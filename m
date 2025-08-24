Return-Path: <linux-iio+bounces-23174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A3B32D7D
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 06:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D6148484D
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 04:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE51F0E24;
	Sun, 24 Aug 2025 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OyQKN/AT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3201EDA2A;
	Sun, 24 Aug 2025 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756008637; cv=none; b=TjEGqWITr/CCkoTZFakPDSr2u22m2urmfBOf9Ou1e925pJCuk/ldHfLpGtwCmDcEP2BCJuRPupM8pzoRccN6ENV4fhaxX7HVEnvfTq2m3kOKz0KhFazSnJbLTjraAmmtTrGb07NQCP0FXqQTiR0xlXJ/D/AusWW45iuU61Cw8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756008637; c=relaxed/simple;
	bh=Dv2jQDwRe+kXwHWH0IUqq2aUFhRhDJ1sbz4O8IPKe1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnhVHfHgY/P0ycZ+h9XXQ5uzMCQ/ka4wdn8pw292vPjbN6pBBDcg9GT4Cuf1r4knpvaVzf0AgK2E9hOdhgrGTTI7kaA2FMRNO8HIXDgxscntqE9BBE4qeBXFPHR2Yhyn/0i/mAexo797hC6zuZ17F6OQEXiXe2ckAR8PJw4iWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OyQKN/AT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57NNENDU011106;
	Sun, 24 Aug 2025 00:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=KQqwHIk1QhNF3GCxhGOwUVcNczo
	fmNcA0UsxdjdFv+g=; b=OyQKN/ATFR9yd9K7bj2SUJdopdOlGKF9lVg88PP9zeL
	LKEJC2seJtsA4nTZMOe+6so5GyvAHpXmsm89h0oeGaUyzG24SqW9dPiym/06cUJm
	PtULYBNGit31wwzkLcsDVnCN+Qu1Hg3ttC/zz9pWhqz5MixMksrvQWgmer+Bm0C5
	zBRSXrhnlLyGxNDvv+FHQMUjlgcZinleBfAaK3APKmnE7bp8TyawDhEZpB2CYJE2
	U0e9dzQO2By3z8Bexcytrz2WPYBsQPF/zWK5zoNXmoLfAk7vHBU8CVyYpNTJG5Ih
	fmmaSlFyxWVWtxAxDl5wvs6ym892r2ij1QKz+uDWvbA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48qaj2aw5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Aug 2025 00:10:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57O4AJ9H043583
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Aug 2025 00:10:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 24 Aug
 2025 00:10:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 24 Aug 2025 00:10:19 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57O4A3de006361;
	Sun, 24 Aug 2025 00:10:06 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>
Subject: [PATCH v2 3/4] iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage()
Date: Sun, 24 Aug 2025 01:10:03 -0300
Message-ID: <20250824041003.9727-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA4NSBTYWx0ZWRfX46gBAcENY4xp
 xDdNMSKijAbQzf9nVQKcC9uDERosTcB3ZHMkTHFxp/7DmJhxUNNMGrT7RsNkbDhwAbn3z6c+rCu
 +NAtmqHpkgi7740rBaKLNwTrnjy8rFRSD+ANx9hmwIF61blEpxzgJwrYJGoH+ukIKPFLRw5JjLF
 KCgV0Fv15z/+NRMfJjfd1QZrEHl1fcjLduRjO6A2JWQ7057UiVIEe15wXvhzawibci8zuYUfNwf
 JR/rxvUngOiVmhmjdPht57rOBgpzvJ66m07550A32bh6qnlcQKMqRaEikLmmn1mgA0qyfD0fIJM
 Np/j4+YjWwcYhQvvzgDsYApr6mpQ1NYIE/nshc65AKZBH2ytUPsUmv+Gy93KY/1D9hEQSlEuFlk
 ZOdMvwPK
X-Proofpoint-GUID: t7lPI1V3uNxohwqehAMI8dCQZofIeN_v
X-Proofpoint-ORIG-GUID: t7lPI1V3uNxohwqehAMI8dCQZofIeN_v
X-Authority-Analysis: v=2.4 cv=UITdHDfy c=1 sm=1 tr=0 ts=68aa90ac cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=58l-YDNnkdqXI4_C_94A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230085

Use devm_regulator_get_enable_read_voltage() function as a standard and
concise way of reading the voltage from the regulator and keep the
regulator enabled. Replace the regulator descriptor with the direct
voltage value in the device struct.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* Removed regulator value check (already done in probe).
* Fixed commit message and description as requested.
---
 drivers/iio/adc/ad7768-1.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 83b0907b068d..51562367a9d4 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -224,7 +224,7 @@ struct ad7768_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct regmap *regmap24;
-	struct regulator *vref;
+	int vref_uv;
 	struct regulator_dev *vcm_rdev;
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
@@ -787,7 +787,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret, temp;
+	int ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -808,11 +808,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = regulator_get_voltage(st->vref);
-		if (scale_uv < 0)
-			return scale_uv;
-
-		*val = (scale_uv * 2) / 1000;
+		*val = (st->vref_uv * 2) / 1000;
 		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -1145,13 +1141,6 @@ static const struct iio_trigger_ops ad7768_trigger_ops = {
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
@@ -1395,19 +1384,11 @@ static int ad7768_probe(struct spi_device *spi)
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


