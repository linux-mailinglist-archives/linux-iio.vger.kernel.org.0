Return-Path: <linux-iio+bounces-22611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA8B22046
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 10:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5310C1AA1812
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56F2E1C53;
	Tue, 12 Aug 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dPdpRl1o"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39092E11AE;
	Tue, 12 Aug 2025 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985944; cv=fail; b=Ayx6UjWch9mDLlaE7mHRXhTFhzC/lJtrkFMe8IGXdC9oqppKX6f8qHbVf7EXvyDziSk8YxOwt5oGSrM/YqiEZ8hJo67khal317d5HTkuWMvLNbWZSPgx8e//j8hl/oa2KCoIdarGKi7L8pYvvoz3+UioQOh7T/cBhaWcq7k22YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985944; c=relaxed/simple;
	bh=nxOSN/SqI8BXyovSeK9P5DKLQALQKNp8gNPh3EMIPAI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=daoqYnnxkqpu4pXLYiEQwnyXjyKipKPPpGib/R7xGUSmdiSYjYt7q2ks9LyLIA6fFaWSdJalxpjs3W7zRoK5HWsaoN2/ZNZMxr1ZwLl0hUS3Iiku6tnD+XFCBosCq5e9ypriGdk81d/ft0gtjq3jJKMJNS0sl6IZxE71TtUW+OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dPdpRl1o; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxX77LSfNmd2AxinQE7eqRvnwt1mpSNpUT10lUAz4zKHjhHNPGWeoiW1U7XBk5OhBWm4g4DoQSyN3kF0aglE/c6hdiuGg7XWg00LaClKZbxvh3WLj8IIedJvKWCjFG9taaFoQymBwlY29uyUnypPOcequUKIOjfmDhd70UzUyLJ5FJj3YFrS/t3QAe+2L1hXzCODluDxSE+JL1zCuApyZQClxy12bHFLb8rDSzrNWdvGRgZ7pjY3TNOJZ5kXDl9O8XbPI2uFunSTUPuE9UUk/LYNh5KJZPhYx8IbD4yNRJnLAn9/PZ18zr8y+n+GyKgATocQ98Si9JeCeNWmBPZr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfrfo0SsmFI/Fz/5f61hWhQNhSqC9QKJ/Asj7/br028=;
 b=anRKL3kmWT5sesNS8O79XEXfLQXoZx6S7JkJ56k8P1g7ZfFXXEVq2Fca+9M0PIG2AGh3bswhVreX8MkckW0i1T4+WFYdsqQRA2c3SQcsuTO8WPm2EfhhC31F5NBYZNHzKP4/xBvUgLWnOdSGzWbkzr98lidG8FQgxn0cttbg9+8ZkB93q/trCdgqfVScJX0QX0wQnHgCMMAXRmOwo17NrH59RJuQdlQ3X/95k0Y8+i+WIIvJET5nhbtQxajTG5A0QZapyOboee39cHBDMByCrq7Z1Jgw19l6sBqupeMBAnt51efEWytazcSz7C9+lEOkURP08oFrBtzlp4IEX1bFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfrfo0SsmFI/Fz/5f61hWhQNhSqC9QKJ/Asj7/br028=;
 b=dPdpRl1oJRAxF1Sb8ySSC1QvGA/Gqz/2V2rg5ISqSKsndrVRkDGrSDXta9ShX4myyYjLTzjzYigVrz0GUkEgy2wvjphJYJgEIK5cZ79DYGiiCoU++u/fW6MLPpr9uPbTFM2rt9e1f+V3H1TGBKdVt4g4paayr3J+xGLj1IvMeijq5ZUYjSl9EBzn2QBsujpZ1o5Zj8ywTPCW1OpuZ/Zb7OvXfhBn4AaZH07zVVGcUPJPlDb5wCZn3qh4/M7GzuxInJRE1fo/SDECxhqlUU4jY7dIK+Th2S1zItBlBri3iT0iJdwOKfA3VNhvgkemK9wAM0ufafn9GYmiL3isfNG56w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7984.eurprd04.prod.outlook.com (2603:10a6:102:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 08:05:39 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 08:05:39 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 12 Aug 2025 16:04:22 +0800
Subject: [PATCH v2 1/2] iio: adc: imx93_adc: keep one style of the hex
 values
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-adc-v2-1-0260833f13b8@nxp.com>
References: <20250812-adc-v2-0-0260833f13b8@nxp.com>
In-Reply-To: <20250812-adc-v2-0-0260833f13b8@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, primoz.fiser@norik.com
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754985925; l=860;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=nxOSN/SqI8BXyovSeK9P5DKLQALQKNp8gNPh3EMIPAI=;
 b=rsSfPuH5MHcawa+hzsgPAVDt2xaplGUYgxS4uJZBZbBOzKKq/GQbOxloedVDxg7qAUTp9mPO7
 Lk5MVIOYZiiArt8g/XwgEaptMHT6kphpk5ncxGOoKW37x/ty20lp8K0
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4310ff-497e-439a-6638-08ddd97706d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhLaDRpdWJBMC9rMktyMHZwWWpQQ0VJRjlTVlZXZm5aR0pmc1U0cnl5RThQ?=
 =?utf-8?B?aXZjbXFCTHc5Z3JGQnNyNzFxcWFvNC9RaFhkUnlESVViVTQzWU8vYmQ5R3FX?=
 =?utf-8?B?aWNvblphL0gwYXpqVGNMNUl4d0Z5YUxyZWp1R01nc0RGVG93UTh2N0kvU3M0?=
 =?utf-8?B?Z0t5c1AwUkVCUnBJbUFqYVYrR0ZYT0hUZEU3Y283d3JBaktaT3FvZnhNKzJw?=
 =?utf-8?B?MGxpNm0xV3ZDUVZjSUQ3T1BaMUV6MkRaNFdZOGtUY3N3bzltMktxWUdQK1F6?=
 =?utf-8?B?ZERtNkhpZWFrcW1XZlRQUUZQQUxkb0ZFQ1c3VHNtODJ3TW4zM3M3SnlrMDZi?=
 =?utf-8?B?bFVFcE9KVnJ6d29uYnk0a2VybGRyN0k3RlM4U2gyd2dJdlQ2SzlkRm1kckh0?=
 =?utf-8?B?cTU4Q3hmSVZlMHAxdDhzVEZqK29NNmxwR3R0eWluQ2prSTB3UlU0aTZTZzln?=
 =?utf-8?B?SkMrakp2andiOWQ5VUxZWFlDcENVUFZRL2VkV3BGVlpybUFSNm5RZllGVFRr?=
 =?utf-8?B?RmNITjNkT0xXNUtDYkNIV3RRYUh1L3BHbmpoa3lIZXlDb254dmRoWFo4OHBk?=
 =?utf-8?B?TE01L2ZmZkFuRHFLRFJiRlN4YTV0MWozTXVmL1AxTmV4bXQrZHhZK21mdnFh?=
 =?utf-8?B?ZVB6T1RyeHZLYU1ZZUdCWURYeU5pWXRFZk93QTA0ZWw5dlQzTGJnZlRzV1lq?=
 =?utf-8?B?QVhWMXNYUDVOWm5ES3FSelRYbFpSTkIyeHJoRUsvUGpMRVZXMGFQay9vKzBa?=
 =?utf-8?B?VnI2dXY5QkJDR01iYnladzB2WTdnaDIzNUZSQXhTYkhPbkJ2Qnpzc0pNUU1m?=
 =?utf-8?B?bEsvV3h1T0tQQkJxZ2VHMi9Hd3NqUVExMmhCeURraGVRSUJjSFZkY2luYkFh?=
 =?utf-8?B?MG9YWEV4QVc3SmNScHFjYVM5aFdNcmRMOHkrNUU3SmFSV2hBU1kwQmwrK0FZ?=
 =?utf-8?B?YXVjNzNWM0FRbWgreWxLaFBDMmxSOW9uNzBSUzNVdFBjVFVoTHhSN1NTN0FY?=
 =?utf-8?B?ODc5b2tGM3dwWTRjRCtIYkIxNXFFNjU5bmNRYjNOdDB2TmJxUk45aVhhWHND?=
 =?utf-8?B?TnY3NWdKeUljWlk0MGozUWovUDY5c2tUWWF2S2tVaVZFNXhabHVidGxqS3N3?=
 =?utf-8?B?MjhTaDFRMC9CcW5PK1g0cnhFUFRib2RsZWpoRW91aWlrMm92WEFYV0hZVzVh?=
 =?utf-8?B?TUdEd1laSlB5SEhFTGFnd0NEQnAxSW4yRC9QUk5OdUZvQTA5UlVrL0w2eVl5?=
 =?utf-8?B?dnRxV3NQenZrbWQ3TnBZSjhqSkpFQjNTK2toOFJLVy9hRjNraFJXV1ZRYnpo?=
 =?utf-8?B?b04xWkJpYWZBTmxmVE1pN1htUTBCZEQ4cFF2alk3akZibGhaejE5YmlObFdl?=
 =?utf-8?B?eDJmMHJYckFuaWg5RE5FRnZIQVg0aUtSSzNnTkM5N1BqSGRLMzlWeFRTOUZ1?=
 =?utf-8?B?UTFCUi95TWpRcUNldWU2RENHcGhYaVNiRjRZc1JVZlNsVHpQVVRtRTZsdHdn?=
 =?utf-8?B?YXBIUjJTSzZiMkJjMFRheFgrZVp2NFBFaUVSeUZEN3dGR1BMeWJuZzhQWnBF?=
 =?utf-8?B?dlN3a0p1anpGNTFFL01pZXFSTjdIN1pMNlFFQVh0UHM2V2hmNlZYd0pUN0hE?=
 =?utf-8?B?L2hIRTVRL3phVEVHTGthTlRsNW16VEFTMVpSSHVJaWpaU000MWgxYks1UDBE?=
 =?utf-8?B?SUtxeGVMU3dWYmUwbEorMVZyU3BqL3N2RHBZNkdUTG5kcUFYWjQrbVpIdE92?=
 =?utf-8?B?dTRjYkRiWUhLeWFFS29JbkRtYlNQUzR3SmVaeWNrY3dlUEJjYkxJVEo4Ni9n?=
 =?utf-8?B?UkgyR1JQemt2UlJBNnRiY3lmSEZWNlZqSVVNWC9lenpJUlZyVWMwL2hGbytt?=
 =?utf-8?B?UXg1enhyNnVXZStBdEgwbG9BWGJ0K1hLWkJURHRySHJTa2EwWDZOWlN6cVdw?=
 =?utf-8?B?aS9wMnBwdnRCTENnbk1zYmdlZ2lUUjFoRGlTM1M0ejhCM0lwZ0hJbStCc3Ux?=
 =?utf-8?B?cjJyb3pUMFNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm40MlpuT2NaVUtCajJoUFA1VzJyeEZocXRSM01McndlZ0Q3bG0rSktXT1A3?=
 =?utf-8?B?VFhxck1HejE3OTBGTXBXS2pLKytqU29rZVVLYkVwRzdhR1IwWTJYYXpzTTVh?=
 =?utf-8?B?NVNnUW9RWTdrbzVtSk9CNVZqVUNua3Yza051TGllazlNdDJsMEJSYTJ4UDFR?=
 =?utf-8?B?MUVtRVkwNmN6WnRwMnV1RTNFVzhqSVVsRWRnRnN1bWdzVDhQbWE1Ykt3VXJL?=
 =?utf-8?B?R3VJaGJxamxlTHNGUzJaUUppbEIzZmp4OFk1ODRQN01hajJzNGt4OFJ1TFBZ?=
 =?utf-8?B?bEJNc1NrR244bkJ4UU8waERVZm5JcXIzTWVFTEZsQzh2NWlJR2FvNEpCZG5o?=
 =?utf-8?B?aTBaMm1KK2JPaXNqNlpEN21iUzdybzJIbk9yQ2ZkbTNvMVp4YkgxOXg3TUNH?=
 =?utf-8?B?UTV0WStGekErVkVYZlVxbDZ1RUE3UG1DY1RFNTVMN0dGR2kyTG1zVEtKNWlI?=
 =?utf-8?B?MHVncmM0Sk83NEVpbEM2K2lyRE5SMFhQNVhPN1NCYi80RG9CS0JUbDBkYnJN?=
 =?utf-8?B?TlFpM05tUi8yYVJ2aExPd2VuQlVtRWpnUEp1RDQyWUd4Nkhkd2JtQ2JaYTZF?=
 =?utf-8?B?dkw3bzFOUHRKaUw0Z045eldJbS9mMGdLVmZhTEk4dlpVOHd6Tm5DWm5ROUND?=
 =?utf-8?B?bVVBT3VPRDVUQTdNWWRHMGFyNVBreFVwSkU1UGVYWDgzUnhQQW5tYXliM2ha?=
 =?utf-8?B?aENDeUszcWJxTS9nS3V6SUdFV2VjcmRJY3dRVGlQUDJLVXVCOUN2V29JK21p?=
 =?utf-8?B?RytsZXQ5ejNiSkVNZUpZS2Q2NHFzSTFTUTI3V2EvdUk4WFF0bnc2a3hMV2Ry?=
 =?utf-8?B?QUlDWGpMeS9FeklPTTNLOHBqT0pWTFFoUXd5ZXBucWpITUt6eW82ZkxDc21i?=
 =?utf-8?B?bEltMTdsV2hoUXA5NkRxMnBzQjJzdko1c2xCZ2dZQ01ZTEhwb3JyakhQWng3?=
 =?utf-8?B?ZDFZYmU0TUowcGFVUUhBN09zSzlraG1yRXBUeUR6akRFUHhIQWVtcWV1Vms2?=
 =?utf-8?B?MEY0WGNsTkR3NndidDc3OUF2aldpQzUxOTFkVHJrQndrOWFINDN5YW4zY2Rr?=
 =?utf-8?B?ajJFMVV5MGNIa0ZZZVBwSW1CQVBZWkpSWXhHNzVsSUx0N3ZmcWV6TEhJZXA4?=
 =?utf-8?B?RlNGVW5HSDRuRGx0aXNWZEZhdnFQbHl2ZlJLVXlidkJvNEpMT1YzZTFZd0xi?=
 =?utf-8?B?YjNjUDk5clZWZERHLzM0S3pnUWlUNXR2UytwZEx3REM1RUdLOTdZNzF4ZUZL?=
 =?utf-8?B?eS8xaG1hcDlSN2lSM2ZQbmM2OW1WeWI1U0t0QnB2aEpVSC9WeDRjbm9pa285?=
 =?utf-8?B?YzdneFRheHVNN3dHUk81RmNmSC9SZVZVMVJCcjloK1NBcVdmREw3TkZwYUNN?=
 =?utf-8?B?Uk9DM1JHYzhBS3JSM2ppMU9IZ0tZRXJjanJFdG5vb0VDeSs4UGJMNFFmMlYz?=
 =?utf-8?B?RVExN3V0OENoc0o3Y240ODZiZ2ViL0pNeDFaMEtZOWZUdW1iSHJRWFdlS2lB?=
 =?utf-8?B?aTJqbWk5ejBOT3h1WnV4OTJOL29EOVNaTjZsQThBRFRhd3BzK2tjVXZUNldl?=
 =?utf-8?B?M2oxdFU1V3FKN0s5OFZLOE5LTWlaWWs5RjB3QUgxUnZGbHgxbFhaMkRWa1Zw?=
 =?utf-8?B?Y2szSktYU0VKMy9rWUkvbWk4SFp3TXVndUV4d3FwZitUMm5xUGIxSUlMYUkr?=
 =?utf-8?B?NmFOOXBubWQ4RzJJVE1lTE5HdzNOeEE2NUt4bjNoSnVYcEFVbnpRTkpZRUY2?=
 =?utf-8?B?b1dzOW1DN1pFRm11MG1BNEpwbzRaSUJqUmpTQzJVa2RQZmtqSWR3RWhDVU0z?=
 =?utf-8?B?NE9XSHlIT1U4LzhqcmRBb2VXb2Fzc0Mxb3czSFBMaWhEdUNSVGQzakVmQVNh?=
 =?utf-8?B?Y2RzRWRhSU5Lc2tjL1c2M21aRGdmUkFGdHZWeVJJVDhyN0E2WW42VEJsaXJT?=
 =?utf-8?B?amV6TGVuekFuUzh5eXY3cjg3bFNqNzNPWEVKQjJ5SzU4UkRLbVR3WXd5QXA5?=
 =?utf-8?B?bjNHVFExajNKTjNIRDVCZDNHeGpCSlByMzJaa0VpTE0wVUE3eDBESHlqSWho?=
 =?utf-8?B?MzliQWVIZVpqYUhGbEMyQzYrN2prZU83OXF0bkNJN2t0a0dvUktjNnRsdEV5?=
 =?utf-8?Q?ANbVyhQ9Oe+sYL7NMCySugw+0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4310ff-497e-439a-6638-08ddd97706d5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:05:39.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0V6FQxayIZtyL7F/Yl/FznNkLuKQP20AJt1xq6NiO2vNAROSzQ1ZAZFpJuQXaoViy/o+j9Wd4Y+aK750iTFpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7984

Use capital letters consistently for hex values.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/adc/imx93_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 7feaafd2316f246bd0c32fea99309900b5c65099..8471737ac04a2bac0417a6397f20865f6a2c01ca 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -32,11 +32,11 @@
 #define IMX93_ADC_PCDR0		0x100
 #define IMX93_ADC_PCDR1		0x104
 #define IMX93_ADC_PCDR2		0x108
-#define IMX93_ADC_PCDR3		0x10c
+#define IMX93_ADC_PCDR3		0x10C
 #define IMX93_ADC_PCDR4		0x110
 #define IMX93_ADC_PCDR5		0x114
 #define IMX93_ADC_PCDR6		0x118
-#define IMX93_ADC_PCDR7		0x11c
+#define IMX93_ADC_PCDR7		0x11C
 #define IMX93_ADC_CALSTAT	0x39C
 
 /* ADC bit shift */

-- 
2.34.1


