Return-Path: <linux-iio+bounces-19562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A6DAB914D
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D77AA02FA5
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 21:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4B29B8CC;
	Thu, 15 May 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="q+InAbB+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506629B237;
	Thu, 15 May 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343598; cv=none; b=NDRN7riUPVrXGHhKv8zfLYj/IDjw1h4kIXbRQl9sPdTpOtaNxEG8LQcRgLL1C6npK85vMEdIrRkD3P2SgeKa3QJUVtJP9bQDJCtjRDu7rO0sTFWyfnLYAAzRduM2RFzPzw9XWNIPVFFBJdczDnEuocXP2fxShnfNErLLGlbAZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343598; c=relaxed/simple;
	bh=rrY4/ZuAxAKnqOHH1ZYX33oXVnLQ0B/KzUCAgon+Res=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqHKd5E0jzh4CbcKqzjO6ACq8YfGygWfTqeuZ2elQ5OZOSeGK29LkfBZd8bba8pCmdzGKxlERMEZNC4Cte7GQHHfz+bvbwfzTtaTFX2S4WSMADK5+Ec9znsC3Dl9fsiOd0FrV4VxqHqT085eQCOV7OJCyT43TGdSeuW0xban94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=q+InAbB+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FGltBh009246;
	Thu, 15 May 2025 17:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/Jfdn
	jTWmPNrevemoKygtrATmLTNG7adNXwP0Ei1Fxc=; b=q+InAbB+3l7CitN7x1W7E
	OxzPgk2FIj9Luv1Qf/NYpmU3KPVWsAuMx9JGEkXKe5OZSsaYA5R7vNKDESccVwim
	gZM5ZhnI+aYj07i1JI3X/FnxicR1knrphxRRTGGsyWZsFQY5r2+JB1hYRC4gV60o
	ubrrTcRLzLNvKhbTy77iinS6Sfir47f9AQp83XpdQer/TL3qSulQnZ06KYPGzQf5
	s/r5q21uOScJVwPXxyHhNAah1GGN8fvdjOUIemgM0w660YddUqCBT6OHbyPKCLSw
	bYUfN2OttNnzRXo0Cq57/6RH3tLdgkgHIdedqtYrQpDxQ3EckO0VrbzUj5pzqd6z
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ngknj9ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:13:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54FLDA0X025016
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 17:13:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 15 May
 2025 17:13:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 15 May 2025 17:13:10 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54FLCpUi018847;
	Thu, 15 May 2025 17:12:54 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v8 03/11] dt-bindings: iio: adc: ad7768-1: Document GPIO controller
Date: Thu, 15 May 2025 18:12:49 -0300
Message-ID: <6487b47ad80330819d21ba9b8b6f976ca3df0dee.1747175187.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747175187.git.Jonathan.Santos@analog.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDIwNyBTYWx0ZWRfXyQdYGjHWyVMd
 H2S4LjsHX424EJecBCHpm49H9JHKVeWh82PNFozWUSSGedvvLQR6R7V/55Fj5qlKpHiUnctjmNU
 JCmcKPzYkSAmwRU4qrCB8eJ79WfRDa0baOVyVPRMQPQdcaDRH+9S9EH9lmv1s762Q0UWUuA0dNp
 /AvsbNxNLYQvzaM/Qq5z6yLIfNQeg0jHj7XKbxa5Hk76K2hC4VgVCf1oamKi0in4XY2foj7jX6B
 ZyjCXelRgKwHDOzi4TnBYoWbVL3Zy2Sbwc/7CGYdieF71UqtXiJPyT8rx22u4q3m/gZ09fPHxeQ
 fxuoorJ7S8dzV4pNAvSTSen3VcySezBJg0Lps/byPJesR81JeZlCuByERHGaga+CXZKA3Hz0jV7
 WvEHY/Ee5pPuQJv/GV9t7t51HvJDQZK2B/8hVF2xRy+fd4Txvu2kIRS11pNPK8ywwGIdseCY
X-Authority-Analysis: v=2.4 cv=B5u50PtM c=1 sm=1 tr=0 ts=682658e7 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=FDCdkw0c5cjSjuxHnEwA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ME6HRJBH0wF_A4EU2ygWiIcSBXqcJ5Qn
X-Proofpoint-ORIG-GUID: ME6HRJBH0wF_A4EU2ygWiIcSBXqcJ5Qn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_09,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150207

The AD7768-1 ADC exports four bidirectional GPIOs accessible
via register map.

Document GPIO properties necessary to enable GPIO controller for this
device.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v8 Changes:
* none.

v7 Changes:
* none.

v6 Changes:
* none.

v5 Changes:
* none.

v4 Changes:
* none.

v3 Changes:
* none.

v2 Changes:
* New
---
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 9a6df931edc3..18f93586fcdf 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -85,6 +85,14 @@ properties:
       dt-bindings/iio/adc/adi,ad7768-1.h.
     const: 1
 
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      The first cell is for the GPIO number: 0 to 3.
+      The second cell takes standard GPIO flags.
+
 required:
   - compatible
   - reg
@@ -142,6 +150,8 @@ examples:
             spi-max-frequency = <2000000>;
             spi-cpol;
             spi-cpha;
+            gpio-controller;
+            #gpio-cells = <2>;
             vref-supply = <&adc_vref>;
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
-- 
2.34.1


