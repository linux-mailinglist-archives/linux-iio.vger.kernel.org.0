Return-Path: <linux-iio+bounces-27779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22674D1EEAC
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9CC2302FBCF
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE63397ADB;
	Wed, 14 Jan 2026 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IYfbXMuq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226391E9906;
	Wed, 14 Jan 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394877; cv=none; b=Jxj+XLUYGxuW++zO2EacQMVLmoODriqqsJG1HjmX1TVZa6fTULATY7E8MrDznBzBj/deqkRPTabNEqAxsKqVp0rKzTNNwrx52+gPypesWrE5IDMvb9Vyq2SFJY660AYu2HMNmjOhG66mBsQAKWQoDXwn6S9mE2byvIhSZzRiZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394877; c=relaxed/simple;
	bh=PfvJLNmlPJU8Oi+kzJjBTvnoeegXBesJSFfOJ8XOxfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNz1KCVmPebLmLehVejK7SSEmRm4upakt+Kwjn2q/yk6L+6fanzo5yHA2w7VSyOUrP4Vg9qgIg50zYCuZ3VfUs76MoW54z8PjyiMBEh1Ujai0r0JWhGFZzFj7gFlDw6vOW8EP6KzD9MIMc2Tp2dsZFiONPJ+phmI9Skr0n5zOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IYfbXMuq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EC4rIY3765826;
	Wed, 14 Jan 2026 07:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6D0bS
	Zm+OlF4YbzRJvG/SKJGuECiZnyrhnTGLIA6ibo=; b=IYfbXMuqrMF6wj1EMZwJc
	Ba1vyWUSvnaKbpUoSokrwWxb65NrQoX1yKLJ56h38m7GuxPk0fsYjIc8XOTcloS9
	MPZbt+ZCiUG4Tz1aIIq1Rasp4k78IHV7TPak0mxHoJPbZIbYPoKk06uB8Dh0IozT
	j2riq8n9VUtoyIcbSLs7hptohcXv5q5wxFM1f+7E88h5CS1JrRwpQalaC4X3tpbM
	3Pw/RiDYB34HdVPWIMvwnBdQdiFMtCkzsloknPkgXLO9G7Q3IxYOpeZveYMth0RC
	pOttYRtZGTDUi8NzvuenNi6zkg/EBNXG8xjCnjFsNiLKDC8qWVfwmNq/Byi+MttE
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau08gtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:47:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60EClew8061496
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 07:47:40 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:47:40 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:47:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 07:47:40 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60EClOnl001744;
	Wed, 14 Jan 2026 07:47:26 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v6 4/5] iio: adc: ad7768-1: refactor ad7768_write_raw()
Date: Wed, 14 Jan 2026 06:27:14 -0300
Message-ID: <496dc9c83900c7edc104d3bf3419b7fdf66c4199.1768350772.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768350772.git.Jonathan.Santos@analog.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwNiBTYWx0ZWRfX67tDZAn2AxiM
 H994tlSCygB0cY+yWdHOs99sRXnCVWg2VDmNolNuT5zsDAIgn+ZIr0Xgke19qVPJNcxYmcZeeQt
 FfrPYeGYvWKs8d5LHRENrqbltFGyPvmFII2k8kWky/1xlJTOTutephQQpkDdN+6HfeCU46xVmb8
 /kwHy+kYfRgd4Ibqq1EDKxaenJmuc6NAawkOG1EneatdRyz5JO3daGql8ilKKGkOAhm5/1EViIa
 4SMbn2jwRtndBe6KKhA1503f9c/SeW2eanTi3Uy2Ld3yc0ZIZgtkFl25I/u9G4RHi1WTjY0ruFr
 A7FiVuRq446kRnRwm+Yfn8VOl1lL/6umf4LVGzap/1ZRS0XHGqqrD5bXX+Emm6uUf9ZHPjMOIwW
 oXBY4eILguI4rkItxPZXe3+CEh+GsMOwkCAb11sDElQbi4UgG/I6YOjXehl1G/igkT6Mu2FF8Bv
 Q5/EfUoh2qqFG5/d4DA==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=6967906d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=ADg9w4Aar0HM7KgavYQA:9
X-Proofpoint-ORIG-GUID: X7n-wY0TLAFRrfyUuKxFTydb9a_z9wnn
X-Proofpoint-GUID: X7n-wY0TLAFRrfyUuKxFTydb9a_z9wnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140106

Squash __ad7768_write_raw() back to ad7768_write_raw() to allow the
addition of new attributes without requiring a direct mode claim.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v6 Changes:
* None.

v5 Changes:
* new patch suggested by Jonathan Cameron to allow attributes without 
  the direct mode claim, necessary for fixing the deadlock issue reported
  in v4.
---
 drivers/iio/adc/ad7768-1.c | 50 ++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 89b0ca8f584c..bd4b2e090c5b 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -742,6 +742,19 @@ static int ad7768_get_filter_type_attr(struct iio_dev *dev,
 	return ad7768_filter_regval_to_type[FIELD_GET(mask, mode)];
 }
 
+static int ad7768_update_dec_rate(struct iio_dev *dev, unsigned int dec_rate)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+
+	ret = ad7768_configure_dig_fil(dev, st->filter_type, dec_rate);
+	if (ret)
+		return ret;
+
+	/* Update sampling frequency */
+	return ad7768_set_freq(st, st->samp_freq);
+}
+
 static const struct iio_enum ad7768_filter_type_iio_enum = {
 	.items = ad7768_filter_enum,
 	.num_items = ARRAY_SIZE(ad7768_filter_enum),
@@ -867,44 +880,33 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
-static int __ad7768_write_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int val, int val2, long info)
+static int ad7768_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return ad7768_set_freq(st, val);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
+		ret = ad7768_set_freq(st, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, val);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
-		/* Update sampling frequency */
-		return ad7768_set_freq(st, st->samp_freq);
+		ret = ad7768_update_dec_rate(indio_dev, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
 }
 
-static int ad7768_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long info)
-{
-	int ret;
-
-	if (!iio_device_claim_direct(indio_dev))
-		return -EBUSY;
-
-	ret = __ad7768_write_raw(indio_dev, chan, val, val2, info);
-	iio_device_release_direct(indio_dev);
-
-	return ret;
-}
-
 static int ad7768_read_label(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, char *label)
 {
-- 
2.34.1


