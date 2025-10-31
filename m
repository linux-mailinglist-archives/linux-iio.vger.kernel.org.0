Return-Path: <linux-iio+bounces-25770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52077C262E8
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65021897169
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6222F6597;
	Fri, 31 Oct 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bZooXuqR"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D72EB841;
	Fri, 31 Oct 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928816; cv=fail; b=rDfLassU17qiqurXKb1d7COo8t/aSk8Lt/o1zb5x5KXRfbZbAWVRirmrMqNRCbFxJv+c9APXSqz2uLiXETvg1ZbgfK+27hxXOQPl3iyju+HVg5dqnd/dQBvJZMw7C7siVYrJUFmsFnQ1DYIxdncg/m+ttUHFw1/MOk47quB9sSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928816; c=relaxed/simple;
	bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MrJEXM4PrZawYCosVgIcpDZwFx7UW0c7DfrVrsUi2gkxPodE8IgR9o9S2+1DZ/dd+0FOxIdEmu58MiwNg7NYDtZ2uZxtOPLyBBkO+6LZ6aQqnTS19S0C9LnIarW6LVPoX0WRNHLiu+28BscTP62fcF5/KiL+Y+uLZzMdn1BBH6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bZooXuqR; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz0Vr+NrWgWf1/rhmiFoHSvDzNlyDPF58OiTTh3yP5zyLiBYXVTpPN/45aHFZgE6vf4pHkgYyG/3kbAALSXDgaHL6RncbfJifulZvZVKQxpyf2WWbj23R7f3pZZBGxa7CEjnS3ur4Hfz0s2oLjyZa+wvoAOYtXyKW2tPENi0InflKLdjPWjOYRdnv5bYTPuvr/URitZbMpaTCrpWoB/9Uv2bbt1mKzCPA/LnGz4UwPM8REhWrTiLPv9NsijjtVf+iJ8KjUjWEgIBwnC5oSkeL5yByd8bV1IZaDgA0zGNoxFOWnreMSE5gUk7OVql89aEl8997UTHZ2K8zsPISWBzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=xt7GgYSVUlLx1+wJJ/jhLPLa4z4i+rrMy+Dp74VBefq2srqO40ETyGwwAi1lJaUvqCORAwr+yM8XG7Gbh98yq8KjOiDJLEV7sNwWId4IddPgqbQhGmjfli9ML5nTtUrRJ8ZgYwghMDJim3H+grZHtuvsT8Rp4hNf1X/QiDmkHl4zD4fpJnSXyN79GYxCal3BXzLQrzPXXAHdPQFVjxPZ8kERa452UfUrT0sttEX9E75ffmO356/hjXjo9u3GgcN38WelrcBBHLRvB9IJQdFTBbOq+Vvji+niW3a8JhBh/SGsm/0tE2jgOyCDNcHGHAr2mWDEF8CMf4jDhPiMYmIVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=bZooXuqRZxcE7TFfb+Lxtg9O82QPOCQLzJsDR3X/pDwMCP5aQ0bu5X9DdgIBj61vSjzr0GZyfB5WP7+3zq5U0IGoRWnb/Ppi2SEA9tqxLWfWn8K2jzHAcdd+jpnhdiyzNFE8u3Kz+EfYf1JPUWn3fo51IurWKzSMpf37AN1uUp/HLBSMA8M9c4eeEJknUDgC2Mnv+c5T8hVgQN27Pc7/oVnL0CI4eNAtBMnMVH9ZSvBU1SIgUmLLZc6Gw94k9SQIniJaB0jlDz9xzIj3Ec9kxBdjMye2ttpqTi7WRpo2KNNHVlZlBXmlUK6NywsXq57n1+VdEN3BJgfrjQbhLaHkOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:39:52 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:39:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 31 Oct 2025 12:39:14 -0400
Subject: [PATCH v9 2/6] i3c: Switch to use new i3c_xfer from i3c_priv_xfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-i3c_ddr-v9-2-f1e523ebaf78@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761928780; l=1345;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
 b=BAalunJT6z23qzEpsEiJgvTKjrnv3TysGrRCDmdrtMB3C+KHEI7YepFei3tpT8V6wyWqswWMN
 4VU3L2LTIl9AA3Rddf2+s5AASPZccn7/rlbj54dnzcdZ4UoPda2Etfj
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
X-MS-Office365-Filtering-Correlation-Id: 1c15ab2b-9c6a-4e65-0117-08de189c1d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWhzcVJzUkhqbUdjbHRzRVU0dzJxUElraHQrZGYwUXlGVHZXYlk0LysvNUI2?=
 =?utf-8?B?RnJDcng4bWxtTmh1ZUtiYzZjZ21wa1NrZC9Pbk9vQU04V1Qrd29PelBKMEJJ?=
 =?utf-8?B?Wm56bDBIOUxBY3pnVjRRdDNwLzI2RXhKanZyTDIyY282WXBGMEtxbG0zb1Rq?=
 =?utf-8?B?MTg0RWxXcFpZRWkzR1hLbnJWYnludGhQMkYyREpYNXBNOElMSlBvWmVUTzdy?=
 =?utf-8?B?dzVVRitUTldIa1JJek05T0tjZ213OGxieGMyeHBpS2d0bThBUk1vZVpnTE95?=
 =?utf-8?B?NlN0Tk1VSTdaaGpyQ0R2bVM4ekhEK2dUZUVabFYrYTJuaXBQWC9SdzBieGxI?=
 =?utf-8?B?SGRDR1EvSDNFWGk5b3NnTkpvNERUY1lCZ056VVFLMDg3SksvM0hLTDNTd2dl?=
 =?utf-8?B?dEVTaFROVWduZ294bmd5S2dTa2JJbVM0Y3haQWt3TFVObHJMS1E2Mm5DT1Ew?=
 =?utf-8?B?NWpnNmg0Qmc3c0VhQU12TS9BL0lyeXZhRzZBTHo0QzFFcUEyWlIzMXNsYS9W?=
 =?utf-8?B?V1lXQTViWGN6Y0ViS3lRSjFVVHcyYlRyTzE3Q1prQjlCUzd5V1BWYXJNTWJ6?=
 =?utf-8?B?U3M3Um9ITlJVSGNhdUFtaUJPOE9ZalJPc0ZZS2FTVU91Y25uRERwM0VmdGtr?=
 =?utf-8?B?cnFKU1REY0dldUh0amZQa3RiOTNoTnZIL2NXaEM0cTd6bEUrV0dhS3IvOGRO?=
 =?utf-8?B?TGQ2c01hV2hkNkRQa1BnaWlQbDlBLzFvRklIQXZnaDdodVVmM212WmZ1ejRr?=
 =?utf-8?B?cnNBVWhEeUFXZjBEZStvZUs0VUlqVENBZ2ZyaDBrMitFeTB3SjJYc3gzcFdr?=
 =?utf-8?B?OHJScnBoaVowSE80UUt3cXNKRDN4MnAwRDVQMmhhZHNlaUs5SHFmQVJRRm5Y?=
 =?utf-8?B?ZU5OdHpLcUNOalZJTC81MmRJeE1Sdk5URERHeElEeTY1STZBNkI2N1Vjb0Iw?=
 =?utf-8?B?TUV6c3VzdDRCT21BVzlyQXYvaVh2L1k3SCs4bnZqY1RqM1dUakFRN2xaWG5S?=
 =?utf-8?B?WE5XcjhRN3ZnRUNxWHl6K0oxSXErVEdwWWsrU2JmQmhDcVZJUHdJeDJrUkda?=
 =?utf-8?B?SlB1K1dXWnRkc0lvdFFFeVNBTWYybkR6cTNzNlJxNXhIRWZVbTNKTlZtVzJD?=
 =?utf-8?B?bWhiRjhxU1FHZ0RjTm5IcERJTGRMMmlFdnFzczVJNFVOem1WanZ1RVJmdkhT?=
 =?utf-8?B?R3drVkNhWkFTbEJBeENWd3FMN3hXamcvN0hBZms0cWFZTUVJNDhZd1FLY1VV?=
 =?utf-8?B?c0c3N0xlc2tIR1J2M0prSy9lcWxBZ0V1ZG8zeW4vL2JvN3EzQWg4a3Y1RVZE?=
 =?utf-8?B?c0oyaWtrRkRkUHRlQ0lGSm1PaTlwVi9xRE84L3BSNjRDTmNIWS9CbXd0RUY3?=
 =?utf-8?B?OFRNSVNOM1Q2bWNoaFRnMFNpYUo0c004RXRCeFVLZ3pIekdGbkJpd1pOVGFP?=
 =?utf-8?B?Rm13NXhHRDRuNUIvY0NyVTl0SldmSXFpV3dtTmE0NjBnc0MvdlBNL0p0MnFE?=
 =?utf-8?B?V2phMk5kVFJsRjZGK251emxETkw0cFJ0SEpCOFZSR3RmTEJQbTZWMURYTWFj?=
 =?utf-8?B?OVdaS2JZUDVFcDRHMkJ5TzBtVjRIT2czZEsveGZBRmF5SlgvNDM5dlJvTHhD?=
 =?utf-8?B?dndtajZJNjU2V1o3T0ZMOVVBejJ0N25mK3hEU2lNNE0wTUJ2UXp6VzdsbjZE?=
 =?utf-8?B?MVVhelZDQWI5dk5tZjNzT0hDU3k5aFU4OHR0YXY5blkyUml4elFBam0yblo4?=
 =?utf-8?B?cFVJYUwrNFh4ZjlaSTZIaDJScjI1OFZlYUNHZ01BVDFVcHlOS0pnRjVPTFAx?=
 =?utf-8?B?VVFpanozSVpxQnpqS2pSK1ZkZGovdDh6NGhhNzRydkdQby9DeDVJaWxXdWZN?=
 =?utf-8?B?cE43WE42VlVwTzVMbU5zcjRlR3Z6MkJBK0tqUlZHRkFOUEppVUtRdEpUWEor?=
 =?utf-8?B?dEMzWXN6MXBsU0sraVRla21Tb0RZbVA0Y2VONEFZRVlPZUorZ2JnTkdBMkNC?=
 =?utf-8?B?d29CemNBbGF2Mlg5WE14S2hFK1E5RWZzQnB6ckhPMnlQdWRXT3RhZDhxTS9p?=
 =?utf-8?Q?QQvsif?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emgxS25TY1B1R1U1WUhYTlh2RWkyY05VU3IyemlWTlpXN09pbERUd0NhK2Ix?=
 =?utf-8?B?SVNtaUROM09KallFaHZwN3d5bjVLdVE3SzFMM3VJWW9NbzlvSDFIVzUzYjAr?=
 =?utf-8?B?WlNGY1hxNDRZMkkrWG84eWpNK1UxeDlsUUQ2aXNLUDB4K3A3T0V3ZzlTT2tJ?=
 =?utf-8?B?eGJlMlZyS3dSRTZ6aS80aEFkbDU1eFlXcG5hOXRyZzlIN0dESVJ2TU4xZUIw?=
 =?utf-8?B?MkZFdzdZQXhXZ2ltSzVYOVI5R2JKcjJLV0hHcXRPT0VUR2hUSWdmeUw0N3RL?=
 =?utf-8?B?KzlQRXB6UFVvaUpvYThOMEdHdjNKMTJqSXVSVzNhT1o1WHpFMDNHaTJrTFVy?=
 =?utf-8?B?UThBQVBZMFQzZW4wbm54RGVmWnRsVFVRYnRlcU1PSzNTcktnUkFMWmE3SkJ3?=
 =?utf-8?B?RGhPZHB1UDNQMkloY3RWUE5HNjFOS05BQXBKcnNOWTFGL2grYmMxblFkZFA2?=
 =?utf-8?B?SWZ0UVRzTDliOFdZR3A5R2ZnSGRaYWt4VWoyajg4cCswVy9NSy9KV2V4SUda?=
 =?utf-8?B?VG85SS9IUnU4aWpSakhmMG84NVNOdVFUOVBxZWNHYTE1US9jb1VwbmtjQjBP?=
 =?utf-8?B?U3M3a3lwZStiVjYrTmgyRWdHaHVrdDMvRGVMdzQrWnM0NDR1a2JrMFZwN0Fn?=
 =?utf-8?B?bGJYVUJPUG9Pa3VEOTVObGg5a2NDZU16NitVYUYyaFIwNzJtNmg0eUFEMFpN?=
 =?utf-8?B?eS9BMjNPYmc5N0lIYzJSalEyV2ZSQTVkN25CUnVucmFkN25aUWtja3lERFR6?=
 =?utf-8?B?SFdod2gxK3MvWC9uWFFLdmpZdmc0Y0g3aS9CQ0lqR0p3VUpaRllyNUFiRlow?=
 =?utf-8?B?dk43elBraU44ODM0VmJaWW4zOGVTb1ZTbXFXVHgzZTFXWlB2K05MN1RiK3Jo?=
 =?utf-8?B?bG85KzVhMHNWOWxiZWJjTGI2Njcwc09aeEFCRnJKLzQrZTJ2Vi80TFR6dzFv?=
 =?utf-8?B?ZDByNEYzYUpoa1Q4VWF4S3dJSGhhdUZvSzJ5VDJqR3c4eEpQVWhpTnphTXBY?=
 =?utf-8?B?Myt0SktYMGhyaXBITnc3dDdqUXpXMlQyQ3RZeFB0SWtHS3BwR0xUUlV3dXdV?=
 =?utf-8?B?cUg3dVVSNEQwS1Yyai9Jell0NkZiQzZoeUNlVEkwWDJYN2EvSm9JZXA2M05B?=
 =?utf-8?B?bzdmaW04Y015dUNrQkVhUjBEdU5sV0NOTkVYT3g2SWJYWjNwUjdHcDZKcVEx?=
 =?utf-8?B?RmUvSlg4dy93TW12bkRkR2w1WGtoUmZVckZ6bGNPRmV6anFkaCszY2NsQXBr?=
 =?utf-8?B?TjFUZ2ZNd21iaWJCVERxWHFNTmg2eE5wcHlnK0U2b2ZpQVBZdHZkTVIwZHJP?=
 =?utf-8?B?Qll5bWgxc05jL0xlOFdMRkc1eWNva2JVL01JVktEaS90SnlvTjRpY0p4S29N?=
 =?utf-8?B?cWNuUEFSQ0RQM1dGQmkvUHdmcHBaditoeXNITEU0ZTR0OHE1K1RQalhKaUdl?=
 =?utf-8?B?cytxaDh0YkdHTmpzZXhJZms3aHdOdWxJYXRkaXQzdUE3bnRaMndUaFNENjgw?=
 =?utf-8?B?VFF6by9RbG5BRnBEejRmSXRjZWxhQVNmYm5tTFgyaUN3Rm5SSFBkMER6eFNy?=
 =?utf-8?B?VU5JSzcybUFNY3JNZkhIWnFVck9HMFRMeXpaWTNZVFd6Qlk3Q21zdUQ0Zklk?=
 =?utf-8?B?L2VhQkVsRjY5VjNhbWZrNGt3VlVvTEovTURLY1hNS013K0ZCa2FQdEtmRTNq?=
 =?utf-8?B?NG5OU2lpTjNYcitBTlp5c3lIV1hFL0pxME5VVk4weGIzeTVtQkt3U3V4N2dO?=
 =?utf-8?B?SWNlYkZ4dkdwK2huVThvR1dEQSs0aXhLZkJDc1F6a21Rb05RYUV4Ky9Pc1Fk?=
 =?utf-8?B?TDBWOEtVeXNRWkE3SVJRVWwxNFVoZWpSRUpUNnd2aTR2Si9yRmU3SmRYOUs2?=
 =?utf-8?B?bkpzeXkyZHlmQ3FybXYvdGZWY25EUXd1YXNXcTc4OXRrZ0d0aEs2OUJBYVlZ?=
 =?utf-8?B?RUxrcVV3dE9GUzZsdkErT3h0T1B0NU54SkxreW1mK0VkWEwzU1JYNDhsZzFZ?=
 =?utf-8?B?MUdRaWF6cG8ranRDbDBWTzEyWExmQzk4QytkRFp2eHNxNWxzWGE1aUFaelIz?=
 =?utf-8?B?SlpnQXE4RXZHYWJEZ3BER1JST3ptejRzMDZ6S0RlbEZHVmNuck0yUVhYY1ZL?=
 =?utf-8?Q?K8es=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c15ab2b-9c6a-4e65-0117-08de189c1d9d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:39:52.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nc/dYOig7WG6/CJY+agWGBb5qy7VYHNAdM7iy1xwuBISsADIFHSpHlPd41tn/dWKLbHavToaCUjJoXGzamUnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

Switch to use i3c_xfer instead of i3c_priv_xfer because framework update to
support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v8
- new patch
---
 include/linux/i3c/device.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f7738041f3809e538816e94f90b99e58eb806f9..ae0662d9d77eb3fa0c976de1803e9c2ff9547451 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -27,7 +27,7 @@
  * These are the standard error codes as defined by the I3C specification.
  * When -EIO is returned by the i3c_device_do_priv_xfers() or
  * i3c_device_send_hdr_cmds() one can check the error code in
- * &struct_i3c_priv_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
+ * &struct_i3c_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
  * what went wrong.
  *
  */
@@ -312,7 +312,7 @@ int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
 			int nxfers, enum i3c_xfer_mode mode);
 
 static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
-					   struct i3c_priv_xfer *xfers,
+					   struct i3c_xfer *xfers,
 					   int nxfers)
 {
 	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);

-- 
2.34.1


