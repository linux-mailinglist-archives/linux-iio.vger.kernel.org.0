Return-Path: <linux-iio+bounces-26216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD1C5CF9B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 12:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D16A535AD1A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D5318125;
	Fri, 14 Nov 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FK7LCx1L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F13164BD;
	Fri, 14 Nov 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121549; cv=none; b=C84L9/ZccQL2f8RetmvpEhX2XTB9iy6za/X2AYdoMiIbln0WNeVz6JEBv7opYphrTJyFoV4dZWbpgO0J/DDY7jg5HuzaymG6eYC83+XRTMeHt+Ut6W9dKJ/xiperqpi6QhSHhg5mdKysuHBJJz3R0DTuRoXvatCIT4D3xM/0VDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121549; c=relaxed/simple;
	bh=chS5KKJaPztbPdIXVZ5m62FYLu/JYz0ViEuZQ1U7lpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4Zp3LybJD0a1l7DWgPPHN+SZbSwahjmPhjQbuzT+5PzSsqLeWqRo8ZrkG4qbBwUrxf07ekL7Jd4bsG5Ag3td/XAf3DjPIzPRyPKOdLBNdQ/6o/hfa/SHlW48PVYNSU5BDg5ZVeqfOO3oDwMMgEF6UQrDCHMurMe8WsPwpA0wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FK7LCx1L; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEAtU9u3284412;
	Fri, 14 Nov 2025 06:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U9e02
	7WOgqVWc/VJc/EDU47B3+WLKgCwbm4urOldRrg=; b=FK7LCx1LlRaFimQdUvRKK
	WXse57MfzhtI22UM2LDdSIKtXs9lDqW6rh7gor95w47vYylvwRietIxtx4RYsPVB
	v9WuVyuGkN942Z3aondcbSWJZBLHjpgKIeS+17wZ+N32MNn7z2dYo6weOvSl6Zdp
	VOz/gUecEk6WcO2ZQVSDVK31wwvjJ9C6uyoBzxPizkAsPK57tnpZyEq/fDPZoapz
	cm4Gp/SmWXisxtdCUE1HJo8RUCVzyH/W8F3rQTj1w9ERbifwQ3wbhmgQV87J+Jjo
	a2qFBTkjQ3uZvVIKSYgPsbDoGyJkmz8nqnJyxESwkPQMol1wRnCXkJaN1s0LI02z
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4adr7uud3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:59:05 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AEBx45m044611
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 06:59:04 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 06:59:04 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 06:59:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 06:59:03 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEBwodj018389;
	Fri, 14 Nov 2025 06:59:00 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 3/3] Documentation: ABI: adl8113: add documentation
Date: Fri, 14 Nov 2025 11:57:25 +0000
Message-ID: <20251114115725.5660-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114115725.5660-1-antoniu.miclaus@analog.com>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5QGvq9z8D9ZEh5lq1C2s-HjNG7ObN2n5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5NSBTYWx0ZWRfX0xTt/sJyG1Yw
 T0/LDFCYabcYP9wenlX8Cq1NnMVuFq6uyYmgeZefWMKEY1QsX+uggW394OS2YNkojDGldhEWoZ9
 RXi2tjpLKbbdPSOExGsbRTlOEFe/Dhgn0q6h1Xggb/8SjGpHOHUkXMZUXxYYh0fpn6fGL6lBu+y
 1R4w9ANmgZCd0vpqhLKJXRB4Z68Atxta+GhfwvT8/jaGFlkTIbuQ7oSjgDN1U2eUfjl5+wA0LiI
 f44NKrDTbaSBJGA4KSvgPDWBMGLghQOpnKL9YIL6v62L3RtBpBmIwM2Own2An9J4S5OpNiFKGiY
 I92OvGPvg8g6TrTDz7TBXV7vR79iWss6zmTGmMwZWFZeEZqxPtwhM271RtP4Agp5Ig+o2id5LzU
 ljWngt2PXqQY9AROa53P0nk5lzdC+w==
X-Proofpoint-ORIG-GUID: 5QGvq9z8D9ZEh5lq1C2s-HjNG7ObN2n5
X-Authority-Analysis: v=2.4 cv=NLTYOk6g c=1 sm=1 tr=0 ts=69171989 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=V4WCqAB441VHpSYF5VcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140095

Add ABI documentation for the ADL8113 Low Noise Amplifier,
covering the 4 pin-selectable operating modes.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v3:
- Replace "mode" attribute documentation with "signal_path" attribute
- Update descriptions to reflect separation of gain control (hardwaregain) and path control (signal_path)
- Add explanation of automatic bypass mode switching when selecting external paths
- Update attribute names from mode/mode_available to signal_path/signal_path_available
- Clarify that external paths enable connection of external components for filtering or amplification
---
 .../testing/sysfs-bus-iio-amplifiers-adl8113  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113 b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
new file mode 100644
index 000000000000..31fb1e6e80fc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
@@ -0,0 +1,30 @@
+What:		/sys/bus/iio/devices/iio:deviceX/signal_path
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute controls the signal routing path for the ADL8113
+		Low Noise Amplifier. The supported signal paths are:
+
+		* internal - Signal passes through internal path. Can be used with
+		  either amplifier mode (14dB gain) or bypass mode (0dB gain).
+
+		* external_a - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
+		  (VA=0, VB=1). External components can be connected for filtering or
+		  additional amplification. Automatically switches to bypass mode (0dB).
+
+		* external_b - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
+		  (VA=1, VB=0). External components can be connected for filtering or
+		  additional amplification. Automatically switches to bypass mode (0dB).
+
+		Note: Selecting an external path automatically sets the hardware gain
+		to 0dB (bypass mode) since external paths require bypass operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/signal_path_available
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading this attribute returns a space-separated list of all
+		available signal paths for the ADL8113 device. The available paths
+		may depend on the current gain mode (hardwaregain setting).
-- 
2.43.0


