Return-Path: <linux-iio+bounces-11469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3B9B3342
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BE81F22622
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67951DD9A6;
	Mon, 28 Oct 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="lIbTPM/A"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A51DD0C9;
	Mon, 28 Oct 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125312; cv=none; b=LZo0QavqlqmfGuyY0vIbydTph3TzJ1tCQZTtnYvytHVBg2GgbUIJt7V6qqu0ViTtIPpNIa/RobfFhVitDqi0aQAYKth0r2FEgRiddTUFkZKIuTVU/PxFS9CMVDHaln8mn5ihz2lsSudDyS+75JiPRbrO/qM2Zo/NKt9Qd4jim3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125312; c=relaxed/simple;
	bh=/YzjZ2+kWaCJYiOsHNNNL2840PxUKMK+oiKSq/YkNaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVRpOzZ7xUdKOgZh6OMXQKIQ+zRSfDBLnqrO4P1ODfqmPRmQ1S1ho506NY65WiIdDA39gF85hMpQh+6SHv1XjKxk0Nr43kl4j8DlQyW4oXLgTXCwfwDB/+Evd2aTadLGpxGsWpceDZPKi/S56D86QqlnH19MuUYR6SbR7bBiBuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=lIbTPM/A; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 588034C736;
	Mon, 28 Oct 2024 14:21:48 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/6] dt-bindings: iio: light: stk33xx: add vdd and leda regulators
Date: Mon, 28 Oct 2024 10:19:55 -0400
Message-ID: <20241028142000.1058149-2-aren@peacevolution.org>
In-Reply-To: <20241028142000.1058149-1-aren@peacevolution.org>
References: <20241028142000.1058149-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ******
X-Spamd-Bar: ++++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730125309;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=6wjZ1pTHZq/+k3MCnSbbzmSo0hoqjpDUYVU+ZZfLBNM=;
	b=lIbTPM/AeaMflAcdwUJTLIqKg+0qzjN+F7YnXFOaviiL719lrG2kCKUyGQWu4NKN79l5qL
	5mqVD0tWkcaaCIf3a1sRdridQwMCanS1iTHnmY5GoM4GLEIMQpq+ZcPYw6LsTkZLoS7yEw
	yQBC8DXXeh9XO+ZV2jk9kFdDP9rki/Y=

stk3310 and stk3311 are typically connected to power supplies for the
chip (vdd) and the infrared LED (leda). Add properties so we can power
these up / down appropriately.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    Changes in v2:
     - add leda-supply
     - add supplies to examples

 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index e4341fdced98..96ee8ec16463 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -34,6 +34,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+  leda-supply: true
   proximity-near-level: true
 
 required:
@@ -57,6 +59,8 @@ examples:
                 proximity-near-level = <25>;
                 interrupt-parent = <&gpio1>;
                 interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+                vdd-supply = <&vdd_regulator>;
+                leda-supply = <&led_regulator>;
         };
     };
 ...
-- 
2.47.0


