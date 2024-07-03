Return-Path: <linux-iio+bounces-7250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A169261EA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 15:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68181C218B3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14562176ADB;
	Wed,  3 Jul 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNL+b1+R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EB053A7;
	Wed,  3 Jul 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013746; cv=none; b=X+/DGyLxPn2FRPJxPZrYay6AmXY+7dMPn/rMeaAKBukMto/qWRAxFKgqT8fr0PK2bWf7ne4CL0DZilSg6p9Bj3dbX9iJAln4yaKQanT6PNze1Ib6zy0+Wew3Kt9Uj7Y88gqAf4FaKRYgKUuKGbzSOO4vPtgE7IXTo4KQlooe8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013746; c=relaxed/simple;
	bh=HoFxd35bX4e02kVr1NCirBKOn+hf+OB5zPUIvP6Eii0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F+pV/NLK5hMEmscwKrvYb6GX/f7202qGU6330Z/h8z0pxIQ+T2PK+rn04KDtYiKflm/6OwsKayeYIc2n+nM98/3kLyfmBlXnWXg4vvBHPnLiPVLbENizzEWZ7LrkCBjYU0uUIBc3BhA2oQQfIULX6RifGu3N3F7+WrrE9PAl6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNL+b1+R; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424ad289949so39138945e9.2;
        Wed, 03 Jul 2024 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720013744; x=1720618544; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/egEqb3dpN0vX1EP/GSQD/ycdLWRjOkweAKnqlzzAG8=;
        b=JNL+b1+RL7x99ITcLZhVnulfHzkqQ+DEjPbu48diiVSIPL8mJq0PNubDDfART8cWoN
         DjmjO8WMf8vsJ+guV7luVdfqgz0CzU6Qi1bho7y6evcCpqyJMDuyManVkND4cmeJe7/g
         a1OGbYNnZeqbKnLaSAM7LbIjW1n+aRopgkVobzToqSoDFxJhujcl1FrvwktcM77cWnyM
         rXBJckqvscrJf8anNKNdDlh7q+MYrdw9h5/w3TrMQaluGtTXaIlt5DSboeFWHQt51Btr
         J4dHuGWksQMSOpuaNKNAVSzjTmOBmaRCSB0eggO4W2C8JSH2zs0Ku1xzAmGD2vZZifXb
         k2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013744; x=1720618544;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/egEqb3dpN0vX1EP/GSQD/ycdLWRjOkweAKnqlzzAG8=;
        b=dsgh8ybWnn+MzqH2SGbwExTzJOz2L/4KSaCH+arcdxSlr/Jkx5zccrU/gFA0Bl5w4g
         +RvRnmLe4jAqOH1uN9kkGgKER5UAcYFmyoBmdbMlSPZ1crQ1eEFARz0dFGHfkTtU7QUZ
         4Esj1zbrmPUpgfM/KCqaXQFPCEpUAVqic+1Tbo0+IBakxQQm3uCiZXLzUMhRMQgGMZEw
         aLjAQr61ZMj6+EMPUeZLcsCx1X4tMPoGBiWfhH+AmlI0ODNlk20EnbQXx6I9rHc7dEVy
         U9WPtuR+/4kZt44Nr29qUgYbM1nxZzDW3AFbZhkusoT7g0/fZlgd4FrXz4/0dXUbJ+R0
         iTJA==
X-Forwarded-Encrypted: i=1; AJvYcCXCKbM9HIFzjl1+/D1m6tSaWd6QAaBH/fowCRZJBNmWUn5gSpbuj/qpCHuM9bKAAcyrnmtrq9fbSter1jmjKFF7Yiczu1RUfj1asSV6xYZ9ucJNGlG5MnKohvN/qq7mYOuYmZ4ytGAYEg==
X-Gm-Message-State: AOJu0Yxqc5Xg6ixgD+eYgWzBuz/ZPvQp7Y7rbW8gO7goJfchAXWBlqiV
	MDY4g+SG237+3/vgLmugVk9Keklph0F9UMKXhQkxH5hpkqhshmoPRArtuEA9
X-Google-Smtp-Source: AGHT+IF6VZJWegmXp/iVokdM4LWIwfRJLhbzH3xqIcHirvq3iC5uj9ESGXw4UN06uJwFHvgtgMpwqg==
X-Received: by 2002:a7b:cbd2:0:b0:425:5eec:d261 with SMTP id 5b1f17b1804b1-4257a02805dmr87912615e9.34.1720013743343;
        Wed, 03 Jul 2024 06:35:43 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b068e54sm243355735e9.25.2024.07.03.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:35:43 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH 0/2] iio: adc: add support for pac1921
Date: Wed, 03 Jul 2024 15:34:34 +0200
Message-Id: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpThWYC/x3MQQqAIBBA0avIrBPUQqmrRAuxsWajohCBePeGl
 m/xf4eGlbDBJjpUfKhRTgw9CQi3TxdKOtlglFmUVVYSZVl80KvR0rnoVfQzUwMXpWKk97/txxg
 f0QMASV0AAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
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
Matteo Martelli (2):
      dt-bindings: iio: adc: add binding for pac1921
      iio: adc: add support for pac1921

 .../ABI/testing/sysfs-bus-iio-adc-pac1921          |   45 +
 .../bindings/iio/adc/microchip,pac1921.yaml        |   79 ++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1921.c                          | 1033 ++++++++++++++++++++
 6 files changed, 1175 insertions(+)
---
base-commit: 529d2e1900642eba6df28307e26e19793e227546
change-id: 20240606-iio-pac1921-77fa0fa3ac11

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


