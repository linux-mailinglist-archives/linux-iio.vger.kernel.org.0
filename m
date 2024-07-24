Return-Path: <linux-iio+bounces-7834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E006E93AE51
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F887B217DC
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FDF1514F6;
	Wed, 24 Jul 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZwaBfV9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7B14C58A;
	Wed, 24 Jul 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812153; cv=none; b=fkhkUQW/GZnAb/UL4CfznwdYStUUfrm1WbivQR/r3RCm+AiJx3ikpRR77Kgx0DCsmLexmfEceroQMmxL1+3CWePzp7xDh74YSBMxIn45kLVwXpkcqo+PCy5D7zovpAYYtibTjLASpUbZgRxOZyAWCjhj7FirDmkpzGN04I8ei+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812153; c=relaxed/simple;
	bh=72kCNgT09jugqxctXzPAC8JE4tMd0YCkyyplx4RXL/k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iW+3NZnSbcaWBI7PD7TvlE2HCqi/ZzDv61B+lEleBBb0tGjazTTlp/Vd8aqezk0UHdXO3xvU5g/KzuwjPuwxkEN0q5Lo5ebj8UZjr+wit/tuTiZfXcLpAb8B2O834lFLqt8wCBdH2rmkGwrY+UmDV+kRtLyZIwnonwJnw72P3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZwaBfV9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so47231645e9.1;
        Wed, 24 Jul 2024 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721812149; x=1722416949; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5tcFG6nOiiD0Mb9BuxDlKvVb1JQJ5CmyQf8Enf7mbw=;
        b=JZwaBfV9lh6xrR9PFp+djrirFChPwcLxBIVpM+pLUua0FTN0aVKGNXgTFKVwxbRGYy
         eQuH8NYwab+mI/nUFZWrERgpXRT/LnVIFssopbIotyGlRe9snCNlNt/8ENqzgfv7TSPr
         it7HdcP7pNIe/TFRKJ4m/ddPrKRZ2NCT+OqS6cQaQBFUAMCB9K4ZbflB1LEYOpe32h/h
         KaMLm+XrVWpRbwcBCUF4uxl3/qZiGZVkvfGRr4J4TYuEdsCg6v7FLn8zhmiT0fgugmVM
         Pww8xACP5jhH53Fm/5Q5aUomLhPvxmU72ABBEN2O9FjUesfaqKB/wO+XkmnlEzbQiDtF
         PP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721812149; x=1722416949;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5tcFG6nOiiD0Mb9BuxDlKvVb1JQJ5CmyQf8Enf7mbw=;
        b=YEocZJh0MJvREOIB0Dt+ZpcDkSxpsrsT0cQ2EgNFhyaSyS+upPC+0xV8cPOmZWFG86
         KR4qnLYv8SdOd8m4pgXb+Ey+TT7URE85pZFsTX5EcvrN01+Vc6r0mVhcsxKAxPkZmql5
         +RewFtFhb4rTU6m3MHDX0VtyvPxcUKTd+FSpNz85Ct88dYIh0pj/SwjJ+xDvmq9T5t1k
         CzcqYZ+wE4UByL24HUe+7gZiW0rNf/+ZuJU66RMQ/ZPgJqQXw338ueOr7e/zK/TotrlR
         3/SV/lEn2S6nuyZJfJG9NMlHbrqQ9ShjeT4O5ClfLrb8jU1l4E8Z2damWHVH7ujZQ50O
         1raQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnA8y+arWKHMoRzhOULiaYi0DRG7Yn+IKAl4e3oshFFhl2cbQ2XzGhNurCDYWOJUUu6rdxqsHAkolUH9ntC6RWZCUKFA2bPq84insorkkC+LeJJWyCHfG7yBp1ay0GTH6t8izl3OlOg==
X-Gm-Message-State: AOJu0YxfEY8SFhMSB4PqWvBHGOsJEL+l3/8nxE9ZY8L6qrWFg4yjhN70
	YaU7sL8HRYSIvPMzSRggYRUfrk0ufDiIGKROz55atGZYoud8JMqS
X-Google-Smtp-Source: AGHT+IEO4uS7Z6jfmn3uVcgvmziuYqRM4Cm7eePr+5CeVLpQRirsl8sLQQX6oXYrHUOnq2+L5PLyow==
X-Received: by 2002:a05:600c:1ca8:b0:426:62c5:473e with SMTP id 5b1f17b1804b1-427dc58f1e8mr85874945e9.26.1721812148313;
        Wed, 24 Jul 2024 02:09:08 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e6795sm20886145e9.36.2024.07.24.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 02:09:07 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v4 0/3] iio: adc: add support for pac1921
Date: Wed, 24 Jul 2024 11:08:30 +0200
Message-Id: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI7EoGYC/13MSw6CMBSF4a2Yjq25fdBSR+7DOChtgZsIJWAaD
 WHvFpyAw3OS75/JFEYME7meZjKGhBPGPg95PhHX2r4JFH3ehAOXoEBRxEgH65jhjGpdW6ityJO
 RLIYx1PjeavdH3i1Orzh+tnhi6/vraBCHTmIUaCGd1N6wEip1azqLz4uLHVk7ie+tPFqeLfhQm
 cLKUoL5t2JnOT9asdrCO2OYcpUQe7ssyxfq+hLmHgEAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0

Add iio driver and DT binding for the Microchip PAC1921 Current/Power
monitor.

Implemented most of the features with few limitations listed in the
driver commit message.

Tested with a Pine64 host board connected to a PAC1921 click board [1]
via I2C. The PAC1921 click board embeds the Microchip PAC1921 device
and a 10 mOhms shunt resistor. The PAC1921 datasheet is at [2].

[1]: https://www.mikroe.com/pac1921-click
[2]: https://ww1.microchip.com/downloads/en/DeviceDoc/PAC1921-Data-Sheet-DS20005293E.pdf

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
Changes in v4:
- DT binding: rename microchip,read-int-gpios to read-integrate-gpios
- Fix non constant ext info initializers, reported by kernel test robot,
  ref: https://lore.kernel.org/oe-kbuild-all/202407240123.tjObpf49-lkp@intel.com/
- Link to v3: https://lore.kernel.org/r/20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com

Changes in v3:
- Add shunt_resistor attribute for current channel
- Generalize shunt_resistor ABI
- Remove specific pac1921 ABI
- Remove resolution and filters controls
- Use scale attributes instead of hwgain attributes to control gains
- Replace integration_num_samples and integration_time attributes with
  oversample_ratio and sampling_frequency
- Consider time to enter integration mode before marking data available
- Add controls for overflow events
- Add select fields in Kconfig
- Refactoring based on Jonathan feedback from v2
- Link to v2: https://lore.kernel.org/r/20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com

Changes in v2:
- DT binding: remove vendor specific gains, add vdd-supply, add
  read/int gpio and fix properties order in example
- Remove parsing of gains from DT
- Handle vdd regulator
- Fix return value in filter_en write handler
- Link to v1: https://lore.kernel.org/r/20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com

---
Matteo Martelli (3):
      dt-bindings: iio: adc: add binding for pac1921
      iio: ABI: generalize shunt_resistor attribute
      iio: adc: add support for pac1921

 Documentation/ABI/testing/sysfs-bus-iio            |    8 +
 .../ABI/testing/sysfs-bus-iio-adc-max9611          |   17 -
 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc |    9 -
 .../bindings/iio/adc/microchip,pac1921.yaml        |   71 ++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1921.c                          | 1263 ++++++++++++++++++++
 8 files changed, 1363 insertions(+), 26 deletions(-)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240606-iio-pac1921-77fa0fa3ac11

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


