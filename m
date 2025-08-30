Return-Path: <linux-iio+bounces-23415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91644B3C69B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E87A02F72
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAC21D54FE;
	Sat, 30 Aug 2025 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1goyN8Y6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856B26281;
	Sat, 30 Aug 2025 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514662; cv=none; b=IS41cYNwPA45j3wYV6W4BWLs+V4lD/eL5cTjWXw4rYh4y+GnprMumPXm1mZil9V/2hePcQm0f6BIgns4uX0xZ/79JJcktyMpvYEXTgyXNjsN3xXSe3cvSLuMwZvNQHls9vWuDma31K0W9nyXayU579KPWrm4fxkJKzMlkBbXnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514662; c=relaxed/simple;
	bh=P1ORQ8JeKo3jpYma9eqqn7fH4n+0e6kjM6qSYOkNj7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOtqgU62KfYY4EV8z1na6xDP5N/tUlZjzGSc/i1uddIiyFPghS/FHKRWpgp8U47mokEoiYxLn721dgaWXXRlJ3EKp/GGi7MUJH9rMK6Fqf+1hoLHsiVPnJtvmYuSQQkhSBllgrzxJJ0Af0wLp8qsBaiz3Yznfi6V9luuyAOeCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1goyN8Y6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0DHQn021582;
	Fri, 29 Aug 2025 20:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QSNGc
	R0+nAqXvUhmFR0YT5+pqELaZV7l3w+ISmZCkR8=; b=1goyN8Y6OEH/mNC0zlGzg
	CCHr7EaPWPqfncyLVPDeJR2822kxzfoaQjCPFegW9k/YxeXNee5C8VFBBMg8/Qe5
	Jbc66eM3WmmTAcSR8yb6B5qtOxCrqqr8Zc2x0ebktiZokhy3J5wOUK20NKHhypL8
	yeVxLctCIxFx9Iy/MGp1x4aFH0wWHVbpKbN5qJMKfaB3Xi4LXvbf9yXTZv72m4vP
	fkgDCU/CmRk+7Ba/+gtzWCYQI1RRapZXdzz2Z3qOBdyMayz/qkI57wJdlExAzHDO
	7mw0tXNX+OQaxgQCmP2ou1S/EYNGaHOH3Jd7A9vQ1r36BJApI2jTNsFZBUWUcq8l
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagch1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:44:16 -0400 (EDT)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0hYps005067;
	Fri, 29 Aug 2025 20:44:16 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagch1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:44:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57U0iE9F041109
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:44:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:44:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:44:14 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0huxE004996;
	Fri, 29 Aug 2025 20:43:58 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <sergiu.cuciurean@analog.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH 10/15] dt-bindings: iio: adc: adi,ad4030: Add adi,clock-mode
Date: Fri, 29 Aug 2025 21:43:55 -0300
Message-ID: <1acb071f7140c9d44ed616a9eaea00b0ee423164.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfXwhfImnu1EObD
 TJX3VdUJIGGA/h46CJXCl84VxG7wwUXW44pWYAaKso4h7Cv9x8gvsdqvtG7bTpQoNm0aUzMdL11
 cfijO6bXsLXyqhXh6Ah2eJICkTwzKaUPAKr9XCqwH8xiF5N6ugZW6mms4+j2edfLblinYVhAMOl
 hFmId7jcgTYTU1ejTHBV8zVQtNvUhCRIWTXIGAK7tt431LZK5VVhexpaVYw71vDKiTAFUITCj+/
 IQ3haxUOZnl/+s6xGHSGicueS/spmD5fjz4IpR+Alq17Jr9BOXbGwa6dMvi5HyimSHyMAe3Fs/t
 6QBGbUHQxQloaGoA3s3bqaFlrtWhHd9w1U0omeHrMewQPPRRAHTBq4aXlGW/QtKDbL2rSD5sAaf
 r4/1GdHl
X-Proofpoint-ORIG-GUID: 6se98caPMIOueh0uyJxyfnSFIZqvf-5r
X-Proofpoint-GUID: k1OgY46jvqeXBS3TqDn29_yFw37ZO4O8
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68b24960 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=nnYS0bij2i_Gjx_wgb8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

AD4030 and similar designs support three different options for the clock
that frames ADC output data. Each option implies a different hardware
configuration for reading ADC data. Document AD4030 clock mode options.

Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index bee85087a7b2..1e4e025b835f 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -78,6 +78,18 @@ properties:
   interrupt-names:
     const: busy
 
+  adi,clock-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ spi, echo, host ]
+    default: spi
+    description:
+      Describes how the clock that frames ADC data output is setup.
+      spi  - Spi-compatible. Normal SPI operation clocking.
+      echo - Echo-clock. Synchronous clock echoing to ease timing requirements
+             when using isolation on the digital interface.
+      host - Host. The Host clock mode uses an internal oscillator to clock out
+             the data bits. In this mode, the spi controller is not driving SCLK.
+
 required:
   - compatible
   - reg
-- 
2.39.2


