Return-Path: <linux-iio+bounces-17228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9214A6D6FF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661DB16CEDE
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A925DAFF;
	Mon, 24 Mar 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I7FmANxc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B325D8EE;
	Mon, 24 Mar 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807434; cv=none; b=pwDTYo1IHcsY5ZGWAZqTPIDimH7T+g37TnicsKXMq/HTKyc33v3+q0BJdFjKrYVVtopwZFIyceVyn0SuBwIJ72O+bwcaDDdPjHdIQLqXP024aB+IY9+6wclsmmw/sh22cMKnvxaZSjIKs2zWH1EQLG5lQMGwRyoH6pXOUJXX1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807434; c=relaxed/simple;
	bh=CjNTzR4/nvfwUgi7RgAsnsshhfhx+xVUbp2/z30Ng+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sd1zZNKTv1PG8uKduOwFcEn87iaDAiGijm63I63yRJrU/f4njbA4oMjujgMSjAIByMM9LU/U5QzX78QGLPmvhBj4PvQqq3Gcf1zrhowTmBTEQCbgahX6eCRx02w25RgUzk2yna0OFHEA68QE80aakcix72HM+2l5qvzack3xyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I7FmANxc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6nv2q017231;
	Mon, 24 Mar 2025 05:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9dDeX
	z8GVfSLGoHR6PTTJ3SLeZDPmKSATrYHoZC5vMk=; b=I7FmANxcd7gRzmZutS6ra
	uJvtsgopWFku50rfJUEPe0PP8Jwtamt044W6dBbkt0O6oKwMCFCN1k02Nt5BjJTH
	vMTFcTsgfzr0Wk4AijyzGLwSyXwpYHZ69+xNaSYVJVncP4N3DPtXprYXIjl/gwFI
	pl+WLDN0LHvTZprKEUEu08VemHArxLyS3c+vkCPSmC/iGe25znXZOYNsrWK4bbVW
	MBNREhisLHtcV72JYVxUsLXw8uvYWGxeFPU8i4pKG5HmOYjDfENYWuHI6mecBLF3
	nLbi2VdOny3aAxL2I8rjppCpjszqKHSqnmh71gojTdmTfNf+yHvXef1x8QenM4L2
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45k2fmgncj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 05:10:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52O9A7v3058902
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 05:10:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 24 Mar
 2025 05:10:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 05:10:07 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52O99Y6A001058;
	Mon, 24 Mar 2025 05:09:57 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        David Lechner <dlechner@baylibre.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Guillaume Stols <gstols@baylibre.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Subject: [PATCH 1/5] iio: backend: add support for decimation ratio set
Date: Mon, 24 Mar 2025 11:07:56 +0200
Message-ID: <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=As/u3P9P c=1 sm=1 tr=0 ts=67e12170 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=l9A8joCuJueiPxiydrAA:9
X-Proofpoint-ORIG-GUID: DK3IPOc7C6JPx7ExsH_P_o_lYx5fcUCn
X-Proofpoint-GUID: DK3IPOc7C6JPx7ExsH_P_o_lYx5fcUCn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Add backend support for setting the decimation ratio used.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 drivers/iio/industrialio-backend.c | 18 ++++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 363281272035..f4db6514944a 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -417,6 +417,24 @@ int iio_backend_test_pattern_set(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_test_pattern_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_set_dec_rate - set decimation ratio
+ * @back: Backend device
+ * @rate: Rate in decimal
+
+ * Return:
+ * 0 on success, negative error number on failure.
+ */
+
+int iio_backend_set_dec_rate(struct iio_backend *back, unsigned int rate)
+{
+	if (!rate)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, set_dec_rate, rate);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_set_dec_rate, "IIO_BACKEND");
+
 /**
  * iio_backend_chan_status - Get the channel status
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 10be00f3b120..e73d7d265a16 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -80,6 +80,7 @@ enum iio_backend_sample_trigger {
  * @data_source_set: Configure the data source for a specific channel.
  * @set_sample_rate: Configure the sampling rate for a specific channel.
  * @test_pattern_set: Configure a test pattern.
+ * @set_dec_rate: Set decimation ratio
  * @chan_status: Get the channel status.
  * @iodelay_set: Set digital I/O delay.
  * @data_sample_trigger: Control when to sample data.
@@ -111,6 +112,7 @@ struct iio_backend_ops {
 	int (*test_pattern_set)(struct iio_backend *back,
 				unsigned int chan,
 				enum iio_backend_test_pattern pattern);
+	int (*set_dec_rate)(struct iio_backend *back, unsigned int rate);
 	int (*chan_status)(struct iio_backend *back, unsigned int chan,
 			   bool *error);
 	int (*iodelay_set)(struct iio_backend *back, unsigned int chan,
@@ -167,6 +169,7 @@ int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
 int iio_backend_test_pattern_set(struct iio_backend *back,
 				 unsigned int chan,
 				 enum iio_backend_test_pattern pattern);
+int iio_backend_set_dec_rate(struct iio_backend *back, unsigned int rate);
 int iio_backend_chan_status(struct iio_backend *back, unsigned int chan,
 			    bool *error);
 int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lane,
-- 
2.34.1


