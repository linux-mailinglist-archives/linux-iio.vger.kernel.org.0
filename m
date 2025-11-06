Return-Path: <linux-iio+bounces-25995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EFFC3CE07
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E551892141
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FAE3546F1;
	Thu,  6 Nov 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZCoZjNZ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB234F246;
	Thu,  6 Nov 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450612; cv=fail; b=OTxaP9rFGkonlhvzIVQOuPUUvRSoHVwOEDq3HfaV65Nxm9Jw11si+tn2a2BJSHVRcQVK1/DvGPkB7Nm9crelIe1diEn62qCkdxk3Tu0GwlibaJC/rWNe+3w0mbENtyOz96pr8e8iWYIzqI9jU/Frcsfogds3fBnEYdfqRh1K0xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450612; c=relaxed/simple;
	bh=anQimOeJzrXr5UYXGKdewIVHAKPren0hdLsICCRdcP4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LvNygcXIDMdkRok/bjB/ruFnm0cyPBuePTivRFIWV0fGInZS+rKCJAimxO6daQcwezcBLrfu6EMSqlkPSxUurb7SWNMwuNyEKNpzHvUzgDwMnaghuZgMAgVryzeE2lDlLyqlQuFlynH78HKvYEa3v+IYwv5of8Vjz+iQqvcgUuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZCoZjNZ2; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlhPwnixXdVcttfg1MuEePleGyPnb9buIjHhYIiZGRrgt/VwoBrI5yurA9nSEL7PPz1J+wZsNEF2eaTqYHTpwOlZ0FwPpQLXbykOJKSWzDEDRqTqOPtVhlKMauzreHTvsXZsylN1/dlQVUkhON+74HJjyMSlECx36Og7cND8gUz2oTmxmTJ3leApvdJV2rSn9Vbk1emVBMtnOG2laMjYcHLzY0GebuOP+IUOjC2o7HAs/vKL7wP+CxNO41SeZulmiCc8ojYaFjUJt1LlzWLiIHIU3XlZo40BbT95RJV6MlOemPdXah0aomm9uGvStn0N/AzmmNzeQJ6VHXaXF2Rqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RsDXIj2lTjYkzcPoOY059aoGN8v3PdCa0e/mCxRvMk=;
 b=mbe7aUjySgZxeJ8qiMzzrj2Wa46gcbZzmIjycTtQ23A7GFicycqq6jXlCRovzKS6F/DfNvSEchXrp4lJlN0IuJ9UwexcWdQ//M+haWmvrUnXLeMR6qa5P7/tkFpjFqmmvCwhzsCYYWGn8zRdUrs2p3Z0dDLevyrYroViV3YkQMooLxKcd0sqMFBE1K4gBMPFzvj0FMHlMMrfGbm8mGN2sfEraXbCCEykJEWqu2H5gf8ynxSeg4tnAF83+R1hGuf9uAdcGd/luUG4acA594Yra+0ZNfUQ9OEkfu2MJlf68JE0sEOYwlfjD+29KqUtAk7en17J7A5uhK0fDAwA42CbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RsDXIj2lTjYkzcPoOY059aoGN8v3PdCa0e/mCxRvMk=;
 b=ZCoZjNZ243h2BcGNOhd8mWpeD1EaAwsJw7BDkPpwz57Z/KITqL+uvnGA07KnA+9tUiW9wW2eq2rwYEdu8Elkjs7r9GlTa6Yu1SCz6jSV26kn3EzZYnk/Kl9NfBnTaic0Dttaq4gHqypaqhgN2Z8BizjmHjIG+lhX8eNEkgjjv8/6Ym0JJwEaWIUqXItUSgsE1IH0O97FOshKh/O+Q86QG40X1b5Gr/gbL9eFN2f3yKsIOp7bnPUo6CUfCujXjnMFwakn+5FRfuglsCQEvbOhtXSF98c67ihwN0DKkwewYZY+I5pLd1M8AR0Osn3L8RlSRvUIxWx6GYAvoyr6lQ6s2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB7200.eurprd04.prod.outlook.com (2603:10a6:800:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:36:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:36:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 12:36:05 -0500
Subject: [PATCH v11 6/6] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-i3c_ddr-v11-6-33a6a66ed095@nxp.com>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
In-Reply-To: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762450581; l=19758;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=anQimOeJzrXr5UYXGKdewIVHAKPren0hdLsICCRdcP4=;
 b=CMHYBqKDniIFo5DZSdYJIT7xOyERQzzWAbyV/rg4Fns17G6iAZ3fngCxjdns86tL3aBt+oRBr
 hmAjAUCOCPdCqridC/9mKDc6Ik8Uh/PoWf0abfi4JWMe1K2mLsEIFv6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0111.namprd11.prod.outlook.com
 (2603:10b6:806:d1::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0539b2-f5f1-45a7-c3da-08de1d5b0db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnRENEZtemxPT3lrT0R6RUljMkNBOW5ETDlQOEg4UDB1d3R2WFFDWldXVk10?=
 =?utf-8?B?aWlIZm9KMGovWDV2Um11VVRIUUtKQTVUS3JkVFVqbk0zUlZ2elo1cEhMWlRl?=
 =?utf-8?B?aThINFhWZnZtaEJrbTZSbkJ4eDQ1dTY2OWJ5UTgzWnE5U0xoVjBMOGlsZU9u?=
 =?utf-8?B?aDhqTW1sQUJxd0VoRS9SMTFleUdDSnpqRkV0WmtuOVkzRFhtSWIrcVlaU054?=
 =?utf-8?B?VUwvTFJYZUk2NkpGVmhHclVvYm5QNDU2a1psQk5JOFBGMUxQeGlIdEtrOUxj?=
 =?utf-8?B?RzVIem1aU29yVmMxbkQyN1FlWjlabnlqOWpLTitYWGFNZC9Cc0xvYVRpSHBS?=
 =?utf-8?B?aElaR0lSYXVRUGhCeEh6eTJrYTc5Uklia1YzZHlWVkVTQXV0TVJETmk0eE1P?=
 =?utf-8?B?SFY3dXcrenpyc3g1RllUKzNTaGNDZS8yTWh0ak56VEdOYzgyNVNlUFRxdlNF?=
 =?utf-8?B?aUhsVGF5YkNBbmgxMFpDMDkxVTZHK2pqSzdydjVIc0Y2blVkeVBxMWljUWsw?=
 =?utf-8?B?ZDRKaEczU3hwOHU3MDFmUVRnc0Y3YjkrdUdRODZxcTMvZ2ZaWWVwM0plYU4r?=
 =?utf-8?B?RWFQN3NlNExyc0pBUEQzS0NNcVJ2N0Y5SUgzNHVrc1dWaUczWDlDakZ3YldR?=
 =?utf-8?B?aXhmbUJ2ME1TR2dPTzg0MTFubHBNY3NXTGdKb3V2YnV0SWZaaTd5ZU45TTht?=
 =?utf-8?B?dXZFNlUxdlliQkN3S1JWVFlLeE5PMXVwQi9qRFV3V0UwbE13TEhQTU5OZGNt?=
 =?utf-8?B?MXNEMXR0MTVTT1owa3RrZ3QwWW1XSVc4azQ1L3Z3NlB0b29PakxtZDVzRGhB?=
 =?utf-8?B?TUpTK1ZkVkNyVmVPVWdISDNkZkMvUjVrQzFRYXlOM0YzU01XRm5veXltQ3Yr?=
 =?utf-8?B?dlpVVUhhN2Y1SlVmMHJzUXZsRXUvYUlCQUNZU25NQ2dVTFB0WktGaDhGT3Vw?=
 =?utf-8?B?VTJsT2E3d2FyVHRrdWQwNGtzZTBKaTA1K1hZRnZhZEhtTS82N2VuOVV4OGlT?=
 =?utf-8?B?VTBHOVp3ZFBLalhTaFpwMU5aVWVsMVc0bWt0d250MGFoeHBQVDRKaTlPTjZw?=
 =?utf-8?B?YjJ5OGc4Y252Q3E4aUFKNGNCckFpdlBxSFZYZlAyNTl3VnlSTDBPVmFWbzRT?=
 =?utf-8?B?RDEwMWw1YlBYT2xPZkJUMzV1ejV0RmZUaVpra0VQT1NaSFJodnc4TVJmVkp2?=
 =?utf-8?B?MlR4WHVyNkhreloyRjlicXVHM01hcVcrS1B1amVUN1pWQUtSckJFL1pmU0lU?=
 =?utf-8?B?TnJncm5qUHlJQkhYLzFqLy9zR0JwUVRrOWhnRnJYY1Y5RndlLzI0emFURTZ1?=
 =?utf-8?B?Mjc3aXBEMktvSy9ab3ZEMkQwTWdySWdNN3d4MUtselJGaEswSlhqRC80YW5t?=
 =?utf-8?B?RXRJRlFhZCtqdkluRVdMRzhmTE9mQWNEWnBja1J3UTl3NmdyUHhZSlUwNmVC?=
 =?utf-8?B?VUVaVnhncjVxVUV4RkN4TG55NDNmcFlFQWsvZW90dWlXOVZsdWdDcHo2TWhq?=
 =?utf-8?B?RXVMWWpybnNiNUxYV2pOYnJJazNTbkFobllsZEZiTVI2YzM2QkRhbWozWkxZ?=
 =?utf-8?B?eU9GZjBiN0tOODRHQyt4N0dKTjZZTTh0ZlJDTFBTbXk4Z0I5NkZZckFqemtp?=
 =?utf-8?B?Qk16MEhlMjczLyt4c0ZRK1hCdFBYZk5uY0FvQzQrVkVOQVlJTG5hZEFvTUFP?=
 =?utf-8?B?NTZ5eFdWNHFjeVQzc2syQkpTY25GQWtxQjdvVzYvQnBOMFJLbHRtRTJMeHFq?=
 =?utf-8?B?VG8zTXh3K1F5a2NDcFoydjg5dVpTT1hEOG56UXFlQVVzQ2dCcVlMOUVJVllN?=
 =?utf-8?B?MU5MVHo3YjZ0K0pWeWRXUXdvVkwxRzlqZ25yWkR0em1kOGFrTzBmTjZ6R2pk?=
 =?utf-8?B?T2E0Z1EvRHlWZEpkc1BtVS9IUEZkWm00UUt6NU43K0YvOUU4bWRUbWlkUVY5?=
 =?utf-8?B?azQ5aUhMQ0tZdXR4TEwxTnlFcllBbm9uMm04NnBmb1ZIZzJUcjhsT3RVaWs2?=
 =?utf-8?B?UzAxL2QvN3BQWlFpUW4zTGF6WjRkazBqL1I5c2dGMnNVcmY4andaS3YrN2p3?=
 =?utf-8?Q?c7/CU+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjNMS1N1Vy84L0txeUJuWE1NRjVHbWtJSnIzT2J5Tkx6cG40K3hZSmxaWVN3?=
 =?utf-8?B?dUhjRnM0K0pTQ0xTZnhoWmV6T2swNlRodVdQcEp3bk8rUUx3N1RLbzJ2WHlI?=
 =?utf-8?B?VkhTdXdwN2JOSmNWaDZvTmw4Z05jUFdudHN0dG9NU1pVRHdQMHhKVjJWR1Jj?=
 =?utf-8?B?eHBtMHdVQUEzT2xrQzJ5UHRNM1l3TG9rT056Z0ROMEtjK0hjM1J5ZG44a1V0?=
 =?utf-8?B?ZnhCTDBhVDdOanUrL3A0dXdNS2E0TGFWR3krL0g2aGpUUkxBYWtveGlMNlJr?=
 =?utf-8?B?Nkcza0U4Rm1HVEtpbGF5WGk0Wk5oVmpmK0FDb0ljM2NXK1E0QXU2VWM0dDYv?=
 =?utf-8?B?MWhMdUYvUGplOVFCNHJuVUJ3akV0eXhoVVg2ZzRuVktLWkJWS3dZdld0NDZC?=
 =?utf-8?B?dWRzd1REZUNtTEVWUjkyNFNUT0dINzAwZzc1eWJSMG9uSTc2T1BTejdhMEZa?=
 =?utf-8?B?SE4xNG5Lb3I4QTNHRjROTVhNWnRIWmFxMTYrZGh6akRienFjZWh4OUp6UU5t?=
 =?utf-8?B?THFCOXBraVhhMHd1bkEwQStPdW9qUXNxbDkrY0xUc3JwUDNWSThiQWwrMWlx?=
 =?utf-8?B?VW9ORzZ0UGo1WldQT1dIb2lqYURTa3JheDZvS2FsaTZ3bFh2S2NPNGtOWlg5?=
 =?utf-8?B?Z2pNOHpnaHg0VWRjZ2lCck0vM3NmcjloOU14Z3BMVStGUWNncDJYUklvUkk3?=
 =?utf-8?B?T0YwTGJ0ZThBQnpYVTJZZHQ4VWNzR2tLQ05iQU00MldUTmpJOVlwaGpwYzZM?=
 =?utf-8?B?NkdyZkQwL0ZqcEdKOXU2dUIzOHVoWXJseFB1amJTazlPSHhweWE4ajhieHY3?=
 =?utf-8?B?N24wMzRZL3E0NzVTNDVwbWZ5N0VCVEgyVWkwQlZaaGZ0V3o4SEQ1Uyt4YlI2?=
 =?utf-8?B?RXBLRkJjRDh0NUpGMlRwdWZmOS9VOHZiVnZsUkhCblEveGxxTTR6clRoVFMy?=
 =?utf-8?B?b2FkdmhWYXJQOG5weDh4RGdFa1R3cVJVT2hEUDFiRnQ1dWZYdFE1emJhVXAv?=
 =?utf-8?B?ZGVwbGRmU1pxcFRyOXdhdGJIVm9sNVRFR1hyVkZFaSt6Y3Fsb3d3UGlnMjN3?=
 =?utf-8?B?dElyQTlLVWN2WlpkZTJNMEtUWXBZZzZESUkvd1ZPZVR5YzFrT244MEpGLzNK?=
 =?utf-8?B?UEFFdEFPb0RrVXc1SlM2cGxoR3Z5NDFmS0NXRkNyNFVDWUswUDR6dXc2ZC9l?=
 =?utf-8?B?Y2V2dXlxSjJPMFNLQzVMUzJIQXZmVjhWY0FidHJIUGFCNFlHU2JxQTBrRUxX?=
 =?utf-8?B?Y3VsalhQMWptWDlJZUlLdGhIUW5oNE5LTkZCbHFDQzZrSUJhS2JkankrbG9k?=
 =?utf-8?B?N2YwQUQ0UFBKK1p2SDF1OGFzL0hkWUZsL014MzZsZ0JZWXRGdkNHSm5UQnFU?=
 =?utf-8?B?S0MrVWlja3NBWXBRYzRLTm50MDVQdWJOdjJPeVErZmk1Y1pPUXFEQWVxQWd6?=
 =?utf-8?B?MWNvQzFRb1ZlMlhmTVZraWtBdEM0RGJMaEhna2NRTm1oQ2FjSFhCRlhOcU12?=
 =?utf-8?B?L2VnTS9FblNRVmRmd0J3K2FOZUdoVUpqalYwLzRXRHRTckFFTjRtRVpQMVRt?=
 =?utf-8?B?VVlHNG9KTE9melE1SFZqUmZBcCtCVDZOYjEzVlg2ajlqQXZJdmI1V1hsN0xv?=
 =?utf-8?B?VlhvNklBR24ySUNubml0QXMzZmZmS3dpZFFLbFgxKzg1UDJFTFhFTEhXOWl2?=
 =?utf-8?B?WE5lNzlKc05LNzZ4VWx3Z3ZDdGRnRG83a2FjN2tLb1I3SHdYSDBnTnNxN2N4?=
 =?utf-8?B?eElWVWxzbitBOWVVOVNhNGFpa1lZYnhnNWp2RzgzUFByaWNKdGY4bWRUN2Rt?=
 =?utf-8?B?ODRsNG9hZXFWenZTTmNDbWMzVzZZQlZGcXF6SzNtNlU1djNvQUE1bHdCejZs?=
 =?utf-8?B?TjdXVnEyeTBnV3owZ2RJcHoyd1BYSUFrbkxwNzdlTlIrMmcvTm8venRXc2pj?=
 =?utf-8?B?bE5vNDZ1WDVzRWZTcDVvOTEyVlFKeXZOMlBzQXgrdE1hSDUzNzlaVDBMSUVD?=
 =?utf-8?B?cTVrK054TmdWNjdxQkcvMmIyYlRCcnVhYXJETGQ5REJZNGFDZk1TT0JHQ0ZH?=
 =?utf-8?B?NDVoUXRmWDRSWC8zbWU1bnpFV2czNXJGWkxxWWVocU1iNm9rRnFOb251NUtk?=
 =?utf-8?Q?yOODmob9Euh4b/HJR/A+a+S6o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0539b2-f5f1-45a7-c3da-08de1d5b0db3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:36:44.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JuC7nMEwvdr+bdI2zOiGM2NORzLoN2fYHfYBe5Lx0nGV+UFxbKiJSkvfUxKRkKKaltdAY8b9mQYyTw/MNrc1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7200

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v11
- add andy shevchenak's reviewed by tag
- use unsigned int for regmap
- compact mmc5633_read_avail arg list to few lines
- move check condition to one line for read_poll_timeout()
- leave i3c_xfer as size 1 array to align existed code style in kernel
tree, git grep -r i3c_priv_xfer drivers/, leave to jonathan to do decide.

change in v10
- align datasheet register name
- remove reduntant regmap_attach_dev()
- add missed \n at error message
- move *regmap to first member.

Changes in v9
- add time.h
- remove dev from mmc5633_data
- remove struct {val, val2}
- regmap return value check use if (ret) ...
- 1 -> ARRAY_SIZE()
- use guard() replace scoped_guard()
- use regmap stored dev
- i3c device use bus assigned name.
- use devm_kasprintf() to combine friend name with device ID from i3c bus
  and it will avoid build warning to discard const return from dev_name().

Change in v7
- add missed *.h file
- remove reduntant empty line
- add comments about delay 1us after SET
- use USEC_PER_MSEC for timeout value

Change in v6:
- remove acpi part
- return 0 for success path at mmc5633_write_raw

Change in V4
- use { 1, 2000 }
- Add _US for timeout
- Use GEN_MASK for MMC5633_CTRL1_BW_MASK
- Use { } for terminator.
- remove !!
- fix mix tab and space
- add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
- add tempature measure support

Change in v3
- remove mmc5633_hw_set
- make -> Make
- change indention for mmc5633_samp_freq
- use u8 arrary to handle dword data
- get_unaligned_be16() to get raw data
- add helper function to check if i3c support hdr
- use read_avail() callback

change in v2
- new patch
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5633.c | 585 +++++++++++++++++++++++++++++++++++++
 3 files changed, 598 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,18 @@ config MMC35240
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc35240.
 
+config MMC5633
+	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
+	select REGMAP_I2C
+	select REGMAP_I3C
+	depends on I2C || I3C
+	help
+	  Say yes here to build support for the MEMSIC MMC5633 3-axis
+	  magnetic sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mmc5633
+
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
+obj-$(CONFIG_MMC5633)	+= mmc5633.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
new file mode 100644
index 0000000000000000000000000000000000000000..7b20ff3b063b026ab2ae0170fd8c021973428dea
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5633 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ * Copyright (c) 2025, NXP
+ *
+ * IIO driver for MMC5633, base on mmc35240.c
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define MMC5633_REG_XOUT0	0x00
+#define MMC5633_REG_XOUT1	0x01
+#define MMC5633_REG_YOUT0	0x02
+#define MMC5633_REG_YOUT1	0x03
+#define MMC5633_REG_ZOUT0	0x04
+#define MMC5633_REG_ZOUT1	0x05
+#define MMC5633_REG_XOUT2	0x06
+#define MMC5633_REG_YOUT2	0x07
+#define MMC5633_REG_ZOUT2	0x08
+#define MMC5633_REG_TOUT	0x09
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
+#define MMC5633_STATUS1_MEAS_T_DONE_BIT	BIT(7)
+#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
+
+#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
+#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
+#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
+#define MMC5633_CTRL0_RESET		BIT(4)
+#define MMC5633_CTRL0_SET		BIT(3)
+#define MMC5633_CTRL0_MEAS_T		BIT(1)
+#define MMC5633_CTRL0_MEAS_M		BIT(0)
+
+#define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
+
+#define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0x05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	MMC5633_AXIS_X,
+	MMC5633_AXIS_Y,
+	MMC5633_AXIS_Z,
+	MMC5633_TEMPERATURE,
+};
+
+struct mmc5633_data {
+	struct regmap *regmap;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+};
+
+int mmc5633_samp_freq[][2] = {
+	{ 1, 200000 },
+	{ 2, 0 },
+	{ 3, 500000 },
+	{ 6, 600000 },
+};
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = MMC5633_AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = MMC5633_TEMPERATURE,
+	},
+};
+
+static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
+				       int val, int val2)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i][0] == val &&
+		    mmc5633_samp_freq[i][1] == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id;
+	int ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret)
+		return dev_err_probe(regmap_get_device(data->regmap), ret,
+				     "Error reading product id\n");
+
+	/*
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret)
+		return ret;
+
+	/*
+	 * Minimum time interval between SET or RESET to other operations is
+	 * 1ms according to Operating Timing Diagram in datasheet.
+	 */
+	fsleep(MMC5633_WAIT_SET_RESET_US);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret)
+		return ret;
+
+	/* set default sampling frequency */
+	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				  MMC5633_CTRL1_BW_MASK,
+				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
+{
+	unsigned int reg_status, val;
+	int ret;
+
+	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
+	if (ret < 0)
+		return ret;
+
+	val = (address == MMC5633_TEMPERATURE) ?
+	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & val,
+				       10 * USEC_PER_MSEC,
+				       100 * 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(regmap_get_device(data->regmap), "data not ready\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
+{
+	if (!data->i3cdev)
+		return false;
+
+	return i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR);
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 data_cmd[2], status[2];
+	unsigned int val, ready;
+	int ret;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
+		struct i3c_xfer xfers_rd_data_cmd[] = {
+			{
+				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
+				.len = sz,
+				.data.in = buf,
+			},
+		};
+
+		data_cmd[0] = 0;
+		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
+			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
+					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ready = (address == MMC5633_TEMPERATURE) ?
+			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val || (status[0] & ready),
+					10 * USEC_PER_MSEC,
+					100 * 10 * USEC_PER_MSEC, 0,
+					data->i3cdev, xfers_rd_sta_cmd,
+					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
+		if (ret) {
+			dev_err(dev, "data not ready\n");
+			return ret;
+		}
+		if (val) {
+			dev_err(dev, "i3c transfer error\n");
+			return val;
+		}
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd,
+					   ARRAY_SIZE(xfers_rd_data_cmd), I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data, address);
+	if (ret < 0)
+		return ret;
+
+	if (address == MMC5633_TEMPERATURE)
+		/*
+		 * Put tempeature to last byte of buff to align HDR case.
+		 * I3C will early terminate data read if previous data is not
+		 * available.
+		 */
+		return regmap_bulk_read(data->regmap, MMC5633_REG_TOUT, buf + sz - 1, 1);
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT0, buf, sz);
+}
+
+/* X,Y,Z 3 channels, each channel has 3 byte and TEMP */
+#define MMC5633_ALL_SIZE (3 * 3 + 1)
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	if (index == MMC5633_TEMPERATURE) {
+		*val = buf[MMC5633_ALL_SIZE - 1];
+		return 0;
+	}
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = get_unaligned_be16(buf + 2 * index) << 4;
+	*val |= buf[index + 6] >> 4;
+
+	return 0;
+}
+
+static int mmc5633_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	char buf[MMC5633_ALL_SIZE];
+	unsigned int reg, i;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = mmc5633_read_measurement(data, chan->address, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_MAGN) {
+			*val = 0;
+			*val2 = 62500;
+		} else {
+			*val = 0;
+			*val2 = 800000000; /* 0.8C */
+		}
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = -75;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
+		if (i >= ARRAY_SIZE(mmc5633_samp_freq))
+			return -EINVAL;
+
+		*val = mmc5633_samp_freq[i][0];
+		*val2 = mmc5633_samp_freq[i][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = mmc5633_get_samp_freq_index(data, val, val2);
+		if (ret < 0)
+			return ret;
+
+		guard(mutex)(&data->mutex);
+
+		return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+					  MMC5633_CTRL1_BW_MASK,
+					  FIELD_PREP(MMC5633_CTRL1_BW_MASK, ret));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)mmc5633_samp_freq;
+		*length = ARRAY_SIZE(mmc5633_samp_freq) * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5633_info = {
+	.read_raw	= mmc5633_read_raw,
+	.write_raw	= mmc5633_write_raw,
+	.read_avail	= mmc5633_read_avail,
+};
+
+static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_XOUT0:
+	case MMC5633_REG_XOUT1:
+	case MMC5633_REG_YOUT0:
+	case MMC5633_REG_YOUT1:
+	case MMC5633_REG_ZOUT0:
+	case MMC5633_REG_ZOUT1:
+	case MMC5633_REG_XOUT2:
+	case MMC5633_REG_YOUT2:
+	case MMC5633_REG_ZOUT2:
+	case MMC5633_REG_TOUT:
+	case MMC5633_REG_STATUS1:
+	case MMC5633_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct reg_default mmc5633_reg_defaults[] = {
+	{ MMC5633_REG_CTRL0,  0x00 },
+	{ MMC5633_REG_CTRL1,  0x00 },
+};
+
+static const struct regmap_config mmc5633_regmap_config = {
+	.name = "mmc5633_regmap",
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MMC5633_REG_ID,
+	.cache_type = REGCACHE_MAPLE,
+
+	.writeable_reg = mmc5633_is_writeable_reg,
+	.readable_reg = mmc5633_is_readable_reg,
+	.volatile_reg = mmc5633_is_volatile_reg,
+
+	.reg_defaults = mmc5633_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
+};
+
+static int mmc5633_common_probe(struct regmap *regmap, char *name,
+				struct i3c_device *i3cdev)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &mmc5633_info;
+	indio_dev->name = name;
+	indio_dev->channels = mmc5633_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = mmc5633_init(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int mmc5633_suspend(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+
+	regcache_cache_only(regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	int ret;
+
+	regcache_mark_dirty(regmap);
+	ret = regcache_sync_region(regmap, MMC5633_REG_CTRL0, MMC5633_REG_CTRL1);
+	if (ret)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(regmap, false);
+
+	return 0;
+}
+
+static int mmc5633_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
+
+	return mmc5633_common_probe(regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend, mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5603" },
+	{ .compatible = "memsic,mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5603" },
+	{ "mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe = mmc5633_i2c_probe,
+	.id_table =  mmc5633_i2c_id,
+};
+
+static const struct i3c_device_id mmc5633_i3c_ids[] = {
+	I3C_DEVICE(0x0251, 0x0000, NULL),
+	{ }
+};
+MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
+
+static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "mmc5633_%s", dev_name(dev));
+	if (!name)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(regmap, name, i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


