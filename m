Return-Path: <linux-iio+bounces-5658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF578D79B6
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 03:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0021C1F22504
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DDB5244;
	Mon,  3 Jun 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Bf6XtVjl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8B4C8A;
	Mon,  3 Jun 2024 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717377783; cv=none; b=BofS1bQratk47p+WyPjRVrs3jqCT+SVRfWdc+6pfSfSwXSqFccnSl62wY0/8sJG1JHffiGz8YIrGQehJCTb6x2kN1QrAOrYBZuI3GnK4rrHcxa+VXamipsKMJ7qY3Fay2CQsk1qT4qrqAG76ZqhS+pI9Dy6DGWi9ly4d+WKmExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717377783; c=relaxed/simple;
	bh=6PXKqYL85FdKzAhRz1TtXT3LipceCNkTw6h/cR19t9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3KDb+211WXa0dWpCqNGk/IMKjtN/zFsh1Mw29wENb1YC7S+yDuFP6/b2+jV1TfqkX6jsgNltatraegXq8kB7HfEdaKiIQEXv7aBTvbjIfHPXHUx4S68haJLwqIf449vu978ORMP5atS+k5HZQOdsPv23sYSFQJ7gFW7ErnTNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Bf6XtVjl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452J2cdT016607;
	Sun, 2 Jun 2024 21:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VBbd3
	88Cd6azu/vWhRc++DQlQ36Je8FpWpOn9E91i90=; b=Bf6XtVjlV10lVSHTBNJUN
	5zi6cTSOtn4ERD4Bxmo3Q4gh6JJuj1xEhCp1/BntBg/j2s1H9ep3GFlPY8LoiDju
	VLMNmuGsXw8AIKc7pHEZrQ+2YX/9uGQ1us5VLpErrmWf1501nyvPkQZZP9snixX0
	Y3dKGePAfAk/1VYg7azGeZis1WcTXdwxyNQ9nxyxNpgxcm5Jj4Q8576xDRJIhFP7
	7KXXpkrBAS6sO8z5jtXp6WAHTULSrGM0sAtz909K1TgaEZds0+Uzv5BB3fgpvpp0
	r6cB83nrywanTfSk/6a/CQpYgUKt2HqsLmBkRDs1Q0gn3um90gHAAR+wsa+1fg3C
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yfwg24g7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 21:22:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4531McHi049823
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Jun 2024 21:22:38 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 2 Jun 2024 21:22:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 2 Jun 2024 21:22:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 2 Jun 2024 21:22:37 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4531MFWP007966;
	Sun, 2 Jun 2024 21:22:27 -0400
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
Subject: [PATCH v3 1/5] iio: ABI: Generalize ABI documentation for DAC
Date: Mon, 3 Jun 2024 09:21:56 +0800
Message-ID: <20240603012200.16589-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603012200.16589-1-kimseer.paller@analog.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: T7eePbmTrPq3oQIhNuM8DExELFrfb07i
X-Proofpoint-GUID: T7eePbmTrPq3oQIhNuM8DExELFrfb07i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=967
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030010

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
index 000000000000..36d316bb75f6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
@@ -0,0 +1,61 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+       		Toggle enable. Write 1 to enable toggle or 0 to disable it. This
+		is useful when one wants to change the DAC output codes. The way
+		it should be done is:
+
+        	- disable toggle operation;
+        	- change out_currentY_rawN, where N is the integer value of the symbol;
+        	- enable toggle operation.
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
+       		Toggle enable. Write 1 to enable toggle or 0 to disable it. This
+		is useful when one wants to change the DAC output codes. The way
+		it should be done is:
+
+        	- disable toggle operation;
+        	- change out_voltageY_rawN, where N is the integer value of the symbol;
+        	- enable toggle operation.
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


