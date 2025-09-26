Return-Path: <linux-iio+bounces-24463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C33BA4F06
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 21:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ED71C20139
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243602741AC;
	Fri, 26 Sep 2025 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jZekPJqn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F11FDA8E;
	Fri, 26 Sep 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913287; cv=none; b=rOp673Jgdfm+yXxNzlf1nHY9UETRA6WsUnPEBSaGeLUfMGrBwLxvfZNoZoqhRWzswOS02/zERLzUBgQYceZ6eqLYpkrExkeicN2RfdJJU2r89Kp8p7gn/6NretCb0nVd3+7C1ylXM6Zb9B12p01h1Jd0vE1cLthd8Zv8wE7K5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913287; c=relaxed/simple;
	bh=/Rffef6fgvSuJlrsB3WPERGgVP6qjWRdvFA6wDZOh9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESqnQ6gOvmFS/czPj1f4qbigoEUaudxO05JlVel0bX+MzhXinWP2q8Syj9Mi9P+xzRzgqmASXL6sTU/y1Y0IRinDgfLS3BS7I3lRJGFim6wGvUmBTs9tkv79fod3lisuGp6dIuyhbs7I6G0VV/SKfT15dIUKMkjD6OXNf7DoPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jZekPJqn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QFTVgT004483;
	Fri, 26 Sep 2025 15:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bkOw6
	4qSK653lebH9Hm8+Q1VZNtMWpNVYH64j4ulDnw=; b=jZekPJqneqgL7po4Lw18d
	MqXYO4Me49+WP+gEi1GIrD6CoxO5/2gUQMUQjxFc3LHiki7xUTYsisI528YtM3Hr
	1tkjeZENmdwfdPVY7ThfFvVwGe32fBSMCnniwSOLhszNZyRrWZ1C6DfDZXaOeMOp
	LX3HEjx0bbtiqB1YEkzDWcr2m9WrOf9JyMQVXhCWRomeIbWVZ4wgxnlf4FLo+UVc
	dvEhB6Gr6ADLbmAeQzQLSDxtMVUPqTsy/dESOXEjBvdY53NUBXjeGILLF6CPpjs0
	oqaQc1dBSdfz6kK4P7Hql4sxQww3n9MeavMZ4gQtj+cCkLz0F+8m+RF1T62LF3YI
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49db3qxtmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 15:01:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58QJ1GXe001109
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 15:01:16 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Sep 2025 15:01:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Sep 2025 15:01:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 15:01:16 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QJ16Hh006157;
	Fri, 26 Sep 2025 15:01:08 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Axel Haslam <ahaslam@baylibre.com>, <broonie@kernel.org>,
        <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 1/1] spi: offload: Add offset parameter
Date: Fri, 26 Sep 2025 16:01:05 -0300
Message-ID: <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758913065.git.marcelo.schmitt@analog.com>
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KcOZez837EIJ_OuY-F5M2uAWVzkXPyAh
X-Authority-Analysis: v=2.4 cv=HY0ZjyE8 c=1 sm=1 tr=0 ts=68d6e2fe cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=1VKOSqg6H_p0a8WXBWEA:9
 a=IawgGOuG5U0WyFbmm1f5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfXz4dHeKc4URZj
 +LMlnKh/bIYnifTumZh8h9HJgIRbLJABPVSamD1TbOPZSh0XNPxyCGT/SKjojGJcTGObHhB0d1i
 /f/SSVkQhF9zAj05Sva8FQ/bzH7gmIB5xaGDbP1Adjlv/7oyxhioBaHJR2b5/W2bWGOK2Bbdlmf
 oOMkc8k6SfZl1LdZggkUJqFNsMVHT4HcA4UJruFuSh5c9sPh8o+cMjVUfJjGAR6jLEj6CGFc87u
 2SadhRTF2qgJT7ETwnrMgWqVaVpngm4DAFH0s6h5PmTCWJJY54TAEpKXEYa3xXFixMRjE2aI9Ns
 GENgh9Tm50kUf1TxBvz1jGEiwlMB48YS5QAKImY2aD5scYxjIlfcxfUX9lx74DezXU/Okf+GFQ0
 3rVyfgkX6wjGFSfqTpTrG042/onFrA==
X-Proofpoint-GUID: KcOZez837EIJ_OuY-F5M2uAWVzkXPyAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

From: Axel Haslam <ahaslam@baylibre.com>

Add an offset parameter that can be passed in the periodic trigger.
This is useful for example when ADC drivers implement a separate periodic
signal to trigger conversion and need offload to read the result with
some delay. While at it, add some documentation to offload periodic trigger
parameters.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- Squashed SPI offload trigger commits.
- Added documentation to offload trigger periodic parameters.
- Picked up reviewed-by tags.

 drivers/spi/spi-offload-trigger-pwm.c |  3 +++
 include/linux/spi/offload/types.h     | 10 ++++++++++
 2 files changed, 13 insertions(+)

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
index 6f7892347871..b56d01ba0b2e 100644
--- a/include/linux/spi/offload/types.h
+++ b/include/linux/spi/offload/types.h
@@ -57,8 +57,18 @@ enum spi_offload_trigger_type {
 	SPI_OFFLOAD_TRIGGER_PERIODIC,
 };
 
+
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
-- 
2.39.2


