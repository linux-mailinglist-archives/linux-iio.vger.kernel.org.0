Return-Path: <linux-iio+bounces-23411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB977B3C684
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BEAA02D3C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF91CCEE0;
	Sat, 30 Aug 2025 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XFGzr/U7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87226281;
	Sat, 30 Aug 2025 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514573; cv=none; b=o8cPmgOCdQK33+Qx4lSynAmjalAf3VevBhZPfXkQkv7STQgOh3c+PozuEQy97YJVdg1DGTyjwvxRAPszy+htKWSZ2Z8twpSNJAhJQC2b0/kw/+CTrqz/aSC/cYXhof6rYFjXSFEyiS0lUENsbE3vkEPFUCngBrlT9n1C5m/4MIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514573; c=relaxed/simple;
	bh=Q8t+nGIcP00OLNXSspLZ1BbibGHoOsdAG6lT58Vg984=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT8FOkcmYpfKY+D1pnc0rtI4/mgN4+p/IrEP/RYKZPUl3kCVkemU+Vgouh1TAKWhlFig6Uh3RpB17Ws+eQugwqbLQjsTphD/t9x42XkxexDm+eehlZwh32nM47A0K4RQS/W8d82xH3eYjBkwFQ/knybT25GAc5GkWjeH2thTN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XFGzr/U7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJRJtk013490;
	Fri, 29 Aug 2025 20:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=f39/N
	3JMJasjCuI5QMxROLcRGUHPKkzA+J+UHxFsNg8=; b=XFGzr/U72EzpwnlapIj60
	5FviX89vBYaHni/JMaNBQcOugTFwTlL7UVBDnsPkd8tkFUFPYyvLsqjGA+eS47NS
	sw+1h0G0DHTf5dZFbxBCpybLJ4DniclE2fOJRCsZCKNJyCwY3GjN+pnIRHVnoo7g
	pYpSk7wDarmPDvO3HKNc61+bK3BqpkRfscgJts/uAYLAy5849fJQ8Js5zngfnoxU
	QXEYXp1ivRO+dpaZIvJEH87Y3n9ged4zRTkFwCkhoewZicYddpb5BUOoYsERBRq/
	wDvuvApg8sBl3uNEE0YpVTXstvss+Bp/ktKpcUy/l1VOhFabpt5tK/KrdQvLtI0V
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966utht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:42:47 -0400 (EDT)
Received: from m0375855.ppops.net (m0375855.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0VsWo009836;
	Fri, 29 Aug 2025 20:42:47 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966uthp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:42:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0gjHX018838
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:42:45 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:42:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:42:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:42:45 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0gQt3004971;
	Fri, 29 Aug 2025 20:42:29 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: Axel Haslam <ahaslam@baylibre.com>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH 06/15] spi: spi-offload-trigger-pwm: Use duty offset
Date: Fri, 29 Aug 2025 21:42:26 -0300
Message-ID: <2410525339f56466fa566dda367678ec92f9fb98.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rLcVe-uoJOiCWPe44_N5YXQQstDflOr4
X-Proofpoint-ORIG-GUID: 8LNZ4PaMhaPBk4WYZPVILyIZgNYY8hrq
X-Authority-Analysis: v=2.4 cv=J6Wq7BnS c=1 sm=1 tr=0 ts=68b24907 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=eWAnnlCVS0XflCgljK0A:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA3NCBTYWx0ZWRfX2lMPJsmD08lO
 SCgbgetMjlBrD+zUzRJJ2pbP46+XseblSOOX10avZ/Fnwq/V5nMtxYnUMymNK0ZywdG+Sa0saVk
 t3YAxUWeRxLM584EiCbVYVO2fmerREm4bgShz0Q6aZN+HwnbfrsJvesH5noj7UMA6g6Cpid4L0s
 5rK/9yB+xeN47dwFGYSs6lfs3DwZlwskOOZhTy1mJHMWe3n1+4v4FHF8GAcSjyoCnbTwWettoU3
 cY4GX/d0PnwwXxSDtdTteCvjyuEpfDfSofUSys1ErGCA0Ut463BtK+4sxLRIsg9uqtym3tfgxfF
 Qkf/phGcyoKI86SKwM70yCdG4hGwm/f/vB6j1++0eY9pGsL6jbGEcfDkipphTGX89T8UmLt9DkK
 NiK68a38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508290074

From: Axel Haslam <ahaslam@baylibre.com>

Pass the duty offset to the waveform pwm.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/spi/spi-offload-trigger-pwm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
index 805ed41560df..8413aeb3689d 100644
--- a/drivers/spi/spi-offload-trigger-pwm.c
+++ b/drivers/spi/spi-offload-trigger-pwm.c
@@ -51,13 +51,13 @@ static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
 	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
 	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
 	wf.duty_length_ns = wf.period_length_ns / 2;
-
+	wf.duty_offset_ns = periodic->offset_ns;
 	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
 	if (ret < 0)
 		return ret;
 
 	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
-
+	periodic->offset_ns = wf.duty_offset_ns;
 	return 0;
 }
 
@@ -77,6 +77,7 @@ static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
 	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
 	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
 	wf.duty_length_ns = wf.period_length_ns / 2;
+	wf.duty_offset_ns = periodic->offset_ns;
 
 	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
 }
-- 
2.39.2


