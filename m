Return-Path: <linux-iio+bounces-6521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921890D8BB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55501F221D2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14C13C3CC;
	Tue, 18 Jun 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ku5z62w0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA713BC30;
	Tue, 18 Jun 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727080; cv=none; b=OoT9btYjIjA9xTCWzAwNokJW/qpOlPLZmoSmBi6DdNQoifcFd3tm03p2ci7vSU0HzFZHy0zVsUZA1i827Y3kNmjWGHslMS+Gw4sCo9t2Fdd1IAIHazaoOa3Bq7WlwAhls7eBl2wiFSNQvTYBtAOlrPu6X66KzwrwWP2j3b39E2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727080; c=relaxed/simple;
	bh=OixfWHuwr8fk2cZhP8A5Y4L7J7wxqUqTFUVglM0/iZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1Vcv18pDbMwIJ+ht5anScMI4W+RP047OskoLsJAiDyMHZBc+1FuSUpF77ALMUP4YRluTVkr1Z/X5DIRu56x/tgpXxQrDW9tGvsz90Ei5d1kY3rkYJ6iuy/RQZ+69Lq/toY1jOTJgXi10814qvUOOObmub6i6SwuQtdikhNXIRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ku5z62w0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IFe3x4027003;
	Tue, 18 Jun 2024 18:11:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	XpA+f9bQP61dqrvt0OM80VMLJKM/XB9fUzUgYOfoOkg=; b=ku5z62w0yaQ98uao
	lOBliKdZgAYwPrvLo5BVwAUxCmthX+MJRz5eHMmtIelgucTH3yF8d5kxBmWnMVc/
	16+AZhBA7VJKlqUG5het3hdUFtLZyy0tw7uoK5WVT58hUdjyG3gLv9sQ4WK9ubEO
	JOb3PONl/VTuV44uVQN1IBd4OgQxiavkzBfWJ/ooduCCHzss938Lk6N9jOy/z4Bg
	6B7LjD12FGX+elaGqL2vc/80j/Z2w3VCJ1GNFlfT5FXbnIOfAc1WE3nB/auHyqUg
	YC09PxBVe0jspwHh1bTfURXp+4TR+x2yQH/0JfIWdng8FfRF2zJZw+jK8lzH+XvY
	c7Z4xA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys29y3yky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:11:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A336A40044;
	Tue, 18 Jun 2024 18:10:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A6DA21D386;
	Tue, 18 Jun 2024 18:10:28 +0200 (CEST)
Received: from localhost (10.252.27.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 18:10:28 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] dt-bindings: iio: add sigma delta modulator backend
Date: Tue, 18 Jun 2024 18:08:31 +0200
Message-ID: <20240618160836.945242-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618160836.945242-1-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
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

Add documentation of device tree bindings to support
sigma delta modulator backend in IIO framework.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../iio/adc/sd-modulator-backend.yaml         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
new file mode 100644
index 000000000000..b0fa71b75cd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
@@ -0,0 +1,43 @@
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
+    description: |
+      "sd-backend" can be used as a generic SD modulator backend,
+      if the modulator is not specified in the compatible list.
+    enum:
+      - sd-backend
+      - ads1201
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
+      compatible = "sd-backend";
+      #io-backend-cells = <0>;
+    };
+
+...
-- 
2.25.1


