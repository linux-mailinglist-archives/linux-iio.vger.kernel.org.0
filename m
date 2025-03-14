Return-Path: <linux-iio+bounces-16845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA91FA6175F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9154C882247
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C02045A2;
	Fri, 14 Mar 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KRE+JmAo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378801F957;
	Fri, 14 Mar 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972792; cv=none; b=IJz70dK0HqcQ1q2AFETrU5UgTyzvtIEqRuA0x/SFcvfgYXehyj5WK89eDcL4UizPXZ+FcHs7h/mwSRsVYXk2/5nol7FjTUPovsWknCF5EIpcvP3LXvSAECuosZUF96ck04cAnXF0PBzrmZtbKMMsVC/lU/rltV64N75JJi32ix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972792; c=relaxed/simple;
	bh=pLQgLbhzSWeLm1NsYOf8P/JZobH+b4N+xZ2+J0+pBzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT7LWv9bl0KWYMFEY5xEap568f5ZtSrfsJLEJCFXeQ1kBzsyci2XsToW8iihF8aQJ/4bfnGW5XeWQ6/TeA1+Ca95YMNEA8V5qhjmXY0WUoTkO1HAfQIezkfs+7slOfnjmC6eBhmhm+92KW35iNGgeIQFft+K4XOn+6NK0w6oNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KRE+JmAo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EFvxn8016602;
	Fri, 14 Mar 2025 13:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rRFmb
	rbuid/omCXO+ai53evzFI6dNJbBmqCMoDl6dOU=; b=KRE+JmAoqi5o7ao3WIHfw
	YbjmIaVUunKti8IxCKibwef+CL0n52uO1WxxkZILnRPqrQnLPnynizYGzKGDeTB/
	r+X1LuLmcBZ2yDJ5VgvXBwHf5qVzSn3xxn4wk8bgiCl1TYyfm1AWGu/AlpYzJa/f
	m7dezkmSfT+3EStjsTLl7GDIr1UUjQuo9eu0DVcM4eOfv+p/TVcqI9qbap6rU464
	HBaAAEc+Ug+m6MG2W7XWY8Eux1ZaHOadAsgikuPX1th+wS3q6/47USQ3QMFGMCNh
	V5K0YSK/skHqdA6ycLnOhGrzD8ggmw6I/PYq5DnyyKzEZGOhukk7OCr0z/pSapJg
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45cqjg8aap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 13:19:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52EHJZIZ037006
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 13:19:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 14 Mar
 2025 13:19:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Mar 2025 13:19:35 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52EHJKjQ005021;
	Fri, 14 Mar 2025 13:19:23 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 3/4] Documentation: iio: ad4000: Add IIO Device characteristics section
Date: Fri, 14 Mar 2025 14:19:17 -0300
Message-ID: <5cc6522c55f7e1ac2713e769690748c66813a995.1741970538.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1741970538.git.marcelo.schmitt@analog.com>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZfhIIM1o-yk6zDazNfPV3IYkikftm0n3
X-Proofpoint-ORIG-GUID: ZfhIIM1o-yk6zDazNfPV3IYkikftm0n3
X-Authority-Analysis: v=2.4 cv=EL0G00ZC c=1 sm=1 tr=0 ts=67d46528 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=Mo4bjoQrprX0_McyEsMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140136

Complement ad4000 IIO driver documentation with considerations about
``_scale_available`` attribute and table of typical channel attributes.

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


