Return-Path: <linux-iio+bounces-1721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C083058B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 13:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEBEB23F07
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F91EA7E;
	Wed, 17 Jan 2024 12:38:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448731DFFE
	for <linux-iio@vger.kernel.org>; Wed, 17 Jan 2024 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495114; cv=none; b=RcAhXTJlNEcmEtgrr9pNRbEuyx0UfNmtg+A+uFQr9JDqlhtBSFWpkppcZGyVPyWdPgjuCQOfazOZ2RY7cB9OoWa0prWg+y+zMyvq/Ov5oKNiL/uNahJjIIEKdVMM18FVCCMRaZckqnFQqRKVne9u8MT+GQ2S6HAR4RA4QbJcUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495114; c=relaxed/simple;
	bh=oW6JfNj/F8Tp14RMHpkvv5ZLaycDjmhWq9PzyUhqzPw=;
	h=Received:Received:Received:Received:Received:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=iMZEPZlA21sEMGNv7IFZh4a+imy8uVhB7+4cJ3a5YuU0yGaD1KepQ9wIiOCURb+wv4z8W++CwPBMqUL7rYgn6+heFQrSpZ1p78DeIcQovI783SxMabU89rrjySIYOu7zBrbRfht+8t2AHe90Uryl8CTk73QnZeXoh+H2LmM5fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HA0g9h029801;
	Wed, 17 Jan 2024 07:38:13 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vnx38bvku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 07:38:11 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40HCcAOu029826
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 07:38:10 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 17 Jan 2024 07:38:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 17 Jan 2024 07:38:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jan 2024 07:38:09 -0500
Received: from [127.0.0.1] ([10.44.3.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40HCbu0x023809;
	Wed, 17 Jan 2024 07:38:03 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 13:41:03 +0100
Subject: [PATCH 1/2] iio: adc: ad_sigma_delta: ensure proper DMA alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240117-dev_sigma_delta_no_irq_flags-v1-1-db39261592cf@analog.com>
References: <20240117-dev_sigma_delta_no_irq_flags-v1-0-db39261592cf@analog.com>
In-Reply-To: <20240117-dev_sigma_delta_no_irq_flags-v1-0-db39261592cf@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Renato
 Lui Geh" <renatogeh@gmail.com>,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705495270; l=1366;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oW6JfNj/F8Tp14RMHpkvv5ZLaycDjmhWq9PzyUhqzPw=;
 b=RiUmXo0asj8VGYluxQOtwUsEchSeXtpxbXnQDwoUOowGjQl/qsmRYCSh33k+dpUVdcATz8ik+
 0Cbvk5ZNPGqBkz0sUfKkWpgjTdFLFbwZn1jsGrd6OzW2lsMvdEsiNrh
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: NQRFji1NDQhAbwIm2lfyWYqag7xqqAVM
X-Proofpoint-ORIG-GUID: NQRFji1NDQhAbwIm2lfyWYqag7xqqAVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=620
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170089

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for the sigma_delta ADCs.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/
Fixes: 0fb6ee8d0b5e ("iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/adc/ad_sigma_delta.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7852f6c9a714..719cf9cc6e1a 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -8,6 +8,8 @@
 #ifndef __AD_SIGMA_DELTA_H__
 #define __AD_SIGMA_DELTA_H__
 
+#include <linux/iio/iio.h>
+
 enum ad_sigma_delta_mode {
 	AD_SD_MODE_CONTINUOUS = 0,
 	AD_SD_MODE_SINGLE = 1,
@@ -99,7 +101,7 @@ struct ad_sigma_delta {
 	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
 	 * rounded to 16 bytes to take into account padding.
 	 */
-	uint8_t				tx_buf[4] ____cacheline_aligned;
+	uint8_t				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
 	uint8_t				rx_buf[16] __aligned(8);
 };
 

-- 
2.43.0


