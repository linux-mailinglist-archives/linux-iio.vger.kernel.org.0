Return-Path: <linux-iio+bounces-25541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A3C11564
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 21:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8EBB505DAC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E842325493;
	Mon, 27 Oct 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fERJWjCl"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35730DEA2;
	Mon, 27 Oct 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595742; cv=fail; b=N/UNj+6IkAgeu0KyX+smcejHLuLNZggrzVQBdi29D/ENf/pHupCr2+c6VkxgbGZrvJ9bKZhKkn+4qx9gt9pwyt3iatTAvNgY40KQwXXV92pzCCU3HwqbRt3CqZ+NTuAN2R8ez0nYI3bBOwF4hjMkfpeGDnZAsekIwogMn6p3vlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595742; c=relaxed/simple;
	bh=qTffBCdu8Mi22zZGCzL0uFmkILG2U6LbqIh7+jK2h4k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aWwMgWNvSw2xmhfV1jp2+7s3UuvSxj6mga3+78yZEqSRswtfNkOyjc8lMOM4qGE+nI3FLhrdx038aIooM9smqTKEtXFyycUbFaX6NRtfvrifNZGDkuubTkap7eWPauCxoNX8nPzqzgOS4swpw9uBeevjCYP/m2fG6x/yh8NX/cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fERJWjCl; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx3omwlrmsVTeC/4ZoEbXYuq184+/nsXJwDD9dOwAoYIxis5/KSUn1Kq4TiwN0Vekd9wNRhBWznPKUaunDK33PP5Qg3U78KgLqKiYGaX5ZazftUGDTLEHDVfIPjXV81te8SLtAJL9K3yGc4Tm5bynS4oLEwnVz8x05jqyBG8NXD5dcP4CnUsQZKNoIeC+reM6kl5LeeUc+GHpVSU3W911iDlZ8dccsUjCZKgUEqDPRO5bZIxjd7jjgrLWKbpCYnZU3sX97kpjb1a3iwi9vmvh1EDHmiLl+cJBoNhuelDvvrxmC1SEqLGPxC1QV1r3nih3962UzTXO4fmL+v5DXz0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mizs44l9kM6gfuXuMhguTCgPiOcdxwSSLKRegAmEMuw=;
 b=j/9CHwi4uC5y1Wy2fq88g0Kr5FM/L3qnZsdLSJGyCMyl0+ZpJrQbyPG6lyUZvd8CJN9V5n3wuzTlq/c43wcYuZeIpSSDB3xT2Bv7IbPKYX3RTVKTeIfs3vOVRpxdZ13q85tiEDnapew2isd4vY+X4Ro73Dm+sYzFXat/ICIloiUUxOI4hP90AOTBefVAU05ZWG4Xw3ccay2jPfVoQTXDMokHnMyy9RgEpslq6XcCTKyWj6MBbRrgj+sCEoeGSvcaIIguzq+nRZ6fM9v016PjcdpTuJJ7z1vXbItJraV0hCKENtAzcSWqRxgqbHcIZqOtL9s4rCHnFck8+fHGMPzztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mizs44l9kM6gfuXuMhguTCgPiOcdxwSSLKRegAmEMuw=;
 b=fERJWjClHTrVo5pnqxeEiMNm/g6/wbrotGpkObONQrOn5IghS5u0+sKgP/MXDfa/q3JWZdJdc9Bi/sieEr6hPp17KGfoOJ5EE4AhAiQsQRyRWQJDy7zYofzNkzEZXferDm0SVT1YgeI9i21D4oujUWuuoihOVJI2ysEeFlcaHjhkqJvCxZxs9mV5stji256RN2Jh/enEMn/8ri1wQiUSKXAFQ5KVBzEGOkPimhwfxNJeoJ7LpZmMwIuHiY1ajFzxZ4IpmSJIZIjLFJJzW5ntGgeC9mQ3sLccW3ggc1zl/5Rq0+wR9BV+Z8BPAsmoOXhNH4kpjx9Md23ZfEzD/TW7vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB11919.eurprd04.prod.outlook.com (2603:10a6:800:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 20:08:57 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:08:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 27 Oct 2025 16:08:31 -0400
Subject: [PATCH v7 3/5] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-i3c_ddr-v7-3-866a0ff7fc46@nxp.com>
References: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
In-Reply-To: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761595722; l=9137;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qTffBCdu8Mi22zZGCzL0uFmkILG2U6LbqIh7+jK2h4k=;
 b=FVlZCFNkhGMvw1bDP7XujuuUGMc78nkT6wZaMtVMaahlc4MCaQROKnmtoIAKBwNG3BgMxV4zC
 6afGdOYyx9XA8kAao00qD80JrMswNKBp8+VvoQ64JK16JlvVoFhQuev
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH1PEPF00013303.namprd07.prod.outlook.com
 (2603:10b6:518:1::12) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB11919:EE_
X-MS-Office365-Filtering-Correlation-Id: b84ed79a-f9cc-4b3b-3c7b-08de1594a933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVBXWU9DS01abnh6aElJWjBtN2JDNnNEMC9LWUJwZEJmS2JDNXZvYjVhbUdL?=
 =?utf-8?B?Ty9oMzdhZXFreW96Y1dzSXZ4T1dJVlpCbnIrQVZCVmltMktIaFN2eHdtekc4?=
 =?utf-8?B?NlVGTWpWai9CSm5WcWZ0RGVIbVNSYVNxMGtDRG5CN3hQNmVhbGM4d0tDMHZh?=
 =?utf-8?B?TndUTkZpUFU4Y2x4UkM0YUhaMGFVdkcvV1FKaXhjZ2diM0J4RDVndlU2ZmFK?=
 =?utf-8?B?T2Iyb1Vmd0gySFJ4bjF5Vk11TkJhOTI4UTltNGZ1MmF2c3dYRXYyVjRGMndp?=
 =?utf-8?B?QUUzTGF1NjdnNjhZVUdDU29CU0JpdHZhckZVUCtlbG9LWElyYzF2bTZIRndT?=
 =?utf-8?B?K0pFUldpYm9lS2lNTnVXc2dZdGNWaE8yMDU2NW41akxwUVFxVGhpR3pWMThs?=
 =?utf-8?B?OUxNaVhoTFpFc0xQcFNhaVEvWkxXNnJrR25oNzFXMHpCY1JndE9FNEczbDVZ?=
 =?utf-8?B?dVBmY1lJeUViY2RMWDdVbWZaM3orckhFc0lqbHkyMW5yVXBnZ0JwVWRUckpm?=
 =?utf-8?B?Vy9DUHIvcURqUHBvYWNHckFCWUhadkwranlzVnNCUzQvaDQ2NW03SWh3Q3hj?=
 =?utf-8?B?TnBJYlhqVkJKNEMwZHVPWEw1WThPRmpoY3A0bzlBOHZtZTIvWmJmUXFOTWpr?=
 =?utf-8?B?UEQwRUFkc0liQWh3eThZdkRBLzFuVXBuckZOUFNjZVErREpoQzNXTm9Wdkk3?=
 =?utf-8?B?WFlIeFhycXdNOFpoMnNMOERXdlFGeHZFSFZzQUxJR2lXVzRWWngwUVlKSHNV?=
 =?utf-8?B?VTJsSXQ5VkYrYURDYThQV3Zwa0Q5NjdGREhGQzZxOFIyRkFZVFBIRGJwOXFG?=
 =?utf-8?B?b3Z6YzJLQjlkcXBMVUY1V2dVa0hQUDM2YUpobU16V0M2SnJhZjhOQUNnUmt2?=
 =?utf-8?B?Ry85R2xRZElwazBXU1VMWUxJOVNtTDIvcGpQcGxycnkyVCs3YTNqb3k5UzEy?=
 =?utf-8?B?M2hmdEM5eksxOWdKakIrbW83QUxWVDIrRXNqUE9ZcXBKb0JudndIQnEzS3pq?=
 =?utf-8?B?dzd4VlZNNklEMUNqZjdncHMzUGJEdkI5NU45eHVaYStwNmJVSldROVZ6NVQx?=
 =?utf-8?B?THBwUVdROVRObVJlSmlISDNrcDJPNzFIQnRsYTFTQ1ZEWWxTWEwyZXJVc2pk?=
 =?utf-8?B?UmM0R0FRRnM0RTF4UktDcWZMd2t1UUlEZUhCaHhrd0dCdmRjekhEbVp2MVVX?=
 =?utf-8?B?djRMNWhPbnBNVWN3Z3ltRGFJUmNFdkJIOXdSNXZLcFJucFFnS3hCcDdoVkxE?=
 =?utf-8?B?TG9iMi80Qm5CSG5kSWcxS1VYYnlQK2pxT2FCN3FZbEZCMVVTK1hPU0ZWVUlq?=
 =?utf-8?B?WGRNcVRGN0FDOVpQNEM1N1NTVXE4cWw4Z2ZieS9GMWl3QkptYXJDR3FUM1Fr?=
 =?utf-8?B?cWsvczB0cUZXOU1PQVVnTkVsdzVKK3V3UlFHZHEraTg4emZwUHJYT1VicWhN?=
 =?utf-8?B?b0lKSnQyVEtEendvcFhGV3A2OWJlTjNndE1zNWpLZjZmTW8yWmloWDRsMUg4?=
 =?utf-8?B?YWFpMjd3QzdienBZbk1HTXI0YWFCeTl2czJLWnRvOE9ZdlhkeEhlY3h1bXRi?=
 =?utf-8?B?Q3F4S241RHM3VEZodFBHMjQwMXkyS0diZUJGWlNCcHVBZ2RNajV3OEFKdEw4?=
 =?utf-8?B?UnpVdGNVRDJOSjZZY3JzdzJCQk53YjM1WXYxZk5rVEZueEt2UCtleFI4VDZq?=
 =?utf-8?B?NU55VnlmRkg3cWl4UytFMUZtNkdQY0VGVXJFSjVGalBSTTdLUUlmVjRlYWZo?=
 =?utf-8?B?ckhxNnJJOFFsRkhSY0VEeWQvQ01HR3VsNzZXMDVicEJLYW1yRWJuM1Q5UTR4?=
 =?utf-8?B?a2puUENwWURRVUJoYlQ2dmUxaXFKRGdtOXkzVE1KMUZoMlYzVzR5RGpvS2dj?=
 =?utf-8?B?NjFnd0QvUGc1RGh6aGkvbERMUms2dHcrdlJ4ZU44MFkveERhZmlDaUFqWHJD?=
 =?utf-8?B?MVJxT2JET0RHeTExY2V1V1BDdENEdnFrdkoxOUl5S3crT2pldnprQVJBTW5n?=
 =?utf-8?B?R2Q1MDBVUE4zMDRhajNTTVpHMFFLcUR3Q05hbTc4ZDIwdjVxM0ovZ3lJeHhs?=
 =?utf-8?Q?kALGAL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjhURlp0dVlIZXlrN3pZaXpvcFJnKzYzY1dJeXpLSFpGTzM3YVFGYzFyazNG?=
 =?utf-8?B?KzhhYmt6KzVFYkpGWTkyYm1NbkRMN1lMeG9FNGU4bTQydlV5SU0xYXdsRnZB?=
 =?utf-8?B?WjgzOXRYQ2R3SVVneU43Nkw0Qkc3WG5tSG45LzJpaEtPZ3FIMXI4UFRONkJY?=
 =?utf-8?B?RWdkTDlSbk5ZWlFad3d2WFlnbVdSTHVZZTV3Z1ZlL3lsUGd1cG1GOVRjM2Rw?=
 =?utf-8?B?eWJMWGp1TkRjS2FKZk42TnBVMUErSmxJdXo4NkdNYllEaE5OVnNQcTQ5dTdn?=
 =?utf-8?B?YnVXWkllaFgzVlNzRmplWGhzYU1URDlUN2ozV09KQXpiQS9oZDNDbE9NcVdp?=
 =?utf-8?B?L0Z2S2YwRjFCZUMvYitXaGdBT1NnWVF6b2g2UElGUHZScEdBMytGRW1OemYv?=
 =?utf-8?B?V2NJbVlGcDBXenc3c3pMVTlaRVA5ZDZkeVMzR1RVdjdwMEt2dCtXbUFldEpL?=
 =?utf-8?B?MUdtYkxLS083K0h4MXhBbmh6NUJhTmNxTFV4RkhYNmJYenRrNmppK3RzbVg4?=
 =?utf-8?B?elZsYUNwWHJZOWVUZjNtV0d6eDNZM3B6SldmaWZyVDRVS3Q1WmNSOVROYzR0?=
 =?utf-8?B?RXBnSzhvWGNoMkVQbWNmRFJYMVlxVnlCTVdXcjdWamFpb3VjckcwT21QVWU3?=
 =?utf-8?B?ZC9PM28ybld6eUFYRDRibEFxOUVFT3dsckZJRndkRHMrUEdmYlUvOXpGcjJT?=
 =?utf-8?B?bjRyaHlrNWhqUWZaeHAwaklHY0VobWpQL25uS3FHanc3RmhaNTlLOWtvK0Nv?=
 =?utf-8?B?ZUNRY0RQRGlXbDJyQnpoQW5VNHZmQW42NENpc2xFNHdwZml5OUhGdVpnVGlF?=
 =?utf-8?B?NnFZc09PNHJsL1NGRWpqa1lTNko3cGs5VmV0VmU4SDhCZ0NJQ0FxWUNCN3Ju?=
 =?utf-8?B?WlQ3OTFwdGtYcTI2eEpVc2NEMmhHNUc1dUU3UHRuUDM2L25qNTVpU092bnVU?=
 =?utf-8?B?MFdxTW9hTEd5b0dIaVdHS3lOUWJ6YnZ5cjJ3bG15OUxidWwranBRVFVTd1NU?=
 =?utf-8?B?SXpSNFFKVytnOW5RMDhQUDZLanNRbUM3TWt5ZXFmdlc5bUVDRWpaT0ZqM1lX?=
 =?utf-8?B?VUxFVk1aUUl5czRCbHJIWUxYVHlwT0pYTTY2OXRPb2Y5NlNEQmVYMTc1QXpQ?=
 =?utf-8?B?YmFaTVlMTnZTNEp3RFJXamk3Y1NibDJnU1NqYUVuY3FHS2k4elFBUk5CNCto?=
 =?utf-8?B?RkVJSjUveC95V1VNY29JandSbEFuNVBHS1FEeTZqM2I5WGRFRUx3cU5TT2NQ?=
 =?utf-8?B?NWk2dDJCTlNNSlFMLzhNVSt0bDFQeDFVaTNuMS9rREMzOWMvVURkUkdJdDdO?=
 =?utf-8?B?ems2N0I3MHhZeFhRVGxQRUhvaGJkMm9IS2VoOXVaTGg1OTllOVRpL041NUda?=
 =?utf-8?B?a0hGMGw3U2FiOWRjVG1HVlVaeDZmeHZKV202d0NDakVaTGh0MkVTa1p6QTMv?=
 =?utf-8?B?OW5STjBQREVGQ214RGh0dC95VFN1eUNaZmtCVEgzdUpUbm43d01kcStib1JY?=
 =?utf-8?B?UWd4cGZDRkpJMGF2RGtmei9KUVJaKzZhV2dtQUl6aCtMM09yTytvV2VqUFFj?=
 =?utf-8?B?bElSeVNCQmFoWllsa3lEQUFiNjFhdnRDcFNvaTFJTXk1aDRJUFd0SVBlN3cr?=
 =?utf-8?B?TzdXM1h5RWlwWUpFNWYyK0RmSE5jZVE2VnQzYTRhVEVuRElsWlhHZGs3dDNQ?=
 =?utf-8?B?TGFnN01wamY2RGhmc0M0eEhPRDFSK0wyVFljdm9YOHZkUFRPVjVRREpkMHhu?=
 =?utf-8?B?UGpLb2FWZlpXQ0VGZEIrSmszeTVWbDFYanlZZkZzTGsrU1RQeWVSZi9zOUJJ?=
 =?utf-8?B?d0xxOXQyMFp1czNuOXZnaEdoWE01WTEwRDExcDZ0RkRuNHpLSy9nZHpDVXhT?=
 =?utf-8?B?TERYbERLeklzWk1FSytDZCt2RXpMdHdnS3V3OWZyem5Qb3Zyd3QzbkdEOXRx?=
 =?utf-8?B?blJKdkVTeW4zNUU2Z0pwQ3p2WEtybUxTb2JXaU0yS0I3U0UzU2k4R21lOEdj?=
 =?utf-8?B?NDRwQkNZaU9ERzBiVUlzTWh1eGNIQmoveGczRisvQ0p2eVI3Q2JyVEw2VEta?=
 =?utf-8?B?S2xjQXUzYkU2d3JlZENqeisxODQ4T2t0WWwxaTZoTWJmQTQybzlRUDg3aUo0?=
 =?utf-8?Q?vN4U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84ed79a-f9cc-4b3b-3c7b-08de1594a933
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:08:57.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfbrscMnu9+k5TL82TlK3OEmqiif2QdWtJU9VRUW4IdB0vot52ojE16vAuXGBet/ONanxkGFUrVTsqDwuJDx4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11919

Add basic HDR mode support for the svs I3C master driver.

Only support for private transfers and does not support sending CCC
commands in HDR mode.

Key differences:
- HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
distinguish transfer direction.
- HDR read/write commands must be written to FIFO before issuing the I3C
address command. The hardware automatically sends the standard CCC command
to enter HDR mode.
- HDR exit pattern must be sent instead of send a stop after transfer
completion.
- Read/write data size must be an even number.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v7:
- add comment about why need check return value readl_poll_timeout()
in svc_i3c_master_emit_force_exit()
- add comment about why need udelay(1)
- remove reg = 0;
- chagne to use readl_poll_timeout_atomic();
- replace all i3c_priv_xfer with new i3c_xfer.

change in v4
- use hdr_cap.

change in v3
- rename to svc_cmd_is_read()
- rename to i3c_mode_to_svc_type()
- use local varible bool rnw to reduce change

change in v2
- support HDR DDR write
- rdterm unit is byte, not words (RM is wrong).
---
 drivers/i3c/master/svc-i3c-master.c | 96 ++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7c516e05d0a1a118479ee3d8ea8ae37ae19fea57..a732443caaf15a2f6e54de46bbafdeb3fc9a9296 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -40,11 +40,13 @@
 #define   SVC_I3C_MCTRL_REQUEST_NONE 0
 #define   SVC_I3C_MCTRL_REQUEST_START_ADDR 1
 #define   SVC_I3C_MCTRL_REQUEST_STOP 2
+#define   SVC_I3C_MCTRL_REQUEST_FORCE_EXIT 6
 #define   SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK 3
 #define   SVC_I3C_MCTRL_REQUEST_PROC_DAA 4
 #define   SVC_I3C_MCTRL_REQUEST_AUTO_IBI 7
 #define   SVC_I3C_MCTRL_TYPE_I3C 0
 #define   SVC_I3C_MCTRL_TYPE_I2C BIT(4)
+#define   SVC_I3C_MCTRL_TYPE_DDR BIT(5)
 #define   SVC_I3C_MCTRL_IBIRESP_AUTO 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE BIT(7)
@@ -95,6 +97,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_CRC	BIT(10)
 #define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
@@ -174,7 +177,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
-	struct i3c_priv_xfer *xfer;
+	struct i3c_xfer *xfer;
 	bool continued;
 };
 
@@ -389,7 +392,32 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+
+	/*
+	 * Not need check error here because it is never happen at hardware. IP
+	 * just wait for few fclk cycle to complete DDR exit pattern. Even
+	 * though fclk stop, timeout happen here, the whole data actually
+	 * already finish transfer. The next command will be timeout because
+	 * wrong hardware state.
+	 */
+	readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+				  SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+
+	/*
+	 * This delay is necessary after the emission of a stop, otherwise eg.
+	 * repeating IBIs do not get detected. There is a note in the manual
+	 * about it, stating that the stop condition might not be settled
+	 * correctly if a start condition follows too rapidly.
+	 */
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -521,7 +549,7 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	 * cycle, leading to missed client IBI handlers.
 	 *
 	 * A typical scenario is when IBIWON occurs and bus arbitration is lost
-	 * at svc_i3c_master_priv_xfers().
+	 * at svc_i3c_master_i3c_xfers().
 	 *
 	 * Clear SVC_I3C_MINT_IBIWON before sending SVC_I3C_MCTRL_REQUEST_AUTO_IBI.
 	 */
@@ -801,6 +829,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	info.dyn_addr = ret;
 
+	info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
 	writel(SVC_MDYNADDR_VALID | SVC_MDYNADDR_ADDR(info.dyn_addr),
 	       master->regs + SVC_I3C_MDYNADDR);
 
@@ -1314,6 +1344,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+			if (ret)
+				goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1407,7 +1447,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1420,10 +1460,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR &&
+	    (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_CRC)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
 
 	if (!continued) {
-		svc_i3c_master_emit_stop(master);
+		if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+			svc_i3c_master_emit_stop(master);
+		else
+			svc_i3c_master_emit_force_exit(master);
 
 		/* Wait idle if stop is sent. */
 		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1433,7 +1482,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	return 0;
 
 emit_stop:
-	svc_i3c_master_emit_stop(master);
+	if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+		svc_i3c_master_emit_stop(master);
+	else
+		svc_i3c_master_emit_force_exit(master);
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1480,6 +1533,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
 
+static int i3c_mode_to_svc_type(enum i3c_xfer_mode mode)
+{
+	return (mode == I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_TYPE_DDR;
+}
+
 static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 {
 	struct svc_i3c_xfer *xfer = master->xferqueue.cur;
@@ -1669,9 +1727,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1679,19 +1736,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct svc_i3c_xfer *xfer;
 	int ret, i;
 
+	if (mode != I3C_SDR) {
+		/*
+		 * Only support data size less than FIFO SIZE when using DDR
+		 * mode. First entry is cmd in FIFO, so actual available FIFO
+		 * for data is SVC_I3C_FIFO_SIZE - 2 since DDR only supports
+		 * even length.
+		 */
+		for (i = 0; i < nxfers; i++)
+			if (xfers[i].len > SVC_I3C_FIFO_SIZE - 2)
+				return -EINVAL;
+	}
+
 	xfer = svc_i3c_master_alloc_xfer(master, nxfers);
 	if (!xfer)
 		return -ENOMEM;
 
-	xfer->type = SVC_I3C_MCTRL_TYPE_I3C;
+	xfer->type = i3c_mode_to_svc_type(mode);
 
 	for (i = 0; i < nxfers; i++) {
+		u32 rnw_cmd = (mode == I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
+		bool rnw = svc_cmd_is_read(rnw_cmd, xfer->type);
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
-		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = rnw;
+		cmd->rnw_cmd = rnw_cmd;
 		cmd->in = rnw ? xfers[i].data.in : NULL;
 		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
@@ -1890,7 +1960,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.do_daa = svc_i3c_master_do_daa,
 	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
-	.priv_xfers = svc_i3c_master_priv_xfers,
+	.i3c_xfers = svc_i3c_master_i3c_xfers,
 	.i2c_xfers = svc_i3c_master_i2c_xfers,
 	.request_ibi = svc_i3c_master_request_ibi,
 	.free_ibi = svc_i3c_master_free_ibi,

-- 
2.34.1


