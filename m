Return-Path: <linux-iio+bounces-6314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A587909C2A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 09:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3167B2110B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3BF17994F;
	Sun, 16 Jun 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sAcP87N9"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2057.outbound.protection.outlook.com [40.92.40.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CE179663;
	Sun, 16 Jun 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523481; cv=fail; b=lUr/MSzDkl3voxFJnQdzJeq/p9ePsLvBQIIxZy5e/nAcskdwnkRIfZQw+bp+fzqbT07ex/7xkX7EBEeCHli2RrNOAUfzQtsaUYuqgOzTVOIHsFn/PUTSkWq7Zn78+9UZOkujeRPPytawuiinJHA0n3QUUa5cBhI+0rckTBNxNKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523481; c=relaxed/simple;
	bh=nSN34mn7Z2Nh19QGVy6QRozihN2zXnb6NafzsUm90Bw=;
	h=From:Subject:Date:Message-ID:Content-Type:To:Cc:MIME-Version; b=kx6yaa+5itBhgJvD2RVI1pIA05AVfqogN+9Xn8/kbP2VeVsHuplYMo4W5lLzXtJADPvyFBJYP7KK3KnHwbZ2zAFt8wdn+yKO4p5zUrrLOFBHOHBHSa8W8NKC8kNOLj+/rPEw0cIAtCc6hMD69vagWT76olBJMJVSlYvx/D7jI6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sAcP87N9; arc=fail smtp.client-ip=40.92.40.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSS3sNqA88ylgFwLJTpTXeAe+mqc9rCnHklMxY7oBeIX2q+Ka9pa+/I3BW+S2+YwqtoidRd2SHudhcAQT5P/IS7PP62XGdNgMiiJcv8H8Xyj6Qf+tlvECzha5fyZesnJkmx+Zq4GtrvU/cGfsRAO+cCK7TSTnmp45MwZbygKHIfX0Edlz3iHCg3U+lGcV0XQBhzZpa/M//OfqIWb0xoYjYgNpB/rFPNoj4IxvjcN6q8Lqfbb9BAP8dpN7zFDMp3HOu4y/oZb06sb9Nmc2IqeJF/ldWY44gVLnSwoLq7WDqnKQjCmtDaeHdx62Pwnccqe5lLUoitnKKVgXaE3uaXs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woAmlDMRidbIxqYoWE7Ad2/0LhDf52vyyKQWT2Mofk8=;
 b=UIFvvw9lLku/+AYUKNYpMGciaG9qUqjPHFZR2dJ5GVvaf3h+hugzfezPsV9r1qCQc0PZimnZ6S8GZ3J7zOR/0A6zISNr+mTfuIwm0eVaIHmeYH2vBDFSTjbZPSPsai7c5UbYaqxlvavIBwzG8X5FQqWoegTtuImGp5CLZ49UDKlsnE4PSKch4tjC3hvgvgWFJEUnDov02JlnHGPWEWJ3G5blFzu07cfJgT+KuqxKVqWiO5M29/hrxwDcxC47/aftLnSvuHX3EXMukzhpguEmPtUg/x5T5BdpwJbm23YcjvS4vCI5KIhQR1HqEUDWtVUYQIt0adceIwNOkCiGTXrPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woAmlDMRidbIxqYoWE7Ad2/0LhDf52vyyKQWT2Mofk8=;
 b=sAcP87N9uFUtjpjsQ0hotWB/l+UvD03oycvIUpBbt7ML/wiVvu8R72OLEOLMHB3icu+HIJzCGrSQFKYAa/VP9BztPwO2vaSmfFZkmItLetMl/EUiB0EzEDrHWoGSJlVNz+QHHe8HihajG7w4OPECdGhsgrPu31dF5BOvXR/i/WgjETJPYMahRELbnnhA72q9Xsm4vWrwXE6iLuHpQTSuzHei6lPeFFT6JTT4eiWkmgUyp2VSxD4cIPg0SwYiyQ4NjZDjMiwjiTvhd7yi9YbPJ4DKJa+UWzYmUh5TgbndykZCIlzZyOksFGBEeyu6PapAkK2UgTNf5CTBzZtvWYjxjg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Sun, 16 Jun
 2024 07:37:56 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Sun, 16 Jun 2024
 07:37:56 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
Subject: [PATCH v5 0/3] Add TYHX HX9023S sensor driver
Date: Sun, 16 Jun 2024 15:36:46 +0800
Message-ID:
 <SN7PR12MB810163A2116D5F84FF3F866DA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6WbmYC/1WNsQ6CMBRFf4V0toRWKNRJUNw0RkfjAPRpG5WSV
 yQYwr+LbI7n5uacgThAA46svIEgdMYZW08QLTxS6aK+AzVqYsIDHgaCCVooRduP7qnuZcCXjjq
 onUWq0HSAFGJVwrK8QSQFmSQNws30c+BynVgb11r8zL0u/K3kfIiPJ8b3WcICFnPJ8ljmIhMsT
 bb5RqZRGu4yvv67+XXxalAx7jdolW/f7dPah1/ZF7mO4/gFPnfJBNcAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718523473; l=1774;
 i=yasin.lee.x@outlook.com; s=20240616; h=from:subject:message-id;
 bh=nSN34mn7Z2Nh19QGVy6QRozihN2zXnb6NafzsUm90Bw=;
 b=O+n4YZSwYKnDhVL1oix9cF1XBz/3DiBA0egVXslgeCDUbvCJCQZDlpRCJvWADMbVE4wYvvWgX
 UKNiR5vT1xNBIW7R0cYaqPdMexyUY06MHMsAJ30uB3vCDaeKZ4FyAsT
X-Developer-Key: i=yasin.lee.x@outlook.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=
X-TMN:
 [Rcn7cfpj5MF9Xuyzy5l25NFPpHfExPW4dvQwqGYeW6HHjO3SVZIP22FOza1twoKauT1GJUKIMoQ=]
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c5a4d0-da84-491e-15f0-08dc8dd73d17
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|4302099010|440099025|1602099009;
X-Microsoft-Antispam-Message-Info:
	8K+nUg++trfMxPlmES0Rx/ox2iMVkQlJl7TLRPdAF+PEck9lJsE4qti4XNXqOi2JUv5OxkK1bECbCVhn1Yfx5fZQZdBC7QpXhJUliZHX6NmiQon2FwthY3jtYYbDOKsAymS0Yd+YHvTykKPlRrLTmgQ+Msj6l+CJuGmzw2qEQtcCV7hdxAIm3o3C6BvmlKIZwvex68lyguMBYMv6nfRfN3ef2WppvL6HV5gdZ7eH63v0Z7t5ClBvRBV3z8als5IF9bwxrLG04UAYurFF+qmb5u/0PwADVDXfeqGlu/7Fy39ZRyNLIZv1U9OZUYZBhA2tDSC74w4hUM/XJx8hBdxKrMkin44REqkMQwcThzKgdq22LihuN4erUE+5BwK6LfVhdkwF4b5IwPfk1ChS7q4epuz02yk+7rwH5H1XAnFjINYNK9dyJS2+pwB+QPPXiPEs8yyyybfWlyOvtGnlk3sywgOyv4/ZkWi7aGD1eIZ8Z1/4+QAf73SMPDNGtIGSfIobsGi5+03T3x4xZhp16JKT8YeE+GDejAQcJQhUMA4EYUT1b08UVIQxBzPXlN2A5bLp9tnprU52n8HMqD8E3aEPgMqTrWEEwbJpbfEIE8u0eeEcPMIkcFnRM7wPz8aBiNZ4iCjOxr0saW9jnvuHjrFRRilhEjjPj//ULO1lISPp/L1q7tdDB/0GYDH9jNfh1E3fosGRA/4SSfP7SxQ3HvLT4Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXliYjJGbTBSUUtoK3JCSUNlREhQZnk0Wm1QMzZ1dCthQXVlOG1GS0x3Sllz?=
 =?utf-8?B?bTdpY3VwZGN3NlBvUWpqeW41cVpxUFZoR2V1ckR3UFcwSFFJNkpYU0N6dXFM?=
 =?utf-8?B?dXRJb2dhQ3MrZUpmRDdDUTRTUVp6a25pYU80WDRGS0RFUERkK0g3ckNxejVo?=
 =?utf-8?B?S1YxaVZqMW5FbFBPVVdkU2JBZ1o1TWVlWCtTOXZZeGR1ZzE1em4wMlVxdTRY?=
 =?utf-8?B?ZkJFejVhbjJhZW0vdTUyWHBpRGpTWitIc1lvbndrczVmL2ZIN2V0U1gza1JD?=
 =?utf-8?B?cGUwSlhBR1VlNUROem9BdUpUcWNBdlVWRkhMbThkZWRLVUtJVFgzQ1haZzJG?=
 =?utf-8?B?NFh3NjVJUWplR2dTVzVzNFZxS2R5M0pBWkdKSTZnb09BVVFVdE1UMk0rNGFv?=
 =?utf-8?B?cG9oRnk4SFdWODl5aDVoVFBGTkQ4cW9SSUFiVnBja1lPZHU5TXppemkveVpy?=
 =?utf-8?B?SWI1ZTdmV2J6dkRrekVCd1A5UG8vSkNJQmxYSXhJSWxsSHVqUm4zYTM4WjFu?=
 =?utf-8?B?dDBqdk5SNUhqWHpQeTloVW9UYVlaR3RSbWFRZXgveFBicElwdjdEQkl4TlF0?=
 =?utf-8?B?cFNCYk5DYUlmamQvczRuTVBCNmxvVWtrbzF2OHRDQUwxRlBIQlZHUmZOOHRQ?=
 =?utf-8?B?UUs4aE1IZ2h3OXZhMnlhZHhrc0M3TnpSY3ZnczAveVN6VWxOOWZrVldYS09W?=
 =?utf-8?B?OXRURnhqM2ZvczcyRjcxeldGM3J2RnJjdko3bmFYQjRvdXNBdGZzSjQwNDdy?=
 =?utf-8?B?ZHRSTnYyL3JMQ2RkMWszMTZmTTVrWXdtQTFQY0d3TEgzVzJmSk5KV1BQMHc2?=
 =?utf-8?B?cUNGS1U2MHJKMnpLd3IxWjJWbWZhWVdqV2Z6RGRYdlByYSthMU1zbFZhK3dI?=
 =?utf-8?B?MWZMQ29YSHZOUk5sOExlbGp5cnpwQ0h2azJNcnpBajVDY2xNcWdQY0FxdTFE?=
 =?utf-8?B?dlArL1R4L3I5aUkzUmJGRjBPZ2s2QVdpd0cwOWliREZ1d2lZSGRlL0ZnREJn?=
 =?utf-8?B?YWFQUWg0aGt1NnpwV2tFVDF1ZS9sOWVSYVdOeEhXdDc5QUtuUENNWEpmZWp2?=
 =?utf-8?B?c2lZd3RkRVdCYWZHYmpRVzgvRUtCVDY0N0xjNTVqSFpWL2JmYnluWTJpTGpR?=
 =?utf-8?B?cGJodGlqQTZvK2xtYXlWSHovVXNjdUswcXFmZWZ0SmhtdkI2cWt5aTN2TldQ?=
 =?utf-8?B?Nm01aUFOMWg4RTNNZVFVeGoyeSsxd3Q2b1IvZkZyakN4MkVzK3lkK0ZUYVhS?=
 =?utf-8?B?TDlQem10YlkvS3o0ZElmZllqdSttaW5HZXBhK2tsZmFVc3ZyNkJ3L3hFenRu?=
 =?utf-8?B?dEVDQ2NyRklZeERmTmxpWS9GYWZtYm9wLzc5c1ZUaXlaOVh2WmJtRmg4d2pV?=
 =?utf-8?B?ZmFnbW5MblUxOGhxK0Z0cnF2OGFxYVNhTENVdXI1YWlnWWduUU5sRG5IMjRZ?=
 =?utf-8?B?Qi9qVFVXYWE5NDJCbGhrR0hNRFF1aEV5NTVCR0ZTRDBLci9lTjUyTU1Zd29C?=
 =?utf-8?B?dTYzVzd2c0RNdmZlYTBHQno0dUJKU0RmS2tqdWphZFlqanNBeWV0MHNyRkcv?=
 =?utf-8?B?LzlpWmxTRmlxb0g4WXB6U2IzWms4Ni81UXNJZ3d0RTQ3d3JmRW9rLzdWcDZy?=
 =?utf-8?B?T3llM2FXem5CTG42Wnl3MitiYmQ0R2VIRkFpNFkrNWwwS0NGVFM5VTlmQkNJ?=
 =?utf-8?B?V0NhbUdwb0FKa1B3YmtadUxIVXBtMmFYSjVxNTR5bGt3QW1XL1MzMlB1b0Ry?=
 =?utf-8?Q?C0AgZbsOHp8qyEqyld3Y3UwvmVjAlJSCdRXn+7Z?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c5a4d0-da84-491e-15f0-08dc8dd73d17
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 07:37:56.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818

Changes in v5:
- I have addressed all the issues mentioned in the email responses.
  Additionally, regarding the IIO-related header files, I have checked and found no unused headers.
- Link to v4: https://lore.kernel.org/linux-iio/SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com/

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v4:
- Removed hardware-irrelevant properties from dt-bindings, retaining only channel configuration
  related `channel-positive` and `channel-negative`. Grouped by channel.
  Retained `channel-in-use` as it is hardware-related.
- Removed redundant register definitions.
- Reorganized `struct hx9023s_data`, extracting channel-related attributes
  into a new `struct hx9023s_ch_data`.
- Optimized bit operation related code.
- Replaced `of_` versions with generic firmware parsing functions.
- Fixed other issues mentioned in the email feedback.
- Link to v3: https://lore.kernel.org/linux-iio/20240602152638.2c674930@jic23-huawei/

---
Yasin Lee (3):
      dt-bindings:iio:proximity:new vendor prefix: tyhx
      dt-bindings:iio:proximity: Add hx9023s binding
      iio:proximity:hx9023s: Add TYHX HX9023S sensor driver

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |   98 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/iio/proximity/Kconfig                      |   14 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/hx9023s.c                    | 1149 ++++++++++++++++++++
 5 files changed, 1264 insertions(+)
---
base-commit: b4b34b020896597406448392ae8678dcb2183803
change-id: 20240616-add-tyhx-hx9023s-sensor-driver-e7dbe3bfe596

Best regards,
-- 
Yasin Lee <yasin.lee.x@outlook.com>


