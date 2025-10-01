Return-Path: <linux-iio+bounces-24635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06739BB0C9E
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6487B1545
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33B304BB2;
	Wed,  1 Oct 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eFB9ZP7m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D49303CA8;
	Wed,  1 Oct 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329928; cv=none; b=LI+L0Qut1kkNlcwkphj44rawqmoPvNcgD4DJZOWnH4JgdwQNyuhILsAk5oxrvwWeR/fuuhboNNFpAQV7xysucuYo7fNT54TaQIk9z1e+fZnphPsHU3BFH541UXEmNgTRav0c1ycnX45RHuk7Tbb8Cjax+jkxqAy3iWPttv8gzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329928; c=relaxed/simple;
	bh=h2ZwpYk9s3ImBK9jTtfdnC5Ej2jHHm9lP9OuSJWUSxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHrqpn1cqIUnZurSel4GiJ8PwVWnvBUYukM3ytDsyiR37a3T/57CHeTqjog28GeG9coGJ3bdI3+yer1d6YWTxcSZj9aszZljwJpSx3wV/OTYBIwjswbpiGO69NqXQlmNu6tukGcfbueFHFbXIXhtbOtY0YXKnA5lJFJyEnMibuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eFB9ZP7m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CwGgn009676;
	Wed, 1 Oct 2025 14:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A9OzHSyflbyykrbW7
	EYr7qpVvkpsCbwn1hOnR4XSlWE=; b=eFB9ZP7mM68RAt+eZPx5GKx9qpH2tPpk2
	YQrgc46zym393uvjLwwV7ZequLR5nci07oJh9+KP9QH+ProowP3NXJSoucr/AAn0
	Cm5Y0m/+8tVBgAsSmJPYv68kMXs50LNhqu08D8Bn8xhsp1eAJO1suCvjkVKzq3PL
	32XVRidE43gmZqHoh29vgvuxnxX3bDudGPBL2ehqdKgVlpvgDgFoRLcTKTc4SLSP
	xZ8hq2e/jc9pxkhAhw9SzvxYpeqE5K5G5QeJSfR1IeEM4DLLNgV2uFZIn7Ok09rh
	R55h7pM5fJfO6zITUcfIr254to2ea4UjEI5p5V7sSD4pV1NdUd5OQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqyjfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591CqTM9007321;
	Wed, 1 Oct 2025 14:44:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk16y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591EinYK27918996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6572158043;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13E9758055;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 4/7] dt-bindings: hwmon: Move max31785 compatibles to max31790 document
Date: Wed,  1 Oct 2025 09:44:38 -0500
Message-ID: <20251001144441.310950-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX1VuNlhU9hEhT
 g+GNf/vio3WH1it7r3F28rVtuzwcwjmCTX5H5XuJdpMqKneBqJTdwRoQVYAmsUYNLiB0LHnZlOJ
 dG2+z/NvLOy35wzkXG1gtPSblOPQfIkbHNz6aKjxsvBTROHckhSEziwTqf7YwxjQ2hHzgIGIhDn
 QLUxGYtUHAJdSwJH8QOjp2sVvOf5quh7NcFFl8E5VOAlGo8VWHUjtcULa5ZPkzK1Qb/UIj14eZV
 OyomVNRqSNxXICfSQE5EDiUCDntDsZkm2FCG2nSzD0y5KpSreZ1tn9chdNDU0wjs9kcYrN5arkx
 8FaSiPETjSYfny6oVOqvpopb9fq/AFEAYFw8U4rKzc5JKbxZ/32aFZgpJ4diLh728eMvA0jIeMt
 zQ3OR3OtqE2lACneKtQKk3l+Ouaz0Q==
X-Proofpoint-GUID: UdEteioiqY0HWtV7B5T9id-JXu8TddFE
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68dd3e62 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=jtbBNqsHAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=brXxiGoeIixPC4QSiM8A:9 a=RWaeYqt-Cn-VcsFsiLGo:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UdEteioiqY0HWtV7B5T9id-JXu8TddFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

The binding for the max31785 is the same as the max31790, so just add
some compatible strings for the max31785 chip.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
 .../bindings/hwmon/maxim,max31790.yaml        |  6 ++++-
 2 files changed, 5 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt

diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Documentation/devicetree/bindings/hwmon/max31785.txt
deleted file mode 100644
index 106e08c56aaa9..0000000000000
--- a/Documentation/devicetree/bindings/hwmon/max31785.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Bindings for the Maxim MAX31785 Intelligent Fan Controller
-==========================================================
-
-Reference:
-
-https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
-
-The Maxim MAX31785 is a PMBus device providing closed-loop, multi-channel fan
-management with temperature and remote voltage sensing. Various fan control
-features are provided, including PWM frequency control, temperature hysteresis,
-dual tachometer measurements, and fan health monitoring.
-
-Required properties:
-- compatible     : One of "maxim,max31785" or "maxim,max31785a"
-- reg            : I2C address, one of 0x52, 0x53, 0x54, 0x55.
-
-Example:
-
-        fans@52 {
-                compatible = "maxim,max31785";
-                reg = <0x52>;
-        };
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index b1ff496f87f95..b2dc813b1ab44 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -20,7 +20,11 @@ description: >
 
 properties:
   compatible:
-    const: maxim,max31790
+    enum:
+      - maxim,max31785
+      - maxim,max31785a
+      - maxim,max31785b
+      - maxim,max31790
 
   reg:
     maxItems: 1
-- 
2.51.0


