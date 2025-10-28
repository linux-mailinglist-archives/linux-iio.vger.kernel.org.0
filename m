Return-Path: <linux-iio+bounces-25590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA36AC15489
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF124669DA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FBC3385B1;
	Tue, 28 Oct 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GJ5cVRB1"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2333CE83;
	Tue, 28 Oct 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662988; cv=fail; b=oaPVfa+DVJmW4hb0OT2BL6bPGoJo5B4cHPKIizpJ73+igYzN0cwkArwwlIsh4HocEUhxyXbirmH/RweI+ZHltu/xeDFzOhw0ZgAtAMNKaSeb4hobDvH4RRonp4njgz6LJOD8aDwuy64hPpR2Se15OUEdFh7v/uSyhV92KvYLK3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662988; c=relaxed/simple;
	bh=MXdfcOlomcKxNyAr9MXZ8gD5rAqp/+jFkqESujXramw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JfQKoNOm4GEw6kfoUcA0CKoQ4vc2q1hrzkf1d7bRFPFIJx7QJ/hYa2YSy/hDgkLfomJoFdDZgDFVm0DBYHvgkf7VM+5XfkO9cmdJMS+8G9NdWejEouuiH3HFR0Yui+eWg2KyLJKOstZMk3oNmYZ0cOO48F8aeTio0OdYXpel7hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GJ5cVRB1; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krwaIrQ9ch3/B/Ad6cwAge60rrmftxyd3FsAlCVNkESkKjPqRiCV8YF+0XrM7+9q/8f4JGctCbLHVe99s94j56NFB8fYQgHMoN17FviNyte8Bxa7OffENqyiKzY9SVFEXPn2J7Y32JXFoHH1GD4uT2l7bWZFkf8YiQHEXiMa42IrUrC490PAT6t9ZR1k24z4ZOHt0H9tUB3plHe/gi2zPwryENgXCWqTRyIfmHkuONX+/wOn4UcPMErwjcDrdXXq011KwZtT3PhXcf4Ftg0zDj1NYfQDCh6GZeOcXAHqoZPmWSbpv0A7IhEUxFEr/lq8hJ5q0gIrcUl/QFDiL5ZghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcscuMED5rYImIkNErwswgsCNJqWvJZ4j6X0DuqFZw8=;
 b=P04IP/FWFAgBguWiESQYqjQrku1fiPgU86GFAUHtolcDFxe4vHXmFw/IEly61HPcxvyzT+Stw8QxH/oa0wXAidUfWUoLwaVdBaD0hf4Bdlm0KCw+VRew7hWsjt/9mrLrwWpvhZk+r4utzLMDcpI8reqrwPVIj9bqZrgpeXAmIpQUSILg7YrWAGp9k46cPNmaUP/D7QzeQt2OEf8CgtsA4khmd8rzJ6lrpsVHl4sCjQZd8tBcp6O27vJKrhNTATn/D3hU8r43hLelfZcHv+a7v/Rg27zbHy0XQ/zo+DkMYgz3VQO2/rAUacUv8NinlVJpilIkySqFryTjg6OLRD5Zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcscuMED5rYImIkNErwswgsCNJqWvJZ4j6X0DuqFZw8=;
 b=GJ5cVRB1ZTmLn/otrFN0KeQPQ13N3CPkXnPvfCvgAxuF4RIN8zg9c+Hzr86v5AvvMO+hQYImEAGNTOJl7bcCegD0zbLf7xuLj9eQmGjY6gnH7MYzzf8NZn0ToI4Zh+/5PKKodq9BAE8HVOtznbjwV5Ct/C0OLuZRlMPggdndF+SPWVuks5RklgJ8uUjqYh6L8B7FVwTsJIg/Iaep3hmovUbgTeyUL8pLiPX7auO3Vcyty50FK+3HQUdUrTv1EsA4al4RlBfhezI7Fs2BE5g67RGngl9sAQ0GTOBzLS+rz5A18nOjGQBzTUGlb9eEOyqayhlC1RYoZpufyq6S14bQQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:49:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:49:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:49:02 -0400
Subject: [PATCH v8 6/6] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-i3c_ddr-v8-6-795ded2db8c2@nxp.com>
References: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
In-Reply-To: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761662950; l=18712;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MXdfcOlomcKxNyAr9MXZ8gD5rAqp/+jFkqESujXramw=;
 b=J/1TiSayKGHTxFDb1nffDrrIqUGhwE1BSe0/QC0Vzl++cFPJwWJGhKAYpF1+h0hNdiUg1L01t
 OearN0SsVYmDgvbE47MkL7oYy8K61Q/UPnwchafzioo4nJuBM1f88TF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe85620-f9fc-45c2-0723-08de16313999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWxsK2ZZbCtyeTJ0bjRnVStBNlRidFc4bENnc2Q2RzkraGxlNVdkVG1OaVZM?=
 =?utf-8?B?UW0xVkw1a0QvZXB4bCt5NldhY3VqNW1PdkJOdTJXb0U5K3FaTDN3S3NBbjY0?=
 =?utf-8?B?d2ZpdkR2RThTd0dVaHNkakk3Tm9CdzhoMkozdmxPWnl6dFBuRDNEQ0ZVUlB4?=
 =?utf-8?B?NFY1bnBCK1NvQzBsb1ZWY1c5WjZOVlhTcmpSUm5VK3VpTWY2d1dDeXRRYjZ0?=
 =?utf-8?B?M0E5WGs1T1I3RmpQT3RraUlNVjc4dmhWbzVMYWRBOFArc2RGL2txR3d5Y0Ur?=
 =?utf-8?B?aCtZSExhdEV3bkg2bExtYTdNNjVZUjgxS2d1YVdpYmp0eDFVOEpaQlJoVnV2?=
 =?utf-8?B?bE5DcFdnR3FsMXNEZ0VXZFIybHcrRVhHQ0RiRTYyc043OU5wNWJIdldGUDlE?=
 =?utf-8?B?VmRDZjR2Mmhmb1JrZ3hFYmVQVVpmbXhDWjNhMUQ1cVJHdXhORXlxdEtQUml3?=
 =?utf-8?B?NEEvTEdPaVlMZ0dwOGVhWUR3a0VDN3M1eS9QTTRZRWp0REhDSVVSVmZ6enhy?=
 =?utf-8?B?Y3pRVzNnUW93OWR5VnM0bW5jTjJrMUhyQ0pCRXc5M3ZSbHIrNUNLTWlRd1Nx?=
 =?utf-8?B?MDVJaTNuQWt5RWJoRzNnQXhuNUNOa0gzRTYycTJsUjBnbzhta1N5dlNLYVFB?=
 =?utf-8?B?MTYwdFRoc2NudjVuL2ZIUTNFekxaMk80aEtUaGN3c3R3eFZJRVUvRWtJTE5L?=
 =?utf-8?B?MUZMWWJHeGF2QW5wRTFiNHZRNWVtbVFZcjBMSXBnZkwxandvWUZiZzNielFV?=
 =?utf-8?B?N1dFeEFBV2M3L0ovSnNnaWNTdXZyem9oWjJQYW01RDRvaU5TRUlwZkFEWDBU?=
 =?utf-8?B?NWkyMVRmaGdqa3g5ZlFQR3lCcHQrSm84MjJoUGdZREU5N3VweTlKWDdHOGll?=
 =?utf-8?B?ZEJUUTdkQW5LMm9qMnppd1VPU2pzWEU1Y2dEaWVyaWlqdzhySWhRMEF5Yndh?=
 =?utf-8?B?bWxMQTMveHg3WUs3MHd1bG9DaTI1VllJMUhyU2FpcWVSMVNkd01zeE55aWFW?=
 =?utf-8?B?MFlvT2lldE9nbDkremQ0ZE4wV0tJWndxaUx5cEpYY2o4VUR5VU9JSjJHSHZx?=
 =?utf-8?B?WU9WcnBXcmNENUNKcjU4b0kwQkR0OXl0cXJ3bG0yazliSkZhZlRrTllJZDNy?=
 =?utf-8?B?eHJzcEpUUkRRNXZiWHJRTURaL1M3bUNDT1ZwODJvOFdxWUM5eXcxSlBnZlQ0?=
 =?utf-8?B?WHZZYTVwR1MrMXo1ZWlMTVJNb29LQUJycTFqWEJuamt5SUU0WVJuMnFHekt1?=
 =?utf-8?B?V2VZRjZxTHVmcWROUklPbDk0UFdFWE5QMlI3c0FqZktrLys0eC9Mc2UxRFZ0?=
 =?utf-8?B?TjRDeE1Jd01CZGYwZ0l6QVJZVmp4QWgzOHpENTNyRjlDOExNYkRveDNJazJI?=
 =?utf-8?B?dkVUTnN3ellIRlQ4TDZCZWlEU1BaOVJXYTZqaFEzT3NZeFFCR2lzUlg1RTYy?=
 =?utf-8?B?V2JxcGxtaVpVenpRSSs3NW9KVXFUVnhZZGN4QXNDL1ZGTWd3cHgxcUVlWTN1?=
 =?utf-8?B?QXN2M1BVbEFHdXdOMndCSGVYaDZtVjQ5S1Q5MG9qMmtSWVk4Qk9CYllPb1Uw?=
 =?utf-8?B?R2xESWNxbEQ5R1MvTHhoVVA4emdNU1BudGtvWVBWVUMyM0t4NzNpQ1NWVFFk?=
 =?utf-8?B?djJzS0J4akt5VGxOd2JrbUFxbjd2Y1RHNjNyblN5ZGsyNFVicWE3NC9UR0kv?=
 =?utf-8?B?UXFvMjZtOU92RE5xWFZpQlZtaDJhRFBzM2JnRHVKajkvKzQ2L29NaXVQdm54?=
 =?utf-8?B?SW1uVG9mNWtPT3d6am5lM09QcVpqQnZHSnRrSzYwRFlQREd4V2tSejFHNVlX?=
 =?utf-8?B?OWJxN1N3ZFpvT1FHQjNpcTVRTHc2U2VuVlVXK2xqeWRMNVZRdDdZQzFsc1hl?=
 =?utf-8?B?NVlLYkVVcEE4NVppK0ZzRFVIcWZsWmJPU3dVQ0U1TjFhMC92UGFTREtDWTZ2?=
 =?utf-8?B?ZXlzVkxNeEU5YzlaMzBxenlFbno4WUdpVXR1U0tDY0tnYVdYYkovcTR5Qi9S?=
 =?utf-8?B?Y1lCd1M2QTc0Q3ZqcUhxckZrTC95ZVJIUVk0eVFqdmtJTUhaVjduRUVLaUN3?=
 =?utf-8?Q?Lta0H+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTNQeGozcUJ0TElOMEU1NEhNMEg0Nmp1Ym1GeUxWcGdhQUc2U0NxOG04dSts?=
 =?utf-8?B?NEhyMVFtR2p4NGZpendWUHVkaDQ4Z0ZpbjFmZDdoc3pXT29ZRlp2TDBCOGpD?=
 =?utf-8?B?dzNySFFpdUNtSnFKMVgybVV3V1hzcnZhbjMwWFR4dlEvTEdyYWFIU3NGRHBY?=
 =?utf-8?B?SzZZcDJ2bjBTemdiSGl4Vk4zaTM5Z2NHTG9IOWpMWmhnMXdUdDdHQ2dnSXJV?=
 =?utf-8?B?ejVaa1p4emQxc1VkM1NZYmp5WWZOeFg1WHFCRURXVG9EQXk4M05GYUpDVWJq?=
 =?utf-8?B?c1JQV010RUVWMlR1cTBlRTRkZi96M2U3TExscldyTmlPR3psVitEaEthV2Zl?=
 =?utf-8?B?UGs0SFlKdEYwQzR1aVlqZmNXaFlnRU84b2Mxc2s0YVdNK1lCVXR1YjQzZE85?=
 =?utf-8?B?aGl1SDhJUTNtTFFXdC9CTzZHMC9ndjVuTnFkbTZJRFR1NFpMaDZwbmN1djRw?=
 =?utf-8?B?RnAzWUFTM05YYUgvdy9IK2lWTEw2SVNUV2ZXeitzU1JJR3BZQS92RFM1Z1Z0?=
 =?utf-8?B?SHcwaG5lNnRCZmV6bWNaVW9Kd0NKMVAxaVV6aGp0YmlwWnIyaHo2RitTU2V5?=
 =?utf-8?B?TTM5cW1OYmxmYmFEMU1OQ0xrNE1QUlZDSURPb3lXTUdURHJFamNPTXpZSGlP?=
 =?utf-8?B?MTdJTllCbWFOdy9XbXZvZ3pKVzF3UWJKb1dUWDNkbjFmMXIyWG9kenB6dWRw?=
 =?utf-8?B?TTBreGtLUklVSzRwd3Fyd0hkYS92SFJHK05qUEZEYU43SzRkdW5jSm1HUy9x?=
 =?utf-8?B?eUtkZzkwZDQrM2hZRndVYms2Z3NRK1hSVXZRM2VUVEZ4aGJsakhLb0hOMkFh?=
 =?utf-8?B?Nld6aXpYUDRGTkkwMUpaRHRrbElWMEUzZjZvN0xSOW9WdURXSnZNaEZZaVZv?=
 =?utf-8?B?Zk5DWnBUUytYZVVMM0hRV1VuVjNQVjQrS2lzT1JYQ2M2dnRmQmxKcDlqTkhk?=
 =?utf-8?B?OWxXV01ZZUdNSmtWVElIMzVTN3doZFZubm1jVEJ6K2kzYmxYd1VnYU5oMEh1?=
 =?utf-8?B?YXcwb21qSllFaGQwM1diY1FwcENBSjNjb3FhUGxZd1drT1dXR3F0WlUwd01k?=
 =?utf-8?B?eWVrYytNQzJUcWFhUkJHNmh6WnozWmQwQUplTC82c01CNXg4c3F4T05tTlhu?=
 =?utf-8?B?d2s3akJLNzdUcXIzMmd2Rjk0THQ5SFdGcTc2eDV6TldTb0FCYVFhang5eHpR?=
 =?utf-8?B?NnNUWkNzQ2NmWmE0dEp3UlQ0V2Ezd0pvRWNkclkzbTVUSmN4Nlg2VGtRQ3R4?=
 =?utf-8?B?UnRhWEYyRE5ZUzZqRCs5WGhpQzI2TXRQS0FOWnVycVdhMC9xMDJ1ek05MnhG?=
 =?utf-8?B?TVZTM29pQ0xDRVZHSzF3Wk16ZWt5bzMxckpGSG95UUlwYjdDeDVYbm1Ldzl5?=
 =?utf-8?B?cE9xV2FNVk9FTzlHaWRSUVZMYkpzTXVBWG1Lb0RmUjk5ZFRxVzhEMHIzNk5N?=
 =?utf-8?B?dUNTMEdiREppeHhTa1BmRENBdG90ZlJiUkZadTFMdGJiVUpSd0tXNHQwSU9s?=
 =?utf-8?B?ZmNDVldwVVlLL2VlUjBhUUlVTmk5anhhYlhhNWVxbzBZUjlHMnZ2K1JielVQ?=
 =?utf-8?B?K1NBK2hxQ2VRMVBFV0ZGTlF5amJlZGNQUE9vL3J5WFV0Q2E2TWtvd2xCdTFm?=
 =?utf-8?B?NFBneEt2b0FqaEdJQ1pCL2ROMGk2M3BNL25xUTcxQzhOTmFhaEl0Rnpjc3Mw?=
 =?utf-8?B?OUVFcUhFRGFER0Q0ZlRqSFZ1R2llVWtNK0Fqei9JeWhLWmg2d1d4TURHc3VJ?=
 =?utf-8?B?WklrTkdRRkhTZFpKRjFMWWl5RG5KcFZsWkpqOHNrL2c1dUFMQWxtbGpNRk1u?=
 =?utf-8?B?REsyalRsZ3FpUklaSXVGYWd2ZTFvTTREZ2gvQUYwU0xJVU0xZU9TNGkxallB?=
 =?utf-8?B?Ty9TS05HQzhJWEYxQlIrVXhHMm1mV1U4U3VkWFM4K2NEcTBuOFRlMkVQdXJh?=
 =?utf-8?B?blhLWTRwa3NpbndkMmtQRDhsRUhubE11V3RnNmw4ck9VUktEQUhaUHA2L01G?=
 =?utf-8?B?Z0dSN0pCS2JQREpONThtendMWngzQ294akJjZUMyMmhCSDQyVUl5ZDB2ZE5U?=
 =?utf-8?B?VUVRYlBCSU81SUVIRUUyaHhkNU4yNWt0U3pRVkljRndKaGNJRWJyeW9Hd2x3?=
 =?utf-8?Q?44Rgtg2P6NL2wlUKmN2jakXK8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe85620-f9fc-45c2-0723-08de16313999
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:49:40.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjuhVgbIusAKih/3zL66X0kL/v/yW2IW31vDKJxObukWhGVn9KMiorFDb3S+Kj3rh7y+Wb8c6RK17UTg9K38Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

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
Change in v7
- add missed *.h file
- remove reduntant empty line
- add comments about delay 1us after SET
- use USEC_PER_MSEC for timeout value

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
 drivers/iio/magnetometer/mmc5633.c | 588 +++++++++++++++++++++++++++++++++++++
 3 files changed, 601 insertions(+)

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
index 0000000000000000000000000000000000000000..3e29324f0720a2b8268ccd63409483a60e48802b
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,588 @@
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
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
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
+#define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0x05
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
+	u32 i;
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
+	unsigned int reg_id;
+	int ret;
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
+	/*
+	 * Minimum time interval between SET or RESET to other operations is
+	 * 1ms according to Operating Timing Diagram in datasheet.
+	 */
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
+				       reg_status & val,
+				       10 * USEC_PER_MSEC,
+				       100 * 10 * USEC_PER_MSEC);
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
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
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
+					10 * USEC_PER_MSEC,
+					100 * 10 * USEC_PER_MSEC, 0,
+					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
+		if (ret) {
+			dev_err(data->dev, "data not ready\n");
+			return ret;
+		}
+		if (val) {
+			dev_err(data->dev, "i3c transfer error\n");
+			return val;
+		}
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
+/* X,Y,Z 3 channels, each channel has 3 byte and TEMP */
+#define MMC5633_ALL_SIZE (3 * 3 + 1)
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
+	unsigned int reg, i;
+	int ret;
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
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend, mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5603" },
+	{ .compatible = "memsic,mmc5633" },
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
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


