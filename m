Return-Path: <linux-iio+bounces-12334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B59CF610
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 21:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7AD28DA28
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE11F76D0;
	Fri, 15 Nov 2024 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCezJZzf"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABC1F755B;
	Fri, 15 Nov 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702272; cv=fail; b=AxY59U1GmU5/xwE7DW3cN3l5KDtWK2YIIr0EMwMBR5B/9hUwEHklBs86zCa8KuLUQl07yhaUh+sPVEv+E83yp3MLnKDU/aoUXvWMgXQaJRHHywizwI9m5MNcHhG+CNvxVnWnjRSmrNMjgzA+gtoyio605A8c+xpW8c1+SVSs3kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702272; c=relaxed/simple;
	bh=9CereBTgdqpoG2P6KYEI3UetU9pdiS4pL3erD9GHBnc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jk6lNt7hGG+Bf/89iNbpfd389oKx001enKFYVgmVMCTcXbAJezZUebGpgX6+5bzJ9W1ga0EeQU/c5XexQMeoQ1W/MFuqX3qJjSJXhZWJClGykXGE/ef1c0pLRF0ebnjS2VnIianGRrVjkMV6HquYRZwi/z7h5uiKn61dhep8EPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iCezJZzf; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz3fJvCj95SAw12E1JPs52dkiAA87f3Hy4NRlJioTsLRdB2rSzlIdZo60sJK1QIEYBeqWWBJuevAFb9gQEDWkdlAjt9ZfPjI690a1tYAjWCKjzTFOQ84TfOp/18jpMmYiFXv4mnEwIM8SkcGtjGK3nFkZtyBtiX5U8JSIIXi0d2p/wp3QfzfoWJcTCtQnCuJSIjU+Rzj+zChxDcU1kRY1qWyQhPFdZ1ms+7r3o5yImzme2yT6enRun4nlVlW65ayicL8GCj3EroUdg2lLyBSIv6pqWg4TW6Cx4fZRL+nmupt3WpgaofkwPGEC3AFquBZabWqufYxCK+AoQ+RvNbVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCj5587eU3VZFXt0swdhoTIIkw9zw5buUCn/uS6QZcw=;
 b=yJgmgR0sYze1pLLWelnReNiMXgALCRy3RwN9pqaCtLK3HUBf8bREmne0l8vnNvLjGZmCFP6VZYxYzZ5ldjbZs0E4kt1G3BiUb8VXUw5f1Y+y3nloY8Afg9bgDKgMTin4JrE1S/MMH3X2VBvaejcEuKyYXWgJ7Bmmo72jL6HvslqVtNB1/QW6DQ3oSiU9yKVZ5wo8qfrf574xPwpQic49xhk+9zkZKmRLgfcsE7zEqG6UG8oyB7zD4NQsQ//TtOcG4at3cDHVHCrE8l0O4u9h/8cp+tNn+ESDlYy28+4PJ3cLEn2U5fZKQt+4z9zpZpXkcT6PhrAFlwubuz0R2LPxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCj5587eU3VZFXt0swdhoTIIkw9zw5buUCn/uS6QZcw=;
 b=iCezJZzfj8soqXScXlxX4Xs5S854HX1Z3MHs2calC+6sEF9xoEfJB51wR+5ATc0POSMwyu5nlHyI3gxs+53bY16bpgLeB3CT4PAAfl/iUhm8T9yeDS+AQ6MldC4C5BHuYDM52jSi5ya4N3Xun9Ox2g2xNqmHNdOdjQOklLIfWoz36Mh9Ct1lRxtTZQR8Rp8hfQ88+WECP834eNGju991Imd/E/xU9RuNby5wvDfce+lN/OK1GxVhfWjW3IjssPiE7QCbV8417etappCwixFXErO2bFNksLJxZkIwYA6bkvGN6eDYLucLP03CT52M/76i8lVg4lrAUrQvDPv8vZm/ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8231.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 20:24:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 20:24:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Nov 2024 15:24:00 -0500
Subject: [PATCH v2 4/4] iio: accel: fxls8962af: add fxls8967af support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-fxls-v2-4-95f3df9228ed@nxp.com>
References: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
In-Reply-To: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731702250; l=2129;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+5pZ0e2TQAqE2VPxZTaDVC5nqnEOf64tyTq8OlxCBFU=;
 b=0i0T+xwJioct0pOSrEIaSJHPixvRm34dqzuP71/md31POKNOYAtvY3e3fLdQpsXBuPvpJhY1A
 jqMmSzuT+VYARNJILfM5cbSj8+GDg5aQ/q27KEUOuq+6fXvC8Iwhg7u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: edb590b2-d10c-4364-a399-08dd05b3806f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0F3U3ZFVHdFbGJFRktBZmVmb2NGeWRKYWdtY0VFckl0RWpHMW9qZWhDbEwz?=
 =?utf-8?B?QXpXVjVmQkJFTCs5aWdEYmtJVm1XVWdmZkN5MmFXVTh0SU1DekF5UmcxaHA0?=
 =?utf-8?B?NTRDMGh1YkZqaU9QSHhxUGNvcVZXamRmMXlnKzE3NytjYkVsaFI5M0cya2dx?=
 =?utf-8?B?OU54L2ZWb001UDhWSWJpdnFxWENPZ3AvTXlvQWNLdTRDb3NzcC82NWQzelky?=
 =?utf-8?B?YmtGeGpjbnBpaTVQQnBRNW9Qa3ZrTlpPdmQvaGttTFNLSHFwNHU1RTdtVGU1?=
 =?utf-8?B?bXJoS0wvUVBqYnYrWWE1NWVUWDJaeXB0dTZSTHhqZGRqWmlXSXQ1S0Y3TDNK?=
 =?utf-8?B?cHRwOWpRUGpVNE56eCsrV1ZiMTNmVlJrK3A3U2hxUHc1Y2JqcU4wZFUwTVFn?=
 =?utf-8?B?WEV1V3l5ZU43MXdTR3VldUZCcHRldTdKL0k5TXc3eDN0eWt0U2w3NEswa2ph?=
 =?utf-8?B?cVRwMGZLUjgyaTR6YktncEQ2eCtUVVdKNEhwc1FTZFB3K1p0Si9GQUZrRW1B?=
 =?utf-8?B?MkhRNG0rdmhHRHg4bTlBanptRS8xSG94ZDluK2dDNUh1UGNUcFhncEVybm1U?=
 =?utf-8?B?WEZxSWNCNGsrdXd4SXVOUWl2NEFwTXI4T2ZlejlQTVA4SEV2clRNWnVzS3VI?=
 =?utf-8?B?eGpRWEVhYTVmOWdqTEF3Y09OcUdnUFV0cEFNNmlkc0srNmFnci9pdThydmFJ?=
 =?utf-8?B?ZEpNQnJ2STlJZDVIdUY3QmYzU1lINHRUR29yOXRQRHlQSUx6V0Jsd2pqTGZ4?=
 =?utf-8?B?bTJMcjBqamVZNHJGOFRxajIwWEx3Tk1ydjV4NmI4N1BpbzZvME1pd0RYVzIw?=
 =?utf-8?B?K1p2a1cyczBkWVl0UmV6Znl2dmJsMzhwNTBOQUZtTWpyL3V6YlNxUmpDa1k2?=
 =?utf-8?B?MHJ2S2wzTkFCdnZnSFpzaHZmQThvVjBZeTFxcVptd1VwWEdRYTFXZTRZeFRJ?=
 =?utf-8?B?R0J6VHZJVnhiTng2dkIwcFEraGdmU3dYcG81T0NlZy95Q2kyQThlb3BaY2xQ?=
 =?utf-8?B?QXQwclR0UzJTbDBlclUrdHBNS1ppTm80K3pvdFBERkZWeW1TcWt6WGhFNERv?=
 =?utf-8?B?bzNIQkk2emd2dTZEVkJRNU9aV1VtWHZ6T3ZhWi9WY2ROQlM1TllWc2ZXd0dm?=
 =?utf-8?B?anZXci9SUVpvZUhhM2NQK3haTEc1bEk3RC9VOEJXUXRCMldWS1pMUUFjdFBH?=
 =?utf-8?B?UkJ6bmZlMVI1b1p5eVJHOEc0R0E4UkRpYVBuZ0dqRzJVL1hLTW81MFhHRWJo?=
 =?utf-8?B?STd0TktXVndFQTFwSnpqMW13QTRUTFc4TnUwN0RpS1hhU2xsZ1ZOaGI4ckNz?=
 =?utf-8?B?ejVWZEYxKy9Cbk5CVjdJcXg3SUtaQVpnK2VQRGJ3MHNBeWhwRXV4Y2RiUHE1?=
 =?utf-8?B?TGRwNmhnNHZUemE4a2oyTE95RTZOeUs3NXlLbDdrdmVaanpBaVFrUjlFMG9x?=
 =?utf-8?B?QmkrenNJdmRBNjdFRnFXZDZOaGV1NE54VzN0QnZzeWtZczI2WDBTRGxCbnRP?=
 =?utf-8?B?WjRqSlJyR1FkS1pta0JKUER5SjlYNVhDSE8waHNMQW5UUk1UbUgzK0xFeDYy?=
 =?utf-8?B?UkRJL09Sb0tEc3IrdTZjMXU3L25WK0phbm5hZW00QzlFSk9PM1VoZ1Q2WG9i?=
 =?utf-8?B?VG1zcG1ua1dHYnJjQ3kveWtTVmM5K3c4N0QzZ2pXNEdzcEVUQkJmNUNrSmpi?=
 =?utf-8?B?M1dDK1NJZXNiT0JUNER1RU1qOWZHbUdRNW82YmVEaXBLR2NRNUhTRkVlek5I?=
 =?utf-8?B?SFdNcnFvRDB5T2JkTzM3MHc2TklxTitpdmorS1l6cU1sbGRYcmltTkdPcHls?=
 =?utf-8?Q?u5SiPBZDTbv25BNuvHSJmbyrpGx8h7rc3tCUE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDlBSjA4b2RoVyt2ai9IaUtyaStsYmY4eWd3MTdVRnZYenNqUlJOdkp4TURv?=
 =?utf-8?B?SFhFbWpFOHAxK0dpL3ZSVzJrN040SFlZZGNaWmRlSUxrNnlxV3l0bUlMVTZL?=
 =?utf-8?B?RGluSE1tVERQM3NONW1HRHZiL2R3MjFiZnZxcmFIcEoyanBrV1JxNEsxTm1l?=
 =?utf-8?B?Si9FaUp5R2x6bTRoU1RBOHNJaHJ3Z2ZzQnFDdlZodThTVDVwK2ljL0NJMnZC?=
 =?utf-8?B?WnhDOUYzSHVlTW1LeUZ6S0sxMkRFTFJweUExbDZQS2xnVXhUQXl0cE81d1VG?=
 =?utf-8?B?MzY3S2MvQUE3elBLOTF2M1pvNFpTNHRnQnY2bFk3c3g2My8yZkRCN0hYRmZI?=
 =?utf-8?B?SzRZM011MUdSRVBSdGR0UUZBS1BteTMydTkrSEcxSFNyRmlKOXNpMjcxcUNB?=
 =?utf-8?B?NnJtMnBuRzBwRTdzN29YUy9WMDNweWpLVG83Z09wSEQyN29kLzkvd0NyaDdF?=
 =?utf-8?B?SEgwZHdVcnVTOHJWMXllbktWdHV5N3QzQkh0S2o3Q3oxd0xFZlJ0TDg2S3pO?=
 =?utf-8?B?TlJCelkrZ1g5anVhaEJjUTFXZDZWM2k4K0xMV0IyMWZIbjdSNTFVSnpwTVpJ?=
 =?utf-8?B?VTczejl3eU5pVEhTL3hoRzJPeXhEcmZ2SS94bVRIdU9ocXAvNWIxMmc1ZEt6?=
 =?utf-8?B?RzRnVEk1dkVRRUsxK1hhS0FGaDYvL2VuUVJJaTFna0Y5WjVZanhOQ3ZHS3dS?=
 =?utf-8?B?SkVmalFtbEZybllOMElvbGpZVnhyVEpKQ2h1Y1RHaDZJMTFVdHJpbnpMRWY3?=
 =?utf-8?B?ZTNOL3FlMCtoY3NBVmVqODA3ZStXWmwzTE1ZQThacDE2VWdyUVdMZnhKWFRx?=
 =?utf-8?B?c1JZbGRtL3BaUHJnQkZ4TWtxd2NuL1lINkRyS3dPMExSMHo2THJTV2lSaXpk?=
 =?utf-8?B?OGc1QXZQL3R4dktJdUhhSjB2M25jOEhvRWUrdmYxU3h4T0Y3VVFzWFh0WjJY?=
 =?utf-8?B?RndYQTJrTWd2OWRabkxHNU1WemVuME1FbVJTTmFmZk5JYnhyYXRkQVBrSjhK?=
 =?utf-8?B?TiszN0FHNnd1MUlXNVN2eUE2Z2c1SElQS2ovbDhDWG11QU9WMkNUV1JPejFz?=
 =?utf-8?B?L0pycFkwZTcwVnJDT3VKRDg2WTZXQXMvdWNScll0Z25aUDNZVldWWGpqVkNp?=
 =?utf-8?B?c3Q2L1FjSHl1cnlGNDNuTE1YOFBReW5qTCtoYkZDWUphMVRYRk9jNlVzOFVQ?=
 =?utf-8?B?bXBWQm1hT0JrYmtydndjYkZGWlB2cW02b0tFalhtOGtKVjZzYUtOcy9zckpM?=
 =?utf-8?B?QWVvWkJqUktiTGJkL2VFVHhGN0FPK09rQllRL05QWFJYNEQ1OWY4NUV0d21r?=
 =?utf-8?B?QmEyaVk4OEVSR3hsbGJiOG5HenhKeUQvSWlmSUZaZEkxaVJMdlB3cFJiZDFM?=
 =?utf-8?B?MGt6RGxDYm40d2hCUTBuNkJ6emhKelN6aHpRb2ZUU3lLWW5ycVczRTh3cnF1?=
 =?utf-8?B?b0w3eUZmMitFbnFQMFBtV3NlYWgzYjB1WlVOOUJRZEVQNGRYWVVhUEJ1YzF3?=
 =?utf-8?B?MUp5Qk0weHMzeE1MeURib2Uwd1kzRkJyN3BycGJjZXhJYUtUSVY1K1d5M0xP?=
 =?utf-8?B?TXg1R1Bka3dDUTlGRnduSlFIc1dPS0VsOCsrVU9idjZvREl4am54Mzk1THVq?=
 =?utf-8?B?TlVjMjB3NGpIWFA1WjBHcEZTaEoxcjZFN0ZVTTl6eGRQeFo1YlJhWTlXeUVN?=
 =?utf-8?B?VWxXc3FFQXVIbDNZMWNseURWdWFhRm1UZExtcHZHK2Q5eEk1RVA4SVlTNjVn?=
 =?utf-8?B?R0Q0K04xWVZwcndpZVhrTStwWWpUU256di9mZm80b3JCR1dOclgvQmZGL0do?=
 =?utf-8?B?dHNySGhMR05RSWpHUnVxbHN3OFFoQndycHNBa2NpbHNVRlpwVElkN2Zlc0RS?=
 =?utf-8?B?SjJpdktDS2VCNUVUR2orZEhhR1BocVh1Z1BvTDJYb0lHTDhxTm9IVmVnbEVB?=
 =?utf-8?B?MmZSUy9WK25IOUtuZmxBbFpwejlmWjdJWkF4dkkzejQ3cWxUL0pNeE00T3B3?=
 =?utf-8?B?cmZRQ1VXVEdZSDlMM29zOFlDLy94RGNGYWwveVkvZGFHOHJYWmY4NW5tK3Ja?=
 =?utf-8?B?SFdqT1A5NldiQWZ0TVBvYyt3SjUzL0lhbXY5Y3pXR3Z4V3hwNkRNWWMrcnFR?=
 =?utf-8?Q?j5BCCf9dy0A3FCFH93uvWz2Wv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb590b2-d10c-4364-a399-08dd05b3806f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:24:26.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBM8PpjLqqG8Ly3azIHaSkfQaLCJUgUUlkT8CzVX40fhqMVPDgJzPNcQhYiBf7CEWwu4UVUgEO/iMOmkdzgv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8231

From: Han Xu <han.xu@nxp.com>

fxls8967af is similar with fxls8962af, the only difference is the device id
change to 0x87.

Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 1 +
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 9 insertions(+)

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
index 687eb49035111..c66ba3ecf373a 100644
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


