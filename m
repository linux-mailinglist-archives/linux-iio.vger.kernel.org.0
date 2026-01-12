Return-Path: <linux-iio+bounces-27646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D60D14848
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91BA3043F30
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D437F0E1;
	Mon, 12 Jan 2026 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VO3pznIE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D323FC49
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239992; cv=none; b=Vc4FLUMQGyR72m/lmRLf0BusbtnwUtWZnyXsE+vl/JEuwCEks7Ig2ZcJL+JbHFhO2D+w56jinCGCZOgHPQjH3Q7y2u0DU/+t6fk0IKSD34OwFnd9rYcj0nrqp35bBWlDNQg+3atoSS6PeUlHrB+qr+kS1pJ+ZPVIOAIWNl2dkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239992; c=relaxed/simple;
	bh=cWc4yE87a/Ng/s0O57Wu6Nl1BtIIqHHRL8gFP/ptNJY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gFt+bpiR1s8lA7BaRThlkUlOWTZHICtsezEBlF+XMS1qFLHczNKLSZXSjEaoEQgMf3yKHN1Ao0dlgIgF6sWEUZO299Xu/xhvCCpz+n0tvCuSBflCvmQeUcLdEKfHT/3oaGd94j6HEzU1ApdHRq5+b4sFXW6PCahA5axu4YUD9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VO3pznIE; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4503ee5c160so4245731b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239988; x=1768844788; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78DS4N4jcu8uNb7b8H3HI1jiwdl1wZNwa4RPrB0L3TA=;
        b=VO3pznIEl1fEHtCTpxWxy5tw4Uf8ehSIE0E8/z4N3gyr7+imqyVEE9qoi86uvScXOl
         kVo9PyAjaClDT1FNzZ3EV/TFw/ZEgysHzu/TzAw1aXTG+O/Em2cQBi5J6hji8dViI1D9
         dbcIuFpWFlqTHZ3o966NA72vIEy0L6pZjixRsfFM76D6rzbDYS6qLiG2ih5V2IxLxxRR
         duU22HHRdo2Ohk+G58nmbiIJGmQS0dofo56jEzThTtHaPpe/aW45CJcbRi14qolsQOxk
         1F0aig9d30A7Od7M7eRR8wmpNplVHUb3r74/CE3Sq8JrgSo/rL2LKd8BbXHtY2UxhqX+
         t47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239988; x=1768844788;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78DS4N4jcu8uNb7b8H3HI1jiwdl1wZNwa4RPrB0L3TA=;
        b=VB/6MCQE4t8p0sXfvyOIJ0dFsV52abjNjHlG5ZbKIkYwzNRseMb5d5FygexRSosWhk
         KOlzixvPrznLigQJavMGX7DQw6JZp09T62mhCMYkRaZCkx6ccnQkINNCWi8MvD3TPTYw
         EuL6Zypv/3NJTjm4A5ZnZftgJOByBOP3kBv40/dFwyVm2kKjmugr6TlKxRdY41YGcKMR
         gO8WrOqkq0HmnhWWehBqIDmGcHQrLiuJVSIlzbNTl7IpdgNkhB/QeQ6D3niImA+UNoyj
         pYiMURW367qMGeHA984WDlVMnxKRjm6PFgJCE3HKYbCm4ENF5KFy6bp4pFGxAd9Pjg/F
         5ctw==
X-Forwarded-Encrypted: i=1; AJvYcCWT+jSrJqjf8wXOxwPwTE0f4noB36OIs+TWs4yGYxNMVL1/VTVurYnroURWORnlSDk136Gxtt2f8Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmJY5ZNEIBd1i+nIdJm3Sjiv+YUyVP/O5/k/GlzZVyan3JbNy
	2ulBZUPEwz5yWdPcUkw/hnenPUPkK7M9rg6Zwc7YnuV+wVmSBVqd5l/vK9NjTav7PRU=
X-Gm-Gg: AY/fxX4m5VenHnOR+4j5P5TGBQNwD5JMeqTD2Jvf069Htn5N551mW8wRu0/zBCvClyt
	3Kr2RETaD1HRQol8vD1HYx1iU5T3yc5fFfbFZ4AYjkVot8kPZ85OyI5Qp40uzDclouNA6IyJNOU
	ewyBSmrd3VptzKB9bt3P1S+MoQbK5A5w6QeGKJLJwhnLRHHJlvbmGz2zEmBnaTjmv3+HxVRpw0C
	je0mKiY/WZe3/O0ulXP2NIxTbMHOXHqemqqmOZYfnFcgt9kgwTSkJuDvOmY9yaRDTWjhtThavUa
	Iy+X88E13rx9MqRa9f5ELW83vFOh87V/MefHn5dqfXd3PnjTBm/hsNL2BeCLQJkjwLCy46ZJ70m
	VNAt1cDBHT6fIIuk08YNYDdg6kr7yvEacMsIjLa3MRCrlgc7yd07/494Zw4fuF7jABT+gMQdL9J
	QnBeTn1sTfpjbkZwoKGhq/q9tWKA==
X-Google-Smtp-Source: AGHT+IF/wvSe7WCb9OA69IFFRs4FyLlFTBuqj2r6THiKEs1tZXAgY0ddHd1FBCfDc5vZswZE+yCOPQ==
X-Received: by 2002:a05:6808:1455:b0:450:c79d:92de with SMTP id 5614622812f47-45a6be38892mr7616179b6e.41.1768239987635;
        Mon, 12 Jan 2026 09:46:27 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v5 0/9] spi: add multi-lane support
Date: Mon, 12 Jan 2026 11:45:18 -0600
Message-Id: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Oy27DIBAF0F+xWJeW4eGYrPofVRYYxg2SXwFsO
 Yr87yHOIlUVeXlHumfujUQMHiM5FjcScPbRD30O6qMg9mz6X6Te5Uw444pVoGgcPTXO0W5qk6f
 1FGmcxnEIiUItlGPKKtmUJPfHgI1fNvvn9MwBL1N+kZ5HUpuI1A5d59OxaH0/LbTHJX11JiYM5
 FE6+5iGcN32zbC1HlOAgdyZMgNllDNdWeCubFTzXZtr6+uAn/ndBs/8hQE77GE8Y5XRvNRCgHT
 6DSZeGGewh4mMCYlMHTQ4rMQbTP7BQO9hMmMglbOKM2ld9Q9b1/UOhqMqxuEBAAA=
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
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6149; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=cWc4yE87a/Ng/s0O57Wu6Nl1BtIIqHHRL8gFP/ptNJY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTMxKkXjDQv6PeSp+ULD/L8tGKHt3bPw/5k9c
 5qZr1kUBIOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzMQAKCRDCzCAB/wGP
 wFXTCACFgLAH2w4rIstilX7/DB9JG79Wed7hu5aGpZoO3bl7yuLKTHG+AmW9W1W0lQ85l3B8oF/
 yBBf91NrrC1gOpyXi0WDcPQrt+5viBt+aybQNZqH444nYDHOc8amTIgjcQQR6lQbI3ADh942Lbg
 HUScncVrQ8aWVoXQlcoIrR5U8lJOR297E5qDnL3oVh8zMQFoeXc6L1zcoNwCNG96DaGta059uFq
 8gNT92C3hqDI2avZwAr+d2ej7dkeGC1bbJmb0C5ngTv/8n7prsjdfku71oRCDPLEBNELYiRl4CG
 uL7AdHjLLhS6T7EU3y8V8E4OCQHkzKQyqrYubEMBci7Omfzu
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
Maintainer coordination:

Jonathan has requested an immutable branch from the SPI tree containing
the SPI patches from this series (all but the last two patches) so that
he can pick up the IIO patches.

Changes in v5:
- Fixed up affected dt-bindings for a new SPI controller that was added
  recently.
- Made some clarification and fixes in the documentation in several
  places.
- Fixed parsing of mapping properties.
- Link to v4: https://lore.kernel.org/r/20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com

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
 .../bindings/spi/andestech,ae350-spi.yaml          |   6 +-
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   6 +-
 .../bindings/spi/spi-peripheral-props.yaml         |  40 +++-
 Documentation/spi/index.rst                        |   1 +
 Documentation/spi/multiple-data-lanes.rst          | 217 +++++++++++++++++++++
 drivers/iio/adc/ad7380.c                           |  51 +++--
 drivers/spi/spi-axi-spi-engine.c                   | 145 +++++++++++++-
 drivers/spi/spi.c                                  | 116 ++++++++++-
 include/linux/spi/spi.h                            |  30 +++
 16 files changed, 676 insertions(+), 38 deletions(-)
---
base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
change-id: 20250815-spi-add-multi-bus-support-1b35d05c54f6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


