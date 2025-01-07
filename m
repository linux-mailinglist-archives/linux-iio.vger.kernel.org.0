Return-Path: <linux-iio+bounces-13969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82869A04437
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB09B7A0477
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F81F2C44;
	Tue,  7 Jan 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T4r8tFPm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B81F0E5A;
	Tue,  7 Jan 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263528; cv=none; b=X51jQH/Av7SAZKmHuA5J4c2EfzzsXI3ANyyXVLluRIcaQi9lOw2u/0gGJuKpdin66VnD1fAGnGSrTkseQV6wJJlChoPibboJ2P0xVpH9AYzD1VLy8W6MtYfx000/RfzKJGS2TmgZkYOCw2ZqKF2OHMxhtMsTuYhFPSQ0KSCQLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263528; c=relaxed/simple;
	bh=ElSuqAk8p/nhheCtJn59rarakSBz64CH8DsWWQLQpyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4Z2yZUZDlGj8qy37F/kw3uOPMrqA8hB5x9Lp54PaOU+VkFZ7uB6fIyvce+FwBt1kb3WD4hpLUDzeOOf6YQJSMwrhtrfsh/isgSfVU7yZNT9CvTr1bFI+CgArBr61Z0PifNsDN7BEKulghMyzHNFSiutjcaBYgtVW+VIL6bmkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T4r8tFPm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvD9Z013528;
	Tue, 7 Jan 2025 10:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=urEVh
	NC8ReEi9+Grsi1R3w+bJebC77Z2JC30lFEGF9I=; b=T4r8tFPmD17KcT2qPxywe
	obUZe3T1thI3ru01D50LTVfSfqnR0S5oK//9C7WrK38XtqtOV6uxgsVl+/tAQD6J
	eJlp8auJOWGFHfvW0T8oaJaiWMCPEoKkoc3BJ1jKjQjstkIA1XZ0ovUgqV55nG0s
	9klMuLWVQXPw2MVkQva1GYsDBCBjOvYljH6nB50AmTPdYEnMjqB20rij311NetBS
	N0SBEoEY9bt+dGIZ0nHhOsuvzXFMPCIOGVkQtV80EOTDNa9qhfiGz67UC2RVeulh
	wZhQr/ffXm72iENRRgMA8SMJr4KPaAVPXt3eVrlGYOXj/k5glArtJjesgrTucSVX
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gdev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:25:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 507FP9FN013359
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:25:09 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:25:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:25:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:25:08 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FOujx030261;
	Tue, 7 Jan 2025 10:24:58 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 03/15] Documentation: ABI: testing: ad7768-1: Add device specific ABI documentation.
Date: Tue, 7 Jan 2025 12:24:53 -0300
Message-ID: <f78c3dee381b23c17787f1e2bc9c5667741d407b.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: E05zIRDgxvyjff4Wlf1eF606s-5sdROC
X-Proofpoint-GUID: E05zIRDgxvyjff4Wlf1eF606s-5sdROC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070129

Add ABI documentation specific to the ad7768-1 device, detailing
the decimation_rate attribute for better clarity and usability.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad7768-1          | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
new file mode 100644
index 000000000000..065247f07cfb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
@@ -0,0 +1,13 @@
+What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a range of possible decimation rate values.
+
+What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sets up the decimation rate for the digital filter. This can
+		directly impact in the final sampling frequency. Reading returns
+		the decimation rate. Writing sets the decimation rate.
-- 
2.34.1


