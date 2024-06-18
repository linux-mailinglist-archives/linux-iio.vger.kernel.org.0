Return-Path: <linux-iio+bounces-6474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04490CB04
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78EF295064
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559FA13AA53;
	Tue, 18 Jun 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="S/tXZM8/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C213A3EE;
	Tue, 18 Jun 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712070; cv=none; b=LV4J198YV8COt1qSaLCTQ2gfGc8Jiqom1d1oIIZtD1YzkCIe5qxFEXtxajO2ociDzcoblFx3PuZVp7aksVt3/fPQy6/rqucofjIWclmWYgFY4s2BCEIlDyVglbiYmVGUpsN6VYIOCER8ttf7nk9FkBw1aFWx+SlOq5PVQqqw7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712070; c=relaxed/simple;
	bh=jc50N0RnVWNFD2GgL6AtQC0sltoDiHKgy3x3xfHb+ew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9Ep1/kzaEULTdPTLAjZILfIrSNiEqvgjNO3cJvdihl5V5AtZjB/N9aKKArHxQlUI2CMIn3zQRgLkqSsj80RV/cTfjLNUu1Lu3lyaElndzr6ZDICmniRhJsLDqZCeTvGUglUHNsdryb7mcMMkQotN3QiMeMsDkyPgDupYHMHQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=S/tXZM8/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IA2Cuf014186;
	Tue, 18 Jun 2024 14:00:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=pRncs9djhWB9Ja92W3g41f
	UBElkvpH4tn5xTWy10eG0=; b=S/tXZM8/EV++30E8fS2Xvuf5Z0QCJH1k5K8+Ri
	8pgtJS+4aBG+qT56h/wb62Zh9qFZS6ZpM3AYtfqQfmRvCJC+OUudFZSnYzxBTV5A
	OPWgbBc16XtxSPw6+Eqj7IkhNMH8waXw0NBrJhDemrIj9ShGqi1cl1Yqqc6cMhDa
	syihGUqouebz49ENPUyKnIg1KlC7HMkuOY/N0uJEZFmbkJzcZR4Apu6a8ONLM4+g
	2HGECQaxT3S7spWfvLdhF85cARpW/9N7awzOb3NueNgw5ouowHK+nu/eIjPBH4JH
	f5zN719srZ3DNUwt/8KClIR0l9PK94D/yvHXTDPT8C9d/Ruw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys035k7pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:00:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 720F040044;
	Tue, 18 Jun 2024 14:00:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 55CFD21682C;
	Tue, 18 Jun 2024 13:59:24 +0200 (CEST)
Received: from localhost (10.252.27.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 13:59:24 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: <alsa-devel@alsa-project.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: iio: stm32: dfsdm: fix dtbs warnings on dfsdm audio port
Date: Tue, 18 Jun 2024 13:59:12 +0200
Message-ID: <20240618115912.706912-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

Fix warnings on DFSDM dtbs check
Unevaluated properties are not allowed ('dfsdm-dai' was unexpected)
'port' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: 11183ac07a74 ("dt-bindings: stm32: convert dfsdm to json-schema")
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
index c1b1324fa132..2722edab1d9a 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
@@ -246,6 +246,10 @@ patternProperties:
                     From common IIO binding. Used to pipe external sigma delta
                     modulator or internal ADC output to DFSDM channel.
 
+                port:
+                  $ref: /schemas/sound/audio-graph-port.yaml#
+                  unevaluatedProperties: false
+
               required:
                 - compatible
                 - "#sound-dai-cells"
-- 
2.25.1


