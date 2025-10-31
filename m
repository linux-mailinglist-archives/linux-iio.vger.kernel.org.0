Return-Path: <linux-iio+bounces-25766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A41C26071
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41C444F038D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A362FE060;
	Fri, 31 Oct 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iKRIkobG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF282F5328;
	Fri, 31 Oct 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926681; cv=none; b=OFqNYcNA7SCot1kk3PewjMF5SYJos74d4eoeRI1bAocI2Ajms2BWuxPO8QQPI29h8p+dYVAkNtx+px1u2Kj631UJTtYOYdZ5YPSTjNTUTRPc9OL8PuTEgOTc+794fgQMdZv56zO2A51w881OWxOCj4y1o8muRQQi7qyZ10FFcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926681; c=relaxed/simple;
	bh=5nJubTjjNG9NKAIGiUGcTFQ2vFJbo2q8cvOpWG0OPwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3qP/yJF7JUFGVfqP/r6XQs+4ng2Z9hMgHD3ijdG/yNNHWatZmfiJ5LqVQQ8faE8XNFXwGowQCKSXcZ69Fc/BqN7MXf9z8b5oOuTvoc73OYJl9oerPI1ZeSmDu1l6M5WGSqUM5Yc6/mB9YHv1YWWe48hn6pgDId0VTk5D+ulXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iKRIkobG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VFFuAe2389589;
	Fri, 31 Oct 2025 12:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ACaFc
	ZXW4lsjQ8W8UsFyNwiqNeeTdM/FeLiR7V0spOw=; b=iKRIkobGSSDmFtCB54R1R
	Sck8Vuj2cAP8qd2TOUqr439TC2MZcdestkVISzTLNshgSj5pidU2pAGX8A23Xjz3
	AD6KRNpoeKWKdcTqWF2DfljFznhv4KdVq6IS8+0Ks16cjxfEZmFfRKGVz5IDSWUv
	uLryonr7Sap0bmNrq0FM0yVZaQJS0J8M4yq73dzo7P65WYQsVQrJkBUPmkHmJ4Uh
	QrfysHXH26u/Z5DgQ4YQUwUWmLKgcOGHIZDdP7Y8CmrWBt5cEoAhMutjcBqxYXn+
	2Orxc86jUGS/egwS3PoR+mumn6SmVJF5u66ie6Q6wMNTMKVisUTnaEKI3MTtsjeM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4a4yktg8ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 12:04:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59VG4YDi064378
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Oct 2025 12:04:34 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Oct 2025 12:04:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Oct 2025 12:04:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Oct 2025 12:04:34 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59VG4K1N006874;
	Fri, 31 Oct 2025 12:04:30 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 3/3] Documentation: ABI: adl8113: add documentation
Date: Fri, 31 Oct 2025 16:04:05 +0000
Message-ID: <20251031160405.13286-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031160405.13286-1-antoniu.miclaus@analog.com>
References: <20251031160405.13286-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8EKqH7PB3eWYEbMD1xDhiyoS124djkfp
X-Proofpoint-ORIG-GUID: 8EKqH7PB3eWYEbMD1xDhiyoS124djkfp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0NCBTYWx0ZWRfX0t2CdHzunGj8
 NAJlkt2w0fVf01hSWFAu0HExgRIvpDp5P1a8PAyMBBFzyW7alcZ+SpKTAFbXpboB5o93KaVv0Ld
 mqo0PEMSeyGe0Uj1PLgLcWF8NRIjQi0ujm+Em75Xw23Moljq9YNPxcTEiqBX+aKNx/RVBz3y1tY
 zUtuMdDzwDgoHKcaGwr9vUuyDyOJeVV+vYqVk2pkpqllzn+1IjExi8+B4gmoSTVq/JZXg1D1RpY
 bgE2d8izXkNQI+zrNDrhmgIBx2MI/NtpPxcpFm1NszewaadO0wdH6Pq6rHalhNWRnBz5V0NsVOm
 ZkE7BvdIk+JxQM0ZtOgqRd1jt9e6kEzIuZXD9VBiysovUOmEPEY/2PMriq9C2o1awG2LmCVcr47
 pHUm0X3LSeEuv2Lqe6MqtzkuGJ/dGQ==
X-Authority-Analysis: v=2.4 cv=Uq1u9uwB c=1 sm=1 tr=0 ts=6904de14 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=5ChSaQLCZzwPHQEXt9AA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310144

Add ABI documentation for the ADL8113 Low Noise Amplifier,
covering the 4 pin-selectable operating modes.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../testing/sysfs-bus-iio-amplifiers-adl8113  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113 b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
new file mode 100644
index 000000000000..6155b79e6b83
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
@@ -0,0 +1,32 @@
+What:		/sys/bus/iio/devices/iio:deviceX/mode
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows the user to set the operation mode of the
+		ADL8113 Low Noise Amplifier. The available modes control signal
+		routing through different paths within the device.
+
+		The supported modes are:
+
+		* internal_amplifier - Signal passes through the internal low
+		  noise amplifier (VA=0, VB=0). Provides 14dB gain.
+
+		* internal_bypass - Signal bypasses through internal bypass path
+		  (VA=1, VB=1). Provides 0dB gain.
+
+		* external_bypass_a - Signal routes through external bypass path A
+		  (VA=0, VB=1). Provides 0dB gain.
+
+		* external_bypass_b - Signal routes through external bypass path B
+		  (VA=1, VB=0). Provides 0dB gain.
+
+What:		/sys/bus/iio/devices/iio:deviceX/mode_available
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading this attribute returns a space-separated list of all
+		available operation modes for the ADL8113 device. The modes
+		control the signal path and determine whether the signal passes
+		through the internal amplifier or various bypass paths.
-- 
2.43.0


