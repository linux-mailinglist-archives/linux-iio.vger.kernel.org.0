Return-Path: <linux-iio+bounces-26034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3247C41A52
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEA0420B8A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652730F7EB;
	Fri,  7 Nov 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yprmy1Z9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1830E846
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548825; cv=none; b=dzZ2/6HFXbiEpu07QSRHDR4sonbJC+tJkL6d63JUH6g3FzfykUJTzoWFjskDt+6gSYH5wDz7SNyTdNqmyRIi5XKBZ8rmJXmsrB8Vt6RZnePdgWPH6MAFvEctS//fw8r+GNy3ZYDrH+gBgvaIbPZ3X4gb9u1N79ar/2Ixah/i64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548825; c=relaxed/simple;
	bh=EpVgqo2v/0JBXNziS+eCmvU2qI9GWnrR9mDBLBMOyJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UFe/q0DetKbC2O13/flyc/K6tPh+FoXjfWEf0A1JZyP2N5JR6QntfcqWjPnN3h57CgoF5KR5dKkVHmfVWHFNJBfJAh511Ya33qHdCR2UCC+GODmuWmvej6klJhn3uOGAeqdohYsrTzDDqaDeM7+myP1Neu2alTX+eZ19a31a/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yprmy1Z9; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c290b18a76so737588a34.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548823; x=1763153623; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gOuYDt+s1jtJNdWwVbx2gWl2Jr6Jhg5Tz5DiyqP1X0=;
        b=yprmy1Z966rIFlM+qGbh1I1KSht4ihc8O2DXeNR4cSzL91SRsC2o7mtlXOoOaaW/Eh
         DniRONBYs/zajJYb+rmqmQxAcdyhS2W709r+Yj88OFyy/SsGuZnaJBThs/U6ec6HNTAM
         3FUj8S4Mye/+lj1KkwNK0EaT+UIATa0m+cKaHKTtmGVD9ElDz46fsyzW0VSSwpdrhlIt
         Hw/aDnU61PX4Dbt1NBtC5Ug5DU1kvRzosDKRhtce5FTbLgr+EvyQXLRdXL22zq+rdHlB
         eOqUOVlBNzw+oqc++PQt/WqwPKyxgBi0Bq+TAIyx8QVPMy/EfTlhadmdv4q3ffTtBVcb
         H+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548823; x=1763153623;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gOuYDt+s1jtJNdWwVbx2gWl2Jr6Jhg5Tz5DiyqP1X0=;
        b=vADCiJAsyMS2Hzsr3UtxoV1jnpmSVvFT3ej/3Y6nMtNHcNFz/BHBc033FMt2W9297M
         NPjIxbrWZhdEvQcPgF1ePxaPOJyr4hdWygHB3sh0tBIil1/JAzK+Ce/B1rkTRTiEQNm6
         ogxwgEytfWE4Z7xKCdI2wn3c45o6QZI+89lEUOBYOH8Z29q9ArJ+Ay/gwi1NUT/XDobX
         qTEfMRDnCs5+DT/qsASvAVfHcdRowJ/Oc3qHy/PFULK4N3/dha4Sh2Qm8K2clGOjvVos
         ov1hiRTRsth/xiiuflYb3fLrkWgq6+ApwN7lbgtFLDvxNYTLzv8lwU9BUuDoxgboutP7
         tfIg==
X-Forwarded-Encrypted: i=1; AJvYcCWpOtSXkbjvH0ZYdpO03DGdT3Pmg4PzrgbkWhjTtnKqrqdgKpcaO3HusqPYKvJSDRkG1DYf9T/Ltmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmfSbVr0xNWKlSg7A4Co/CPtWFIs9s/RzIq8/m9/CkN1DiFkR
	oneY4ALbBa44pRH+Q2Oumj4yFvS90GmjT/QiUX/Wl004I4DZ6KM2lrDs4Mh0FJvpL9I=
X-Gm-Gg: ASbGncu9jReGpeMt0GTxukNPj85Xa291JYO+PpJ35hCXtIDtim/il4hyElNN7n1SlUj
	IXnL+DD2iEjBqPPDE4lz6Vai6QkHNIlQVo02N3i5gQVn9F21Cg5ncvNqGfI6dMjPhIdkKQqa2/E
	rLkVcwO6gnIlLL5JLZyaVK82wgzck0/EsOGGF6z6K90ZCBsp4PnPP74wYjon0mbZNclWDQ9FudF
	P+0x2RTz5Oa1XwT82Z3tfeb5agjBMhwBgCvUR1dAZdoYfBlyCag95wRAvkdHw37LTFBqSKe/KXQ
	gq3YCymO13u2YKQOL8mAOz8mzcRI/KjT9yTrKs9IWJ36wy2MJuu0kwOt4LEWDK0NGxHsdxTpq5c
	UO8WmjoRfNHMU9tGV1xn1ibgqYLTeg5N/CYaukOipkpm9Q2NhAnEOwSy3qwW6zxHhY6Y8uY/LgU
	WtCewl
X-Google-Smtp-Source: AGHT+IFXl+nfu0q8+xI0hJxiOW52RV8VlfHFe9go24ubMqqAb1xpi3RHHUr4UHdBzwIkl2Fv+CCopQ==
X-Received: by 2002:a05:6808:2210:b0:44f:8f02:c75a with SMTP id 5614622812f47-4502a321198mr396341b6e.1.1762548822596;
        Fri, 07 Nov 2025 12:53:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/6] spi: add multi-bus support
Date: Fri, 07 Nov 2025 14:52:46 -0600
Message-Id: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5cDmkC/32OSw6DMAxEr4K8rquEEtqy6j0qFoSYYolfk4BAi
 Ls3wL7LsfXmzQqOLJODLFrB0sSO+y6E+BJBWRfdh5BNyBCLWImHVOgGxsIYbMfGM+rRoRuHobc
 epb4pI1SpkiqFwA+WKp6P7nd+ZkvfMSj8eQRdOMKyb1v2WdTR7HHXSCnusAM1O9/b5dg2yYM4/
 kImf2ZMEkXoeT5KGZu0UtVLF0vD2tI1qCDftu0H02BJT/YAAAA=
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3831; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=EpVgqo2v/0JBXNziS+eCmvU2qI9GWnrR9mDBLBMOyJ8=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGkOXCWjOokw1YvHZeERiY9tQ7lCxYJJapSJOmws90Rt0RNVW
 okBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJpDlwlAAoJEMLMIAH/AY/ATXMIAJed
 rE8vL5+a+BrfFb//ZywMaqJHgbc6yfLEwR1QYIVbcFdkuVUwckiftr83YA9YPVs3adFkT6+jYju
 dVzMj6AlOFSdRSJMSSKY+ZzXd4wvMSEgvjx+eFeqCte1u4SmVjIrL+jqOEFfx/8gJetez2VZFsd
 oqdHK8lp4Yskptr+uv5hkSileILVb83Uv/vpPBBt/wbZlUKWSLM5CMhkDbWQfoBhygNwuyHXduo
 VNl6l2l2UotMuJO9yLvCNXVzb0eB6X5bKLNzsVbPsv2zES3zBf+5vP9fUwsFpiDU0Gd1FxQSE+5
 TqHw4FlobsZW1kY1LECU4OrvsFKgHpZ19w6fK2k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This series is adding support for SPI controllers and peripherals that
have multiple SPI data buses (data buses being independent sets of
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
When a peripheral driver sees that multiple data buses are wired up, it
can chose to use them when sending messages.

The SPI message API is a bit higher-level than just specifying the
number of data lines for a SPI transfer though. I did some research on
other SPI controllers that have this feature. They tend to be the kind
meant for connecting to two flash memory chips at the same time but can
be used more generically as well. They generally have the option to
either use one bus at a time (Sean's use case), or can mirror the same
data on multiple buses (no users of this yet) or can perform striping
of a single data FIFO/DMA stream to/from the two buses (our use case).

For now, the API assumes that if you want to do mirror/striping, then
you want to use all available data buses. Otherwise, it just uses the
first data bus for "normal" SPI transfers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Renamed devicetree property spi-buses to spi-data-buses. (Driver code
  was already using spi->data_buses, so it matches).
- Fixed a small bug in the AXI ADC driver changes.
- Moved one line of code in the ADC driver changes.
- Link to v1: https://lore.kernel.org/r/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com

---
David Lechner (6):
      spi: dt-bindings: Add spi-data-buses property
      spi: Support multi-bus controllers
      spi: add multi_bus_mode field to struct spi_transfer
      spi: axi-spi-engine: support SPI_MULTI_BUS_MODE_STRIPE
      dt-bindings: iio: adc: adi,ad7380: add spi-buses property
      iio: adc: ad7380: Add support for multiple SPI buses

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  22 ++++
 .../bindings/spi/spi-peripheral-props.yaml         |  12 ++
 drivers/iio/adc/ad7380.c                           |  42 ++++---
 drivers/spi/spi-axi-spi-engine.c                   | 128 ++++++++++++++++++++-
 drivers/spi/spi.c                                  |  28 ++++-
 include/linux/spi/spi.h                            |  23 ++++
 6 files changed, 237 insertions(+), 18 deletions(-)
---
base-commit: 1a26618e7466b8d825989201086c235e76aa999a
change-id: 20250815-spi-add-multi-bus-support-1b35d05c54f6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


