Return-Path: <linux-iio+bounces-12219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DEA9C7A5F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206D51F26E4B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34CD2040B2;
	Wed, 13 Nov 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i13ZuCFr"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8732040AE;
	Wed, 13 Nov 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520516; cv=fail; b=gjBqRUB3qktkdpf1o7siPsCbYVu+8DAQuFN6EZJHYFQ548IxVtFCivXnsr3ZgcykKIyHTWa/hcj4ajgSwYB4dU0UmxFT7YhVPoXTAIIA0P+HLiiFFhhbD7Ub5boQl0eBPhCZZ2G+EVlwYJ2McJ3wRhozjKrLtY3XshNhF/uFyTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520516; c=relaxed/simple;
	bh=BF4AvUzYLCGf45tnupeZdY6npAqAkmq7GQlGXEaAv18=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UCNn3e95FtW+k3Ws0mMherC5BZ6ZLV8vyLaERmUWMw2jMZ3mRMLCr6+gEIp/3OYOZG3Y3M6FD6Cd2PZFTqBEXcHTISsqUwdpItY4jL+ZFa9Ddapzmal/eb9RU1tkAh4rKb+Y7F+lRI1LskkYi88gbtD4mwuAwyyOdXWD3s/i3Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i13ZuCFr; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWk4GiEg15RcK/SDeFSKZKOsdqJsOgQjtPVw+Ro1JmZf6478CuJxdC+bQhgSmx8MCRO+e9d/VdtTTQaqeCdwJXdsja0RvGKAYBywvCIC6vRtqnXhvQ4Vor/2cn//5l7GOz4syHoPSInvFmklyQEnTZlBNj5qMD1teQ1IircbgFyuc6A612SGZ7AZhqLpit+sDCK9flyS+3Z7HkZsfIFIFbzho/aNJ8+jE9/AZt5c9VmF3aetjJZJ2WES7axkPc4Mj8IiP5iPyVt9guW8lIgPbWzf1/CDbMUuewLSen/U1+Ks5Bungx1l9PmQER4UtIU0l1tWTIQwrU0NEtWBh/qwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD/py7h1oJ8to0KeBUnEG/s6aDuMsX09cjxND78mDqM=;
 b=sk0oi7SwT8V2dzcAcd6oDLkTG340fYsLhjSO4o4x0pMx9Ak+6Qfyd3CnjXPFtx5JdRPmnAIj5hQtfLowOz5+tk0yjRir6H6MwD+GoNfhHp76fAlhcka3FwpVKh6ja1NHqp/0hDewJUP6dKvpZbw/506s+uAIKYvaIBosRY08Rhmz2iJjdLcQTgqPsUt7oA6tTw0F/WcYec1kSRBNAzaYLBeuYDS60pGlNd6fiJOVZ+iyif7ibMRyBSH+H7MpsJu2yrTZQ2RFYLCrXXpHL1hOTrGlrt+37AbRCMlXBIZSK046Y3vqdMM2X5uArtyhNpdc8s/3El8rdk73e2EYb+S0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD/py7h1oJ8to0KeBUnEG/s6aDuMsX09cjxND78mDqM=;
 b=i13ZuCFr0rapP3iPlh6gXmzHhFzA8vD8MdW5K3J5tbEUFEcvjW5YR0NZV+MNXp1zuDOiLcmLCcw8AHP7K+jZvlEMrBYfygDk4cHHSuLNnZR6BWHKYL5Lpg+HqUiz4vxyqu5dbGZQRGMZSb69TsqdXHf7OVROV1iQysrk7oU9J81UHdy5rEojqSO+rpWMddFL4CR2aWEP397yXuqnW0FYMHWiH5OT8UasY5bcJks9RnlF/m3CciZkOjW0FnkgcA8ZZCdBAv5QoIu0TRmg0SgIqWNlmECoRjE5Yxj88oeRkpBOpe84B4HuUGHndnnrmJ7zJqligvq6IvSYz7b5Bzqx4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 17:55:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:55:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 13 Nov 2024 12:54:42 -0500
Subject: [PATCH 4/4] iio: accel: fxls8962af: add fxls8967af support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-fxls-v1-4-5e48ff1b1fb8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731520491; l=2373;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JO375cBldwsAR5vWQF0kDGVd9Tr1BAkXoLQlX4T3m3c=;
 b=r393QS7hGpdC7BAqL3VD2FZOJSuzQokeU9a3b7HNHpSG5MhQPbTGuIIEEpb4jtrvHdy51cvCm
 Tpz/984/NxBAHfPGQhqjsnNIlHcJBEKhr2CVRGO5KQynVJqV0F9KSB4
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
X-MS-Office365-Filtering-Correlation-Id: f376efce-a93e-424b-67f3-08dd040c4ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUxLSXBnbytMYmc1Y2JXRGh4WmhsTmNGRjVIREFXRDlQdkVzeUJ0QlJjcDBi?=
 =?utf-8?B?ajZKU1J1aXppY1ZGbEdJc2VaRmJDdVlBNGoyQmhiRmFJMVIrNGRPVkFSLzVa?=
 =?utf-8?B?dFU1bm4rSXBIdERudzhna21XOHAxNmNyeWhvTGp1NkhzTDBIb2hhQ1phUTVR?=
 =?utf-8?B?dlpEODlTRHdHMFJPcmZBNHFwaWNvWEdyakhpZ2wvY3dGckFKeERoOFU3TllG?=
 =?utf-8?B?OVlDM1E4YjR2NGtMMUV3YW5SY1ZaSnc1d3dhV1YvY3FPZ0p6ZDdJZ1RGYVpR?=
 =?utf-8?B?UFF0ZG5hcW9YRWRIUkRRNUI1QkZrUExoeXFlYXdZcE9WNlBrTC9WOWNob2Vp?=
 =?utf-8?B?bTh1NnVKVk1ic3dzN3lJd2tTOTJVZHhlRFFlRkZmVG5PbWRVVXVOMVBVZ2pL?=
 =?utf-8?B?eWdJaDJqaU4rR0hteFROZWlnWFFnN3ZiYzlWdWZnUmYvbUliK1FYdjlBVFAr?=
 =?utf-8?B?aWpwcC8rUUx1TUhNVmtOYWM0b0dKbU9xb1FQTVZ0ZDZxNTkxUS9IVlBjZTdi?=
 =?utf-8?B?ZFJDU0RhSXhPUmxjaU1zem02NDhpYS9qWklqdTIrbkIwL2NmMVBNeTZkSkpF?=
 =?utf-8?B?bjhQZTdwRWJMMitmcDNxRUJRRHcvVEdQSmFkZCtoUE1HUmNrQjc2b1FZa1pz?=
 =?utf-8?B?LzVWTCtzNEo1SWV6b1V1alplcVZ2U094bmVMMHYzaXY2ME1FaUo5Y3NqQ0Uv?=
 =?utf-8?B?bkFCYzZ0NFVhSjdWV0VndDd3WDJoUUhZNUc0VW9QelhxYTltMVFlbVNmVmVj?=
 =?utf-8?B?UFB5S3VGQ3BkbFB2VHJZYzJxVENWa1pLODFsZEdIYUVjOW9jWDIxeHljZlZa?=
 =?utf-8?B?QzNnTU9Bd0hmNE9IWkJkMnhqS3FLM3lFejcwbEdTOUg3bmRGMXFzVG4vSDVR?=
 =?utf-8?B?K2svN2J1MWs4WTluSDZ0WVBSQjZEdXRXRm1MMDhXdHVHYy83TXJUL0VFSVZM?=
 =?utf-8?B?ZDVqZ1Y5U3I3bHZ6SEhxdEViai9ZQ25MM0Nib0RuaVZEbEZ5eVlZNytRTWRQ?=
 =?utf-8?B?OTFTb0JFc0dBTUhSZ1VNQlpMMXJPWkJobmptTnZRKzYraUVBYm9xbkFmaFRu?=
 =?utf-8?B?ME5ZMlM4UVIzaTdKOW9PRjJaY0RnTkVGQlEyTEFaRnA4UkNTT2F5N1hRSkRO?=
 =?utf-8?B?QmdvZXVjQVhvVGZ5SGN0RG5CZWRwTDJjVVBGN1dZaG1xN3RmbkcrQTdQcW5M?=
 =?utf-8?B?TUx1aFowd2tZMVQ0cE1pVXRWSVRENGJsTXZsZWxEYW93U1d0M2JjbUg2b0xY?=
 =?utf-8?B?elQwUmc1aDRzS0oycnl6NEhvNzRBd3Y0LysxSVhmSnRjN1ZVeGZJTEcrUkdx?=
 =?utf-8?B?UEwzYjJScHB3TWtuQkt6UjFJRDJMTW1rM3BUZytnZDVmc3RTM2l3UHg0NlJL?=
 =?utf-8?B?MC95VlV1TlhwZktieXpiQlFQUExqRWQ3MUlndUxZd2l1UWVBM29jRHN5ZWNW?=
 =?utf-8?B?a2J0dFpzQ01HN1hWU2ZtRTl0SmJsclNRL0JyTndPSFdqYktBb0VrbnZVOEs5?=
 =?utf-8?B?OTY2amJSTVJ3a01WR2l0RmZMVk5wK0wvK3JNdTd0OGlIZmNkTUFSNmFFVjZ3?=
 =?utf-8?B?dkh1OGloODhkUDB5MFFiWlBLeHlubDVrNlhvV01WdDFVdnVaRVE4N011THF2?=
 =?utf-8?B?L3l5eURmRytHMGdQQzB4K2RlR2JLZnl1V0trbm8xVmRFMWt0T1kwSnFWUnVn?=
 =?utf-8?B?Tlp0dmFHMjMyVldmREJ6WUI0cE8raVJWampGd1FXVzdkdTEzd2FnekdNb3Jr?=
 =?utf-8?B?ZWZCY3Ribm9XaDhQNy9aME9PQy80bE14WHBhSUFNbWtuUWdOemRhRTIrOUFy?=
 =?utf-8?Q?Z3hVJpCCk9s4USQJSEHx0mYZsLrJ7dh7GYBk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHU1emhHNTZRY2tFQXIrZThPOVZLTmE1bERPTGFvSHBhSElxeDIxaWJxNFE4?=
 =?utf-8?B?N3FERDAyZzRFaklsWW42KzhkbktNMmVWMGI3WmpMQkpKV0lSaWZkbTVCYm1P?=
 =?utf-8?B?M3JDR3FlK0pnbnRjcUljWjUrSXBOTUQyWFRrM3Y0QVNocnFPQS9kYjZZMGVx?=
 =?utf-8?B?bnVaRzFKN3ZrcURnMFpDU0RFckdxRG5xY3FrM2RzMW14VmFKOTNaZzZEdTZM?=
 =?utf-8?B?M1lBLzlSVE54Nng4NUtsRmNiNjJXK3dVa3RrVGFOZ0xlRTFQT0RCREdOY21n?=
 =?utf-8?B?b3Q4QUFyT1RNdituZlJpVDBCSnRNQTBKSFVDQ3F3Rk1LTHJqWWhRWWp0WjF0?=
 =?utf-8?B?L3k3ZXVpKzRYdS92Ukt2K2x3L252MUpQSzdqUW5OY3RwWnNPRWZCTDdjQnY1?=
 =?utf-8?B?Ry94Q21QdVUwc1o4MnhWaGxEV0lhaVd6UVZzS2w5ZHpyY3doWXRCa29VaDhQ?=
 =?utf-8?B?ODlLNVdDd2FkNUt6dkpWNVAvOUs0ejJQY1dGOE9TQTJlSitWeU9BcG4zd0ho?=
 =?utf-8?B?OHFPUTdaaHlBclAxTVVNTlc1YVp2RVRZT3FxZ05VUXd1OXdtZUptbm5ub25m?=
 =?utf-8?B?Z3FkSEdFWStzNFU0ODZDU0tBSWJBTlF4SkpjdndYQnRqMXV0MmJyeUZ3ZmxY?=
 =?utf-8?B?Q0dtdUJkOUF0UThUdzcvQ0J2QUhRWW1vYytFUktMRUlpZVBRRlN2REpYVDh2?=
 =?utf-8?B?NHZBelNONkhzZFY2RkZRQUJGMXIrMUdJUlpZcXFDV3FYd3pGRkZxdVlBVmhw?=
 =?utf-8?B?YTZuQ0dHV0txVHU0dTZieC95cFZFYkR0ZEo3Y3BST01aZFVVdkpSbVpPcHhr?=
 =?utf-8?B?OHl3Zm50K3p1eWl0ck95MmxNN2VIUHZPUEdjejgwd0xsZDhrUFVMUkZyVllq?=
 =?utf-8?B?bjg1UFgzcms0bCtrM2V2S0dmaFVCMFREWnR4bHk0SFJVUEVuaStSTW1mcHF4?=
 =?utf-8?B?V0NvaDc4Ymp0UmZ2dHJPZEtkVzV0V2JTZ095bTJDQ2o5aEVSZS93SExDczJO?=
 =?utf-8?B?OURrSTJQdld6VW5ZSVFlNWJmRnZPWTNHOG10M3lPOFpDZmhIY2hNcThtaDUv?=
 =?utf-8?B?b2VLYjdZTk5NRytkYXAvSis5UXBSYTJ3UUZpK3lJeFkrZnh2dWZGU2FWdWUw?=
 =?utf-8?B?OVhBdDhxdjVjL0tHdkR6RE1hN0IxcitXeTV0UFhlSWhZOENEWmpkczRMd3dP?=
 =?utf-8?B?V0Zka3k4d2ltYThCZkY2WnRGbUxiOHJEOWdEdElLcFkyOFE4MWlqQklseGdM?=
 =?utf-8?B?VTRTYVp0bjB3T0VaRkZxUGY4UjRvRTVBWEpwSGZxNmJBVGFwUTVCSDZQUkRa?=
 =?utf-8?B?bVJjSUdqYzZhRWNtOSs1cTlhOWVKZHY3aFVkeHpqL3ppdWp4MWlHRDI0Qld4?=
 =?utf-8?B?b2NyV2VYSHFKZU11NmFWSkJMWHJaR0RZMlN6YVAyVy9SS2wxQ2xyL1FZb2ZK?=
 =?utf-8?B?VUFjemVnR0YrRy9mNHFwRC9EN2JFTmJmNmxiMUVYMzYyM3N1RThlWkcycjV5?=
 =?utf-8?B?TlBqUTVCUktjeVB2SHVnZlpSdVVab1RhYURJa20zNmNWRU9FR0RzVE04aW81?=
 =?utf-8?B?V3RMMkc4OU9KMVpoYStub2poMGZuOFltc2NwRHRVaFF5UDZQYWpZclkyL2JN?=
 =?utf-8?B?WmVEQW9xaGtWLzRsbTBsYUREMHdrb05QeUlMK0JlcnBrQm9zbHk1bVFCMTVD?=
 =?utf-8?B?Q2o1eFFoZW5sMTAxMm5XRGZpMzVyQ3o2MWRNdldBSFJqaWo5SEQ4YzZwQXBt?=
 =?utf-8?B?ZDZPVlM2anR0dTdsSGlNTEowTGlVMVMzelAyaHlrOFVHSkZCNE9aako3UHIy?=
 =?utf-8?B?bzNod0k3Z0VIZGpIK2oySWErZVNHbEZWT1NtTFcrRkVkdXVScG9wUTk1U2Vu?=
 =?utf-8?B?NjZDY2szcFdRNjJnNEE5ZlJFRko4MndhTWpjYTgyZTVycEErRUU1YWplMGQy?=
 =?utf-8?B?ZWVFLzFUNy9ISllsbCtFWUlITC9rTEtZQ3BoZ0c5Q0lZOHVxTE13KzJhYWFx?=
 =?utf-8?B?WUUzelNWNnZOM0NLVnNidlpZZThNM2lYRXlEK2lpNWdGWjI3V3dSWEwxZFRx?=
 =?utf-8?B?bVhQQXpvYUZlRzRPNi9rVFV3QStTWjBuNlBUdjZzQmZIVjBISTdKR3YyQmh3?=
 =?utf-8?Q?nqt5LhRLy+DAeJOIBsD9skvBF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f376efce-a93e-424b-67f3-08dd040c4ff5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:55:08.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PlpDQ/z5bC/APLWLcrOOTfg/6LLSJSPF4YMjnN6V8R94ihu+dbDPpJxEBq4uqXP/zIkpU3EVYn/Rf6M4RURZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656

From: Han Xu <han.xu@nxp.com>

fxls8967af is similar with fxls8962af, the only difference is the device id
change to 0x87.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index b5607e753a7db..fd9b461904c20 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -130,6 +130,7 @@
 #define FXLS8962AF_DEVICE_ID			0x62
 #define FXLS8964AF_DEVICE_ID			0x84
 #define FXLS8974CF_DEVICE_ID			0x86
+#define FXLS8967AF_DEVICE_ID			0x87
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
@@ -767,6 +768,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
 		.channels = fxls8962af_channels,
 		.num_channels = ARRAY_SIZE(fxls8962af_channels),
 	},
+	[fxls8967af] = {
+		.chip_id = FXLS8967AF_DEVICE_ID,
+		.name = "fxls8967af",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
 	[fxls8974cf] = {
 		.chip_id = FXLS8974CF_DEVICE_ID,
 		.name = "fxls8974cf",
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index ebdf6926db0a7..029ba849a0423 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
 static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
+	{ "fxls8967af", fxls8967af },
 	{ "fxls8974cf", fxls8974cf },
 	{}
 };
@@ -38,6 +39,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
 static const struct of_device_id fxls8962af_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
+	{ .compatible = "nxp,fxls8967af" },
 	{ .compatible = "nxp,fxls8974cf" },
 	{}
 };
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 733b69e01e1cc..1c9adfc8c0dc1 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -11,6 +11,7 @@ struct device;
 enum {
 	fxls8962af,
 	fxls8964af,
+	fxls8967af,
 	fxls8974cf,
 };
 

-- 
2.34.1


