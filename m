Return-Path: <linux-iio+bounces-7806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA5F939622
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A2528071C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297C6EB46;
	Mon, 22 Jul 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDhFbtcb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4664CB4E
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685693; cv=none; b=izRCfUnlPx/E2cGAqO2bACXy8Cz++1ApZFatf/Mtpu9mIsnMVXMM3EbvxJI/II1R7u1ZC6tcfjrATwyEsheq8T+9BknSOcU/VD9ijPu0HfsxlUxo4dv/PCOsuN6wuVERWGZGV+8YVZMo6GH9K1xqcYSNKl7A1SKfJISSLVWTMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685693; c=relaxed/simple;
	bh=g+xF9JlXpviiMNJmjaApOysuZnb3kQE42/SlQHNRfAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH4CwCmGgY+phmBcVLvau3++LRLTkZnl4HzBYTXMGDtuZP9fZ/Fny3TaLPR8o7hLmI7i2VOJ39K7ryp1XF8Dx4HJN38k02nnjfNpRkld3FvCwZKc0taLuXBjjWoK6T+HUwBuYQd2TQ6vV3PkOohDR6zZChDRDdp1Oq/cW13nGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDhFbtcb; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70364e06dc6so2092004a34.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685690; x=1722290490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jiC0bL0wy9+AlsO7Q0mhlDRo68Cb9JVUn8nn5AwBW8=;
        b=LDhFbtcbgALgFGlMfZjjOK8pY/dai09kwgByRoj9kjRG7x0h0cNCS437oImM2aA6Mq
         rcjLJZLiGwNNzIaMI1nul4Pd2ggC2PJbCM/YKdGg//jxYiEIJfPFEcCMOzTGiu3FDMfV
         cVeYH4jO7Ej4e776hHVbRJb+VCRriGfON29oPD/KwtPEgtgjzXdvGnWQ2NOToyqGH9Ip
         fllOo0je5d0JQ30A0hWV+ffjLUEgJSNdYymUsV83rz+3xYzGfvwQ6d3pynbxbifn9fdC
         GruBzpBgE4Y7Uv9Uj8KgEYTrx1OdSO1gKC3MwF+kHiJPcRawZWZubayUNtdKKCskuXM4
         lM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685690; x=1722290490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jiC0bL0wy9+AlsO7Q0mhlDRo68Cb9JVUn8nn5AwBW8=;
        b=fBRcEIrCg0h41vccEUZfl9VJ4C9icy7YvhQW+OteOLKatM5sW0iq915uVqyQgAqaFh
         aYi8w2k9Y6MIzmEb2wX0+pu30uiKp+QmT5AtL1exEUoV3idbAUWF2q7WdFh4Jgy9/AAV
         LWms9aLt2yfGFH2J/jmZUczDgCNBO70NzyZ9SY93fWAd7auSBjXUi8PKi8uC2VKVjSNf
         6vtxCLwr7VmIHRFWK1HRb0eK11yjBnRzdCOUVkQUplGk62+HZKhd+dIO1tPux9uibC9r
         l/iOseusA29QWcVQVkJnj7WX6THtxS1+JRnko/186tlj+Z6je/0pZilRxqcTKkwZSNqH
         D1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8iglewKTh2HFCWJbWSi7C9A3jREZLFR1PMk146cXoz95xQmZUKMXrd/XsXXg3t9AGBUBpyKdpJAQ2BZqRRiWO+LbDKdRHXgN
X-Gm-Message-State: AOJu0YyQPKLm+rANJu0kJnyGG6w3jtY96r10ON2YaBHTnLhH9YVkyza+
	+UPX2M/DhpRQLyx7AcV9Magq+uR7la7FTEvbbU6LB8n5teYBdvxtLPmZRl3oUlU=
X-Google-Smtp-Source: AGHT+IGs64wd91EwVV4Q/LZEgMoFqhXFy69BoOg7X1dR3lfIoah1e8xmfwOiIrdKEkWIZnK/5Kjetg==
X-Received: by 2002:a05:6830:388d:b0:703:6477:460a with SMTP id 46e09a7af769-709009cd848mr6822618a34.29.1721685690446;
        Mon, 22 Jul 2024 15:01:30 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v3 5/9] spi: dt-bindings: axi-spi-engine: document spi-offloads
Date: Mon, 22 Jul 2024 16:57:12 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-5-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

The AXI SPI Engine has support for hardware offloading capabilities.
There can be up to 32 offload instances per SPI controller, so the
bindings limit the value accordingly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

RFC: I have a few questions about this one...

1.  The trigger-source properties are borrowed from the leds bindings.
    Do we want to promote this to a generic binding that can be used by
    any type of device?

2.  Some folks are working on adding DMA to TX stream support to the
    AXI SPI Engine hardware. I assume that the `dmas` property is like
    others where the order/index in the phandle array matters. So this
    would mean that for device that only uses 1 out of the 32 offloads
    and only uses 1 TX DMA channel, we would have to have 32 <0>s for
    each of the possible RX dmas in the array. Any way to do some kind
    of mapping to avoid this?

3.  In v2, we discussed about having some sort of data processing unit
    between the AXI SPI Engine RX stream interface and the DMA channel
    interface on the DMA controller. I haven't included this in the
    bindings yet because we don't have a user yet. But it was suggested
    that we could use the graph bindings for this. So here is what that
    might look like:

    Additional property for the AXI SPI Engine controller bindings:

        out-ports:
            $ref: /schemas/graph.yaml#/properties/ports
            unevaluatedProperties: false
            patternProperties:
            "^port@1?[0-9a-f]$":
                $ref: /schemas/graph.yaml#/properties/port
                unevaluatedProperties: false

    And this would be connected to a device node similar to this:

        ip-block@3000 {
            // Something similar to, but not exactly like
            // http://analogdevicesinc.github.io/hdl/library/util_extract/index.html
            compatible = "adi,crc-check";
            // clock that runs this IP block
            clocks = <&sysclk 15>;
            // interrupt raised on bad CRC
            interrupts = <&intc 99>;
            interrupt-names = "crc";
            // output stream with CRC byte removed piped to DMA
            dmas = <&adc_dma 0>;
            dma-names = "rx";

            port {
                adc_crc_check: endpoint {
                    remote-endpoint: <&offload0_rx>;
                };
            };
        };

    Does this sound reasonable?

v3 changes:
* Added #spi-offload-cells property.
* Added properties for triggers and RX data stream connected to DMA.

v2 changes:

This is basically a new patch. It partially replaces "dt-bindings: iio:
offload: add binding for PWM/DMA triggered buffer".

The controller no longer has an offloads object node and the
spi-offloads property is now a standard SPI peripheral property.
---
 .../bindings/spi/adi,axi-spi-engine.yaml           | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index d48faa42d025..ec18eabb993a 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -41,6 +41,42 @@ properties:
       - const: s_axi_aclk
       - const: spi_clk
 
+  '#spi-offload-cells':
+    description: The cell value is the offload instance number.
+    const: 1
+
+  trigger-sources:
+    description:
+      An array of trigger source phandles for offload instances. The index in
+      the array corresponds to the offload instance number.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  dmas:
+    description:
+      DMA channels connected to the output stream interface of an offload instance.
+    minItems: 1
+    maxItems: 32
+
+  dma-names:
+    minItems: 1
+    maxItems: 32
+    items:
+      pattern: "^offload(?:[12]?[0-9]|3[01])-rx$"
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    $ref: spi-peripheral-props.yaml
+    additionalProperties: true
+    properties:
+      spi-offloads:
+        description:
+          An array of 1 or more offload instance numbers assigned to this
+          peripheral.
+        items:
+          minimum: 0
+          maximum: 31
+
 required:
   - compatible
   - reg
@@ -59,6 +95,11 @@ examples:
         clocks = <&clkc 15>, <&clkc 15>;
         clock-names = "s_axi_aclk", "spi_clk";
 
+        #spi-offload-cells = <1>;
+        trigger-sources = <&trigger_clock>;
+        dmas = <&dma 0>;
+        dma-names = "offload0-rx";
+
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.43.0


