Return-Path: <linux-iio+bounces-12291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512239C9669
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A8C1F225A2
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB321B0F3C;
	Thu, 14 Nov 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a/d4C3mL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E16374CC;
	Thu, 14 Nov 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628237; cv=none; b=Iq3wK1DeaPhsLH7Vx854x8Oty6Mv7nWD1x18DRV6sAl8t66GFDdzGi6wymrJL+fJxMauAM+9LVU/E+XpNAf2Z+W4fhv9Fb6Bp2jOz8FhQAzLmq5m/b12RSJLhrN/zDI5a3dmwO8EsS6PPSGXzw5Dq47dv/uPIOdboSe0XJY5J3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628237; c=relaxed/simple;
	bh=q67R8fDELJk33y92tV6yiParsk7J2Bwl0F4EVceOGWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TI+52MH79dm+1BXtVXUclq2DoKx9p3g8tAB7AyEqVoHSQ9tzgRIJCddhI8i/HfZqVJTKQxkIV41YFYG3IBDC1tKu6uJxidv2AuE4Fb4xwFqW7sUIZWsfJCBRzb1UD43FGy2NxuZnbxlXBuES4VLhuNI+/CVkD2MO5XT5cxk8bMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a/d4C3mL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJ55QN025925;
	Thu, 14 Nov 2024 18:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Ju9EokhG+GJ50YwKU3jN2wj3WFJ
	UbMIQbRrG7KNd4qM=; b=a/d4C3mLalplTN7JjY5T9isfrvkkfChIkQl2uvw0Mca
	3mgciE3NSdPjvL5YQxVyma1e77xebVmMUOld8stjdYSufOkp/YvUASwl2O9gBeuc
	HW92icvE04l5i2/i3/mg1S2qnBhwzOCn5tCR374FseaKi2895mvP3cNvTSKvmXHo
	n6jAthFsEXmR5ZKOjcDLOFbCTP31UZdjyiNAIWAzBCni/4aq4oAXsLFxIk23hUu4
	yGqg8dEKkaIHLQO6kjfIipGOWRbDN9Pv/rcPuXRNKcpWu8rdsjefhjTRVnvBW7lu
	ibEf/T+MjvShKQShzH5mpowKnsi8X/6iqb1GsyXMSRw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42v48jhkmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 18:50:20 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AENoJCd006598
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Nov 2024 18:50:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 14 Nov
 2024 18:50:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 14 Nov 2024 18:50:19 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AENo6M3028806;
	Thu, 14 Nov 2024 18:50:09 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Timestamp and PulSAR support for ad4000
Date: Thu, 14 Nov 2024 20:50:04 -0300
Message-ID: <cover.1731626099.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: wrAp4Pe3JPKs8tBwh0r_CME0Bu10TnwY
X-Proofpoint-ORIG-GUID: wrAp4Pe3JPKs8tBwh0r_CME0Bu10TnwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140188

Complement the ad4000 driver with a timestamp channel, a minor adjust in
transfer timing, and support for single-channel PulSAR devices.

This series was tested with ADAQ4003, AD7687, and AD7691 on CoraZ7 board.

Marcelo Schmitt (4):
  dt-bindings: iio: adc: adi,ad4000: Add PulSAR
  iio: adc: ad4000: Add timestamp channel
  iio: adc: ad4000: Use device specific timing for SPI transfers
  iio: adc: ad4000: Add support for PulSAR devices

 .../bindings/iio/adc/adi,ad4000.yaml          | 115 ++++++-
 drivers/iio/adc/ad4000.c                      | 311 +++++++++++++++---
 2 files changed, 374 insertions(+), 52 deletions(-)


base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
-- 
2.45.2


