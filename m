Return-Path: <linux-iio+bounces-25769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43511C2628E
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC84E1982
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23812F5A16;
	Fri, 31 Oct 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eYSv3Xnk"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576E2F5330;
	Fri, 31 Oct 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928807; cv=fail; b=BdpIkxd0OYL47Jx/YptZU8wbUzrEOkd7s8VEFlBNimYruprxXXXHUTG0++Cq8A4ztJOl/aFT7xPJl7qHUeM0fjfpn5JDyChDXEENgBnhgWZW8jdcm1uw+T2BdVDk3PNjM7MLn97KNPuwYfC+lG+pJTYVVjC692d3+0s0HngfhBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928807; c=relaxed/simple;
	bh=Xu8bp9V4hfsx8ETYTi55tKRQ6COWT2egdx/YMlh7Rpg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eLMls/kqck82BhDJWGdJmds5wHRLQfXMGAENX3d9SHuSBW29QPefoJMOeUn5nGYhr+Umy89My2WN+1YiI0tdO368wUylZcDVsRExkdOtUtqqAPSw/HNfe3MVeNsRelSlG6EYJrsSoy7DL0gWUiw37N9g7Nvw+8AzQOsfjkPTCmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eYSv3Xnk; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmSOfKAolwJbaF2G5838bMqsUU9QyGuQmU8DQUhYrxgpZy1p4+GfUda9KGDyZvI/LQ7inejOW5puPpULprByb8LVBSJitCPI/mCy0Etd3vsAWwH/LwXLMDwpACFRO7NHspUeRevC7bjSfkJ1qpMK97nhIvpqOrqrXRcaYKarTIHbl92UfB6jw+hUTLPm1cqzIKW/GgZvE2wDb4E8bQaHviudwghbDQALG5x/z7D/at08NYxMOORANHn0keUfE4qWvbGNznxIcL3If9+IGS270/lEmZJ3tCZtMkzGfJjRyGYSsTQsiBCJWGeuXRvQAXd53RIel/fXLb6s2+3UyfC+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OEKCc7tVnIacFKaPEeylBUa7U0P1wVjPQ/ux24a1u0=;
 b=v4Fmw7iHUgzbrXOXTVXY+leGFo0fvVq256bZ4rm30lD/hNT8yBEa7QczG0m3UfabbuhER6geC70LaBxrCVOfYikl4jJtadIHEmt+ulJqJBz+9c1hy34CdaXmywvHHTeHnZDolEPYqTjl3PNCKjMCXkj0v3zikL1QnYLHeoBiZAmXD4gkJqys1ZpSaXpsmu3JyUt58H3N77Iw9dtIT/Ves8nPx96u29gyDF9f0S0ZFwxOGCE73gRXfNFFeaiaQJXstKLeGNbzHJ1c6cbfKlgGyv0V04Z5m/yzrOl6RqE4t149hMYWRPVvMF6MfNC7edtXK0duSJVhwyLpOSgYWRCHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OEKCc7tVnIacFKaPEeylBUa7U0P1wVjPQ/ux24a1u0=;
 b=eYSv3XnkTziCoBeGFCRyBNq/gyTUbs87HVJcXSO1Ne8BCs6tI0FOPoncBwKRL0wJbeVv7NK87t94MiuSW9OCGHq2ri36tBd3v/s9+RB6I1rnEp959uCDSdyKExu7wE1Cv884xoPO4N0PnwBnHSMA2uN8L3xT84a+rMC0p4rkn9Nbwsjy8wbv637glTyDYUzigV9vHU7SII4WpSYpzzFzj4U8fPiwzVUk38loxX/kOoYo7A+5XOTDF/Emts6RnzU3Q+M4FEoprklunfwAj8MUlxeUO8yLh+P9jRgW/aWwD1ZgW30y5Ax601Vab7hR+KM7aaRJoEqn4DDRY8tLcSrujA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:39:48 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:39:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 31 Oct 2025 12:39:13 -0400
Subject: [PATCH v9 1/6] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-i3c_ddr-v9-1-f1e523ebaf78@nxp.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
In-Reply-To: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761928780; l=10620;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xu8bp9V4hfsx8ETYTi55tKRQ6COWT2egdx/YMlh7Rpg=;
 b=k99mgiHm35yxDA+jU8NbNEx0eUgpPYR+6zhNGcl7hoSajhcdksC4+brMk/KBNflfQ+QvwP5Uv
 h1QlR73WV4gDQJh++WQhl9KgJVO1HqVYQFn/MzEou12zNYetmeuwjcq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB11533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea950c5-09c0-49f5-a84e-08de189c1b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUN2eGcrUHRtcy9JU1RjOGtrL0kyMHdrRnNST3lzVTB0SU1jYmFCbm9aTk5y?=
 =?utf-8?B?MDRhR2phaUNvTUVrSXVNbzFnNEFJdDh1akRuL0orY2htR21oYXA2QTJKZjlH?=
 =?utf-8?B?OW4vZ3BqWEQ3bDN5bUtwQzhQTXFFYkdiWnBnN0g2K1kyODZadGUydmdRTkIr?=
 =?utf-8?B?NGtldUY2VUdFYS9zc1B2MVZIdmV0ZVNoaTFOaVJsbUo2Qm00UU5yUUcwdmgv?=
 =?utf-8?B?a1MxNjJlTjIyZDk2dkZCcmRoekp0QVdtQXJ4TlZ3OHpvVThMZjRQY2FXUExV?=
 =?utf-8?B?SWc5VUc3K3Y5K0J2MGlFNE9SM05PSVRNc1pKREdvWTIyRytzSStvenV2ditN?=
 =?utf-8?B?UXVCdFlaS3AyNXRFb2h2ZDh5Y0hVUEJVOVNMTVZLSkI0UTUyM0J0aUJzU202?=
 =?utf-8?B?dFVmaFFsUzI5TjBqL3pHb00zY0FZNTJGY3RyTmlqMzRqczZOZDdZRXdFZDZq?=
 =?utf-8?B?dmc0dWZya3lERVptZklUOTNtWFovZTRDanRvZ1dtem1mWTFuYUVDbVA2Nndy?=
 =?utf-8?B?U202VmxweGhPeS8yeHJ3MGhrYUVGNlBMVFYxOXRhdkw1dVlZS1luNk9UQmM1?=
 =?utf-8?B?bFRxRWVRVHdQVnkvekJuY0JsUEtoVFlLSVdmUnI1MEhiWXMwZUZFY2U1VGgy?=
 =?utf-8?B?SmlLaVVtK3o0QjJzOHR6citiLzdIS3BORHY4eVh4TWVEcysxd21ublNTNDFR?=
 =?utf-8?B?SUoxK1d4QTAwOGdKeG1jajFJSHRqakVFTVlqalZHV2RBblMyWDF1RW5OUGdF?=
 =?utf-8?B?Nkc2dG1YZUl6R2p4Q08vYkpwQ0I5V2Y1V0o4VGxJMzlJWldHcFJjb1JoUEpK?=
 =?utf-8?B?NDNmTFN3ODcvZTdWNm4rMXRlUmJORlRKcXNqU3lqNkZ2bTJCSVovNWxjZG5a?=
 =?utf-8?B?SVY1NE9pMmJHYWpkMGNGQ3U4aTB0akE2Q3RuMjR1OWhhK04yUVlyUFByV1pB?=
 =?utf-8?B?TEd5WUxaTXBVMXlIalhwYlVtRmVGNTF3Vlh5cmxadlhyVW4wd0RWcnVTMGVL?=
 =?utf-8?B?QVQwRzd4dUt4cGNpM3pvbU1MVTl6dXZFNHkwOVlCeTJScThtK2JzZW5EV1hH?=
 =?utf-8?B?UDlJZUNZS0N0SUEzbzF5ZjExMWN4bHhrYUVKSGhpaTRMbHhibDBiVDBtSUY3?=
 =?utf-8?B?YnBzb3pwZWNUM1k4S2xyTnJxR20xd2FYcDFNa1h6YW84a0YydnhXUVhSUHpB?=
 =?utf-8?B?dStXUzE1MmRRNDhlS1A4c1FIdUY4QVdzRTI4bVhOb012dXpEbWYreXl4NXMz?=
 =?utf-8?B?aVNJaG1sU0IxN3VlUmNkcmF0a01TMW9palczSEZ3elBWRTZBMVh3aWlMQlFv?=
 =?utf-8?B?c3JmclBwTlpHdElXS1RFYWJ3aWU0Z0dzL0J1aTloYnpRNHZ4Rysydi9rdzZR?=
 =?utf-8?B?cWNKbW9ic21JODRtTy9xckF1RUpVZ2pPRUZFeWNGNUdycUNVbmUvTjNnMHBV?=
 =?utf-8?B?T01iLytaMGtxQkFzNlRNUEgveldxZFN5bVVGVDhCUEZwcWp1TDlIeDZNV3Ax?=
 =?utf-8?B?SURxZUladlByNG9KQVN4bUZDWHNUcENoaGIvNm9uRGhYaW5KVDNUZDg2Ujd4?=
 =?utf-8?B?MGE0ODY3NC9qeTFGYlFmLzVIT3RRUFdoUFJ4Z3NxdVdFcFRSR0kvTXJzaU5V?=
 =?utf-8?B?UGkxZWhSRlN5U1JQV1R0RGxBcFRNN2VOS1ZxeVNGblRQS3BGWFhHdDFiWjFM?=
 =?utf-8?B?SjZSZzd3Y2R6aGx1c3BCTnQycDJYVnhIUENiT1ZDUjdLSCtaNE1yVVdaSTE2?=
 =?utf-8?B?WEFHakIySjhXQzd2bWttbTRONlk0dlVIbjJ0NVFuTTFObE01YVVQY0tMTEV0?=
 =?utf-8?B?MnRMUGoydGlad3d6blJ3MFFVTDFGQWMwUi92N0p5aEVwZ01GZXhyV21xTHBS?=
 =?utf-8?B?RjlFMnlkL1RkZHBuZDRYaDl6OU91eGYwVlpOd3cyWnVCV1QydW1jMEVXTkF4?=
 =?utf-8?B?b3RFWFhaMGFDZXBraldoYXRwck5rcVErN3RHQ3g3b1lZdStKeWlUK3pBVWhN?=
 =?utf-8?B?ZFR0cUxpbzkrTzR6Q0RCd3JNVmo0bjE3RXlmZnMwMDk5YzRnY2dacVF6Y2kv?=
 =?utf-8?Q?3XRn7d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0pNSm1aWnFSS1lCMzBRZ0dudGZGNDBSYUgzWkd3eWpnR0xQQ1NlWHVwZXVF?=
 =?utf-8?B?ZENqTVNoa2pXZGp6MHFCSnRZbzIyR3RtTjZSVld2RGtDbnpOOXByN0JERnpD?=
 =?utf-8?B?NjhERVZ5RGsrMG5hb0c1MEU1dmNRaDBjZHl1SklRLzhDVHNVTXVTanRkZUht?=
 =?utf-8?B?QXluL1Znd0pOWlJ4NzBCYzY5WkpuMStTL0E5OHprZTZRUGowUXkyM2Nud2FV?=
 =?utf-8?B?eXN5aUw2UFVaT2FkY0kvMEk2cE85d2lMaEs5N0FiUHRYaDd3NzZxMWdvc1F4?=
 =?utf-8?B?Y3lOYWdEVHpZUW9rTnhKZGRyaytGb1Rrazh3TkkxVzZNOUd2NHFpSEN3YVBl?=
 =?utf-8?B?eDY3b1o3dXJLYUJUdlhsREF4bUtJR05JeE9nNTBkVEtYUFAvSmZqRUhmL1dZ?=
 =?utf-8?B?VU5JL21ZTHRIOEhCV3N1bXc3QkhaQXM1UWdoZTZjRzczaEZlTDc5czdqZUE5?=
 =?utf-8?B?YU45aC9NVFJFTzNTK1htU05mUXpYM28wNEJyVWRmeVpaMmt0S2pMN0t3Ti9P?=
 =?utf-8?B?Q0JNOSt5andjVkEzQXgxK3o0OG1URzN1SUwzdG1hMlVpSis0eW5mSG5vRGV5?=
 =?utf-8?B?MDZCOFYxNWpjMUc4Wnc3REdmUERIdmJGUkZva2krMkFkSnFSdnJncktLUGdU?=
 =?utf-8?B?WHVYNDAyRWE2cHBUZUlTVFZLY2ZyeG1DSzRJN3FoTzBXRk1HeWI1MytwNVdE?=
 =?utf-8?B?NHR0d25NQU5hcWJSQjBHUDV6aTRJTXVUcW90TU1FZU9jc2lOTzlPc0dZa2h2?=
 =?utf-8?B?Qk9ZdXJqcTR4QWIrOGI5K3lIQXdPeWVzQTBlZkliRWlJZ0pEcVZWNnJ2c29t?=
 =?utf-8?B?R1IyazZnR3crdDQybXJaVUhCcU5HZnVtL0JvM0diY05GOS9hbnVhSG1wWnE3?=
 =?utf-8?B?WENIVXFYL1Fxa21BUGZlcW1LWkx4bHdLU1EwZkphbjBOSFdZK0I1alpna0g1?=
 =?utf-8?B?UXkzM0lhcUxXLzArc0JoVEVBUjNXcENZVlYxZDlySFFqeXM3V3BJYWlnQXVM?=
 =?utf-8?B?SE13M1lqNlRzZENVQTZyL2REdkl2THVPTjFjTXdEMitvcll5NHowOGZZdVI1?=
 =?utf-8?B?K1BJZUIxWkhzaEs2b1FjR2x0L1ZJdlpXNlNhODJOc2ZPcW16V3BPWjBaVEdw?=
 =?utf-8?B?QldBaWQxZVdOdndpc044OXJ2RGZFZlEyQld5am1aUHhDc2RUS29jSGNabG9K?=
 =?utf-8?B?am0xWEJiVlNXM1daUlFMWnh6aVcwRS9rOHRhd3dzNjdOdEl0QUhqWCtnaFZP?=
 =?utf-8?B?MGx0UUF1VDh6M011Z1pSTElBTkI2RFhqVndLa1hiVE9pUUhibWpxUUFaLzMz?=
 =?utf-8?B?K0t6Z0FwNEpxK1MvWitwd1VhQXpSK3MrZTIvMDRLeFJBUHhMdE9odG1HQWZj?=
 =?utf-8?B?OFdzUlp1YnErT09ocHlsUHk2WkNQc29TU3B2OFprVmcrNEV0QW9UT2hNdk9X?=
 =?utf-8?B?RXRqdXlldTlYVW1CQjBlTG5BblhXNWRHa0tud3pob1g0Y3RWaW9FbHovdGlo?=
 =?utf-8?B?Q0V5eXZDbTBBeVlpT08yTlBWYnczdy93aWJMbVFKS0dONHRPVHAwNHF6WG1y?=
 =?utf-8?B?ZWJGWGs1b3hPbFlxbDZWeklPV01XcWpXTDVnOU10eGZlM3dnVy9kT2JnWTlm?=
 =?utf-8?B?cStLVnI5dlNWWGZ0dkZxOFZ6MHR6U3QyVTdMa0FMMElLTEFuQzB6SVBNWklR?=
 =?utf-8?B?aWV6OGx1QklGWWFhMjFIck4rRWtaUG1tczlPaldnQ0psMXZ5TktwYTFTMnlE?=
 =?utf-8?B?YjloNnFLWld6UjdpVjFJdEF3ZUpzci9RN0FPam9XL0JzTnhUWFIzN1N0azdj?=
 =?utf-8?B?MTFuMjV5NGphSTROVFQ5L3Y3RENsQzJsR2NCWDlQMTJsUVB2Y1BCY1NSbS9a?=
 =?utf-8?B?UjdNN2hwMHVYbXNlbTdRdy9FZFBvT1dnY2gwREkxMXFlaStFbmVHTnN0M2hY?=
 =?utf-8?B?M2tBb0JlTHA0SW0zOWFBMi9RZnlXaTY5cmM1Wm9kNEpTbzlEZUc3SnU4aGNr?=
 =?utf-8?B?amZORDVKdXUzYkRWYkhmYSt1aEpJUEE5SEl5ZHpjRHhaWWRBRmhDbENzcVZm?=
 =?utf-8?B?YkJjSWZEbHhRNjVVRWxvZ1lsdyswZ3RJa1pWWDRZZzIwUnRoekpsSDlJQ0Nx?=
 =?utf-8?Q?Mdb0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea950c5-09c0-49f5-a84e-08de189c1b32
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:39:48.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqTJzJXx16Uo++M95/91RNTXMQDB0+kB45+vGVNWEr31TKT6EvXlowqaM02hC55aKkjXJ3z5GTM0CF+R+QCzJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
Technical Overview.

i3c_xfer will be used for both SDR and HDR.

Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.

Add i3c_device_do_xfers() with an xfer mode argument, while keeping
i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
with I3C_SDR for backward compatibility.

Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
'rnw', since HDR mode uses read/write commands instead of the SDR address
bit.

Add .i3c_xfers() callback for master controllers. If not implemented, fall
back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
all controllers switch to .i3c_xfers().

Add 'mode_mask' bitmask to advertise controller capability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
one i3c transfer. for example, can't send a HDR follow one SDR between
START and STOP.

i3c_priv_xfer should be treat as whole i3c transactions. If user want send
HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
instead put into a big i3c_priv_xfer[n].

change in v9
- fix typo Deprecated
- remove reduntant master->ops->priv_xfers check.

change in v8
- new API use i3c_xfer instead of i3c_priv_xfer.

change in v7
- explicit set enum I3C_HDR_* to value, which spec required.
- add comments about check priv_xfers and i3c_xfers

change in v5-v6
- none

change in v4
- Rename enum i3c_hdr_mode to i3c_xfer_mode.

change in v3
- Add Deprecated comment for priv_xfers.

change in v2
- don't use 'priv_' since it is refer to sdr mode transfer in spec.
- add 'mode_mask' indicate controller's capibility.
- add helper function to check master's supported transfer mode.
---
 drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
 drivers/i3c/internals.h    |  6 +++---
 drivers/i3c/master.c       | 19 ++++++++++++++-----
 include/linux/i3c/device.h | 40 +++++++++++++++++++++++++++++-----------
 include/linux/i3c/master.h |  4 ++++
 5 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..8a156f5ad6929402eb92b152d2e80754dd5a2387 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -15,12 +15,12 @@
 #include "internals.h"
 
 /**
- * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
- *				specific device
+ * i3c_device_do_xfers() - do I3C transfers directed to a specific device
  *
  * @dev: device with which the transfers should be done
  * @xfers: array of transfers
  * @nxfers: number of transfers
+ * @mode: transfer mode
  *
  * Initiate one or several private SDR transfers with @dev.
  *
@@ -33,9 +33,8 @@
  *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
  *   5.1.2.2.3.
  */
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers)
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode)
 {
 	int ret, i;
 
@@ -48,12 +47,12 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 	}
 
 	i3c_bus_normaluse_lock(dev->bus);
-	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
+	ret = i3c_dev_do_xfers_locked(dev->desc, xfers, nxfers, mode);
 	i3c_bus_normaluse_unlock(dev->bus);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+EXPORT_SYMBOL_GPL(i3c_device_do_xfers);
 
 /**
  * i3c_device_do_setdasa() - do I3C dynamic address assignement with
@@ -260,6 +259,20 @@ i3c_device_match_id(struct i3c_device *i3cdev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_match_id);
 
+/**
+ * i3c_device_get_supported_xfer_mode - Returns the supported transfer mode by
+ *					connected master controller.
+ * @dev: I3C device
+ *
+ * Return: a bit mask, which supported transfer mode, bit position is defined at
+ *	   enum i3c_hdr_mode
+ */
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
+{
+	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 79ceaa5f5afd6f8772db114472cfad99d4dd4341..f609e5098137c1b00db1830a176bb44c2802eb6f 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -15,9 +15,9 @@ void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
 int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers);
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev,
+			    struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode);
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 66513a27e6e776d251203b286bcaecb9d8fc67b9..30c5e5de7963c78735e96605367e9a762d286e86 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2821,10 +2821,14 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	/* Must provide one of priv_xfers (SDR only) or i3c_xfers (all modes) */
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -3014,9 +3018,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -3027,9 +3030,15 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master || !xfers)
 		return -EINVAL;
 
-	if (!master->ops->priv_xfers)
+	if (mode != I3C_SDR && !(master->this->info.hdr_cap & BIT(mode)))
 		return -EOPNOTSUPP;
 
+	if (master->ops->i3c_xfers)
+		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
+
+	if (mode != I3C_SDR)
+		return -EINVAL;
+
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..7f7738041f3809e538816e94f90b99e58eb806f9 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -39,20 +39,25 @@ enum i3c_error_code {
 };
 
 /**
- * enum i3c_hdr_mode - HDR mode ids
+ * enum i3c_xfer_mode - I3C xfer mode ids
  * @I3C_HDR_DDR: DDR mode
  * @I3C_HDR_TSP: TSP mode
  * @I3C_HDR_TSL: TSL mode
+ * @I3C_SDR: SDR mode (NOT HDR mode)
  */
-enum i3c_hdr_mode {
-	I3C_HDR_DDR,
-	I3C_HDR_TSP,
-	I3C_HDR_TSL,
+enum i3c_xfer_mode {
+	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
+	I3C_HDR_DDR = 0,
+	I3C_HDR_TSP = 1,
+	I3C_HDR_TSL = 2,
+	/* Use for default SDR transfer mode */
+	I3C_SDR = 0x31,
 };
 
 /**
- * struct i3c_priv_xfer - I3C SDR private transfer
+ * struct i3c_xfer - I3C data transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
  * @len: transfer length in bytes of the transfer
  * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
@@ -60,8 +65,11 @@ enum i3c_hdr_mode {
  * @data.out: output buffer. Must point to a DMA-able buffer
  * @err: I3C error code
  */
-struct i3c_priv_xfer {
-	u8 rnw;
+struct i3c_xfer {
+	union {
+		u8 rnw;
+		u8 cmd;
+	};
 	u16 len;
 	u16 actual_len;
 	union {
@@ -71,6 +79,9 @@ struct i3c_priv_xfer {
 	enum i3c_error_code err;
 };
 
+/* keep back compatible */
+#define i3c_priv_xfer i3c_xfer
+
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -297,9 +308,15 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers);
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode);
+
+static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
+					   struct i3c_priv_xfer *xfers,
+					   int nxfers)
+{
+	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
+}
 
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
@@ -341,5 +358,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index c52a82dd79a63436c1de6a01c11df9e295c1660e..d0d5b3a9049f0b5ff65ae6c5a7d59444b373edec 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
 				 const struct i3c_ccc_cmd *cmd);
 	int (*send_ccc_cmd)(struct i3c_master_controller *master,
 			    struct i3c_ccc_cmd *cmd);
+	/* Deprecated, please use i3c_xfers() */
 	int (*priv_xfers)(struct i3c_dev_desc *dev,
 			  struct i3c_priv_xfer *xfers,
 			  int nxfers);
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_xfer *xfers,
+			 int nxfers, enum i3c_xfer_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,

-- 
2.34.1


