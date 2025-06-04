Return-Path: <linux-iio+bounces-20215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89934ACE4DD
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C02F188FE07
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098E20E000;
	Wed,  4 Jun 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Vv4uIt0X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004220CCE3;
	Wed,  4 Jun 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065751; cv=none; b=dck3xohe4OoTq34gsP0QLevHguD83hlurgv1UjHkS1cIGFifeu3fq33aC4QchPOuXbntUsCryEbFRolnnZWiEtu7GpGYRluLUWDc2sbP6HI1nh0SqiA63bAn+5VsEKLfnunmhTFR0d2+FPoC/n5oXo0bmpDl3uZNNIGCrKWRjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065751; c=relaxed/simple;
	bh=efDFrDLQz/d2Yw77VdfC8b6/5TFj5T5inDk7rIll8jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCtmn+ylyFz+4Yq0R3g/s1PhMKoANDLHWY6ZTAjET8x9xhZuP+zYVnNtpwC26zL8bPC9FCiFCIRFDhdx0970MvxF2UxTunIaGEd+QsNIlVchMBEXxNgFMR4DwHXpALqZqoY7+aV68/0edsrQwovC2nK7kjvz1Nuidt6Z7to8odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Vv4uIt0X; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Fm0dV030199;
	Wed, 4 Jun 2025 15:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ls8tu
	X4nyzu/DDgCutcb6eUVMzFtwW6yazobUynUfGg=; b=Vv4uIt0XjR3g1wbMRGIaV
	ImLz3do2hlZ/tafHt5QJoEaVOI3ViX/XTlp9vhSs7WVj/ir6PEQRfZOt2abZ+5wn
	RHX8ZpBC7SpObbzXmPUBR/pgF0AQUEka6zdGDzgDokIbW5QKyajCeEnVsqKspbnM
	IKtbhQRQoOpHxiB8n3pOLuPN1KclJlMgdynohekQDaoK8BiwTi585LGlsCormR1O
	Ga/jjROYPTVuG9Af3GrwByzEUOyD5ppVh7tTg17YnukSQ2qxRd9DTp0qjRKgGbdH
	k8xo0rnC9UELSBw/44jMR7ZlZLt9vsBadcqgLPnPCp9MQkQ2PP03N8o89yTha2SF
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vhvt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:35:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 554JZcR3043835
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:35:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 15:35:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:35:38 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JZLMI014301;
	Wed, 4 Jun 2025 15:35:24 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v10 01/12] iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement
Date: Wed, 4 Jun 2025 16:35:21 -0300
Message-ID: <d3ee92a533cd1207cf5c5cc4d7bdbb5c6c267f68.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfX02aSiB/grcK/
 jXQKojBz6iaxqZFwbRVmfmltsn5ga62Ev8EZKZVYZG7GJMZDTd6AXqwIb9ptqWYPukzMMjQsbI6
 MJ5yIaeVql/SllvVHcUmo4u7L6yOSD3r9aUI7Ta7QvQnwga+2RN3rYVYj6m44/QPm+9zyvnl8vi
 nIRI2khkNvHOsy3kJ/TP+VlMYJQcH2WaUHc7ei833ANTBlLzyz91fEJWQ/CGp/k/gYdYT7dpgBa
 vkHEjKHg7cIXFgwntWZTcnwFJ6TtjgnqYvS5/V5P/96+kIcgxjbmDjq/GnmsdHQSJG6ooupDpkb
 g+vvAU15NndviC8aaUwO9bKDaZv05z4zUqyG7YlU9NCSG5clA8uaZ8fhnH0hQ/3BuEK7vKruwRB
 cF4E5Qy3UrS4BWRoeYhB7A63iNdnT32cjsoA9QBD3eTT1iyCf/FWsCgXVkebrPtujxPEs5ci
X-Proofpoint-GUID: -0gOjBYSoDnGXILWY2UVDpY-jZI98bOH
X-Proofpoint-ORIG-GUID: -0gOjBYSoDnGXILWY2UVDpY-jZI98bOH
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=6840a00c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=vwO0T6k6XbGL632noZEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040155

The SYNC_IN pulse width must be at least 1.5 x Tmclk, corresponding to
~2.5 µs at the lowest supported MCLK frequency. Add a 3 µs delay to
ensure reliable synchronization timing even for the worst-case scenario.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v10 Changes:
* New patch.
---
 drivers/iio/adc/ad7768-1.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 51134023534a..8b414a102864 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -252,6 +252,24 @@ static const struct regmap_config ad7768_regmap24_config = {
 	.max_register = AD7768_REG24_COEFF_DATA,
 };
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	/*
+	 * The datasheet specifies a minimum SYNC_IN pulse width of 1.5 × Tmclk,
+	 * where Tmclk is the MCLK period. The supported MCLK frequencies range
+	 * from 0.6 MHz to 17 MHz, which corresponds to a minimum SYNC_IN pulse
+	 * width of approximately 2.5 µs in the worst-case scenario (0.6 MHz).
+	 *
+	 * Add a delay to ensure the pulse width is always sufficient to
+	 * trigger synchronization.
+	 */
+	gpiod_set_value_cansleep(st->gpio_sync_in, 1);
+	fsleep(3);
+	gpiod_set_value_cansleep(st->gpio_sync_in, 0);
+
+	return 0;
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -339,10 +357,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_set_freq(struct ad7768_state *st,
-- 
2.34.1


