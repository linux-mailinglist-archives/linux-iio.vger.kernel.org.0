Return-Path: <linux-iio+bounces-26935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD1CAD26E
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525ED3062213
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C5B2F659C;
	Mon,  8 Dec 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="RGpdUdBT"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBA2E5427;
	Mon,  8 Dec 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197078; cv=fail; b=d+bVcLltgO8+JtGNi0VLoT+3V/WTn9JSsIz5J+PqNIYEyCEJW1SGZs+HS/sNg70AcWNKeobVfw4RhK70E02u1owiaUu0kCLbDYbu6WyZaB3m54YWv5jPbTzS40siOnyZm4whsO6gEo/W9165N+USlhKLl7PwZeOWNkJqJl2BXz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197078; c=relaxed/simple;
	bh=jkPs6SqrK8NnhO1muK1xSuEDEJAsN8Ta2d+qlPN0Zeg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jV5Jc0ztwLBUqi2wPAUpZ7dGJ7npK3+1HvYDLKWBVDtBIyCeyswgL/iS0Nk0MkPjuLulUoKab1qoQJv9UsJifYT1HizuFDddX5S5cTwcDV497i0bbjIvcHFW/6EZU+4iNnxP7jK85U0bPK26TK5PjOgaPye08hVvZNNR/cymlyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=RGpdUdBT; arc=fail smtp.client-ip=52.101.72.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7sWhwXsLT+1gLQoNYlWdFY9SMQMYUdveXR3vf5ZwkOk1ZNG5a6ZrvaO+/+O1UdG+QLwh7s/sVTNejMGONTlAecpm2le0AN+oM72emmnncT2ZEGazTntOo1dlF7iqmgIja3ifJgtUnasV0KwLaTYSWqP/YSA+NMFqiE941Khjo0NfPCTfb6FSYXrzjPaQBec55eK4+k5GCK4Yv/R5/PGl2T8jyYE80OTDM4yYxdX8LTOcaQd1no7YoVSRRnvCpr3vIbhedieNaEla9xJ3bmWQdHDDGr1KjNQaWVAqVgaE/AlPxs+esnRBqktvm3GGPri9zTy1V7wF3tp8283lvVznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGByndXr/mPXHXuph9nQ5QHMDEgnJnQMcsA5oel2nXk=;
 b=hw++9oPRHpcKBOX/WEbuSyiqyi6TuCrsNQAVDSl2KR7wRpsgec8gl0qc9cd+uNo8ayWp23JWP8W4j98BhOVQV5c+zDlJfgru1pw5BSHtxq1U2jmH5ONpybLBvUCHuw5Q4H3pOLplwWDc0Q31lc5/PZkHoZWLYJ2tzW1Khb4PnCgt0pKGEE2z0kfAlOn6yibdJJbGQN6FW3wPrfC1OGZdsi5vOg5yw8U+OVW9DRrXLt2oaUp474Hgr5GLn3foEq+3TKEXSVuVq7PTvPanCyYyo/TpfJVWnC/Dkjm7ptT1XZXwGNss63COdWhcxGQKjed5EggMo7tfInkSgL2aPk0fjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGByndXr/mPXHXuph9nQ5QHMDEgnJnQMcsA5oel2nXk=;
 b=RGpdUdBT5lWJC9/qbcBsTSyIJ8Hki8ENnZ0ywIqRyZJMy13BpBsYsewB0EoNI7cbqdj8ddaBmHxfv2ub439rQdS9tu7hmfBQ5hGyqKEP8qxklURgyYoze54/9fnwUYkhmKUUJigZ15tx0YKbA2Rgv7PsoHoQ74ICDWArwRudweE1fRsKXl8KD+YgU/IuBH8muoZ80R9kxsqyVVjJbRnAmCr2Dnkr1gCzZjkH34sugoRA67GSAEqhtMivcVhk4sUlalkwYOUDi0JQDcVOMizITkNdUhgEGuQaqmp6I7iHU7d83YgQzlvPy7HWYOAdkvvj16H9qOBnqTaJpy73lkgcMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV4PR06MB10452.eurprd06.prod.outlook.com (2603:10a6:150:2e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 12:31:09 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 12:31:09 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Mon, 08 Dec 2025 12:30:57 +0000
Subject: [PATCH v3 1/3] dt-bindings: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-add-ad9211-v3-1-c49897fa91c4@vaisala.com>
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
In-Reply-To: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765197067; l=1386;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=jkPs6SqrK8NnhO1muK1xSuEDEJAsN8Ta2d+qlPN0Zeg=;
 b=+5VvAnbxl8bWbOjNec/1KKUO7V24dQYcp+YMjNyZNuhcI1sMzd6DqOOETGQEBev03xWpibrhz
 RM3t6qj+kJfBaHa2YsjCwNBg6kSfXtFcEbhNoAIQqpK2rrpP1MH3RGN
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0004F092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::62d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV4PR06MB10452:EE_
X-MS-Office365-Filtering-Correlation-Id: 27194d9d-ef1a-44ad-1cf1-08de3655aa38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azk2MlZQQnRvZ3lGa0hTNnJpdlE2VXFWS2FBQTEwOTZpMUZzcmtPTGpqQkti?=
 =?utf-8?B?TVdYMUhWTGt0K25zT1Z4SVRUalAwODQ3K3lkOTArTFVNb0o4N2Znd1hzaktD?=
 =?utf-8?B?SUw2R0tQZU8zNC9ZcitnbFJtNFpSa3ZhcVJ5RmtiZWs5U2c4dE9zb3o1Y0Zp?=
 =?utf-8?B?SHRDMXk4Vm1QdE1UNXRLNVdpREJST2QwNUU5N2RlZ0MvMytLMGw1V3FCQ0dk?=
 =?utf-8?B?UU1FcWxFZWhyeGk0NEZCQ3hlRDBEdUN6QTdCR1o1RDZXU1I2MWNkVHZadUxq?=
 =?utf-8?B?OFRXQ1RUUWFaNWdoUi9MS1NjdUFuY2tYQlc5WFdpNE9jdjYwZDNlZmdkRUly?=
 =?utf-8?B?UWlOL05BTlAzN0RESUo5SGozbnNkSlQrZjI4eFJBa1RuYjZlS0hNemZ1bXcz?=
 =?utf-8?B?NVVUbnl2SW9SNVBtUGFoMEVvb0JaSWIzWWlrUmVBNnYzMFRERXgzNkc1bzRJ?=
 =?utf-8?B?a0lmb1pkRnE2YXJ6ZU02WHZxYTRSb0lhNGU2UGhxYlVVcDBra0JGTTF0Rzc0?=
 =?utf-8?B?NXkzWjhoWmozdkRSeHNHM2E1dU5VTDRwdlc3YStqdkVXTEk4SEJtbTd2MENT?=
 =?utf-8?B?RU9GSUczckZlMHliQzh3S1lQUjJpcS8vbnBFKytYR2tJWTA2WDhFTXJ6ZHRi?=
 =?utf-8?B?UVFuM2JZNEhKVW0ySldWYUJFUzdCallnQVptNmovNWRoQ01YUkliWlE1c2pQ?=
 =?utf-8?B?MFRSNy9QTWEvTUlmMFhlYmp6QW1sNkN5UkFWMWxwRmxDUnExMlhhUzhJQmFq?=
 =?utf-8?B?NlNLTUpYbWJ1VG1KUVVlOXByeXY0VTB4TkFRQ1hHaGQyYWo2aFVsQjFZWHJS?=
 =?utf-8?B?V3grd1MvYzE3ZW5scFNJNFBsRFR3ckFCeU9yNjk1dXZsTHZndkFWc2VVNmxK?=
 =?utf-8?B?eXY4U09rOVQ0anNEUlNMdDczajZtRFZQMDRCdnZBOC9yV05jRWk0SG80cXF3?=
 =?utf-8?B?MkYwTWk1S0NKUm1YRndYbWpFQ05NeFUvL01qaGQyR1hnMVVwMmdmeTVqTWlP?=
 =?utf-8?B?alVLMzJVSG5NQ2ZjNkFIU0NTRllJS1RGME92d3dqMkE3QmxlaTAwdXVGa2lj?=
 =?utf-8?B?R3B2NkQvTWU3ZmVXWWgxbGNwajI1eXV5Q28xcGd1dXI0VTFtcllXUTlyV2Y5?=
 =?utf-8?B?UTF4SHh0WG9Dck11TU1vWm42RUxIemtaUmFoYllFRFRZbm9NNGlRWWx3RDZy?=
 =?utf-8?B?eFZrS2N0aUlSVVB5QVMwSHNRTUJrUzdDOHBlWGxmRUt5TzNEeFo5ZkFWV1pQ?=
 =?utf-8?B?TVRkQlAzUDBGdEo4VDhGeUQwWlQyeFVhYTgvbndvQ0VhajVreS9uMWpHNzRK?=
 =?utf-8?B?Q05RV0RpNzNCU1dudlYxZUlxRTZpRXV2dVk2OVFoUVNVR2pqZkNzQWpTMDJB?=
 =?utf-8?B?NW9FL29KY3pnYm5FNnFxdWJxVEVYekRMSWNaWWhKMjNBMTVKays0djFoMHdr?=
 =?utf-8?B?RGV2U2c4dUtwb1VDRXlZNEIwZXBjTmhxTzM5dzRDODRmUnAyR3d3U1R5SmpI?=
 =?utf-8?B?bDVrM3lVQUdBOElLdWpYWW9LWWZNVTJDY0hJd3paN3AvMGRkd05QZTV6c2lS?=
 =?utf-8?B?OSs1TER1RkpIZHovRFNlbS9Zc2tyT3lVSmJiaFJZSFViL0x5UmJieUxYT3VJ?=
 =?utf-8?B?TTdTckxycmNTcWdmelYyVWNqbDJOSkg5cGNsQm5JRmxTWklidWhrN1ZiMHpP?=
 =?utf-8?B?K29DZy8wZ0MrMWlKOVdnZTNOdHZ4SFpWOUJaTnVRbG1mWDdDNU5EODhwQ2JR?=
 =?utf-8?B?YitIb1VSMDR0VmJEeG1NOG1IaVhkS2RxN1d3NWx2SWEySnlGd2hGN3YzYkVT?=
 =?utf-8?B?V1ZQQng0c2Zob0o1bStUaWJmS2FXbzVQYi9NYkRwV3F3cVo5OVBSeUNxeG5u?=
 =?utf-8?B?ejFrQ3pORW8yLzdudGtTMVhwNTNydENobk91WjNHckVlbmRic3lZRUoxV3Bh?=
 =?utf-8?B?RzRXd01VcjJoUzFBY2FmdnFCUStlYkFJM3dHZnlRdHN1NUdabzBYa21vam5o?=
 =?utf-8?B?Zk1XR2Z4WTI5eForazNNZkRTcmYwNUFjcmlFWnVMUDlUMFNuN1QwMkFCdFBs?=
 =?utf-8?Q?gi8mfb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3VnVXBpTlpRKzBPTEpXWmZyYWVRWmRTdlduSFdEUjdYSGpjK3dvRThjQU15?=
 =?utf-8?B?VTBhUi9EaHd3NVNzc3RiUXlNaXZZcWVINHRvWkhUeGcvNmhDQTE5MTFPS2c2?=
 =?utf-8?B?MGtXWGdZR0ZjKzdqb3hROW50ckprVFdZWlJ3WGttTHllTE13S0pVVmhIWTU4?=
 =?utf-8?B?YmZaeC9OMnJUZTBFR0V1WCtxM0tsUVhzOGE5ZzdWamN0bVo0ZEg5bTBsUkJK?=
 =?utf-8?B?SnFPZnR3ZEJ0RTB1VnljL3F4ODcrbHFZMDdWaGRrYkVQbEk1cXc1N1VUSHpC?=
 =?utf-8?B?eERwTlR5eXJxcEh0QTR5QW5nNXpOSy9sblM2QVBva09zRkgxWk82a3JtRmtR?=
 =?utf-8?B?VXU2a1ZzK29iSXp5aGREN21mOVh2cWlTNlYwTFh6TE1xY0RwK3Uzak1iQXhv?=
 =?utf-8?B?SUdsWXBveTNUS1hRY2taa1krYkNZWWdZUjY5ckNJRnZpalVlN21WWUtZWjdP?=
 =?utf-8?B?R2tpY0ZucFluZkwzZmM3VHBNYytNMkZ1NGFPd25ycXRlTTV4RDVjRFVvdHR4?=
 =?utf-8?B?cUVDV202d2pZN2VkbmZHSDYxZStIRlRJSzRTQzlTeTJzS3RZVXpEY2tnKzlE?=
 =?utf-8?B?QWR6Qy9TQktOMGpTc3REbEM0UmZmcm1LeklUYWdQY1YvNEJCVGZHWGN1Q1Rl?=
 =?utf-8?B?NVp4bm1JV0ZFdVlXc0k2Mm55dkRWVFNJOXI5NjhObXpMbS92WDY4dXFFbS9X?=
 =?utf-8?B?YU5wY1I5aWI1K0J5d3BCcUFsWUR2VVJET3JqM1preDQzNW9ERFAwQ2xXSmlx?=
 =?utf-8?B?TkNja3dUMEJ4K1ZOanpVS2hXUHFlWWxQNDNucFpQT0Q0VmdsVzRLWkxwZG91?=
 =?utf-8?B?dEVzWWE3YjFpM3pLdXNkNkI5Sy9mL0dJWDJZZ0ZsRU16dDZBc3kvSlp6OWxp?=
 =?utf-8?B?MXhiNlR3L0hvWGlMdG1pd0ZJUXpjY3NJbnJwRFpQREU5bDZlcHZ6YzZ4OWpY?=
 =?utf-8?B?Y2tPUm1nclV5aFBZRG92VmlsckN1RWx2NGExU3VWSjhXaGh6NC9SS3FnMWw3?=
 =?utf-8?B?SE9xcDFXTzRrZld0c3ROaHFPTGVjWE1vb2hHWTZxZWVldHJ1QU1Fek90dmhS?=
 =?utf-8?B?d0lFdEtlT0NjUHdCd3A1QkJ2bEZTYyt5OFFkenNjVldHOUdHV0NhREtMWWZs?=
 =?utf-8?B?dCtVb3d0S1JBN0FLOFpGdFZuVVlQalFxNzlmaThHNzlQblA2MVFoaHkzZWM2?=
 =?utf-8?B?d0VyUTZRSHdnZzBGRllBbzNkQjF0QTRjV0ZpR0x1NkNONWVUb1NiWkIvMjhL?=
 =?utf-8?B?NHJaNy93NGtDTVo1S2dzUFY5REt2eFB0WXhmZTh4SGswbXovUDFCVXIyVXUz?=
 =?utf-8?B?S3NUZVhFQkNsM09jRUV4ZWFrK2pvQXVibDkyQXQrRnY3ejJycmlnTW9aUUc4?=
 =?utf-8?B?bUwxNE91NGdHbTV5SHgwMlZQbFZoazdCQW1tdTZnNy85SGdmNDc4RFZEQ25M?=
 =?utf-8?B?b2pKREVIb3VzdXBsMlpZRnEzM0VaQmRxeEY3U0pQeGR5bkxqYlVFaC9KME43?=
 =?utf-8?B?TDJKcXR1UldZR0g4TE16RDc3K1Y0U0tCa1RCeUFaMUJ6RkNjYUFyRUQ1S21D?=
 =?utf-8?B?Nk92akFjQ0FTaWJKVWk0ODg2N0NhMXJqV0p1WmRYbGliWHpOdm9GTG9KMkZi?=
 =?utf-8?B?MDlyR2JhdlNjQ2JYd0ZsbDhMQUNBVHVvcjdsdjZUR3k0dlRNTGtEWW4zL3RI?=
 =?utf-8?B?ekhXN3RuTU1NTTYraWVVTExwSEFqekNOZm9rZTlkWkVXOGJIdmZmcWNiRzJn?=
 =?utf-8?B?REVBWE5nM0t6eXVzWWc1UllOeFZ6TlJPZkFWZXBFSFdBZ0ZWQ0JWU3Nia280?=
 =?utf-8?B?LzZJZkFuUmhVOHZPU2NhL2ZsQUlBZGZHTjlOeEp5aUozS1ZZeGRseGNKSE9I?=
 =?utf-8?B?R0dnOFNLWm9ualBXdWR6UTNFb1lJSzlOSjZDeG40NUtuZVB4TEVhbDNocFhE?=
 =?utf-8?B?dzdVZ2FBRHZwbUNGM21GcTk0cHkzNXJNQVFSTXd1UjhYOUYwL21vUDF1YkZU?=
 =?utf-8?B?OGExWDV6eHRKU2ZMVVFIQldhYUtEQ2JMNzVjNFpQOG5VUU1HZTdqWlcydVZP?=
 =?utf-8?B?UmJGOXpNRzlHZlhMNERBRFdWaFE5YjNXVnVqcXBhRlBxdlNpNzR4Wm1LRHdw?=
 =?utf-8?B?cGowRVNRaWYzN0lVbExJbGxab1dybmc5UFRMOFozQm8yZVZHTlNvZWNIUWZq?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27194d9d-ef1a-44ad-1cf1-08de3655aa38
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 12:31:08.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxgDsMBZ13Ivg2DntEQtbqAkSDRcpS1dAclqsoDHTCf1j4vDwgz8DiAESZ+zeW+ljex4Wl8vcT1eoZGcYd9HxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10452

This device has e.g. different scaling values than currently
listed devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 2606c0c5dfc61fd65cd0fb2015b3f659c2fc9e07..5acfb0eef4d5cf487adaa93ce5bda759bb4853c9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -18,6 +18,7 @@ description: |
   All the parts support the register map described by Application Note AN-877
    https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
 
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9265.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
@@ -25,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad9211
       - adi,ad9265
       - adi,ad9434
       - adi,ad9467

-- 
2.47.3


