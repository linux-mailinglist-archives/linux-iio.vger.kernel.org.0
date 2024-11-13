Return-Path: <linux-iio+bounces-12217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2D9C7AE6
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 19:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBB2B2D4CD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0B2038DD;
	Wed, 13 Nov 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXCt+luS"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABD203713;
	Wed, 13 Nov 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520512; cv=fail; b=HPPp9N5mqz4NVP3AkegRDHPnaSUlM/Ktdc3ZPFs4WFSIO18OCRiKzeopsbCnK351AoUYHzTnFESZ6WP376h73B3a9M9F8CGePKZFQQC5dJFsHcpX7nppL9BGIm9ll3YvCZCzFNWsupH1Y6A9vR0RqqzbLL/HNaZjazmonuq5lMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520512; c=relaxed/simple;
	bh=2V2/OffTB7Y+mRoauyWGApi08KOhpAyk4U8e3vWJxro=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rhTNT0mxnLYgbS+rBHsksq6VpkMidMKzCCn6V+9NEcCrrY0OTMmTJoG5aD26LVhixUgxNlN1YtAJAKGw47qiaHXady76ThAv7pszxMOngVid/0+cPVCrD/BM8F1KR50bVUVVYHK9zXnXyAkcJzKCaJLLLwJOVx12MUXuptRdpUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXCt+luS; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHqDxkqJIrF/WuLR0hqQDbRxn7XFfL7QPmjci9giVJqxs09rzQ8BryFnK1XeWulsngj9ZC6iue+myzkWioltYZJ00RxlwEwtVhCbkXWLhg5G0dwuVh2fXGLpkYqEsT1TmBCshhbDBS6fGs5gxlVM1AFeIAHDJFer/pBBLdr2cu3XuzC88kCrGwWsgCtogPeP1b5xX+EUWRHI7ES5LkbOr4khVBF8o1troiKHxwxGEZO1zLCapl0xAhKcDbuhGVcu9JlIr3DDGnOH3qVai5c28Gxkp/LG11XTct6O4rgho3Aq4c8asN6HLe2PJMdqE3aRERnVJMQc/xytgfVesS2vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsWjOU7YHQJM27Ukq3hW/Czxq3cDElu0AasVAlDzxng=;
 b=C1agEIrHIUMAHSWp5Wr3Ft2rGVqeIJB7WlLODe1cHrpt9fntYu/Z7r7V4DXU7sSChPWd0ZCZHcPa4KpMeDLlNeLD82quD7Kpq7XGJRfWapful0Qfwzr2Ug6gBQVw4C9TvATHFnwDWNo6ryiIEPmG50+AtT82adR5zINQYxN4TgbA0evUdjeu3nwo5YwrqcDy0E/nNLDqvav5vu8FvmAcFk0bBGfYKCybNI+seBVXwhrmT2jdRmN3qAFFg8fzp3R7sR+E8InfBYkU9oQ3x8pb/lmnogzbZylpZxIJmetHIrEQIK2cldXg5u3mk8+L8aH4Zveab4gF4y83sAiyz9J+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsWjOU7YHQJM27Ukq3hW/Czxq3cDElu0AasVAlDzxng=;
 b=mXCt+luSfPkRMM7ZrVmKVCeqMdOrWiUvJRe6XSfEC1zuACQ16KJt/qWhaVB0p55/hcvFXUkluZv9x0SYtrcpCajNipwZUmviTW5yJLvdk1ihC0BUPX6ilPQpXluSY9b5OAR8TIEgL0QNGZj2IxgU607AtO0A9oee32l/U/WO6uDV5Z/niLWdGUbHho9zkX+wrjXlH5YUps5shAlMb7jxsx0l9aNaBQIlNuMYG3ymlEK4Ir/qHOrf4jZVsQ+Ryi2q8nBv3Hy+YnlVdviL/dCXgRVjd1xe2KeIG+XX8jeMKqZsPchiB0aLvLEAqOJ/4CNqETvd4GJcXj/g8HqRCwc7uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 17:55:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:55:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 13 Nov 2024 12:54:40 -0500
Subject: [PATCH 2/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8974cf'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-fxls-v1-2-5e48ff1b1fb8@nxp.com>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
In-Reply-To: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731520491; l=1098;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=a/bA0APA+3ygwvANvfyZu1e3vggDDQPdXKxLuDjPneQ=;
 b=1GHmYbAaH54DC0zh04GGRKa14AUXBdch0H8skYja9tKyHeEmCrcqOHwWKIKw3Gu/3suUSJxOd
 bdGzQRA89lrCFQuqBw8lnyYnXm19mWrBwNOBNs9FA8dlZwU5MoXFcRk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6fae1c-3c22-46f9-3f61-08dd040c4be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0g5bkNJcW5tMkRmYTlUMkZyYlBIUEJhNlZQU3NzdXJ2M0V1YkRxOUNsUU1B?=
 =?utf-8?B?RTVGQnhDSDE0Zjk2OUxRVXJ2bG11eFhld1YzcEkrQ1ZBRUJ6ZU9IVFhxYzE1?=
 =?utf-8?B?RHU1UXk0SDJFaUVvRTNDQnNzbkJkZ003WHcvQzQrNE1EeVdtWEV5ZytQNTMz?=
 =?utf-8?B?WW04U04yN0huKzhsQmwvTFdNUHhscHkrMnlTWVdZbzlSbGRvUGdLM1JSK2h2?=
 =?utf-8?B?NzBwVW00dW9KY1g5ZWI3bnJqYnVFRnBBYy9UODV3UWthVm4rTStjV2VOcDdI?=
 =?utf-8?B?dVlSWjVwUFBiM2F4Zm9pcjk3dlU3ZmJpWEU3YnVPWGJxRXQ5OTNlNWczOE0x?=
 =?utf-8?B?RDM2R3lYWnFEeXBtTXV2a2xHSVRHWG0xeG9HRzdzUGpQcVErd1ZPWTVPYUo0?=
 =?utf-8?B?MFNWeUNpVUg1T291Z3Jaak1pQ2Fjc3BoZXcwWFYxaEpWdUR5eWFoalYwSkZ2?=
 =?utf-8?B?dWR1aVFISmw3ZnlUNDhubVVSMHBDVytvdEh6WjJpZENGVHVPY0JLM0xnUlN3?=
 =?utf-8?B?cVNPZWxOMzZ3aTRVUkdkMDRzaGNIelhKRldNd1pHeFFsaWYzWnpyY2FVOWNr?=
 =?utf-8?B?V2preDk4Q3F6SExHc2NwRVlZeEdIeUkwdHY0QWUzbVo5UVh3NXhmbDNLbDFp?=
 =?utf-8?B?OHlCMUU2MUFWcEMvVjZDZE1adHlML3YvdDgrb0hIS0c5MHVvU1hZZVJ2UXVZ?=
 =?utf-8?B?UEkralhJc3h3Ky90aFZrTzh2TVFmNUNuMVJFY3VVTVByUHByZitJaVBpYzha?=
 =?utf-8?B?UDYxbFh5Y0hwYnhQd1dvUjVVVXovZ2lVbmRWTHJvVlFIWm16a21aU1Z2RXRl?=
 =?utf-8?B?NHp2YU5ucTBXWHZSNEVqdkJjUEdPV014Mlk4S1dvaGRpMXNzMmhGUlY4eEEy?=
 =?utf-8?B?Y1ZueE5nS3NUcGc5YnozekRZRk13LzhxV00yL0R5ZjdmMUtyK3VhbXcrc0lM?=
 =?utf-8?B?aURZWUxBY1VSNGQrWUhXMTVGMXdDYktkRHRKeGQ2dWc0M0Qwdy9nd2VjczZx?=
 =?utf-8?B?c1R2SU8zTm5MRTJMNjFxdjFJMjE4dlVnMDlPUUl4VXlDaTA4Y2VHNllwdnZN?=
 =?utf-8?B?LzZIWkJySGNBYmxkRUN1S2dKMUVDMm5zdnhRSm5zSnBFUVA2YTkrZG84aXc2?=
 =?utf-8?B?MVI4WWpRaUNCbmNlcUFyRW9hWlZENnlSc3VFbmExdTN2M0tRZnovWE5DNDhR?=
 =?utf-8?B?eW9wUkd2TUdDTmFEejkwTEtjWDNOZmV5K2dNbHJPVFFmT1NNMFBRc0FkcWlq?=
 =?utf-8?B?dTJ6QmZ2Y1dZcnBwRU5zcFR5N28ra3dsMEd6cHZsVUF4dm1Wa0dvTjY5a3Nn?=
 =?utf-8?B?U0F6L0ZDNzZ4MjhNRFl6cGlYTVJEUTJLNEdncHhCa2pHSVpXaURyMnhpYUp5?=
 =?utf-8?B?K1praFlWMU5OWC9zRVRMdkRZWlVJOCs0VmQ0RW56SE5tS2ZObHU1cG1Kb3lv?=
 =?utf-8?B?Sk0yT0Zsck14VStyZ0pDYzdCV1U0MVhTLzNSTXFBRzh0Nm4xZm9LRWtzbUFw?=
 =?utf-8?B?M2FCK1EvcU51b2Qvbi9JdENNMmNQZ0k5bDI2MkhsNUlmL1BhZ3hKNUJVYmp2?=
 =?utf-8?B?cE1JdHdiUnBnYTVqTkF2VGcyNmNmTVc3cTJWRElxcXJCK3dlMlk2TkdGMnZu?=
 =?utf-8?B?U2xsRXZ4VW1BSG14S29PVUNHd28wc1hqRTJkOFRPMU56ZHlKRGtMVndpYlNU?=
 =?utf-8?B?RFhwcFN3TDhDZ2NGM1dWd0VhYzdud1lMdWZsckhZRlIzWGt0MXdobTJnN3hj?=
 =?utf-8?B?VTVocnZ4RFNobVdNbk9FWXhNTUtaVXlSdllnUWlHejBobWt6YkprNE9Rendl?=
 =?utf-8?B?WUVhRlFVNTZGYWFmMVA4MmFlN3dUV1ZvQlJJNFVCWTNudmJ3clQ0ZGZyUlg1?=
 =?utf-8?Q?SBpHjvyV3HmYT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3pIZU5XeDYzWkV5ZmtJZlcwWGl6SHIrbUg5MjZqYWY0b1RGS2E2NGhBd1Vk?=
 =?utf-8?B?Ym5Qby9iRnRhQXc2NTdMNmFhM2l3TnNtOVBXQmZ2ZU9VaFBuQlZ2Y25sc1Bx?=
 =?utf-8?B?d0RLcUdqN3lBcnJNWUtESUVRelNVVmlXSlJ5cHptYmFGTEVFem1WVkxZMXIz?=
 =?utf-8?B?c3RpQXJObnU1Qkgrc3UxM2VZeTRwbUVMOGtQM21DNUZCbzkyRnFtNUdJNVFK?=
 =?utf-8?B?Szg2ZC9tY2lQNU1lOTYrcngwOUNhNEh4RVA0dXZiUGsvWktCUEZldUllcVRB?=
 =?utf-8?B?bGZXQXBrU2hqLzhCRElzRlZEQzFhSEs3VjVsWkhFeTloVS9xUjZ6bmtHKzVU?=
 =?utf-8?B?b0daSDNuQjZwR3RFaWxTY3VOb3d1S28vTE1NVHZPUWYwblVvREdsZVVSbGpJ?=
 =?utf-8?B?SGppQVEyQnB1WFlrQTIxYnVpQmxYd1Nka3dmWE5FMTVHeU9WYXZuZElVb2FJ?=
 =?utf-8?B?Zmk4Y21yNUowVzlidVBiSUovczVHSjhLZFNLMFRVT3psNDMrYjBFajJKWnp5?=
 =?utf-8?B?MFNSNUJJZEpQM3lwQ3E5cTJBRFBhU0tCMXFIZis1emJJZ3ZXNkFxWWlFYnNU?=
 =?utf-8?B?Ym44K3ZXNHZ4OEhFYkc5YXNTUG8rcEcvZ2hkZEJZYXQ2OC8vUGdmdWRLZlcv?=
 =?utf-8?B?QTZzSGgrcnR2MW9jWjExK01EODl1bmk3dU5TeHlFTFozSDhxSTZldTJEVWhY?=
 =?utf-8?B?dmNvbzBNSndnNXVNekJHbk9QaUppTnhhUUVwY0oweHdUNkREYnFhbWRZamJB?=
 =?utf-8?B?R3RDdGJaRjBwUzkvYlY1REZmTStxbXIyVUY0SmdCdTdlLytFb09YODNKTmIy?=
 =?utf-8?B?bi9Ib05JMnFWZm4xZGpKd0oya1IrSUxKby9KWG0zL2lpZEJPSDdWdmN0K2xE?=
 =?utf-8?B?andSaEx0ZlVWNncvbjUzNDFleXZubmdNaFJLTEx4eWs4NGdCSE40YlQwYXZL?=
 =?utf-8?B?ZnRNOCs3eDhsUE5ReC9kYjUyc0JTTnlDeGRsaDZxcDZEL21oOFpNWUYzYWpQ?=
 =?utf-8?B?Rm5LdlcrYnNJenFPdFZGcVRBaTlPYWxZZDlEcFJpaG9RVXhHRXBwMUJ3d1By?=
 =?utf-8?B?c2Y3aTZMNExOMkFhdlliejBXOCt2UU95YmpsUkZvWEJyRks1N1ZqWVFVTm9m?=
 =?utf-8?B?ait5ZXNQMEVXTWFoVlk0aC83U3VtenkzUnBQWC91Ym84VlRHdmpkK2U3emhj?=
 =?utf-8?B?aXVjc0tOYTFEOFIzdDFpNmM3WTNrYUs4R1FBcGlDMGI4M3ZaNGp6Q3NXeTZm?=
 =?utf-8?B?TWg4NUxtcEVTVDF2R0hCWXRUVWlPRDlMeEloblhoOUZ1VnZWR1FrUWtXZlhm?=
 =?utf-8?B?VmppdmJRY2M5RGhkSWtYdmNhbWxsUGFRMU9yY25hS3FkQjQyYmJwZ0JwR1BD?=
 =?utf-8?B?K1A3VE9kWU1ZOW5ZMGcyM3BuSm04aFE2NjIreTBvWCt5anNSeldabHlabWxp?=
 =?utf-8?B?UVEyVWdxRndPNU1WU0ppQ04yYm4wVVY5OVFtTzNqZ3NIMnlOTTZNQStlNzk0?=
 =?utf-8?B?Unl5MU8zZDlLVWFpamVUTGVXdzZwanZzVm5YNVNsVUNUeHRnRjF5TzV0eU1U?=
 =?utf-8?B?dWQ0MDVXL0U2bXlyVkQyMFB1SVBIQlpLdTBDdXptak4zLzVYRG1hdFhld1pJ?=
 =?utf-8?B?VFBBVm9NTGZOVkVWSUNHa2lVYUljWUdlTTJSVnJxTEJ0dUxEdWp0TUpvUWFB?=
 =?utf-8?B?djdKNDZ4LzJ1Uko3NnVoZXFUWXUzQUVRZExSN25ZRTh2M3hQV2NaT00yWWRW?=
 =?utf-8?B?Qityd3ZhdGVBdllKVDBHV0xmMCtzNHlNNnU3eEJ2aXg1SEN1b2FPVUZtSVVO?=
 =?utf-8?B?MzRNM1owSXk0ZGJlMklqczRXR0tWK1VZMS92S3o3MlpkSmhkQVJuR2JFS1pq?=
 =?utf-8?B?U1R5Tm0xRi9YRXV4cUNtTGJBbVlQam5obXQwcXhZSStJR05OTEtiQ09OS2V6?=
 =?utf-8?B?QTRUcTJUaGdLM0ZQaHBnSEt0MDhKUXJFcGtlL3NNVktZb3pVWlc0VHA5a1Ez?=
 =?utf-8?B?c3JXWXBSVk9XMXhyUjM2VWxBQzMyeDRjMWRra095aXVFUVluWVNSL1JUZjJh?=
 =?utf-8?B?YmJGVkxVdmVIb2d0RjFmLzM0aERmQnAzT3g0bzRPeFJaOFQxbHpTbUJUM2Ja?=
 =?utf-8?Q?VuBlZK6k1X6bcoe0hUqzw7fkY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6fae1c-3c22-46f9-3f61-08dd040c4be9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:55:01.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpjtQbcLhkaJFmQgbacT0DnpdNBju2g01+ifU8/nxu9904p+2lyqjfNsQ3MGXUpVUJ5S3hjNkjApvdTRXiMFXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656

From: Han Xu <han.xu@nxp.com>

Add compatible string 'nxp,fxls8974cf' for the NXP FXLS8974CF accelerometer
sensor.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index c375ef1bd083f..93985f670aa7b 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -15,6 +15,7 @@ description: |
     https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8974CF.pdf
 
 properties:
   compatible:
@@ -24,6 +25,7 @@ properties:
       - nxp,fxls8962af
       - nxp,fxls8964af
       - nxp,fxls8967af
+      - nxp,fxls8974cf
 
   reg:
     maxItems: 1

-- 
2.34.1


