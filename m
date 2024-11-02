Return-Path: <linux-iio+bounces-11855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC36F9BA239
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 20:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD571C20C6A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331081AB51E;
	Sat,  2 Nov 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="VAUl+C68"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769691AB525;
	Sat,  2 Nov 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577284; cv=none; b=o6KZs0hhz8IRu6L42jZW6L0c2jUksvWi27TqRAImRZEV4STapFSR3QA7EugIIDOnziybCjGvUQzLEqQ/c+kgHL/R8YK2Q3hQb0Ud8ZJBGLDfAzgZS+mLYalgd/w08RQe+Rm5jxSDvlVOlETIPRnbFJVss6ednZoDAIibyPRFFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577284; c=relaxed/simple;
	bh=/YzjZ2+kWaCJYiOsHNNNL2840PxUKMK+oiKSq/YkNaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiKa3T35JYI+QHk8lj2SV05HjXNU1bMX9ufsLegFIpySXHNgja5P2lbMobIhV0LkE7tD3Oi5Zg14u7PGdqmz9fRQ375NIAcGbei3Li5Ylcsa/CMuMiGA5Zf1U/VXO3FKaf2kQsrb9nDnZi0qrpLlVnB2wwabpnyq5bn3xZ00JL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=VAUl+C68; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 307724C845;
	Sat,  2 Nov 2024 19:54:39 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
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
Subject: [PATCH v4 1/6] dt-bindings: iio: light: stk33xx: add vdd and leda regulators
Date: Sat,  2 Nov 2024 15:50:35 -0400
Message-ID: <20241102195037.3013934-5-aren@peacevolution.org>
In-Reply-To: <20241102195037.3013934-3-aren@peacevolution.org>
References: <20241102195037.3013934-3-aren@peacevolution.org>
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
	s=dkim; t=1730577280;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=6wjZ1pTHZq/+k3MCnSbbzmSo0hoqjpDUYVU+ZZfLBNM=;
	b=VAUl+C68ru76ec7Nb1Mb9ewjMuuI0BS5yVVgiZzYbG1egtlzzsh+ja7Si9tRUCmfImF0EN
	mgJfFaitBAaR2zB3PqoQZVBgsVfbO5iyyCQHBC0Ux6Y/CrbqRpTNKsBhNqKA3kDTsjFB52
	olPU/ef1KtJVkPoyexcTUwmxVvoQ40s=

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


