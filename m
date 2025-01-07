Return-Path: <linux-iio+bounces-13963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67861A043D7
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F716587E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A21F239E;
	Tue,  7 Jan 2025 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TUQf/ZT0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256211F239C;
	Tue,  7 Jan 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262760; cv=none; b=J+Boa2zp9iUTuFSLvXK7RBn3cH4AXuWn0FE/1ko52+CxVYPVchTmcSe1bXn9rBUlydAMQxzNh9UIrji50dGy2Sd9CFtjIRdXYJ7i0pjX7pDwqV1wt3HpiVpOkLz5aFckbzG4+ugzrBA+82klu6HegzXV7nlwtxPTGDDT9M57RzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262760; c=relaxed/simple;
	bh=gKNuXGhTh95DXAr4G4BnEi38AxqgBGf2PSTsSrQbXiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5txF5H+KsN983ZAh5snXVEVJT1Uv4iIIguWdY4LhmVDF1fk9zs7/SU0Y6Z2lFF5CgYQUJC6KYsL6GBqkg/n1qIXXGOKxUGQJBDM9n9mJLaSHHUKqsOPL9ZpG2n5s4tbsnH+WQr3FuEoSmuVwekhXHItPeg/HQZsnCVzPsdc5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TUQf/ZT0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvlCw014417;
	Tue, 7 Jan 2025 10:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9WAYh
	DkRvqVnvAjude8p/d1i1sL4tPJ5n3R/3cX2LHk=; b=TUQf/ZT0ViEBBICpkB+SJ
	lrKBaD/uGNZmW4AjAfv0j6hntoZzzdvFUUCXfwIdz1OlTA7FNHZVQ62MuVKYZELT
	bBxLzizcJj8SNCsfdBSOqmTnM366gGRWbkTSCTOO9ZoYHx5RLer+Jr7r2S3sTiY7
	bRznBml1ttV9xBRLOZ5HHkBoqtnfCK78EcQ2hVyXE19wIxWJ2VNi0+L/sK14pFMW
	SCxkAeo5f8lV+CY8uzN/3T85IpYoAuXqBGdr2RotZgEIyUlhznek2HxUoEm/1pdT
	0xDB45wK7hA9HtWK5Wpe/2UytnmzRcUiBqWTtkIBW2oOKG06OOwTiNbr5NR4jjcr
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gbrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:12:21 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FCJRt033332
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:12:20 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:12:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:12:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:12:19 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FC4qg029724;
	Tue, 7 Jan 2025 10:12:07 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/3] Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130
Date: Tue, 7 Jan 2025 12:12:02 -0300
Message-ID: <d03c85e527ffa5f8d54da55b7562cf84b1fc68fd.1736261048.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1736261047.git.marcelo.schmitt@analog.com>
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -3Iiv9rXUB52T8ngHMLt9Vtw04Rs1ts1
X-Proofpoint-GUID: -3Iiv9rXUB52T8ngHMLt9Vtw04Rs1ts1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070127

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
Second and third paragraphs of the body could maybe go into device specific docs
as suggested in some previous thread but those drivers don't have docs in
Documentation/iio/ and I've been more interested in how filter_type is supported
accross IIO to be able to support it appropriatly in new drivers.

 Documentation/ABI/testing/sysfs-bus-iio       |  1 -
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 55 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d97c35057a03..1faac5b2ad84 100644
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
index 000000000000..bd827186ad1f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
@@ -0,0 +1,55 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
+KernelVersion:  6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible filter modes.
+
+		  * "sinc4"       - Sinc 4. Excellent noise performance. Long
+                    1st conversion time. No natural 50/60Hz rejection.
+
+		  * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
+		    time.
+
+		  * "sinc3"	      - Sinc3. Moderate 1st conversion time.
+		    Good noise performance.
+
+		  * "sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling
+		    frequency of 50Hz, achieves simultaneous 50Hz and 60Hz
+		    rejection.
+
+		  * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
+		    time. Best used with a sampling frequency of at least
+		    216.19Hz.
+
+		  * "sinc3+pf1"   - Sinc3 + Post Filter 1. 53dB rejection @
+		    50Hz, 58dB rejection @ 60Hz.
+
+		  * "sinc3+pf2"   - Sinc3 + Post Filter 2. 70dB rejection @
+		    50Hz, 70dB rejection @ 60Hz.
+
+		  * "sinc3+pf3"   - Sinc3 + Post Filter 3. 99dB rejection @
+		    50Hz, 103dB rejection @ 60Hz.
+
+		  * "sinc3+pf4"   - Sinc3 + Post Filter 4. 103dB rejection @
+		    50Hz, 109dB rejection @ 60Hz.
+
+		This interface is deprecated; please use filter_type_available
+		documented in Documentation/ABI/testing/sysfs-bus-iio to provide
+		filter options for new drivers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
+KernelVersion:  6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Set the filter mode of the differential channel. When the filter
+		mode changes, the in_voltageY-voltageZ_sampling_frequency and
+		in_voltageY-voltageZ_sampling_frequency_available attributes
+		might also change to accommodate the new filter mode.
+		If the current sampling frequency is out of range for the new
+		filter mode, the sampling frequency will be changed to the
+		closest valid one.
+
+		This interface is deprecated; please use
+		in_voltageY-voltageZ_filter_type documented in
+		Documentation/ABI/testing/sysfs-bus-iio to provide
+		filter options for new drivers.
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
2.45.2


