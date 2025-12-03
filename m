Return-Path: <linux-iio+bounces-26666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E29C9E7AA
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 10:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148123A910E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB12DEA9B;
	Wed,  3 Dec 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="K/0VNraC"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021097.outbound.protection.outlook.com [40.107.130.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F62DE702;
	Wed,  3 Dec 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754137; cv=fail; b=CxTQ6pURe4G7zCxEyRzX8eoagDgO6JlMpCNoWSDQ4B9i+r9GRI+63l70Yk+Gfiee5mQRAdnZjQrAUDTZzsroicekgIORSBtr8az5nbmMrO1e4ckMKWSG8kQ/a53hSRLNxSUfTSYpT+rO5fvB7kwIlLBhwYlD8LCOXK6kd7LqWM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754137; c=relaxed/simple;
	bh=aDllm1bBlLWfoj8FVzG0v6r3m/vLIXiwSiK3eCrpT3Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kXK9gpaZ+l+GW4fWrjxogkNXJKZbvY7jJS/DkhcSM1Cubs9wa/soRikI0iHPO5WXePl6mT0tBDXcVQICs4V+GTcvfaDlc1E5Sa0CVzG5XTFBdQ8BH3sN48/9Smcany+jEJp38r7rn+cW3E/GwnZBVxlzCIOoqEkJNpZwHC8omcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=K/0VNraC; arc=fail smtp.client-ip=40.107.130.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYyXptOWHfwRYnG7a0vAJAuR9Elaj5wgDKwUzWS16PRukstVTGzmVLQFDY0T6qKw2J2Mrz3FFQ81tAQ2W5DQHwY+tWJEWStDUN1bmHQsxTd54/c2uxaACEY8H/IoT/Qm73n41i1ZJp1oJw3e9cbSQCdt4IBWtQBa0k6VJmdRFb23dfITFKofWGWgl+R/a1M2WzYFOmBRFNmqso68EtEj1ucvi/y5FG2dAOIW+eN/gK2dp4A7covARlMDFtwxwN7QCZ276cg+50khC2KY3zYakNzMAU0MsAzzitF8cPeHWEpns8lVcdd3XACj2/CnTkfdYY9o0kBEfDcPMUmqE8PTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV/G3r8TLO8Q5QcYQ2aRl7xguBySa2MOAGh8RQiXmqg=;
 b=Q3sA2Ry+vY6/lcdWiOFlPAe0vuXh5SakobShSxSRP2URSz3Kko1hzAhLZD1v9sj/gHT2jcELR0i05xEjZgzbVWLxfjps2J6AZYIb+5lLtIntnP3dofep8JKJbBCjDn86ZQIa9a6buTxYQ/gL8/uLKNPlXNd+miiO7BqdDLverAqaVsO7OmEv65lM3zhl10kav1wpzvBayvSUDjLrfcrP6/oGbWvZ/y7FDlpaElMpYjkoilei9HtJaGh6f9f5pNUtanD6xkP8q2VaB9gbRKK3wpqj/ojJMjfygyIe0uXfr44d5D5t1D/YAIYbQdpDQl81yjOK+cxQNUlGrO3yjFwF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV/G3r8TLO8Q5QcYQ2aRl7xguBySa2MOAGh8RQiXmqg=;
 b=K/0VNraCkTDeOrhAPHSSvNuzSg4v/YF8snYrMYtFpT7sE5oo8Th5vnY7Ux+oT3epDSeYrurBgJH6VZbCsCbDREEUeasd/969zb7TRjbwm5TL+DzaLJ+NWeOeACT6alo5Z6WriYc4VCZ344qtCaZkQJ9nayXnssYBHc+gQGgNdha/rGgk5tijXvFhca3XVDsIkYEvKk2UXXT4A9WJP6LjZwxV0Sad/Hj3nhAuoeuM9P58aG64056PRcsw9mqkX50KHDIJbTwxj9RG04wUjMuuCPfRrakCqlobWfMNaWnTLTChsrs7JWa19hA9Wbh7IdDcEgZ4C/L37rN0mj+OVk6zFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PAXPR06MB7422.eurprd06.prod.outlook.com (2603:10a6:102:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 09:28:42 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:28:42 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 03 Dec 2025 09:28:12 +0000
Subject: [PATCH v3 2/2] iio: adc: ad9467: support write/read offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-ad9434-fixes-v3-2-38d14f28456f@vaisala.com>
References: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
In-Reply-To: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764754120; l=4106;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=aDllm1bBlLWfoj8FVzG0v6r3m/vLIXiwSiK3eCrpT3Q=;
 b=4E4ngGpIw5bGML2OfbtGwoNRNc4t3MgWGC6MgbMcth5AQYVxcI6hdKj6EW6RpyelM6flq9mQZ
 iD2gSHB1WYbCUVcmJyf3gxNSStFjIXgT5ZL/T6mYndiNnX0XNaeoKK9
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF00011B53.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PAXPR06MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 0898dee1-45b8-4baa-e5e1-08de324e5997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWt1UkRndzhqTC9zWnNFc0pCdGp2ZjJCY1pVbTZVd0xrZmVWTUloK0FMaDBo?=
 =?utf-8?B?eXpGWmZkbWpSZDYrb3BSek1UZVNFRG4rbmFWbE1Zc3RDUWx4YUJEaG9nVVNs?=
 =?utf-8?B?Sy9YTDEvZDJmdStkdzdnY21RUjJjdlQyQWdBV1lYV2x6WXhxQlJ5QzdQbXBp?=
 =?utf-8?B?TWFqTmpIWWV1aFo5b3ZTdDFjWWZkQVViVlBRMGhWbitGaG92NE92YVErWmh4?=
 =?utf-8?B?Q040WUtmcUJ1Q3RoTVo2YkJIb0Q3RmwwU04vQ3RMRUdDSGZSakJVZjBJRUFk?=
 =?utf-8?B?VGxET2EzZ0ZYRWw4VjhvYXI5MDBWR3lzZUw0QXdHMTZlYjVsM2pac2dNMnNK?=
 =?utf-8?B?TWFDNXd2c1RPWmdWa3Q5cHloMmE1UTJseFdNNUVNcTE3ZWpVYjRkN2p5Q1lN?=
 =?utf-8?B?Y2RBTHBFOFZJaGUxTEo3VThaSmNMb3BscHRUQ015U1JDeWhMbDQzUS9TajRG?=
 =?utf-8?B?N3RxT1d0ZFE0RzhKcHh3U3NoMHMzTG5qL3RrY29nY3BTMGlBUThCOU1tTDNF?=
 =?utf-8?B?VU1BVU81YUhIQjQ2WFU2WXRod3V1QkRWMStNbzREQzRFTGtybnhqeGc2Q3ds?=
 =?utf-8?B?Y0NVbCtmWVZOK0VvT2pmQ1lGZ0lIbHNDQ1FDZFAwdVpJbEdxcFF6aDlTSXow?=
 =?utf-8?B?VkdYaEsxSWY1RlJwSFFiRytpMUR5OUxRYWY1czNQZnF5dnMzbVppa2JaKy9y?=
 =?utf-8?B?SWR0aUd1Sy9qMTJ1WStyZjNOQ3ZnUUlJYVR1MGdIV2dPQlcxVE1VY1RPZVAy?=
 =?utf-8?B?b1BsSzdSdCtwcjRrV3RmN2hPd09BMzlKVStnaXl5Ri91ejRydW5QT1lnUllH?=
 =?utf-8?B?aWRMM0FYZFJsMEQ2bEIvZnhNN0VtRUdlVStwZVE4ZVcxMkFFWEExNExTL0Rk?=
 =?utf-8?B?V0tmYnpwcFZ2L01kNDFxNEV4Y0I5b3R6bm8vT1Y3eDdQQlVZVHIwcVJBL1Rl?=
 =?utf-8?B?RURiUU1NUkdwTnVVVmx2TkIrSzM4bm9laVo2c1ZvcExTcUFTZ1p2Q3BzamI1?=
 =?utf-8?B?YnlDWVV0MGlzN3dteVU0eFJWajN1azhIY1VOVzJiVHhoc2JDYVQ2YXlsVUdZ?=
 =?utf-8?B?L1lYK3JrTDI0WHg1Q0VpOVEvSXVmblBGR2VQdTVXak5CL1picDh2MHJuTUFv?=
 =?utf-8?B?Ykk2QkhRaU1CQlgrUVJybndkc0Q0dFNSN09JNDQ5M2gzbUEvRFUwNzgwSzBi?=
 =?utf-8?B?cU9xTFg5S014SUQ0Vm95d0VLUHlNQkFZNDJVd04xUWdMdDMvVWZ4R09rYmd2?=
 =?utf-8?B?b1I5T3JrVWluN2NtUllyelZXT2RLV2dna0FMYlBWODV2QitoOXYyaGx3VGFM?=
 =?utf-8?B?SzlMM3dOZmZIZWZiejZSbmZEU2x4MnpIQ09OZGtjM1RUcWQ1b1k4TmdsWVBt?=
 =?utf-8?B?N2YzVUJWdlFyeEtLRERkYkRVTENja3Z6WDFKdko3djJiUDZFTTVZNEFrdFI1?=
 =?utf-8?B?VHN4ZmE3SHlZc0d0ZnM5WDh5Y2J5REpmaUpLbjFtWktwSU5IZjZvNnBZS3BD?=
 =?utf-8?B?NmZlaUVYWUw1RllLWVFSUzBnaFpNQW5SejZvREpoczhFSVQ4UTVvT2JpTDlq?=
 =?utf-8?B?bjBjd0JEU2tCQjlYMVFWUUJiSFdDN29ZRG9meFBZcGZPeHZkNEFDeFR5NVVO?=
 =?utf-8?B?WWlaUjV1Z1dXNUtmVW1HNzNLUm0zaGpTYUI3bnBQVklBc0QzYVhVV3oxSU04?=
 =?utf-8?B?MjBLWlpWVXB0ZkdlcTdiaU56ZjlxQ01VUEpJZzZxTmNHelJFS29RNS92RExq?=
 =?utf-8?B?eXdxWDZNQUwxclpWM29CU1pIU1lhT0dTdXJLWUp5dFhhc0d0eGg2MG84LzBo?=
 =?utf-8?B?QmJFN0x2TGNiYnc4R3QraitrbTJpSittbFZvWHZlcTQ5ak9TY2cwZlp6d0ZG?=
 =?utf-8?B?Tnc3dHNrWHpNaW40enZSdkFJVnMyZlUyUGk3NG84aGZFOG9VZFlYK3g3ZVhE?=
 =?utf-8?B?V2JhcTFJNDlZNVlaVTY3SGhiKzVxalVVY292UHNOYUNOUFNjMmpONzBqV1ZJ?=
 =?utf-8?B?M2pJVFhBYjdBQk9XbDBWTXRMZGxxbVFHWW1wTVg2NGVITEdBL2tUV0VJdE93?=
 =?utf-8?Q?owsy+a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnprTUhIY3BYdzFISUZTbDJNTU9UeTRqUzdUOWhqWTlrVzR0Sk1RTE8xR3ky?=
 =?utf-8?B?aWhNNE1ndW40QitwRjFqa25WY3did0JPclNURU5QV1FQVEJBREtVVnNBSFNV?=
 =?utf-8?B?eGpqMUhtK1dNTFlTOGtXVENjNE1ZQU1jUWtQVnlVZjcxMDhVZ0wyZm43Yk1a?=
 =?utf-8?B?RzBiVXBDVHMrS0JFYTVaWE44S0hJUTQrc0lFVVk0L2lXdXFtS0luWGYyVFlJ?=
 =?utf-8?B?RU5aUjBYMzEzem5CaWdSOHcrQnlzTlc5TW5WSWF1NndOTXYxOFBFa00rTW4w?=
 =?utf-8?B?ZEpNZTl3RkQvb0g2cHBlOGNKTXhuRE1pWnpWb1FZVk9zTE9RNytSR2xBYk1D?=
 =?utf-8?B?TXYwamZUVk1YdTc4WDA3dEpkUklUU1c3aE56c3NuUDUrb1JjaXBwY0tLMk0y?=
 =?utf-8?B?UTE3MGRoTjhkd2pNVTlkTkk4cStuZ1JteEQ1ZFNSQUdqeWpjK1dZRHFnK0ts?=
 =?utf-8?B?RGlVUmNGTU9WNUQyWGdwMkRiYnVpZ3FUb2o1UThBaUY5NEJmcWRpQ3h0emdz?=
 =?utf-8?B?RERDbHoxbkZMYWRLS210K1kxVGdwc1pkQWVsUjRWNEdPeENnZk05V2hpQkdi?=
 =?utf-8?B?R3c0bTNleGRvQ0Z1blZnczY0UDFoVVVOUDRJbkQ1cXl1MWFCaDRTRk8xVDUx?=
 =?utf-8?B?SkJtblJkMElmWE8vVC8rTmNDb1kyRUZkTThHYVBqM1MwaGorVG1VNnh0eUJU?=
 =?utf-8?B?enN3N1RnaUxJd3dkM2t2aW5waW93dkxBSzNGMm4yTGMyRHNxdjk3VFdrcmFZ?=
 =?utf-8?B?aTJsdnB6UzB5Yy80OENzazd6K2V1cWFnWEcreUFYQTQwSlUzLzJGZTVEc2Z6?=
 =?utf-8?B?WGN1UDEyR0QvVGJUNkJ5bEd0NWtMRldSaWpnR2hnWkpxdzdTcXhpakYrelVK?=
 =?utf-8?B?R2FaV1FuM0s0K1kyQVBlRmRpWjlJaldsZkRibXZjTUtYV1pWTjBJRHFXNC9N?=
 =?utf-8?B?dHVPblpMSlliZHVSbVRTdUZjMUl0YjY5ZVVnYzhsTlMydlNWc2xxczdnVHU4?=
 =?utf-8?B?RjYrbUtCRlQ4eHdxYnIvdGJ0aHROZ0xiVDh5N2d0ZlBIZnAzaWRnZWFNREZJ?=
 =?utf-8?B?MVArdVZTcDFGTlVibndidDg4L0I2VHh0b2FLSmtaTmhpdUhoVTJLZmpBR05Y?=
 =?utf-8?B?dDJBbDQ3ejNhYTlwS3l4b2FiUlhzcXF5MERhVVJPUlorK3ZXRzNFNWZseDQw?=
 =?utf-8?B?Smhsa241UUFKcGpLdytHNmJYYWhLYUNGTytoVWhFSThoeGFTbEFFK3dJUytO?=
 =?utf-8?B?cTIvc3g4OVJaSHhNTVI2aXg4OWd3M0ErR3Qwd1BhcGZ1VlZPY1lLSkdZUDMz?=
 =?utf-8?B?NHpaK2lkajV6T1puc2tDSzhzNEV6VVhjeVhudTM0eld2NG53VGFrV3lUNFBS?=
 =?utf-8?B?b2F1VVF6d2Q5S0VmTnVGN2ZWblRwS0pOLyt6WmRuNy9BVWhNSUx3QUhWYy8z?=
 =?utf-8?B?U2lISHA5dXAxUGdOeWRwY2Q1RWVRSFpPTmp6U2EvbTlIMkpRSVhUa3M4Q1FC?=
 =?utf-8?B?a3Bzd0ZjWjFtTXh3RzV2enFObURJeUVRZmZmamFSd2dOVjFMY0dRb2k4TCs5?=
 =?utf-8?B?dWk0b3lPU0xpT1JVZllublRvMVBSSlRnS2Q2RlNMQTRwOFU2OUFxRC9JV24v?=
 =?utf-8?B?WkN2M3AvZloyU2pPQkJHSFV5dXE0YTlkK05XcksyODUrcTVSODJocURoTVNI?=
 =?utf-8?B?Q1hDcVh4U1lNTXYxWE91NnMwZ3o4SlZyQ3RoT1NQZnJJNzFCeHVaT1NpaDcv?=
 =?utf-8?B?TTRjQ2lDTDV4aEJFa0FMWVQ2c3pQcDVoeXo3Q2d0eDBhZW9DbGQ2NDZtZXYz?=
 =?utf-8?B?ODlMQlpJOHl0L1g4K0dhOGdURXk2ekZwSTJKOEFTNWpxUVI3M0hiaW5TTWR5?=
 =?utf-8?B?TWRnTTlDcEFiOTg0aEtUL3JvTFlxVGtkMTVKRzVUcDFSdDRTYlVmaENrblpX?=
 =?utf-8?B?Sm1DYVpqbThTZElsUGJkR29aSDhTREN5UGpFYWVpc3o1T2pyQitYZ1ZqOTdj?=
 =?utf-8?B?UWVTNEV1aWpoSUpRdlgwYmJNMUN0QTREcEtrVFJ0VkpFR2lGZkFvOWRYVkJn?=
 =?utf-8?B?NWd4Wk1aMUFUMEFVZFBZK09CWEFwWlBHK2Z1OVg2Sk1vY3JSRHdZTEpsaVZI?=
 =?utf-8?B?cmRpMjVuM1ZxZmZhTXJtYkxIQkdybWh0cnZ5UlMxMEp6UW03ejl3U0w5TnJu?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0898dee1-45b8-4baa-e5e1-08de324e5997
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:28:42.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlENvg094ZzZD7+FoIy0Bo7KGcFKOoA6lsYtoMg/K1u+Num8yvshPdbQNK85Eowrk7zImjAlpcYvmCM8+uuOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7422

Support configuring output calibration value. Among the devices
currently supported by this driver, this setting is specific to
ad9434. The offset can be used to calibrate the output against
a known input. The register is called offset, but the procedure
is best mapped internally with calibbias operation.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 2d8f8da3671dac61994a1864a82cdbef7f54c1af..48c10acb1566ba471be0804e7c39b0b553d76188 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -145,6 +145,7 @@ struct ad9467_chip_info {
 	unsigned int num_lanes;
 	unsigned int dco_en;
 	unsigned int test_points;
+	const int *offset_range;
 	/* data clock output */
 	bool has_dco;
 	bool has_dco_invert;
@@ -234,6 +235,10 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return 0;
 }
 
+static const int ad9434_offset_range[] = {
+	-128, 1, 127,
+};
+
 static const unsigned int ad9265_scale_table[][2] = {
 	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
 };
@@ -298,7 +303,24 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_shared_by_type =
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_shared_by_type_available =
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	},
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
@@ -367,6 +389,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
 	.num_lanes = 6,
+	.offset_range = ad9434_offset_range,
 };
 
 static const struct ad9467_chip_info ad9265_chip_tbl = {
@@ -499,6 +522,33 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 	return -EINVAL;
 }
 
+static int ad9467_get_offset(struct ad9467_state *st, int *val)
+{
+	int ret;
+
+	ret = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
+	if (ret < 0)
+		return ret;
+	*val = ret;
+
+	return IIO_VAL_INT;
+}
+
+static int ad9467_set_offset(struct ad9467_state *st, int val)
+{
+	int ret;
+
+	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
+		return -EINVAL;
+
+	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
+	if (ret < 0)
+		return ret;
+
+	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
+				AN877_ADC_TRANSFER_SYNC);
+}
+
 static int ad9467_outputmode_set(struct ad9467_state *st, unsigned int mode)
 {
 	int ret;
@@ -802,6 +852,8 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
 	struct ad9467_state *st = iio_priv(indio_dev);
 
 	switch (m) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad9467_get_offset(st, val);
 	case IIO_CHAN_INFO_SCALE:
 		return ad9467_get_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -836,6 +888,8 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad9467_set_offset(st, val);
 	case IIO_CHAN_INFO_SCALE:
 		return ad9467_set_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -874,6 +928,10 @@ static int ad9467_read_avail(struct iio_dev *indio_dev,
 	const struct ad9467_chip_info *info = st->info;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*type = IIO_VAL_INT;
+		*vals = info->offset_range;
+		return IIO_AVAIL_RANGE;
 	case IIO_CHAN_INFO_SCALE:
 		*vals = (const int *)st->scales;
 		*type = IIO_VAL_INT_PLUS_MICRO;

-- 
2.47.3


