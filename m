Return-Path: <linux-iio+bounces-26048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D64C43262
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615A6188DAF1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D27263F28;
	Sat,  8 Nov 2025 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Tpp0cDlC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36974275860;
	Sat,  8 Nov 2025 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623864; cv=none; b=ksq94uRFH5WGb61fGXJ3+kfkrJMLCBamG+4G0YHEaShQ8jlD4jOVcHlgySe568GON7WDZDjJKo62u4g3mw908Wt7vCL6J4wTEKRmF4T8ml03ZpOYwF05Yy6KskSEB1Yc9oeVSH8Y0msXLiBt+Hy7fzPqMLeVQLxOJN82cE7pPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623864; c=relaxed/simple;
	bh=md8g/94FjY5fnSYxgrTq6SdIHTdIUw0HnjE+VUQ+gjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPZzHaUnpxq/TM8Ae5S/iwGOnEatNZ93su0OdR84jHEo3gVum0+vGfIA9KmjApujpieMGDQLeJJHBf1lPycsXkvhl8IeZM02sjutDXt3SN+tjFofNfKOwT3DDhBOEJOdAJ3T8gRv3nKVXam9DMImFmyzSJ5Wa9yqHXza0v8kDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Tpp0cDlC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8Bs04q3114830;
	Sat, 8 Nov 2025 12:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2mcdB
	8RKVC58nibfdHMsa76GXXvaO/H6gJInDmCgFts=; b=Tpp0cDlCkA5l0DyYEErKX
	pn9b3v/xnDvtCcup0Zmb05gi2IzOkLmXi1+qCZ+xK4gkYTB9NqzjQMGSV/aMmLg6
	0uNCLoCINeqn1tcajH+lRx6tUM3m7lShsadyvSfo4MHGl/pUPV+pAJjswZM8Sad/
	B4p8FomoxiXvWjAI6TruHFiyV1J9Qf9XgNkovbeUffF3XyWRhSq/Qyf/h6cDna1o
	5bVn3MU5qdgl+7eyBdQvPv8ISGxPsuiorKyxRdLUORKgB92aWl69gJmxnP1mh/W8
	AK5Dylawa+vc2SDECQV9Au/EqyZmZhfw0hsY7bWzDtgTpTD/9DKDFlkk4QqnYbxK
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4a9xtx29s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 12:44:20 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5A8HiJvf010300
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 8 Nov 2025 12:44:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 8 Nov
 2025 12:44:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 8 Nov 2025 12:44:19 -0500
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5A8Hi4Xk028553;
	Sat, 8 Nov 2025 12:44:13 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 3/3] Documentation: ABI: adl8113: add documentation
Date: Sat, 8 Nov 2025 17:43:54 +0000
Message-ID: <20251108174357.3748-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108174357.3748-1-antoniu.miclaus@analog.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JJ590RVTyWCFeNZvy9IdTVexSf1ifmwj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0MyBTYWx0ZWRfX9K7z3YNNUjbR
 esFy1awTfWc0V8TjjEskUqVdRBgIQix0JLxwGcQ/qDudk+hH2tQ+GtfAon4urpieeoaZkMA9tDk
 lbOpKT98qXgGRHdlmQF+t5/WqFMjRsRvs7mbAlYfyKEBSHi8lMeEZ7Ao1mTLU/NtLotGHUvl2bn
 1+DiYQkSnRufSxLoJrFZUFjdNaEJxhS8Ts2JB5Dp79sdXCn8l/Gf6E1j4LzIfZ5fwJ40s6m/yiV
 wmXeh53hWqDAXkdKdT5LCMvitUaVzKxu+zy2WpYRuFdW94C2MbRKs3Sx15O5nnxr9c4za51eONo
 e0xnNG8m2lg5FzyzDDlFn+1xp4S/m6t2KVL/f90g3RxbdubIjEqB5q1FmNwpI7FOJsIoHlNck5V
 l5d+X+wuCi4N6y0vVDUvsJR0mh4llw==
X-Authority-Analysis: v=2.4 cv=Ao/jHe9P c=1 sm=1 tr=0 ts=690f8174 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=lgrdZ4WJZJCj7Phda2gA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: JJ590RVTyWCFeNZvy9IdTVexSf1ifmwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080143

Add ABI documentation for the ADL8113 Low Noise Amplifier,
covering the 4 pin-selectable operating modes.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v2:
- Enhance external_bypass_a mode description: clarify signal routing from RFIN to OUT_A and from IN_A to RFOUT
- Enhance external_bypass_b mode description: clarify signal routing from RFIN to OUT_B and from IN_B to RFOUT
 .../testing/sysfs-bus-iio-amplifiers-adl8113  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113 b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
new file mode 100644
index 000000000000..6e3994283a45
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
+		* external_bypass_a - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
+		  (VA=0, VB=1). Provides 0dB gain.
+
+		* external_bypass_b - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
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


