Return-Path: <linux-iio+bounces-27234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA73CD1F9A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04E7C30361D7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88917C77;
	Fri, 19 Dec 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R4k+IDbt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44025CC7A
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180011; cv=none; b=VqYR8SilSoObPv++2gSHyoaBVztog/3ghUfSzYN49Ni35T/dhYU/rL6njs3/FkJRl91wRKMZEpSACZw7CymPApUe/3K3NOqNAGVd8n90FxDY+QMa6U3hfTO2avFIxxFblyE3i4gSxv2VYb8RnEo0Zflf2iBWjnePo3H6ypBS5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180011; c=relaxed/simple;
	bh=7j7Mhbg90xSzHED8l/clDqlKrqKh2bnUjRe+8uj7ie0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pcFYAshgqTNkXMlHEIWRp/WC8tj8qiilFUY/6aGt5pukR/HF8Ickw8FFz0WvJf11RL+88E9u9IBtPIbgiXcyECVNMgLiplWdzO+vrrIDWZIWB2kb3fYgB83us7yyiBprhE7gxDHsaM81f7kTkphb6gMYMNxdWcEdlXK/6hIlZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R4k+IDbt; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6d13986f8so1830862a34.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180008; x=1766784808; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGq9VvIUtHaafoMX9MKtWZKVfVDLWd2Cnsr/0BUU6N0=;
        b=R4k+IDbthcRITWM2FPdL9O0hN9sry7k8Y+kPMapevgHy4ONWuqKhe6azytaLdPKAPo
         +s65WAPofqvOBS7u9f9Or8Vcbb1uTCpOhEfFftWmm+AWcUYi2IKPMlZ6IqPLxi2UmSNh
         9rmiH0g7/C7aL75UlvXdumqnjlv02US6QQeMOEmHf2sbfSU1Nl9AfNhhTm9UIGQnwDQl
         Gl2Nez2aepLUUBeIrk2uuTBdPEpbDj2I9lEtlNKpddFVrlOG3ItvV4a4hSt/plfIp13x
         WhTSodRJTtDlIpUjOOxFo97XNU3Zw+vg4qiwSnnIzKdrWJ3S7uhp7Ye9pSMEPwHKSvBg
         m15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180008; x=1766784808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGq9VvIUtHaafoMX9MKtWZKVfVDLWd2Cnsr/0BUU6N0=;
        b=nwDuouevxDs8LB7NDUJ4Gdz5pbANE6mlmb61eLPD+XcSdpuxxTgaG2r+zlJoWCPi/v
         CmbzCBE4svGUrRY2cwIKHDb06yLfIk/rMnOty6otnbIpjcryZcekDphEot1NAQvC0jzI
         UmiPzMEbIsQK1XNI5OJo9y51MX9jQHhY1DdjPTNRuF0rpqdD6BjyWEg/lln/SO6NrWom
         CzUZgQTsvCKqKF31xoJ7sLYAZ6WEyBAPXnYE7A72kpZMlMqJDUWrUkVl5pbt3SHeEnSO
         cVzH7/+C82n/e4X2YOY861f1aaznuaSMFi2Hs4sV1bP1XPown8kZtnHLlOF8rBsPAc2M
         eK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhfIA1EJq8d5udOGdOTIorQl2iJR/PdTuFTNMtqCM6s9Wbw874liuEqT05RetKr5rVBDRAnzWd7oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQANY380rm17Zf+P4yfP667yItnGddRmVqnHR//c0HC3FLduJ
	4Q3E/PweHuuiqWOXxhI5fZHEriLJqxCmnZtWANcwLavKYGlh9cgqnmKTlLSjxFClgDc=
X-Gm-Gg: AY/fxX7BsOc63T+vuVyzhHn9LUrfEUos2hmyT27y1HNM6gc1mngqRblvgbwLwAedauA
	AReJofghlx+jiSpxhfczhyME+TqPPiL1yKp/dxwc0MvejqsGcSshvpP0I6gQ65KXbzLqXg5RVw2
	DjjUqmEYVxBQ39pgU7H8MANKz02sB6MQcTy0XuvZBk52Z0DJabJQI/AUCPHHTZsdStri1jD22mE
	A6r8KoPfJa9J5264N9Kai5iN3kspwDCXwp37dZlo8hgK9p2vajEhRs1OQRePmFzgT/MfBtNBSNJ
	CGsMjygd8FYU3s7UKTB69ynkpTbb9nAvQmDQyK0QouoBZPd+78OCpqNw+AE+kFXD+bC9zvMsJ6X
	JiDW4608dr1YwaFmbmGHQehhw4Lu8hP7RofUWq6bhojmVRx9/Du5JAl4Toq0pM06jezn48dUQh4
	1Xj83Gd+1DHSf7kQ==
X-Google-Smtp-Source: AGHT+IHT+jQUaBkRwcfZMx50SHEhmDlF+7KC5RBX8VWqbplJItdm2aIku1mBWh9Rd41kLXnoreJuCQ==
X-Received: by 2002:a05:6830:2463:b0:7c7:538a:c6fd with SMTP id 46e09a7af769-7cc5926f92amr3264434a34.12.1766180008123;
        Fri, 19 Dec 2025 13:33:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 0/9] spi: add multi-lane support
Date: Fri, 19 Dec 2025 15:32:08 -0600
Message-Id: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Oy27DIBAF0F+xWHcihodjsup/VF1gM26Q4kcBW
 4ki/3sIWUSqKi8v6J47dxYpeIrsVN1ZoNVHP405qI+KdWc7/hB4lzMTXGjeoIY4e7DOwbBckod
 2iRCXeZ5CAmyldlx3WvU1y/05UO+vxf76fuVAv0ueSK9H1tpI0E3D4NOpGuma4DmDAg17Fs4+p
 incym0rlkb556h2zlgReHZM06Fwda/7z9beLr4NdMhTBV7FG0N+3MNExhprRG2kROXMP5h8Y4L
 jHiYzJhVxfTToqJF/sG3bHpoicvCQAQAA
X-Change-ID: 20250815-spi-add-multi-bus-support-1b35d05c54f6
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5547; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7j7Mhbg90xSzHED8l/clDqlKrqKh2bnUjRe+8uj7ie0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpRcRjMtzknafQySd4Eu28JCWxvVFH5PYmHeQM7
 uiVAwQs5JSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUXEYwAKCRDCzCAB/wGP
 wBEcB/45ZOyTag78NIigTuDGygj4v6mfQzOcQ2nC+XRi8YWqx8pJa6jbSi1HnQad5ANPVdKhJNU
 0bLei/xudpOG0rGHdLBTkO0/fsv755o6tLr9JQ0TuGlw1Rcum9hI7os1GHcBpVlraR7J66MAZ0+
 Y+kEfO23CaV61V3tNT7gpOzLcENlihSnUyyeyspYvdyiGCBI+46Er1iFmn7PVFNuZHuunsCjPYO
 6/s7Tmz2LmcVVwG1O/MOHJ25jIoLqKaBhI6VQ2I+KDfWZRaI1hpAogtpVkzBjVNcbopbVW8vB4z
 hbn3rSnM0U5xHUX6BND/IH1v6PI2S0++w9Wk7+0mJ6BNkGTX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This series is adding support for SPI controllers and peripherals that
have multiple SPI data lanes (data lanes being independent sets of
SDI/SDO lines, each with their own serializer/deserializer).

This series covers this specific use case:

+--------------+    +---------+
| SPI          |    | SPI     |
| Controller   |    | ADC     |
|              |    |         |
|          CS0 |--->| CS      |
|         SCLK |--->| SCLK    |
|          SDO |--->| SDI     |
|         SDI0 |<---| SDOA    |
|         SDI1 |<---| SDOB    |
|         SDI2 |<---| SDOC    |
|         SDI3 |<---| SDOD    |
+--------------+     +--------+

The ADC is a simultaneous sampling ADC that can convert 4 samples at the
same time. It has 4 data output lines (SDOA-D) that each contain the
data of one of the 4 channels. So it requires a SPI controller with 4
separate deserializers in order to receive all of the information at the
same time.

This should also work for the use case in [1] as well. (Some of the
patches in this series were already submitted there). In that case the
SPI controller is used kind of like it is two separate SPI controllers,
each with its own chip select, clock, and data lines.

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-1-sean.anderson@linux.dev/

The DT bindings are a fairly straight-forward mapping of which pins on
the peripheral are connected to which pins on the controller. The SPI
core code parses this and makes the information available to drivers.
When a peripheral driver sees that multiple data lanes are wired up, it
can chose to use them when sending messages.

The SPI message API is a bit higher-level than just specifying the
number of data lines for a SPI transfer though. I did some research on
other SPI controllers that have this feature. They tend to be the kind
meant for connecting to two flash memory chips at the same time but can
be used more generically as well. They generally have the option to
either use one lane at a time (Sean's use case), or can mirror the same
data on multiple lanes (no users of this yet) or can perform striping
of a single data FIFO/DMA stream to/from the two lanes (our use case).

For now, the API assumes that if you want to do mirror/striping, then
you want to use all available data lanes. Otherwise, it just uses the
first data lane for "normal" SPI transfers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v4:
- New patch to change spi-{rx,tx}-bus-width to array. This will cover
  most use cases.
- Split data-lanes property into spi-{rx,tx}-lane-map. These properties
  are now only needed for special cases instead of being the primary
  property for multi-lane support.
- Didn't pick up Rob's acks since all DT bindings are significantly changed.
- Rework other code to accommodate the above changes.
- New documentation patch.
- Link to v3: https://lore.kernel.org/r/20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com

Changes in v3:
- Use existing data-lanes devicetree property name instead of creating a
  new one.
- Renamed "buses" to "lanes" everywhere to match the devicetree property
  name.
- Clarified bindings description about how to specify data lanes.
- Link to v2: https://lore.kernel.org/r/20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com

Changes in v2:
- Renamed devicetree property spi-buses to spi-data-buses. (Driver code
  was already using spi->data_buses, so it matches).
- Fixed a small bug in the AXI ADC driver changes.
- Moved one line of code in the ADC driver changes.
- Link to v1: https://lore.kernel.org/r/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com

---
David Lechner (9):
      spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
      spi: dt-bindings: add spi-{tx,rx}-lane-map properties
      spi: support controllers with multiple data lanes
      spi: add multi_lane_mode field to struct spi_transfer
      spi: Documentation: add page on multi-lane support
      spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
      spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
      dt-bindings: iio: adc: adi,ad7380: add spi-rx-bus-width property
      iio: adc: ad7380: add support for multiple SPI lanes

 .../bindings/display/panel/sitronix,st7789v.yaml   |   5 +-
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  42 +++-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |   5 +-
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  23 +++
 .../bindings/spi/adi,axi-spi-engine.yaml           |  15 ++
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   6 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   6 +-
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   6 +-
 .../bindings/spi/spi-peripheral-props.yaml         |  40 +++-
 Documentation/spi/index.rst                        |   1 +
 Documentation/spi/multiple-data-lanes.rst          | 217 +++++++++++++++++++++
 drivers/iio/adc/ad7380.c                           |  49 +++--
 drivers/spi/spi-axi-spi-engine.c                   | 145 +++++++++++++-
 drivers/spi/spi.c                                  | 114 ++++++++++-
 include/linux/spi/spi.h                            |  30 +++
 15 files changed, 668 insertions(+), 36 deletions(-)
---
base-commit: b96bcfba104c65db41378a04f5ccac186f79578f
change-id: 20250815-spi-add-multi-bus-support-1b35d05c54f6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


