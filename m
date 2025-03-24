Return-Path: <linux-iio+bounces-17237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7FA6D90F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B54189028C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4CF25DD02;
	Mon, 24 Mar 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nOHGIm21"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B211EEE0;
	Mon, 24 Mar 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815449; cv=none; b=UbADBDWRfSYmj/ajM6HgX6cf8PzNDzwh5KdgKeQ51LmJPkQ/BHk+wZN/u58e1d0Ial6BoaBXyZSfthMF4fM+AuCqomobCQnGyaRlHEx6/EZ3MzJrTfwN9ISMonBqbIecmzr+xanF/l08OJgDDnLGoTCDMa471ndzvaxzjKEKjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815449; c=relaxed/simple;
	bh=0t3+RoY0LigkPiTbfM/nTM5FzSBZdbGY+aPCdynnMOo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=t7DAcPXTXOFavo4daRuEKAgFga0r6vJQqgXx2Yr7E36ThKPdcpv/zfmMmSCu2+1kh+H+y5bHQrwjF+0g+q5IwPy1FE+6oC+jJeeqFytQmWU1gJClEbK3Pf4fsq/It2deS/NvHFWG1AkmhWpj1wYkFwexMb1x4M9BXvVU+Qw5gQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nOHGIm21; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O8CXFp017889;
	Mon, 24 Mar 2025 07:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=48DdnN6DF0JrUeBD/I3LjvGLS0F
	v2oAp5LC/oUIFVCs=; b=nOHGIm21JSCnjXgqQ6P++38bCxZnzJ1TafmSxzQnc0U
	5InTSwri3wgukO1wc+pdjKFncJ15k6JQFISpKHKG919CAXIwCIxqkJs9VkcQCFlp
	O2gizdGkerfDrBUOoSM5UjpLYFDT1fg4luD1ieIVt8jqbO7BT9KiGigV6cHWbeIS
	ApMm4lhVOVF166eujIpXJ6OxJIztTLxJYSZCSPMWTTIRp4f2IIf9CqeMH9BriHwp
	mLT4i+AnvSRbniM2vKlt1g51bPjjvet9mwEr+KRZ4NiM+oMKKHs6/TFcafBOEIB5
	hUQKuD99z/awd46Mc01RCKPVCmjX1W1Ayb1/pF4/Ecg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45ht4aa6fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:23:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52OBNpHR052238
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 07:23:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:23:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:23:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 07:23:51 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.117.223.46])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52OBNb9g007643;
	Mon, 24 Mar 2025 07:23:41 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v2 0/4] Add driver for AD3530R and AD3531R DACs
Date: Mon, 24 Mar 2025 19:22:54 +0800
Message-ID: <20250324-togreg-v2-0-f211d781923e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI5A4WcC/2XMQQ7CIBCF4as0sxYDY9tYV72H6WICAyVRMNAQT
 cPdxW5d/i8v3w6Zk+cMt26HxMVnH0MLPHWgVwqOhTetASUO8qImsUWX2AmrR5Jkp1GxgXZ+Jbb
 +fUD3pfXq8xbT53CL+q1/RFFCCnPFvqdBokU9U6BHdGcdn7DUWr/fCXfOnQAAAA==
X-Change-ID: 20250319-togreg-fc6a0af961ed
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742815405; l=1985;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=0t3+RoY0LigkPiTbfM/nTM5FzSBZdbGY+aPCdynnMOo=;
 b=zDxY2U9/cRX3MgtUFj/QCf/O+dgp2GwyAq4gweZHq9rlCehbdM0t8lTsckAW4DX4oVascpwug
 L23MpgHeGrJBJ9SY2XlJjgJ8pbruBaOjtuzYlxeWpwcU1EXof4/+9EP
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oZ8ozqMWhqglxQPahPcjXdyRx3d6zFH2
X-Authority-Analysis: v=2.4 cv=YNCfyQGx c=1 sm=1 tr=0 ts=67e140c8 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=Bz3p57LwOhYugZDU6K4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oZ8ozqMWhqglxQPahPcjXdyRx3d6zFH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=959 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240082

The AD3530R/AD3530 is an 8-Channel, 16-Bit Voltage Output DAC, while the
AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC. These devices
include software-programmable gain controls that provide full-scale
output spans of 2.5V or 5V for reference voltages of 2.5V. They operate
from a single supply voltage range of 2.7V to 5.5V and are guaranteed to
be monotonic by design. Additionally, these devices features a 2.5V,
5ppm/°C internal reference, which is disabled by default.

The AD3531R/AD3531 is not yet released, so the only available datasheet
for now is the AD3530R/AD3530. The only differences between the two is
the number of channels, and register addresses of some registers.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Changes in v2:
Bindings:
- Updated commit message.
- Changed adi,double-output-range to adi,range-double property.

ad3530r:
- Changed data type to __be16 to resolve sparse warnings related to
  type mismatches.

- Link to v1: https://lore.kernel.org/r/20250319-togreg-v1-0-d8244a502f2c@analog.com

---
Kim Seer Paller (4):
      iio: ABI: add new DAC powerdown mode
      iio: dac: ad3530r: Add ABI file for the AD3530R DAC
      dt-bindings: iio: dac: Add adi,ad3530r.yaml
      iio: dac: ad3530r: Add driver for AD3530R and AD3531R

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +
 .../ABI/testing/sysfs-bus-iio-dac-ad3530r          |  68 +++
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |  91 ++++
 MAINTAINERS                                        |   9 +
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad3530r.c                          | 586 +++++++++++++++++++++
 7 files changed, 768 insertions(+)
---
base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc
change-id: 20250319-togreg-fc6a0af961ed

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


