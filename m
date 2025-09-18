Return-Path: <linux-iio+bounces-24258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A68B863B2
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB45565962
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F63C313521;
	Thu, 18 Sep 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="d7vQ5ots"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF0245020;
	Thu, 18 Sep 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216898; cv=none; b=ppJs1+BAC17/s5UJYtJ7JbFbLmB8+4pXuLrJI4NIs0oOXYWiTNYTeFQA1Xd+XPe2/7+sqpkkI8mlFUwTLCgwZ+y6IRcppv7AcEqhyjOi8eJAt4h6uhZxBa6zlYZjuBlb0hIqx+nNQupuufZyxrfA7wGQ42/Axwlu9s5v0AHsIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216898; c=relaxed/simple;
	bh=NYq3kjME1TcsGuCBJAqAzpPLgxse0Htmv7QtAlCRK0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYf9pAuI2ze1lMQQI7NsP9S9t8ull9IssrTGIxAE8bbJ3rZxVkznvGdRFYKu9e6J89psVOvm4eoLWilN4qH9t3wX4XTqhLy+tartMaBrJW0+EMS2voFgnyKYj2JvLdOkkO4TIOcWEJoMIA0LRBum119tHoU+74QoHMZdRo/PTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=d7vQ5ots; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFaHKg022772;
	Thu, 18 Sep 2025 13:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tTEUN
	2/4eRE2uh2w1LcXd945TNFppVfATZyb9fHdfr8=; b=d7vQ5otsW2FM6jF7Rpo61
	YGEVSttBGlwdSQVyNVDkFc3JaurOIq8j6w0GD76nKdSfrW+8dQCzHf6HRe+dIJ5M
	aVvsaeI1PCM2ffv58xblKGzO6vGVejTjG9GMsVLV5G/WeuZDDaW7zzuJqUYdf462
	BQ6Wu7Z4EZDt8WoGY6y1nhVKNPcKIhHXMFzmj8TkqUF0Q2lv5DzZ/rQIDtHugPNB
	+sJ+DUj/nOqkoa+a+yXx0KOWgPXSqS444Pv3fbk95qk0w7VZ1IZLTjv1rEWKCsGF
	Q1MrNWxnYP1tBx48qSTw7OL5g4oRWptpYVdw58kqr3qqjRALMIDxH5o7ds+HSGTa
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 497xre7ucs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:34:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHYpDk013236
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:34:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 13:34:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:34:51 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHYcoA021981;
	Thu, 18 Sep 2025 13:34:41 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Axel Haslam <ahaslam@baylibre.com>, <broonie@kernel.org>,
        <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/2] spi: offload: types: add offset parameter
Date: Thu, 18 Sep 2025 14:34:38 -0300
Message-ID: <cc049e25c9633f41eeaacc94bed5db2a1aa299d8.1758206554.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758206554.git.marcelo.schmitt@analog.com>
References: <cover.1758206554.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: EFwjblW6qN6qgx54Oqjr1qNK4cGmwO8j
X-Authority-Analysis: v=2.4 cv=WZUMa1hX c=1 sm=1 tr=0 ts=68cc42bc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=9ldudtiKjGZ9N8G2jv0A:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE0MCBTYWx0ZWRfX62HNrT9sujcd
 E6yC0882qkIbCuvRgHiz32dGTkL9MuudsmJQTmC0AT531o+v1AFNUTYciDGwOWBuWSwaCVXrp94
 j8tcy8OKiHFIQFkkx5VzkSr366D1OmtwkKezucZ5PkpFNPFHL5QH0YE3rysdJEKV/Z6ws/EgCu/
 uZcmJ2NRT+WgV29n9Z3EI1tSTEj3rbbapCmeZSu9FksVuT5hg7mGcFo/nUTaGunQB/MFJOWmiw/
 yIGU3CVjdqAR2UQQ0Zbo+gNCuejvxpCJlI4uk4ybFi7VrEcjrbieTNts03bv/8vBEG5olWa0h5a
 Zwn3G7AwNMSbPRALjseEaEHE5F0RjH84EWbuSg/3DJmnNhwgfyEIhasDso6r85yL7CfKVkIPMoo
 P29l2KUC
X-Proofpoint-GUID: EFwjblW6qN6qgx54Oqjr1qNK4cGmwO8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170140

From: Axel Haslam <ahaslam@baylibre.com>

Add an offset parameter that can be passed in the periodic trigger.
This is useful for example when ADC drivers implement a separate periodic
signal to trigger conversion and need offload to read the result with
some delay.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 include/linux/spi/offload/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
index 6f7892347871..0170fd1f42e5 100644
--- a/include/linux/spi/offload/types.h
+++ b/include/linux/spi/offload/types.h
@@ -59,6 +59,7 @@ enum spi_offload_trigger_type {
 
 struct spi_offload_trigger_periodic {
 	u64 frequency_hz;
+	u64 offset_ns;
 };
 
 struct spi_offload_trigger_config {
-- 
2.50.1


