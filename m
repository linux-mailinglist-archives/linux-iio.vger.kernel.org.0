Return-Path: <linux-iio+bounces-6898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19824916CA4
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99BC283201
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247F17E479;
	Tue, 25 Jun 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7BPSx8SD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562217E466;
	Tue, 25 Jun 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328224; cv=none; b=cc/OoOl+pApWpGCbmyqpGmTjXH7xKS6+h/mBcMNHW16NQNY+f6nS9cDg/671rUcIbp3Lk7lL9lwFHuV53lKqPmoS8xsTEee3Vcgq+y+FvWvEQg7LHMGIAjfTdfggSAFMbRG10PZqHtdrxMCcmVjnWlmkN4US9zuGAiftH3+1p8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328224; c=relaxed/simple;
	bh=lLB22x55jySBGNixoxsFlXICiRIaK+cW04NihrwW8gA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZP/1qvcMwdw3XYaz3G3QlJrepFLFTDxePb/SyQZEQfpvvJyAv2cQMD6cUd18Hvk0plq245l1Qlw51Kg6ymuReNd5bMpDaNC6eyDA7Ly7lnEzdSxQV+06twD2KSmq9CnHHfQ3cDgiryT4TYGXugVQXd32SMdmIwMs+NoM/Vg9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7BPSx8SD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBwZOY005234;
	Tue, 25 Jun 2024 17:10:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	p6Efemr+Ciek6n5zMzC+VG43vrUgOuYAINEidsFq9IQ=; b=7BPSx8SDXWPdwOTA
	eaT/tUOis3zIINH8hkhT80u+J3a8x4cZiBAwO9FKXVJPHea5I1cN6X+VjSv88rtk
	SzdKvOjOH/xgdgGAlurnZo9hCpSiRRIzAC1jhdLHbCDHqxTemI2cNe8mQEpLABkw
	Nyzji+qVUKsEhb9xx0PTu91vJNhCKYMAPjSKJPS6oT7ePplden3uBycSlYxLCdik
	6Byl07IN6xF25uevykgoIlr0XqfgLUr0dusTdl4B2D+T/9kwYK3NCR4M5kxG9r+i
	B0zlsA03K9u3gaJGdBfcRoKWc3tUgSRCMjuAqNzr5EqmAJT6hUyENI5EktNHZkaE
	ce4lYg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywm1gcu7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:10:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 627A74002D;
	Tue, 25 Jun 2024 17:10:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 06C092207AC;
	Tue, 25 Jun 2024 17:09:32 +0200 (CEST)
Received: from localhost (10.252.26.63) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:09:31 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/8] dt-bindings: iio: add sigma delta modulator backend
Date: Tue, 25 Jun 2024 17:07:13 +0200
Message-ID: <20240625150717.1038212-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01

Add documentation of device tree bindings to support
sigma delta modulator backend in IIO framework.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../iio/adc/sd-modulator-backend.yaml         | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
new file mode 100644
index 000000000000..3299db71f79d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/sd-modulator-backend.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sigma delta modulator backend
+
+maintainers:
+  - Olivier Moysan <olivier.moysan@foss.st.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1201
+
+  '#io-backend-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: Phandle to the vref input analog reference voltage.
+
+required:
+  - compatible
+  - '#io-backend-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ads1201: adc {
+      compatible = "ti,ads1201";
+      #io-backend-cells = <0>;
+    };
+
+...
-- 
2.25.1


