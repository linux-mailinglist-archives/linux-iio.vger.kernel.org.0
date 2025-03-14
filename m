Return-Path: <linux-iio+bounces-16842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8D6A6174F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C23BE550
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47097202F93;
	Fri, 14 Mar 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wSXERhUB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3F1F957;
	Fri, 14 Mar 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972701; cv=none; b=MooGpjA3vWaXmWWjNDmP1+JVuU9R7oRHo+8elmCrj8HDKJFF3SYKn5zmmJ6siNJPF76KxtLaKyhZbkf1xHJUwmREN9tPnPhwTZFXmKznuuzzBPg3W9vez5B0rALLBKcBjcR5hR4jU+7aq1Ak9vT39NQllyJX9bOpou2zlIRjWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972701; c=relaxed/simple;
	bh=+RX0bOfB5Qz+vXOyHXihEQwKeBSuvgq5jV37rXdBC3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pGywFh70bVZd2zohQypDViXVe/aUD5vYbkxB2YY9hs/XszfiCUCJnK95MdjWJty+MYQThKd9Xte2HH3Wpj/pjx8+8wvVXPtcW5er7DeICYKa/mDQ1hipAiq31uUybXQ7TZA44Xe0RNCptWEQ+91F3+4umR/Zl6SXaEZofpFBZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wSXERhUB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EF5B59008213;
	Fri, 14 Mar 2025 13:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=itgvC/ZWz2LcGv939LwDGD3Mr24
	JIPo7vS7Eob/K9/o=; b=wSXERhUBNUxJALFMyN2UZK7s/+QnUVcW4/+qZTehCDH
	YZ0b7sDEvqwF6EO/0l5yb7mLUvFnWADxbfGr7SND0zFhnJArPKmF9/FISysjCjhF
	oC3xpAJVlZ8y95yxFnRzQHs9M/1+Y+qZa1+C4y2ze2fRlqd2xhg2tEOYFE2P0qxX
	78XthnNUw5tH4xdjRVAoaJQy3ruXJMySlzOXtwmRwSf0ObgXgMFm6Mzmz7OM2hbb
	aY1Vl8Fdofd8KkwfFb7f9SVsvKBBfLPoyJLg4FvAdPHbSJGMh5oMk7iSJ0h0X2+f
	PTHDMFctY4MDlq2CYgu0j0OXr/5etjDJ5aEC/E2ITmQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45cpsq0gh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 13:17:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52EHHnsu018752
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 13:17:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 14 Mar
 2025 13:17:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Mar 2025 13:17:49 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52EHHUwA004983;
	Fri, 14 Mar 2025 13:17:33 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 0/4] iio: adc: ad4000: Add SPI offload support
Date: Fri, 14 Mar 2025 14:17:26 -0300
Message-ID: <cover.1741970538.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: qiFi1hf3DUiEoMes5Fh_ORWzUr5Y2TiN
X-Authority-Analysis: v=2.4 cv=HawUTjE8 c=1 sm=1 tr=0 ts=67d464be cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=LW6Ksy-oGqye9MjSVIYA:9
X-Proofpoint-ORIG-GUID: qiFi1hf3DUiEoMes5Fh_ORWzUr5Y2TiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140135

This patch series extends the ad4000 driver to support SPI offloading.
In addition to that, ad4000 IIO documentation is expanded to:
- list PulSAR parts supported by the ad4000 driver.
- describe some characteristics of AD4000 IIO device.
- describe changes when SPI offload is being used.

The proposed changes were tested with AD7687 and ADAQ4003 on CoraZ7 setup
running Linux built from IIO testing branch.

Marcelo Schmitt (4):
  iio: adc: ad4000: Add support for SPI offload
  Documentation: iio: ad4000: Add new supported parts
  Documentation: iio: ad4000: Add IIO Device characteristics section
  Documentation: iio: ad4000: Describe offload support

 Documentation/iio/ad4000.rst |  81 +++++-
 drivers/iio/adc/Kconfig      |   7 +-
 drivers/iio/adc/ad4000.c     | 519 +++++++++++++++++++++++++++++------
 3 files changed, 517 insertions(+), 90 deletions(-)


base-commit: af94f401e26f686f7391ce79b38a6129417c22dc
prerequisite-patch-id: 3d517eef53a799adba5922815fe684b913e36773
-- 
2.47.2


