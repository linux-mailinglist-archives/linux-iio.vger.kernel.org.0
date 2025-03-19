Return-Path: <linux-iio+bounces-17097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3AA692C4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585924807B6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A91C5D4D;
	Wed, 19 Mar 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="slAm8Mu8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B41B4F17;
	Wed, 19 Mar 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396249; cv=none; b=QBPil9KGmic4JpfLQ0QifqGqje8wgZmAcinPeXlLUDOdlzqHfiolbTfMbk+SofV35uHGqgX8zxPiOHlcmY1vzqFnOF/73EzkhG1zW1XyfWB5nOzCE20/PT7AJAjUk9+1Iiv7aFaqfQFq57tN0+H2MSsovsYyMuQLokB3FNrtZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396249; c=relaxed/simple;
	bh=NE0VBns65kP3ZnIBsYd+tGxI5D3/SKH5eG5sKVgZ8Vo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U42nkwCJO8kqlFU2Cy9lLJdlkuToGiKqUX0RnBFUEV9wF2kiTgwhqtUo61VNuqHeTIWGgHsCCywEqpFiPAp5QxfKPUX3WOiMGfckHrHooS6GObGnCt2rowlUuTTULkMqZbVzRA8p3BnezLq09NGZR88i2W4FXcNcFBCcVgr0M6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=slAm8Mu8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JC29tu031606;
	Wed, 19 Mar 2025 10:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=70QtxCAdO+bNcScZ41mEncqGVdT
	QuuGlVfXQAQatlAA=; b=slAm8Mu8gCIbgooBTkphAUUI0B1cqG7hrnnEP755lxI
	CZvg+lOHHOL3G04cfEs2/14fYTMifz/uThxjUqcRbQbRRk8roxbBRImNuqrdh+Nb
	kV97OeEoPfyKvLzbHCfVJBvghBtUg5BIP+pJL0VbRv47lUGL8eE0ezHqOCS5Ppg/
	Olx7200+KtWtaTot6Xbk3K1sTS+FJpd5QwMMzSMaGfYogOuxFEVILsP8hgPp4pD6
	FxwVQw8ELNCzrqrjUPiPsYt5zKN58FCSSVJO5biyXjSJfBcyG/YwLb6WzZjM5JDO
	RVD7UuF0pjrBHfMWhckbZrtSlth04C2PSPYOSfqOgxg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45fwjx0xk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:57:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52JEv9NT048059
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 10:57:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 19 Mar
 2025 10:57:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Mar 2025 10:57:09 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52JEutMt025112;
	Wed, 19 Mar 2025 10:56:58 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/5] iio: adc: ad4000: Add SPI offload support
Date: Wed, 19 Mar 2025 11:56:51 -0300
Message-ID: <cover.1742394806.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=V/Z90fni c=1 sm=1 tr=0 ts=67dadb47 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=Ntxb3bkde_v2aC8s7KEA:9
X-Proofpoint-ORIG-GUID: 5Y2aVmrElz9kK4pvgioaeee9bjjqo9SC
X-Proofpoint-GUID: 5Y2aVmrElz9kK4pvgioaeee9bjjqo9SC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=956
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190101

This patch series extends the ad4000 driver to support SPI offloading.
In addition to that, ad4000 IIO documentation is expanded to:
- list PulSAR parts supported by the ad4000 driver.
- describe some characteristics of AD4000 IIO device.
- describe changes when SPI offload is being used.

v2 changes were tested with ADAQ4003 on CoraZ7 setup running Linux built from
IIO testing branch.

Link to v1: https://lore.kernel.org/linux-iio/cover.1741970538.git.marcelo.schmitt@analog.com/

Change log v1 -> v2
- Fixed passing inappropriate pointer instead of ret to dev_err_probe().
- [new patch] Set transfer bits_per_word to have data in CPU endianness.
- Set iio_dev num_channels close to where channels is set.
- Complement offload message comment about first sample being invalid.
- Documented why the first buffer sample is invalid when offloading.
- Added blank line before a 'simple return'. 

Instead of changing bits_per_word according to buffer endianness, I set
bits_per_word for other SPI transfers and updated IIO channels to always use CPU
endianness (the new patch). With that, bits_per_word no longer needs be updated
according to buffer endianness or, in other words, buffer endianness is no
longer related to bits_per_word.


Marcelo Schmitt (5):
  iio: adc: ad400: Set transfer bits_per_word to have data in CPU
    endianness
  iio: adc: ad4000: Add support for SPI offload
  Documentation: iio: ad4000: Add new supported parts
  Documentation: iio: ad4000: Add IIO Device characteristics section
  Documentation: iio: ad4000: Describe offload support

 Documentation/iio/ad4000.rst |  86 +++++-
 drivers/iio/adc/Kconfig      |   7 +-
 drivers/iio/adc/ad4000.c     | 509 +++++++++++++++++++++++++++++------
 3 files changed, 512 insertions(+), 90 deletions(-)


base-commit: af94f401e26f686f7391ce79b38a6129417c22dc
prerequisite-patch-id: 3d517eef53a799adba5922815fe684b913e36773
-- 
2.47.2


