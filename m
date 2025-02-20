Return-Path: <linux-iio+bounces-15869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB79A3DBF3
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C5D1736CA
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1426212B00;
	Thu, 20 Feb 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="c7QysMVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E894F2116F4;
	Thu, 20 Feb 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059790; cv=none; b=B2QjjLbZQZLZ9dyr/QyIpvWe9KgQhXXEvUmdtmkmhC1ONmxVs/sZYAzowdO4Rz+kn8QwhF2AK0AMcL4AuiM1Gp9AEpst/wD8AqxF7l/IEGdjJu2sMdQTWfCn/942ciJCAcSpbhGlhfzwuR+DCaTwrYb3e6h7GDZJ6f4pBZkmpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059790; c=relaxed/simple;
	bh=lnjWRDCKMMsRgpUtfDbsvcwCXp+CyGxfNXNlU5obMoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwZ+sZkwnmqx9MeQvG0YCoyzhQCWfsTiC4CDuKUrxlet5dcJX4MDkDOlotDTxmkmtUCurlfYhM3t/DOoIE2bzxcH6Sf7Jyz+co/QUamB6eSPg2+WIfMpjMz7W+dR5v1iHlM9/2TlBeYRor+MxbCQidCuph6WbO8p9PS+IMRTkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=c7QysMVJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBLvWj023645;
	Thu, 20 Feb 2025 08:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jMP+A
	uEu28ksfbMp/kG28vo8P5ePEEgpTSjga20FT80=; b=c7QysMVJ6CvBSVVgN5IYb
	M7SlOimP338WB98i44BYAx8L7TPMc/2AM4J1ZqFaMb7yq4dE5xGYZhcPE25HSwVw
	U49wpqxSsvIZFQjsg9ADqMOGtukTbSrGfbVXGJyGRkisJPjkWE7ENFZWA0G2Haap
	59AaFAPdj2gYDkbolSMMpznzthxh3I+0BwW+wghKDp/Si+HmPGRHxg5HUgX5Imd8
	O5e8m+yQ2IY9yyiVEA8hv3zI1N/SP+sSAxAONDoLMiwaGVcC6oUW92y3Y9HrRyS5
	2tPo0osrpvykJl8Nc7tLHxOEV/5lp+n12DlCOZ9r27a+KP/N4O1Du6NX3P5kfQym
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44x3f40hef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuOqU054164
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:24 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:56:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:24 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxr3008409;
	Thu, 20 Feb 2025 08:56:20 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 14/14] Documentation: ABI: testing: ad4080 docs
Date: Thu, 20 Feb 2025 15:54:24 +0200
Message-ID: <20250220135429.8615-15-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220135429.8615-1-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 59Q0V9GJ0KgE-X8E2Wfx6Lufnhxvjgi6
X-Proofpoint-GUID: 59Q0V9GJ0KgE-X8E2Wfx6Lufnhxvjgi6
X-Authority-Analysis: v=2.4 cv=DuKs+H/+ c=1 sm=1 tr=0 ts=67b73489 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=isn6CkdhFtPCLzFFK64A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add documentation for the ad4080 attributes.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad4080      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
new file mode 100644
index 000000000000..e37bfba0e989
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
@@ -0,0 +1,55 @@
+What:		/sys/bus/iio/devices/iio:deviceX/lvds_sync
+Date:		February 2025
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute handles the data synchronization process.Because the CNV
+		signal is not taken into account by the FPGA when capturing the data, we
+		need a process that configures the ADC to output pattern data, writes the
+		SYNC bit in the axi_adc register map, waits until the custom HDL syncs the
+		data correctly, and then changes the output mode to analog data instead of
+		the fixed pattern.
+
+What:		/sys/bus/iio/devices/iio:deviceX/lvds_lvds
+Date:		February 2025
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configures the signal type of the CNV signal. The value can be either CMOS
+		(lvds_cnv=0) or LVDS (lvds_cnv=1).
+
+What:		/sys/bus/iio/devices/iio:deviceX/filter_sel
+Date:		February 2025
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute enables the digital filter functionality of the AD4080.In
+		order to capture data correctly, the function must configure the ADC
+		through SPI to select the filter type and enable data capture in filter
+		mode through axi_adc(In this mode, data is gated by a signal generated by
+		the AD4080 (GPIO1 and is not continuous as it is when the filter is
+		disabled).
+
+What:		/sys/bus/iio/devices/iio:deviceX/filter_sel_available
+Date:		February 2025
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Return the available filter modes that can be set.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate
+Date:		February 2025
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Set the filter’s decimation rate.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate_available
+Date:		February 2025
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Return the available filter's decimation rates.
+
+
+
-- 
2.48.1


