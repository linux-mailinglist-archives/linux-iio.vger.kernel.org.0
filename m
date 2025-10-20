Return-Path: <linux-iio+bounces-25286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CEBF3249
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 21:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1A54F33D0
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C982F744C;
	Mon, 20 Oct 2025 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="opcfKr7J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC102D640F;
	Mon, 20 Oct 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987655; cv=none; b=jy+ocVPgBbJL3MYJBeG6Mv55JoJ8i4uC+UVi3al10RchRSggVMdK1rg11hongKK8vY6marX327Vpb5CTsbIVAQ2GXe0VXHs6yReBbElUbvyqSdeoLqWrfCJJ0MS/QstOINOakQeIv7BudaxrD/jW6BqiJQbAR14vc4aRcST56tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987655; c=relaxed/simple;
	bh=vreuyB1oJMX28dl3w587JJSbrdpOaZ848torossb2pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WziHLUyYO+ymvH2JfDs9lnlNeePrI+KxuqHBGWmsMp86kryXdpvhhErCjr1AwKQyl2mLADcuJ8OjaAo7OiKWHCcqpKXZ8P59oNuENLnopuxegdTciszYGjCT4uzPEi9p9lfufJgHqEvBHHcS+VNsHVWiH8Hvq0xQBzphD2Y7L6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=opcfKr7J; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFsRcd019061;
	Mon, 20 Oct 2025 15:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/m5lg
	W9LZdYxB6YJs1TYPvAh9FlaVDaMUHUk0YNse/U=; b=opcfKr7J+GBJkXNumyjWj
	BsmiwNMjp92VmSKMINJ9YzGkGUjzDaqhtW+0M71sgkuOC0+dP/e04u2hn96+w6Uz
	8lz8xu6LqNekbZoNYmr3vJBhFxNu64l9mULn2lT5avmONhPOh+KqVwrnAdQ2cTGo
	ZkycvfT5JxsvseADwnbpZI5iFZwCE4b1cDiC/O1OPQOsbpzgkrvxWAhMQvQnJqZE
	tSQhTNQZv0qI95UO0ZONu08acdyQpTm7cgMXkcrZe1cPrrKrWhbnX504CYGpXM/2
	BO2y5VWddmw16ZqUciKew7sSbpFeHxcU6kUqkzH2v3Ia/3yJLxXTsOe6IjR+qvSN
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v4r4kn21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:14:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59KJE7Md026501
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Oct 2025 15:14:07 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:14:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:14:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Oct 2025 15:14:07 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59KJDneO013270;
	Mon, 20 Oct 2025 15:13:52 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 2/8] Docs: iio: ad4030: Add double PWM SPI offload doc
Date: Mon, 20 Oct 2025 16:13:49 -0300
Message-ID: <9accfba376f997bc52293ad8fe151cbca98b0725.1760984107.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: 7ZrOBwhmsRvqsdBuIVuHfb6WBJXZbfIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzNSBTYWx0ZWRfX0ujCNs2mU7sA
 keVfkiKo31VNyOYSRJHy1XfVGM7haOj/2p2epjWC2OxS57SpuYb29jMDPXAxPH1R14lFh5YpLcd
 rHwck/GcfBlzG89S4Q3p6Gh4Dbf0CgWBsuowJs0AINsEWc/tyMbXNbsZq2SDu/z3fx/KtNVr4vP
 /PfR2ahhJ0sN2y47iggyVqtygQLCsrY3IO64p496q9NFmB7oTzAHGlaSRkkdQ7PKx1KrE2TimfN
 81qEa3eSgOPFuIl0p+uavlQ2DSlcYoSQbfVS9veKl27a8KeEkpEioO4pXAVB5DZE6LcEYuKvUoi
 cQDYmyIZvJJbaijplEEZj8UBhwSWwfLBEekm2iZRlplLCb6kdsHzsISdgwMlT5Xxn5jujW8fx6Z
 fhK8ubcvhpRYLdKTqjxgqMbScsr50w==
X-Authority-Analysis: v=2.4 cv=KKtXzVFo c=1 sm=1 tr=0 ts=68f68a00 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=Z7BqY8bEq__jAXHbdh4A:9 a=6HWbV-4b7c7AdzY24d_u:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: 7ZrOBwhmsRvqsdBuIVuHfb6WBJXZbfIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180035

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


