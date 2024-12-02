Return-Path: <linux-iio+bounces-12963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B019E0AE7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B1F281E76
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638911DDA2F;
	Mon,  2 Dec 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SXfbWijL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BF17C7CE;
	Mon,  2 Dec 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163792; cv=none; b=VNrw/hP26ECOSJrlVELM2+xmk+4hDp6Qag8w4c5pf93eWkSu0wTGgU9zEeD6Mmg0eRXSQpekgIWgTXNpvev5YIKq7xoXLieoSf/gwTozxaDb8puW0XONwh9ydIPM+gk0/MZ7GZlXy7CX5EjoBpRgg5L+QL9+wjD2SoFg3Ii2X7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163792; c=relaxed/simple;
	bh=xhIIKTgEjgfgPJ7uZLN9bGnfJwQ9HDBQbB0AxH1lDxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RGGrx4NUkviTFwHECSoXXBVcMaQ+60BbL9QbfVw0JJgqAQUY24b/a/PwDGktQml+UcgQj5ygqoO+P/DwmVyMWUUJAYAIUhgFWk+X/xWwx7mxz+Xcd6IbJu8z5z3HZgZPqe4qkRYm8a7ebvhxCpnXtfAPTy4lKCpBUY6U9fP3IYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SXfbWijL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2HdRtB026862;
	Mon, 2 Dec 2024 13:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Hg01MtYLSNkXslDYbN5/Uh6enJb
	m4mOvCya7IpOQFkc=; b=SXfbWijLh6XiLoscTrptzRznEZOGg1BT/H99sPw9xtg
	8Z6kudAOJrUuJJ+AibT5geO7Yjc5zyguvfWIoSBBkBVaxhuUxuEdcchjUM6sLFsJ
	aK6gXgutNLmIccHbHhFAx7yPKQxMMj23WMObiF7jrJQmDU3f3U25ZORSN2JDeNy8
	+kstgFBR05swKrL+XFvekCyByMxcJWI0Ovl/IoNpSyndTAj5GcOyYx3++JGrcYnY
	sm/O1kX/fR6lMqDVRr5xMVwROvxGlfJ446YenLb3LFnr42TAuL6t0GnnknFdzhTc
	g/xgxQArlQBBnqVo9XMLXK8GftGjgQGa1j8IhjJOAkA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4380g6h6hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 13:22:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B2IMrXd037765
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 13:22:53 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 2 Dec 2024
 13:22:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 2 Dec 2024 13:22:53 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B2IMfkQ007526;
	Mon, 2 Dec 2024 13:22:44 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 1/1] Documentation: ABI: IIO: Re-add filter_type/filter_mode
Date: Mon, 2 Dec 2024 15:22:39 -0300
Message-ID: <b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: N6f4ONGVqAyC_D2ulWzVRNIuUaDEnRX4
X-Proofpoint-ORIG-GUID: N6f4ONGVqAyC_D2ulWzVRNIuUaDEnRX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020156

The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
in_voltage-voltage_filter_mode_available attributes to user space.
The ad7779 driver exports filter_type and filter_type_available.
Add (back again) documentation for filter_type/filter_mode attributes.

Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Digressing a bit away from the specific ABI used by ad4130 and ad7779,
the sinc3/4/5 filters are called `filter_mode` in ad4130 driver while other
drivers (ad7779, ad7124, ad7768-1) call sinc3/4/5 filters a `filter_type`.
Datasheets use the term `filter type`.

Depending on the particular ADC chip/design, the sinc3/4/5 filter configuration
may have an impact on the output data rate (ODR) (which is equivalent to the
sampling frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff
frequency of the filter (`_low_pass_3db_frequency` attributes), or settling
time.

ad7768-1 sets sinc3/4/5 according to the sampling_frequency attribute. No
filter_type attribute.

ad7173 sets the filter_type according to sampling_frequency too, though it
looks like support for only one filter type is implemented.

ad7124 sets sinc3/4/5 filters according to a filter_low_pass_3db_frequency
attribute so it doesn't export filter type attributes to user space.
Missing `in_voltageY-voltageZ_filter_low_pass_3db_frequency` documentation?
follow up patch?

 Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..704c9033cb5b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2268,6 +2268,20 @@ Description:
 		An example format is 16-bytes, 2-digits-per-byte, HEX-string
 		representing the sensor unique ID number.
 
+What:		/sys/bus/iio/devices/iio:deviceX/filter_type
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
+voltageY_filter_type_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Set the filter mode of the channel. When the filter mode
+		changes, the in_voltageY-voltageZ_sampling_frequency and
+		in_voltageY-voltageZ_sampling_frequency_available attributes
+		might also change to accommodate the new filter mode.
+		If the current sampling frequency is out of range for the new
+		filter mode, the sampling frequency will be changed to the
+		closest valid one.
+
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
 KernelVersion:	6.1

base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
prerequisite-patch-id: 3370db9ec1e67ba97b55607f445ff37c60929668
prerequisite-patch-id: d686dd309e1d3d39d038613f514e58ff5893ae42
prerequisite-patch-id: c832285d7bcc22433f2314a144566aa9437fd5da
prerequisite-patch-id: 3f758a121e36edd43789e80379ff81beeb2d75ce
prerequisite-patch-id: 0ef36ec4d6cf23f08bdb3bc4399ced2561a2a69b
prerequisite-patch-id: c8e7f0e10a2630bd0029ee160f8dfc3f742378ba
prerequisite-patch-id: 5e85d52a87f2a833893eeeac5d1651bda46d0931
prerequisite-patch-id: cd75aba06cf77f8cd398dc7d0c33d94e1277d1f3
prerequisite-patch-id: b813c25db823f1b02d0e9005188d41c0d89eb291
prerequisite-patch-id: 024ac23a16e45e802b70afe9bc464d1caeb41fcc
prerequisite-patch-id: bc084c859bfa93c5764e656bbcbfd4d14e031299
prerequisite-patch-id: 51ebb591fbbb3535899332ce1b106a3f8d6497da
prerequisite-patch-id: 2b396d1069227fee1c5a7bcf33bc63a56681441b
prerequisite-patch-id: c00b841cea6e331e19fb1f31beae831572bce4f5
prerequisite-patch-id: 4fe5fcebfeb745a83a7054390a304a1e250d74d1
prerequisite-patch-id: 461cce4f81f88bbec71580c0743b8970a504899c
prerequisite-patch-id: 59cf79cfa5f091815f578aad884ba0e3f9ae2175
prerequisite-patch-id: d48f6e531e64ee7797890e9f36f849f881884f1a
prerequisite-patch-id: 5f48c69023ecae6b3de595c9a209d1c4d65b5ba2
prerequisite-patch-id: 73e2fc3be282880231105142342b47b00b23ab6d
prerequisite-patch-id: d71deacf6bb4e90e8059a12a94ade36866729fa0
prerequisite-patch-id: 6173a25ddf92a3d1446923d9e87b15642b761034
prerequisite-patch-id: 5b248ee02cc148eeea4f01c435e701b74bc07c60
prerequisite-patch-id: 9fa4f11d62ba0e1ef9f3ca08ef1ee5c1f0711038
prerequisite-patch-id: 6cf99f094cfa8d984a1c1cab8813d1078ee48f05
prerequisite-patch-id: b42c4bf1ce430dccca920f942c6040f641c8307e
-- 
2.45.2


