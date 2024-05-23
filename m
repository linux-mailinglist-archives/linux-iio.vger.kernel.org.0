Return-Path: <linux-iio+bounces-5198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09F18CCB13
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 05:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC59B21D55
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182913B5A6;
	Thu, 23 May 2024 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f008PjRn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37713B2B6;
	Thu, 23 May 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434402; cv=none; b=WgfpwWHoHj0pa4PfUeu9aercuEjB4RGYRZ7mgB4HrlXLZ/Bopa3HN5MBDQUiDD4MZUueSzMplQJr1YMzxvvZAWWgP7FXK6eVqcRhNXp0LuXWxJ0J6qB5eXLP7uE6HFOk8xVaDcsjMqcYOviA3jgadeW1rklXlKSUr/6Nexmp4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434402; c=relaxed/simple;
	bh=54QIr1/0oMNlXsGMnj38IZ5iHmrVmpbIdHYLSTrPXsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcN424W/BbO/vsex9F9XTUgViQNU/54PtD0mOzCFgBFHaeGW9AOmPLTRv4mZLeD+bRvgi8s/EIvy++ekEndFu3PhWHWKDpoklk6ATxe/Q/QLbOWZZTSWnIqAwaQbpVkH/IYGZdamCUdh8qSxwV9q0k9fDVLe4dAQBeYnS++NLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f008PjRn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N2m5Gk002020;
	Wed, 22 May 2024 23:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=DKIM;
	 bh=aCXuglTpDKRYnsqCTi9LJn9HbQWMmHkQATPKz6GmVWI=; b=f008PjRnaPS9
	nnvFHbJX973inhqBGWnkRJis2jnEyFDQAVtsQRcLt+6EhzcjeGZzHkSMFbxc0Cg/
	pgj4JNxCjCmLPuQEknd86qillg5is2kV4ps22un9QK4xw9tTBzT39Ki7LHtpUbPa
	uWQ6CtOu8gMHiPlepEWmsaGa8f7d5P6gKOYoT7Y1Zfly7fbaHyytvrl2f7YFcQc0
	9FeO+BfcWtwIUAJH0l0KyK1C7ZwF7aVxkMnUvX0dHtKY+4o+eW7HlT9q2Grty4Vj
	gcDqHJ8HIPS6aNNt5Z7vl8f2dqhc2gx7/QxgIm6qTjbi0ejC8uiw4L0PMgf7+y8R
	CYSEXRRvOw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3y9dd03gqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 23:19:40 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44N3Jdvx004179
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 23:19:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 22 May
 2024 23:19:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 23:19:38 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.38])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44N3JG8s018850;
	Wed, 22 May 2024 23:19:28 -0400
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
	<noname.nuno@gmail.com>
Subject: [PATCH v2 1/5] iio: ABI: Generalize ABI documentation for DAC
Date: Thu, 23 May 2024 11:19:05 +0800
Message-ID: <20240523031909.19427-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523031909.19427-1-kimseer.paller@analog.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: jv_oVTymtdm4lIB1Znf_-GkpOmt8r7H8
X-Proofpoint-GUID: jv_oVTymtdm4lIB1Znf_-GkpOmt8r7H8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230022

Introduces a more generalized ABI documentation for DAC. Instead of
having separate ABI files for each DAC, we now have a single ABI file
that covers the common sysfs interface for all DAC.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-dac   | 61 +++++++++++++++++++
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 31 ----------
 MAINTAINERS                                   |  8 +++
 3 files changed, 69 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
new file mode 100644
index 000000000000..53d5213520c6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
@@ -0,0 +1,61 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
+		useful when one wants to change the DAC output codes. The way it should
+		be done is:
+
+		- disable toggle operation;
+		- change out_currentY_raw0 and out_currentY_raw1;
+		- enable toggle operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw0
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw1
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		It has the same meaning as out_currentY_raw. This attribute is
+		specific to toggle enabled channels and refers to the DAC output
+		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
+		as in out_currentY_raw applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_symbol
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW toggle. This attribute is specific to toggle
+		enabled channels and allows to toggle between out_currentY_raw0
+		and out_currentY_raw1 through software. Writing 0 will select
+		out_currentY_raw0 while 1 selects out_currentY_raw1.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
+		useful when one wants to change the DAC output codes. The way it should
+		be done is:
+
+		- disable toggle operation;
+		- change out_voltageY_raw0 and out_voltageY_raw1;
+		- enable toggle operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		It has the same meaning as out_voltageY_raw. This attribute is
+		specific to toggle enabled channels and refers to the DAC output
+		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
+		as in out_voltageY_raw applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW toggle. This attribute is specific to toggle
+		enabled channels and allows to toggle between out_voltageY_raw0
+		and out_voltageY_raw1 through software. Writing 0 will select
+		out_voltageY_raw0 while 1 selects out_voltageY_raw1.
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 758c202ec712..b3be54c09159 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12850,6 +12850,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2664 IIO DAC DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-dac
+
 LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


