Return-Path: <linux-iio+bounces-26672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9552C9EF6E
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 13:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32D213488F6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BB2D661C;
	Wed,  3 Dec 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="yL+USWaQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021103.outbound.protection.outlook.com [40.107.130.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADA27A904;
	Wed,  3 Dec 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764764473; cv=fail; b=Wk3fAZI0wFBsYgnjd4FnXxvxgLXFGcuy+W7D4jlRZquafcRa4jAv1+5NVT8htBxdAKiTzTmI64TwQRNxckMbfLG5hkw1BYG/K+rBeV+ZIQVE6L6gutQVml/4elhrCaRVDQsmqs2yo9m3kFO+57ac7QKDLPcLPr6YurLoQCkWV6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764764473; c=relaxed/simple;
	bh=U0KVX0520fUnxkn9z7Dh4q8c0BrWndn6LJDzM62d96A=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YmUtlpvcn1cLZJ66nTVniwE5zkB0gHzmcB2YBl4rHd5pHpXx1/KIGefmLvvOZ/mLvrIqtCOqOVrN65e9kOd+wKBh9boDFEZUiMBNCtVsXLw/CHeQ1LDavrJzCJWZyIX6dGwCtVyNrbqQGYroDb+psafD+qotm3jY7T4OMnP9Rc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=yL+USWaQ; arc=fail smtp.client-ip=40.107.130.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPucrY3zNqAz5rgstaXshTmIOroozmTw81kLOnbizoJEJoR2kqDb4ijZnlP+38wmhmVNAe2erIpRFUSs9dBB0SzsykqOSgWTajhAjNqNmeLrkSAMRBj93/eTncF52lPie3IM8IYCNGytavpXqHutc9w1dwEVjOCTj+H6np55SdIPFhb+YpS03UdB/w55M8sO47bTm5YyKrYc9BE9Kio8qJIrDe+LGpzORVCNfCCG3J/UIyOQSchUgs00wd5eGvqOaVo3z5dzvHnpev5umCH3g+2JwgKGZKPety/1+AtKBdujJsda5+4D06wfjNGVS1hAGVgXa+hMrV8XK422ONqsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfKeTt/oLuy3pj3imcFrhyP6rr+Z9FNNwKZxWZf8Lk8=;
 b=cApXxarIFjPHPEo0QA6E8C3BjlSH64jSkDjw55+HZqD7dOg18sOanhpPfq3VorlC8lG5EGffy5Oy43lJ1NWLcaRwpzFUrTjeg2EjiC8cp4h/PsRbL4SMrtEXew5njcHKjUpTjOtGo4HKBqfZe1pyyTAyvdrKjzYERpd12PFr/qVx4ywgcVf2vUdv9I7iXXYo5E7FSX8RqdhipyqMKJIlBmh1uFzxlE/0yKwmMA5Hh86ajHMQCtuW4ZAnJZstmRN030wcADHVjGYB0lpTM45Yw8DWCA7NdLjaeb6/st8CK3Ahq/vyxBCVw3P2rL8t1Ab/KaAbchaOUy+Ij4UrO+dhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfKeTt/oLuy3pj3imcFrhyP6rr+Z9FNNwKZxWZf8Lk8=;
 b=yL+USWaQhYhzsNiqwMpOjgkwsDG88vYpo8vZBOtD/bB1FrSocbQhVGIyv2Xf0067pxtcEc1ODj5DVuCV+758/bkj48lrJhLDUkkZEBxdcvTKAuJKPAYfbbhboftWWt3P2NuXSRaa4m37IB8IYEQKq1WLXk42RDBq2+XB2mzjzVpIgWdMLthhbI709yJ7micuRbfv1CQv+tf4pieWJWkSJS8yCUCV5XMp9W7+kppFtVLQGw68Q6D3ekqlJ8nQVxVf0lTfWZSXPo7eYKXhCNIeA7hGN43KDXRh90UYOodNAT7b86AYsYpaVs84L7WvHv2MuJ56nA0WcfqMtDzUvMnwyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB9PR06MB7257.eurprd06.prod.outlook.com (2603:10a6:10:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 12:21:03 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 12:21:03 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 0/2] iio: adc: ad9467: add support for ad9211
Date: Wed, 03 Dec 2025 12:20:32 +0000
Message-Id: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABArMGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNj3cSUFCC2NDI01LWwNE9JtjQ2NTG0MFUCaigoSk3LrAAbFh1bWws
 A6H2IGVwAAAA=
X-Change-ID: 20251203-add-ad9211-897dc9354185
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764764462; l=1071;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=U0KVX0520fUnxkn9z7Dh4q8c0BrWndn6LJDzM62d96A=;
 b=OWcwAbdVm3dLNJHFbvZpxmR5pV4YrXoPyYHJDGK/eO4oGP1uSvWTn3FLcIJI6PJ8y678Msd8n
 Rz896mcc+5jAR7uGxWQx2Uf9akF/JyHUdPwAp6aGqxYFCzDNqvyRbIO
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVZP280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::15) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB9PR06MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f894ff8-4ef5-4069-e090-08de32666d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDIzUjlUTEdTUTl5UWVXQlBPbGlZWVhzNTdEempYZFlOSU9CdzFPb0xDbEU0?=
 =?utf-8?B?RERxSjlpR1ljb1ZIRm5VUWhXM01JN1ZXY0lhYjVTeUF2VTg5cWtZSEc0TjJY?=
 =?utf-8?B?Tkg4aEc0RU1mRnAyNlpxTGRBczBqcHRWRGF2SHpnb0VjV1RGREthUElpKzVy?=
 =?utf-8?B?blhEMUk2Q0h0NDJJMkFpK3BlalNxYXVXTzJWQ2VyTWM2MU9DdEg4K3ZoNWFZ?=
 =?utf-8?B?VDlIVTkrNkxyN0JtanhacTBxc09KbTRhSVl6T000QW1ONXFDVDhWUHR5NUhM?=
 =?utf-8?B?QWJUTzlHU2hlWTd5ZFdPQk9xWE1hdTRubTdiUDRmT2N1L2R4dytZTmVFZFpH?=
 =?utf-8?B?RWJ6WWlXMFFia3JoWW1oUURmb2lwNzk2UGVpNFNqVkZjUEs0MDRzbUc1OHpZ?=
 =?utf-8?B?T0thY3EvdkVzM3Fjb21qUHNJZnk2KzNJaWFHMGFSWkVLRjN6UHN5Mmd4Mmd3?=
 =?utf-8?B?QXNXN2pvaS9MZW9GY1FYYWFmaWd3YU9iZFhGWVZsUC8vU0tKNlpYOXFDZkg4?=
 =?utf-8?B?LzdYT2NWZjRqTnV3OXkwQVE2b202cWdra3pXWHhRV2xOUXJKejJuZEVZTlho?=
 =?utf-8?B?M1pxQktBaGlZL1AwbmRsdVJGREsrNE1mbnY3MWoyM1BNeDJvcWZMMzhlNHoy?=
 =?utf-8?B?V1Y3Vm9wOTR6aUNaNjc1SFpLMkRZeFBXMHBPRUMzbTg2dEdlTnhhNkVabmUr?=
 =?utf-8?B?MXBJc2hXMGJITVFoTlVIa3pGd0J6VU0zYVY5Z1QyamtKL3F2SjJHV25RT3Ew?=
 =?utf-8?B?U2c1bHBmdG9pZ1pUc3cwNjZJNXZhb3IyT0FDcTZVTGNrL05IQXo0enp1RUpQ?=
 =?utf-8?B?NE9lZk8ycGhnTlRBOWVlRTYzNWM1OW5OOHcrZ0tIV1VScW1nakpPckNWdzU4?=
 =?utf-8?B?amlKaVprRGVpZEtPWWlBakY4WFo1L2tnYUl3ZjNqcE5jNkFsL3JJaEhiR0l1?=
 =?utf-8?B?UnVkRURIdmNOVzBmY3AyRHJBTWRQZE50OWJIKzNaTHcxeFJBQXNwaUhXZ0tq?=
 =?utf-8?B?MzNuWlRwYkZNclhJSzJuSU1qZFV5dXY1aHFPc0pOdlRGeFllQmRBQXE0Q21Z?=
 =?utf-8?B?cWd3bXMxS0txNTVuZ013a0FWd1h6SFg0NUdLMGZBTVZyL3lMV2xHSkZCeEU3?=
 =?utf-8?B?TUNyMEQzZElta0FMaEVPOUxsck9GZ3hwVGt6WUQxbnQ1czZWL2lYY2hjY0ky?=
 =?utf-8?B?OWhUa3M2SndhNWo0aUFUZGY0SUdmY1Nta3NiT0s3NTYyTmQzWklXT2w4dEF0?=
 =?utf-8?B?cG9BOTZTK0YyVXAzN2gzU1o2dWVNcWZvcnJ2K1dibmdKQ21lKzVDaEl2TFhY?=
 =?utf-8?B?QnNkZUxHSDZxaDVKVnBLMDdIZE1VTVF1dVVjdzUvaGxzeHpUdjdjNXdCVG9H?=
 =?utf-8?B?cmYybWlYdWU2cWtmZlRyeGI2S3UwcmNYVlZtR01FUW0yN0NvbTNSanFiRndS?=
 =?utf-8?B?cjFqRTRhcnd5UTFUR2R3djNyWXRPcnB5bnNidXdaR0NkQ240Y0VkK1IrU3hO?=
 =?utf-8?B?ZHdiSXhBN3ZaNUtmblhWUmhYSklSM2o1SnMwM0h3eHZXU1AxKzVUa0JyMW1a?=
 =?utf-8?B?N2hWQzJ2N3pnWjUvbFpubXJIUGhuTDRUZ2d5RnJTMXU2eDYrZXJrSkZtTEZq?=
 =?utf-8?B?Zlo5Um9JQ2doSmxha2FacU45ZmVta3RnNGJxUGRINHh3WVAvMEc3NUZ6TlVs?=
 =?utf-8?B?Y3FtNVZ6cDBoL0hxWE5zNFA0Z3V3WW1KenlUejJtcS9pcUQwdm84K2szODZ1?=
 =?utf-8?B?b1AxSnV6N2tocnl3QVM3a3c0ZzdlQ1h3UElRek1LaEJIeGhXV2tZNGEvWDNa?=
 =?utf-8?B?RDE0YmFMUVUyRHFFR0lENHR2YkFPazBNQVBBdVpQN05wZ05xNU5aM3pycld6?=
 =?utf-8?B?RjQzTE1tMDlydmJtNDNMSVRMQWcveVNJbnRRTkc0bDlVS3A1RXpob2xJanl6?=
 =?utf-8?B?bXIvZENUbWlVUXJ6U0pGTzIwdTZHcVNGUXVHRWJsc1BqWjQ3ZXJETU1NSXdT?=
 =?utf-8?B?RDI5UzQwY1p5M3A5SjIrUlVaVEpzb25Pdm5wL0NPa2t5di9TMDN2K0FVZG1q?=
 =?utf-8?Q?OBvPzC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW1tNXpFTHFoQ1A5RXNITlNYRGJ1VnJZRTc2NE5IRldPV1dZRzhkVXk1dldV?=
 =?utf-8?B?NzRWUVhkTmxnemhmRDRSdmV5aTViVVpvdkFDYWhyWjZUME03Um10dXJrLzFX?=
 =?utf-8?B?bGdOaUV3Sk9CeUJ3dTE3cXdOVTZ5R0tEN2l0VjBjUlRBUFJ0cy92eFlKSFkw?=
 =?utf-8?B?STEzL3lYSVRUdTVpREw5bEhwTGVDU1I1c1RSZVU1QW5wRVZCS0xHcUY2L1Rq?=
 =?utf-8?B?UzhUR29SUlp2aytCbGo2dUw1KzFLM29GN0g4UFBpVUtNTGRDK0Z0L3pMdGZQ?=
 =?utf-8?B?RTFnMlh5V0xuRm1rS21pbGgyL1F1WlQrUEoxbzl5U2JuLzRQbEdkMWl4WmZI?=
 =?utf-8?B?Q29iT09Od0c5TGgxamE5NEw1NFpJM1JOc1MveVdJb3R0ckJKS0RqVjV6M1Yv?=
 =?utf-8?B?Lzh5RmJGeWd2ZHl3dzZWeld6Z1Vja3pOVXFsUjR2M00veWRMcFFXYS9qSXZY?=
 =?utf-8?B?RGx4WndnYkdaNEtrNzhLMVNHWGs0VUNVK0pvc2ZhbEpEVEFnS2dXYXlxSGVn?=
 =?utf-8?B?OXU4MksrZWNPM0dCd1lnK25CZVdUM1c0dUExU2hlOHpSeGp2Rm9qbktYODZq?=
 =?utf-8?B?cXE3UENhL2NpVXpsNWozSjVVWU05dDgzNUVrenhlZmVUYTd2WWhMMW90WW9O?=
 =?utf-8?B?Vkg4WjVTSXNXbVJ5UEQxVExwUHRqckw2d00vWi9scWd3UUFPTkw0NUJrQXlD?=
 =?utf-8?B?SG9EWkFmUzllRk5tc0g4OUlSWDlBa1FXYTl0VWxDakd6UWwzRFA3NGxqbVpX?=
 =?utf-8?B?dFFJSWFPOWpEc0dkeVQrNG1VaWdDbWRZUkdOYkVQWVpPLzhJRENUeEM2d01h?=
 =?utf-8?B?ZVQyRlo5UVFqYlpkNmM0dy9MQmU1WlViTTNKUko4SjZzTytxaW9sUHVDK0NB?=
 =?utf-8?B?NmlBQ2VCRU15bHlvOENLTmc1WDRpUmcvbGx3Q1BaL0Q5N1RibjZQQlRBTW93?=
 =?utf-8?B?eDNRaFN1NE44cHpzM1VNRCtONkt0ODJOMVg1Rjh0NUc0YWdUakdKS1BjbC9I?=
 =?utf-8?B?N0RmTkFoY01RUWZkMzIxUE9iM29GYkNJVS82SGRCZDl6RXU4NVIrYlJ6MGRx?=
 =?utf-8?B?L2xnNDQvVGk0NHFXMG9IZVFDRTkvTDFBSDJ3UTQ0TThuSEp6TGhSSGpwenN1?=
 =?utf-8?B?Z2lzN1Z4RFJsb1pobGZaay8wVXRPQU04d1VGSU91MUs0N3hHRnJUM1o1SmZH?=
 =?utf-8?B?YU1KUUVVNkZjYU1vL1NxREhrTm9xWkRXMGhMOEZnbFhZLzZiTWd0QnlURUQv?=
 =?utf-8?B?K0hwUytubS9KZjZibzNnTGxwUTFjazlSNkxPZEUvdldLRDZ3SjlDZTRuRUhn?=
 =?utf-8?B?ZHhKN3BYUXdKNmpja0ZVOU40ZEhObXlyUi95SjNiMkprRVJrdm9SMlBOLzhp?=
 =?utf-8?B?TmVUYkpKSjJaWEpaTzI0S3lwOGQzRmY3bGp2VGxkNTArYVovZWVXNngwRHNP?=
 =?utf-8?B?bDlveGw1QzVBNVkwOFNOMUZaS0YvOGhNQnU5Rzl2WlZYYWppUjVvSXh6K01o?=
 =?utf-8?B?d3Rxa0djeUhMb1V2UUM0ZEZvdVczMHowN1NUUDNleVZQbXZnQmJGajhhSXlT?=
 =?utf-8?B?VkkwOGxhaHNRMEozQUdPMVltQjR3QWpUSHhTUzJCZnFoeGJWcExhODFWWUx5?=
 =?utf-8?B?MCtKdlpXcEpnU0t1ZU91RjkrMWJHR2RMd2pPeDV4c05kYVdydGhab2Y0dGp0?=
 =?utf-8?B?MDl4SUpDcklaTkpwaDhKaCtLQUVDZVcwNTdQaFMwVEFNVE5COXlNVERZSmds?=
 =?utf-8?B?TUt1NUpwYWU1c2FWbWJFN0N2ZUl2Z3hvMzFLT0tXWUtOK28zMk1yZ09kUkZK?=
 =?utf-8?B?SWFMRlQyeUpXOERxSjZidzl4TUpMMDBUSTlBRnQxUFgwaDJCbHRrNUZMNXk0?=
 =?utf-8?B?RWpUMmM5UHFHZ09LRjJKMStJQXFaNWhHa3ZwcHdvVklDcnlucHA2dWtBUHBE?=
 =?utf-8?B?WFordkVWSFpnSmdsVXM1bVVCRVFhbTM1aXJreHY2UHphS3JITzVoNlNBUSsv?=
 =?utf-8?B?ZWZRd0NVN25SVkwwYXNML21lK1UyenM5SElVZTJpU21XU2xjejNDNDZkRXNC?=
 =?utf-8?B?N3MyMEFCU2d1c3BlQXBYZlJLTEhMeGFuOU12d2N1bWdLQkJrWFYxNHhEZXAr?=
 =?utf-8?B?dTNyenFTZkJvRXBieHdyY3Y5dmh0L0VqNExYNEdoeVNKbE5OR0J3SUJhUmFm?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f894ff8-4ef5-4069-e090-08de32666d25
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:21:03.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p50icPF4BHiQ1GqWgyQ3cJMbwE9pvwso+asmUO6ZUqgAzct/68cGZCLZxm4Q0AEeFSI3TCdbafBK3APs0bC/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7257

This series adds support for the ad9211, a variant of the already
supported devices.

Example usage:

$ cat name 
ad9211
$ cat in_voltage_scale_available 
0.957031 0.976562 0.996093 1.015625 1.035156 1.054687 1.074218
1.093750 1.113281 1.132812 1.152343 1.162109 1.171875 1.181640
1.191406 1.201171 1.220703 1.240234 1.259765 1.279296 1.298828
1.318359 1.337890 1.357421 1.376953 1.396484 1.416015 1.425781
1.435546 1.445312 1.455078 1.464843

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Tomas Melin (2):
      dt-bindings: adc: ad9467: add support for ad9211
      iio: adc: ad9467: add support for ad9211

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |  2 ++
 drivers/iio/adc/ad9467.c                           | 42 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251203-add-ad9211-897dc9354185

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


