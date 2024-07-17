Return-Path: <linux-iio+bounces-7651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADBD9339E0
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE15B21D4F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAA23BB50;
	Wed, 17 Jul 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="G0A/Cn4H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAA224FA;
	Wed, 17 Jul 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208689; cv=none; b=m0ve3vZHFOdcj3z0pSbykpTTSelaOzjAPHbiBFsQAxsQIx1OaDzi0H+0Jv9Afusshb8Z5P7+GjaEmiNmi8iVuMoWivi6aIy0ZXGIZcDqoRt6GavJ0ZpR5ewLDufo8wqK3RIZiws9+gKlnXMaSHJxitrtodElwTiaD8oQ2G72vBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208689; c=relaxed/simple;
	bh=gAazFzqaZ490cAM+4rusqktMnOGrVW3syFYMSlYhewY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z8g0rD+Gr8KkiE2uChuB/KpcLRjHMK6F8ZJm/OE1DOkFsJcMjT5fClGjX/+Le+HDHPOhxKlzQE4t+9ZVxm51jhhELzjXM6sJ6F4npOx2AuO/VJwerdZtfbHol1uCvtGv6zmnFc2LHmYEC6BicDgyjzDECkf2YwAYD7ChFVlyBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=G0A/Cn4H; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H7Fdtd016944;
	Wed, 17 Jul 2024 05:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=iTbjNWS7Men/pAjIpZVN9E5gy4p
	NyB3vaVa0VE0do4k=; b=G0A/Cn4HGu3fpcXBlBRlEa26lSdR0RrfrYb5yhcXbr/
	/VTC23cRi/VuRtyTW8lzULdpEQSz28fRYq1Xx0OX+DA8i8F+Et0Au/EHnlN6pknl
	rmCQRgH8D1aDNb5vfQd31LOGxG4UsdntRaKRxgzRx3txx0aN7M89VK9A4MQR6qWN
	/0TFYafTzAEMeiw1dIAVKL9cgFQjZLAUucblC9Nam6oDNJ+jbDSA+Uztn9gN9rDd
	mcvRfJL6Td75RVMTDu+WiWxOshRMTpww4uZnujAcx7imJeYzjPIWZj5E+K0VV+yE
	XolJg5emh+tPebu+7SAIemNlZvgyOdGBbFgm53krp7g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40e9dngd3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 05:31:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46H9V5CD039713
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jul 2024 05:31:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 17 Jul
 2024 05:31:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jul 2024 05:31:04 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.170])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46H9Upnt010792;
	Wed, 17 Jul 2024 05:30:53 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: adf4377: add adf4378 link
Date: Wed, 17 Jul 2024 12:30:31 +0300
Message-ID: <20240717093034.9221-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: C69jKqTsphyNsIWyvVxZeR5zReWC5g_i
X-Proofpoint-GUID: C69jKqTsphyNsIWyvVxZeR5zReWC5g_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170072

Add product link for the adf4378 part.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
index aa6a3193b4e0..902081b83447 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -17,6 +17,7 @@ description: |
    applications.
 
    https://www.analog.com/en/products/adf4377.html
+   https://www.analog.com/en/products/adf4378.html
 
 properties:
   compatible:
-- 
2.45.2


