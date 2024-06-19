Return-Path: <linux-iio+bounces-6579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C490EB0B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 14:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655531F2288B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FC414900C;
	Wed, 19 Jun 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IHiDIbhY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C179950;
	Wed, 19 Jun 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799827; cv=none; b=UT4Ep3GtF9KfBLiLNTvi8AGx0uY9odZPwzZi5S8+u/EUNmv8pCJ65/4y0fB/lTXW0v8Epjvj0KTg6KI4lmeEymmzOmVhYSeHC+/0u/noB4vX93LmfCb/XJj2TU+1eFav7pO3j+k9DZQwfvlMklNKxgYpf+U8Gnc+0GIc6q8MM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799827; c=relaxed/simple;
	bh=Olzzvp24AOC4T+V7DJiEH5HUqYnKd+8BcbBEFc09ZE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e/NVHX9CmfZg5C1rQpmEnxExFaPKIK63HIlKVkUwlEhFWcx+4ZxEpjP+kPqAQWaug/1KHpXj1+s5xVNC3hoee1pt0AlnTptv23FHvxFun84IgvqstdEzdtEzP9J9Z2XTmwQMp9edg/poTXEOPu757+zvsYN3tzUexlQDG2YIzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IHiDIbhY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9Tife005209;
	Wed, 19 Jun 2024 08:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vNRa5Oiplrn2Xgjadf1n6RmThiC
	4FkAUT3lbnFrTe1s=; b=IHiDIbhYhXUbFh02BxTRFqdV2aMnr1reWY6XSdLjFTh
	uFXixAQHI37sJphLmIH6r7jmrIOj0YLYd6tLJgA/RyDgqxfSxAL1/i8ENxiCu6DA
	hOJyhYyK0TEoOj7nc0EEQNEWXRq6NyrainPEHYZ3vKta8okBRnEU0xe/jHEefLWP
	eDoUPSDI6JnoqP6EqP3TRClBSDbq91fWK/Ow1pkOaOHvKjsXegr2sKMH/6veNHEZ
	mzPtYpGUUgqJGtsgYMJ8bOe0NrWeWTOQmADQAj2Zv8zXkkDts6Zug/HHWcl6yWzE
	2pfoI0+o2J5GmxAixPeP6ibmrvgGPSr3kKzWJfq++2A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yuj8qjugv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 08:23:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45JCNOQS057286
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 08:23:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jun 2024 08:23:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jun 2024 08:23:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jun 2024 08:23:23 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.166])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45JCN6iD017140;
	Wed, 19 Jun 2024 08:23:09 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Nuno Sa
	<nuno.sa@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Maksim
 Kiselev <bigunclemax@gmail.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        "Mike Looijmans" <mike.looijmans@topic.nl>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Lee Jones <lee@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] ad777x driver addressing patch comments
Date: Wed, 19 Jun 2024 15:22:42 +0300
Message-ID: <20240619122301.22737-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LXzQioMqosGidwifod3GomlapAj5Cpah
X-Proofpoint-GUID: LXzQioMqosGidwifod3GomlapAj5Cpah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190092

This patch series is sent to address the comments received
with regards to the ad7779 driver patch:
v2-0001-drivers-iio-adc-add-support-for-ad777x-family.patch,
as well as the dt-bindings patch:
v3-0001-dt-bindings-iio-adc-add-a7779-doc.patch.
The patches were initially sent separated, this has now
been corrected with this patch series, along with soeme
other issues such as the cover letter and author.
The changes in the series:
v3:
	* drop spi-max-frequency from yaml and fix indent
	* separate ABI doc into different patch, drop ad4130
	 ABI doc file and combine the filter_mode/type properties
	 in the sysfs-bus-iio file
	* update Kconfig help section for the driver
	* update driver commit message
	* drop crc_enabled and check crc by default on all regs
	  except GEN_ERR_REG_1_EN
	* rename from "ad777x_*" to "ad7779_*"
	* switch from kfifo to triggered buffer and send w/timestamp
	* switched spidata_rx/tx buffer data type to u8 and declared
	  channels as IIO_BE
	* switched to fsleep and added comments for each of them
	* changed "____cacheline_aligned" to "__aligned(IIO_DMA_MINALIGN)"
	* fixed allignments and removed redundant variables
	* removed local update_scan_mode in favor of iio active_scan_mask
	* requested trigger as NO_AUTOEN and it is enabled/disabled only
	  in preenable/postdisable functions
	* removed separate ad777x_register function and moved the code
	  in probe
	* switched to get_clk_enabled
	* check for irq earlier in probe
	* misc code style / format changes, as suggested

Ramona Alexandra Nechita (3):
  dt-bindings: iio: adc: add a7779 doc
  Documentation: ABI: added filter mode doc in sysfs-bus-iio
  drivers: iio: adc: add support for ad777x family

 Documentation/ABI/testing/sysfs-bus-iio       |   7 +
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |  46 -
 .../bindings/iio/adc/adi,ad7779.yaml          |  84 ++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7779.c                      | 936 ++++++++++++++++++
 6 files changed, 1039 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
 create mode 100644 drivers/iio/adc/ad7779.c

-- 
2.43.0


