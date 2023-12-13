Return-Path: <linux-iio+bounces-882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6BB810FAD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D71F2112C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07F2377D;
	Wed, 13 Dec 2023 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pRfBouSm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE1DB
	for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 03:21:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2308faedso69533025e9.1
        for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 03:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702466486; x=1703071286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev6Cfv6nDG3qQtZztAusOez9MHzFknUz32Jp+6osCws=;
        b=pRfBouSmfIk7+UkwhgR6609sL0nJpVqW53h8QK576q/yEA96HUnIwioeKgyH0wVWOo
         C46X4jqbdAgx75E3WHQknWSFL+qX43jnM8x7fp9Ufvg+fTlN0c3YICO/LbePONGc6bjx
         vnhG28i8msV7nixLZAq+1N0UUT7r+Tu70gvF+va9yol/ld93W7NfQTxHzHT0xdDILB8d
         twryLQxoIs8n9sJg9XOpm290IcycOYkctr+/gWJRRlZKKuzg3phz6A7pMic9D61AK5B/
         SBh8olhH2Gqh02XMFuz+jkHr/yD2lYJPGtkNNaddltnHd3VL5w9/ENzPcFJxTLXKzkVr
         OjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466486; x=1703071286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev6Cfv6nDG3qQtZztAusOez9MHzFknUz32Jp+6osCws=;
        b=BB5jxJr1pXVYQebbrQ4ZjFsjKgkLxNTTFl8Iz0eWs1Zp9QMowaFdEYkN95mUCkx9Vo
         bfEmD5yGZndW78wf5Y48cNC3+h2movuH2vUPELIiVRaVJ8oo4Tv/lwo3u30zYD6dptrD
         jqB/JjlehBP8RfRYbmkx7gB22jNi9IgQ2E2khpA38KX4jKidQkbsPucrqGLjpeRAtQns
         2/lnsJvDtxSejeGp/XHbhmjp1A20AwNrFthPdr1rwlgtT6iX8kgn/ScfS2YA9xyzcpcj
         8obiz2O6udEE4sI87SrXClu0UbB0+OqfJmFndWDCOrdy7rjtGZU8cWWJff4o6Xo06p8v
         dJBg==
X-Gm-Message-State: AOJu0YyIX6uYWWnSwmY2/FNorHvI5fza+uGUi7nFDaKgSjXDqUBM2SKG
	cNyhR1pQrOQ1U4kr7kCcTIbMUPIgSbUs3v+31Vu21g==
X-Google-Smtp-Source: AGHT+IFYo7bTOfdzgxtVdb4EObLHhLYJD6yACWy15D89wzsOa/LZSsHgFmB0kezYkUnbcrxwBEtHeg==
X-Received: by 2002:a05:600c:21c7:b0:40b:5e59:c56d with SMTP id x7-20020a05600c21c700b0040b5e59c56dmr3727083wmj.151.1702466486079;
        Wed, 13 Dec 2023 03:21:26 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm20097617wms.7.2023.12.13.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:21:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: spi: add spi-rx-bus-channels peripheral property
Date: Wed, 13 Dec 2023 05:21:18 -0600
Message-Id: <20231213-ad7380-mainline-v2-1-cd32150d84a3@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new spi-rx-bus-channels property to the generic spi
peripheral property bindings. This property is used to describe
devices that have parallel data output channels.

This property is different from spi-rx-bus-width in that the latter
means that we are reading multiple bits of a single word at one time
while the former means that we are reading single bits of multiple words
at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes: new patch in v2

 .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 15938f81fdce..1c8e71c18234 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -67,6 +67,18 @@ properties:
     enum: [0, 1, 2, 4, 8]
     default: 1
 
+  spi-rx-bus-channels:
+    description:
+      The number of parallel channels for read transfers. The difference between
+      this and spi-rx-bus-width is that a value N for spi-rx-bus-channels means
+      the SPI bus is receiving one bit each of N different words at the same
+      time whereas a value M for spi-rx-bus-width means that the bus is
+      receiving M bits of a single word at the same time. It is also possible to
+      use both properties at the same time, meaning the bus is receiving M bits
+      of N different words at the same time.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+
   spi-rx-delay-us:
     description:
       Delay, in microseconds, after a read transfer.

-- 
2.34.1


