Return-Path: <linux-iio+bounces-7326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F33927C62
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 19:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71691C2269E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B33D97F;
	Thu,  4 Jul 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZHF35e4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2612481DD;
	Thu,  4 Jul 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114934; cv=none; b=h1IHQzHPhYX4tUWLWm0x7Il4QgNsnawAPvMPKcGYDwtclL//GHzVjebb4H31Heh8yRreRpxdAG79J502uh4mtRkaOvBv0Og1hBOYwFHcrWNE5Nc9fwMt/yb0k8GsHlApN30PrRK328xsHlX+uDFpGdOW2mHxsJZO2Hc0NeYalAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114934; c=relaxed/simple;
	bh=/UL7zNv1YAzCIL2wAkS5eJ2VvZjKvlSPTFpjpomTmAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OXBBEv+eY5rHG1zjVtsXvZKVy+Kf6T0eedYjD3+EiEqxiDMjp/WMBKDKKVX3NQxBuSL0sFLBaQfTmSrh2Uzu/zU8tQEdXNQZzw/vfMHQibGigQnwfRXv2FCYbLmaFw5kB5NuaC3fIrrVo0PfgXVLtcx5f/6fHUML6WCO/3lW7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZHF35e4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367940c57ddso558740f8f.3;
        Thu, 04 Jul 2024 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114931; x=1720719731; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrDhFq09WwhJ6O/2SNYG8U+h8zKR4OktvVYRCrqcAQE=;
        b=iZHF35e4M7HtrZ9YAou2n+lFIOUQCphNY4dXli4kkxO80g1TyCXhlCBdIU4i05prAe
         zsdx6BZNXKB8YFWV7JO3vkbVKSYQVCvQ0T+T03W2n1akpbOiOhFG6zSYreCLYUVoaSIJ
         z7L4BygwA/gkPZfG/8y53EJQtpJesMDOt2qVqi6BL+LJLFD72FR/96sS7fmMexYxRykV
         hfruSIj0nKDUAnyOziSnUTpBSVA4TX1GZWAHmxy/IwoIXPld6qqaWzBZZAttSwLe+6k5
         oAWZK82c4qK3O6DAMayM6rSwO+lA4QbAs8Uulv8xVZDajSVhV41L2omcEDB/OJMAHcb+
         t/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114931; x=1720719731;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrDhFq09WwhJ6O/2SNYG8U+h8zKR4OktvVYRCrqcAQE=;
        b=SDKPEI4W+YsARcpdIMiQ3yUcvg+GWBoioE1LWjQJbtSPmM91Ek6mA+dJVRVHGdBK9u
         j1Pbz9Epjh1oL2N/rHAOe+P6g5cM9bJPxGXnyqp35/aCN+guGjY5M6BVZbtV00m7gF6M
         ClTb/LMDiJP2vzp25uknwRPkF9K2C2rFAd6prWkgj3i4MdlnmbFFaRIOJWSlHMXa7t7l
         8C8GsIi/BUfzJv9V1QLT4ImaN4SegM1Iu5qgGQXjQWBW8sJ/poOqBlfKvIonU9K8gTU5
         O7YO51lo3+hEIR4ezym2Nd55+cmw13kq+oBE9KxTX0NHgVb47FzswzZAzwNO0qR3y699
         JjvA==
X-Forwarded-Encrypted: i=1; AJvYcCWzThbilTvS1IMNOqWPSu2qN7Emrkg9S9nJth1thskKktJObN5nFYT8c9/r37GVH7BjVcgzdebvN2FmmrNxollVBoqnfVc9pgG0g0d1H9ChdOvq+Jq0hMfG394sJSJq/adIurhRT5952A==
X-Gm-Message-State: AOJu0Yz5Ol69yCQdGbR/H+A0LzuRerSO2m9ZjgNFUh2j0AcSwMjOHodM
	3nEK/GHvvExx3wyJgVuPgaohcAhm54emggFEz7bU0OHTwifuXIEX
X-Google-Smtp-Source: AGHT+IHMcLCfkKP27bBBfA+MWIyDCsTk8BV+OPdXDpvo3SuYYECzu9kToJ8MStelKCyY5MZMXh4dKA==
X-Received: by 2002:adf:f889:0:b0:367:3cdf:c027 with SMTP id ffacd0b85a97d-3679dd63bf0mr1502343f8f.50.1720114931135;
        Thu, 04 Jul 2024 10:42:11 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1ee57d8sm1289098f8f.47.2024.07.04.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:42:10 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: add support for pac1921
Date: Thu, 04 Jul 2024 19:42:00 +0200
Message-Id: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjehmYC/1XMQQ7CIBCF4as0sxYzUATrynuYLpBCO4ktDRiia
 bi7WFcu/5e8b4PkIrkEl2aD6DIlCksNcWjATmYZHaOhNggUEhUqRhTYaizvBGdae4PetDU51Mc
 anafXrt362hOlZ4jvHc/8u/4cje2fkzlDdpJW6qHjZ7yr6zgbehxtmKEvpXwA0wmhZKYAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.13.0

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
Changes in v2:
- DT binding: remove vendor specific gains, add vdd-supply, add
  read/int gpio and fix properties order in example
- Remove parsing of gains from DT
- Handle vdd regulator
- Fix return value in filter_en write handler
- Link to v1: https://lore.kernel.org/r/20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com

---
Matteo Martelli (2):
      dt-bindings: iio: adc: add binding for pac1921
      iio: adc: add support for pac1921

 .../ABI/testing/sysfs-bus-iio-adc-pac1921          |   45 +
 .../bindings/iio/adc/microchip,pac1921.yaml        |   71 ++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1921.c                          | 1038 ++++++++++++++++++++
 6 files changed, 1172 insertions(+)
---
base-commit: 529d2e1900642eba6df28307e26e19793e227546
change-id: 20240606-iio-pac1921-77fa0fa3ac11

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


