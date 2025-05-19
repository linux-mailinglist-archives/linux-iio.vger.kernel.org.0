Return-Path: <linux-iio+bounces-19676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57175ABC039
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F6417C446
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B358283C87;
	Mon, 19 May 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="awFjoyA5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A384281528;
	Mon, 19 May 2025 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663456; cv=none; b=CumzQYEwnA33mbLl0qCyeOk+5rApKxqpK48OE4UsHVIAdhNHyvv/f6tilVXrAJuYgpoRwJ2nCkTK8QusL5YidUey7CLD63G9iCRrqHWq0Y77nkJ5ihBY+0Ux3V/RyLmymzkSCSJbFwCxyqH8Go3zWk+TBI5tt17aYyozIbPHhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663456; c=relaxed/simple;
	bh=kqQMK/3KpDXgaWS/pYZ3VmfZtdfsfoeThCQJDd+NoKc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXqUuj/uhsHTq6IXhR8HKLWZVJLBtwDrJf6oWPaw0jpBXk+EZR4+o8b1OJYs9LgoEU+mHvWjxuojlLjQzH4pIlsj4g6C75m5LARphfIOgDvsxrshqNfV/h6gtImNynUH4H5X49xmLTIuwz/Eaqco+0mzjZQKHqKSwKDrTj+Ui2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=awFjoyA5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDVG2X012725;
	Mon, 19 May 2025 10:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ETSV9
	DafWyOmWjJfwE5PR4gy7f9cEXluhSRXX982A1s=; b=awFjoyA5cjedykv8IZuqF
	GcQOzklSlrljPnOqyylAe6K9huYo7DwE0jDll7ifkscW/qXICJ8OJLvjsCF6aJs3
	0H4JSdBv0zYT5AfkOeVxVgvpneviNEcms5pgdqgKmfw8LJBB2+e4jnHTM7T5wlCE
	abWJCC+IuoovuVRqtVH3Sivhsuw7Q1xahKX5ygeR+BWkldKFUi7IabVLw83aabIM
	fcDAAZlhb6lC1uEsg05p+NrvthoOxpNMd5vtfEaWP2l+nfq5TdeNqrD2SAKlo45q
	5bWThFagO5wfXBRhHyUNVs/fWPo57o/soJfr50eJcGm+o6SbFXgj7vSOrN8qHa6Q
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46psveqt88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:03:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54JE3jTX026788
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 May 2025 10:03:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 19 May
 2025 10:03:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 19 May 2025 10:03:44 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54JE2bPH016713;
	Mon, 19 May 2025 10:03:37 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
        Esteban Blanc <eblanc@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/6] dt-bindings: iio: adc: adi-axi-adc: add ad7405 example
Date: Mon, 19 May 2025 17:02:13 +0300
Message-ID: <20250519140220.81489-6-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 6gn-iqYCo9IATDTAw8-2Z69BAg5OQPLP
X-Proofpoint-ORIG-GUID: 6gn-iqYCo9IATDTAw8-2Z69BAg5OQPLP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMCBTYWx0ZWRfX0KeW8tnrmRXw
 Hqq/AHY/RWc6tWtuulg+/GF1Pa8X9jtTrRnQamEJEVCzW5Yj0juwtmuwStTFPx2ofj26IIvEN/a
 wvCOeDu6xgWW7dRB4+FKE95XLVy7DUSq4sNFwLqe+SEac0L5575bkxRe/05VDQBs617WA5sdaju
 D1mEZDddyuGSb/uaGQngZ0r+/6fFrFh9nOPyvWKD6YFJKcmvdcEycT/FNYLQTFoh02ThtwwSHbz
 ZTXQW06Lrm9AMCXuZ8exvKESIAYAFqsZEIjIxxy/ilIS8e5b1Ko4o/LP3G7Njl+wcMBect2KUzp
 MXQFNunkPhyf1hCsRH3Glytn2iGhMkNcPTZLDhmtw3Zqbg8oBq3eVOCtqAqOyAymk93sUkGhIND
 NXEJ3Z+bdwIhrMU1WPBxhq9fcbzHQnQl6Y+xX4WH5be0MK6t8oHQ+/zquiq/yNXTCEWEb06z
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=682b3a42 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=1v7LO-Y7ZEEvXFWEQcsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=790 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190130

The ad7405 device is defined as a child of the AXI ADC.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v4:
 - add ad7405 device that is defined as a child of the AXI ADC
 .../bindings/iio/adc/adi,axi-adc.yaml           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index cf74f84d6103..a6bc8acd101f 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -135,4 +135,21 @@ examples:
             io-backends = <&parallel_bus_controller>;
         };
     };
+  - |
+    axi_adc@44a00000 {
+        compatible = "adi,axi-adc-10.0.a";
+        reg = <0x44a00000 0x10000>;
+        dmas = <&rx_dma 0>;
+        dma-names = "rx";
+        clocks = <&axi_clk>;
+        #io-backend-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7405";
+            clocks = <&axi_clk_gen 0>;
+            vdd1-supply = <&vdd1>;
+            vdd2-supply = <&vdd2>;
+            io-backends = <&axi_adc>;
+        };
+    };
 ...
-- 
2.34.1


