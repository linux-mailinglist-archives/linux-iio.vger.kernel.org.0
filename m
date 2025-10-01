Return-Path: <linux-iio+bounces-24636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A2BB0CB6
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE4E3AE366
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF030507F;
	Wed,  1 Oct 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YNM7Kiid"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCB3043BE;
	Wed,  1 Oct 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329929; cv=none; b=g+JVN1klaVASc7z/QBDVOoohDz76s/ZuR+gHOp/xX5ci7fnnCoFAq1VBDFAQ4kf/PgfsTG6BEctgkpC4F4NgAZZ4Gi34XU/aARJvF1kGlYrY9CIFGWR5E56KcqlTBs9+4dQYzf3TnGSvQuxp+OcVEfW/ksuOnL5h+GGwVCu/Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329929; c=relaxed/simple;
	bh=5954l7LU6fPIBRtOlT4gDpqEUKsuwLeScmgiPh7owZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8qPrquVCzo/F5vsJdqOmDdqdoLhHGBID2UeOIci9K2nD2Lk9tMHrUXFKByFXexqisjp6Bhfi+AlhwdNb5ukHkXoSFiIQ441zUyNg6Jsr8WngrY/eWdu/AAEW3fkKxMVyL6wip50Nniz4+MPkgrKo8wXaqayfnkMwGLTXyfuDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YNM7Kiid; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591DAuWw031961;
	Wed, 1 Oct 2025 14:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xU/mKPOxpYgMlnUyj
	4Zgu1OyckkeAGsJNFbd59wLYNk=; b=YNM7Kiid6hTMxPYmygWz8i7YgbsXhle3Y
	Nyryn6ju7bTt0ZsFEzDkE+PgoLVZn/RajhGg25cptQgXo7WAid3zX5JB8dFFX9Ec
	70Elln8gaxR9Y4dWBh3pqIJZlec+xI3DVMEp1PVxC/Vt8KDuWFgyw0yASAlH35dR
	shVlndvEsiK1TbdIw/rC6CyXFGk3LXM1UldEFJ3w2/4L90ZaB6IJifbnH97Aa1IP
	dPE6Z28yi6ystOG64oOA8DY7EsNcoLODeb+FZhRK5InlIiNFfIcp1GI6ZGWPpKNn
	0VGBoXQg/qfVHAT1WY6pO5JBSasIuLZ/C0FDO9ckJnVhrFwUpJUIw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwq4k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591Dt8qk001543;
	Wed, 1 Oct 2025 14:44:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfj91hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:51 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591EiouE6357688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9103758043;
	Wed,  1 Oct 2025 14:44:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DED35805F;
	Wed,  1 Oct 2025 14:44:50 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:50 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 7/7] ARM: dts: aspeed: Fix max31785 fan properties
Date: Wed,  1 Oct 2025 09:44:41 -0500
Message-ID: <20251001144441.310950-8-eajames@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXwcxK+Lz/Qj/B
 70f8eatWzwBnFqINdGQGfe6CYGD8q2GP5hdkWHfiNdE1aOOfCm7Jj0gVCLXNldptp/OTWk3aVPf
 VlR6N31HSgtLw/WR0bWzo9hMgfzqV3eJT6A1JXaX7mGpvzXE+ldY+3E78nYmI5BXmHqjbB/MpD0
 AIl3JqirCdYxGWAWDRymThC7nj1AWUaGXK20NMxEDPEg+nZw+R4wpl+VPPEck+PYp4soC+C990I
 f7hBChQoj0TBr7VWAJLPhKKIqys+bnR3eQEmbd1i99+diG16ZwePzx0UjM/ssaO22MOr3fUtR7X
 nkjm2Hl52Wqh5dPKsWy0Gv2aDSNNKvFX5NobVLtjBtPH6s6Tr9AU4GZfwni1L3WRheEIRTXcUt1
 7kWw13J6ssWvbNFLlBt1WcE3GiqJVg==
X-Proofpoint-ORIG-GUID: 8q2E8dPlqfZ3S2V1g3I4VKTNAUSimI6E
X-Proofpoint-GUID: 8q2E8dPlqfZ3S2V1g3I4VKTNAUSimI6E
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dd3e64 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=Kt26cSGSbpyySZw-S6oA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Remove non-existant fan properties from max31785 nodes.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |  4 ---
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  8 -----
 .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     | 12 -------
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts | 36 -------------------
 4 files changed, 60 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
index 2f5d4075a64ad..a37399ff3cea2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
@@ -277,15 +277,11 @@ max31785@52 {
 		#size-cells = <0>;
 
 		fan0: fan@0 {
-			compatible = "pmbus-fan";
 			reg = <0>;
-			tach-pulses = <2>;
 		};
 
 		fan1: fan@1 {
-			compatible = "pmbus-fan";
 			reg = <1>;
-			tach-pulses = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 9f144f527f03b..5a0975d52492c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2066,27 +2066,19 @@ max31785@52 {
 				reg = <0x52>;
 
 				fan@0 {
-					compatible = "pmbus-fan";
 					reg = <0>;
-					tach-pulses = <2>;
 				};
 
 				fan@1 {
-					compatible = "pmbus-fan";
 					reg = <1>;
-					tach-pulses = <2>;
 				};
 
 				fan@2 {
-					compatible = "pmbus-fan";
 					reg = <2>;
-					tach-pulses = <2>;
 				};
 
 				fan@3 {
-					compatible = "pmbus-fan";
 					reg = <3>;
-					tach-pulses = <2>;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index c5fb5d410001b..e90421bf7e3af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1080,39 +1080,27 @@ max: max31785@52 {
 		#size-cells = <0>;
 
 		fan0: fan@0 {
-			compatible = "pmbus-fan";
 			reg = <0>;
-			tach-pulses = <2>;
 		};
 
 		fan1: fan@1 {
-			compatible = "pmbus-fan";
 			reg = <1>;
-			tach-pulses = <2>;
 		};
 
 		fan2: fan@2 {
-			compatible = "pmbus-fan";
 			reg = <2>;
-			tach-pulses = <2>;
 		};
 
 		fan3: fan@3 {
-			compatible = "pmbus-fan";
 			reg = <3>;
-			tach-pulses = <2>;
 		};
 
 		fan4: fan@4 {
-			compatible = "pmbus-fan";
 			reg = <4>;
-			tach-pulses = <2>;
 		};
 
 		fan5: fan@5 {
-			compatible = "pmbus-fan";
 			reg = <5>;
-			tach-pulses = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index b31eb8e58c6b4..6fe7023599e88 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -481,55 +481,19 @@ max31785@52 {
 		#size-cells = <0>;
 
 		fan@0 {
-			compatible = "pmbus-fan";
 			reg = <0>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 
 		fan@1 {
-			compatible = "pmbus-fan";
 			reg = <1>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 
 		fan@2 {
-			compatible = "pmbus-fan";
 			reg = <2>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 
 		fan@3 {
-			compatible = "pmbus-fan";
 			reg = <3>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 	};
 
-- 
2.51.0


