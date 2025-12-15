Return-Path: <linux-iio+bounces-27093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6BCBF29A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F120F30852D1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667AA33F8BC;
	Mon, 15 Dec 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LbLpe3FX"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAD33F390;
	Mon, 15 Dec 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817497; cv=fail; b=O/iJRgUvJJZ6Vx8F8IMl9rygFzkHzbLrwFmCgI2OMSpcMEWvPpBlBHvrQqPRUrg6jAi+tmXQStLeXyHXO8qBo4NxQ+MIMlA+r5yWOzSzfcID70rbbnln406wu6N+QjGRyyYIIPCMjqRow+sIkr6Kr4THVvsGj19cn4w/Q3hEPXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817497; c=relaxed/simple;
	bh=jMurBC+laYUuovbtv9IGRtvg57bBsoupmO9b4DHzvv4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tZ2Mzt4uKwoaEZP1vtIz8WdvT44IxcCAGOwM/aXbJkt1zTjuwaPj6GhV4wzFtrccpZMJseEx9vD8Moei7VPRflIKfJMzRN891Ru6Y8yqgUFq8biTc80w6sMtbUErX5fEkyjbqoKVGR+/oFItdSdx2WaqNmNwBZWaaWjdC57JKaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LbLpe3FX; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHvxNA5YPsHEVvgob3Kd1OFMc7cQVU11SgFbrM6BCE0jYCam3XCa7MweqZneDf3o4/VUHwDz8akcAH5+EUjbqLk2k5KlPCfMF0sux4wB7y5BzpgpB9lAbSI1pEKVD0MTH7ZcXVI/YFUtFKssYtkyUCdl+A299Zl7R3oCJQUgBj6VX4BLUePn0vNeDOc0Nd2qaoESVO5n3u/fbsyd4c1xzGY5Nh+GlOsGB7Z+iefNiZmycnwPl9Zk1vF5S3YFvyb7sqaLrmpUK2lvRQkHxMGNFNaHg6tPriqhTbwjJ2agXC4IUrTzSu580n8BOe0UvZiJq22iz3U5Nk4FW3lvV8NOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o59iOsYckhSz6rQpA9/ezaxrYI+whXFs1N4aDdGGfNU=;
 b=Yx/rodWF8XGMNcv+ospez4K+eahyrvXak54pWXYwgzCN6hNb3QX31gbYdJDnb6VZed9w+DxqQ/Ca/9MXPQTyQazUVRzis3gFS5nAJ68g8fN40bXPPuwffJePXN4b6z8OWw60PhrF9ZI6uSHo2TEIO9Zk/ZYkaQO/9E61RCo82ZDs9+d9nrKitHFjEryzB5ah7QaR0ORr1hQcMxAnEOB87z7BDpsCZn8Vow9wAua0IczvLDgH1rMWd0oy2spssAqFxNAUNlD2/KlNPkliMvhQse3hAKz6fzuD4ecGhme2ukzfR6L8xEM2bbp7XVpEUZaavJYvzgzotpZLd9hHeVUtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o59iOsYckhSz6rQpA9/ezaxrYI+whXFs1N4aDdGGfNU=;
 b=LbLpe3FXzq908TOhLUCibdLIZwh+VVVfOWEHtLzy/rJKp9cceWzk6gxU0d4vvZ8bv+zWrCLpfVIMGNfXN5f0WOcxb2IYC7GuSbIiWtqDgSbrha1Qt1O42E8rWMquDo3Kq8ij8tGiUCSQNBSdjYDcD9Kl+LEkSSuQl0KnpGNCR/36FT/luWWc/q7kRn/GOIK4j99Pb8n5mAucCsg638ofMQVDujhZ/uQg0SGdcTRElriaLT33jgFuLuuCH3PUkvLqN65po6gu5BYM44UFWDMXAkmhse3Eivqpj4QLcLxZaFszWpYbybgOjhhAzLnqna8i1faZBteEL2OSXzLbjBdqLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:51:33 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:51:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Dec 2025 11:51:10 -0500
Subject: [PATCH v12 1/2] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-i3c_ddr-v12-1-1ae31225b4d9@nxp.com>
References: <20251215-i3c_ddr-v12-0-1ae31225b4d9@nxp.com>
In-Reply-To: <20251215-i3c_ddr-v12-0-1ae31225b4d9@nxp.com>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765817484; l=1253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jMurBC+laYUuovbtv9IGRtvg57bBsoupmO9b4DHzvv4=;
 b=otSM+9/w38/yQz8sSDU/ucMZSMCLrId6nqQ1WnhCBbrg827y8W/lgYUklxzxfBHK+q9Mffrrm
 XPBUlWSRQxXBFDodiVCMjTuZdz4GJ4boNOANCvF/6XjlCPU+dQI0afT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab04244-faba-4eb4-2828-08de3bfa33af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHdqREZZSW9TN2tSOHBKUVZhVXR4V0pnejA0NktlZklIZ3IxeSttRjE1aW5K?=
 =?utf-8?B?bHExMUk2VnNNNlVkZmZhMFVZbm9KdFZwOXpFR0NjRkU4c2xFTXk3T21lNkd1?=
 =?utf-8?B?eWNBaDlSZmdscXplaHVmdG1XSGltRk9lV0NuZnpuUm4zaGRDZjQ0ZTVON3ZD?=
 =?utf-8?B?a2JhdDdHVDFLZktZNDRnZXZBTEhOc0RnenVqOHJhblZpNWI3eW9haGFpc0hl?=
 =?utf-8?B?dGg1QnpPN2hxckVYd3pENGs0eWo4NFZwdW1FTzZ6RjZ3NlMxWkZEZzE0dm13?=
 =?utf-8?B?QzI5WlVtOWlBM2ZxWWlFUkNsQmh6WWpmZHhHN0FVaTd5MDdJbVBwQ25tZ1hu?=
 =?utf-8?B?RE0zU3RXR2xhWWd6T2prbVhEcklxMVBpM3p5RlJzdm5OeGplckQ1aVhoV3lH?=
 =?utf-8?B?ZHRUdGxhMDJvY3p3OU1vUUE0K2ZYcTNTRG5qaUl1SGMwUHlsU3AvR0dEMGZw?=
 =?utf-8?B?ZFVRU3BpaFA4c2lpajA0K2RhOTlQWGhob3c0dHpKam4xNGIzSEZ1azRJZFVo?=
 =?utf-8?B?bTBqSWkyR0xzblN3a1VOWFoxaVNIcHdoa0ptQ3g4TlQyY0R2N2ZSN1hIdTJV?=
 =?utf-8?B?Wmd3cHRJT1IvRXdFbmRlY2ZqR0VSYnorTWFkQ3NDUnNyMXFVWFF3Y3ZrWnY5?=
 =?utf-8?B?OWtGdXhYZjJKRlFHS0JHLzFUTi8xM3pIL21KWFZRQ0JDSnR5N1JvTXV5QjAr?=
 =?utf-8?B?TmxYZGZ4QlRnelZSVy9ENkVZZ0s3U1NtSHAzMHN5UUF4akcySHN4ZHlmMWlI?=
 =?utf-8?B?Q21Xa3k3WnEyYU56V1RYTHFOWE1zN3VxS3NtdjB1STUvZ0VBLzF1cmRWNW9w?=
 =?utf-8?B?VFRDbzFYMC9HQWhhdVhYNlluVmViTFlmaERZdWd4aVNCM2UvandtSWxzR2wy?=
 =?utf-8?B?SzBzeWozTHVSV3pOMWcvQkJHZEQ5bGlYT1AzRUdwU2l3R0RyN3dzQ2NENVhj?=
 =?utf-8?B?WWNiOTJiL3ZYTVp0S2hnallYRHRqU3gzVlduc29WRGFwNzFjTk1YMkNjOEwy?=
 =?utf-8?B?MlpmTzBwMis3MExiOVZNUjdsQ3NsUnEwQ3h6OWNNUXlxRkI3MGwrcER2Q1Nv?=
 =?utf-8?B?TlFkb3d2R1RKNk00VmVYdnBrdHRQMGM1VUhva2ZPeUVXSStGQkx4SUE2VXZt?=
 =?utf-8?B?d0ptbHZMM2hMWWl1blpldld0b2Eyc1VzV1JHdlRJc0JZYnRWQjJCWWVRcStZ?=
 =?utf-8?B?WW5NM0Q1N1N6V25Cd2RQK0xNWmVKbS9vMHlhM1Fsd29zY3E1ajF5MXIzVE0x?=
 =?utf-8?B?ZGJodlNrRkhUYkNCTEZpT2NNUjhVWVFaVittWjJ3YkdXYmo3NW8zYXB1bTJU?=
 =?utf-8?B?K3E2R1lydDRzODJsUUMvaW9CeVpndFdaM293eTVnNndCTkI3QWsyc0kraW1U?=
 =?utf-8?B?c3JEa1JITWlhc0d3Q1RQRWZqV2V5VzNiWjNHRk95TUFLLy96eHVMOUdNUkxK?=
 =?utf-8?B?bWJFbEpoaWZRNDVZY1JMTmE4S1l4YVpoakFpR2Zhdy9DZ01UMlpvbndRV3Ni?=
 =?utf-8?B?NFk4WXIyR3E3NXZJNWQ2ZFBFMDk1VVhxdXBiM1pZL21reUVBRGRNVGFWdWp4?=
 =?utf-8?B?dDBBSTBJcVFqSG10N2VxeXBsQ25JM0NOakM4UHk3ZHlrcm1SN3FsWFVKZGJK?=
 =?utf-8?B?ZkVJM3duTUMrbVRCRWZEWkdIR1BHUllYc2Y4Yll3eEFXUWtxK3E3RzFsTmhG?=
 =?utf-8?B?N0paaSs1K2luMFRneXdsdjU4UnRWM00ycFEwS1E5YU9XY2lOeENrdHFVdVpE?=
 =?utf-8?B?Q2p0aFVyQWZvQUtQNUx5Z2QyWS9wbzVxTFZsTnY0blBDaFk0NmRqajIzQ0xF?=
 =?utf-8?B?N1NPdWNFSnJORlhWZmpnVHJidVVveldrOFNQeW11ZFdBV2RkOFFhTkV0dGY2?=
 =?utf-8?B?azFyY3hJdG9Wa3NYeEVrbFhlWkZmb0FPQnk4dkhIM0RPRE9FdDlrYW42TW9L?=
 =?utf-8?B?andNL1JMcUs5N1F6VzRwZ215RmxDbXpVbnk4TTFJdis0cXJzQ2kvNXpER1hN?=
 =?utf-8?B?c0hTSnAxTktZYWtMNWlNTFFQWEZBMFk1MjVQU2ZBd0lSZVJRWVdSL0ZZc2Js?=
 =?utf-8?Q?TISlDy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUtaT3RqV1F2dWcyeW1tajd3c0NGMG56R3BjMnI0TE1UT05FM1E1a0YwUk42?=
 =?utf-8?B?UEtzbWVaWk1ZSXJnTnJRdHNMN2gvOHZsNlA3anlBOUhEQXNjV2xFRFo2b2Yw?=
 =?utf-8?B?NXQzYi92Smg0aHo4OGk5bDFseElpdzJvVWY1dTJlZmZsSWpMQmlJZG9TUEhP?=
 =?utf-8?B?VUIxbUYzZFd2aEEvNTlmNkFWUjBvdGR3d2tQMXBabEV3STFwZElPeXVLT2NK?=
 =?utf-8?B?N3ZVWWhKNTRkdWRpR1c5RlBXOEFseS9qa0FKL0VVdjNmdTNpNnlZMnJGMkhY?=
 =?utf-8?B?SE02MSt3NkRmc3V4ZXExSE82MUcyaGdwZFFacm5GRTRwcDZPMlJzUXhEUDZt?=
 =?utf-8?B?TU9rQWNQZVk4ci91U1luZUhxNGdUVEh4bENUS2JTMjlENXhwTlBDZ2d0UTIz?=
 =?utf-8?B?MUJKRkZCUVUxaXFuSmV4ckVNb3R4M250QzJLK1VqelJyeTFwMVh6WFJISE9a?=
 =?utf-8?B?ZFVGNGFYWEozT2JSNGZxZnhpTzZMcTFWMWhaNDlBWWoyNVBMcitySENFQWVB?=
 =?utf-8?B?b0V1QzBTeUNCNVVjRkE0M2o4TFA1d3BxVmJacjFZY3pHam9rbjBnazdkT3Fm?=
 =?utf-8?B?SGp1Wnh3RHZPYXg1VTRjY1AvQytVTldFWEZqT0Y1cEhXYU1zK2xLUWRrN1ZR?=
 =?utf-8?B?b1pTWkhCUDNJSDljNm10ZHdaeWxmUWtnK1lvaFZBVlVGeTBqamVvcFFTejRL?=
 =?utf-8?B?SG5mL3RGc1B6TlNOZEpoY1hsN0x4SWdaOHp4ZlBGSlRBK3pLN284R3RCQXlT?=
 =?utf-8?B?MytWT0UyTlg4c25pcU81b3NTR2pmdDlpUTEwVjgyTHo4NnUwL0wrT2VjL1hl?=
 =?utf-8?B?c2QzWStPdmwzSVRwMVE4Wk1HaTNMWVJmdFQvVTJldkdYcnBFeFVQQXhyeTFM?=
 =?utf-8?B?eTgxU3U3Q1lwelhlY1AycFZRUmRZRFJveEZOYlJ5dWxKaVliSEZWaUkxSXZk?=
 =?utf-8?B?Vk5la1FRNnR0dFBKaW1JaG9DeEU0SXZwMmNZSGF0a3ExY0NscGZxQkU4VjFJ?=
 =?utf-8?B?MCs1OXhnTGxBaWkwcDQ4ZjVXcE9MYmVTZEZ2bitJaEt5NGg4ZW44L2pZZUpD?=
 =?utf-8?B?cmxzNitIeU5HSkVYSkhrbmw3b0tSZG52TWRIVks4SjJJeE8xTHQ3bEs3Nm5L?=
 =?utf-8?B?THZQeXlhM21VbGMrQzdKTDQrYTkzZmUwWkt6VjdxcWpnTUdLNlV6eVQwaCt3?=
 =?utf-8?B?SnFPOU5mYTRRT080Y2R5NGV0SEhkY3JDbFZRTndzd1ByVW90L1JlbnlESk9Z?=
 =?utf-8?B?dE9BL1dNU1BJOFRKQTNFWUdjNk1KOGx0a08rY1dCV2hSN3BtOHJuek1zUDNO?=
 =?utf-8?B?OVhJb0dCelY1ZjQ1UExKMjFnUUlCM2srVHVXMG9qMTlvejBKWGhTbHRpdTZu?=
 =?utf-8?B?SHhzWGwzRWlIbXVra2RkQTZuVUNFcUp2UGYweXRWclhxVTZYSUJQVDlBY2Jj?=
 =?utf-8?B?WHFMYnBJRkZiZHA5LzZPS2lIUDhVR3UwUUMvdTF6SGdRVlhwSzIrbzRaZmNw?=
 =?utf-8?B?VHpTS1JuK1Rzb3NmeXhxcnpSVm1KTnhJRjZZVTRBM1JZSTdDZ3VKUE96YXRE?=
 =?utf-8?B?Mjd0Z0VXSjdSd1Ura0JyeUF3RDFCcXFQN3Y5NEhpNFA5c1FpSStubUdZZkwv?=
 =?utf-8?B?WncvQThiRUlQRThnMVV0VHc3TW5Udml1U0FSSFh4VGtrT0diMHhGSnJIUDVK?=
 =?utf-8?B?TUdlN3VzUW9JTHB5bXRHdXpPRXI3UmducGErdXVaREw4cDdKNEVScXpwQXRM?=
 =?utf-8?B?TkZXZG1ZZXFVSkJTZVFncWsweWx6WXFVWWkwQnF3TjhCeGV6Tk53MkJLZnZC?=
 =?utf-8?B?VXp5ZmU4dklkZHBkVy9ZSktGWVc4OFRIUW9NT004WmhJZldsK09OQWlEUVNS?=
 =?utf-8?B?ZlB4U1U3OGxiUG1TQWwrc1h6bFlzRGZWeWRDNUJ6ckROK1dUSm5ZdkVqeHFn?=
 =?utf-8?B?bjBlRkJ4N3JYb3hwU2Y2TVFPWHVHZC9VQVp4Rk41N1V5TGx1ZTBLMzlNd1dl?=
 =?utf-8?B?eGIzL21vb2tKRnJIbU5sMGxNYTkwWXZpVGRRM2tya2o2TVRvOEs2R2NFZUxj?=
 =?utf-8?B?bGx6MHB2T29tUFczQUVmN3NPL2tqSTcxK21LZEZRUGNhM1J1dzZpOWMzTHl0?=
 =?utf-8?Q?fDkbkWYN02AMMOGmfXKx6k/5U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab04244-faba-4eb4-2828-08de3bfa33af
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:51:32.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gUf5LPttuCYFCe+5Tg7yWYIw2tRltkruu8hN4w5hezfJnRpKpKGe+WxZs8ByAcWIeGH+g8JgQo38nkQWw5OYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913

Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
MEMSIC 3-axis magnetometer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7
- none

Changes in v6:
- add Conor Dooley ack tag.

Changes in v5
- none

Changes in v4
- add memsic,mmc5603

Changes from v1 .. v3
- None
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index d0f7dbf15d6f1d901688b4b529aaf2cf537addd6..055c9e2b7d475cef550ca0ac7d937254eb7c54b9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -229,6 +229,10 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis magnetometer
+          - memsic,mmc5603
+            # MEMSIC 3-axis magnetometer (Support I3C HDR)
+          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer

-- 
2.34.1


