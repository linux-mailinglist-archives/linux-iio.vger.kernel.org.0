Return-Path: <linux-iio+bounces-25990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39807C3CE49
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FBD3B78A2
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0534F48F;
	Thu,  6 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkwPMEup"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90C34C9AF;
	Thu,  6 Nov 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450595; cv=fail; b=IXpIMCbmycuT6ZS4LxqS7cCgiIp/mdglN8oPL9jplC6/EJlU9P6q3aF0FM7HxE4bgQJSO3XihGAgMPcR/HobA+4rAUSGlFB9jQ2eZh0R2HaMNQ/dnTcui1Z9eb1IIjARlV89+QBzD0etPQdxss8yY9zjetxZXx/0nbQEPS/bpKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450595; c=relaxed/simple;
	bh=Xu8bp9V4hfsx8ETYTi55tKRQ6COWT2egdx/YMlh7Rpg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=afSBjQmOL9hxcweIV899UD6pcKLYZcJabnC04Rwi+aHUyQlGo8W0q4C+EQZfuizzQQVD+UEN/yBXp/Yy0c+UyaaCMmccYhU2N4p0vHt+xcGLAW86COJSitYRMENxjHevOdWCDk+gCZ6YVuA3m1FQEaJMI8cVSexgsNQ1Lt3eih4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GkwPMEup; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGNR5Fyt5Sfnaq4Cd8rTFdiVUkK4wYZ06AbpNCE4hyNXCOwPcWAQU3C4ojsQT+r4T8CugaeiBnPe2UO9iTV/5u2WaMg0pLLuIoqfcUJuutEFxANDRny7M52eiFrvJIwx94QxniF1ypXP4UXb22jjb5/kIUhN3PDuitvqhqce4sD/bdVsBqoQm+X1MbaSuqRreq1ntl02DK7wleZwgAEX6Zuz8arX/ecmmRQpeQVIqFr6CfsfdjJR1Km6DiNr5RNVOkO/QWB0dahomhjM2t1ewYykUNxhMOmPaIR+XxrqHxjcDEJ7qOPpqc170WdtPUXUHeLVr3+oeq8Tb5SwD5zg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OEKCc7tVnIacFKaPEeylBUa7U0P1wVjPQ/ux24a1u0=;
 b=IfAyVoxswJlBwGu85wbSolUo68VOD1D6av1349cre55aw5irZq80O1WkiDWrrarnIC1ExANe6SnvZdVUMlXhJz4UQbr2ELZAMTOUHg1ehAmzs1PiRrvi1693CUK+kOVgcFFs6WG3rOuCRpLpiU4MfhcQXEKNQIkxtF4uckDEnEt7yfSJvN63YE+1MZcTUp2CC23YXxJjdTOuWR/f+lrByqN9ZIyiJU2SFYZVB/cjaWl+E4WtB4An1NgiHLa414nLnyyFMzzwHy0s5eqvesq4PZ8pVRGu+pxWMrUlp2btDwt/PS18WIDQwT57gE6nl7lW2Sgh5MjSYLVAUb6A07wYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OEKCc7tVnIacFKaPEeylBUa7U0P1wVjPQ/ux24a1u0=;
 b=GkwPMEup3nKoCyFlh+Z5HFfLI1HzXjkL8aI6QBZb4nZZuvjVgwQlJFUphWrwvVFAJjFwaqgOq91MnaemUYmNH3au5JcS1M86TBg1Uv2LgZX9E+hXqV41YO2dIeIWU34DQGxiON+bBim/arBjtA4Eeis9GlWaZPi9/sIQSrBQl9UDfWPri4PfAgB/yLvVkolChe2ZORjwXLfod6eOJvYNjAoAIpcnfWME6OMkEOQIZrDA0kRbm85aGaaZlXejKXYXXqDJvVnYg5g5NM99JXrYNNn6YcBHVzL5itdfMZH4MdEvwKGUQUg32GyiuO7hTwtS32kHTJSW0V1BQdyMPjjRmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:36:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:36:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 12:36:00 -0500
Subject: [PATCH v11 1/6] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-i3c_ddr-v11-1-33a6a66ed095@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762450581; l=10620;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xu8bp9V4hfsx8ETYTi55tKRQ6COWT2egdx/YMlh7Rpg=;
 b=iBRvaTdUTOWW84l2WENim6RKx8P2Wt9oegFU7hQRbgvy8E1TdA6id6KTo1Nr3OM9IaeG3BAda
 fWD7TUzD49sCw7Q6zwiONWJOtN9M5aYoR5IC7Dsvv4t+mCetKKWWeBA
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
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10989:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2ec14d-9d7e-4397-06da-08de1d5b0432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkFtSGxPMHRwc2xmTFZvb2M1Wm9qbkw4YTN1bXFEM0EwSS9Ca2tLU2ljT2o5?=
 =?utf-8?B?WUZkamx5Ym0rbklyMGNuZzQxRWFpMjY3S1NGMTBXRlFXV3VYblNqSEpqRXVt?=
 =?utf-8?B?RXpHbFkvU2FYa3hqK09IbXRUalg3bnNlYnhMNGlwVkdtVFVOK29KTU5sRGJT?=
 =?utf-8?B?Ry80RFZIUE9xWXVQL1VKYmorR1ZNWVZMcEZocmZhVm1EbU94R1YxMUVKSStL?=
 =?utf-8?B?bFNFOXRZT2Z0Ti9uT2lVcXg3RldqOE1USDlRS3AvcHdvamJRclNmS2dYLzZ2?=
 =?utf-8?B?VURJbGhXdWl6RUZSSDhlZzk5OHF2QlJoQTI0OHhjSzZoL05kUDUyWnBMQ0p2?=
 =?utf-8?B?Y2hCSDZMMDQ5TDZyeWlVeVRMQVRsM2ZqanJvUWhiTnM2V1czR24rNmljbFB5?=
 =?utf-8?B?U0Q2V2w2OEtmOHNTUDdiZ1Q4KzFRQmtLanp5WEVKTE9pODU3R05kcGIrbHVY?=
 =?utf-8?B?eC91N1ZoQndZckpRVTNvZ25DMXhCMm1WU1gyWVJJTnBGR3FwdmxBbjFLTTl0?=
 =?utf-8?B?OTJMbmM0VDBISWtEY3FrNW5PaHR6Vk5ZUitXSG81WTlqb0tEOVR0YkRNaUw4?=
 =?utf-8?B?Z2pwVVg4MFY4OFRYNC8zSnZMM2N0aEFXVGtHV3pSNXZ1SERVRTFjd3phL2RL?=
 =?utf-8?B?eXRXNkJ1TDk4YTRJaVh0ZXI1TFZndnRhZkYvcTc4QzZoYTRyVUorS0xncHN1?=
 =?utf-8?B?QWJac1NueE9VRWVrZXp1TVFXVFFmeFJZbEIzN3RiMmV6QThUZnh4a3A0MXZy?=
 =?utf-8?B?TEhkVDY2cllkZkduK3MxdWdNNG5VcWlXVlg4aENQN0xsVjFKKzhINmRlSWdK?=
 =?utf-8?B?RXZYWmUvVlZCamtrL1hzam1udXQ2YThudndhTHBJMkp6RGdQQncwYmZkWnlN?=
 =?utf-8?B?RWd6Vy9nbUwxMTdLYUZXWVd3OTJ6aStBKzVPM0FPcG5TMWtqVTd5U0hVVDUr?=
 =?utf-8?B?emJNOThNTFVOcUVKVUFyL0x6ZDVteWhOYXJxd1NqaGZjc2VaZEVoM2VIU1BE?=
 =?utf-8?B?MUl1QUZHcFNJMXBZMWlkUXFhRlB6TGdRcEJyOWdvMVN2YmtTTWNHeVhiTTNX?=
 =?utf-8?B?bmVNSXNuZUJ5NUZCdjRUbU1ETHYzZThveGdoWFRmQkc3TVJVUDlUVHNTWW5y?=
 =?utf-8?B?bzlEQ3puWloxRHg4RlV5aXF4MnlSbEFQcVhhMVVvd09pcnV0V3IyYVl2R1Jz?=
 =?utf-8?B?K1kvY3ptM1BCNEhEY01PRUlWaTVMVzhobjdXbDNWci9SUTRoTzE3M2hlaDFX?=
 =?utf-8?B?eEFhc1BGTUJta3ptd09nOHR0RXg0eGpUVHJjb29qMHUvY3FocXZ0TVAwUXVa?=
 =?utf-8?B?MjBqZUtSSURzMHZsdGZDT3J4clJlZzlzRitmK3IwSXVYMVU2NU5OSEIrOFlJ?=
 =?utf-8?B?bzQyMTNsZjFsZ3dTaU5yaXRkNVVRSURybUloaE5VSEtwRWVYT1VCWVJ4WVEy?=
 =?utf-8?B?ZGlqV2E4aUtsSDdEZERWZjRUZStUSHV5ZEo3ZkdnU0pkTVFoTU4zcFJSTm1v?=
 =?utf-8?B?WWFoREk2QVF6UGI1eTZ2S2g5Ymo1M2x0ck4yb0RHM2tybmhUVmpwOThDaG5Z?=
 =?utf-8?B?U2JjWE45aDREdDdVVlNoSVVQY0xadVpGR2RxR0dILzdKbW9JOGx3azdSSndW?=
 =?utf-8?B?SDV2VEFtUWZEendGZnZ4VE9MQ0oySGlzcGpEeFhtUU9Xb2FsWm00Wk03QTRz?=
 =?utf-8?B?RWJwaytxUVhHT2Y3S2J2MlhlSGhJWGg3UGpOOWV6clhMVHY3bk5BQ3h6MHdr?=
 =?utf-8?B?dHQyMFVIcVF6K2R5aSs0ZlYxV3I4VVpzZTJpMDVoVEwydnBjdkk0TE1YZ2tm?=
 =?utf-8?B?dStqTDF3cXJlV1JGQzJyZWRQdlhxaFMyS2FrMVZjZU1zNUY2b1lLV0x0aXl6?=
 =?utf-8?B?bFprQ2NBWmo5YUlFRGZSTlJLQTNWemozNk5WeEptZzZObStiQ3BqcksxVERm?=
 =?utf-8?B?cFJtQlhYRUpQRys2a243dEg5cEtuSG5NakIyNmFSS2crV25hT0F5RDY1ZW9v?=
 =?utf-8?B?L1NvS3hEclhTUWV2TXZHVzVpMllNeEcwYW1vMlJXa3g4TlM5MVgrZFF3L01Y?=
 =?utf-8?Q?/DFuPX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC9pYUtIN2Rzd0MrSnhZVDJjTkp5RXNneHhnWHQ0UGF3TkJ0OWx4dGtVNGxO?=
 =?utf-8?B?K0dDaFlYZnp6U2RoTklEY04ySndMMGR0Uzh3cGd5dHF0RWJSUC9TOUppc3hw?=
 =?utf-8?B?anF1ellRL1ZqbGNSSmd0Uk4zOUw5b0xxbGdDWW9pdXhCS2Y4aFZxTlRReUNj?=
 =?utf-8?B?M0pqYkN3TWxVWlk5dC9wZW9DSFhZc24wWU5kVENUOFN2dmxGN3hwWkpLeTFa?=
 =?utf-8?B?T2dKSnhzOWM2YWFBdHBIUFc0eGdIeXA4U3VtTGZlcXdtNEpTa0xhWkY1bFZB?=
 =?utf-8?B?QXlXVUo3ZkU4YlZUTkFXbG0zaHJldUp0VGUwWmlXMGtnbHVpKzBjYjZUQU5B?=
 =?utf-8?B?bTQ2d0tyVmR0a0RsdUgvanBvWXF3aVlyeGg2M3FOenJGdXVOYkpraCs5enJl?=
 =?utf-8?B?b2V1RnJPbzF2THVTWTlrRUFVenRtM2VoZ01pNFZIcnNkWld5UVBNT2RVRmlP?=
 =?utf-8?B?WnFaUTY3WjJWaEE1N3dWVUJ6OHF3RFlUZ2MxZXdwSE5mWGw4M2F1RSt3UVRn?=
 =?utf-8?B?WUNjMHA0Um05MWU3VzZpb2UrWEhOSzJnclR6ZlVYVmx3cmEySmxNNVdjdnd6?=
 =?utf-8?B?UEdDM1Bub2NZcnEvRXN4L2NyUjJhOGtWd1VPZWRVSVhDZzZ5NGtKZW9QR2NN?=
 =?utf-8?B?L1doc0tFOGUvNERMVVV1N0ttUFhEdkhINXQ5MDlWNWNrbWlxS00vYUJieTlH?=
 =?utf-8?B?N29JVFU3STBmRDg4N2tnZ1V5eVEwZUxrR0R3cmtsUkNqOFh0d09hanVxZ3o0?=
 =?utf-8?B?bXFCcGtPZW55QTNZenhXVFNybjFaeXo4RUIxWXVwVUlQWDcycUhKcjkwakVh?=
 =?utf-8?B?WUx5dG4zVGNWRGpDWTBpQjhJY3hDZTZ2OERaOVlpaTlBMmxWb2dyM2lGYkxC?=
 =?utf-8?B?bmZGQ2VUVm8yK1FjVkpMY1F1MjYzeWc0c0orSVI5Y1hNZGY4OW1sRWZQbi9Q?=
 =?utf-8?B?UkFXQ2dLRGtqcXF4M1F5WmpBZzVCYXNyODRnZ0V4M3lXb3JWY2JRRlBFajJy?=
 =?utf-8?B?Y0dzOXRydVpzVThjOWZXK2FUUEJUcERIL0R3WWVlSnI4WEhhd1ZGNWtDQTJF?=
 =?utf-8?B?VWVYd0RRMjdra3UyVzBZL0ZRUVFXanY1UFMyb0JsUHlhQkxnTS96aGllSHo1?=
 =?utf-8?B?TXlaYlRVbWVuYXdzRTJ3bU01Y2hRdEIxcFZObVdsdTZTcEVHV1FibXVFOWRr?=
 =?utf-8?B?RTlUbjcrVUpLNW44YWEwMWxqT2piZ2gzb00zNTV3VU5ET0RoWllpU05peVJ3?=
 =?utf-8?B?dk5KeDg1bmZsdXdPMVJDanYvK3Byc0FzQ1hkU3VnUEJzK25KdWMrMW8yZm0y?=
 =?utf-8?B?eUlRUkpMc0NEMkYvbmpMTExpSlRCbEFUWHlOR2FnUkRZZmswbDAvWFJkWFNr?=
 =?utf-8?B?SVV2Z0lIOEQ4czRjQldpZnNzTlE3N0drbVlPUTdPTk1TNEMweDFTZFR0OFov?=
 =?utf-8?B?bE4vWmpRQ21XR2VEY2lYK0d4Z1l6M29PdnZ3REVCbGZHbmIwZklhcm5DVDFi?=
 =?utf-8?B?YUZrU1AzZGF1VmdOc1JvQzBzT3FKbzJ6QU9hQUhsMU5hYkpRZlBuczMxbkdT?=
 =?utf-8?B?SHVBblBXOHBtbUNuTG1KTnNpZndBSTduRjZJdUQwWmhzVHg3dVcrbDByUTZQ?=
 =?utf-8?B?bGlSU21aUDMzY3pnZlNSSDhDdFlkRFNneVJQU2t2cEluSzIvMFFDWGhhQ2Ja?=
 =?utf-8?B?dmlPNEgyY25pbUtyK1ZHWlEyTm1qNm5ZOUFQNlhQcTdGOVQydkZNeUVGUjRy?=
 =?utf-8?B?VUhUOU84SlFrUHcxN2U0MnpJZkRVYzNPaEpWUWp5cFFldXdZVWhHUDdiUExu?=
 =?utf-8?B?U1g0UTUxZUhpdUJ2NzRidGRFYk1IeHJwVG9KbWNSN09temFtdG5ObExBSjAr?=
 =?utf-8?B?ZnhYMSt4UnMwUGRkVXZJTXhET0V2RzJuRlBTWnhPd0xhNk9JbmtaV3ZHVFJt?=
 =?utf-8?B?c1ZYYVp5WWdKMEdMRnVwaWpnbkUrbUZHNElLQnBYT2lMUHUza2xQR1NSWGRV?=
 =?utf-8?B?UVJDS255aEtxTHZZSWtkUHpjNzh2OTNjZVJWTHBQcmJVVFlFcEp3TDZhci9x?=
 =?utf-8?B?YVhOQUhoQ0IvRGFjZ1BaYUVpbmYvRkNTSUt6bGRheHUvSFZYOWw1QzlXa2RK?=
 =?utf-8?Q?oyQd3VfJf2WDJAEdqECBVYpkX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2ec14d-9d7e-4397-06da-08de1d5b0432
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:36:28.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDSe6WeNCKVg67YycxoIbtINgMpiQzqlpANv92U02u2saCNzOoSj+qtFfLeC0bJZ1AMwJP3aor66VYIcLb+mBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

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


