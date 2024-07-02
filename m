Return-Path: <linux-iio+bounces-7114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1E91ED33
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 05:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3531C21113
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029E2B2DD;
	Tue,  2 Jul 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xwdu4ULD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F122079;
	Tue,  2 Jul 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889277; cv=none; b=U043tel8pXPSX59KOO0Lis3+GmLUrY1/E9/AhG4Bs41dGRgXvax/grONwCKoFC83llvUulzXwppsT0u0uKm7rKlCjP26mDJDvG1b+2xou0PhCBmfwvfteOgBUDZPgNnXTIwd0cncKmV0M2BbiC1DyUnbQjo5ZWbN6OeMvLsSzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889277; c=relaxed/simple;
	bh=I+CXTagreL7fKO/W4/j2zsvsfD2mANdRkzn+/ifW9WQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bik/hAgm0m8QLDprd6A5PnsZWMhIAdcjPViWJkT32iQIhOOz7jvi8dpLyRKXO2DtcXHMRRIFylIxCIVBoZCq425YvFdj354jvi2QctbEuLNcTYrIm+RvewX0ad6HEjIQEsvX/gJIx803pfl853y4AB1aj7aQ7vvvI+LV9VGf4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xwdu4ULD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4622dam0003294;
	Mon, 1 Jul 2024 23:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=q2rZ+
	/fy8q/Wv7rOt9uSKSPfi3UDfAxEuQjAB6sckIM=; b=xwdu4ULD0VOLIEn4m2jpF
	vX05SIYjCyHrn5EVmT7SArmj1t4ls485o5YcbmN6D/rCCVadA5C3xiYQ09Lv1rb5
	iAbE2i9xm7I6dV5ttJ2u59y11zsu1WVCGhtJZb0FLVXhXPDq6NtB6kUqY2viL6Hr
	TZYb1B8bkBUmfgsenY9Y0U10PtRW+CtsICjtKqbSh4pmvFJpVZoMGrw0bxbkDcZM
	brOROgtHbVyLgl4hE50Nt0gcU3kFHJaRGmJSrCfHD2Pk7MoDvjJHWU8Ptr+LL7Hq
	cyHDlQRQVtyT5Lb1/sOQBLhvmu0lsViuXOQAARsXCVYrClJSYNKhudxG1By1XStR
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402c43ry5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:00:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46230vPQ041168
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 23:00:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 1 Jul 2024 23:00:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 1 Jul 2024 23:00:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 1 Jul 2024 23:00:55 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.28])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46230WbM032046;
	Mon, 1 Jul 2024 23:00:45 -0400
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
        "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Michael
 Hennerich" <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v5 1/6] iio: ABI: Generalize ABI documentation for DAC
Date: Tue, 2 Jul 2024 11:00:20 +0800
Message-ID: <20240702030025.57078-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702030025.57078-1-kimseer.paller@analog.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JcrPCaZxhDxStU66nbpTEd-dtb8xTk9Y
X-Proofpoint-GUID: JcrPCaZxhDxStU66nbpTEd-dtb8xTk9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_23,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 mlxlogscore=985 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020020

Introduces a more generalized ABI documentation for DAC. Instead of
having separate ABI files for each DAC, we now have a single ABI file
that covers the common sysfs interface for all DAC.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
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


