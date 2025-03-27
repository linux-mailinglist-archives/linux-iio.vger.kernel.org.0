Return-Path: <linux-iio+bounces-17297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1547A74036
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 22:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2869F174FF5
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8D61DAC97;
	Thu, 27 Mar 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VdoN7jf/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E48199FD0;
	Thu, 27 Mar 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110707; cv=none; b=S/dSaIolvUoee1pc3Tqc4gwo7VQZu3k1RCbVhDN+/5H4YHrLnnptKQQXA/6WVASAWa5EbnmbG7bysJZHPgs83Ig9gq2nQFLorpC5BU583EwtcOnAM8Y1nMcsrBrrwLieHLY5yQBFXCHjSJu8UDxco41EMPPu6Ctoe61R6grsiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110707; c=relaxed/simple;
	bh=VTxI0AIyVxlnmbS9rWrfz2ocmSpb/apVDsKoGwuHfiE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PfH+tMuLlG+V6g7uzIlGOdSMDLOc0UHa18W15mrk+yO0nPmJu1E3xI3DSi4TYLcfZ/DrKqk3dE29ZWajzGCnf+84iBM9YGmXIeHT3lobwIFBWkIXPCCFg7cV5EP48MlGQ6tZDIgoemSHeNChVmOWITXWe6/C4D8nVPL8Y/xlV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VdoN7jf/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RHXeh5023412;
	Thu, 27 Mar 2025 17:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=oDovE7mI8Vww64iMfagGyRyK5fZ
	AXAUaWJQg4qr3r64=; b=VdoN7jf/FLekDSHjHKy29+71bzhs8kD/yzb3b+ojSK6
	T6ibnZBR6tTqD5wxQ7OJg+OhEtXKTLTg3CcVKX5+MEgmqR1uBMgDh7PLbuQ4O58G
	XP2fPL2ZU26tXLrk0Geh3NYF3ru4X08PAMuVS5iEIAl4a8ejqP0PvQI1ysr2lgUu
	spS6qwtwl25z2iF114xEWijIAaQUbbTjh0+ttQhrHH+eZOqWJUHjrdCM/9o5jSy/
	XBmxiVpy5QnT2rA4Kx5TYvBVMsj1uLCtb7NrbEbO0NfFHqfnoyPV16+dpgn7C+/z
	/u+WoL6+d7NdZMyUiTsmXl9A0UamHTcOR+XO4OxBQYw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45krwhg275-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:24:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52RLOV2o047366
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Mar 2025 17:24:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 27 Mar
 2025 17:24:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Mar 2025 17:24:31 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52RLOIJ8022509;
	Thu, 27 Mar 2025 17:24:21 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 0/4] iio: adc: ad4000: Add SPI offload support
Date: Thu, 27 Mar 2025 18:24:14 -0300
Message-ID: <cover.1743110188.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: iO7EA_tYjWPA1I1Kkr7Rhj3RptZ3Q_Ky
X-Proofpoint-ORIG-GUID: iO7EA_tYjWPA1I1Kkr7Rhj3RptZ3Q_Ky
X-Authority-Analysis: v=2.4 cv=IuAecK/g c=1 sm=1 tr=0 ts=67e5c210 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=jY0B12Pf-14_IDfJoVoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270144

This patch series extends the ad4000 driver to support SPI offloading.
In addition to that, ad4000 IIO documentation is expanded to:
- list PulSAR parts supported by the ad4000 driver.
- describe some characteristics of AD4000 IIO device.
- describe changes when SPI offload is being used.

Change log v3 -> v4
[IIO driver]
- No longer changing spi_device CS timing parameters.
- SPI offload messages now set only one transfer.
- Degraded offload_xfers from array to single entry field.
- Adjusted ad4000_spi_offload_setup() comment.
- Dropped t_quiet1_ns since it's not used anymore.
- Fixed include order.
- Fixed typo: withouth -> without.
[Documentation]
- Picked up review tags.
- Made phrase about SPI offload engine more generic.
- Complemented SPI offload section with supported wiring configurations.

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

Link to v3: https://lore.kernel.org/linux-iio/cover.1742992305.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1742394806.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1741970538.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (4):
  iio: adc: ad4000: Add support for SPI offload
  Documentation: iio: ad4000: Add new supported parts
  Documentation: iio: ad4000: Add IIO Device characteristics section
  Documentation: iio: ad4000: Describe offload support

 Documentation/iio/ad4000.rst |  91 ++++++++-
 drivers/iio/adc/Kconfig      |   7 +-
 drivers/iio/adc/ad4000.c     | 382 +++++++++++++++++++++++++++++++----
 3 files changed, 444 insertions(+), 36 deletions(-)


base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
prerequisite-patch-id: 3d517eef53a799adba5922815fe684b913e36773
-- 
2.47.2


