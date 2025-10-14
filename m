Return-Path: <linux-iio+bounces-25054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10302BDAA8F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 427B84F5CC1
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71C304BCD;
	Tue, 14 Oct 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvONXWFH"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9DD30504A;
	Tue, 14 Oct 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460046; cv=fail; b=WKxpcbdccsTABZ/eNNyMrLqDBYcRIAyVVfh3nzG/iX3aQOK1uU+vBLCkzejHfil9EfYrrHAesoWRqptPIDHQcl6+qxWzL1Sug3w4fYt3QPeC2NryRY46rXkRKe/Wy3TzxCklp0A5r281L2MjMYICPrZqp3YJq/6YInVGIQgtlJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460046; c=relaxed/simple;
	bh=S4cmwi0Zb9OvyerJxr9iDPquvI/H8Jpzz8FRijLe2O0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FN2Bcdi6qrm/DAjO1Xm0JUhI5xgWTRYlLNSUsFBqgxmJL6OsWojvT5GdP3JYLRLznMVIhbTnm2a28rfWc4NYQzYecjGeXOiSVeKXTprZB8+MYd87pCiiOpKd4bDVZHyGAM54zBSwfCIaNE6v8FAB6WcP3TioCXstiVjvBbiyt5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvONXWFH; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtgGiBw92DiUC2alfYMavp9vnfo2r4GYnyAYHuhODYNtItOHPVouNOpFRk5GdsUZcHpegxs/JbZWpQJyfQhQKp5LYmPsMAvA2YtfGRQd/Rqb56CIlf7qQHJF/ZaKviv0BF0u869jWKg+U1ZFboRhLWTGnW2gzuBL5BwcAbolImgmO3OrFmR+DEb1RN6T+PCPDM4ZTXHv4CzVzXPs9TqMa1GPBePywDBCxcu/3ID3dsW9wOp1ToL5+7gdtyEd+LwygzDaDzURyaRrrVlLnc14qWLm6xA21B8+SyJmX1o1dy3+a0UKbwqBkfA9Q0FrQE3LILQhxLj/vfnmQ67XsjpXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hcgUbhtwyKwTClhJSo+50RKbY5vfmhiYaETL7Pe1bY=;
 b=TiTCIpg2nODy9y+Qqpc/G2HG8B+c+RKyMxVZ3+nImGCqCnacj4H8TC7a9rZBSl+j6w0Us+OiFOXoHg8Re3YXXC1mracI2sVRPkHXeGT2ncO3oqYKLnzXrYWHN2Zv9dZRckM0ki2vfz5vEmij+iBcKEAvwT/r9l/nsT5dPoyhUyuH/2vnowT0xRhYbeKW99HXPcsOP0H4TbAcIxsNI4yM0MAsZfYoORV1B+kMXx04fbPxn7smFHnH9eULu0jljCi55sK6rRhhdmT2FmjyeECyhve32AXbBfVJzeIGrmBNQX05dB4JLiuZV3o455T09gLRd5cJKWfmy7mSncxXYr4KvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hcgUbhtwyKwTClhJSo+50RKbY5vfmhiYaETL7Pe1bY=;
 b=JvONXWFHt3dowtOUvq7u7irLswxH0AuMSywsWsxuMOhHrLJqNMLaw0LRVaA2SL408xyQV8c70xauu3uNnD33eurbc4QytwXNnYANHlvDkfBYwlkkebRdBByauK9SxDvIvdsAH5GkB1tMwewFEMazxOhcZTGqZwQxgVmVhMe9CS5Hd1B7JfHsi5hVJUAf6FZ3j1QFIqnzr7Yi0VjSR+/W4u9vH93KfBzt6xaMQVaj8DE1hrGFNehoPA7EgtXYJBbxkskEGS91pngvCKJy0hLtF0ran+Zfesz89aG36Lo7JheBiUnLo54H6lREHDXzKadUY3YBv/rDERLYm1blWxTgEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10946.eurprd04.prod.outlook.com (2603:10a6:150:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:40:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:40:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 12:40:04 -0400
Subject: [PATCH v6 5/5] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-i3c_ddr-v6-5-3afe49773107@nxp.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
In-Reply-To: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760460014; l=17961;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=S4cmwi0Zb9OvyerJxr9iDPquvI/H8Jpzz8FRijLe2O0=;
 b=7BGn+3LLXorrAcOvqe5yTIdq4nhePObej8EtfwfXEd9tyG9OipBQzVZaZiTDyWpjICRY6k/1z
 UmhmqNsxaZUB9aShHDNutrb6l1lFw8X2RaittPBhEMZVOLync+dgkBj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 892207b3-599d-4f03-670b-08de0b4068ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2h4WXRyQ0pydzJiQkg0Zmpnb2FWUlJoQ0RFNDZXbE5Sb3F3bGZ3Ny8za2FK?=
 =?utf-8?B?aW9RNCs2TlVzNWk5MkExR1k1N3JMUzI5TWxRWmdxRkFmS2dlTkQ4MnQ2RzFE?=
 =?utf-8?B?RllwaGh1U0tDaitjMHZKTVlyQnhUUlZCQS81U05RaHord2N0aS9QR3F6QTZZ?=
 =?utf-8?B?OHdlSXVFb3RCRjM1K05VT0pMb0FWK2x2WFR0bkwxMDBuN0FpNHJBdG1ySVRq?=
 =?utf-8?B?djl5YmwzU0ZscWVzZllQRUR5M1BUQnUya3pTVkljd292SkxzU0p2TC9MTHg1?=
 =?utf-8?B?QmI0eDBwbzFtdHVKalk4WE0xWTI1eU0zdTJ5MC9ibU9SL291WldLbHpHTE1l?=
 =?utf-8?B?b2JvYm45S044NjM3b2F2YklteTcrSzdJWFh5cFBsSWI1MGdPbUNhUFI3SVpN?=
 =?utf-8?B?c1lsTzk0d2g3SHQwN08wZmJqUW5OV1ZoNEQyeVRFN2VlbndXc1BCL1hJU0Yr?=
 =?utf-8?B?ME1WT0E5OEp4U0RKbHJsdXRKUXFvaVFrVTY5aFdscmpVOVZxWW81NUJGYnE5?=
 =?utf-8?B?Q1N0TVJCUlE5ZllNemt2WG8raTVuMjNlZTNseXJGaVNpSjBjN1hlLzJjeCtu?=
 =?utf-8?B?Y0tBTDR6aXQwWktSekxZeVJoNFREMVNOUEtuQWM2K3BmN1E2TzVyNTRSZWpm?=
 =?utf-8?B?RTh4R2ZSVFloc2hsRjdpeWhWOW40ME1xMmdzWEg4dVMwMm1GajBELzVuOGxo?=
 =?utf-8?B?anJocXJmNGNtVG1wL3dWVnVxNWdKL0ZlN3RJTWplZW1ROU5UbTdSQjZiMmx2?=
 =?utf-8?B?OVRTWkNVRE5wOFVqa2VqL1p1RlZZSVBHOFBzcmJSZ0RwUVdFRjJGUWw3WDR3?=
 =?utf-8?B?MmIxdnR1QlFLMTJnbGN5eFVPcTRDdXh2cUxiNEU5bHFJNHpJTlZXemU0bUQv?=
 =?utf-8?B?c1dNMDNjbWhaY2tIQ293TmNEQXdLcW1MelgrK1V6SFR0Q3lKNmZvZmlXS3Ir?=
 =?utf-8?B?VUUyRHBMTVk2bm9waWhrczZ6R291SkxwMDIxbGNwSXlDd21YdTljUk81Y0JZ?=
 =?utf-8?B?bmJrck9EVFNicWc0dUh2OG1wWUtpMFFBSFEwY1JqQUV1VXhRZy9nU3JpeHJv?=
 =?utf-8?B?VFQ2bnBzelZ3bXdRbm9YZVpja0F4MVVsY0k0OWI2bEdNbVFkeHdMdkVnbFVS?=
 =?utf-8?B?dC9iMlUxN200cDFWeGxQNXBQUU5iZEhKbTVuQTdXNXN5M3o3QXlRRG9jMWpY?=
 =?utf-8?B?NmRWRW5SWU0zM1dlZVkzUHZYTENQbkJkVzNhc0dYUkx0WGIya1JWWEVvTlEz?=
 =?utf-8?B?U3MyS2hmU3IyN2d2MnVpZFRENStvZksvQjNLbGZRNlV6Q0JVWE5CZzFUdVBh?=
 =?utf-8?B?dGlPNC94Y0pMZlE4QlRiQXNhYUV4Z0hEWkZzb0dqalowOTVVOFlqYUk2UkNR?=
 =?utf-8?B?aXcxTlAxWEI4eU1KYkRDcS9KRVdGS3RxRlo5Y1J1eVRyM242TmVUakl0ZVNM?=
 =?utf-8?B?dlo3YktNSi9ueWpqZlAyR2dNLzBsL1pQK3FBQTY4eUpSZE1QNkZObnN3RWNn?=
 =?utf-8?B?bkZ1WEh4czRoZmRBRjdoVmhoYTRBR1JUeEJMZm9VV01kRTdsSmh6N1dLU2lC?=
 =?utf-8?B?TTJjSklqUjJ1T3gzVUxuQmJzV1hXajVVeGU2cS9qRjlpRTZ4WFJjQzZ3MHhj?=
 =?utf-8?B?b2FyaTRYY0hGWHlBU3lIVmRuZ3ZXRWxTTUljYWV2OUlwOEpTUE4yaWQzMWVi?=
 =?utf-8?B?WDlWVFBDRUcweHhIT3Q4bnZ2S1V2UlR6STlIV2ZmbXAyeU5NeHcrd2QyUy9I?=
 =?utf-8?B?M3UwUGVBeTMxU3VJLzFDUit4NmFrQ0x3RFpHa1I3OW1MRWtOc0lTVmJJVHBY?=
 =?utf-8?B?VnM0aENLeFhQdmxMZksvYTJCeDR1Y2JjSjR4MWZDSE9rbGF4QVo3ZHdjcVpT?=
 =?utf-8?B?blBtTnNGVzdsQm1MTVBCQ0s5UHp1eHpFV2NJazh1S3NPeFdwQzY4U0dQd01K?=
 =?utf-8?B?c3Y0WVdXYkVNVjRqM2gwcHF6blpVa25YZzBrSkNxcXdyNytXZDVqdHZEelBS?=
 =?utf-8?B?dnZTcXovNmJRNVZRWlBpMUNmS3BnWk5tNWo4a3VnT2VNSWlYYXB3UHQxOU1w?=
 =?utf-8?Q?Rz7ykW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTRISjJBdzFWemxCYTZpMjJMejRsanc2akNrODRTM0pJdDRKSGh4ek1wNGFI?=
 =?utf-8?B?am02bTFUN2FqanRUSjY5MUV6MEV3bUJkb0pNaXNGL0NPWXJad282ODAxVkhn?=
 =?utf-8?B?d0NMeERqblVMcTFoTG10c05qS1NKWFlMTU5SZ0tSR1ZYWkZrbTlBdTJuc0F4?=
 =?utf-8?B?NCt4cDJkc0s0NUtQM0JuRk5yZXFrRVVja3BROW5ua1dwQWVMampXQlNicUdr?=
 =?utf-8?B?cFREWHA5UGxmYzdKZUpicGYyam1pYkg0SU1YT1BoTG1ndndBYm43VWpLb3RZ?=
 =?utf-8?B?TkNPTkViTnpMYzJoVjc0aGR3bjVOOU5uNy9SVmZ3ckhsSEl4Y1J5cUxST2hT?=
 =?utf-8?B?ODF4MnBJclRGa1ppb1I2R25zWmlQa1Q3T0hySk5TNUNFN012NXJaWFFqNERu?=
 =?utf-8?B?SHl2ZktEbnlZSzUvYlBPaTloUUZYT3Q2NVl3ZGlNOHpMRTVjcjU3S3Nqb2Jh?=
 =?utf-8?B?MHdYUE04UXFYV0tEVVZ5RFpxUGVlQmM1azd4WVJwMERSRHVvby9GWkhDd1Ri?=
 =?utf-8?B?YnNGaEc1N3JRQUxWeUxiL3VpTjRLZjNXT1BaNDVjWGVZa3pqbHJ5UDN0RGRM?=
 =?utf-8?B?TDhGOWdHV3krcloydHhoT3A0M1FzaTRibnZVbFIyaGNjZ1VaZW1Cak00dDVE?=
 =?utf-8?B?UkRyWTFMbGlsZWxnY0xzSmFFSUxMUXVYTzZpRm1uWjl3Sy9Bb1BvdTA5MDZn?=
 =?utf-8?B?NXl3bmNpb2RtcHRXaEJhUU5RekxIMUh6L2NHbUVoZjhIOHlpVDBYM1cyWCtX?=
 =?utf-8?B?SC94dzlENzhDYWgwQnhkaHh3Z0F2WEhVTkVrUVBTbUhwa3ZDTElCeDBqSnRF?=
 =?utf-8?B?WU5QbCtiZjd3UlNqSDZNSzBHa01Ydk42N2hOUVc0bjZyU0MwY2lBdTZob2xv?=
 =?utf-8?B?YVA5c2dTWEYwVi9QOWx1YWxOM3FZYW1JdjlOVTF5MVN1MnFhOGRNUGxuc0pw?=
 =?utf-8?B?Rmt1a1ZiVXVxTnJsMEFsY2ppVS92ekViTlVCYUlUUWc0UlhXcE9aV2VOcFgy?=
 =?utf-8?B?WEJuaC9yaGNFNktLOG9yeldhamx6ZnNDSFF0Zkcyb3EweW9vVE10dFpORHV3?=
 =?utf-8?B?UUpKTk9ERW5oelc1eE1YN3ZtVFkza01Ib3ptcDZuemtyK05pdE13SFcxZ3lE?=
 =?utf-8?B?YVl1SHh2ZWhoNEcwSTJwVjF4S2Q5aTh4cTNiZ2Zwbmh2bjBSdzR1QXoxeFRr?=
 =?utf-8?B?SHd4NnpVdFkzdlFtMEVRdnBrNjI2Z2RydTQwcDZjWUFuclpGaXhFY2hJUVRK?=
 =?utf-8?B?c3htOUJsT0NiREUxMDlCNGpha25NUStyVUdTMVF5THA5SkVrdkI0YjlZMEVh?=
 =?utf-8?B?bElsK3U3WW1GVFI5TENxdXBYMTNXekJneEkzQ2xINmZYZk9vZ05Jd1NRRzhY?=
 =?utf-8?B?aGw1TTNSbHZpVlREU252YWtvaUtFS3FTUWFuTm9ia01EMU95ekgyVlNoZWN3?=
 =?utf-8?B?Zy8rdlNPdG1rSnN0cjdsTGRIYVNoWjA3TU9pV1JpTjdIZDIxRnZ3OGpTRzVS?=
 =?utf-8?B?VktKYmZQQzZHS2VjWW9iRERCUFUyaGt6eFdvQ0ZUd0EycnN6b2ZnY0lpa0Rl?=
 =?utf-8?B?VkN1YVBDc3NWQWwxb0hvYThaOHd0Nm5MTnJnbHM3a2xpMzh1YTZleU9OK2lw?=
 =?utf-8?B?dk4rckZ0enZsTk9NdllSZklzSDhjYy83aTlZT2tzWkZ3S2dRSHFuRGh6UTJy?=
 =?utf-8?B?VFJiaUEyb0xNeUMyY0dVWXV5b2paZHVjdDJmZTRDd0Vlb0RiTDNWOFdWcWt5?=
 =?utf-8?B?ejduRHlVNGRQS0pVaTB1ZXJ5RXB4U3dWV2doUHMrRzFmWXdoRkE1R3RTSjdG?=
 =?utf-8?B?OHBwWWZZZHc2TG1hdmhiV1RPTUdJU0xtQ0hYQWp0czBFV085clRNMURkdGRL?=
 =?utf-8?B?OHM5Z1lmbisvRG1QMHBZVEEyQTZBME9NemQrSk5VVTNhTm80VUdqM3NqTWRV?=
 =?utf-8?B?R1ZIMkdQWEFqMWR0TkxSdUtTQkNOTE40TTlIVEo5SVdqYzlaVlVUOHNDNStN?=
 =?utf-8?B?R1hhdEhLalFIM2tlQXZaMzBIZjNEUnBNd1E1Mk1ZR2xqYldKbDBWYklVUWdq?=
 =?utf-8?B?Y01rVlQ1N1NvM2RYMTdKaVJsV3RvalpHTi81T3o0U0hQUWVnb0lTbHQraHNl?=
 =?utf-8?Q?/Mj5WO2/rZNI8kKNQ3jSQo2mU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892207b3-599d-4f03-670b-08de0b4068ef
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:40:40.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngBYzZZXl0ymwoTowKYH1NV5TKH5bzAyT3zSRLwank/lfHuam7XdwpV7yWSvJhuWunvvYUPTRChaodjBuoYguA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10946

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v6:
- remove acpi part
- return 0 for success path at mmc5633_write_raw

Change in V4
- use { 1, 2000 }
- Add _US for timeout
- Use GEN_MASK for MMC5633_CTRL1_BW_MASK
- Use { } for terminator.
- remove !!
- fix mix tab and space
- add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
- add tempature measure support

Change in v3
- remove mmc5633_hw_set
- make -> Make
- change indention for mmc5633_samp_freq
- use u8 arrary to handle dword data
- get_unaligned_be16() to get raw data
- add helper function to check if i3c support hdr
- use read_avail() callback

change in v2
- new patch
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5633.c | 571 +++++++++++++++++++++++++++++++++++++
 3 files changed, 584 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,18 @@ config MMC35240
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc35240.
 
+config MMC5633
+	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
+	select REGMAP_I2C
+	select REGMAP_I3C
+	depends on I2C || I3C
+	help
+	  Say yes here to build support for the MEMSIC MMC5633 3-axis
+	  magnetic sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mmc5633
+
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
+obj-$(CONFIG_MMC5633)	+= mmc5633.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
new file mode 100644
index 0000000000000000000000000000000000000000..c862a85a06c1786108cc16d31c93a12997df5578
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5633 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ * Copyright (c) 2025, NXP
+ *
+ * IIO driver for MMC5633, base on mmc35240.c
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/unaligned.h>
+
+#define MMC5633_REG_XOUT_L	0x00
+#define MMC5633_REG_XOUT_H	0x01
+#define MMC5633_REG_YOUT_L	0x02
+#define MMC5633_REG_YOUT_H	0x03
+#define MMC5633_REG_ZOUT_L	0x04
+#define MMC5633_REG_ZOUT_H	0x05
+#define MMC5633_REG_XOUT_2	0x06
+#define MMC5633_REG_YOUT_2	0x07
+#define MMC5633_REG_ZOUT_2	0x08
+#define MMC5633_REG_TOUT	0x09
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
+#define MMC5633_STATUS1_MEAS_T_DONE_BIT	BIT(7)
+#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
+
+#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
+#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
+#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
+#define MMC5633_CTRL0_RESET		BIT(4)
+#define MMC5633_CTRL0_SET		BIT(3)
+#define MMC5633_CTRL0_MEAS_T		BIT(1)
+#define MMC5633_CTRL0_MEAS_M		BIT(0)
+
+#define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
+
+#define MMC5633_WAIT_SET_RESET_US	1000
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0X05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	MMC5633_AXIS_X,
+	MMC5633_AXIS_Y,
+	MMC5633_AXIS_Z,
+	MMC5633_TEMPERATURE,
+};
+
+struct mmc5633_data {
+	struct device *dev;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+	struct regmap *regmap;
+};
+
+static const struct {
+	int val;
+	int val2;
+} mmc5633_samp_freq[] = {
+	{ 1, 200000 },
+	{ 2, 0 },
+	{ 3, 500000 },
+	{ 6, 600000 },
+};
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = MMC5633_AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = MMC5633_TEMPERATURE,
+	},
+};
+
+static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
+				       int val, int val2)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i].val == val &&
+		    mmc5633_samp_freq[i].val2 == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id, ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret,
+				     "Error reading product id\n");
+
+	/*
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret < 0)
+		return ret;
+
+	fsleep(MMC5633_WAIT_SET_RESET_US);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* set default sampling frequency */
+	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				  MMC5633_CTRL1_BW_MASK,
+				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
+{
+	unsigned int reg_status;
+	int ret;
+	int val;
+
+	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
+	if (ret < 0)
+		return ret;
+
+	val = (address == MMC5633_TEMPERATURE) ?
+	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & val, 10000, 10000 * 100);
+	if (ret) {
+		dev_err(data->dev, "data not ready\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
+{
+	if (!data->i3cdev)
+		return false;
+
+	return i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR);
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
+{
+	u8 data_cmd[2], status[2];
+	int ret, val, ready;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
+
+		struct i3c_xfer xfers_rd_data_cmd[] = {
+			{
+				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
+				.len = sz,
+				.data.in = buf,
+			},
+		};
+
+		data_cmd[0] = 0;
+		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
+			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ready = (address == MMC5633_TEMPERATURE) ?
+			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val ||
+					status[0] & ready,
+					10000, 10000 * 100, 0,
+					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
+
+		if (ret || val) {
+			dev_err(data->dev, "data not ready\n");
+			return ret ? ret : -EIO;
+		}
+
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data, address);
+	if (ret < 0)
+		return ret;
+
+	if (address == MMC5633_TEMPERATURE)
+		/*
+		 * Put tempeature to last byte of buff to align HDR case.
+		 * I3C will early terminate data read if previous data is not
+		 * available.
+		 */
+		return regmap_bulk_read(data->regmap, MMC5633_REG_TOUT, buf + sz - 1, 1);
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
+}
+
+#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	if (index == MMC5633_TEMPERATURE) {
+		*val = buf[MMC5633_ALL_SIZE - 1];
+		return 0;
+	}
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = get_unaligned_be16(buf + 2 * index) << 4;
+	*val |= buf[index + 6] >> 4;
+
+	return 0;
+}
+
+static int mmc5633_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	char buf[MMC5633_ALL_SIZE];
+	unsigned int reg;
+	int ret, i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = mmc5633_read_measurement(data, chan->address, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_MAGN) {
+			*val = 0;
+			*val2 = 62500;
+		} else {
+			*val = 0;
+			*val2 = 800000000; /* 0.8C */
+		}
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = -75;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
+		if (i >= ARRAY_SIZE(mmc5633_samp_freq))
+			return -EINVAL;
+
+		*val = mmc5633_samp_freq[i].val;
+		*val2 = mmc5633_samp_freq[i].val2;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = mmc5633_get_samp_freq_index(data, val, val2);
+		if (i < 0)
+			return -EINVAL;
+
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+						 MMC5633_CTRL1_BW_MASK,
+						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
+			if (ret)
+				return ret;
+		};
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)mmc5633_samp_freq;
+		*length = ARRAY_SIZE(mmc5633_samp_freq) * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5633_info = {
+	.read_raw	= mmc5633_read_raw,
+	.write_raw	= mmc5633_write_raw,
+	.read_avail	= mmc5633_read_avail,
+};
+
+static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_XOUT_L:
+	case MMC5633_REG_XOUT_H:
+	case MMC5633_REG_YOUT_L:
+	case MMC5633_REG_YOUT_H:
+	case MMC5633_REG_ZOUT_L:
+	case MMC5633_REG_ZOUT_H:
+	case MMC5633_REG_XOUT_2:
+	case MMC5633_REG_YOUT_2:
+	case MMC5633_REG_ZOUT_2:
+	case MMC5633_REG_TOUT:
+	case MMC5633_REG_STATUS1:
+	case MMC5633_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct reg_default mmc5633_reg_defaults[] = {
+	{ MMC5633_REG_CTRL0,  0x00 },
+	{ MMC5633_REG_CTRL1,  0x00 },
+};
+
+static const struct regmap_config mmc5633_regmap_config = {
+	.name = "mmc5633_regmap",
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MMC5633_REG_ID,
+	.cache_type = REGCACHE_MAPLE,
+
+	.writeable_reg = mmc5633_is_writeable_reg,
+	.readable_reg = mmc5633_is_readable_reg,
+	.volatile_reg = mmc5633_is_volatile_reg,
+
+	.reg_defaults = mmc5633_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
+};
+
+static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
+				char *name, struct i3c_device *i3cdev)
+{
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
+	data->dev = dev;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &mmc5633_info;
+	indio_dev->name = name;
+	indio_dev->channels = mmc5633_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = mmc5633_init(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int mmc5633_suspend(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+
+	regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	regcache_mark_dirty(data->regmap);
+	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
+				   MMC5633_REG_CTRL1);
+	if (ret < 0)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(data->regmap, false);
+
+	return 0;
+}
+
+static int mmc5633_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return mmc5633_common_probe(dev, regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend,
+				mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5603", },
+	{ .compatible = "memsic,mmc5633", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5603" },
+	{ "mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe = mmc5633_i2c_probe,
+	.id_table =  mmc5633_i2c_id,
+};
+
+static const struct i3c_device_id mmc5633_i3c_ids[] = {
+	I3C_DEVICE(0x0251, 0x0000, NULL),
+	{ }
+};
+MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
+
+static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


