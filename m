Return-Path: <linux-iio+bounces-18557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F56A98243
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FBF44148C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB626F465;
	Wed, 23 Apr 2025 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ge7ECr7C"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E826F44D;
	Wed, 23 Apr 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395276; cv=fail; b=EGx4jxHPS22I+viCaWlOb1qjfcGMPyRKdzt5mGa6JF3QvP0tbMGzoN2eqrW/FBl90a/rAWYrc5OPbxY0+1ZsJXbGAXzNWmkiBb2rAh1v73HULpfuCSD354kldAtggo3op0mhFr7XRk2+nIz5BsNxfROF7D88Ki6hESd9TsM1py4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395276; c=relaxed/simple;
	bh=t2jDuLe1YchmBoaRAfzrk5/9vvzpLLnbzsItn7WNz9I=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=kXD7NmqHeCirxputSjkw1tPU4/oHQpGkH3yHKKZQntWMFt2Jr4ny47eQxMCAP0eCi0O3bxD9KJGXSupBCvfVYxYoZBcLdpeWzbEGQ4fm3xkBc+LqXfGEwfaaYCZBvfqMe7MFJmhxow/7cWiwkNHss/X6DWss5E7uUyWKV46lu1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ge7ECr7C; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFET0IVen1/HlHjN732Q5EQPdiKST1WntxMk5sz4NkMIUy/2VwtfFGuCkj1qbg5DEp3s1zEITmrBaTTzn5r2Zb4URiwQG7flqcaMxmUseM16tozU22u3eaCPY8B8z6nMRV3qoOcq0a7zGFc+8dsIOuleySAI92U1/+by+bu9Wr2HTvyFnaBhGcCZR+VQ3T067M2Tz4E9XaE9mcNIEK8SHKh57nY0BLRcvJvq2kJzcrm0+yz7J9g04xs9pIpUA3LmUyLDGKdLpUWYLreKsFRWptt9/j2zCT7CFNs9Axb9Lcah1ruwL/hlv0JDCX/Pne9pbso6w7MP1WtCu8gdShJggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYu49f0xzQqyVsdq/NvR/H8/kyPJ89r2Xvl6WXmAZRg=;
 b=qIgYXUCqwA8ip/8FBIqXu3MbTt/rI9IW3KfLBI5J1xMfZMRfArL+ABY+TdBbYirq4+WzzLWCC8UnzDA2J10UFc1d/r2tO/YKpCr8/UFdT9/wpIK/4eLR1wJzmvqh8KTCpb4HXOtetbSwaeWjMTfOB7E1r+GlgXnSH8Rfns6kF+KmjwZZe0jYs7S/+gAI1CoUidcP5LhaH8XRj6kRL9IGbrQ6s5dq5o+HeoaHE5EgRlDPxLaAYZliCxc8ZvL87xJQcnflA9VYVvjVPHxNvIIbumvzV9N19krk693wY1wCK5ekuzoqoGBdnBe5Eqq703xRkGWeFTMoUJTCUtPcz9Bfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYu49f0xzQqyVsdq/NvR/H8/kyPJ89r2Xvl6WXmAZRg=;
 b=ge7ECr7CfQVbY7b4JckPMs5gf6QYocwycMBVt2KOcbrnwY83MxuXaQKvbZQ+0Zam4AcJtRrx6HzMAyoGAXzicurCRQulxo5a6RRcz9hmNEo3GlutD48GNNp9A0s2BBfGa2QJ+Lue61RkXE1G3QRKcNYGQExi4JBRqVZg1Wqq1ZlMXTJyjAKyQE6+/DbCeDv/cwb42tIw3c0c3vr/TsMcPQnphSbqCxOTswag1b2q7s5OmL6KAakUPPMISxE5Ag4nIJxKE40FY25ynVkYXRryVkJusl3It0KxthhbaEEWqjwuqDb2visrZ4gh8vAVDzFMeabF1g4XjZzE540jnLcobg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 08:01:10 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 08:01:10 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 23 Apr 2025 16:02:48 +0800
Subject: [PATCH] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-adcpatch-v1-1-b0e84c27ae98@nxp.com>
X-B4-Tracking: v=1; b=H4sIAKeeCGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyNj3cSU5ILEkuQM3eQkU8tkUyNTU0szQyWg8oKi1LTMCrBR0bG1tQC
 8Uw7hWgAAAA==
X-Change-ID: 20250423-adcpatch-cb59c5255961
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745395391; l=2740;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=t2jDuLe1YchmBoaRAfzrk5/9vvzpLLnbzsItn7WNz9I=;
 b=1CoOrnu+mMs+Ia1tG+AyFrNTstzNkGpHtf8Z7CZD2r56BZOESsSNC/J14HVGoEq9Adpku91og
 /q3UY6edMq0CfuE5t+gSv0DkayAEoRHHK107eMQjdaBi9G4OamyncKZ
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b9a433-4062-4cba-437d-08dd823d0274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1RlK1RjaUZSV0JucDJJckU5N3Jod2h2bk5QNDAyUG1sNlp5elpZTW9hVTE0?=
 =?utf-8?B?RzRBa0NIRFFNNnpDeEJvdWNoQURaNURzZTJpYmFvYXJiMEQzb3lNOWdmTnVZ?=
 =?utf-8?B?VFdrcW1pbVl3TVZ3MU9vdzlqakNCQzF0eXVLaVlEcHE2VUxxa0ZQbzRockpO?=
 =?utf-8?B?S1ZYVU1CNXRwaUNJWFBqdXgzWmxIWHNLYXZuVFppTC9Wbml5VjJVZWRSdzQ4?=
 =?utf-8?B?eFpjL1oyUjBIZDlUQk4vcjF2TkJNdlNVbmF0eFg1V1krelVxM2tuMVJscmo1?=
 =?utf-8?B?SU81UUs0eHV2cFpRSnNETmFIcjAwdGRoejU1eklCdEg1dncvRC9KOXMwNXpI?=
 =?utf-8?B?UE1JV2VwdmtQdWQzWjRSdzZ4RThyOCtsQ0wxWCtwRUpreU9LSG05QmhLTFpE?=
 =?utf-8?B?UHVPZE5pcW9DM25zMERIbEoveTVGRFpueFdzRWJhNlRWOUZpZlFqcWlOMSts?=
 =?utf-8?B?dk1nYU1VYUxrMmRTUFhsVGxJdXZSWEg3RDRSa3ZDTmdHOHpjNEoyc1YzZnJE?=
 =?utf-8?B?VTZnemFtZnFBZm1UOElWNzNheEYwcC9iZEFTbzBKekJOcTd2a1lLYjdVNzdp?=
 =?utf-8?B?bmk5bisvQTBZOHBiNkFEQXJXcnJqc0h2WFluTjl2ZXExT05kRE9CNm1qS21B?=
 =?utf-8?B?eFo2MCsxYTlOTkROUWhFa2dBWGN6T3pVTDIrR0o3RnhvTHR1eTJRSmQvN2tS?=
 =?utf-8?B?ZEZnRFBsS3BSb1FvT2FxckZaNFA2OWZHRzQya3VrWTRPQ1lFaVM4bXBCQjlm?=
 =?utf-8?B?ZXpDaEZDaXJtcXRzYlUvbUE2bGNDUzRwdGhnRWV1bld0SzVWMG1Cd0lhWnll?=
 =?utf-8?B?bVZERnN4NWRDV3FMY0x0OENwMDhGWitpOEthYXY3aDF3YzVaRjNmTU9IWDQ1?=
 =?utf-8?B?ZjZSQ2ZZa05ZSDU2SGxGbnhNZC80K3BlYTJrWk9LdDV5V3ZQN2FmeXJXZWMx?=
 =?utf-8?B?aUZCSlpxMzNIbDBWbGhBSGF0Uk9ZaktBV1FMZy9UazBiZ3RURHhDRGMyRmtk?=
 =?utf-8?B?SlRtZEduZTdlNXNMME13OUg5NGExdFRuOG9LeVg4aUhUWm91SG43cGhMRmV1?=
 =?utf-8?B?TzJPRzRsWEd3NnMzQ3Q0QmZxQjlLMTFLOWdUVUVuTUx2bzlSNGdUcUdackFo?=
 =?utf-8?B?bmpodHZDaUl5TXpHUzZxRzAyQzI0NC9qbzdkSUY5MldnajQ3Wlh3L2djNzdh?=
 =?utf-8?B?L1pXRVlVTWUvWkdvTnJGVTIxMWlaNWUycVZGL1VYNWttYklrUjdYTG13T1do?=
 =?utf-8?B?VHhEWll0cS9vQnZGWmROSjgzSnZkeDBaMzRtZlNJS0hBZlFaSGgzN0JLVFI1?=
 =?utf-8?B?UHhxY252VjlkTHNsWU1XY3hsRDIwaGZJZTFadGFOUHk1OE1WUTVRZHBQZU53?=
 =?utf-8?B?MS82UEZ5cFp3aFdIRndoWjZCTER4WDFJNTl6K1VMemJpVDhVbFBkUkdUT0VE?=
 =?utf-8?B?OXc3ZTFYWnRudno0aXVRMll5MU5paW9GZDhPZ3VzTE4xcndxeDFDMFgxYzhJ?=
 =?utf-8?B?Ynk1MzYyamxlaGtrNExFUEYrVGU2SndBL0YwM2xRVE9LTm5FckhJQjE2bjdU?=
 =?utf-8?B?M1R0ZmdwZHVQWVdpNWRKaWU4MFVSaDZ5TENIUXZsNjBweStaYUMvZ08xd3Mz?=
 =?utf-8?B?dmlvdWU2Y2F0NER0ZkFsTXlJak9vcDZsVlJ5MUVjYjlsa2xqa1gyd3k5TERx?=
 =?utf-8?B?Z3ZjYXNwcWVhVlBLQjNPeHRLci8rdXFVa1htbTF3aUFseXAzakdvQXU3RHM3?=
 =?utf-8?B?MlJBVXYrQjR2SUk0Vkxpcy9taEtLWW9TL1BUaTRzYUxuamNJZStBMmhxREFB?=
 =?utf-8?B?dk9ZQ3BwV3puWUpBbGVFdVliRTdTbkZhaHFHQ2pzeXJhSXBjRE1CSUZ6QVJO?=
 =?utf-8?B?WTZzZ1hNWTJSczFyR3NjVi92UnIrbGx2U2cvVER3NCtjU041aEpPMURUV1dW?=
 =?utf-8?B?NkNvTUR6enRKdTVQMEV1L1pYRmRSMEo2M05TV2R6eStKY2FPSVZkWnZpKy9U?=
 =?utf-8?Q?xdG5R0aqixjuBrXrfPfuHaMn0g7A6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2REZU9hb0RDallzaEIxb3M2SkdZc3VtWEVlWWVPdHcwV1RvMnp5d2NmUmtW?=
 =?utf-8?B?L0VyUWowcGx3OU1ROGJYTWpITjZWTXJseWROUi9tU0lEaVc3M3NTVlM4eUVl?=
 =?utf-8?B?bFBYQlRjeUV1RlkrZnVHMmlRMVRJcXlxQWtiZFlwZFlxaVdqbjd6dy9LMGZP?=
 =?utf-8?B?Szc5T0U5S1c0WUFPd3FvOSt5NjhBWmxldjJkbklvTHpaOUtEaVh0NFdEdjJN?=
 =?utf-8?B?WC9wNjVWaC83VVFnejhpVzZwRkhtbGJaME9pK2RGQmZjcmtISVV5NW9rUkhr?=
 =?utf-8?B?RGVqcFdvaWt6ZW43a0kvSWlZQWRDc2JXRVVuajlVQWVOQzFzblRxRU9aYTdF?=
 =?utf-8?B?NnQrcVFrZzBZVXdkcnVabHdtdklBVnlBT0xld0lZcXh4bG9ZY0I1OXN0N1JD?=
 =?utf-8?B?NWRqT1NIQU1yUXZWdHJ3OXlPbGN1RWNVS1B1UmVPRUhsbFo4VFBQTmszcGxx?=
 =?utf-8?B?c2JKZDNGd0pjTm9HUzBjRUpvVi9BV21VeGlUZERMUXdTMEZJREhOdHNWMFcr?=
 =?utf-8?B?ODN1anRyRmxXZzNIcWcvQUVXTUhhWllac0dPV0Z0Vjk2WjhZQjl4YlNSY2Ny?=
 =?utf-8?B?NWJIa0txTzQ2M0o0cTZDcXZXT0VPM0dJS09CQjdkcUlWUmxpQjVjK01ZNlpW?=
 =?utf-8?B?VlNaWE1ZUkI2ek1Nelpnak9uYkJJa21jU0xSMkNFeFUySjVUajlhNkpDUjBl?=
 =?utf-8?B?OXEwcFJMb3F3SHRNYW5MWmh1Mm5aQVJzVW1FalZiZTdYUEtxNjhGR1VKMXRW?=
 =?utf-8?B?aTFxQi9FbEtLM0pSM05OeDc0d1FxL1JiSGptWGluM1dsOFVBdnpKWWRhRW9h?=
 =?utf-8?B?eHVQK0pyVTZYNm1BSDk3WW83cFREVElWVkpXYzQ1NU1UMjhjS2Q1OCszQjkr?=
 =?utf-8?B?aEEzcGJoZVhiV3FOcHZQbThMRnhpeVJkTVcwa3c1RURtaHZIV0ZxYVpaTHlL?=
 =?utf-8?B?YWFkQ1haVS9xTzZKT2c4MzEwb1ZIaFRuSCtVZ3huVFkrZUZpckhjc0RzNUFX?=
 =?utf-8?B?TzV0VzAreW5JZWZHSmRXbmJNalVQa0tKT1dnV0ZuUUFLZ2Mvd3Q0eHlSdjBB?=
 =?utf-8?B?TGNZZzVpcGh5SExrL2toUXcxaEZjcmRPN1Q5ejE4MlhlbzFFcDRNdnFmMUQ2?=
 =?utf-8?B?WUZSYVN2RzFJU0RGY1NFbXd0aHQ0ZGpNdmNORVo0ZG5uRldlUjNlZG1MWjZa?=
 =?utf-8?B?NjVSV1VieCtzTnBUVHVDanhVR2VTOXNOaTFkVmdRb2FOT0NqQ0xYUGorOHhj?=
 =?utf-8?B?L1NDSjNvTVZkdURrL1pXTHhwMUVNcmxRNjMxVTlvRWVpNFY3elczUHRrVk9m?=
 =?utf-8?B?SEk0SG1XMktyOEM4V1NWUm9XcUJ4UVQvaFp2UDVxVGRiRC9wUk45cTVSOWZM?=
 =?utf-8?B?VktXemEySlo0eWRzUWpiNnVUYmZQQ3RqN2paWGlKdjdlay93aE5kWExuZi96?=
 =?utf-8?B?NW9PbnFST2U5bTE1T1dCUDZaMWc4TTRzSFVPWHpuaGppQVpzMXprVVRLK2tT?=
 =?utf-8?B?Q2c0SU15M3Y2c0kwQ3NESXM4ek0vb1lMTVoyWG51MTNuVnhrQ1lISGZOZ25j?=
 =?utf-8?B?bm1FU3AzZEMxUHhxKzNLNjFyREdOTkpGb3h4YlNnSDZ0cFRnYTZUMlRBbXR0?=
 =?utf-8?B?SnlrZnFWUTJhYlY0d0p3MGpGb0hoeXowQnkrcERaUmtsbEZ0K2pZMldYbUc5?=
 =?utf-8?B?eTRES3lVQmpyUmhOR01jaWlwSzBxSjcwZm1CYkZXVEtZVFNqMStlNjZLYVYx?=
 =?utf-8?B?OURnVStSa25Ca044VVp5eVJTT0NMZ2hHTzdGMTZBU0x2WDVXMUdLcTZ1VDFw?=
 =?utf-8?B?a2RjNjdwbkYyNUlRbUxJV09wQTFvMHhTbGlQbHJ3b1ZMZU9wcmM5SHVFUE9n?=
 =?utf-8?B?RzdFWHdYZFkwdE9GNmNTYisrNDZGUzh3SlZBTHJSeFdDS3hhOFpFeVI4ejIy?=
 =?utf-8?B?VjUwOHpoTmdnWjFlWmpUMFdxVXloa0diN2FMeEc3MlhwZzc3Z1ZOSlp2amFL?=
 =?utf-8?B?dE5vMUErR3ZYL2VFMXNZSDdhVVdrOXRBNkNMVEVOR01qamJYd00wMlZXa3NG?=
 =?utf-8?B?RGQrL2VBZ3ZvR1ZDMlZtREZTUUFkL1h5ditoZHZtQjlENGFHYy8vVnova2xH?=
 =?utf-8?Q?781xjpU41AnTX1FlvyPHTC2fb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b9a433-4062-4cba-437d-08dd823d0274
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:01:10.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W216Op5fWDkHE3TJnqiyx2IbA+NNa5tSqMgYqXGU2cTYWYUk4Ubq0S7InzyRVmPFtlFCuCNRaqNWiqS3p9BBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

ADC calibration might fail because of the noise on reference voltage.
To avoid calibration fail, need to meet the following requirement:
ADC reference voltage Noise < 1.8V * 1/2^ENOB

For the case which the ADC reference voltage on board do not meet
the requirement, still load the calibrated values, so ADC can also
work but maybe not that accurate.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/adc/imx93_adc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 7feaafd2316f246bd0c32fea99309900b5c65099..ebf976db746f02431a315b1faa86f151bb67132e 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -38,6 +38,7 @@
 #define IMX93_ADC_PCDR6		0x118
 #define IMX93_ADC_PCDR7		0x11c
 #define IMX93_ADC_CALSTAT	0x39C
+#define IMX93_ADC_CALCFG0	0X3A0
 
 /* ADC bit shift */
 #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
@@ -58,6 +59,8 @@
 #define IMX93_ADC_IMR_ECH_MASK			BIT(0)
 #define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
 
+#define IMX93_ADC_CALCFG0_LDFAIL_MASK		BIT(4)
+
 /* ADC status */
 #define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
 #define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
@@ -145,7 +148,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
 
 static int imx93_adc_calibration(struct imx93_adc *adc)
 {
-	u32 mcr, msr;
+	u32 mcr, msr, calcfg;
 	int ret;
 
 	/* make sure ADC in power down mode */
@@ -158,6 +161,11 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 
 	imx93_adc_power_up(adc);
 
+	/* Enable loading of calibrated values even in fail condition */
+	calcfg = readl(adc->regs + IMX93_ADC_CALCFG0);
+	calcfg |= IMX93_ADC_CALCFG0_LDFAIL_MASK;
+	writel(calcfg, adc->regs + IMX93_ADC_CALCFG0);
+
 	/*
 	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
 	 * can add the setting of these bit if need in future.
@@ -179,11 +187,14 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 
 	/* check whether calbration is success or not */
 	msr = readl(adc->regs + IMX93_ADC_MSR);
-	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
+	if (msr & IMX93_ADC_MSR_CALFAIL_MASK)
+		/*
+		 * Only give warning here, this means the noise of the
+		 * reference voltage do not meet the requirement:
+		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
+		 * And the reault of ADC is not that accurate.
+		 */
 		dev_warn(adc->dev, "ADC calibration failed!\n");
-		imx93_adc_power_down(adc);
-		return -EAGAIN;
-	}
 
 	return 0;
 }

---
base-commit: bc8aa6cdadcc00862f2b5720e5de2e17f696a081
change-id: 20250423-adcpatch-cb59c5255961

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


