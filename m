Return-Path: <linux-iio+bounces-24828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5EDBC1EB4
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 17:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01E214F768E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D82E5B3D;
	Tue,  7 Oct 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXenh/67"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DA2E62C3;
	Tue,  7 Oct 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850585; cv=fail; b=dO0Ahm4YN3qw/zstwebjcSIgSVfGQrlLIx7PQ6axtz/azh7HNs9NpRE654tKUnzyUqtwnBNN+zIBAhAyxYSlnfIbb5WR3kFFvROWbIzm8mAa3FSGk9jWz0x4sXNHzIVQuF+XxXqXWVtqyIW7tvyggQ3ET/pmKlRepMZnjt/E2CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850585; c=relaxed/simple;
	bh=oB8hNInmAqJKKzs/Srzrawh2yTT2662oVpY4ckrvcIw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZgiPFTMJXO2gxDyO56ouxiC6YIp0tfdlvFmLxBLyMbdrBpJIyXbetaEkwp4OC6aHrp+ZJJaEBa3XbN0Lbsn5i5aqnZy7xGOVTBhoglWs+SQOZbxWTW5KgW19J7YRzE8RuChp6on78JXbOTqzuKho2QcNue3ZM2ypHgyOln2xkmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXenh/67; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMG2aPaUoNHMbLhXs/ZCl1fNSf0gIqIayr49tK53xiBejrlV3ufkWBD8fIkoiwkkroY7rrg9wcZ/TA918/158tCgIrOdcHv2D3yh9qaB1yKQjLW9OVBqfUYzkfmCDnSow2kJ5ytIYatLUS4VihiIGQ+pyl8tr+b0IYA0kPjdhP845V83JJB2011EX9CgRcFgnn8oW82XxE1g+rxjlvjO/flz+qIcZY/sMmvvExuj+D0zqpUw/y+gGoThmqF8hsfJP5CC5gYsemzYJ3E5XYtXmoga79oXeAw9Rkx8H4C3wh7e6w4Law/0Rd7FzEIDQ+c/oJf755S40HE0lzmRuu6TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoGGQW9bLiB/QKXcUQE/usMqkF5TLtPSFT9NdIxIVuQ=;
 b=kFlef18POMjN7sH0t8vSVmk7sbbbr23LUj/bXf9iO9GVGvNS7SaRHwJFfH13cigz5j6ToR9CT7tZe7ooUOOfwq96UBVdD/8ov6VfzIbhdFHFNOHTm3F/4a0Ew9WPAYxnTwurA7xGIvU/Zpb7WIH7GRjVL07yTsjg7pZbRqirl4TbJQKYaCLTJVIm1LAfhfZlkpemPdqu9mnSMNyGODK13ZG5zc4jk4eso9+Ww6+T2VeF4lNLBO+hMgAyEM1kinHeK18Cb9JkcI0fflXg2pz8V/5WMf01AMvWWdQkcMHjxD1YAMKUgFvkgWmUtz2UUiJpYRHO7ztVWu/++hRuUOEhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoGGQW9bLiB/QKXcUQE/usMqkF5TLtPSFT9NdIxIVuQ=;
 b=mXenh/67uYflCmCiTo4+QFQFuzxBX9mO2U7aDt1NUfa+ZUsG2BlTQ2h6DBdbdAF4StfCH/RUj+VsukGDzyFpC12fIwfopxnY0cEg95271X4DLAEMLf1JmUK4mZnvepB8/LAXmv0ncYnJPnY/aBBKIrgzSfP/FwVM9BmGbdfGHtpybkhORGrBYLdC1clrODdPuE36OQjk/2ePiAxA9mXwUno28G/9Iz97qxvOFy3EdOJ7K+eADPfvC/SeUHLgyEAC7c3rDWwxtoabQB0PRI0Aa8415d6+6RlFQL8Sm2517iF73FE8UiGZgzsQPVDqXFuBwMwQD1zj1fzFQuEdCcd6Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:22:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 15:22:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 11:22:18 -0400
Subject: [PATCH v4 4/5] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v4-4-3afea5105775@nxp.com>
References: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759850558; l=1103;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oB8hNInmAqJKKzs/Srzrawh2yTT2662oVpY4ckrvcIw=;
 b=3/LcqD7usxut9gbJUfE4ETtOLuwDvZIIYKygVzEQOBvVBVbIscs3zIT+NJ5hVHQo+t5QxwfIt
 1DGtZeLvWPYCSlkMhuoSm/uFJo71IquaxvGnucX2Ucy+fCailDUfHvB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 4300956b-87cf-4167-f122-08de05b564a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlYrK2hyaGV2MHlQWUZLWGFVMEhZVEkvQWNUclg1dktBRmpvbGl4a0VjNk1t?=
 =?utf-8?B?aFFjODE3djdTZmtvcVFxT2tBMXBMcjR5MXNCMVpGalVmaHlmNk1hM3E4V2ps?=
 =?utf-8?B?U0habXFaV05EWHlrQ1RieUJubFZ1am1maWtKUi9VZUJrR2NTNExiS3p2bGpN?=
 =?utf-8?B?TjcyWXdnalNSYytIM2VFeDJud1FScjNhNmcxZVpFY0tONG9lYzFWckRSbUdt?=
 =?utf-8?B?N0lZM1JiSWYwTXBUNzc1T1lST1k0T1FjY3YrQnJWbkRwOEVPdWR3eDEyZFg1?=
 =?utf-8?B?Q0kxK2VrOU5yUnoxOUxQRXBYMGxLQlAyVzQwa3g0UHI0SHFkZmpVSWxyZlBD?=
 =?utf-8?B?UUx1UXhPQzJBMlRncWZqTTcvTUMrS2pMMU42L1FqOTcxdG8wWS82d2Nic0p5?=
 =?utf-8?B?RkFSNGZhaTIrRC85ZEVycDBkcDNQOEZaci9mQm5YL2crWUh2YmVmaGdLdTVt?=
 =?utf-8?B?a2lkKzZGUFRpRDNaR1pyeW5HTFZGYVJld0xWZ2l5a1hBWkc3QkZZMTh1UFhl?=
 =?utf-8?B?Rkg0VGd2NEtlekZnaENmOGRYemdKUWwyakxoU21NUnZrbUx4ejZ5NFpuZzhX?=
 =?utf-8?B?YXV6L1I1ZlNRQU92ZFE3WEo1elhLUElDU2hxUUh5aVBxQ3AvTlhOQzdTYkc5?=
 =?utf-8?B?ZTVDTWk5N0FvQk9HVVEwc2xGdzVOc2I2WElvVVB3cGVUVXJqQzFvaC91TUV4?=
 =?utf-8?B?OHBBdldSdWNmUXh5Y2I1TmJGR28xTzdoQ3I3MjdyTXIyMGRQbzVSY2lGR3k2?=
 =?utf-8?B?a3lENmZjejZOYW9SYytRZVRFVVFJcmZvTEc0Zmp3UGFodkZQZWRycWtFNEpn?=
 =?utf-8?B?dkhmTDB1RkpJT0V5akVObVArcTZVYkR6emhkYmdDY2haL2d0ZmJlYzYyVzgw?=
 =?utf-8?B?aCtaa0syNXRuTm1OZnpHNkZIeVljUE9UcW0rK2QycmhkQUNucjA4R3lIVG5M?=
 =?utf-8?B?c0VnbU1Id2xyNCtkck1WaHhKeGcra0t0YkFpTU9oTDIvUHlEb2FIL1BGZ0N1?=
 =?utf-8?B?amNxN1NQMnBUakVUQlE5VE1zOFhHaUxad1pqZFcwZGRIYnQ0R3dPTmVUTnNY?=
 =?utf-8?B?d25JbzB1QkxEbjJnS05RRUpQQTVldGYvY254K1pWSFgydmpvaDRJUGJvSWE0?=
 =?utf-8?B?NFR5NnEyMWxvS0xnU0lyN01yZS9TR0lwY3R4emowdDFyQ21qUHpEcnl6anJT?=
 =?utf-8?B?bFdkZDRSNXpnd3lhNjY4bnJEUmRuUk5CRys1UDkzczlqSmFoQWRSRWREWWgx?=
 =?utf-8?B?YVpJTFBZQ1ppQUF2bi9wanhyN29kbm41QmVnR01nOThLaWJGK01DUzZpSTRR?=
 =?utf-8?B?eEowZFVrWlp5NW8zYnFtanY5YmJubC9kMTRzSHowemVsRmxrZkpXNlArSGgy?=
 =?utf-8?B?VW5GZ1BLYThuWlAwM3k5d2IxUUJuMWdjYW9TbnRwTWFWS3dZN3g3QnNWeFVZ?=
 =?utf-8?B?eTJsWFJ1OWRiR2tRQVJLODlEa2Y5VjFseExkSzFyT2xOUUd0NE1OdG5wM0w3?=
 =?utf-8?B?YkEyUGZ2QTdQN1ZyMlo4ZFd2aUJ5cmdwTmhiVmVKRW9SRGFKbG40MDhuMHVQ?=
 =?utf-8?B?SElZczYrOVM4ZWViY1p4elpXUUd4V1VDM2w4S3kyZzFaTS9NdnpzTklUeEZo?=
 =?utf-8?B?OHFFVk40SGZZMENHMmdLUW1jR0NpWUhOb0xkM09JSlRDWDEyOGp1ZHIwSkdD?=
 =?utf-8?B?OGZFcUxqeEVNbWNKYjYzVDlQZUVVN3B4U1hmdjk0RXRrL2NQcDVhUVR6b0ZS?=
 =?utf-8?B?WVZDcUszNFBCTEQySjdNQU5JOWVueDl1SEx0OXFsVkxvaUJEaWQ0VHlrZ3FL?=
 =?utf-8?B?UHJtNWZlL0lPNHlSNkFNNHdETDNCVDljb01jRk96VHFyYkVrMW5OMlBjemFj?=
 =?utf-8?B?b2RVdkFIVGVzYVhuSnZZMjlMR0t4MHcxcndvSndWWG9jdDlzZEVmT1VmYkRj?=
 =?utf-8?B?b0xOeUcrL3BUTlNzdmdjVUVZNnQxVVlwa2hQbXhqMTJSajBLVzdOa3dGR1BX?=
 =?utf-8?B?Vkl2bXkwMGM2bWdvSzU0blh2a0E0dmx2SS9tMVBia0xKVXQ1K1k0RlArbU0z?=
 =?utf-8?Q?kHsO3w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWJEWjNUZzhuZ1kwdzE5T0ljT25ZYlNQeWNhRjJDSkR2Tm1yc29sVGtPMStK?=
 =?utf-8?B?UEFEVHkza3hUb01uSWZ0b2wyR0FTNHNQYktoNmROMGhzRVVKNFk3UU5KMy8v?=
 =?utf-8?B?UHJSN2dOZm9ud2lpUHZucU4vQitrQmk4ZXpnUE1nOVpPUWxpbGVtQnd6VXlT?=
 =?utf-8?B?M01hbGRWbmxOMUJzWlc3UkE3a213QjVtYitQZ0JnYkU2VkwxWmxNQlpIU25R?=
 =?utf-8?B?cTd0K0l3d0NGVFdkbS81a216OVFlcHRLNnFhZ1YvY3J2dGtGd1hpUE9aOEFv?=
 =?utf-8?B?OHNDQmRQaVJ3aW9TT0RVcGVXRHRJeDMxd3Z2RWo4OWZ2MHIxU0pXWm1LaDhG?=
 =?utf-8?B?Ykw2TE1aUytnWGdDRWFQQWZrOHZsM3RsRCtpZWozdi9lZjVqYXlENGc3N3JH?=
 =?utf-8?B?YllnVzMzVndEM1RrVXUwbi9EVTRiMyt2RWVjbjZ3QmNCTkRhS3lkd0pCVE84?=
 =?utf-8?B?S0R4WStzaFlneDd4UXZLUkZuRCtaL3R5d0o1V1NLM2Z5aUx1NzNzVStGTHAv?=
 =?utf-8?B?VExRMkdra1g0a3NRN2I1SXBranZsK0cwaWlvMCtpQlNoenNZR20veTFhMGxz?=
 =?utf-8?B?a2NPa1VNdC9UT01mc1VneG43TFJ6S1l6L3kyT1JWREwxQjhmQndwOVJIWm04?=
 =?utf-8?B?TlVwcUJJVVJlRXJkOUFWdituZ3lVTjRBcXNJODl6SVVJbThBUmVzU2oyMENY?=
 =?utf-8?B?d3MzNFUxQ0VFd2hYc0JXQ2dZdU5pZERZY1NUakU5TjMrd1lqb0E4U1hHRkxa?=
 =?utf-8?B?ZkUyc0RWMEhHWGdTbml1YnliK1JJNVhTN3BUTStqTjFxQTAvSmRQVkFNVEhm?=
 =?utf-8?B?RTQzOEJWZ2Z4QzIyenFVUFRmOWZKZEJoajZKMjZodEpkMGJndWZUT0FMMlVI?=
 =?utf-8?B?KzAxaUVFMGdETTVxZ3FpN01nTk1Hekg1WVFhZ0E0VFV5R2hKSXE0RkFOZTFr?=
 =?utf-8?B?Y01uRHV4eVVWQm5QYmlTNEZlK2JaTm0zY3FzWGJrV3pVZTd5YlFqMDNTZDFn?=
 =?utf-8?B?MUxEU2hYQnZEMGxmLzhQc3AyaWhBalZic3JranByNUxKaUZiVWRlcHZhUkI4?=
 =?utf-8?B?U1lET0VNQkhyYzVFM0FLaG13QTVMYnNGdDY4QndOQVh5eXZuM3JpKzRmNEFW?=
 =?utf-8?B?ZEw0NUN1SVFQVzUzbVdaRzhJMWZSK293U01xZ3BmSlY2UThUWE5LenBTYnFP?=
 =?utf-8?B?bWR1MzQrYnU4eHdOUlJpUzB4aXZ2WVhlTllqQkpJSnNHL0xwSnVHYXBNMkFw?=
 =?utf-8?B?Y1plWGZRM2tROUw1eE5ITmR0Lzl4eUowWXRFV1F2dHcwK0VLN1dGaHZUdlg4?=
 =?utf-8?B?Q1hZNTBkUTVvRTR3bW10WU0zNGRyRXh3SlcwT1FGb2hHQ0lYVVkyRjdFZmdZ?=
 =?utf-8?B?cUwyWnBXVElYZHl4eVZoVFE5SXB6MnNHK25jcjJBZ1B6MXU3ZHBSOXVWOGFv?=
 =?utf-8?B?bVBxeUdWalRJcE1zYTZyT1BYQUgzZXpFRnpOTHEyNDZkYSt6SU5IdlUza1N0?=
 =?utf-8?B?S0dXRWdmMjVLTVFic2xnOXU2T0VuZkE0QkVKNkNqcEtsYzZPYzRBUnUzdEZp?=
 =?utf-8?B?UTJFTC9QR2VyOWlLMHJJTHFhNHJETEt0bnJJRllzYlJiWCtxZmhRaUpOaTl5?=
 =?utf-8?B?azUzWXdZVjNyVEV5SGhvTmJzUjZQb1B3K2U0cUNHREZ1N0JoWENYYUZOeEFN?=
 =?utf-8?B?WlhBRDhpbGJFYStXNm81ek1CWU1YN1g0RjNNbVZOZUlmTERaRXh6TDFhVkNt?=
 =?utf-8?B?bnpqTEJGWTU5a3dtWlZKYVhyMGNJRTgrN0k1L2JMQ1dVUnRCdWJRUzhOL0ls?=
 =?utf-8?B?TEpsNW9yQ3psNE9uMGR5a1lEZ3JTQXhvcHNZUldUZkU0djN2SS9waldMd2RL?=
 =?utf-8?B?MlVxWi9SMmROMzhnQ3NsQWQxc09NUFA5ZENVZ2dZNE9GSVl6REdhOFJ6c1V1?=
 =?utf-8?B?U2x4VEM3cHo5bTVzVGlkT2Y2Nkw4RURLaEQwajFubzMraTdUZktzWFR0Ujhs?=
 =?utf-8?B?OWRFVnFhLzJqaVY0N1l1bEZPNnVDdkVLYlFpS3dvQW5UdEhBa1RRWDAxNkgx?=
 =?utf-8?B?T2V0Y3c1QWlnREhVQUlRYklNeTJWc3ErTEpyMzdMekRHYzBOMmNCeTk3dGtR?=
 =?utf-8?Q?ahCMWSIXZMMU8Qty+ZJ3OUpfM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4300956b-87cf-4167-f122-08de05b564a6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:22:57.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyLQV6TbbHb04h6uaO1EQifJWTqNwiHi3rIAaDj4rq1/JhxYSG+SUUMlmIKQ6s1x8o+C3oh3XrPp3ChNCX/2iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
MEMSIC 3-axis magnetometer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4
- add memsic,mmc5603

Changes from v1 .. v3
- None
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7609acaa752d5c1c89a26bb007fa38357dee1a28..72786eebfbd63beffd2a09fc20c7aedbe9e96a8e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -225,6 +225,10 @@ properties:
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


