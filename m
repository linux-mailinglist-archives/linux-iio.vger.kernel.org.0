Return-Path: <linux-iio+bounces-24602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F177BAE743
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 21:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994001944F50
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78423236D;
	Tue, 30 Sep 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nr2q//Bm"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08413267F58;
	Tue, 30 Sep 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260892; cv=fail; b=Jpl0Qigd5o8yyQeoB1bEZr7WHXb0WZTkAR4B2DcpsUhcUykCeQm2b6E0x4B5Da9XspWkcayHKAB0shAaX4KIkd/VUj8vv3LpZqbqzAKpZ9e1NFcUadVR2i6WL9dUfe+JZ2h8kEJy4X5vn62sZLWjGMF1MYq+oiXlz8g6yFXBKAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260892; c=relaxed/simple;
	bh=b1FXz1XmITTrHJrziGulUAuz6krnV+qzTEmrbke/oHM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DjzcvwBhtCZsmcYrAAOJbx/tDu22oYLNRTjNGf4Ni9wZUWt48ZpY/x/X6Sh84IxqCVd4SUxM68jWQZwrRL6rgQD9J/BSpJshhX1JYFTjkuAhSHYuvx+u1z4r0pHVnPc3yDAAResqs+X0GPWft1LHtf6Iy9xvCkb235uPoWzx/PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nr2q//Bm; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIlk3xSSTNQrl0lK1dFpU9B7pGmtWgKd2gE83v+se70oMVx+E4SK/l8T/hqes2GK/bj2bo3PuEu+gwDbGeFrI/XrvWRQMMl28Q1FXgC9XBMZyp02xC82WOEi9zpBNiiJcxyDuPJU4wIzkBlZ5648qWLe9mwSp++OX59nqDiZNw274lJwrYOpkEmuPNQSBVnFStUnu9SiYXB6dQCkX5g2WeCOMHKTRLPoCoYzzARaB4LlfXnkWca6PpImsOkvW3OtyAkqPgBUpzjgeCrRScOyCQPpTlqT+c/tiAak+0aM+FjmeTkBS72bHfRKaV7Q96NMvVmfckCM1IWnmZso5d0g4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy0HbvsDfZ6wIEzoh3Y3FwKicG4gIIBodsn931jZSMo=;
 b=kqSSj0A0J31qYiFNuWCwSyvW7FoY53ohMN2+bNcuR1bZm520/GhfKzDcyXBtvvBOFp6d+BLhfrkHe/HF9fiM92OaX6Q4W5o7p56W4AyXET+wQU/v43QcfpdvuA/3+nkI2+Q/g7L5/DDxsl5ZebFlaExIdeNuLbBfU+yYBJ4f9BsfKcobq7yIx1MwqouF6XjKaQiHFwcNwx4IRiNZ7EEYRqVaxZTCZVS3XGyrjDopaL36FZCJoeaCnwWUWtbnZTy/uEYN7z74aZJlz2gE7MsS8qJ0aNX1iIo0glI7a821iaLvUfk57Cz75MZw2FoWBOBILYQx7PKH/qY4UdOybh5UMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy0HbvsDfZ6wIEzoh3Y3FwKicG4gIIBodsn931jZSMo=;
 b=Nr2q//BmFE9R65wgTRHQkk617R7YKj0WMQaLvgA9HE8RpysD9ALKN4k7cKLNqpyNNBg6Niy707T+/QJq1+r9UUQpduWAn0ZHQO9IDCd5KT7YD0vZMtCJqzTrNcmfNJ7hSJz/lIhtJL53mm6kk8Z5p5d3JtKf7MotCzT6C615vFdDoTDjuveffZfRQbgcae8k1FY485AYWUO65CFuIU0XjXp35obsKagOS8QX/A2g+y+C39JjpLEVuDBT+od5vES5FlP9HSUDrEe1Q4oF6tWEI5l0NP+1WVK+XhCEQo7Gc3dAfSUyA1DPMwGXVKpJELkkg86QESVKND+rSmeJgv1GTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10926.eurprd04.prod.outlook.com (2603:10a6:800:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:34:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:34:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/5] i3c: Add basic HDR mode support
Date: Tue, 30 Sep 2025 15:34:19 -0400
Message-Id: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALsw3GgC/2WMQQ6CMBBFr2JmbU07baW48h7GmEJHmYVAWtNgC
 He3sGHh8v3892ZIFJkSXA4zRMqceOgL6OMB2s73LxIcCgNKtFJhLVi3jxCiaJQ1ztVSUeOgvMd
 IT5620u1euOP0GeJ3C2e1rv+NrIQUEp2vvA1Go7n203hqhzeshYy7VaPZLSzW2aGX1Gi0Fe7Ws
 iw/+3zl8tIAAAA=
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759260882; l=2217;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=b1FXz1XmITTrHJrziGulUAuz6krnV+qzTEmrbke/oHM=;
 b=AQrLJk3LzT6VoqsSk8JirnSqA1nFJoOOnkyeWhMSKadS73KRhNaCIkpHpni+UxXwxpeu8M1rw
 V/BLOd9B6yeCXr2UVv/x6AkMQxMCTrzKtAHgT9ItHjPw1on+906qV0H
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6848efd4-1f70-4123-a033-08de00586908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejRHMDhGSEVUWFh4UUFCVDhRTkl1a2lYbyt1NHNaZjhRVDNER1lsY3dJeTcv?=
 =?utf-8?B?bk84dTQ2dlFDbEpTYUR4QjZKS0ZiSGJrcDVaWFZrclA4aW1MdnNvd2ZubndT?=
 =?utf-8?B?TnRCUUNOVVBFYk1HWndHcVEzZEEyRmpxeWw3WkF6MGw3Y2gzWFV4RjM0d1Bs?=
 =?utf-8?B?Q29iVjI0WkxlV3hNSytlbG1XVjRWS0JnZnpEQUVLSUt1NkVFcUFrT0o0dERS?=
 =?utf-8?B?a1psTDNhTnV3SVorTy9GK1RzTEYzb3gyNHJQTmIzTHVEcGVaYjN0SVpVZCtF?=
 =?utf-8?B?VjJ4STBrbFpwa2pFN1Z0ZkhKUjdObzJDL093ZVhEVDg4bFE2Q1M5OVVTYVdp?=
 =?utf-8?B?WHJ1ZUVWd05wN0Z1VnZ6TWh5OWlsY3AyaFk5dU5oSG02ZXVPKzZ1WGlrb1Vt?=
 =?utf-8?B?OHRzYjhhdUp1eGdqck54bExjTXJCSG4rZDkyTkdjT2h1bEgrb0dNRkhBM2Ns?=
 =?utf-8?B?MC9PUmVSNDVreXNxTzhVSU9pT01MYmtPQlJqMFNia2l5SzFkVU95N2E4elB6?=
 =?utf-8?B?ODRpT1YzSFdGTGJXY2dTSysrZGpkOG5vNTlhUHdYakpkakI4emZPMkZkM2xG?=
 =?utf-8?B?MkxtKy9iVnBiYng1dGhJQUdHU2dFYnIxbEVzbGNBWGxnY0wxVko2dWhWZ0dE?=
 =?utf-8?B?UzVkTUhIOU9ibTJRbU8xbThDOExOSmRJYWZGVHRUT0gvUC9UNTk5YWhMVjdo?=
 =?utf-8?B?ZEJzSnp3NHpNWERCTWxLaHc0WGdJbGl4V3BndlN1QUpOS3Z1aC9lQW5yV0pS?=
 =?utf-8?B?RU9ob2p3ZW9LcGFDSVlzSlpFdm1GSmJET1BKbjRmZ0ZBcU5pek8rV2REYVVS?=
 =?utf-8?B?YzIrY2N2UjhSRVR5TE5xNTdodWVFTTMyMWhKT1Qrc3ljRVowNjFQbDhTaXRM?=
 =?utf-8?B?bnBJWGFDak9lSVBQelBhVzllMUF6QjZaRElEODdFN3pvMzNwZGtMcWVqSXQx?=
 =?utf-8?B?N0RQamk2ckMxbXB3d0NkZE8wYStaVFdrekVKU0ZzaytMS0pXbDIrRzhoUm5J?=
 =?utf-8?B?NUM1Rzlhc3U3c1hSYUhWYjMxQXhUd0s2ZmNIdlgwUUJ4RGhoN1hVUHZjMUlv?=
 =?utf-8?B?OHc2YWg4MHBrb21QWUJjU2NtV2FXTkFzQ2xEMmlhdWo3TjJ2bGY1bitvcXlU?=
 =?utf-8?B?U0xLUXdVRXNQYjNld2NpU216OTY3a2N3ZC8vNGx3bjdjMTZ4bEtKNm5ObGtP?=
 =?utf-8?B?aGVmT3hVRXduaFRqYmprYzRyQ0JoSW1XbkRqSXdxZHdVd1BHVkh2V3VtWWZL?=
 =?utf-8?B?Ymd4UHc2WkN1Z3F3OCtHU3JlVUxMYWJ5TWZxTlNxRzhDKzNDNjg4ektnVVI1?=
 =?utf-8?B?dGNubk9uTXVHZ3JiUnVFZHpjOWVkOFBTdm1GVitTMW1GN2YrNWJJaE56eHFt?=
 =?utf-8?B?aFdzYXNTRkdGSUhLdUI1amRaUGt0aFV2bjJlL3BkV3VhcDF5RGR2UE5OTjY0?=
 =?utf-8?B?bUIxaHRFeitqTzYxZVlWdmd4UnBSbFN6SzhtYzk5dU5sRUhFTG4vQmt4Mkt3?=
 =?utf-8?B?SDRJOTh4WVlnTjJOMTQ0SmxMM3ZudHpnTU5tL1hRN1J6V1NJTFpuM3JwSXYy?=
 =?utf-8?B?K2w4QnFjRkhlOTJsYWN5TTVnWnVrODc3emplQVVVSEZTTGZDTlo0S0tIVnk4?=
 =?utf-8?B?Nmt3TFo0aWNWSnZiZzNNS0lxbndmcythLzJDZlpMV3pjNU5XcDRVNEs0SlZV?=
 =?utf-8?B?eVJ2cXhMa3hKVFpXZkcvSTR2c0N1U3hudUwvdmp0SzBMNmZFZmwvMFRyblhh?=
 =?utf-8?B?ZUlualF2MWJUcGQ2UjZDTFZqY0J3TFI5M1JLamRZT05uanM5ZlNhRlBtdWN5?=
 =?utf-8?B?dGt0K1RDeXZaQ3ViQVNqaGttUVNIKy9ySkp0OHcvQndZV1B0WGZ5M3JoMzU1?=
 =?utf-8?B?TGNFVnk2QVNYL3RZSjFvd2s3Vlc4NEw1Qmk4bWlTWU9zby9FcWZWRlpuN21Y?=
 =?utf-8?B?ZC9IR09rRW1mYTBrc0MwbnBZL1FqVGNwTk44Z0FEZFRreTZDTnhaRW4yc3VJ?=
 =?utf-8?B?bkhWU2RTV21qMjAzTlpCV1RIek1oVnRqeGZISU1SV0Q5TENOWG9NTU9tZGhw?=
 =?utf-8?Q?8cSt3c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3hyS2xpV2k0TGQvWWI1a3hSb1FMOU4xM3lTeXFLQVVDY0hjSmV2a1o0TThh?=
 =?utf-8?B?OUxTckhSemlHaGtZSGRZL2FKWGxKS1pkTVN0QW5hS2czOExNRUtrZm5vWXAw?=
 =?utf-8?B?UzZNRVlpa0V6SmJRT1N5dXBIZk9TMnkxVUlPTUY1MUsyRGhjOWIydzBTck1I?=
 =?utf-8?B?Y1QwTnlrWFJnK0QxVWlwYWNPU2M4VUhxVGdLSFBxeWpMVzZQNFU0TzFCQWNh?=
 =?utf-8?B?Slg1Q0N1TjY5NjlnZHN6djd6N0F2Y25seWpzSDBJMlhMN2lVd0tQaDdRbjVK?=
 =?utf-8?B?MGJ5aVRTaGFsNW9BOXJCcTJxaFZpeWNwcnMxYjJkREZDeGZCMzBwdVpXV2NZ?=
 =?utf-8?B?dURaUUtCUkFUZ3dxby9BemI2Tk1JNS9NTWdyMU1jdWVkWTFmZVVLV1pnNzZz?=
 =?utf-8?B?MnljSTVSajVURWVXWklkYVFObXVwV0tQd1htZ1NYVmNtTDNmQjFDa0VSUko1?=
 =?utf-8?B?MlJSSytYTDRTSXBtZXlCVy83em5EbFFjVWR2QWUya3FQZEdqUFdnOUZ4K2p0?=
 =?utf-8?B?MnJIMFdoUmVFbEViM3FaMk84YUJNcjQ1TnNKK2s4MWk4aC9mME5XVVVzT1dw?=
 =?utf-8?B?M0ZrZXdIRnpsSjc0aHFOa0NSOTg3MldJYWpKTXVhaHlvTzFFY05RbEJKcUhG?=
 =?utf-8?B?ZU9VZkpocHFldlRPVG15dXlKc0JlempSSWNHd3JDWXJyd3Ivd0JJWGErWGlm?=
 =?utf-8?B?U0I5bWpXR3dZOEcrMjdlMHRUU1ErajJzT1dlaXZHNEwvbERLdFg4dWhvcUpp?=
 =?utf-8?B?czluNmc0bUpsclVXS01YNTYwdGs1N2pyMXhSaHZueHR1S3BrNGg2NUlabGQ0?=
 =?utf-8?B?eVRsejRDU0Rpc0JRdm9TU1ZOMGFkdzBOQTBCUlBoZm8rNDVHVUFxL0NyemIx?=
 =?utf-8?B?Y1U4Y2djcnoyUkNrUjJ5RS8wckk3TUc0NVNuQ2pMY1JmRmJtOHBnNXNET2VO?=
 =?utf-8?B?UUFGWGtKMWwzMVlFZXVkdjROTFF0SkszM2FuMFBpb2g0RHE2T1ovdlE2amxl?=
 =?utf-8?B?QUhNUW9hRGM4N3RhNlIzNU1oZ2F4amp4bG55a3NHa20wTzFadGdMd043ZzJq?=
 =?utf-8?B?cXFFcGdzdHdCSnI2SkQ1MGIwakxqTzBCNlVEVkdkSjBzbWR6RnBXaC9DZ2JG?=
 =?utf-8?B?M0UwNDFXN1RUZ2lZOXVmRXU5bDdJbDRiMWpLejV6bjhPRXVwZ0F4QUF4YWE1?=
 =?utf-8?B?NWRmMVJ0QVNoUW1xTFlpU2hBZm84NmNPZmRGTjFTSHVwejlHcSt4TjlybVNx?=
 =?utf-8?B?YUU4NVhnQnZuNERNYmgxbFVzMzJxZDFHV2o1N2xTUVcrM2JsSG5ITDd5cGh4?=
 =?utf-8?B?MWhlcGV3aGZraUdPajh0cUdYUFRyM09oSWcxbTlhSVYvaklsemNJdm43aVo4?=
 =?utf-8?B?NlArUXBON0R6ejZmbmRkWHNId3poZTIrVWdXcndhZGRDUE5jcmw2amp0TVVz?=
 =?utf-8?B?NXJlNVFQSThYb0VHOW0xdStnSUdXQUFpYi96Z3pFalB3dW1VblhUdk1MNFRn?=
 =?utf-8?B?bXJwUE81YXk3WEpNUjRjcEp1N0JmSitEQWxUVWJHSW5oNElOUTI1OXVMYnFM?=
 =?utf-8?B?Z1h6YjliNnlPNXJPMHlCbk9ORWpOZkN2WnZRb0VJbjE1OU9zd2ZmR0JqUUgw?=
 =?utf-8?B?bWNOYTJTQ3dYSkd2cTJtOUNwanIrZmZ6ZnlBTVBaRVJ4eUJ1MGVVdVhiU281?=
 =?utf-8?B?a1dncm9VU2NlVWlyWFFhMVlJV0toVXRaS3ZYV3lobXYrc3o2M01PY1dXTUM1?=
 =?utf-8?B?RTg4QmxwR3FzQk5EWGIrWHBXYkNHaDBpRXRCMkRzdFlkTitQNjVxVGpHY3Bh?=
 =?utf-8?B?Qlc2NGk4NCtodDhKV2RqRXIxdTlpUFpuM0NQaktVeVQ2cG13NU5namdKdkVz?=
 =?utf-8?B?NTlnN0hmQmxROEd2Sy8xeEFxUHo0RGJwMGhtVk0yaFkyK21pVlJWSXJNZjBW?=
 =?utf-8?B?N0RXakpvdndmL1BOVVd1a1J5Qk1hOHYrbk9GclJnVjVFNS8rRUtBamdEOTdx?=
 =?utf-8?B?UjFveVZFN1QxZHJjaFFUS2hIZmc0MklKa2FvYnVHNVU3VmJJN2Rpb2lDaHRl?=
 =?utf-8?B?V0NVY0sxaG5XTFdCQkFlUVhSQTVOMFBSZ25UMGV3NEs0M1ZYV1hXK3U3NFVC?=
 =?utf-8?Q?bRT8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6848efd4-1f70-4123-a033-08de00586908
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:34:45.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3BHM68Fw29komaaBANHus6A6BG9qwYeyUY/eQIYEACDpyqUXVnUV+yHSiklL16Hbv1aVruXXeKxGJY532rAVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10926

Add basic HDR mode support, only support private transfer, not support
CCC command.

Update i3c framework API to allow pass down mode and extend driver callback
function.

Implement HDR transfer in svc i3c master driver.

Simplifed HDR flow is (ref i3c spec line 5514) Figure 129

<--              SDR            ---> | <--- HDR
START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)

                                    ----> |
HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT

Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
read/write command.

svc hardware can auto issue SDR part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- Add new patch for change rnw to union for svc.
- Detial changes see each patch's change log.
- Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com

Changes in v2:
- Add sensor driver, which use HDR mode read/write data.
- change priv_xfer to i3c_xfer.
- Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com

---
Frank Li (5):
      i3c: Add HDR API support
      i3c: master: svc: Replace bool rnw with union for HDR support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  22 +-
 drivers/i3c/master/svc-i3c-master.c                |  96 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 534 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  28 +-
 include/linux/i3c/master.h                         |   6 +
 10 files changed, 699 insertions(+), 35 deletions(-)
---
base-commit: 5248ab97a6dd1dc6856422f6b1595baaf4fa85ce
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


