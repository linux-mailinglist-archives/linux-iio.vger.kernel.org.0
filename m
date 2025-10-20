Return-Path: <linux-iio+bounces-25285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45EBF3228
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 21:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E2518C0A55
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8F2D73B6;
	Mon, 20 Oct 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SSab23BI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8B2D6E6E;
	Mon, 20 Oct 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987638; cv=none; b=cywJcZJJorWefdR3lvk/yKHMtJ9JYmH2+f1MMTF6n9rzwFqiwtBY/1V6Xh1AfLYd4ISxUnw37R94VTilRtN3XeTtzlsubZX0cyUmLycgGcFbXyEBsjcjaflQ0MoRvt6KxnYSBWbxihcULGTaAyKBHpp5NASdM+II+MzRKzM5leU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987638; c=relaxed/simple;
	bh=WZ9Dsob8217rQMVY/2ETpmcz51DbclJK5tiSEfVxA3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lk4UJCWcrNVPbCtdaA7be9XyofNDLQ+PUKuEJAPZIg8FbReA/h/B65TGSL72tBlIbEF5jhQRaZEFDPaV/bq9KcSCobWnCCGJZAfa94OlPsUqpLanhqcwTEdtMpgFERleAikm98sKEwZns6TA395B/xftp8kM0hYsgyecvh5wKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SSab23BI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KIJaV6019043;
	Mon, 20 Oct 2025 15:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S14ln
	y/Kcps9xDIlvxH1tzTzOuHDv/EVueka5mwTaCY=; b=SSab23BIm3A/vTS4wGe/Q
	Om0QGP2eH5l9JN1LSmGnA17a5d/syefSdcNl2Sl9GzFJuEFbHn4BmZzZNk4Un7/k
	EAzPFXKSS0bOkceVm82E+F+GBZLgakLUGe6tWR0StIXQz9UcwPTwBDlt6C6gadQl
	IR5W2DLQ5/r1FDl2AAJuQiWEBiDXK6PrxoUaTDTT9wsElIJLMOa+luLFtI4XhR61
	LtT+8kZDHBYvOlixz2/RrX95JgFQ2z9+6/SSVMa6E24tc0vJlqiEP83jJM2MDc7Y
	V20uZVD6IkjTwBeEZFvza0+xCaV7RX1nAp6N4qDhcz0JmC+9jJWlVzURk7MHMDHo
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v4r4kn0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:13:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59KJDm7O026461
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Oct 2025 15:13:48 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:13:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Oct 2025 15:13:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Oct 2025 15:13:48 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59KJDWKk013262;
	Mon, 20 Oct 2025 15:13:35 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 1/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Mon, 20 Oct 2025 16:13:32 -0300
Message-ID: <c370c9e475da72001160419b8a3dcae0c6060ed2.1760984107.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760984107.git.marcelo.schmitt@analog.com>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qIG3TQVkfvyjmBrb58ua961J6ryy2X-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzNSBTYWx0ZWRfX2RwGF+Yf/YZT
 SRuDH/MZ+79HW9My6Iqtw4pjhJuSphuBR1b7oDVUhJHSGyOOk9qliXP0NelE41oN7SVmA51W0sb
 hltTQB4P67wizDKM0P7oZF2nVBBIwsPBwl2R/Fu9sb1q0RrLslOyHFgnCfXSpdWlnQ4UswGWkuT
 em68z3ywEqhXYG8noX+mvgjvjqSnCZgLpXiT1qLUP46I7hKY56YsaXpsbwqifgiBa0dXQsOvzxB
 FDGA+H4PMaeCk3wQ91U92GW9gVSOK/C664T1/XV54HPzsgdFQkLsT5QaNjFKKHlkRo0U6zbjTe3
 /lM/W8N+Axx3tO8zXBd9QfTYLsIiGSTnLwC137TmXdBLCYHgqLsN4Ts/G25HqnJmg0y1JGMuWJy
 AncJOP3/7bm845gm6EXmu4bNh/mkzA==
X-Authority-Analysis: v=2.4 cv=KKtXzVFo c=1 sm=1 tr=0 ts=68f689ed cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=EfQ9L3lKGMo9VN_2EekA:9 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qIG3TQVkfvyjmBrb58ua961J6ryy2X-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180035

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


