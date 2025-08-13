Return-Path: <linux-iio+bounces-22641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA1B23E78
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B27B7AB47F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 02:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8626FD9A;
	Wed, 13 Aug 2025 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EE4ruZL2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646126FA5B;
	Wed, 13 Aug 2025 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053367; cv=none; b=p50ze6dt9AWUjrmlAeGz1ZPnWXICU4O/tflcV54j8UkFLUs8kJAPZEKJSewDpiG84KsembgiivyffKcfp9gvlcjRn3aCjQPmtA3eOxpTPIqKVuLVikpMK3c+uaoLvzt3zw/wv/vic9keLx0p1R5ApP2ePPWeCq2QSMo4g7sW6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053367; c=relaxed/simple;
	bh=UEiWNMuEuQAs/f5jkc/RFxn2JuqtmUGDE9EF9cEGvKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dvgi119/HszHG6avIsJQE/+CHWf0WRUx2m+EOH4EN58LVIiz0Uyg1USpcI8th0df/VaeT/iaIkHJFlOYYQH3ZPZDr539/WOOMtYMovA0eZPtDF+y5fnBEf0vRhk6zWuYTMX+LCJAr5nEbJ5bwksh8YY1dsaNRXZ6fQsxrhjxiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EE4ruZL2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D2TV4K027716;
	Tue, 12 Aug 2025 22:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=C2B6X
	a5L82/2B7OuGRWq3iFvspmXzu7gYstIpW5hiAg=; b=EE4ruZL2lPVwJqRg2Fxq2
	issCEzVjX6x8/HLRe2HxdnHK0Vke+3UfDqkeiP58FtZtyiv8CYcmRmwbP/AXra0V
	xfS7zTwRwQ+ittrR4j5W4L2vHXx83qo6NBACKx6MQLrCOUO959asYudd/pgw1sDx
	TmX2Vtpoj5vg3rcRZmRlLGXgOPznZhZYHElMrS0GtWyC1ioXFoW0Vr3CsWNTEdb1
	gDN/3BJBFaHyK9MMvQefXqqMX5LaJ936bjhda15RCL0d8Y9YliHROCX6yDU7whis
	tR6uu877QEvguf8TRthIRYQZ5uy3kAfE6JMHVB1cxte6Hh7YPcD1pq3QtUYFronL
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48g9q9t9sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 22:49:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57D2nK2U050856
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Aug 2025 22:49:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 22:49:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 22:49:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 22:49:20 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57D2n7WQ032761;
	Tue, 12 Aug 2025 22:49:09 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH 3/4] iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage
Date: Tue, 12 Aug 2025 23:49:07 -0300
Message-ID: <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=EOsG00ZC c=1 sm=1 tr=0 ts=689bfd31 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=A5znH7WzVNNAUNHUab8A:9
X-Proofpoint-GUID: CG5zqnSGEsysSXuNHmm7UWk0CJLTwZEV
X-Proofpoint-ORIG-GUID: CG5zqnSGEsysSXuNHmm7UWk0CJLTwZEV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX0zIaeMGQqVdl
 5sRIwAcpLuVqELZTWv+p3QU8zZFF34rjUXdcxdllGlr99nlPiaRyoXjT7eUHMFpcSPHr0j3XRN+
 Oz3JW19ZKib+/7+mFE5PnOEjRVcghhspyWyoFmn7B43z9ZxPF3Hu/08Ws7OIg31ju2bu0QiTaah
 MX6seHOCuFIUGyetumayvmS5lV6acazhWypU+ZCgxkKKtMn+sFqfLclLNS2wvdLScKDQ5sv1Q6o
 7ozIkf4AosybFZayOvdrOvkdFqQluuQeaxX0n9QMqy7DOqRjCZ7W1ccQFLMvei0+wqhow8W4Gmg
 Go1eQ+JHNX97F7R/k4Y97nYPC0Tur50sBudM5HyLfmehgIsVmC+wpRFVVzC5sXSmhbfOnWzCzMA
 FXnQTWrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Use devm_regulator_get_enable_read_voltage function as a standard and
concise way of reading the voltage from the regulator and keep the
regulator enabled. Replace the regulator descriptor with the direct
voltage value in the device struct.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 36ba208fc119..d0b9764a8f92 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -225,7 +225,7 @@ struct ad7768_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct regmap *regmap24;
-	struct regulator *vref;
+	int vref_uv;
 	struct regulator_dev *vcm_rdev;
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
@@ -809,7 +809,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = regulator_get_voltage(st->vref);
+		scale_uv = st->vref_uv;
 		if (scale_uv < 0)
 			return scale_uv;
 
@@ -1146,13 +1146,6 @@ static const struct iio_trigger_ops ad7768_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static void ad7768_regulator_disable(void *data)
-{
-	struct ad7768_state *st = data;
-
-	regulator_disable(st->vref);
-}
-
 static int ad7768_set_channel_label(struct iio_dev *indio_dev,
 						int num_channels)
 {
@@ -1396,19 +1389,11 @@ static int ad7768_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap24),
 				     "Failed to initialize regmap24");
 
-	st->vref = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(st->vref))
-		return PTR_ERR(st->vref);
-
-	ret = regulator_enable(st->vref);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified vref supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7768_regulator_disable, st);
-	if (ret)
-		return ret;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to get VREF voltage\n");
+	st->vref_uv = ret;
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
-- 
2.34.1


