Return-Path: <linux-iio+bounces-9789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E65C9874DE
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B01C24CF1
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696E76034;
	Thu, 26 Sep 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oBo02WC9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5D5D8F0;
	Thu, 26 Sep 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358941; cv=none; b=Y8BNYcZtLGgvnaAKnNeaIHeQuu3jz58ArauT8buxS2i3+PCjzqm84Lfsmr3r1z9Fs+EpQMgi6/TWVolUITfRpEaykn0smgq5xJ7u65qyFYYRk+HGhimTWvZwS5YEX/HYvz+UMU85bLRvQ7TwT1Bda49h/A0pz6wbnpaSTUCaBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358941; c=relaxed/simple;
	bh=AkGaxpUdwO01O0UewLhD3BX2g1yWHbooR9dT4RBGW3Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrqdWp11oqNfcjcdRun5Jo8+5bAANAxMtQMnHkgkU1Vl347lZTjF3e3V2nTV+39BPDE4lanUMVWwpWRPpXduG4M5e/te4wYAcxKvje0VwsvK6PPUT4xV4SOMHk15+dXrOcHrqP751fgkL2uHVG2fpgpU2pDWtA1ZfjteWhb3g+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oBo02WC9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAjS9O003626;
	Thu, 26 Sep 2024 09:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=O2PVZ
	Ewh5XFYy48wvfmFnw8dLN21shAM2F1oCAXGuPs=; b=oBo02WC9bi5f4uFNQC7JC
	aOdzdM3eMy5f7ah8zaz4SWHZQzMcHAJVal6vQC/Cf9EL7gm+f2cUPA+o5fqZDob1
	uN/D/0AhsMZyx8tF1PyVRojbgvkbwaNI8Hz9h6w8h0jRbB7HGeI+HIY83mkkTuhk
	nHLtdDAaB1yDivCBmGDQp4gt8u2O3U05vjbiwO2zP/MHJ2JGxV+q/HR77xVM3mze
	h0apF+TXr8W2ERmYwVha5bkwDRF1Zz0MXrrWwuqZLU13r4h7yJrJ6XTULPtoZD0/
	E9OoZQ4mWI+5SmeoUGg3XnMDULlklXj2JWbyXNpJVE/FbmeY0jdqLtuW6yO3YimZ
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41u3fs9kb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:55:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 48QDtF7p010502
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 09:55:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Sep 2024 09:55:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Sep 2024 09:55:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 Sep 2024 09:55:15 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48QDsUFi028460;
	Thu, 26 Sep 2024 09:55:05 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Matteo Martelli
	<matteomartelli3@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v6 2/3] Documentation: ABI: added filter mode doc in sysfs-bus-iio
Date: Thu, 26 Sep 2024 16:53:56 +0300
Message-ID: <20240926135418.8342-3-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926135418.8342-1-ramona.nechita@analog.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: STm4YJh1OHft1HdZp6hJvRuArssyzTxM
X-Proofpoint-GUID: STm4YJh1OHft1HdZp6hJvRuArssyzTxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260096

The filter mode / filter type property is used for ad4130
and ad7779 drivers, therefore the ABI doc file for ad4130
was removed, merging both of them in the sysfs-bus-iio.
Since one of the drivers is available from 6.1, the version
has been set to 6.1 for these attributes.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio       | 22 +++++++++
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 46 -------------------
 MAINTAINERS                                   |  1 -
 3 files changed, 22 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 345d58535dc9..aac41e69aa43 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2265,6 +2265,28 @@ Description:
 		An example format is 16-bytes, 2-digits-per-byte, HEX-string
 		representing the sensor unique ID number.
 
+What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible filter modes. Options
+		for the attribute:
+			* "sinc3"	- The digital sinc3 filter. Moderate 1st conversion time.
+		    Good noise performance.
+			* "sinc4"       - Sinc 4. Excellent noise performance. Long
+			1st conversion time.
+			* "sinc5"	- The digital sinc5 filter. Excellent noise performance
+			* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
+		    time.
+			* "sinc3+rej60" - Sinc3 + 60Hz rejection.
+			* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
+		    time.
+			* "sinc3+pf1"   - Sinc3 + device specific Post Filter 1.
+			* "sinc3+pf2"   - Sinc3 + device specific Post Filter 2.
+			* "sinc3+pf3"   - Sinc3 + device specific Post Filter 3.
+			* "sinc3+pf4"   - Sinc3 + device specific Post Filter 4.
+
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
deleted file mode 100644
index f24ed6687e90..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
+++ /dev/null
@@ -1,46 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
-KernelVersion:  6.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Reading returns a list with the possible filter modes.
-
-		  * "sinc4"       - Sinc 4. Excellent noise performance. Long
-                    1st conversion time. No natural 50/60Hz rejection.
-
-		  * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
-		    time.
-
-		  * "sinc3"	      - Sinc3. Moderate 1st conversion time.
-		    Good noise performance.
-
-		  * "sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling
-		    frequency of 50Hz, achieves simultaneous 50Hz and 60Hz
-		    rejection.
-
-		  * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
-		    time. Best used with a sampling frequency of at least
-		    216.19Hz.
-
-		  * "sinc3+pf1"   - Sinc3 + Post Filter 1. 53dB rejection @
-		    50Hz, 58dB rejection @ 60Hz.
-
-		  * "sinc3+pf2"   - Sinc3 + Post Filter 2. 70dB rejection @
-		    50Hz, 70dB rejection @ 60Hz.
-
-		  * "sinc3+pf3"   - Sinc3 + Post Filter 3. 99dB rejection @
-		    50Hz, 103dB rejection @ 60Hz.
-
-		  * "sinc3+pf4"   - Sinc3 + Post Filter 4. 103dB rejection @
-		    50Hz, 109dB rejection @ 60Hz.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
-KernelVersion:  6.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Set the filter mode of the differential channel. When the filter
-		mode changes, the in_voltageY-voltageZ_sampling_frequency and
-		in_voltageY-voltageZ_sampling_frequency_available attributes
-		might also change to accommodate the new filter mode.
-		If the current sampling frequency is out of range for the new
-		filter mode, the sampling frequency will be changed to the
-		closest valid one.
diff --git a/MAINTAINERS b/MAINTAINERS
index 417c6751c0dc..3e72010b45a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1228,7 +1228,6 @@ M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
-- 
2.43.0


