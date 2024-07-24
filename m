Return-Path: <linux-iio+bounces-7859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505893B462
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F841C23843
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A84915E5A2;
	Wed, 24 Jul 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hlHb3GrP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80D15B562;
	Wed, 24 Jul 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836611; cv=none; b=tYOaRo7hkiVYIDv5RkJyJxHW0bcIch99Apona+L14sQz3z8ELR8QIhl0wlJiA8xyW5usvqygeIGh/w3pHqIYEi9cgEubVz3MFjHLj36hRqqTlmub8Gyxvj+5EjoSv/2RDbdTOwPA8oh8f52GYV3BbBOANgdIh8MFZy6+qJNUOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836611; c=relaxed/simple;
	bh=67u0rkQ4U2k/kgDI3xUkhRA8bYUvlvBu+Pi6/kcc2OI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kq1G+rm18iYTX0ake/vOIWHtBiFLU7zRZYhuXH6CWaVijhgsGtMngra8anx2gz+07bexd+kt9hbbEdyofSBH6/Keo4HsMRsdVIRtp2QCEOhBIE93y5uvYxKcnsGPs9snMoP26Lr6/HDiY77LwjpH4Vp58k7zZ++AfyuXM9o+t6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hlHb3GrP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OD89nE007989;
	Wed, 24 Jul 2024 11:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Hqjbp
	p/gNkvWog7m4Aof0aaaBUsXjIMVPbUK+XSgrf4=; b=hlHb3GrPgTWQs29rmlsVj
	T2fze5/aa7wfMwQ1ZnUfUH0OA/aJexeNfHUNU+sPf8JoC2V0IXKIt4MfpSebXWjB
	ZvEz8XjrUwGJcgm9MBlyk9T1SaLr+FVPPWnvCFzn5DQQOtaHD+fAoTZWwmAoCzdw
	+usbEPfnl/85W4QAx47kLbZ3Cghw0aUOis+SHqi5WOhV/F41f3JE7M77L2IR/F58
	Di5hDJ1bmnjlaNTqYcBudtTMaHDAJMQeUNHCWlCtPlUWlBTSSK3vmlyArNPfZnTL
	Sn2bpP7fIlYvowkiMa0cjYrA6zxHIHXZpMcJ4xY1rUr9t2pnTmMmOILi0AGHyWZg
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40jw2v9skm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:56:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46OFuTtl046242
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jul 2024 11:56:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 24 Jul
 2024 11:56:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 24 Jul 2024 11:56:28 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.162] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46OFtP3a002602;
	Wed, 24 Jul 2024 11:56:18 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Mike Looijmans
	<mike.looijmans@topic.nl>,
        Liam Beguin <liambeguin@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/3] Documentation: ABI: added filter mode doc in sysfs-bus-iio
Date: Wed, 24 Jul 2024 18:54:40 +0300
Message-ID: <20240724155517.12470-4-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724155517.12470-1-ramona.nechita@analog.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: lq-CQ_SiINBV2uTDolNoCA_kGT2uJbdO
X-Proofpoint-GUID: lq-CQ_SiINBV2uTDolNoCA_kGT2uJbdO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407240114

The filter mode / filter type property is used for ad4130
and ad7779 drivers, therefore the ABI doc file for ad4130
was removed, merging both of them in the sysfs-bus-iio

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio       | 22 +++++++++
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 46 -------------------
 2 files changed, 22 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2e6d5ebfd3c7..31b1cafec8b5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2225,6 +2225,28 @@ Description:
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
-- 
2.43.0


