Return-Path: <linux-iio+bounces-25288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0823BF3267
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 21:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD9D24FB418
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 19:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B192D838F;
	Mon, 20 Oct 2025 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VAmDST7X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0A2D7802;
	Mon, 20 Oct 2025 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987689; cv=none; b=mxvTheLPFFi7lQOSDgD2dDMEWB4W1uzi1cDLJSHbCTdBSpHQ8U98N47rXyePqo8LSkkODCXsWHhTBEg99Vtl7mfwn35chmYmr0//lxVIGM9qEudHROTuQPRoZ9xiPXVTbkDk5YivPAtaZwXhxs+ulCETXnTo8g+1R9uKZ+l0eA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987689; c=relaxed/simple;
	bh=YYfxM/IEXRyy3tSn9031a+tC/FZ0vP5y2Zd0ZKNwQ1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkXPePvQ1QtNIGMHOfx+MyFL5Y+FMdXyX3XwQHxQ+L80f2dO765eb/8/hxtHcYHIvxjiuHN/iTmseB72FHTP5d/E7/39m/4JkUSAP9r7JNjZutyPt5kmBDW+GkUUkj2otGmaogtrdvOQirZkP8ns1gkApz5yR6PgBhykFrF2+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VAmDST7X; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KIG4Q7019086;
	Mon, 20 Oct 2025 15:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o/Yvi
	ipDmQRdKm89jYIy99ODGZfAHFXY9KHrjrTRA+c=; b=VAmDST7Xm2zjLYqBzDhMW
	TmDcUTK7+PASZmKGW9Y5GwQegE8oK2l70aRmIgxxZZFKf/2Ec109WBTq3qKvIs7v
	kQCmf3Kpixx/i2GgwxCSEXnbuJPA+YbDjQl/2G4sLNehNPD1CnO12IvkCH613kOM
	uYR4QlcseSTworHXcrSa6BEtZEU+U1hmB2rYLX15pzVQ89WoPI+HpUlI1/8HKkqT
	2DRNDYtQl5Uu2+CKr/Xw11zc+vh+Pzl8Ww53NbPABaQni9qplv1kcq9/2KPqZM1t
	qmfIeJ1sQOW+/6phS8ctHp6bnSkVDijIAl7fnhvmX1YqZsSG1yn9cPV7O2ZwK+Pp
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v4r4kn60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:14:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59KJEfx2026571
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Oct 2025 15:14:41 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:14:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:14:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Oct 2025 15:14:41 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59KJEPab013280;
	Mon, 20 Oct 2025 15:14:28 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
Subject: [PATCH v6 4/8] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Mon, 20 Oct 2025 16:14:25 -0300
Message-ID: <173cf46155132709e8e2a560379231052141f036.1760984107.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760984107.git.marcelo.schmitt@analog.com>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -g3G9q2Nx-lefGoN3AE-axsFDLiGnMmI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzNSBTYWx0ZWRfX2nURvWbcfjiK
 3036aqlTx5UMcb65FumfTO8vnF95q5xwj+Ze1rX/L58L2X8aUbVK90trAkzgUvaiaIDnISVfyv3
 vs03Bwthh8xSYrLO5He7tNkbn+Y8r8ipZYPc96PHklcq/NvfOA+N7Tjgo7rgP8KWdYCi+fVRQMX
 Rfk6/JwyD8hnrGZJ7jYK7P+upki3WlveasdNn0HpAWAb6dMKtVLE0OvevVACbcqYHjk1IQ8vUeN
 EanaVDnCdyZ969F2s/bb30eJeaG8WQ5NxT7DmdxFH4QfIGg9BSFksEcR96v790TEejTeb1R7KwA
 dXbzwu+ZLEZ0S6CFBhJy7vdXF5LWFhzvdAmnuyCtX1AK0NtcADbyQr8QGO6waZCY0mEYDRW/E1C
 hGAafkrP2VQCVRWCSdw5P99L3tnxJA==
X-Authority-Analysis: v=2.4 cv=KKtXzVFo c=1 sm=1 tr=0 ts=68f68a22 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=HwBGVG7bte8kWS4IyKsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: -g3G9q2Nx-lefGoN3AE-axsFDLiGnMmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180035

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6
- Adjusted comment on list of average modes.
- Dropped link associated with Suggested-by tag.

 drivers/iio/adc/ad4030.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 4393160c7c77..e413003f1a17 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -232,10 +232,16 @@ struct ad4030_state {
 	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+/*
+ * AD4030 can average over 2^N samples, where N = 1, 2, 3, ..., 16.
+ * We use N = 0 to mean no sample averaging.
+ */
 static const int ad4030_average_modes[] = {
-	1, 2, 4, 8, 16, 32, 64, 128,
-	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
-	65536,
+	BIT(0),
+	BIT(1), BIT(2), BIT(3), BIT(4),
+	BIT(5), BIT(6), BIT(7), BIT(8),
+	BIT(9), BIT(10), BIT(11), BIT(12),
+	BIT(13), BIT(14), BIT(15), BIT(16),
 };
 
 static int ad4030_enter_config_mode(struct ad4030_state *st)
-- 
2.39.2


