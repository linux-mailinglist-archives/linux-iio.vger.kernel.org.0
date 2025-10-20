Return-Path: <linux-iio+bounces-25287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F6BF3243
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD823B26DD
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DD2FE587;
	Mon, 20 Oct 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Xl83JZ/C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EE2D7803;
	Mon, 20 Oct 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987668; cv=none; b=XHOOIj9XbHvtvs3QeBILD12UiaH4ZpxhlLdh1sIqERg6IM4AlbHVfRta60gprRkUMqnaTe67yf+vmge/qxtTwFQDwLKHdlSg28mhDqfjgqE2kMKEBNuA2C4V8W5Yv7Hq73In8d/32eGAwuTJ93uWin3VkE1G0RzMwGzutXyqV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987668; c=relaxed/simple;
	bh=mMvQO9gUvkU4ydX38HzUe1NFpnjpQb6EoaNFMHqTHoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCyz2rA2ZIeTgJxD9YmGPiWr7rUfW4GjEgu7gkH4bxJZlcGglcQzNxZ9707Odlev+XLN07Tn2bZrE+redzZEjORMJsdtxELZInScRKMLcOf71GDOucHislh6HeJ/AI0dTmMBtQ+fgYyJhW33ziSsLc72V6ZHbnyM7mIfSw7pSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Xl83JZ/C; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KILmr7006006;
	Mon, 20 Oct 2025 15:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1Xf3P
	4FaNtw7plQ3RNniLL6fpn0T247BbYMIn6GhM7Y=; b=Xl83JZ/Cy8vqbjlYOBkO+
	H8NqcAMiZPuilA8Fs3i43u8MovBRKbcITV7N/YP1fd3sAo/9fAYPH5UluNIh/YKK
	9PuKHWZsljmXrFAio7JMfphBKmhbho1ZOxeZ0B9N4Q5qTipTqufZLU8osfiiLBEz
	6Llke0yJc5y57V65WJIroreAAXq3j4io6N1kkHMRsajbd6imqSZ+bySpTMxfEQMb
	4ShWRzejQt5Uacsi1KVadZ5UsWuB3A0wqVAj/hFtqiG6juS9WO1LbLQUlZUufD0a
	UGf5YbaptUGkwH3LbzSAr89tVuR7VES53NxQW23l1pqUyl8TANPBvf5bH/IB1sXd
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49wt9v86v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:14:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59KJELOI026530
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Oct 2025 15:14:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:14:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:14:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Oct 2025 15:14:20 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59KJE4nP013275;
	Mon, 20 Oct 2025 15:14:07 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 3/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Mon, 20 Oct 2025 16:14:04 -0300
Message-ID: <9de79e4697014a6bd7c7cdf32b79cc41b7ad2a3e.1760984107.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760984107.git.marcelo.schmitt@analog.com>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=H5vWAuYi c=1 sm=1 tr=0 ts=68f68a0e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8
 a=gAnH3GRIAAAA:8 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1jjwBl_1Y5jdMY6plWto_EuDWbZlpNDT
X-Proofpoint-ORIG-GUID: 1jjwBl_1Y5jdMY6plWto_EuDWbZlpNDT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1MSBTYWx0ZWRfX6FLLXNbWnfhI
 4WaokGBw2wi18JBPbzGaEsBnVSP+ixPU8g5j6mQhizhvd9gugZ53Mt3gUh4AECtcAnMgEvLnn9o
 4D2ZRUHunifzdPk2fJI+nWxaCkLrhHPoQKy65SA1GjaWsaRfd830ActyXM8aZZhPS/FLAlQN1No
 SiJE0fkKh9nQz+NgpuB9r4clCijtBxK94CGN4oqRe+pIkdeJR2v6Owy4XCDiEutQDpYW3Xg4TXD
 WWhPiXE4m2M1csvZsXoYuDflrilMF0QViRMsWHT0xO68rcFpfI9qmOBls+xFI63eQLe3SUw1gX1
 Bclj080wme24x4c9M90NRdJb5fuouf3JNfwjBImtJUlndUTgOw5KgnCouvWai9BxyiTvef0Ej7c
 O1chySGTfy8pYfy/WxCJ42+l/GKcFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200151

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


