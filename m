Return-Path: <linux-iio+bounces-24630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DACBB0C6E
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00D34A03D9
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F502AEF5;
	Wed,  1 Oct 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UVaQnPrZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B972626;
	Wed,  1 Oct 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329922; cv=none; b=J9/ZAq6vl6WjsJI5BHkmw5hkTYeTNPVaxgs6Mh/rxsLD3CYVmeuEsQ+jB/ku2In5eOOVMoCWsXSDLmgtzsDZm2+wl3tHNqs4yk35LmuzRXXZL7UNDbShnoRe8vWoEsOgcBUrgBzFZ8gs0UbNbRqjUAXvEGIFzYgNrzrh2HZQtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329922; c=relaxed/simple;
	bh=1gg0DoGoCQi80YyEqUnE4s+oGo8+kcQJ4QckiNdWwCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4seSxmVcsoUkieM1Ro69T+5midRjuvjL+NSy0Lbe62zjC8LsCNcL1tM+sBkSJxEFWsJHvz7v5CX1vleA+lq4UnrVYeWtgSI5Ak+DrsmMdA6NZsBqP9tMyX7wy7Qg23GKQ3p1Fz6Jq3hCNQ83FQj+b+amRgk9ToLZLa5UMWwKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UVaQnPrZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CxMAW010564;
	Wed, 1 Oct 2025 14:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xH8/d/Pd7JhrTL4O5vfuKAguxflwb112mAzbS4M7L
	UE=; b=UVaQnPrZv4p23XN7VQQfxHM4nCuU/SHw88OQWMG8lNX9G7PB950M/c2Oz
	jd+hnqB+5iLf3nZsiqmrVM4Jvf6A5dYKIN+1viwOChdzSXaU8V/HijVCcCyHdDZO
	5IEt8qvTYDg0ivhKoDWqXBFXMgR9VfDHTEmPm8Z5UhrLrn58TC5Uxx2T+1n9Tviv
	XTDmh6SumHpYVTGlZofrJu6NjUqeLyO0lfv19YI+uxVg7T67DMSXNz76yhSjRUHT
	Xwj8YaFamxRK0+ulMZAqCzEWotCuD2In0BCOHSF9rHS1x96gkMHTTEDN+UYw1PZg
	1tXvKFYLLluyosgiG+s0dN2qvDd8A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e7g5h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ck7Qe003599;
	Wed, 1 Oct 2025 14:44:48 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy1dh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591EilwN19530336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB9D58055;
	Wed,  1 Oct 2025 14:44:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CA3458043;
	Wed,  1 Oct 2025 14:44:47 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:47 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 0/7] ARM: dts: aspeed: Add Balcones system
Date: Wed,  1 Oct 2025 09:44:34 -0500
Message-ID: <20251001144441.310950-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CMC2hCLar303clp7FU2UQeCFdXAZfWrH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfXyffcH7rZVZjd
 0/REGw9bsObBHC20urF66w8YyuzD4xLLU9R7yYLj4U73OCZ1qVaWtIbd8m/298sO6XcqvYCnnRv
 dvHk61nHIRUQLmSJu82x9AZQpqPj0AiOl4jA6yIhhd7Ctd/VAgZzqO+Bn9RoxoZ8e546vO7Oylp
 rTQtOItqp6tJjdYSOsRe4DqxWLj6pdZXqB3QCvdKyDeNIGlH70NhQmX9C6vmzOI/p6V9SP2Uncs
 lkoQcEqCQFpALpOa6olypIQmFR20QOu2XBg4fbxqvSqPk+hCcYUr8C/i2H/atPgbMt92dhLpbBc
 xyisnnAaVxcJ5gpatqWvpXlp5eLF7EBWh4BiRnmjF5qZXBtf1bYMo5x9VMb61WnPQteO7IQRfak
 YPqkWANIMfoBAGD5B9fDNq5u6VSZ1A==
X-Proofpoint-GUID: CMC2hCLar303clp7FU2UQeCFdXAZfWrH
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68dd3e61 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=Hy7NEVtaT5kuqzZ1rwQA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

Resending this series to iio and hwmon maintainers too. Andrew J has merged the
dts changes with the Aspeed tree already.

The Balcones system is similar to Bonnell but with a POWER11 processor.

Changes since v6:
 - Remove un-documented fan properties under max31785 nodes
 - Change fan-x to fan@x in max31790 documentation.

Changes since v5:
 - Add patch to add address and size cells to max31790 document
 - Don't remove address and size cells in max31785 fixes change

Changes since v4:
 - Add patch to fix max31785 warnings
 - Add patch to fix missing Bonnell documentation

Changes since v3:
 - Add max31785 to the max31790 document instead of to trivial-devices
 - Fix minor formatting in dps310 document

Changes since v2:
 - Fix a couple of incorrect i2c addresses
 - Document dps310 and max31785 properly
 - Drop the UCD binding documentation update, it's been fixed

Changes since v1:
 - Add all the ucd9000 driver supported compatible strings
 - Fix node ordering in Balcones device tree
 - Improve commit message to explain addition of ibm-power11-dual.dtsi

Eddie James (7):
  dt-bindings: arm: aspeed: add IBM Balcones board
  dt-bindings: arm: aspeed: add IBM Bonnell board
  dt-bindings: iio: Add Infineon DPS310 sensor documentation
  dt-bindings: hwmon: Move max31785 compatibles to max31790 document
  dt-bindings: hwmon: max31790: Use addressed fan nodes
  ARM: dts: aspeed: Add Balcones system
  ARM: dts: aspeed: Fix max31785 fan properties

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 .../devicetree/bindings/hwmon/max31785.txt    |  22 -
 .../bindings/hwmon/maxim,max31790.yaml        |  22 +-
 .../iio/pressure/infineon,dps310.yaml         |  44 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
 .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |   4 -
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |   8 -
 .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  12 -
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |  36 -
 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
 14 files changed, 1456 insertions(+), 855 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi

-- 
2.51.0


