Return-Path: <linux-iio+bounces-25072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEBBDB9E5
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FF7542723
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7D30DEC7;
	Tue, 14 Oct 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jXz4OV3M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD430DD34;
	Tue, 14 Oct 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480489; cv=none; b=YK7hMC0ZZT8RS/1taQoTwKzQdaaBqhhXvRFIAyMP4LJkp874oALWXQ6hktRiJvRv1p6+drqRfhrOz4zggQYFq+HCGPX3jUnZo3C+2CxHNqjuwrYANbBEDpa8BGSO9AlFfiVDLRdHePpbt0zCYToljO71RwVcP6z9NKYkLs33mO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480489; c=relaxed/simple;
	bh=WZ9Dsob8217rQMVY/2ETpmcz51DbclJK5tiSEfVxA3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1ElNPpeP47296TbZp8d5toz+lNSDaGK5O+N469CiQCLpqj7t1a8RlV0Xpo+GG0T7aSaVBTlzdIiKhoXjj5xqOT9VWbz3ORsqpLTlODhrErj/52nQtvsmXYd/zRaSzFWZA02n6oF+YBxycli4GjR8+iiGpzs1bWI4GHLuPZhzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jXz4OV3M; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EHxrPQ008518;
	Tue, 14 Oct 2025 18:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S14ln
	y/Kcps9xDIlvxH1tzTzOuHDv/EVueka5mwTaCY=; b=jXz4OV3M4jV+WOziVpS+H
	uBQiK71dkuzbp5tTg+LAYu+n9p8lOdJHK4o+FHAO3FPCnCg0tG4W0wOY3W3h8L6x
	qQryfJUSPCan9H6lgZkUg+JawNa+rLQm/qv+8DCchiEsL6REQ8J/JrwJTaC3FHzm
	RSDSXHMvR7urVl2wMmDJCDYMhiJxJc2GZq283bqXhz0wbdTsmT7wZC4gEu+61oXh
	tyAdFIyp1iDOgd6tSPwl8FyfnRokE0EyovuXY3zIWDAlyYaibslvIXKVWXtjKX/Z
	ijp25HECNxc8EY3q6d9UhDhyApPMtWF2VYZi/QOu2DUUYzCopOU5n/yK72c/bJPc
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qm50kr61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:21:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59EMLLUj042718
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 18:21:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 14 Oct 2025 18:21:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 14 Oct 2025 18:21:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 14 Oct 2025 18:21:21 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59EML7EM005492;
	Tue, 14 Oct 2025 18:21:10 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 1/7] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Tue, 14 Oct 2025 19:21:07 -0300
Message-ID: <271cdc2dfcb46c12362085a86cb86a91bc0b8ff6.1760479760.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cJ7tc1eN c=1 sm=1 tr=0 ts=68eecce3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=EfQ9L3lKGMo9VN_2EekA:9 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA0NyBTYWx0ZWRfX0tlZb9Le613N
 4cb0EMRS1pz9KLRUuyoU2E8+PZTmLfU9EnRm8T3YsaDakw+umiEVnW0LgNqZqKTacWcRDD/P1sA
 tl10q/7gr5j0ZTdRkHFQ9v/636qJqfVkUN2jictpkkaDvvWhAJguRO+WXrcx5vSJRdiXKpLusDm
 4h7ANUtMw+LDVj25mQLVVFDTWxqiyWkX6XES6YQx+n/6aa+E4MqblGo5fuFZXcYYTYLIf4S1IHk
 6VkkFJqB/HkQumK/xEPRNOdHB61HF+t/MmnC7g7G9vzyoO0sRfe88TWBT9ylOdATbzDW9emsYjr
 Amh6WTsvzt5PzjV4cnNhx2PPmXAwEHnLuOk6TFensuQQmyb/1HtTradcGYnVzDgCvubsTbPXWWr
 rT7h8xLwUaFMVSJ6GwwBUkV2Mw6psA==
X-Proofpoint-GUID: Z5I6_aPGu_-nSXiOlB9cnZLu5krdA-pL
X-Proofpoint-ORIG-GUID: Z5I6_aPGu_-nSXiOlB9cnZLu5krdA-pL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110047

AD4030 and similar devices all connect to the system as SPI peripherals.
Reference spi-peripheral-props so common SPI peripheral can be used from
ad4030 dt-binding.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.39.2


