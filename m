Return-Path: <linux-iio+bounces-26608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1548C99D94
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 03:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF5AB3459AB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443E24E4AF;
	Tue,  2 Dec 2025 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sx6YwzeU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE623EAB6
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642103; cv=none; b=KeEyvhJd6eKhJuMqAOeCJHz0kXr2DElhdLjKjvUSuTF/p6/6qoPX3ISiTNYMhhmpbKRWV6CAnlXlPOuEumv4/5EXFCtCGsbPfeW6STfG39akKVtsQ2QO5fM0cd4pmxTNDiKe7EbV9aBrxiMKXjE+nHb8VXYPKJ1oZc+ne8CuHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642103; c=relaxed/simple;
	bh=hQZOLk8i9DVbMZG4cJemIzrR34rWhbVDk46gXL5wP1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pwx72BseaOyKsFOLOCoFiBmzLyPpI3wloAl688Yr7JIt0WFu9+SLS0uFj18WY/jvuQsesFMTJ2++Ow2b9PHgXIHiu/Sc8QfFIK8V70lfod3viOcJ2MLQ2AGtrM64NHFQ4SLOn7XbAq+t1e7c/VgPnimRcDid4dgxvLhHhHZu+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sx6YwzeU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c704bf2d9eso2437359a34.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 18:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764642099; x=1765246899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doomhoJuMMF1QAGOVBRmzRBJ94ihy9fy+VenqVEanXk=;
        b=sx6YwzeUVYadh0Q57SwMdDnFTueFYPjpPy19P7Aj3904i8KlIhg51jWTnnhMVhx1i2
         uwRh/jmH6NthheYjEZ2I/Wu1teDlaGsbxUxMSoopfppBX0UGFYmOhXRQXPXEZ6DrSbZD
         I6fm2OmtcrwdI/7R/Q0LXE1agCSL1AAeN1pTpfGMdiYAsQZTJANzQa2MISXgOezXZl6f
         g5vQguvBFq61poVABd3HBaWWhi0hzYcPYP/MGbDJVUaFa4yhCpK8av25RbDHtB36xzDa
         R1EygurEnRfmpzzjpOnx+Wlv7XRYGPnpNdRRmzKO+EP53dMweFAL+uk92AIzHbO6aKW4
         YpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642099; x=1765246899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=doomhoJuMMF1QAGOVBRmzRBJ94ihy9fy+VenqVEanXk=;
        b=lwWklk9fx+YvWXPeu06zIF1jobG5UOdrJfnLUcMEplpPiG2IKXQusLSwv/KpCmVk+s
         Q3UBI3FeYdf3t3mCCIGys2kpDq3GyxrIYJ7+ki5edI3j4vV3xvTKTTRsdtiS4nnqhvlu
         SobJpFevV3KHJdmzxc+I5DxDli9LXTrF3kqwzeK76/uk6EvupNGd/MLn/Km+uDppkwb2
         SOgfmNOXxcNhuHCwMBE9ahMdbhJ9KsjYooQEvbeeLyUP0y5EkP0zeNvAWTeWTD2x5Qq6
         9FokmhwDBIFesn15augtTH+RMyF4PKjkN3Ebn7fdx8yYBSPPz1PpfWttVx+BXIeo4vQC
         wmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4SBZzn6rq3n5vnP9KmbnEr1UZtXhNCsnmxMZDKwFQFQ/nloMn4O4icDHxwWnBU8lxENkGSCH//Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEVNDrFFRl3OLYyxHWa/GbhMryDGAzUlESk8QDHCqTixgkOqX
	E6fyFSfSV9R69pXxu9mcnZGbFFyDxHorhnoiQV4jj8KKprJXkuhzc/+/S0Vn+mZn5vE=
X-Gm-Gg: ASbGncu+1/ozBCv76BG2CQy//0x00kxMdr0aZarx7QYID8frT6CJJ+S0nCrUihuHGl2
	8mUIlwyMacyzqR5LCNbieM7Rp50i3R3w49w446yPBGm4kaQM9sxJVz3nBpnM1Mq070KXa+jTI04
	mUVrUWkv22QcpaEbzpOd0No+abPxVzdt1DNRVKNi7GNa24tJGMCJ/ZqMMlG8rO/BNkX61kJnkuP
	V81xn4M7Cr9IQvxqP0AmykysgrHOEpZl3q1Vr3m563jym5kDwPDgtlxXqocbfGu5slCyUIzHSN0
	oXoGwTnMiWpy868SHTnvQJ1ZFsjHWpJ/MxL6smuBNXsexGSeHhoZijluslJDRuv5W5+WnjjKUWN
	AcYYQfmWvQO92s0lAm7FLibzxCnvvJ1dGBFdIN5pxBPSNj3A2NF4qPzIzpSkFXt6Kn5ARAdlJOi
	Y8PtiSQlbLxZ77Kg==
X-Google-Smtp-Source: AGHT+IGYdhQZHjywqEbS7m4fq8WaqNIMbtnS2wILUvY6Euq1m9AKjcj01QT+B7Mu/1rPB/uVooCz6g==
X-Received: by 2002:a05:6830:4118:b0:7c7:10ca:bf with SMTP id 46e09a7af769-7c7c410fc5dmr19052593a34.10.1764642099535;
        Mon, 01 Dec 2025 18:21:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca0475esm6651747fac.1.2025.12.01.18.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:21:39 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 01 Dec 2025 20:20:39 -0600
Subject: [PATCH v3 1/7] spi: dt-bindings: Add data-lanes property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-spi-add-multi-bus-support-v3-1-34e05791de83@baylibre.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=hQZOLk8i9DVbMZG4cJemIzrR34rWhbVDk46gXL5wP1c=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpLk0D0p4cZWkK6Mc3W7w2xdA3t8b6/WIkrYxAg
 DacFRekNumJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaS5NAwAKCRDCzCAB/wGP
 wGUJB/4p+CRbrTI2i7n3RLRe0FCrdrtB2N75kINuMC6YnhaephfWlXEIEmICc09LUccKbGQrzdV
 J6q1bw4PL6rk4etxr6BUlabnejzYH7nObG3HJ913UwtN3kgWqjZy7+FipWVk5smwfZoT4wXymBk
 4uoHyvA8smaC+vj32EAEqZsWI+o62VXAz2aADlc6+TiSS7cjpwBhpOyZE3JqLVKFmb7evZNy9RO
 lbKnJAcApiJxLNMKAdR4x+/yYtll7JXEmnG5YiKYLSs0ZDvhxDQ3wdlfmq5ZvZA5R+EeZ1uWj/7
 nrFrKt01cX6eF55TD5ZS3V+GWn99HHgvHbDmZgbuLNGJ18X4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a data-lanes property to the spi-peripheral-props binding to
allow specifying the SPI data lane or lanes that a peripheral is
connected to in cases where the SPI controller has more than one
physical SPI data lane.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes:
* Renamed spi-buses to data-lanes to reuse existing common property name.
* Added to description to clarify index is peripheral and value is
  controller.
v2 changes:
* Renamed property from spi-buses to spi-data-buses to make it clear
  that we are only talking about the SDI/SDO lines and not the entire
  SPI bus (SCK, CS, etc).
* Fixed prefix order in subject.

This patch has been seen before in a different series from Sean [1].

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-2-sean.anderson@linux.dev/

Changes:
* Added maxItems. (8 is the most I've seen so far on an ADC)
* Tweaked the description a bit.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009dbdc80978f3afef84ddc688ade4348..a2d1b3d82799f6e93e274711eb57f3739eb8f405 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -89,6 +89,20 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  data-lanes:
+    description:
+      Array of data lane numbers that describes which SPI data lanes of the
+      controller are connected to the peripheral. The index in the array
+      corresponds to the lane on the peripheral and the value corresponds to
+      the lane on the controller. This only applies to peripherals connected to
+      specialized SPI controllers that have multiple SPI data lanes (a set of
+      independent SDI/SDO lines each with its own serializer) on a single
+      controller.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    default: [0]
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip

-- 
2.43.0


