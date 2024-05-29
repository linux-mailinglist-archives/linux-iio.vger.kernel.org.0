Return-Path: <linux-iio+bounces-5420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E058D2BD7
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 06:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEE01C226E5
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829EE13E05F;
	Wed, 29 May 2024 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I14TkWDW"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2100.outbound.protection.outlook.com [40.92.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435610A35;
	Wed, 29 May 2024 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716958705; cv=fail; b=XZjCjula84azbJOWa7yxdSLh0Niudo0Vcb+a4FeWIKdVtLMmIHKJ6ArIGCRVZX9m4Kb1EkzCLDr0YPjLHLu0C3Tp33MNIVo1Ek5Ls52bnFiyPDuuXLJ+GXfhBvXO8+p9L6sJIlAWHOQ6x+6XesC9qSGOEsAO08LEKFXsK8cGNH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716958705; c=relaxed/simple;
	bh=XfdcftjDJ0+icnmjWALKgQIgubBNnF+ryVKcxmIQ13g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qm4QwbEnoVnQAqrIiFr/Joj6235jXytvIIhbTQCSEVgRVJBS7t9aQ3VT7+GZZO3HMTgVELBtyO6MKylaC02ykQIdpyiJQOOlaAHhMus1SnYY57AOYQCicJK8V5ATpWBO4evUWZuV1NkIf4AJcq5mAgFkVnIgIAlUoG+cJcfg5T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I14TkWDW; arc=fail smtp.client-ip=40.92.41.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIn4Y6o4z7C2ifdDHRBNB3WZvHTYzU3r0f/PVuxhKNv9uKl+DIGnbVEw4X/4rU73nUxjVkyg9U0RNC74j8zeKiH+rEtv2SIxgYrzNlhPSUJN7pF2pq6qDJQ0YZK6eAOgdcdj9dwJacyf97mecCcH7NeEmhvnAAsv/mjrpxvMPK5AqoSCjoQS5A6Mbfa9NJbCi6owHoEDyFJtxVkAWRZv4IPQx0ngS77yPx63c/UtbTOH1D8EL5y4OdMps9Oqt6mrxiJApW8hHj27ECtsUERzoVDTVE2uajzGjhxmcxOHAnvFKx+bApeWgiixyWeuoLiBgGvXB1u4UrZjQ7VadPkLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISsBsF6kVDXBNEuEWbUoRzacB6/N9kwomjh5I29LSQE=;
 b=BlrW0HVY986ZZy1i+3fnPbj1ni59fZYtLBVcsDd+zfOhtP8zwRz6isHLQIJcGZY0ITmaRyakeRD32NMHaemb9NADqlESrF1QfOoK0HTtDBhQ24gz2gIZSbmMZL29k5xhTTvup2egqY4O6j/wciRBLkDTV2QNKF1PR8sUnDKvUhlGKzgZy2G9d0wyegbqzVj67jD/Vw7Cg0UvWtEfCQOswuaAE2Cri6vhVZ4Pe4nm3guk6aHBinWvZWqLlC+QqmEomnJmm+RwQXgj8LLLj0xX64ZOo+MR7T+T0dD5UwvSGwjpOk0r/BU+iTopAEHzN30wliffPOKnJmagerabZG87Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISsBsF6kVDXBNEuEWbUoRzacB6/N9kwomjh5I29LSQE=;
 b=I14TkWDW9+qqjfW8dI8RstCDSQj1HAjfD33waHfjA+C7oP6cfwCmscJO1z3HKcPnRMz5fIb7pDwn0XMkdLUY7//pvYji5/q7Me2bMS19Vn3HwAHjfARge/dPNdGNFLilSELtLKpSOnTcI4MfqHnsa6f9O5lNoI60Q7tNAF1GhHds3g90Cbuc8RQV1gmjJQ8Q1XgCPDKwIEr9WJHsSqvF6biQEisGizGyRpBNpRP8cXfkGT+y4D7AP6bel3H90C5nrx9uLMV9yLjTiAA6r88rb7i1rGEOQZ8K1J6dxB+J1Evn5o84zO2iiGRDWpXqCOhc1Jdg5bG/0bqiYP4Nzo9/jA==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 04:58:21 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 04:58:21 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
To: jic23@kernel.org
Cc: andy.shevchenko@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.a@analog.com,
	swboyd@chromium.org,
	u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: [PATCH v3 0/2] iio-proximity-hx9023s-Add-TYHX-HX9023S-sensor-driver
Date: Wed, 29 May 2024 12:57:47 +0800
Message-ID:
 <SN7PR12MB81019093E9E5D29BEC4B821FA4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240519162438.17af0ff8@jic23-huawei>
References: <20240519162438.17af0ff8@jic23-huawei>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [ad9Jh13qDtoEGhViwWRAq2/O/eoZLYbA8ScsC9Cay7c8cpQGrWbGgqDuzk+gG8HGOriql7QZsQ4=]
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240529045749.530039-1-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: d92ecd77-cb3c-4e84-c158-08dc7f9bf642
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|3430499023;
X-Microsoft-Antispam-Message-Info:
	3fpeMjar+dOkBxyorffVCS9QoCU1WJu/CGrbv7CoCfDiOASzUKCYac7a6fH62cbuBQatMIh/CB15qE41KUoLOWB6VDwmnJ0IK7EZCamubY/eI/qjGWFDrLAX0TBVDvkenCYC5k7xZ4U0cWs9+8hq1DLnXGemBG3IRENyHUObB9Hw2Rbkw1Q/3F2dRNXRoiImiLFqcSnqHvwV/5Vq+wPO0l6qpR4HuYdAggM5OXC9uoKpMwUZDN/+Mcbg3OPyTbEb782D+pD3M7HwP4oe9wadrmt5iuTBK4A3jO6isa0U4G6BVzgdoZPjJWYQzQUUUJeyCU+TZeQYoBVWSsFGeYG/mOrpIMJ1crB4fPOr6eLgcTK7LKyUqPvgZj94TrhQ4TSiu0dZ+FOMle82W2JID6cZLhoRNxWqiLIx0nfYNMMP3KEWXfUz5gZ7ZlFX/M+p3jz1oPKM4nHCi5LOwc7/FyC8ndWDY/Qu9hnSHy1sSZnsf03SPWoaguii9MZCL+u32RpTLETNbvPYEeQ5WSNaqRmBv9HGvhZd62KO4p7BPM2kfyh+Apj4X8iyhC8UxhZofvMD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ejnKUH5JEORckFDFhxUcNz+1FJHe4CHdo/bN9mQAWQOmM9SDztwP57HAnQiO?=
 =?us-ascii?Q?X82i2lQqMc3DboMW/ItP0yDwih7jlX203Dao8Y0pikefAcEBXwkp/ucG9OT2?=
 =?us-ascii?Q?qCnnbkk2FybOXb7LbfFTzWhk1VCFilVabXc2KE5Aghu7HDjoQCENRQZg3KKX?=
 =?us-ascii?Q?uHGClDMnWG+J3oGaHg09az6XWeyztxLvwAKIm/Sm1Fsou0M2E7c9+K6qAD2T?=
 =?us-ascii?Q?12zoCPg6zJIF2HIgDEZAcI4j6Ew8U7GzwBmzD0rB9ImDxwKbCU//Md99K0Kx?=
 =?us-ascii?Q?9FQwd0PGr7A/juOCvIf1FqJ/LdvEn6qr8CGNgACJaLk0+K5k1sRpjSTEv/SJ?=
 =?us-ascii?Q?UJ1Do/w4Z6/svwDeq2f6Imq4aOPQAZ+lqs7rsQ85PhvvNaJ/+Zmhvc/LSEsX?=
 =?us-ascii?Q?pKrg1u92VPVLJ+ChgSDvcyA2cm64hOsYJ9Q1FhfUGnTlPPH6s2CE0UbRPwHn?=
 =?us-ascii?Q?iQbNsPXsn+4GXxw/174yA0EX23tmV9UHOy7HM6ND0Y8dm5vu5QtcT/U74YpE?=
 =?us-ascii?Q?wMc7BE11drt5w9DqGpuIbn8Gd6T8jY1j+6u8kxiFe0oCitVa2PPQn4FgqUKP?=
 =?us-ascii?Q?igTbAG+IY3QSZgJn471A4mM5HEoplvxuJ5FrStIzCMBDJlusV21XJOo9Lv7y?=
 =?us-ascii?Q?TJEcsZFHgUzg738xJ6sPcebCyhxRPLRKT1oN/HO4f9JemcMWrNutSqyGWzaX?=
 =?us-ascii?Q?7OyFgEbCJwJPurl/Yt7aEs4DmrI3v8863PH/VX+rajOxFUKVBDVsPiZ5vRLO?=
 =?us-ascii?Q?/eLRXIc1W9e8Oboqc1wZAQ0gQqxiVnkHUGSnF59HIt/+ItqWrRxpJNUNI52l?=
 =?us-ascii?Q?bZv3UBYV+HKR4BwKG51Y6EsnemcLQbcqkswamNWXO4F/GUpclO1HtQyilgB/?=
 =?us-ascii?Q?JgK5RTXOEYoaqjgg/mVTkXe1oMxqflD1AEzMZrpPqvoTpfVsF7Xk+wDFaYVo?=
 =?us-ascii?Q?Z9jWk2gqJIK0eMy1VZBzlJkxrN1xBDxsYP3O9nTJYR6DgsRjMewVEqjK/gfg?=
 =?us-ascii?Q?DEyiYPMJEbAyVWfUPDjqf9VKjgCNJ3hEzUabEDK6aLfReO+VqVY8WVIDb+hm?=
 =?us-ascii?Q?4t/ockSOwc3RyqgEqVZ0+AnwNgS30mFHGRPgaq3MXOiI4c8ScVPEmxgYcWpm?=
 =?us-ascii?Q?SgitSFWfAFRpxnP2n+0TZs8qd6UaHrqcmXmh3e0pHNFgsMHGdfBHAEKbgDsd?=
 =?us-ascii?Q?bhtjvYKqsAz42mh75J+DoEX34V+u7kLjZR39zufYBcupSLgjJtMrr8Ck/msx?=
 =?us-ascii?Q?w+xltdjKBJQrczdUUwwuimftWhsr+R7OeCvDFsgxI9dxdd3J9LGCJBzf8N60?=
 =?us-ascii?Q?bc3XrEz5nIHXpE9F2Au58QIE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92ecd77-cb3c-4e84-c158-08dc7f9bf642
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 04:58:21.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

From: Yasin Lee <yasin.lee.x@gmail.com>

v3:
 - Renamed the files to keep the file names consistent with the chip name.
 - Removed custom bit operation macro definitions.
 - Deleted redundant documentation that duplicated the Standard ABI.
 - Deleted unused header files.
 - Deleted unused register definitions.
 - Changed parts of the code related to circuit design to be configurable through DTS.
 - Removed unnecessary print statements.
 - Fixed the error in hx9031as_write_event_val.
 - Removed unnecessary threshold settings in the probe.
 - Replaced enable_irq(data->client->irq) with interrupt enable register operations.
 - Fixed style issues.

v2:
 - Deleted the global data structures, replacing them with dynamic allocation.
 - Delete debugfs.
 - Fixed styles issues.

Yasin Lee (2):
  dt-bindings:iio:proximity: Add hx9023s binding
  iio:proximity:hx9023s: Add TYHX HX9023S sensor driver

 .../bindings/iio/proximity/tyhx,hx9023s.yaml  |  106 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/iio/proximity/Kconfig                 |   14 +
 drivers/iio/proximity/Makefile                |    2 +-
 drivers/iio/proximity/hx9023s.c               | 1428 +++++++++++++++++
 5 files changed, 1551 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
 create mode 100644 drivers/iio/proximity/hx9023s.c

-- 
2.25.1


