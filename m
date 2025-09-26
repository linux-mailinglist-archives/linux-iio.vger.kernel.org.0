Return-Path: <linux-iio+bounces-24467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA0BA5169
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8451C022FE
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A71285C98;
	Fri, 26 Sep 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MaV8hRjT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384227F003;
	Fri, 26 Sep 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919245; cv=none; b=kA4JnxzlLMEHY59C6/mTlpuNrRXBPBnsFku7rjC8GEPaktqSWi2OMDZsenaeW24+ayveOz+eqOYAjtKieJqsk5PBDgCByt3cdV9l5LrC3PROzTj5C8rCkUqeM3lwboNw3MVn/YWqx36RmVKcPDVCANmNgF1QcVkJfcRgN3BXTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919245; c=relaxed/simple;
	bh=mMvQO9gUvkU4ydX38HzUe1NFpnjpQb6EoaNFMHqTHoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jqmg7e92GaLvukWNA8Q6LoqeYCeM/9eshB+32QirEZg2ZAufZCgUDROvxFyKuMV7vHAoM5RTs0zECKYt2QAindfRSGicIVqgQYhY/1FldzKPzharKzTDoJojYe+QVG9F/zlQOFiRoAO2lo+cMuu+7w/IgcLy3xv8uuFPZ6LK97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MaV8hRjT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QJsVPo004633;
	Fri, 26 Sep 2025 16:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1Xf3P
	4FaNtw7plQ3RNniLL6fpn0T247BbYMIn6GhM7Y=; b=MaV8hRjT0o82IK0oUwJZc
	4gkvSsv9LEiIMhik3LhSCvFRtco2qshooM2iWaAff4bpdfkDe3QqWXCrr/XJRI01
	pLyTxO9UeSZTR66ToSzdzA50gS7dfE+EFTktc8dc40mv1LDl0f0Vevpll6QdK3I2
	cFw4L90vZ028jy+twF+EMuUZiFKkVFulIWjZb2rz8Dxkkx0LKzgdfylqeKiCgyFe
	IOuw8g09WyELyDZpoobyRBRC7ViiVH5qsIwjY1VLuCcJvP7gmPXDv9R+KjfsObMY
	9l5BwpbX1kp0CVRfmQVwnHuMEsNFet92XMVZ+GJ9I8gKHQFSqd4YrM1NsxgPkl7K
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49db3qy98g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:40:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58QKebna027145
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 16:40:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 16:40:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 16:40:37 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QKdIfB010311;
	Fri, 26 Sep 2025 16:39:21 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 3/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Fri, 26 Sep 2025 17:39:18 -0300
Message-ID: <6847f7957873c0a2959ff7ddc8df45f4024b036c.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 5uRV79wbAYhN5_gRMri4W350h5ajXEcQ
X-Authority-Analysis: v=2.4 cv=HY0ZjyE8 c=1 sm=1 tr=0 ts=68d6fa46 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=E8ToXWR_bxluHZ7gmE-Z:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfXwIlWuPmwU1lA
 8v4a3KUDAS2jaD2zq5334R1jitDoF4Liv1zA3sXUjLGyFnFbIbXLjqG7FoXxz6GTre6TMAv1jmk
 2cC3fnS26YB3pdqaS4W6Rs2SbqH2+kW49NsPIXsNqp0tIl5h1TjTVzN4D1Xrq7IS/fj2gsUoAKl
 M7yJKD6+iWZ4STDTCg6Y6y/Toerw0o9eE+t8pB+Kl7bISa6QIn0OHi8B+ItvcjhK4q11YD03bpM
 0BJdhydAjCwmZL6oy8cBaOcPPbN13tzkBFQIkx+7BIzrvQs+0uSQKtRgkzuQ7MxY075NZh2AtQv
 Sddl1nUei4YYuKMTYtWYWbeFIc5oBxysqJg5NzCC/9cJscsvhtlaDWJEOTQF5rLRp4ZqIfuIAiO
 NNaW+ycU3suPadc/6p07aKtypKu6rA==
X-Proofpoint-GUID: 5uRV79wbAYhN5_gRMri4W350h5ajXEcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index a8fee4062d0e..564b6f67a96e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -64,6 +64,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.39.2


