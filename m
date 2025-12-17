Return-Path: <linux-iio+bounces-27149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23475CC7AC7
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8799E30652F3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0CC357705;
	Wed, 17 Dec 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="akDg0jiT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5635770E;
	Wed, 17 Dec 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975426; cv=none; b=V8q//Wl5CIKUvWBb0CaXQxBUITpbszY+kuJ3dfyMagHg1UvxKRq52PTr2N8EjdkK8Zj+dxkai1vq7LBgHANFS0OYAaBB7cOEOSkq4HXAc3rA7BgLV7k+yShG6SfOboAyO+Q+S80WSmiTsNqamU2AW7a6sTrKUy8S/tTzM9V8kQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975426; c=relaxed/simple;
	bh=5kzDo9Te52KkJi1h1kNmqEyQ4lXFDGeLkGkhEs0ezxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPqrzwDYTfzzgBfAwVORPV677VENl97NcYBN+FE0DTfHwrzJh03CmqPF5g06C1azVm9KeyEuAljJkS8GLESN/z4q/T41bmpm8J5aNPKx9rHX/3r+DxEHfnrd25zeYQHsbsrtZV12FItvR+7+xPgSQeyL/xbouS2i7TR8Vd/rrG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=akDg0jiT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHAf3Jb3838948;
	Wed, 17 Dec 2025 07:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=N+vuT
	TNtBvRL7m45EzD5H79/RgpnQuILVpEkUHoW3+0=; b=akDg0jiTV1ivzxEzjRW16
	GYUrGzHDJ3ooPB/4Jjoas0WU9wnvpuM/5QaJTqFcyMW1og2ieHQtjx4UP6o94mZU
	19Zn9KtSVjtxu6FTx7kH/E0qyhFCKOXLyJHnIi2ho4ptXitQkZBZ/aRjOoU3MI8e
	eaciTLiDzYqGuErO66Tr5OV+CnwJwuiVbskunWRRip+EYfq6y8AD6TmWcY4YKMf+
	+2HgaOed1rY5Xh0mnW9Ej/n6kPxf4MqHqe8XjzNnqu0ksa7rPAnJxge/EblEkfQP
	PuHFhiDd9/9ONfvjMqLLRRn3tu0D0kmbKjfZnM+rMoiuVZ2BwrO4edIPy9jjeBUh
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jw9jj6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:43:26 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHChPfd043150
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:43:25 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:43:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:43:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:43:25 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHChCDa015901;
	Wed, 17 Dec 2025 07:43:14 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v5 4/5] iio: adc: ad7768-1: refactor ad7768_write_raw()
Date: Wed, 17 Dec 2025 02:52:56 -0300
Message-ID: <3c3122b60ace1c69b46fbd341c029ff7bd1cbd17.1765900411.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1765900411.git.Jonathan.Santos@analog.com>
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OCBTYWx0ZWRfX24OoJAycsSHH
 2xxWbf6OcahiE029AFQbvPe0eUHJxLQmi+AkKIoXb8zIuFD0FmuHzp8iDSYHIXLQyU9QudRAkL2
 E6tROMpmA+8wIngL+TYNyqPym3wOrjV1a5yrOfDF/Pqj0RJuuqATv5Hga+13h5dX9Seyl7bZWwO
 2qiU8Dy+iAgG0OwAAwfuCbxY4BGOHCYkVmJnlRb4NdBGOQAJ2HrLfnHItL1nYoC2FrsokoEfRiv
 743+xkHcXSLrXj90fOddnCPgfmN+AxKgzZMpynXts0obuPyvzDv1WQz0Vs15pTM/FAnzC/lBr00
 AxT142W+H89o+Qe6tZdXf+i4wtfm1NhBETQEjbjzJ/xQzxc++TYSNQc/2UwHF4xvogy9dYaosya
 jGZz1bQY5zB89Du6zWornK8fzftoIA==
X-Authority-Analysis: v=2.4 cv=TZGbdBQh c=1 sm=1 tr=0 ts=6942a56e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=ADg9w4Aar0HM7KgavYQA:9
X-Proofpoint-GUID: 36u2KXmyLFdKL8Vj3FK7Q-iQw87gfI2K
X-Proofpoint-ORIG-GUID: 36u2KXmyLFdKL8Vj3FK7Q-iQw87gfI2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170098

Squash __ad7768_write_raw() back to ad7768_write_raw() to allow the
addition of new attributes without requiring a direct mode claim.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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


