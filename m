Return-Path: <linux-iio+bounces-12054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78CC9C2789
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 23:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD6EB225D0
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917920B806;
	Fri,  8 Nov 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GelNZdWO"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689520B7F8;
	Fri,  8 Nov 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104847; cv=fail; b=CteUMQCO9rIKL+nq/czQaKfG40j5g4OreK5JsyORaPbtgc7hvjqGwjly9N+2QbezX6qCI13XCyz95ivdYinGHDV4LDlTrusLVUE86Ea3a9iQEwVc+AbQaDHAd7fzm2xnxRTFHNHHN+ff/NimTFWhYrbLndznL/VcpTezrU2KU8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104847; c=relaxed/simple;
	bh=dNC+ZQ30MlH5Eg8phImGTLf2Ic51qNcIJJM20651DNs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kLAu1EXEkMm/S8btq3ihXJ7O0UvjRZxuaN0skPssyhJfnuPfDPVa4O56Qgj4mTL/J+bz/LOiMeP2LI9AtPurIrlhuCYOaM70chne0UCa9e/I5MtVoxE1zlRhuhwIvc28AK3AK1HXGkPfdst+Jcv52U9aGvvEMbuUrS8So6y3IMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GelNZdWO; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPyEYd3wJ2q6rsz97k+O+OIYfAsmJ2PwFTs3+XWP+vPpmUvzZxmwA/G5jRF5VWlC8/CoNRrZAyhY88HjUyIqOajfeo4aicBXr1EDVgtG12b06gPOl5RENUBn/seohagknDD+aFZpJkg0Q1CjX6vPtC0R2t5hHpHLgFvTCOB9bOQgdXrrpUIy3iJt+oN3Mmf7UWyLzMoN1r4c+sulxp7ACzpEZARDobdSJNW2HJ6JOIi6/GXPvgG9dIiQZL23huvQrQ58hP0cbyEoIa6vGrs4o6xM9NS+onZnmj7ekClBw3k08yI/QW+VScVpk0+Fq0EOKNDGZBKaQY9paE9Vk3X9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFmlONCWGpLj73XDAx4W3D0f9kD7Obz3kl1YoM4qpaY=;
 b=Tv08ebieWAo6iAL5dB3FLFCnPT4bA89erypGNIpwJiHzDIAsPWZ7YzVuwSmvTc090ve5qH0j8GkBKz6G8GpxiKeILUQKiwF4I+xBRqarobTygiDCaUtbR8vAMKfeyFsLjjE5hYUs83bfoK94esz3K9jankIs5yQpDBveeVsljG29XrFznGsIxupEaimZurRk3aumuwSFFRoyRUWNgItHxi/n/HSZDqmfFR6teErJqOZ4Ri7IKz8fVMoR6//10kCI6H21BivoDIf+cqWqjDE5a0zybMezFK61WTDJsoMeijnaAPIiNMZ0/dEmTvsYi7qOGm5XL4bQmoybm+K/aGmQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFmlONCWGpLj73XDAx4W3D0f9kD7Obz3kl1YoM4qpaY=;
 b=GelNZdWObwm/Cu+fwAfpcWoND6L6rczgN2t4ExMgT9vAhqlOD7dhLcdKKPhJR6dCT/6DTEf8YpGUe3wK00QVrkdav1BmcDBDNJXqZXPlVETBMZPWvLBSX6RIiFsKEbrn/F+FqEoqfvGk6sQ+as22d0S2StxqgkVfTiOdr1OzsS1lpu5hqvrBYp0Gu5WU3EHqYVzFXmOPKbRwbkbmsurNZTBOadenpzflBgBbWL1QaqbNDvgGPXvqF+ZyxaTcx46NMJhvyfxWHhrYJEUQEBfB6Y7uKz5+N/Sm//fxRyk4WMf1ugWoOTB8px+/jOWKW/sanhj3Sl6+Id5MeySLlT+G7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 22:27:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 22:27:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 17:26:57 -0500
Subject: [PATCH v2 3/4] hwmon: tmp108: Add support for I3C device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
In-Reply-To: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731104824; l=1736;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dNC+ZQ30MlH5Eg8phImGTLf2Ic51qNcIJJM20651DNs=;
 b=1QVgOqrY5wGn2COQ5CWxshxQj0TE+iEGMOb0SjFc8GyeMJ/+XyHoThOXeVHT5y+qgvcMOOQR9
 0tQ14ldloaCDEzwbhcVpJjfXQk9MZQNYH53EOdFlclP120vZvUDfBjm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afabcf6-2289-46b8-e0b5-08dd004483d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVZjTlI2UlRuVTNPQlhvZ1dGSjdjalY1WndnODBLSEl1bGpUd1pzVkxtS3Y0?=
 =?utf-8?B?SXhEcHIzUGZBamltYXVkT1EwTlFEazc2OTVhcWRZeW9BMlRJME9PYmtQeUFL?=
 =?utf-8?B?UFVISnpCc2hVdDBTZ21OSGZ0M29Ba3dVRDNyaDlaUWVHS2wvaldKaVFQeW9R?=
 =?utf-8?B?NHRtekx3QXQzOGR1RjU1dFpoS203NE4rNDB2Tk1uZmI1VmJEc2g2ckV4RDRw?=
 =?utf-8?B?ZnhMNmoxYXNGOXJNN1ZQTm16bXFwQytuOTN4TnNSdVBYQ3lydjFWN1JqN1ZF?=
 =?utf-8?B?OG5SNGE2MmRVNnQrSnp1RnNva0JaTHhyTVZiUHNCczJIQVJOS0creHQ4WTAz?=
 =?utf-8?B?M1dKak5rQzBMdEd6emg5U0xkSjh6b2ZVOUVQak5wQTRYUXVhcGNKZUlCUG9n?=
 =?utf-8?B?SzlZSENvK0pMbXVoQ00rdDFZajBKQysrYjlQM0NkRVlPVVd5TnZQR1pLVHVT?=
 =?utf-8?B?djhvOHorNE9nV0F6VStsNlVsYmxYV05yWnJMNE5BOTFsLzVUZGQ1ZjNQRjYy?=
 =?utf-8?B?Tlg2OVpQUTVDRkxVeDliSlFrV2gybmdGR05pUGFsTHl6T3I4c1R3cUtzOUt4?=
 =?utf-8?B?YWc5SG9VQzRvRU9RUldLUGRNTzlRN0E1WWJRLytqTVpENGNjMTVHcE9PSXZT?=
 =?utf-8?B?YmNERXVyUWI0NFJpTjE2Vlpua2NnVThvU3pqcmIrRUp1NkJMMnNGNm1QK1Bi?=
 =?utf-8?B?bDh3NmJzZ3g4aE5FRW9sRXR6MFpSaVVOeTEzbG43OHZUVUtLcWFHY2hHN0dU?=
 =?utf-8?B?eDJvRldlMXFaRnhnV2ZIODBQckhNRFRIYmFVekg3Y2lmLzZZUE43NHV4c0J6?=
 =?utf-8?B?OURMMUx0RnhtREN1NUg5VFJ5TXBhdVc3SjM5S3hiZlZVNVRhUm15ZHArRFFq?=
 =?utf-8?B?dU5IVWVEd29KZGRidC95Z2NQbGFkaUl2Mm5pMEJDaVo1RzI1Y2Q5WWhRTmxv?=
 =?utf-8?B?QWlaY3o4STFReXo5UWhKUXh6bjk3SGd0elJhc2c0SnFiYy94SFBMRzBsWkhr?=
 =?utf-8?B?RzE3dnhTVW1uZ2RFUGsxRlpzY1JYb2VtbUVUckxOWW1CMjFCSHE4V2dwVWhu?=
 =?utf-8?B?MVJvb3dUVEpLbjBZVlU1K2lPaXA0UlFWRHQ1RWxubVk3WlFROFVEOURHTWVF?=
 =?utf-8?B?YVplRWpISkJraERHMXhrSWtCTjdsWXpYVmczZmREc2ViV1NnMytBeDJwUFNy?=
 =?utf-8?B?MHY4SXgwMVpsdm5yZXRkM2dHRkRXUGxVS3FheE1KRytzRENqd2hMcWhZZHpq?=
 =?utf-8?B?aGoxNHdRcVF5VWowQ0tPWXpiK2VqY3dIZDdTdy9oTFFCcENoSUh2QUxtcHN6?=
 =?utf-8?B?V0hraVpZRFJHbkF2ell2UEZQSFlhcWo4dVZXSGE1UTFUZ1ZZRnAzdmRSNWw0?=
 =?utf-8?B?T0ZqblhrbjFOUVZQQ2FKMzBFSS9kdVpUZWxqN2F0Nm1PWTduMDlWNjU5RzIy?=
 =?utf-8?B?VS90ZlEzNDQ3SXR3cjdzZlpBcW91NWJNV1FyNmVDS21TNmFsQVIrZnJzNU9X?=
 =?utf-8?B?RUJYd0NCd3VBMFJ6R2tsRkhQNG5lWWVVTzVvN29vTkFBV2xxZFU5Qk0yTkFE?=
 =?utf-8?B?dFQyeVFPeThrRzVXSFgyb2dQYWJZdmpFQkk1Uk9hdmp4L0NLRUpJbDZobFlL?=
 =?utf-8?B?Si9BK1pFMVdmbitRSVNwRXd6Y1NnZnJzbGlzSVJmS2swQTU4WGRpWm1LVE9j?=
 =?utf-8?B?S1VLalUxK0o1SnlvcGxRRFVKUTRDZHhiZnRwL0t5WkF1RWkvdDRVRTFIYS9Z?=
 =?utf-8?B?bU1FU2dkblJvRGpackxkVzRBVGRYL0U3MWhzV21kaExhMW5WTllpeDNLOGcw?=
 =?utf-8?B?dzhUTFQzcmhIN0VJRklUWW41MEVoMVFxWHdrWG9uMG5vdGJSR2FrZ3ZpZVhP?=
 =?utf-8?Q?O0NrT2Shdr1Dv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEhRUmtVdmd6K1lHdGZvV1l0YmxLT0ZsNmIyL0h6MzdINFJKTmk4dHgzQ2l5?=
 =?utf-8?B?TWRueTRYZGR2b24yeGZHTzMxaGM4Wkt3STNzZTJMZFBsZ2JWM2t1ZjByMHJ5?=
 =?utf-8?B?Z2JCMGlwaTErMjJxZnJpOE1HZE9qY050SlpVYTFab3ZLTG9HSVhlOGJpNkJV?=
 =?utf-8?B?dGU4M2x6OU1WbURPR2JIMWUzV1k2TkprdmpwQ2FFc0E1UDlDcUs1TDZ4cVFB?=
 =?utf-8?B?UEc0OUhqY3JwUFF2WjczQzdwTnVQcFNJRnROUzVoNmZyYTIwSG9pOTJxS0Jt?=
 =?utf-8?B?cEZMZWRIU2Fab0pXQkt2bytETzRoSmd0Q3Z5UExnakZkMytHRnVCVDRSMyt0?=
 =?utf-8?B?R2ZYYUN5bXErMlZiSEtNa3dCK3ZaaFk2ay9jVWpHMWRITDhSVEtQN0NpQ0g2?=
 =?utf-8?B?RU93SWZMdE9ZM09yZjJlZHgzMEdCUkcvY1ZoeTZkakpNY2Q1RnJ2Yk1PeVMy?=
 =?utf-8?B?c1BkQ2FWeG81eDdwYkh6NnR4cG1UYjBtM0p0TWtIelZyYitBQ2trbUhKL09t?=
 =?utf-8?B?ZGRKODIvdnQ5WHpWaUY3aGVoVk5yRHh6N1o5Ynd5aHFTeHRCZVpFTXhTTEty?=
 =?utf-8?B?UEFzbW5hU1ZlaS9WK0hMemt4YnZGTjZVbkt1UDJxNVo4U1Yya09LOU81cG4y?=
 =?utf-8?B?UjdiTXRqS3NRS0pPeUNGWG1BZkxMcjYzKzBkaXdXb2RYZkVMU2JWbHFBTWJW?=
 =?utf-8?B?V0xyOHpBRW1WQUZUV1RzRjRjKzMzalBHT0I2MmNYdkVybHpJVlNIRFFGZ1J0?=
 =?utf-8?B?enFUNFptZEJIUzN2Nm0ycTJXTDAwaUxPWlRheUdOMzgwYXlkWmNyTndna3F6?=
 =?utf-8?B?cTY0eHRVRFUrbGZQYXZ3amhicEhFZERMcTJFVUV6bDQyeTdrMzB4OGRsME9N?=
 =?utf-8?B?R1JRWkJjaE1mL1ErN3krOEx3bC9pODltWWZIREdpSDNqeFRBTm45RHNENVFB?=
 =?utf-8?B?eis4TGZIQWloVENibGs1cnhJTXBiTjk5UERneWp1Nmo5cG1yTVNNNWJWMHYw?=
 =?utf-8?B?bGhoWWZaM3lROHNuM1I1dmhYa0ZyZTg0aUVBK2I1QnVQYnk2dGpoaGVLSE5O?=
 =?utf-8?B?bDByWG9qazNEbzlQNUd1NWVzeW9RZzVVUE5XRDB3ZkhGVVIyZVNwZ1F0M1Ir?=
 =?utf-8?B?akhVUDB2SnlBaVBkUis1bldtRkEwcXNwT2VzZnFVbVFoV1ZvMTdzL2ZyZ2ht?=
 =?utf-8?B?Zmp2ZG5SQlZHNFR3MCsxQm5ncmRPM2VTbGUxdHAvd0dMeGl2RnlqanBOa2xm?=
 =?utf-8?B?dGx2SlVldW5Hd3lYaitiYUQrYXBGOHVpbmYwK05vSDJxNzhDQnJoeVVlbEE3?=
 =?utf-8?B?Tks3OGdvQ0twUGxpbG5hN2ZCbEJVdzRpTWN4MDMxZnBpaStINXdaY0hYT0RG?=
 =?utf-8?B?WU9nNU05Tk5UMkFtN0V1WDBObWkweXA0NnUxTTg0OWtqd29sdXNyMGNTbG1w?=
 =?utf-8?B?LzYvclJuczRLN0ZWOERhUVl1ZzZLZHZYZHNFaVIreXBJd1Z3RnNscGFYOElm?=
 =?utf-8?B?NzUvUU9adTVRUHRSeTBhYXdoUUg1QU56Q3Q2Mi9DekZ4YVVGMy9mT1YxWFpJ?=
 =?utf-8?B?NEg3UUVaRXRhTWNuWnViaGxrdVNmQmxQekNtb0RkVlZ2dEF5VHc5UXduV3NM?=
 =?utf-8?B?MzlwTnpYazBTQUNmbytNMGZ6TE1pc1Jub2YvcklOUmJxQlR5TWRCdThKeGVX?=
 =?utf-8?B?SVhNVGt1a0p1U1E5ZlY4akVvNVJLSHlEOTMzVEFGaVZQSHZHYTA1MDFjbGNT?=
 =?utf-8?B?Rlc2K2lTL1M4Rmkrd2JPV2V5TjNxaEJ1eHBvRTZRZGh4aW9TbG9xTUt6VU5R?=
 =?utf-8?B?RjducFZ6RXNlanFLb0c5dDd5YVBXMVh3TkEzYmNjUlY0WlB3K1BvS3Q4Wk9h?=
 =?utf-8?B?bVVJQ3UycGl1a0E2eldhMDM5VWs0N29OakdDbWRycWo3ZS85NVR6aEMrVmtD?=
 =?utf-8?B?ZFo3Q2lWbWxWeFYzZHBLUnMrYnJQOXp5UU5jeVNOSG1TUmpuSEg0RDVmamxD?=
 =?utf-8?B?d3BlQUVKT1YyRXpPa0NIYUxqNnpWc0RHTnE3ck1MTWV5WVFTcVhNRDhxTFkx?=
 =?utf-8?B?NnpYb29WU1Q4OFdFODc3eW5PeEIwNWpnUnlRYW01ejhQOWtmejd0elJodEh1?=
 =?utf-8?Q?rExTh6SCyuf/azDaaKQhsoyCS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afabcf6-2289-46b8-e0b5-08dd004483d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 22:27:22.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTtTVPUow5RusrHfJqFssMdUAubBs1tvaM4v4b/4BsTaanme0xC4xJ7Z/U4OoBs453artmi5uPjOY1uQkaDrcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318

Add support for I3C device in the tmp108 driver to handle the P3T1085
sensor. Register the I3C device driver to enable I3C functionality for the
sensor.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index bfbea6349a95f..83d6847cb542c 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -13,6 +13,8 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
@@ -442,6 +444,35 @@ static struct i2c_driver tmp108_driver = {
 
 module_i2c_driver(tmp108_driver);
 
+#ifdef CONFIG_REGMAP_I3C
+static const struct i3c_device_id p3t1085_i3c_ids[] = {
+	I3C_DEVICE(0x011b, 0x1529, NULL),
+	{},
+};
+MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
+
+static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return tmp108_common_probe(&i3cdev->dev, regmap, "p3t1085_i3c");
+}
+
+static struct i3c_driver p3t1085_driver = {
+	.driver = {
+		.name = "p3t1085_i3c",
+	},
+	.probe = p3t1085_i3c_probe,
+	.id_table = p3t1085_i3c_ids,
+};
+module_i3c_driver(p3t1085_driver);
+#endif
+
 MODULE_AUTHOR("John Muir <john@jmuir.com>");
 MODULE_DESCRIPTION("Texas Instruments TMP108 temperature sensor driver");
 MODULE_LICENSE("GPL");

-- 
2.34.1


