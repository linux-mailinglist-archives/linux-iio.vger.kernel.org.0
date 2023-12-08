Return-Path: <linux-iio+bounces-765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469680A7EC
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 16:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DA2281724
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4511E31591;
	Fri,  8 Dec 2023 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2GNma6WT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71911723
	for <linux-iio@vger.kernel.org>; Fri,  8 Dec 2023 07:52:37 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d9d307a732so1355322a34.1
        for <linux-iio@vger.kernel.org>; Fri, 08 Dec 2023 07:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702050757; x=1702655557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUg/znhTOIWnO1n9WUNrCkz7MCYRa0cNRXdZfa57rxM=;
        b=2GNma6WTvnX2ZM/RSDQ3MEaemiUC4QZ9NKeWp4HNL4R4GlzzPFOUQ7Q3Kb6OODPv7l
         SishtNxHzlh887P27mgmLOMYvkyGtyBkBjmmBH8qaQJyNURnRraK8BQ3URT0glCixsME
         dTt8kyuJDkwcczuBph+N76QmFCeC89t7vRuerzRqq5cb5YuHaatYPWld0aI6hsADby29
         ClYz3vvLc4yYWM3M2R74m6Y8UEBYyqUaYAn+ZKqWF3ApqtTvn+vOUYP5rsfCT1XmdQ0x
         zhLE1HoXwkm+LLL6jmDPJqYRpTNN0nOhAl81l3AOe3z37IRMRm5dU/pbXtO0hgw2p3N8
         qxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050757; x=1702655557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUg/znhTOIWnO1n9WUNrCkz7MCYRa0cNRXdZfa57rxM=;
        b=t51sfbirPkAo3n3czpvtfRzAzgLzHboHbkqTHXWZV3iUfwHjbCJNafhlBWkcjatXQP
         zCbryb7LLBvxFu+bf/tNPt8UWLvAREHf++Mk8k/dMtn/kDkpK1IfVcPxtSu1DKio2dNq
         9YjJa+4ErdCw8Fh2BWMA/yLV8NmmXgbfpPYcjutklAkDya95GN0xZS4blPmsUp86goHg
         +cXbcJFNeICb4hNpGlHGPkGeVTbpkZfqYJO7nGY5CE2RYYGsUxnBzUZ4S9q1CL8D89B5
         MV7CSMXAk8KQxr/JU2cQTBvu4t7DG8y2WpheQ3QMe1ynXHchZz5Zf9q2YnpD8q6BTAhu
         31WA==
X-Gm-Message-State: AOJu0YzHfxl3DqIJ/Od5TRUiIPR1nO/BeVOIWnb3Wx7fhjo/6fXdvx2h
	YOoGBkn9V/RTY38DfSYEXftu+Ugmtg4kZOf5QhE=
X-Google-Smtp-Source: AGHT+IEvZm96yDwkXa4CYNB62gvIRQrwcn8Dogy1yVqamELwSIJAM+evvjcjOg0JkXwSpAfPt97sTw==
X-Received: by 2002:a9d:7519:0:b0:6d8:4bfb:eb4c with SMTP id r25-20020a9d7519000000b006d84bfbeb4cmr242635otk.9.1702050757188;
        Fri, 08 Dec 2023 07:52:37 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id v3-20020a9d7d03000000b006d99d363723sm332032otn.63.2023.12.08.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:52:36 -0800 (PST)
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
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 0/2] iio: adc: add new ad7380 driver
Date: Fri,  8 Dec 2023 09:51:39 -0600
Message-ID: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
X-Mailer: git-send-email 2.43.0
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
David Lechner (2):
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 102 +++++
 MAINTAINERS                                        |  10 +
 drivers/iio/adc/Kconfig                            |  16 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7380.c                           | 467 +++++++++++++++++++++
 5 files changed, 596 insertions(+)
---
base-commit: 18f78b5e609b19b56237f0dae47068d44b8b0ecd
change-id: 20231208-ad7380-mainline-e6c4fa7dbedd

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


