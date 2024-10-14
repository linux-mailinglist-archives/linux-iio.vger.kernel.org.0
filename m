Return-Path: <linux-iio+bounces-10570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FE99CD7C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 16:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74F11C22AB7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7FB1AB522;
	Mon, 14 Oct 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GfaQeAOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B312610B;
	Mon, 14 Oct 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916386; cv=none; b=sqPMB56whkV1NIG27C7EAjtL4hMU8Ko1xbXdsJysqW0L8N4iplju5Y3e06sItqPZ9HkrKaHznnKre/0gRURkNAc15VDvjjgR4w/AlwBiNJoqNzu+WdE4xrSHTWPloTdAXgVyrPhgAKDo+xWt8t6t9MWX2RYHaET+vg9ICBPwSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916386; c=relaxed/simple;
	bh=7UlqkAk6os2Mvsp55yo9/CdeAhyY9FDBzZWzXnwkIAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ai0X5Mfle9qoZmPhcRStDee874UeHTrt4ySBHiBxYPANbdXCpVAO72Ku19TtqOkzWWGZI/pF2Xbp8epJgfReqlSvcaNTXLz1+MIDzjWxTNOM4QEIkcsUm/SSPKtE4rGhkxPKwn2QSIJEKEoFou+doJDoNKt5UYLWbj7bRx0hEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GfaQeAOE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EDePoE001993;
	Mon, 14 Oct 2024 10:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=T5DN0
	4DV6CLoqefnUn0edgchV3q8OmRAOgou1fkomeE=; b=GfaQeAOETqry/Oi5JuQaM
	uoUHMggOCL30OZzCJz6OEcACGh4fSyHmoYtilHWiZGndk4E0znnMidsNvzgpqcSf
	o3r8S86+jf6EM+Y3CSTcU/KrSBd83T3LxM4UwK0B8XdpcO3FzMoVAL3225BXUc8l
	oUQLsx6D83jVstdExdTdLXUo6flNY6Bd0gugwHrShoax94vhCYSJ8oPo3iMWQ1Hk
	Zoyx0zOWKhY8inFyxpEHHLgerQWdI8vyRjb4PeYE921Xy0STg7ggy1LKAQ5GUezb
	mMDuSYoj7+/TfRdk25UufY3c73YRyB4YIs9vWawAGwhWxlp3fPPW1JhzXT55jtqW
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 428yqm18ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 10:32:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49EEWlrM051578
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 10:32:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 14 Oct
 2024 10:32:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 14 Oct 2024 10:32:47 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49EEW6bC014258;
	Mon, 14 Oct 2024 10:32:42 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
        George Mois <george.mois@analog.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Ana-Maria Cusco
	<ana-maria.cusco@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v7 2/3] Documentation: ABI: added filter mode doc in sysfs-bus-iio
Date: Mon, 14 Oct 2024 17:31:59 +0300
Message-ID: <20241014143204.30195-3-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014143204.30195-1-ramona.nechita@analog.com>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: evJ7NzTQbptv3Z3KopfBbZzcF1vctJuo
X-Proofpoint-GUID: evJ7NzTQbptv3Z3KopfBbZzcF1vctJuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140106

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
index 89943c2d54e8..541b3a28c1fd 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2268,6 +2268,28 @@ Description:
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
index 6011af70c12e..2de269df7d3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1262,7 +1262,6 @@ M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
-- 
2.43.0


