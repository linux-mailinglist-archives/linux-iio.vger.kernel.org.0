Return-Path: <linux-iio+bounces-17300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C579A7403F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 22:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C649175807
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4541DC98C;
	Thu, 27 Mar 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DkBK7awn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013E1DB158;
	Thu, 27 Mar 2025 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110744; cv=none; b=jkLA3AqJL5vTm1g9m7Xlmed8kMAL4H4BAXOYTt97d7/jlhxza0Wr56TUY/f9Jg+UswTZKho7jvUqFo7yMbfqKJjORhGeiFWe7EgdGWJJQKCcXx4vxGelLm+c7JWVpUs00Goez2ZGOiLPqrhG9vY2QM2zAZgmP/0hsOI64EXGt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110744; c=relaxed/simple;
	bh=3iEzaUshFce4dYrxyOtWaCUpmLk97uKr2KNQCfPq8js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3/VM0H651WyJwfFSpLdyPOCcN+DDQf48WBdwQjykfiMr68hWnLXapAVZOLUeyk8TF1rrnDNLf1g7f6cjIekTB205k1QigEP5CXNyY2XMu+/iqcP/fDFZ/edqpQ9Bhoev9UqB3r6sxZGGIWa+bHkvVqEWPOGYwaSjs4dATZLums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DkBK7awn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RHX0wR019554;
	Thu, 27 Mar 2025 17:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SKLAG
	pWaVtiF1LZhA0bCy4sl+NIPRLLa2db5m4+Q1bw=; b=DkBK7awnEDL/ZQJXUDH3a
	l8LEQoFM9BRQiVKaZeeh8m8UEEgWhz0QprffZstTdc5P9fWhC+0JIazORkQUwcE8
	vOazxZ44o/VbpBMu89CAKuFtOyh0AXk+rZDbpE8gNRn30poD/pHolkk0kytq5keH
	nEHc2j4OcljTcdjmyWlcsNCEOkx/ulWBBLl3kGCSwZmwLBYynBKPlota2gZ1OKWw
	8G16pUy/n+1CAMwD20Clk++C/RBSVaQVHCMsMbtWakrGR7lc3PyHI8V7JOuSYWa0
	PgWfOGt1rrmCs3agcKMiyh/lgH9cZ6KN/DJ+eLFVF80lCy3ivg8kdackGeNjH2/I
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45nb62h11u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:25:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52RLPRNq047476
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Mar 2025 17:25:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Mar 2025 17:25:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Mar 2025 17:25:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Mar 2025 17:25:26 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52RLPEWb022571;
	Thu, 27 Mar 2025 17:25:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 3/4] Documentation: iio: ad4000: Add IIO Device characteristics section
Date: Thu, 27 Mar 2025 18:25:12 -0300
Message-ID: <6c8fe68d7d413ffdd33b154ba45600c7ce7013da.1743110188.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1743110188.git.marcelo.schmitt@analog.com>
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=KqxN2XWN c=1 sm=1 tr=0 ts=67e5c248 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=Mo4bjoQrprX0_McyEsMA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: QsDj1oyVmn8WgeKSzAAJdvoKDGZkpmrX
X-Proofpoint-GUID: QsDj1oyVmn8WgeKSzAAJdvoKDGZkpmrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270144

Complement ad4000 IIO driver documentation with considerations about
``_scale_available`` attribute and table of typical channel attributes.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4000.rst | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
index 5578a9cfd9d5..468d30dc9214 100644
--- a/Documentation/iio/ad4000.rst
+++ b/Documentation/iio/ad4000.rst
@@ -144,3 +144,50 @@ Set ``adi,sdi-pin`` to ``"cs"`` to select this mode.
                     ^                    |             |
                     +--------------------| SCLK        |
                                          +-------------+
+
+IIO Device characteristics
+==========================
+
+The AD4000 series driver supports differential and pseudo-differential ADCs.
+
+The span compression feature available in AD4000 series devices can be
+enabled/disabled by changing the ``_scale_available`` attribute of the voltage
+channel. Note that span compression configuration requires writing to AD4000
+configuration register, which is only possible when the ADC is wired in 3-wire
+turbo mode, and the SPI controller is ``SPI_MOSI_IDLE_HIGH`` capable. If those
+conditions are not met, no ``_scale_available`` attribute is provided.
+
+Besides that, differential and pseudo-differential voltage channels present
+slightly different sysfs interfaces.
+
+Pseudo-differential ADCs
+------------------------
+
+Typical voltage channel attributes of a pseudo-differential AD4000 series device:
+
++-------------------------------------------+------------------------------------------+
+| Voltage Channel Attributes                | Description                              |
++===========================================+==========================================+
+| ``in_voltage0_raw``                       | Raw ADC output code.                     |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0_offset``                    | Offset to convert raw value to mV.       |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0_scale``                     | Scale factor to convert raw value to mV. |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0_scale_available``           | Toggles input span compression           |
++-------------------------------------------+------------------------------------------+
+
+Differential ADCs
+-----------------
+
+Typical voltage channel attributes of a differential AD4000 series device:
+
++-------------------------------------------+------------------------------------------+
+| Voltage Channel Attributes                | Description                              |
++===========================================+==========================================+
+| ``in_voltage0-voltage1_raw``              | Raw ADC output code.                     |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0-voltage1_scale``            | Scale factor to convert raw value to mV. |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0-voltage1_scale_available``  | Toggles input span compression           |
++-------------------------------------------+------------------------------------------+
-- 
2.47.2


