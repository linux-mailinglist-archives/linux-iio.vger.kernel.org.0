Return-Path: <linux-iio+bounces-17250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F2FA6DC7B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 15:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9717C188DBAF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CE25F79E;
	Mon, 24 Mar 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="cXr7Y/mo"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-100-percent-8.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster2-host4-snip4-5.eps.apple.com [57.103.88.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D312D1F1
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824997; cv=none; b=DIH4HDV5D+pIVbG7dEZVHhO4917zKUV7F3XpCZ8/54uoD7bY0StJDwoghzFNDIVRCccHyNBKt1m1pKx30JtbI3KExHlUw7tjpFMAtO9SEdmKlJODkx+zSzBG0AxlwhLJnN3lAHu9kA8l27njfJ4GOj1hdPdkiscJW7yP2FEQxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824997; c=relaxed/simple;
	bh=2hHc93Sco5xP3xZWtNHCJvQEA7HZmGG0cztk7rwE8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLiKsVnL+brSfON2iUpDsOCkK/PiGqZ2hFcZ6IeYjxNctmyaCJ/IWvsME2gkC5O2L4rRBlB1dethltXe67I7lLyy8MH0Nzgl+VoeHVKHmSXyew59ixdlON06xzzK+UTLJVoeHl2aBAJCd75PE4x6zXwmfXHNCsAxsDZGf6wjFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=cXr7Y/mo; arc=none smtp.client-ip=57.103.88.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=WasnMIg1e5gehV8W5yYsLBf07jVgGTrC4bfranCi3dk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=cXr7Y/moaYWQBxPDWwCuOwrzrUeaZqru75odTB6U0MjXjEBvP+e5K/+yrZigVVNv4
	 Yz3/zxwnlKa1IVXec4kkS+h8fH2KpEibbpSze+Idgm7hlNX/azMg2domhcucLLkH7y
	 3RjjMrVvNx6xGPMKwLuC704diLjez3y5ZVYy1x5Qa3CeWEnJ9rwudmNHd7UspBnljI
	 gxY709oxPaT5ZP4ZLtV2VO/zR0dg7SLctIizPmKgeWS9HTjViVKoBapSoMhexOrYTI
	 5y9PTIk/2M3733fgQO4ysqa4PpwiDCfm1AFtjJwlZhruL6DoEq1SC79imU1nRt1J/X
	 bE/4BGuzfehxQ==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-8.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id A5850180122D;
	Mon, 24 Mar 2025 14:03:10 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios property
Date: Mon, 24 Mar 2025 14:59:19 +0100
Message-ID: <20250324135920.6802-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y8ImYB_bvq9y8NVnp88OL0bl3FfobXMM
X-Proofpoint-GUID: Y8ImYB_bvq9y8NVnp88OL0bl3FfobXMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1030 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503240102

Some BH1750 sensors require a hardware reset via GPIO before they can
be properly detected on the I2C bus. Add a new reset-gpios property
to the binding to support this functionality.

The reset-gpios property allows specifying a GPIO that will be toggled
during driver initialization to reset the sensor.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Revision history:
v5 => v6:
 - Fixed include placement as commented by Krzysztof Kozlowski
v4 => v5:
 - Update description to reflect "active low" on reset signal as indicated by Krzysztof Kozlowski
 - Update description to clarify what pin of sensor is used to do reset (DVI) as mentioned by Krzysztof Kozlowski
 - Edit example to be coherent with "active low" as informed by Krzysztof Kozlowski
 - Added necessary include on example
v3 => v4:
 - No changes
v2 => v3:
 - Split in two patches: dtbinding and code
 - Ensure list off mantainers following instructions by Krzysztof Kozlowski
 - Delete redundant details on description as suggested by Jonathan Cameron
 - Added related example to existing one as suggested by Jonathan Cameron
v1 => v2:
 - Ensure check tests as commented by Rob Herring
 - Fixes some whitespaces and end lines
---
 Documentation/devicetree/bindings/iio/light/bh1750.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
index 1a88b3c253d5..9df81c271411 100644
--- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
@@ -24,6 +24,10 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description: GPIO connected to the DVI reset pin (active low)
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -32,6 +36,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -39,6 +44,7 @@ examples:
       light-sensor@23 {
         compatible = "rohm,bh1750";
         reg = <0x23>;
+        reset-gpios = <&gpio2 17 GPIO_ACTIVE_LOW>;
       };
     };
 
-- 
2.43.0


