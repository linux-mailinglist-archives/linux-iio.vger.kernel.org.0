Return-Path: <linux-iio+bounces-12484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE09D5E28
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DB81F22832
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43031DED5A;
	Fri, 22 Nov 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XwY2jMWm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC91DE4EB
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275245; cv=none; b=IcYenLqwo3RgSI5ytZBf/cgmzjBsOR/CNYAmdR5K6p1B9d/zC1wzD1ZvTbdCPg90uHZQR+HhFLziNOCTU2JPV9dfxyyz6AIbi66+jNYo/wWn7ZpN0GLnyZ1MimuNBi/grvxdtBZcqJbuhRTw/wJF9qbI4McFqMFMHO2fC+UczhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275245; c=relaxed/simple;
	bh=LR5pHXckvZl5Tv7d1tyrP9QH9OzPMit0Fd60NybG8t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXjZkQwSMMXoktZ3OlMiCcf5O/EzBjaqCZfT9bMagw/5rWWLVFyFxUMgBd//HIXfOml3JIrZsRyFyEmbOD6LL742e7uM4gYPOw31UXfegfnkTqol4WSb94rQs9n3wdQVx5XXBcoXkkKriouixMDsT8xdJB8jh0zF3wLMI0p1KsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XwY2jMWm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539ee1acb86so2237240e87.0
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275241; x=1732880041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3DONvhJN+q3bgNzEaY4EWEouwcZMkht5kfoO/Vdpd4=;
        b=XwY2jMWmfFFcQNiM/VXZntksJfBF9ZlLMnoGhhT8qKqYW2deNv+FVaJzi6EJgaA61v
         6ZPdUMjF+IWsNwjc7LXy0lKxaEhddUQMlPPqD4atj/mTi5jPhUepXWY5mCtjzKsAes/U
         YLJE5rT5+u02yn7r+GaxyaS+xIF18qqvVIBf2JML3fBDmhHVV6qI+kIf2OJtAiU4+ZY5
         cqMuoBj8tRNItt0lH6qdPTUMSpwndziFjfoVV5XyIYkfzaNFC/5clddAsZWgGaW87KQs
         NJpOybGay6m6YZ9O6Me5YFJHyasn8++UN/bZGq7yKWaJS2XRVzjrDFKbWg6dBdIJXkJj
         OCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275241; x=1732880041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3DONvhJN+q3bgNzEaY4EWEouwcZMkht5kfoO/Vdpd4=;
        b=JDGbpg85b6K1qHV319yA1EWXokN7TAoOIXayTRkluoeOOcycgUAr5k4vNKBec1wPsb
         BuwtAm9GEkHB8K2pcs54Ys5yWtucFUAt8xHovRmHxXFalpxl2u7qS35ykdE/eTTy5Z3f
         EbG1xJc/n1gwDlSoH/CcrsRHnuz+5OwtA44lGQQyo7uRlrORACNFZ4UrTVB7erKRT7qw
         VsNvzsjqsupb1U6XDMVV8ISkYfhLDRDsSSWpHNnZ1Ds1ssMpw55w1H7/li/Gh67idlQ3
         2pYozdPzpOPNKz0T1n8PCTdMfD3oIAItcHB2AVbghmuX9CLt5ChjAoUUSaao8tdFiDVk
         HdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoq+mtPeR2yXqc6gmI9qaqBTakcOQbtoG0PYxyf8acl9WKhd0uzNvr6V9B6yXeYbWpoZGBLK/iRQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOV8ci/8WcSrDDv1gjuXB9ELgurAdPO91GJLare/NHLTGiCBL
	sblZ1oB2kXaDgMUgiByHcRI8f+ohWx5bT/Zbn1xhq1XB6TYnqhDdqNQJaOUnclE=
X-Gm-Gg: ASbGncsMj5Bewr16NzphBHGZyhSD6tYaEF2aF5w+4IGE3sxTV6VtAQC+huQ6wM7AUaq
	PJi3RYNsQzGncG8Q5AUyLQuz2SB0JhIXsnB2dzEtIn035ZUwC0a6LVRTgmz7LIJiIx+wFEmvXpy
	V+TUw6Mwq0BiHJ1FwsdiMRNh1hMtWktcDpGXexcEnQIFjs+E6MfrqsEMm9geF+kJwKO6igTetGQ
	yYmsZy9YqJWEs24GHGckzngVQ3//HPom1hx/xW8VtROkCU8HSRSfnZPbPgeLZuYwosC1QRGaOSw
	kYQ=
X-Google-Smtp-Source: AGHT+IEjFwOuMWDydiQ9Eny5j247ZIzsJsm74p6LBuQ6gWy1+9S09E/I7z022prykzF996YrBb0eOw==
X-Received: by 2002:a05:6512:10ca:b0:53d:a9dd:5a05 with SMTP id 2adb3069b0e04-53dd39a5365mr1322534e87.46.1732275240647;
        Fri, 22 Nov 2024 03:34:00 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb30bfdsm2157536f8f.56.2024.11.22.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:34:00 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 03/10] dt-bindings: iio: adc: adi,ad7124: Allow specifications of a gpio for irq line
Date: Fri, 22 Nov 2024 12:33:22 +0100
Message-ID: <20241122113322.242875-15-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=LR5pHXckvZl5Tv7d1tyrP9QH9OzPMit0Fd60NybG8t8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwK3n0rFUM30pvMNf0ReBZRIcrNLiAQoOy/d bLmRqnRrsKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsCgAKCRCPgPtYfRL+ TnR+CACN4VPCHsuSilSXsvvasA4WJ1MsIkTRD4pl2WLgcQO4UVd2c+rgE3f8GcTEJJPEJ7hHlyp GCCwJG8VnTiXDwhy/tTgThdp+0jispOOYSd0IInnPhkXoPCldh8mMSXZ/TbtPLQbvEnvvpbhBCy xtgbFzSQijGhKeZlyFe3+2itLaNw6pldUMhzAbTw3c+x9/n20FbGunCfBqSZtksGGZwYv8kdIDB sPCzZE2szpxkrerQsxV1foDGtccVlw0qPXNu0hfm9vZxSzKLT7PPxMFIPBldkKFiuKC+j2zX8Hk NROdSun/Cg9oC5Abjw4CEWRbVDNOTJCGzW8hDZrQ5scU1Rlf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For the AD7124 chip the logical irq line (̅R̅D̅Y) is physically on the same
pin as the spi MISO output (DOUT) and so reading a register might
trigger an interrupt. For correct operation it's critical that the
actual state of the pin can be read to judge if an interrupt event is a
real one or just a spurious one triggered by toggling the line in its
MISO mode.

Allow specification of an "rdy-gpios" property that references a GPIO
that can be used for that purpose. While this is typically the same GPIO
also used (implicitly) as interrupt source, it is still supposed that
the interrupt is specified as before and usual.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 35ed04350e28..ebe77cbe87ff 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -37,6 +37,12 @@ properties:
     description: IRQ line for the ADC
     maxItems: 1
 
+  rdy-gpios:
+    description: |
+      GPIO reading the ̅R̅D̅Y line. Useful to reliably detect the interrupt
+      condition.
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -111,6 +117,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -121,6 +128,7 @@ examples:
         spi-max-frequency = <5000000>;
         interrupts = <25 2>;
         interrupt-parent = <&gpio>;
+        rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         refin1-supply = <&adc_vref>;
         clocks = <&ad7124_mclk>;
         clock-names = "mclk";
-- 
2.45.2


