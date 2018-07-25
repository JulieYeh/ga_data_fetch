from pathlib import Path


class SqlLoader:
	"""SqlLoader"""

	def __init__(self, sql_path: str):
		"""
		Arguments:
			sql_path {str} -- Directory of sql path
		
		Returns:
			[type] -- [description]
		"""

		sql_path = Path(sql_path)
		sql_files = sql_path.resolve().glob('*.sql')
		self.sql_list = []

		for _, file_path in enumerate(sql_files):
			print(_ + '-' * 32)
		    with open(file_path, 'r', encoding='utf8') as file:
		        try:
		            sql_list.append(file.read())
		        except Exception as e:
		            print(e)

