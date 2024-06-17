Return-Path: <linux-iio+bounces-6417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E195990BB7B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E651F225D1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8618F2D3;
	Mon, 17 Jun 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GxTWFREL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1017188CDE
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654226; cv=none; b=knCCbZ52ltycSxGhcgGlXT/P38/PrkAtYhk9lMs1mD+jn+vH7vIDEp1jY3wPsLAt3RBP8ipbsTEmqbNlN/PkMqqhWvHRgyqr/lhplvSrT0TKiya5S7XLHSamdK84P3GSpykSmEjj+m6bY2SsGgGwknviWYziZ6iblMsB/+jfBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654226; c=relaxed/simple;
	bh=s9reazg6TBFKFG2f9Ng//E/D00yIl1rxKSsErYw3Eew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCxAh5oefmSePrw4GT0svW5iObDPAQp9YGoXDLJbd0ifhPnReHNfdKAkYeV4LRnz5o5Pj4SHw0Nk6cvZMWwmvtEDvooKC62rFHsTOQLnOLwyZElcpAAXHbeeKmL6QXF0DXHIJyEh8GoR0ZdlnCEBSCIw4h7wnVZLU0XSDpem1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GxTWFREL; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9c36db8eeso2593430b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718654224; x=1719259024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjDdICWQ2oaGVdfAV4oGUq0PgukKKOkUbuScnyybVlc=;
        b=GxTWFRELaLLKTzFFr6cZ8EaHu+b2QDierAOHBraqqbQERWnB/IRBNU/vUAHlBXTGHe
         dqyz8GJIqpxqKk0LtxGt85+uyxnDUNCwcEWP/UXNNORLCtuLoy6PPMMDmOvhVjup1veM
         JvCwzQ4GCxaz90SPxMyY+GAwPZ9J2H03ymQrFUiDA/HK9oR/SRF9H4nnElHN8AmiJz09
         iDPOG5O5TQ66YerKfPX/1INMkkwsyhUe3X3VROd+ML+38vKFn7i87wIduxAlvSbxCrBT
         EDlRfKLew1SsidJ1PP8N7sl3YIAf2aX87dtjuTizSkXZ656Z/8oCb5IanX5CuSGRu5Wg
         FycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654224; x=1719259024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjDdICWQ2oaGVdfAV4oGUq0PgukKKOkUbuScnyybVlc=;
        b=pydZXSM5Vpw3POxYJGXOUbtCfLTbvlh2GwGL872JX1yszRjUi+kpEVre8ys+blM69F
         bNUcaA2xGelfCuatAM/i+Hte/kAbm5dPIKN43UKxT76Yfi6yt3Y2isrN9c1+FM2Ork7B
         4frdEU1LILxG6jcrReP1zMcXhwBb76/jY8V5MX9GyQcAuex8kmRm1E36Kmx2NBVTFjDE
         3Df4BUtItWdbQLPLlR08w0fgUKw7wZIGwe872ZuufWDZR6+S69bxIXSieDJnBu0agL1B
         Z2f8musP8iuuF5sSC44YkTUBHbMLj7NZT3xIfsyMVLQJPUyyPMORP6rPMkUfos5C0wNO
         s1hg==
X-Forwarded-Encrypted: i=1; AJvYcCXYyjSZ8vHCyYm9QFoJ7jei4gTwghEJWUvaH08WWeB7FVZzBoZtt/xXI8mI2ZSH0AOTZLCyyAHJb/tNMw17t+OE08E29Nbtuso6
X-Gm-Message-State: AOJu0Yy9x1imQNkiyL7tlsyh09FNycUuPE2DL2P8X7s4K//A+9w3p1JX
	kSY465yXKMky7IPYuqrSF312PBHwoj8DiCY2xQMz9ld835t33CrZGaZBdHE9B7A=
X-Google-Smtp-Source: AGHT+IHhWGIOP5vCe5YhBqVWIz/2hVBesFqWs+uyjC79F4jfNKd28VX0z9aWhmbMQu5bKKCy8t8clw==
X-Received: by 2002:a05:6808:1910:b0:3d2:20e2:368e with SMTP id 5614622812f47-3d24e987574mr16129788b6e.40.1718654222424;
        Mon, 17 Jun 2024 12:57:02 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476e2fa4sm1579492b6e.52.2024.06.17.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:57:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v2 0/4] iio: adc: ad4695: new driver for AD4695 and similar ADCs
Date: Mon, 17 Jun 2024 14:53:11 -0500
Message-ID: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This is adding DT bindings and a new driver for the AD4695 and similar
devices. The plan is to implement quite a few more features, but this
is a complex chip so we're spreading out the work. To start with, we
have a reasonably complete DT binding and a very basic driver.

This work is being done in collaboration with Analog Devices Inc.,
hence they listed as maintainers rather than me. The code has been
tested on a Zedboard with an EVAL-AD4696FMCZ using the internal LDO,
an external reference and a variety of input channel configurations.

---
Changes in v2:

[PATCH 1/1]
* New patch
* Depends on recently applied patch
  https://lore.kernel.org/linux-iio/20240607-ad4111-v7-1-97e3855900a0@analog.com/

[PATCH 1/2]
* Drop *-wlcsp compatible strings
* Don't use fallback compatible strings
* Reword supply descriptions
* Use standard channel properties instead of adi,pin-pairing
* Fix unnecessary | character
* Fix missing blank line
* Add header file with common mode channel macros

[PATCH 1/3]
* rework register definition macros
* remove code structure comments at top level
* remove simple wrapper functions around regmap functions
* rework channel fwnode parsing for DT changes
* fix missing return value check

[PATCH 1/4]
* Rework DT examples for DT bindings changes
* Add file to MAINTAINERS

* Link to v1: https://lore.kernel.org/r/20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com

---
David Lechner (4):
      dt-bindings: iio: adc: add common-mode-channel dependency
      dt-bindings: iio: adc: add AD4695 and similar ADCs
      iio: adc: ad4695: Add driver for AD4695 and similar ADCs
      Documentation: iio: Document ad4695 driver

 Documentation/devicetree/bindings/iio/adc/adc.yaml |   3 +
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 290 ++++++++
 Documentation/iio/ad4695.rst                       | 153 +++++
 Documentation/iio/index.rst                        |   1 +
 MAINTAINERS                                        |  12 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad4695.c                           | 753 +++++++++++++++++++++
 include/dt-bindings/iio/adi,ad4695.h               |   9 +
 9 files changed, 1233 insertions(+)
---
base-commit: 9ab0746278aff96c1a36fcaad22bee9e9d3b3bf6
change-id: 20240517-iio-adc-ad4695-ef72b2a2cf88

