Return-Path: <linux-iio+bounces-17267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C158A71777
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57679176C35
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7C1E8330;
	Wed, 26 Mar 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lKiFVRlT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5919E7E2;
	Wed, 26 Mar 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995507; cv=none; b=YnEUjPwMVpRHk3uGx2CP6LXB9tRRJrWcijblQWC4RBXfKklHApnjvk6/RXkPgSNWi5ULnpglYwg+mC6BhQC39ZVhagBZQeENF9dG9OyIz7PobzggyUXZKql5Pf3iVU66bQQkSyq7kAP1zAhc6wJG9dEFqDjHVC5AZru73sC40fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995507; c=relaxed/simple;
	bh=Nl+10FAzfsORuUu1DCuzZNgcTfzPXOUYYQaR/dcvcHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvsTO0yqhlLSua52+JZrYSAcHQPEk+5vGy7SA9damo8QujJFbMjE7qUE0g7omeiZkRBpKL5nSjc/KdOwa7Ypj/lQnYhwWG57yuoDo8Vj0f3I726fyv+nb7zZNz0AYCpnbyoHa+USHmMmye3t02nVnrtavSKfp0VdJ2klAwrCGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lKiFVRlT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9Vo3V014128;
	Wed, 26 Mar 2025 09:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gWv2MyO/NWHLdJ26ZZhkCq82dNl
	g2t2fpQcAb3y2jdI=; b=lKiFVRlTZ7ylDmYIBQ9QQnAonywvaMpibkrNBgA7BjX
	iIMbVHKh1UF/xj0cBlxM6Rg7bbqfn4dEkjzSetpedxtmd72Db14njMGYOZDSZ+kG
	ajV1WfieJgU/LP0hOnrYhFsMtRlx4tbZ5N2h+IJTKN+ZoBWQ9S9wu/AsRymS2zz7
	9G9Iyqeh+7zDsiRApURpxIqQEe8ibn9nZmdMtfqsk4HlXKxqkV7ZuPVCrm0WCFtK
	j0LZWYmW3SGFbNaxKK97WE12Vk0xL4oa1+O4kPdpDBwF5uu0Xge1IzyOpSb20Mkg
	8NDBZxcRinO/YRhkXbALQZioaVQYkPBns1Pby/A0idA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45mf1h0y35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 09:24:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52QDOY0n042990
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 09:24:34 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 26 Mar 2025 09:24:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 26 Mar 2025 09:24:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 26 Mar 2025 09:24:34 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52QDOJbU007524;
	Wed, 26 Mar 2025 09:24:21 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 0/4] iio: adc: ad4000: Add SPI offload support
Date: Wed, 26 Mar 2025 10:24:15 -0300
Message-ID: <cover.1742992305.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67e40013 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=yEi1-Fu5WF2DL2A3visA:9
X-Proofpoint-ORIG-GUID: -MccmbZBhSl6WKwg86snZMKUqdphdZn_
X-Proofpoint-GUID: -MccmbZBhSl6WKwg86snZMKUqdphdZn_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260082

This patch series extends the ad4000 driver to support SPI offloading.
In addition to that, ad4000 IIO documentation is expanded to:
- list PulSAR parts supported by the ad4000 driver.
- describe some characteristics of AD4000 IIO device.
- describe changes when SPI offload is being used.

Change log v2 -> v3
- Dropped patch 1 of v2 series and reverted buffer endianness and SPI transfer
  bits_per_word configurations to the way they were in v1.
- Removed dummy transfer in ad4000_prepare_offload_turbo_message().
- Unified offload message preparation.
- Removed spi->cs_hold.value to use cs_inactive to set CNV/CS high time.
- Adjusted max sample rate for AD7983 and AD7984.
- Dropped AD4000_TCONV_NS and made all time related constants a time_spec field.
- Removed _offl param from _CHANNELS() macros and added a comment about that.
- Commented IIO_BE check in ad4000_prepare_3wire_mode_message().
- Now using predisable to balance with postenable.
- Put spi/offload/consumer.h include right after spi/spi.h.
- Removed unrelated brackets in info_mask_separate_available assignment
- Added blank line after if.

Change log v1 -> v2
- Fixed passing inappropriate pointer instead of ret to dev_err_probe()
- [new patch] Set transfer bits_per_word to have data in CPU endianness
- Set iio_dev num_channels close to where channels is set.
- Complement offload message comment about first sample being invalid
- Document why the first buffer sample is invalid when offloading
- Added blank line before a 'simple return'.

Link to v2: https://lore.kernel.org/linux-iio/cover.1742394806.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1741970538.git.marcelo.schmitt@analog.com/

v3 was tested and worked with the following setups
- ADAQ4003 on CoraZ7 with SPI offload support;
- AD7687 on CoraZ7 with SPI offload support;
- AD7687 on rpi (no SPI offload support).
The Linux image ran on cora was built from IIO testing branch.
The Linux image ran on rpi was built from rpi tree rpi-6.14.y branch with
some adaptations to cope with old iio_device_claim_direct_mode() and addition
of the following patches
iio: adc: ad4000: Stop using iio_device_claim_direct_scoped()
spi: add basic support for SPI offloading
spi: offload: add support for hardware triggers
dt-bindings: trigger-source: add generic PWM trigger source
spi: offload-trigger: add PWM trigger driver
spi: add offload TX/RX streaming APIs
iio: buffer-dmaengine: split requesting DMA channel from allocating buffer
iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_with_handle()

Marcelo Schmitt (4):
  iio: adc: ad4000: Add support for SPI offload
  Documentation: iio: ad4000: Add new supported parts
  Documentation: iio: ad4000: Add IIO Device characteristics section
  Documentation: iio: ad4000: Describe offload support

 Documentation/iio/ad4000.rst |  86 +++++++-
 drivers/iio/adc/Kconfig      |   7 +-
 drivers/iio/adc/ad4000.c     | 405 ++++++++++++++++++++++++++++++++---
 3 files changed, 463 insertions(+), 35 deletions(-)


base-commit: af94f401e26f686f7391ce79b38a6129417c22dc
prerequisite-patch-id: 3d517eef53a799adba5922815fe684b913e36773
-- 
2.47.2


