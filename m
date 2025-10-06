Return-Path: <linux-iio+bounces-24775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA7BBBE52F
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 16:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A062C188B697
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBF2D47F4;
	Mon,  6 Oct 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cFoqkWpW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991362D540D;
	Mon,  6 Oct 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760778; cv=none; b=s9i0Z1KGdACfzRemvAieUv3eckNo6PrqlTVhjf/bj9fQ6vHKhTNHU0HWOhcoVkESNkdY50zXxRPSRDVhHD3Yzv2ENN/9uVTb/KZsXNRYdExe52qo1Io0vpp6fPqn5bZdaMeZVCIOUkfHLoh5n6lpQOy9Od9FGe/HJ3Yst6vhVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760778; c=relaxed/simple;
	bh=ZCvm/CwZlMogzqGchY5yFh91tf8jZJ50qI/rneTlbeM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oS6DAJteosxr1y8cPy8j2dPn7ft6PF+/uW0tgp86vKAP1BhdfelSmGMsrzgQ0VklBFybzv6n6wvcCW97Vdc2gJf4Kg1iS3mTf5Xotkzgaqcn9x4/TH/kHlIER5WdHBJkAj12COzG00Ej7lozPbphB6z7uAk/ziOkaD/H3ppE/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cFoqkWpW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596C1akY027813;
	Mon, 6 Oct 2025 10:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gyHx3nP4BxmjQqLQ4p5/KlkpAFb
	1rpAnTZaLXvvVg7I=; b=cFoqkWpWxQNglj0jAoSqCgbDbkpWkDP/1zg2i212ofF
	0IVibjbdTko2Q/7eQPQE1aLb8mPjxGAEzgHA45Zbr0hvWlF3NP4tduyPccckR0kj
	4ypzXVB6GgwyXz9zX5d8juBagSCEij7mMDg99UM+SqacNmT9LC2Q6UpDYFsqTDx2
	8IK24zX1I2SMiPTZNsnmMsjqYEacbPJj9jPUsAPqhOuTr1aT4bwnOsNzV87+qt+f
	ZioMXuJ4DYYX1zybk1fPb61F04a12FDhfK2/R7c+Weg/YgyjIredWkRxb8gV/Nn+
	5eEu/+z4JYNZYID1miAXIQA+pPtU9NX4ZGInasTPoZg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49m0aabs79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 10:25:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 596EPtOB041696
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 Oct 2025 10:25:55 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 6 Oct 2025 10:25:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 6 Oct 2025 10:25:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 6 Oct 2025 10:25:55 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 596EPgoY001472;
	Mon, 6 Oct 2025 10:25:44 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Axel Haslam <ahaslam@baylibre.com>, <broonie@kernel.org>,
        <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 1/1] spi: offload: Add offset parameter
Date: Mon, 6 Oct 2025 11:25:41 -0300
Message-ID: <cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: F0U_zPAgI2dotNbXGNw9K7LZUXK_-YOC
X-Authority-Analysis: v=2.4 cv=EOkLElZC c=1 sm=1 tr=0 ts=68e3d175 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=rBt3ZXhBKYfrHXRu4PUA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA1MDE4NSBTYWx0ZWRfX9VA7xNWnTKv2
 QtLgfthC+lncfRdnCDiAe6AWKjTewKvnCCQS1vsUyLUg0jjdUU8xmXLgy7SgfMZDulivfoNutQ+
 qBFPQ4+IayjhbEKtgifvD1Iqn2MpIQZD4lp0WPN/q5usxAIiz9YuFiCSM3AweJI6PKTwyr6oUbG
 UQmxt27IXT2ZdLz7ETIAKeaszQ3CmipKBEltEWgst/05jGsl+PeJeUVrpRdG1UlDhiWhQ3CsC+B
 u4hf43RqCp0wpRe3KHmwX5mnLFsMtChCzjrFkVcVDm5r1YrziU2dvTkDubw971yRfwqm5aR4Yei
 0Tf52QKPAHaDd+JIaH4dSqnCAiTMe4HL4ru/0pK4YgxwRwdjH/HN0cK4Pn7N5789zOlzIDMjIK2
 S4DUr0zw0YIkQhy3g5Bez19C1dzCqw==
X-Proofpoint-ORIG-GUID: F0U_zPAgI2dotNbXGNw9K7LZUXK_-YOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510050185

From: Axel Haslam <ahaslam@baylibre.com>

Add an offset parameter that can be passed in the periodic trigger.
This is useful for example when ADC drivers implement a separate periodic
signal to trigger conversion and need offload to read the result with
some delay. While at it, add some documentation to offload periodic trigger
parameters.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Hello,

This patch adds a small feature that is required for a series improving ad4030
in the IIO subsystem [1]. Can we have an immutable branch with this patch so
that it can be used as base for the IIO driver changes?

[1]: https://lore.kernel.org/linux-iio/cover.1758916484.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo

Change log v3 -> v4
- Picked up David's review tag

Change log v2 -> v3
- Squashed SPI offload trigger commits.
- Added documentation to offload trigger periodic parameters.

Change log v1 -> v2
- Use upper case: adc -> ADC.
- Codestyle/readability improvements according to suggestions.

Link to v3: https://lore.kernel.org/linux-spi/d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-spi/cover.1758206554.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1756511030.git.marcelo.schmitt@analog.com/

 drivers/spi/spi-offload-trigger-pwm.c | 3 +++
 include/linux/spi/offload/types.h     | 9 +++++++++
 2 files changed, 12 insertions(+)

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
diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
index 6f7892347871..cd61f8adb7a5 100644
--- a/include/linux/spi/offload/types.h
+++ b/include/linux/spi/offload/types.h
@@ -57,8 +57,17 @@ enum spi_offload_trigger_type {
 	SPI_OFFLOAD_TRIGGER_PERIODIC,
 };
 
+/**
+ * spi_offload_trigger_periodic - configuration parameters for periodic triggers
+ * @frequency_hz: The rate that the trigger should fire in Hz.
+ * @offset_ns: A delay in nanoseconds between when this trigger fires
+ *	       compared to another trigger. This requires specialized hardware
+ *	       that supports such synchronization with a delay between two or
+ *	       more triggers. Set to 0 when not needed.
+ */
 struct spi_offload_trigger_periodic {
 	u64 frequency_hz;
+	u64 offset_ns;
 };
 
 struct spi_offload_trigger_config {

base-commit: 23bd49d3a1c042a3fb262299d86110af4cbd073d
-- 
2.39.2


