Return-Path: <linux-iio+bounces-14947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89489A2635B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFA9163D97
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4A205507;
	Mon,  3 Feb 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lKbkZJYm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A281D5CC4;
	Mon,  3 Feb 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609945; cv=none; b=bPanQVbnT62LvVG+U7nyN2VmP4NUX82Y34sMk5mZQEQcVufAAEbdqbonj3QOsoel4cdBI69UoS0MdSIp1ZduK/hAXtuEeQ1/ycaa3kCFwyZah2j5L6oXbod01/U6nof4HIYvtWHzc0OM0OEvOoWShgMGJtqf/TrpUM/3XHROz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609945; c=relaxed/simple;
	bh=VkoKXHMxkBVKr44iLiDogPGF7kL63gtGYshcH5QFDXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca+PSfgLJeIIU31ecwvP+XBZdbb8HY7bG4pWZO/S6uj7JgNLD018H/1n3aWLfI2deH/iSc8zE93S/SwWYTBQqbRd4dWu5XXcwopXzZEAV/aOL2Cc4USd+aRZuDxP2pVYBj7/UNyZrDQhsE0F1zHBmM/mIAvCIKsyvobqbLd1Xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lKbkZJYm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513EBw3W022238;
	Mon, 3 Feb 2025 14:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NLDEC
	/twcdDdfDjs1rZdk47cdYEAF5yiIV9SL2Z0bZA=; b=lKbkZJYmOxhyYnrAeZ5L6
	NeoOdr4aaa9H5U2hkAyqhZ5PpgXdWsbskerEWczj4lEXnWyeYFkWMZLeEfA8+rKq
	LySH8xgSWvvLEm2aCJwU5XvjoX1QTqfqXZVfV49bwHHzVV6Zm9+uyYMF3LYz9p08
	RO3EE6ImyVVlcEm0ATy7xwiSyo+qyAhRjY7j/RpL/o0o6j9fO8XVOrJO+cGBWEOM
	w12v5ByDK8p6zdkyxNmGMVLQPQB6dvGoFq1/QZ/9MCWKia0GudmzE8G2qiGEaa+/
	AbU8iAJimAoguTdSA79xJ7zFu/jGXrPPXkThp08y+eOZakjs6n0QvYOyVWt7AmR5
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44jp6mb8v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:12:07 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 513JC67E052098
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Feb 2025 14:12:06 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Feb 2025 14:12:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Feb 2025 14:12:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Feb 2025 14:12:06 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 513JBrON026401;
	Mon, 3 Feb 2025 14:11:55 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 3/3] Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130
Date: Mon, 3 Feb 2025 16:11:51 -0300
Message-ID: <0d73303f2bca3312ccf2abfeb2c654c228fa7f60.1738608986.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1738608986.git.marcelo.schmitt@analog.com>
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: UyTUHrHGnq5Hnb5EqMZfpX9BKv2fYBDC
X-Proofpoint-ORIG-GUID: UyTUHrHGnq5Hnb5EqMZfpX9BKv2fYBDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030139

The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
in_voltage-voltage_filter_mode_available attributes to user space. A
previous patch merged the documentation for those attributes with the
documentation for filter_type/filter_type_available into sysfs-bus-iio.
Filter mode and filter type refer to the same feature which is the digital
filter applied over ADC samples. However, since datasheets use the term
`filter type` and ad4130 driver is the only one using filter_mode,
deprecate the filter_mode ABI in favor of filter_type and keep the docs
separate to avoid confusion and intricate attribute descriptions.

The digital filter helps shape the noise rejection bandwidth and is
supposed to be adjusted according to the signal of interest. Depending on
the particular ADC design, the digital filter configuration may have an
impact on the output data rate (ODR) (which is equivalent to the sampling
frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff frequency of
the filter (`_low_pass_3db_frequency` attributes), or settling time.

Digital filters are a common feature among sigma-delta ADCs and
IIO drivers set digital filters according to different attributes.
ad4130 and ad7779 filter options are supported through dedicated
filter_mode/filter_type attributes in sysfs.
ad7768-1 and ad7173 set the sinc filters according to the
sampling_frequency attribute. No filter_type attribute.
ad7124 sets the digital filter according to a filter_low_pass_3db_frequency
attribute so it doesn't export filter type attributes to user space.

Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio       |  1 -
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ff9cc09360dc..e4fd99c92d81 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2277,7 +2277,6 @@ Description:
 		representing the sensor unique ID number.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
 KernelVersion:	6.1
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
new file mode 100644
index 000000000000..9c0698ad27f9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
@@ -0,0 +1,20 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
+KernelVersion:  6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible filter modes.
+
+		This ABI is only kept for backwards compatibility and the values
+		returned are identical to filter_type_available attribute
+		documented in Documentation/ABI/testing/sysfs-bus-iio. Please,
+		use filter_type_available to provide filter options for new
+		drivers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
+KernelVersion:  6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This ABI is only kept for backwards compatibility and the values
+		returned are identical to in_voltageY-voltageZ_filter_type
+		attribute documented in Documentation/ABI/testing/sysfs-bus-iio.
+		Please, use in_voltageY-voltageZ_filter_type for new drivers.
diff --git a/MAINTAINERS b/MAINTAINERS
index 98a3c1e46311..28dbbf6d6efa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1279,6 +1279,7 @@ M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
-- 
2.47.2


