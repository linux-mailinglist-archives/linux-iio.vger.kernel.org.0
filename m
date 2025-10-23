Return-Path: <linux-iio+bounces-25371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E18C009DB
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0443AEDEB
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF230B512;
	Thu, 23 Oct 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ozonf+tN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150E30BF74;
	Thu, 23 Oct 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217330; cv=none; b=ul+kEZI8MX87nd116W4Fjlo/xIwM/0X1ftOAiFoCNAKvcg9l1kvUz4bLWMahSZn/Jog6VZfbGN2I71GsX/XhghZnD8yq4VUbwlB572rzS61mWMOCIUc8vsaQDVSP6jqy9bE4W8g7pNCkVZvWFzr+Behj61peKcaWlKQ04wL/jzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217330; c=relaxed/simple;
	bh=W23SPRSfDaZeWF/yu8OQ4d1WQba4ZpqP1h7crAoaGkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TnhxmSSTlKVuJbYnYwt3zyQGBoG4CZY1vzGoBdLGz8agRaOiGwf57I7eYZZ5jfFZMCeWUT18nCO5llBlTUuGRyTpdGD9YApx+xU2J1d7cN5GaAOs76cRRjyBFKD89gBCoeuxOmYdmAsUtlV/iVoasPj99iN3SkXuPgpx1H1Hik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ozonf+tN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9ajKI029358;
	Thu, 23 Oct 2025 07:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xreJg
	kS1inPMmZmxnf/lhmeSAp5jM1cHLdKeHZS9zro=; b=ozonf+tNHTTKV0tBCkMsg
	C58SWoO+Kjt9x9ZiS2DBVTbA7VOn6j+Pl5PJ6sDJCm8gDh9/nvsUohGjnaEG321a
	QYlbqwnHJD+pysNF53y5lsl2ipADKozsw/sAhcal3gEUFM0lj4uPPNixYtEjtMtd
	Qsii5nuRR1TG7/6g/j/bY6Ize5Tks2bEJ3HIpZCY95p3hxAAwX9X4Tjg3kD8Lguy
	m+rkS1/KDn8t8TfuUMzcji7dhpqThiPxI/rmUu6SF45QAOI2vUQVL/cqtKY5duAo
	b9sQXDbjvWYf8j9zWgxbKMQ7sAfBKSeGWC/yHM6MfSzdoR1PbEhJuAM9krQBIDIh
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v4r55pwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 07:02:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59NB23Xd015117
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 07:02:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 23 Oct
 2025 07:02:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Oct 2025 07:02:03 -0400
Received: from NSA-L02.ad.analog.com (NSA-L02.ad.analog.com [10.48.65.124])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59NB1eqw027813;
	Thu, 23 Oct 2025 07:01:50 -0400
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Thu, 23 Oct 2025 14:01:39 +0300
Subject: [PATCH v2 3/3] iio: dac: ad5446: Add AD5542 to the spi id table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251023-ad5446-bindings-v2-3-27fab9891e86@analog.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
In-Reply-To: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Michael
 Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>
X-Mailer: b4 0.15-dev-52d38
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: CvmsV9kE3ECmLFJUESGnBvWEnW0BbsC1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzNSBTYWx0ZWRfX+MSMERv4fI4b
 PJ//PozLD6YDglH20LDaiy3k42r6N9DrJr86Gti5ZXu3cQn8wLHGX9tYGCoyaWeDkVfIQKYD/WQ
 h36IJTm8Nhcx06vX/v1nzsVKdFaS+TKvrZxPRhGoQiIorX3WcolQkv6LW17Tda12LfRT4G0117y
 QsJpeEZoG6l+lZf8X3OUwcsUhdSoBSOirUhOZ/Xs1Q//k7u4QfH8mHLMSwP/Hxm5QnUpJhUJqPH
 Wcua8f13jUh03JqcFn3RAqHZTgmVtPNbCT3wlDMs9/ZpnJMZs5Hfs7HEm7CX0AJ+0RFdf4FVNBm
 h/gnBdS+MbBdUN7XkGsX6ygQE+diOchzf8wzvXoJwx0Fi9vzh4reDnAi6U5vaw9968BjEsv3WOs
 EO+nmS3YqBdu1XiVyatgRgZK+iPePA==
X-Authority-Analysis: v=2.4 cv=KKtXzVFo c=1 sm=1 tr=0 ts=68fa0b2c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=c6Rqu9kgPA2RkrxMWccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: CvmsV9kE3ECmLFJUESGnBvWEnW0BbsC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180035

From: Michael Hennerich <michael.hennerich@analog.com>

This adds support for the AD5542 single channel Current Source and
Voltage Output DACs.

It is similar to the AD5542A model so just use the same id.

While at it, add the driver to the proper MAINTAINERS entry.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Co-developed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 MAINTAINERS              | 1 +
 drivers/iio/dac/ad5446.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dae04c308975..1288df469151 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,6 +447,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
+F:	drivers/iio/dac/ad5446.c
 
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index b6967f3b9386..e71f10806496 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -421,6 +421,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"ad5453", ID_AD5446}, /* ad5453 is compatible to the ad5446 */
 	{"ad5512a", ID_AD5512A},
 	{"ad5541a", ID_AD5541A},
+	{"ad5542", ID_AD5541A}, /* ad5541a and ad5542 are compatible */
 	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
 	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", ID_AD5553},
@@ -456,6 +457,7 @@ static const struct of_device_id ad5446_of_ids[] = {
 	{ .compatible = "adi,ad5453" },
 	{ .compatible = "adi,ad5512a" },
 	{ .compatible = "adi,ad5541a" },
+	{ .compatible = "adi,ad5542" },
 	{ .compatible = "adi,ad5542a" },
 	{ .compatible = "adi,ad5543" },
 	{ .compatible = "adi,ad5553" },

-- 
2.34.1


