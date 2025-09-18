Return-Path: <linux-iio+bounces-24263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699DDB86419
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DB27E0251
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B003164CB;
	Thu, 18 Sep 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uZ4dFV97"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626D25B31B;
	Thu, 18 Sep 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217123; cv=none; b=gFlPWFzSUpyobD+pvGAjNoxzZqxTujwol8397msImiXYcoPP34su2aA7ORxoya9vRR51chJU2BTkXDcAPpCpy0XcTxKcUs2IXlPm2uklJcp1H3/buZ0SVmJYU5ZoIt/uiE9lCyRJrY1X5EO4C4UylBeeEu7CIYm2rQrS9eC7a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217123; c=relaxed/simple;
	bh=DR/yPc3lWbuZEteVQBQEUsAF6coD1n+ACVfLU9zYx0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhoFYc29hlNJKc3DQ9IC2hQrZjd1lTmBMp9a1kAE6tlc5mkfRhKGbUo8t0+L9bEh4Rhghhr0AGG86dRP8sCjCq7/w/ctmJoy49zEGsXWhEYj76ezIMQRFlhstFDWPmNvujXAeGFMgGWVI4eqI6gzBqajT/NEVetlvvMmMKaiXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uZ4dFV97; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFuXQw008831;
	Thu, 18 Sep 2025 13:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0bQPm
	28AAoWzZSvMOXiyyHoKKKJQvy/oXwyYYdtkYuc=; b=uZ4dFV97X2DhtpjuVOvrO
	C9al16mfqvHyvtiNM7pe6GClrSZtNAEFnI6Ku5kGKBkfcawDi5J1DRX7Ad10wA1U
	w+ehT149pXkAdLCiVq4AWnY1ckN7TJNyqG+lSrmJaSxgiBMZRJ+huE1Vd8TKaQSK
	zpChsKhtqi2t38W17tnMrJanOfO14OMUprW0H6kzVe+T1MHr3tcarxMysD16Xn3W
	ewWydDoNUjJdO8QIgNvgvFrO7rB/wgQ62zNAAhXJKWKjfGASDBa8Yl9Ydx6eyyNu
	rYnDBOEXdPdtNNbg2wR5o7BJeN+gWNPrK8I+XK13yTjnNLnKNEeQcWP1e1vxkVlI
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 497fxumef7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:38:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHcaYU013732
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:38:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 13:38:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:38:36 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHcMG4022208;
	Thu, 18 Sep 2025 13:38:25 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/8] Documentation: iio: ad4030: Add double PWM SPI offload doc
Date: Thu, 18 Sep 2025 14:38:22 -0300
Message-ID: <4f3b1c516f8148e0b7e1c430bb184a2db12ade3c.1758214628.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758214628.git.marcelo.schmitt@analog.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cLfgskeN c=1 sm=1 tr=0 ts=68cc439e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=bnatI8Kpfu1acvcDwXQA:9
X-Proofpoint-ORIG-GUID: uCKEBF8QqiJwyqVa3tS8fs1L51ia9Ugn
X-Proofpoint-GUID: uCKEBF8QqiJwyqVa3tS8fs1L51ia9Ugn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwLcglCn3++w+
 nqZOKxsyMe8sENsBQfyXMFzTUGGYhU1oDhnyOid6ui0khdA+YEobarNh18kd23eyE8QNzOGwbZz
 dYbGKk3U2OK6hOS3FEfdaZKczdy2s80CIaiSDDpI8DQaeS2xEV1SgVKX3bdpLnoUBW9vRRWmswQ
 7D7FHtTqFr3lyKSJvDa2EG9ed0rDQ8rc5jO2rEs2VDDj4dKULvgfPTPEWNH8NnyzmiS/C8K+DJ7
 dgZG0CewCYccVnXYHuvFBeDae7Jwnfxetz6jHMpNqW57V/TcSk5t6FyryY1oGKW1Qrr4VrjqpZR
 glMDzDcjXn7bkJni7l0K+LGSm4oCb3tB1fKYgQnwDEngSpmHM714nCyngexRqMWbg3rzMfvcZaf
 Bf1aBK+p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Document double PWM setup SPI offload wiring schema.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2
- Swapped PWM numbering.
- Expanded double PWM description and capture zone description.

 Documentation/iio/ad4030.rst | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
index b57424b650a8..9501d3fee9bb 100644
--- a/Documentation/iio/ad4030.rst
+++ b/Documentation/iio/ad4030.rst
@@ -92,6 +92,41 @@ Interleaved mode
 In this mode, both channels conversion results are bit interleaved one SDO line.
 As such the wiring is the same as `One lane mode`_.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |         CNV |<-----+--| GPIO        |
+    |             |      +--| PWM0        |
+    |             |         |             |
+    |             |      +--| PWM1        |
+    |             |      |  +-------------+
+    |             |      +->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+In this mode, both the ``cnv-gpios`` and a ``pwms`` properties are required.
+The ``pwms`` property specifies the PWM that is connected to the ADC CNV pin.
+The SPI offload will have a ``trigger-sources`` property to indicate the SPI
+offload (PWM) trigger source. For AD4030 and similar ADCs, there are two
+possible data transfer zones for sample N. One of them (zone 1) starts after the
+data conversion for sample N is complete while the other one (zone 2) starts 9.8
+nanoseconds after the rising edge of CNV for sample N + 1.
+
+The configuration depicted in the above ASCII art is intended to perform data
+transfer in zone 2. To achieve high sample rates while meeting ADC timing
+requirements, an offset is added between the rising edges of PWM0 and PWM1 to
+delay the SPI transfer until 9.8 nanoseconds after CNV rising edge. This
+requires a specialized PWM controller that can provide such an offset.
+
 SPI Clock mode
 --------------
 
-- 
2.50.1


