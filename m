Return-Path: <linux-iio+bounces-24262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E1B8641F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A357BD37D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224D31961D;
	Thu, 18 Sep 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aAMvcsI7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEA319601;
	Thu, 18 Sep 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217107; cv=none; b=ZDqGtCWvXCT9cLOX0VFhCTv3lMUmxCOdbqlT0RdxhftEcjshx7M5GuDkfX0eXSPvCbeJ7QcOys86aH/vNmRsumBhueGV1HzcP6gvrdJQjC2GZikE6fCf/Wg49YUvrXzkm61PM4KARe4gFDfx6cmaG/jKLBDmueuMRlVLaH0aDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217107; c=relaxed/simple;
	bh=aka+a1cMCdZ8q47AjyPaw4UMur/gZqvQs785CwPRIdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRv0NSDXonax4rgT1OH4FeU5hNrP4RdSsQAcALIW/qtj4WI4kQpYaGZI4/krhfYsCq7Gy+fpG+n0hUiKU4XHrhHdqOZyxvaZ1hovhATo4ExPiotgZ9d/L6SP7bC9+e8gXJ2XD3/EjCHqd/rohzK/ZTZw4v2YFnbmbzjmwGM++04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aAMvcsI7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGNcWA008734;
	Thu, 18 Sep 2025 13:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vEY8G
	obHsxaTMpairbl1i0iTGFO87IW0PeGzbVSM+Js=; b=aAMvcsI7wPkBB+UKRA5Xt
	2RPnpH+JxV4hWp5mLcG0JPs2R7BKD7un1jbPXGpVtud1RYY/eB1fCXlXRr0RZ/Rq
	DW0qbZEdgE3C+ygzix+AX8fj00mnij1Ga2UiEXlIAmLNqGZbgBE8qKXOtoZwU5zO
	HdM2u4f4bMudLYIXKP7MpsT+3eBtbo5ibjfxHHSdWtwn5drB5lG3Xt7p+BjAQzwS
	o+dbo+aVewEeZAFdDDfp9u45CnfGY8GPuehYjnIZUqaTbSAwWejbtkYwWuH3VZj6
	qxPbh/DgOJfIxEZ3daAUVBLKedwy8D3MuwbpkFLpM8co2UN4KymwFs3S7vHq+idR
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 497fxumee4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:38:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHcK3q013706
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:38:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 13:38:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:38:19 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHc4GO022203;
	Thu, 18 Sep 2025 13:38:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Thu, 18 Sep 2025 14:38:04 -0300
Message-ID: <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=cLfgskeN c=1 sm=1 tr=0 ts=68cc438d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=GdcMA79DVxPdcO9iM0oA:9
X-Proofpoint-ORIG-GUID: jSu-npRKkeIhHnYNaMLVXv8-9llDWSPD
X-Proofpoint-GUID: jSu-npRKkeIhHnYNaMLVXv8-9llDWSPD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzXf5fjqVArHV
 muT/3EJIm8SRxnTqLZlgPQlbg3QocTzL7fexlf8qr2oR8SRc0LAalbATM68qDFK3oYMzy8WIhH0
 2lHSHdtRxYXbGk+YVMZctMEPPnIQ+6I43JGXKwjv94A041dtiqN7Hvxkr1lWkuw7Y0lXR57piyP
 5YYHp+yIqO+enQNbvaXG4HQSWxlPHMZwoXSivaFCsWOZR2BWnayfmjQIIKJXd2bKtYh5moQG5nt
 w4YuTkuCkSq76tTlpgaaxbIkhcMERMiXu0Kand1wdCC7Hwz9glQUXppCW/D7UF6eVdmPED4twgD
 Wg+WpDU+zPNbcsRUMnseN1M41WOszEi6YeHfMqxPntsh9q1Qy/021M3I4gujLVKhPZN+RgW9gAp
 WkM0Qe9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

AD4030 and similar devices all connect to the system as SPI peripherals.
Reference spi-peripheral-props so common SPI peripheral can be used from
ad4030 dt-binding.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..a8fee4062d0e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -20,6 +20,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
 
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
 properties:
   compatible:
     enum:
-- 
2.50.1


