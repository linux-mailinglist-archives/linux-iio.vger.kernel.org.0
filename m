Return-Path: <linux-iio+bounces-25073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD6DBDB9F1
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC501891E25
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4556830DD21;
	Tue, 14 Oct 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PK7P3UjL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5230CDAF;
	Tue, 14 Oct 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480506; cv=none; b=p3UcvDbR0K7YO5h/yIdNZ3QPCca3+9lxGLu9ZpnulYRWkP5R1BxSj00fCmJ+6xU5smF/chyLbk15fFE6p+A6JhrhwcIprPAmBXcUkv4VqXrJ3HbZvFMI0LBgUvJ7r/XHarfyJdKgkcnk8IU4wba7zCrM+v2zVueJpZrvSfSfgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480506; c=relaxed/simple;
	bh=vreuyB1oJMX28dl3w587JJSbrdpOaZ848torossb2pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1wnpdu60/VKozrd68UfTgymQ6SWcQWiUPohmu2a+776Wz7mWABBBxY1ACNs13jucp3Rhe7iOwmqBpAuI8zKk3QXVQ54/ylISMGyGqcwRBUxa1QPjuy/YpL2SvnQ4MtVaPMX3szIgDQIGztMFqo7c0FWsDfTyIMvMwuZ2NMyJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PK7P3UjL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKPth4008042;
	Tue, 14 Oct 2025 18:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/m5lg
	W9LZdYxB6YJs1TYPvAh9FlaVDaMUHUk0YNse/U=; b=PK7P3UjLVXKlzUm8B8X5m
	KxchoHBcv+SsF59gIMjVGXDYF2ihfHftHcPmOiFaBhNYLIes2sQH+Lo00/l8K37O
	jn3zyBDU5ly8yeOpymPjjTUY8gJpVVGk6uvWzqa6z7X+S3yF684gCeSEuuwI2jC6
	wWY1JHYHScZ1tzB3zQ+cU9iKxI7RL5BBPox2RpNttMFl0JNxt3DHZJRxgqpLyCqX
	8qyt0WeydZx9vrKyd/6mp2pkhmi7wUH8WBBeQ8WEeq5EP34/2rWpCusejqgk9ZbV
	G4KSBVQckl1xMCwpr78moyJb8sLDgkt8wnOLIoBiN+yyEp18qoqo6kR/CZKjOmHy
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49r5jcgghw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:21:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59EMLbPs042743
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 18:21:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 14 Oct
 2025 18:21:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 14 Oct 2025 18:21:37 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59EMLOkr005500;
	Tue, 14 Oct 2025 18:21:26 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 2/7] Docs: iio: ad4030: Add double PWM SPI offload doc
Date: Tue, 14 Oct 2025 19:21:23 -0300
Message-ID: <7d70aac0db13ac15d51c8fb2b96089ccdf6b962e.1760479760.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=OdqVzxTY c=1 sm=1 tr=0 ts=68eeccf3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=Z7BqY8bEq__jAXHbdh4A:9 a=6HWbV-4b7c7AdzY24d_u:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: yVS0QjL8BIeSjFSUoYQds4MVt8T5F2BD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDAyNSBTYWx0ZWRfX9jnyaBxSMXzq
 j2R8bla0Yc9fcZwnCquQp01+fTomLzHH5Ssv1TVoQAPUfeG3SCJwM/tbmp0yPi1bsiGMs+1bKxk
 m26Zg3xK4yTFQB4ajgkTQVLOtk9gfiAz7vJROw0zSIPBm7CPMpk9+8n/2689Yl4TVOdpzvzB9yu
 nXMGLeXsOJ3ewEQf35ONIrV8VK8nKi7C+SB5xsyjrsOZ5V5r7DVaTsHYITS/tXA0grg/LPcGNEB
 oWf4vdHWiIG37GqLngQA4EGjmmtNuvcG4aWoo5ZvxN0+FkoMsFNHlW+UbANir6UsC2U0p5N2uTR
 OP61iEYtyJwVj3cVq9JaECGk8ACr41ZB00cXvVirLK9OF2AHNxVN/ZdtcKjdkGMjXQJwbgvDhTB
 7x1/h2n8l9B1iko4ysM/4mUVWTfYaA==
X-Proofpoint-GUID: yVS0QjL8BIeSjFSUoYQds4MVt8T5F2BD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120025

Document double PWM setup SPI offload wiring schema.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4030.rst | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
index b57424b650a8..9caafa4148b0 100644
--- a/Documentation/iio/ad4030.rst
+++ b/Documentation/iio/ad4030.rst
@@ -92,6 +92,45 @@ Interleaved mode
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
+The configuration depicted in the above diagram is intended to perform data
+transfer in zone 2. To achieve high sample rates while meeting ADC timing
+requirements, an offset is added between the rising edges of PWM0 and PWM1 to
+delay the SPI transfer until 9.8 nanoseconds after CNV rising edge. This
+requires a specialized PWM controller that can provide such an offset.
+The `AD4630-FMC HDL project`_, for example, can be configured to sample AD4030
+data during zone 2 data read window.
+
+.. _AD4630-FMC HDL project: https://analogdevicesinc.github.io/hdl/projects/ad4630_fmc/index.html
+
 SPI Clock mode
 --------------
 
-- 
2.39.2


