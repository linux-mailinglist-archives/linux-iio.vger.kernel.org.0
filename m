Return-Path: <linux-iio+bounces-25064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF488BDB892
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A294216C8
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230A2EA47F;
	Tue, 14 Oct 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nq+wqQur"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153112E92D4
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479386; cv=none; b=kOSomJBhkFQ6WbTp4HvTnNlZKji4esaFK8IZ9wLNIfP/ikqz88I0EaEzTkDSMuNGXfmIPlgj332qar1EAV+328aHAQ07Ik8o36eVobv2QBoZaXEO44mlVtopuJDbYZxrcMnNBewWnliyYIimb0Ohy22jV/mRBX4EuUDaodLR2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479386; c=relaxed/simple;
	bh=vYt5j/TlrATD/NQ86XcdaWp5A87BK8f5MKugqBE/r1Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZasHvG2ta1Ut8fQmZ/euvw44uZ68yrWWMt7cad5mrbpGnPB8ROsAtz+TbG1vaIKHjSubTH2haMdWmlgBwy2b2Az1FUASbXBRj1GNw/CRXzhz1bVts73hOcS712EfxHff8S3RuaMULFFTxkIQebcjFtUjPkAkOugN7aTWO2huN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Nq+wqQur; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43f9cc65f66so2961909b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760479382; x=1761084182; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Unn+1ZYz7vvp7AnQvc4v91fgV41lOz1ySt2oX0dZY=;
        b=Nq+wqQursYufxYfscZhuWbsBQVHLBIxwlYYQmeJhNxz9u35+8f1KzaZOVhhGE12J42
         Iu9BF5MX3WcSMowab5hD1CjywuaPQ4L6K9ZmmIDUc9n36XPDBihDDPmq5flVVQTjaUlN
         JVWOoF7rGn0085JNXpNJeWobZR0FWt81pQ/Pa2ErAeP21belZYkZZ642pI73amwwNsoP
         PA+YDY0vBaxiswW3GO0fieBTRYDGlm2pQMVybLH0KKfgKWwp4K0DlpJrNLGAiCzDz7Pl
         8oQsOXKQsksOAlaHVySyWxN1H0GrIaVCaDJtud+CGph+tiVOSzMsVbc2V9VoAs/Lwndv
         Bg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479382; x=1761084182;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5Unn+1ZYz7vvp7AnQvc4v91fgV41lOz1ySt2oX0dZY=;
        b=JvoR88SB7ktzsXp9+WKdULSYx0ueUWcAwplzMvkanQDv5OSP8VTuAIjJKzN+DKlCQ4
         kxH1ppnIxlR/GUzyVzfQHRWz29Fv/a8/LhA2PfpLPUDnZZoB4aDn/+l3L9/2ww3h7OKM
         RCHi/g3DhJqkAhCv0wKXbPKHOQW5/bxZpsxSprWg7Gkpmce/bWrF1die865uJpOUFScu
         ht8aWqnhAw0ROweJRmG6s1Ljh+AoWb5rszAyWnGUDnZtIhopuCnARfbLNS+WS7CfCsCr
         SuqVouQl9tovMxh3qiZYVmztElcewzFwFCcnElZd7wbG9BbRli9ujtaSAicctMxpMcz+
         iwGw==
X-Forwarded-Encrypted: i=1; AJvYcCWZbmnr71i9eNMupGTEeH86slFg+pAJlSA1JQC9217E2WwKUygzcxb2isPckT3TgitkYjZMcWLhYIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkC9bjZnpQ/LgpeqycFZRJf71ZHLkK+06CUwCFTxourIkcdlG
	IxreDErIAJ1nyJAjQLMdbYI7rQ7dZX9N3EdhMt6+bGoZUIJqhvddBkGGvY2NPAG1poY=
X-Gm-Gg: ASbGncsYyc3898bDIxsn7YC2qFFLXfjdV3P1VQDOlFQ9METsBsZFjmZT3hzz4bIAZ2D
	FlW1MEKBUJ1E4rqrkI2Hgz5trLRgTADMusZrci0/CqwNJJtYk10FEuDLrEgKwgQW9dTCHZrK8Hr
	8pvVeLo5MjP3LzujWSzP9PB/QspH5YE8ohgBjhh65MTfY5o4DRNZ1IPW+DSf9fnx0devkPTcpWt
	yR06LS3+/pMJ6ryaP7KiH0cWomQ/Gn1nzX8Ue/oy4Al6BRFUQ/khZ7eKWP6OeqZ4B9UMkPAp9Uo
	DaNKiyUb1QCf4r9M6xHnnllGg/8f4zFFsCavnY4DbaoYfZ0bqRibxee50Ji4WOBzUXu93dW3G5/
	qNihQ2NvMf2KbSAVX+ISM5+mAVUBwhSnF/xK1k9xAcuntyg==
X-Google-Smtp-Source: AGHT+IE+CBP0iv12dN4nWZ7tB3t9Nd6SFbCgUncDxvpjJou1Nlvao0Jn/IzjdN0UJ9Z8zy7lLZya9g==
X-Received: by 2002:a05:6808:1987:b0:43d:6b7b:2469 with SMTP id 5614622812f47-4417b345606mr12410216b6e.4.1760479382072;
        Tue, 14 Oct 2025 15:03:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419895119bsm3593732b6e.21.2025.10.14.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:03:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/6] spi: add multi-bus support
Date: Tue, 14 Oct 2025 17:02:10 -0500
Message-Id: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGLI7mgC/y3NwQqDQAwE0F+RnBvY1UZKf6X0oG6sgVa3ya4I4
 r93aXt8AzOzg7EKG1yrHZRXMVnmAn+qYJi6+cEooRhqV5O7eEKLgl0I+MrPJNhnQ8sxLprQ9w0
 FRwOdxxZKPyqPsn23b/efld+5XKR/eBwf2ZLh6oAAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3365; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=vYt5j/TlrATD/NQ86XcdaWp5A87BK8f5MKugqBE/r1Y=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7shlOFDubLGnSukbfE3OlGb/pY8YoyhJLgw/R
 mMoykxBEM6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO7IZQAKCRDCzCAB/wGP
 wOpZB/wNynUwGKOtXcET2BIJeukjC/PRR7cZhkHzspPFnUfUcr23lmQmjvgPvG4DzEntWSObWmh
 /75q5dHDZu1vTbxc07k9RbeeQwVpfZ9RC50orUwupgSSV+Iz29aWouyq7/jhwd0DcgeLh9hHnC2
 a8yy74/daBzQ1BSL1iMetX5U1U+c09OUJOxHae1HmsxRe3+SKvFVFrYBYSaE1ZRJgeGdXoz4k4E
 laQKZxzEagqxse61waRNceAoZeIO8mn7CoM5zLqtEqk72pzRmLhtx3ZF02M/AWfbhl0GYAz/LuX
 5+x7IKhX+Q8SJI/1g4UEvmRH9fGZZfgy967tBIWjAFJJ3WI4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This series is adding support for SPI controllers and peripherals that
have multiple SPI data buses.

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
David Lechner (6):
      dt-bindings: spi: Add spi-buses property
      spi: Support multi-bus controllers
      spi: add multi_bus_mode field to struct spi_transfer
      spi: axi-spi-engine: support SPI_MULTI_BUS_MODE_STRIPE
      dt-bindings: iio: adc: adi,ad7380: add spi-buses property
      iio: adc: ad7380: Add support for multiple SPI buses

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  22 ++++
 .../bindings/spi/spi-peripheral-props.yaml         |  11 ++
 drivers/iio/adc/ad7380.c                           |  41 ++++---
 drivers/spi/spi-axi-spi-engine.c                   | 128 ++++++++++++++++++++-
 drivers/spi/spi.c                                  |  28 ++++-
 include/linux/spi/spi.h                            |  23 ++++
 6 files changed, 235 insertions(+), 18 deletions(-)
---
base-commit: 40d3910fa7980ad3c211837f1a0ded5dfa36779a
change-id: 20250815-spi-add-multi-bus-support-1b35d05c54f6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


