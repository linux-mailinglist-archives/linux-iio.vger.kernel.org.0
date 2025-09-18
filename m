Return-Path: <linux-iio+bounces-24264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6BB86431
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12CC171137
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777BE2F7ADC;
	Thu, 18 Sep 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LFQTbz+w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1F301034;
	Thu, 18 Sep 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217139; cv=none; b=W2O3jysgc9bZ6RgScjvPynEnPfq8KkTHimzKrwuejTFYjY0xSJ1JCd2tq+e6fqYPOf5VGZHQP6mWtMRvEELaKpdCtB0Iwlv/tTW14XFQ3OH1yHr90fXHC14I84Nnlb3q4fcsOqAfdWu9YlxU/Yp2/x3z3IwcpQqZxWREkKY0GsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217139; c=relaxed/simple;
	bh=9j3p70LeOjZHtgc4nzW37Pkvr0YysmLCdihtof0XofE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uK6jHzXzVHw4ds6w+0BT0/qM/85RnH9EWgdutuvvXDjp8qKKQLYpSN5yoDAtebKkFh+Aq/+oM49LPQrP66zPeipV021GCBZAzkiXP6C+cXCYgB0BvmavUoAdHtd0ZrrwLOYoOBekO9DM6j3DnaeDjMlipYgExFlW64QSaIv0wXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LFQTbz+w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IF9RSV022765;
	Thu, 18 Sep 2025 13:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=u76xt
	kjs/fr3W9ZnpnYRbPBXz/JB11Tk76lBIqXJgf0=; b=LFQTbz+w6+SlPtVua+EDW
	Cq592M+9eW2rrdujuikTHhwcPUNr+LPLiwfRjCkvGz7HGEP00/dT9b1mu1bfVq8D
	eDO0q0JeNGFk0jZ2+2+oYiaa1t1Szk6Z++lN/Mf3ntIJCJSl2RjjCdGDPikjb/WK
	T+FQAp7CkZhOvUE3tMpoUko56Lku2Rfu2fv3LrJtR0U6pjLxgCGdaIgyFRfADBb7
	nk14rDBGr9SnWTD9NK+6dr1+P8sbQPwU1fr9st+ObdAsaxSPbjIGCCGXAwh3Xd+2
	r0HV6HKmsILRouFItInrvFhUCDh/8M1wjZCPxln2Mhh9nSbFxveKtNNvVKly8H63
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 497xre7v15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:38:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHcq2M013778
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:38:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 13:38:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:38:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHcbqv022216;
	Thu, 18 Sep 2025 13:38:40 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 4/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Thu, 18 Sep 2025 14:38:37 -0300
Message-ID: <7a1a68a33769c69967bcffbbf7a0bdfec69516ed.1758214628.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758214628.git.marcelo.schmitt@analog.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KnPepnK2U_HdUYHw1mFHs3lo6KKFYGgJ
X-Authority-Analysis: v=2.4 cv=WZUMa1hX c=1 sm=1 tr=0 ts=68cc43ad cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=VV9VPHWj0pc-8j9jmhYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE0MCBTYWx0ZWRfX9t10MUhOSRxl
 ww3+EuGrri24aQ3X8yoh8+pjJ6F1AvoucNmzM7megwJT3xFrBM2qDr19N8f9qAU0z96Eb3O4ae7
 1RjuPbxnXxkV0663JB+XTFigWcuKcZ3SpaC064qbNu2QkGYft4wrYmbmSVRoOdx4Hc+PUngZ++m
 BNVaUR7WTDAVuNETwFI4YddrOefldMKvMTKkQYFVSNKKoLoxBaVa39FpX/EGgBDTqt+kicwR3Qr
 HcdWT6xUI5zPARZ/inLMQLMeSDWkk9vt4tnvQCBvqBmV6f18hbkJ7ZWTswOE2MZVZKOFsNYB3Di
 KKkstHCrQ6l3BZI+sGgGRgw4gYN145LWXnrnTWD5PNstI/ll0YMPPfkrNBK48zIS21X4JBXC8Ur
 5vp4sLxN
X-Proofpoint-GUID: KnPepnK2U_HdUYHw1mFHs3lo6KKFYGgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170140

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2
- Dropped pwm-names since only one PWM signal is directly requested by the ADC.

 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index a8fee4062d0e..564b6f67a96e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -64,6 +64,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.50.1


