Return-Path: <linux-iio+bounces-24259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDAB863B8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE021CC3B4E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0A314A6C;
	Thu, 18 Sep 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SSOlEbZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8A25A2DD;
	Thu, 18 Sep 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216914; cv=none; b=i6eJ5Eix37XXWoxTHgWJX1SDXNqaLWXux+tmt3Dl4qxQfC7sBf44j0z+mk2zfhR0vnbnmvgsmD6rCsXBksRwXrXyZD+bhS7YCAY7aFpTm6Uu18pX3ynGW/WupmfWqOM27PWhXrCxYb2HmjlEG9JVOvSBVaxGR+qweAFVPbD5lHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216914; c=relaxed/simple;
	bh=dPLbBP/JyeNfc/hSp0lXye/vKCnxdGR3IvcDDSzL/f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfxF9h8W2XvO5b8OwsjLa2r+RYuVGWakZC6K5LZwrX5YPtdJIhWjCTJsaDkNVKTTv2SxFeGf2/xPRFu+uE8sdEgwudCmPpksXmPOWx2qRhywNi3ewdWCSvMjP9SjOeZg1ks2InHKcasKMf0PSPXeHnCBWIuUCOgemisOXMKHV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SSOlEbZj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFuXQQ008831;
	Thu, 18 Sep 2025 13:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bSQhN
	o4mba5GxPAz5Q5C3vU/cfEUsUf5ZFytwKXZKAI=; b=SSOlEbZjgdM2VIpuVYLed
	SaHRO25YDO/llBNEa5anMK03fDGFXHJ8peuQuABrstzZLyuYiV3d/3BXWyYR2beC
	l2zKm+sVqjKeq08dA9/oHiR/8cCJmmwIPFFwQXOlLTTv8fejdV3jKj8G8mFdx1eu
	H59ma7ZruBJf+fHdFZAa8ACyhbIZuA8g9kHTGtq5VPuSpcwK9paeJoaWwNCgLNdR
	4oQa0LUBnQcQ23OaAs2ZQou19FbU2JPH5njyk91mDJCq9jaoNZzx1f+YzkMMCI7b
	nUvlvoLwbhi8NW+q0OQGlaYfE7vgPSVCSCopf7tTC0HqY3I4SVpRiwqi7E6a7g/g
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 497fxumdy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:35:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHZ7jQ013272
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:35:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:35:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:35:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:35:07 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHYsD2021986;
	Thu, 18 Sep 2025 13:34:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Axel Haslam <ahaslam@baylibre.com>, <broonie@kernel.org>,
        <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/2] spi: spi-offload-trigger-pwm: Use duty offset
Date: Thu, 18 Sep 2025 14:34:54 -0300
Message-ID: <181f64a4e9f0d6788f325a200b24b0166cb8c346.1758206554.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=cLfgskeN c=1 sm=1 tr=0 ts=68cc42cc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=Nz0FCHQsgo3j7Z9OLJ8A:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: YiAUmGGTatEKf-4cwZJUxQbFE0ejCRjT
X-Proofpoint-GUID: YiAUmGGTatEKf-4cwZJUxQbFE0ejCRjT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/uppbCiRYdVj
 d6XyZm/OYXCGMXug0MogfMnqzqwLyQNIf3BVn2WzhhyiS5QyL9u3mq+m1jBGCVQ4ooQSix4kbAB
 doW0CJzIFEVcv3+uuWPzjvTua+bRqAqnjquWhrBXwlybd1cKtQ9zHeOK1ChsmVofguBcn/bSk7F
 4M2ohsVDAkCEhr+tqgElHFCvv0KAW1udUGvaq/we+ovwm5ibYT30DllHLTUoSHYvU9H5gc/ur+U
 WQSCXi/Bhlo+QRd2krGSRa/o+n+HEE7jPa9YPEJ2zJ+/4agvDkDcgk8WdkcZ0tY+qIkUA0aOM2e
 ATMDgpYTdIA/XqqJaWtr6wzpd6By1wxZqBtEa0AMf/eQNL7BldsBkNs/r3ewpz2kSWbdqZwkJdV
 /8vqxKHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

From: Axel Haslam <ahaslam@baylibre.com>

Pass the duty offset to the waveform pwm.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-offload-trigger-pwm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
index 805ed41560df..3e8c19227edb 100644
--- a/drivers/spi/spi-offload-trigger-pwm.c
+++ b/drivers/spi/spi-offload-trigger-pwm.c
@@ -51,12 +51,14 @@ static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
 	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
 	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
 	wf.duty_length_ns = wf.period_length_ns / 2;
+	wf.duty_offset_ns = periodic->offset_ns;
 
 	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
 	if (ret < 0)
 		return ret;
 
 	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
+	periodic->offset_ns = wf.duty_offset_ns;
 
 	return 0;
 }
@@ -77,6 +79,7 @@ static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
 	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
 	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
 	wf.duty_length_ns = wf.period_length_ns / 2;
+	wf.duty_offset_ns = periodic->offset_ns;
 
 	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
 }
-- 
2.50.1


