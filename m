Return-Path: <linux-iio+bounces-6189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C79050AC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 12:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D248D1C210B4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9B16EBF6;
	Wed, 12 Jun 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Un+7FvGk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80B16C685;
	Wed, 12 Jun 2024 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189229; cv=none; b=ad/Mk0Wmmb6TC1ioBC7Zcueef5q/gWkhf0qwz95SrwiCmaVECig1DrLzmT8mh4Uby2w/hhMPdAAQBIOkuoqlyR/quqRkyun9jSmu3OWyJHqiYv3RWRc3jDaonaVSgJpgsWx9Kl6FmSZoy+msFxsfpxqoGTZe/mdpt7LCue24Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189229; c=relaxed/simple;
	bh=zd9AtjFEjlHmHQUOMipqx9bNU+kz9GjJesmITD/EYS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J79YFKAIvFNiS43cqnYVgknKdJQTOIlWdVFuLWCHjk16R1Vi3N/x8Ar1+eyNPVPkmxCtiGcnAHTeRN2BULe2e8zY4GBopnZjSYSR50wdzp6cLFkfFc7nYSGtAkXINMHro6UQeMensF0VUhTh2w+Qr4cF0/up6U55TTM0j3SfFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Un+7FvGk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C3MMkg012392;
	Wed, 12 Jun 2024 06:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vGb092HVWL0tRAA0O/vkBKFBFUD
	t7GZaxz8NJaVybYw=; b=Un+7FvGkvfldPSy/uY0HCcHE63ZEj5dxSckjvm+p60y
	RUJNapsyHhTsLeohqJ81BgvYdpdeUlfG/TqPHclCoNFrd2YucNALHxpI1rhbYMCB
	/gYo57tFlpspBeZ0X7FUPjqLIZ2k9UsOXsf9oAS8rFsWPXvVm7QaYhcaOF5VgTZb
	627/69rsW6tslhfCddynrjgsSkAA25V4e57JeTsyEJ5jIeOo/wQ8IiYciA0zmWzu
	SgLJs/Ejq2WF1XicoJFjHhz135EgI/o7f4fKp+EQQiuAX7owyT+tBofJKDwLRs0W
	otBQnISO0NBlirdrXONUNPc1vt4NDG/8YmBu0ejIiBQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yprwjucbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:46:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45CAkp8V035539
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 06:46:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 06:46:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 06:46:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jun 2024 06:46:50 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.163])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45CAkc52009636;
	Wed, 12 Jun 2024 06:46:41 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adf4350: add clk provider prop
Date: Wed, 12 Jun 2024 13:45:51 +0300
Message-ID: <20240612104554.66851-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: _q4bNFpkaJ_wvcudPVNEU2UWUNzt5D0s
X-Proofpoint-ORIG-GUID: _q4bNFpkaJ_wvcudPVNEU2UWUNzt5D0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120078

Add properties required for providing clock to other consumers.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
no changes in v3.
 .../devicetree/bindings/iio/frequency/adi,adf4350.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
index 43cbf27114c7..d1d1311332f8 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
@@ -28,6 +28,12 @@ properties:
   clock-names:
     const: clkin
 
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
   gpios:
     maxItems: 1
     description: Lock detect GPIO.
-- 
2.45.2


