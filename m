Return-Path: <linux-iio+bounces-23683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5AFB41E1D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 14:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12351BA6908
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889E258CE7;
	Wed,  3 Sep 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="o2ZMvI9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3D2FD1D4;
	Wed,  3 Sep 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900807; cv=none; b=uW3i2r1Mss7oN/qH0B+y1sywLkKT69v5Xoyf4jUX0QNVb6O83FTzhZj1qYj2nW8x27q8Y+iy66ZN5ehd1f+zu/lylfEs3ocdlHsG5c/Uhvi/ify5t+29o2zHS5qm0qKn9T/7CxlV9X+YgUaN19gYwItrBiPoe/dDaSdYbSPbSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900807; c=relaxed/simple;
	bh=Rb+PgskYzX9hALGvKjDvYwWW2Nn2Nrp6mSa/cLLO1GM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bvcu9S2B7qw3j9UvjCzSYCY/sil9TQmLKoIIbNoeLSyueOBr7dT2xqYcpkQhqjRFSDyJQwYm7MwPsrnj6gH+HkeAq6uxZVt8tqIJ0SQxmsT3lXuGfQ6M54KMtKi0Vmd9HOUpVSwyo5W5TatXBTnSmddZChtWPkn3TWHIZu+WR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=o2ZMvI9B; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=coCvg9toaaZHalzdq7we7HoqSKMDL7gNaulcB9obD/s=; b=o2ZMvI9BejTF4cXzOojjDzjoMq
	V3qzoWK+kJHDNUFa3Q7jBydchZ2zA+NAQIfaUaCOV4pyhDwJFSbBL5B9xxEhZ0haczUkxYQPiEeDI
	ttEqiXVlDmjMWZPSLrRHrPtbQGYcotpXC49FZhU4Z51wiOERsjSReZ+E/j+7mAJrBu6+PiRc4c4+d
	8NIaK3TJYFxRM7LdTPFo6QAPWpT5WKcrkSOer5cZDZBe7f4sxZ9kyjOQ8hNglHzSG7B9wbxYU5K2Y
	0xQfc21VTxvndLbilf+pfJ0IKNY/4OJdFYVcW8Zio6HkmtX1XwYbZo4rgTMYQ1qTUIhk0fi9T/4dh
	B8TOZt+A==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52410 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1utlnU-000000034mQ-1Rh5;
	Wed, 03 Sep 2025 13:37:02 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] dt-bindings: iio: afe: current-sense-amplifier: Add io-channel-cells
Date: Wed,  3 Sep 2025 13:36:59 +0200
Message-Id: <20250903113700.3079626-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The current-sense-amplifier is an IIO provider thus can be referenced by
IIO consumers (via "io-channels" property in consumer device node). Such
provider is required to describe number of cells used in phandle lookup
with "io-channel-cells" property, otherwise the following kernel error
is present:

  OF: /iio-hwmon: could not get #io-channel-cells for /current-sense

Also fixes the following dtbs_check warning:

  current-sense: '#io-channel-cells' does not match any of the regexes:
  'pinctrl-[0-9]+' from schema $id:
  http://devicetree.org/schemas/iio/afe/current-sense-amplifier.yaml#

Fixes: fbac26b9ad21 ("dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.")
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 .../devicetree/bindings/iio/afe/current-sense-amplifier.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
index 527501c1d695..bcf4ddcfd13b 100644
--- a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
@@ -24,6 +24,9 @@ properties:
     description: |
       Channel node of a voltage io-channel.
 
+  "#io-channel-cells":
+    const: 0
+
   sense-resistor-micro-ohms:
     description: The sense resistance.
 
@@ -46,6 +49,7 @@ examples:
   - |
     sysi {
         compatible = "current-sense-amplifier";
+        #io-channel-cells = <0>;
         io-channels = <&tiadc 0>;
 
         sense-resistor-micro-ohms = <20000>;
-- 
2.34.1


