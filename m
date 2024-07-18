Return-Path: <linux-iio+bounces-7667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376D93477F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 07:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D158B229AA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 05:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E32A4C62E;
	Thu, 18 Jul 2024 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZXTXd0LZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AE481D5;
	Thu, 18 Jul 2024 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279967; cv=none; b=qjPDbrjbTk7uE6ZS4mc5fYn4d4v5Qdtyk1sUsJjh4QGYRiSMLVXgS1pjl1C+FmDh/E7eq72s2gNlSCJzQTZj3Ei8kEhMSQ0f6sIUisqKlHjwerzFTtbHHAlFmV52xsPOo/Vd9J6kI1aUS6MRU3z6N5iLGUwMT3oXqDwZioJYAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279967; c=relaxed/simple;
	bh=jgq4Oslihc9f2TZkyLqb5vj6zpaHW6dUq64OcN5wBcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKswfMce+UC0UcN6SuBFYzN7ifCZq3NVhcMI3imm+HliiIqx6NmGVZlFrZNcotorw7PFMJZ2v6y1qbHKE42QxIFOLoESr3y8a6ajpz3EOyNzKTPr+IzPz7PpqdnyuguQEP7GkCXqaLILMgoVtOWeIT04D51u4FLrGWUm2Hyl7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZXTXd0LZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I1ljEM023192;
	Thu, 18 Jul 2024 01:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oLUkD
	ph/1q+Z3h4aKql9uwEiEDrCkCSPU0F9oc0WDpU=; b=ZXTXd0LZ9KKRomeO6ZZag
	+8S6cPKl9xc+rTb7tT3AfnT1X3azmQIxXlduhAbSHPZMtcq1iZuJ+C60DOa0q0Ry
	nDvpdXkL1FxtaG3XJGu/VZ/eBjQLpAuWnDvOBpGwFQEXJCwkLo/5+++e7OKPfqN9
	fTBNVGkjyMo1IlUWVqXnh1ZCROASFxehtLcvQWgOPy+V33qKm70xaOfC5rFq6caT
	Ug4aUyFMHe2MvEDlc/53I+jodyUfLq/XwrpVS0mNhjxajM/2cV/ZCng9P0i4D5Yv
	GpbmzzWirIX5Si1BVUP5uRArLBTlPOn7ouxvzwqUDeQkRG7glnzyHyaWu/Jehpsk
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40dwer69m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 01:19:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46I5J9fZ007546
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jul 2024 01:19:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 18 Jul
 2024 01:19:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 18 Jul 2024 01:19:08 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46I5IhgS009768;
	Thu, 18 Jul 2024 01:18:57 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Michael
 Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v8 1/6] iio: ABI: Generalize ABI documentation for DAC
Date: Thu, 18 Jul 2024 13:18:29 +0800
Message-ID: <20240718051834.32270-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718051834.32270-1-kimseer.paller@analog.com>
References: <20240718051834.32270-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZCljzlSchn93MRUh62GA1ksxjt0a0kmd
X-Proofpoint-ORIG-GUID: ZCljzlSchn93MRUh62GA1ksxjt0a0kmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_02,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=935 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180035

Introduces a more generalized ABI documentation for DAC. Instead of
having separate ABI files for each DAC, we now have a single ABI file
that covers the common sysfs interface for all DAC.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-dac   | 61 +++++++++++++++++++
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 31 ----------
 2 files changed, 61 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
new file mode 100644
index 000000000000..810eaac5533c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
@@ -0,0 +1,61 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Toggle enable. Write 1 to enable toggle or 0 to disable it. This
+		is useful when one wants to change the DAC output codes. For
+		autonomous toggling, the way it should be done is:
+
+		- disable toggle operation;
+		- change out_currentY_rawN, where N is the integer value of the symbol;
+		- enable toggle operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_rawN
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute has the same meaning as out_currentY_raw. It is
+		specific to toggle enabled channels and refers to the DAC output
+		code in INPUT_N (_rawN), where N is the integer value of the symbol.
+		The same scale and offset as in out_currentY_raw applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_symbol
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW switch to a predefined output symbol. This attribute
+		is specific to toggle enabled channels and allows switching between
+		multiple predefined symbols. Each symbol corresponds to a different
+		output, denoted as out_currentY_rawN, where N is the integer value
+		of the symbol. Writing an integer value N will select out_currentY_rawN.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Toggle enable. Write 1 to enable toggle or 0 to disable it. This
+		is useful when one wants to change the DAC output codes. For
+		autonomous toggling, the way it should be done is:
+
+		- disable toggle operation;
+		- change out_voltageY_rawN, where N is the integer value of the symbol;
+		- enable toggle operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_rawN
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute has the same meaning as out_currentY_raw. It is
+		specific to toggle enabled channels and refers to the DAC output
+		code in INPUT_N (_rawN), where N is the integer value of the symbol.
+		The same scale and offset as in out_currentY_raw applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW switch to a predefined output symbol. This attribute
+		is specific to toggle enabled channels and allows switching between
+		multiple predefined symbols. Each symbol corresponds to a different
+		output, denoted as out_voltageY_rawN, where N is the integer value
+		of the symbol. Writing an integer value N will select out_voltageY_rawN.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
index 1c35971277ba..ae95a5477382 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
@@ -53,34 +53,3 @@ KernelVersion:	5.18
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Returns the available values for the dither phase.
-
-What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
-KernelVersion:	5.18
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
-		useful when one wants to change the DAC output codes. The way it should
-		be done is:
-
-		- disable toggle operation;
-		- change out_voltageY_raw0 and out_voltageY_raw1;
-		- enable toggle operation.
-
-What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
-What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
-KernelVersion:	5.18
-Contact:	linux-iio@vger.kernel.org
-Description:
-		It has the same meaning as out_voltageY_raw. This attribute is
-		specific to toggle enabled channels and refers to the DAC output
-		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
-		as in out_voltageY_raw applies.
-
-What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
-KernelVersion:	5.18
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Performs a SW toggle. This attribute is specific to toggle
-		enabled channels and allows to toggle between out_voltageY_raw0
-		and out_voltageY_raw1 through software. Writing 0 will select
-		out_voltageY_raw0 while 1 selects out_voltageY_raw1.
-- 
2.34.1


