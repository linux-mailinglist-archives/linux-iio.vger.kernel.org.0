Return-Path: <linux-iio+bounces-24469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC64BA5199
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EF3327642
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49430C63C;
	Fri, 26 Sep 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1LgQBPv4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07A2DC78E;
	Fri, 26 Sep 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919260; cv=none; b=MgLJVVupk1qiF2e/Ee+LgE9UPsTcL0XKYtvGBH9A35nJMFvs48Wl8pl/fIM3w6OHcH9nfUWFw5a36sm/dJtrTQWM2l2AN7Q/xOzcYX9G+UCmSG+CnkD+moRALUiTyJbrTPxjvDnORw2tbocZt3wgMIL4L1INkF0fpZ8GC/0/8Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919260; c=relaxed/simple;
	bh=WZ9Dsob8217rQMVY/2ETpmcz51DbclJK5tiSEfVxA3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEQ/aPEj8K3NB/o83bXds1LOjXK+QtHyBIlga4mPN0ledlf8CoyBgBr6ufRoC2w831oR6VGfttSbSYkjiK+y8GYRMujZDKksx9HZD7U9ySvpR99uTve38AOgk0ju633huytaSKh+Kv5cs2b5B2+NLFu4ZPB9a5D0RzrxGa61qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1LgQBPv4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QFsBXj019533;
	Fri, 26 Sep 2025 16:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S14ln
	y/Kcps9xDIlvxH1tzTzOuHDv/EVueka5mwTaCY=; b=1LgQBPv42VDgggcH134Ry
	cADrQHJb07EmkTlCBPGpu81NB8Fajte+QKAWNRY2I/fi15m/T2lw7Zfpc6isx4iY
	l07QJxP93iSRQ8GLyjQLXGpWuS9pjWT1qW/Hhmu6Rg/u8oPKfVR3RE8dFzUCq7ZJ
	GV4mzVrlu9NgCf9v+8jz5Yy7TMxLPVReZbl8Sc+VWvWToVEgzup59Ru9KtDQPiH0
	o8w9rypwxU74dZnf9i6eDunx0aB6Lh/b+34TSBMh3RiITshhXMQmf/ldvibClsAi
	TcHycQEBy50Q/Gz9M1pL15RrKBGST/m0HMQZiOQ7tHbgwD3FhPeSQU7HcrijnhOL
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49db1ef957-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:40:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58QKesfo006502
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 16:40:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 16:40:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 16:40:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QKcStR010296;
	Fri, 26 Sep 2025 16:38:30 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Fri, 26 Sep 2025 17:38:28 -0300
Message-ID: <6008c574fa60e73576984e4ba153816324f9558a.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 3nSZv5yfz0QCvHvsNmr4epVfVtWpo_8U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXw9KQplw4t7br
 epL+Zu4Hqn9mcUBovLFsRuARD475TwXnL5Mj0cOsabi4ohNLnyf7UX1iiXesGfjyLN2f2x3WM3+
 O1ISCFyVGeHU9N81WUXRAFSiAJrTc/56wjxkBahVptZdBdjhgRm1eZhlyz15olDDT6r9JNJg5Mq
 +HcyGEFa9vJq1rgkQZ7k+O7Zr9M/HYPAlfxZ9akdzavkr8HhnS3t9UscEtI2FDCgoTP1Psk5/pW
 71a6OE7h0xX7YryO4qbfTHMkPMCifFvDowfg6jMKL92fIOLJHLsVRLr5Rj6dkZpDLb8zT/B5tKT
 0xh7Lk/vSGsR40URWIYe7GiuLOX2sMuWrFRJTOlkjsMkR7NMdpHczA8aDX8AwRZDn00jJKKRNlf
 vmFLtbhBV8ZWTbn9SDJkU9uWDFcVdg==
X-Authority-Analysis: v=2.4 cv=YaGwJgRf c=1 sm=1 tr=0 ts=68d6fa57 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=EfQ9L3lKGMo9VN_2EekA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 3nSZv5yfz0QCvHvsNmr4epVfVtWpo_8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

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


