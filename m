Return-Path: <linux-iio+bounces-936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5518814598
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 11:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68111C230DB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0819BA8;
	Fri, 15 Dec 2023 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WkGmsWB6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5820307
	for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2023 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so4779885e9.3
        for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2023 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702636330; x=1703241130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3bsA3Hq1tZST6LLgdgUCasdE4/LKtqWt/9/psp4mcs=;
        b=WkGmsWB6mErIuSPKRgwJk99QrrPKhdO4xeWDYJi8dCV8BSsfLGzVH0a0IIWPJuNV20
         rGJ8eIZ37dboX9DG4b3t97m6+rnqUl+Ex6i9fU1AwD5rFENzDsuOlkNJimpjP0wndB8w
         sN0rLED3t4GM8+/h66lycMs0PHsj2AVEOBmIQYe/+wtcDtvkY0cvZ/SiT4tUGanHvCjX
         ZeASR51Qs4T78kqVuPMODnrVGABn0OqnoTkAi4JuTj0DbtGhgfAcOseTDA4UikT6Klnb
         5Agp4w7Y1BBw9vD9dPDVqWVRrAutmpSwXA10I37AHw38A5wgFKY7mU1Xj6gnhFN7K5uH
         kAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636330; x=1703241130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3bsA3Hq1tZST6LLgdgUCasdE4/LKtqWt/9/psp4mcs=;
        b=lKcJwSqQtZcOlT1ontrhWnd70flwzEEzlqZbw9dHmoF3YBhZKLicp48zfsLU1aO9cB
         s27RMc5aYoLN6wrgtGMJUxnZ0tVbP0pIsxFOsoR/Mc9QY0OBARRS4LoZFbdsl+2m2fKe
         Hfd9CG4N0oPBovW3MUplH6QIjgQXOfrP+f9pCigLgCEMWr6zFHcXpEdjlLUPlvFSzquG
         yGTiStdjI2b39IY9I5Bw2icN7uY0t6P44oHxR/ZOCsGcncrg083CGmsoxM2M2sM+JzNv
         xaphw2s9CKV/7XsyaILYeEd4hZJQSV2cAjIefxXPBDAcgFkFB5soVd6hkJ5C3vm4REwj
         qjnQ==
X-Gm-Message-State: AOJu0YxvYhiGMOaq0imxvn9mU0LEUcEPf+bp7BEq/8brAlnMUS3420Jk
	79z4brpelC7RoU8p+2GcRpTwfDn/j0SGL/otPKwd/g==
X-Google-Smtp-Source: AGHT+IGe4MMucKjjA3WOJtoTmJMh3Fj4pIUjOpDhgEcF23Hnh5z6vn2Zy3FUjhpnZwv0L/I4CQkvqw==
X-Received: by 2002:adf:ebc4:0:b0:333:2fd2:8146 with SMTP id v4-20020adfebc4000000b003332fd28146mr7175355wrn.99.1702636330773;
        Fri, 15 Dec 2023 02:32:10 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id q11-20020adffecb000000b003332db7d91dsm18421015wrs.39.2023.12.15.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:32:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
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
Subject: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels peripheral property
Date: Fri, 15 Dec 2023 04:32:02 -0600
Message-Id: <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
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

The rest of this series is ready to merge, so just looking for an ack from
Mark on this one.

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


