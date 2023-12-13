Return-Path: <linux-iio+bounces-881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACE810FA7
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 12:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E4A1C20967
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F17C23767;
	Wed, 13 Dec 2023 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hlmHtjci"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0649EB0
	for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 03:21:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3363880e9f3so508094f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702466485; x=1703071285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2AHGVRImv1il3RnA/w9BXBJjGCy0x5OVgjGmOLgYFc=;
        b=hlmHtjcitGDBPFCT1zwI3cs+oXTD1zvxN/C225Xg4VTWYg/77Xe282bOZgoQuDgRuH
         wREMhHUGbX3Nr6dM+dedYbyPAZO/RXHc/8W2fTu7teFQleEbchtjWdmkeOnxKtqYjhRx
         vzflK6RMxijoWjRY6zWmAQa/7eXqQxasGIpPy6BRiHPnAV+y1DuH+++/CyCZ+BnioYT/
         vwc2PSsDm7ZPjb1YZw3sgf6ntXr37lG1uEFjAJ1Zviptn5+Y7RkDamHAXK2/y8bTLyAu
         s3bRlpS2Qz1X+k8CjB2Y7cZ84u3gadmC7sVUf+bAiubOg1jk/zqcbjHoFsi7JbyPKf5F
         k40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466485; x=1703071285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2AHGVRImv1il3RnA/w9BXBJjGCy0x5OVgjGmOLgYFc=;
        b=aZNY+dG4KYlyQ6hHIEFjtYKVa6wsrdP+nB3U73axxwPnHYnAtJjbap2wHaNg5eFN7h
         Mp+CAZinsYOjUxQYBYHHaqImZn8N1QYE/ogijA2x+n5Dhhw5JumG0bf3RrIGhN3oYTWI
         6pqVUv4Eg5ujIMPQZbcngEomr+cM8o2XqbcSWPqzXTdB1StozZ3fxX7bbz9boVQT1Tl9
         dbB8MIMCXusAmZxT6ydtAhLmFdAVoTLeBGx2EwkJ++k0TxkNDQtUZ6elRR3di2wW6YTa
         2WRLSZDpnRC0e4cMoordNaT+M+RiG3MPa1WzipcpaLZKNk3vo3bFXyP3dh4NjE35CRI9
         fk5w==
X-Gm-Message-State: AOJu0YxtAsmk1jzGZpXBpYsYOfCi9ZJWM3Vnfmaxka0KMwWLvELpIDeg
	M58XS9S+6DPJV2HlkioRjqk1bN5MeiF5UN+x4ffH0A==
X-Google-Smtp-Source: AGHT+IFVI+TLiwSXwc7P7MOM6V6DxExpmSlZzse8cfnx9paa42CxQXBNLMcBOinYvQsp7gC6p2UR9w==
X-Received: by 2002:a7b:c4c7:0:b0:40c:38dc:f6bf with SMTP id g7-20020a7bc4c7000000b0040c38dcf6bfmr3804161wmk.113.1702466485292;
        Wed, 13 Dec 2023 03:21:25 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm20097617wms.7.2023.12.13.03.21.24
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
Subject: [PATCH v2 0/3] iio: adc: add new ad7380 driver
Date: Wed, 13 Dec 2023 05:21:17 -0600
Message-Id: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This series is adding a new driver for the Analog Devices Inc. AD7380,
AD7381, AD7383, and AD7384 ADCs. These chips are part of a family of
simultaneous sampling SAR ADCs.

One quirk of these chips is that since they are simultaneous sampling,
they have multiple SPI data output lines that allow transferring two
data words (one for each input channel) at the same time. So a new
generic devicetree binding is added to describe this sort of SPI bus
configuration.

To keep things simple, the initial driver implementation only supports
the 2-channel differential chips listed above. There are also 4-channel
differential chips and 4-channel single-ended chips in the family that
can be added later.

Furthermore, the driver is just implementing basic support for capturing
data. Additional features like interrupts, CRC, etc. can be added later.

Also, FYI, this driver will also be used as the base for an upcoming
series adding AXI SPI Engine offload support for these chips along with
[1].

This work is being done by BayLibre and on behalf of Analog Devices Inc.
hence the maintainers are @analog.com.

[1]: https://lore.kernel.org/linux-spi/20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com/

---
Changes in v2:
- dt-bindings:
    - Added new patch with generic spi-rx-bus-channels property
    - Added maxItems to reg property
    - Replaced adi,sdo-mode property with spi-rx-bus-channels
    - Made spi-rx-bus-channels property optional with default value of 1
      (this made the if: check more complex)
    - Changed example to use gpio for interrupt
- driver:
    - Fixed CONFIG_AD7380 in Makefile
    - rx_buf = st->scan_data.raw instead of rx_buf = &st->scan_data
    - Moved iio_push_to_buffers_with_timestamp() outside of if statement
    - Removed extra blank lines
    - Renamed regulator disable function
    - Dropped checking of adi,sdo-mode property
    - Added available_scan_masks
    - Added check for missing driver match data
- Link to v1: https://lore.kernel.org/r/20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com

---
David Lechner (3):
      dt-bindings: spi: add spi-rx-bus-channels peripheral property
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 107 +++++
 .../bindings/spi/spi-peripheral-props.yaml         |  12 +
 MAINTAINERS                                        |  10 +
 drivers/iio/adc/Kconfig                            |  16 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7380.c                           | 464 +++++++++++++++++++++
 6 files changed, 610 insertions(+)
---
base-commit: 18f78b5e609b19b56237f0dae47068d44b8b0ecd
change-id: 20231208-ad7380-mainline-e6c4fa7dbedd

