Return-Path: <linux-iio+bounces-21815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5EB0C2D8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035445413C4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CA2BD5AD;
	Mon, 21 Jul 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bEun1vs6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF629E0F3;
	Mon, 21 Jul 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097124; cv=none; b=K7Ah56dJ+4l1kfYhrZkqA5bS35124zKP8JQNr0/lzMKtn5zg/SJxAWTm+4AqXXOZUSfGZVdlg8jNLBnv88p/EkVJtZuICzlfQEIdi3MDHI+d9mWchE+nsGpVUnlsEmTINi056d5OAUebayIK8t9gOR8xSLOT7ZBeGvftaOrHsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097124; c=relaxed/simple;
	bh=8/uk1vqgAefd6fGn1RoqHepit2mR80dRJ2YpDpk0SnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox/1EYF5ny4SCmx4/xDvLBCaej9M1eVIdEJTBC0frIDuROTHx8kPfMO1umXQ1MMDVIPJsL2i/27Z3jod+Ix4EUL3efBZH6Ax8aqD4WrF7h30OmLW8lPKgrjTQ00AzBYE55joLn/1zq1GxTSN9F0hFntJu/jxyjL1wvyBIhrf9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bEun1vs6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L8761B029685;
	Mon, 21 Jul 2025 07:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MKoRu
	sqNRS/Ng1H1GDj0av6v4hssphyuvOtjJgWQ7sM=; b=bEun1vs6bKJsrR7LGD0LF
	vSy9SE/78eaVTgCM23JnyjU1tB+AljIbJaln3IYDt+QVncF4jtTLSoDg9ISzBBPy
	403joklfTjFdfM9QL9oE/5T0BhI0CzWGdn8fsVIEWyBPH9ARjSYFMQV+HLe0mGGq
	sglA7EwCCxT0dicH4bFbvdLknqWPafDjia6JHOnL+dCTXozXM/Fme27X9S/2Gq+r
	/XAbnm5xXzSpf35vnTnJtDjn8X0yr6bWGD7cgxfmMdH7/zdHDGeWObsGS3MC0vKX
	wnsZMiG+MtERlhRSF81GCcNo2IseZa5oAfTQvHBDr5420X0UjVjcW3vQvOHAqKLI
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 481e8a1vu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:25:14 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56LBPDIF033325
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Jul 2025 07:25:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 21 Jul
 2025 07:25:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 21 Jul 2025 07:25:13 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.210])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56LBOxBm007027;
	Mon, 21 Jul 2025 07:25:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 5/5] Documentation: ABI: iio: adc: add ade9000 ABI
Date: Mon, 21 Jul 2025 14:24:45 +0300
Message-ID: <20250721112455.23948-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721112455.23948-1-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kcc4CjEsJjmLQMZap2KgqOtK364ZhVBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwMSBTYWx0ZWRfX0QeEIDV5RtB2
 jTWcdzvSv6lbkzKGXLqs8PaJ0jbWGVIdvhos534nYPwWnDCu2sx1nTciUcwF1kEqx37j9n/eu6A
 lH9jKKKXtOXBgAzh/Nr5b2N1Cj92q43Fz1Ak28hWC3V0RwEOdz7ULHWQ+NljNO4k/8+mHyyGG1e
 sxcLMNWaRzHx4LrGU2F14QV3A8qWLl9+Sb3eASO6alGkBR2RJuHemm/8fiZoJKnCNHCzzzWjZtz
 3jOJ0bFDbYld3U+HL2YNn+ue/pck1o4rgkJ6cOmGb1HdsiPr3MbCSR6SfQu5qh+33hl6j0N5s60
 Q40Sim38FrdbazvUZf65dHLlObwFeOWksd9Q1BNXNw7xySOoUm9kNuRreig8rb7d3UII3X7COuS
 Iak+MrbXsuCDg5xArlz4o/EP8mZ9nIrbPOM+zLSg55gq7InaRd7nAhZg/1YoWyUA5f6481kZ
X-Authority-Analysis: v=2.4 cv=OdGYDgTY c=1 sm=1 tr=0 ts=687e239a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=G9epBy2OD0CA4cr1lPEA:9
X-Proofpoint-ORIG-GUID: kcc4CjEsJjmLQMZap2KgqOtK364ZhVBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=943 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210101

Add sysfs ABI documentation for the ADE9000 ADC driver,
documenting the device-specific attributes and interfaces.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 new in v2.
 .../ABI/testing/sysfs-bus-iio-adc-ade9000     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000
new file mode 100644
index 000000000000..fa92fd67483f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000
@@ -0,0 +1,64 @@
+What:		/sys/bus/iio/devices/iio:deviceX/wf_cap_en
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enable fixed data rate for waveform buffer instead of resampled data.
+		When enabled (1), the waveform buffer uses a fixed data rate.
+		When disabled (0), the waveform buffer uses resampled data.
+
+		This attribute is shared by all channels and represents a device-wide
+		setting that affects the entire waveform buffer configuration.
+		Changes immediately update the hardware configuration.
+
+		Reading: Returns current setting (0 or 1)
+		Writing: Accepts 0, 1
+
+What:		/sys/bus/iio/devices/iio:deviceX/wf_mode
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Waveform buffer filling and trigger mode configuration.
+
+		Valid values:
+		0 - Stop when waveform buffer is full
+		1 - Continuous fill, stop only on enabled trigger events
+		2 - Continuous filling, center capture around enabled trigger events
+		3 - Streaming mode
+
+		This attribute is shared by all channels and represents a device-wide
+		setting that affects the entire waveform buffer configuration.
+		Changes immediately update the hardware configuration.
+
+		Reading: Returns current mode (0-3)
+		Writing: Accepts values 0, 1, 2, or 3
+
+What:		/sys/bus/iio/devices/iio:deviceX/wf_in_en
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enable IN waveform samples readout from waveform buffer.
+		When enabled (1), IN waveform samples are included in buffer readout.
+		When disabled (0), IN waveform samples are excluded from buffer readout.
+
+		This attribute is shared by all channels and represents a device-wide
+		setting that affects the entire waveform buffer configuration.
+		Changes immediately update the hardware configuration.
+
+		Reading: Returns current setting (0 or 1)
+		Writing: Accepts 0, 1
+
+What:		/sys/bus/iio/devices/iio:deviceX/egy_time
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Energy accumulation time setting for energy registers.
+		This value configures the time period over which energy
+		measurements are accumulated in the ADE9000 device.
+
+		This attribute is shared by all channels and represents a device-wide
+		setting that affects energy accumulation across all phases.
+		Changes immediately update the hardware configuration.
+
+		Reading: Returns current energy accumulation time value
+		Writing: Accepts any valid 32-bit unsigned integer value
+
-- 
2.49.0


