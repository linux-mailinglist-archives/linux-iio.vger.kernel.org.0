Return-Path: <linux-iio+bounces-7779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5331F938D1F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D785D1F29380
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816116EB71;
	Mon, 22 Jul 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBBu7nwa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDFC168491;
	Mon, 22 Jul 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642626; cv=none; b=F6q9WbfGk/4HTr42wetAaWnLTu/G8xPOgGzZRORrGfqiZguyutuDAE/NDOniOBjNIV4H2lQOzKP6BzYV5dG3DsasWYxfj1bYDrIfglQPo2E5nfk73exiu7wcbxufY28rM0Q3fZ/tFvGq+qoYdu4EeVF/UuSKQNMcTRf9Le/UJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642626; c=relaxed/simple;
	bh=eTseU1JvNfE/gA355AGdxgDwaG6TNzVXAoONYhqXy+0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oMj5vH3a6O1r1pLmyoQlrqiy5TH3tA2MAWu3dc5ZlGWKj5kIssoEPFXAjvyjUv8MOYlEtVbtc7GcXdWalAJxMVTI/a1MjOpFb9+imew8erSUchXTozTUhGjxcYZjXh7Y6/AUfFOSzBWupLBohkasukI+/MO6BsV8jAEKeOS1XXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBBu7nwa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3685afd0c56so273328f8f.1;
        Mon, 22 Jul 2024 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721642623; x=1722247423; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eL9cUWDiG/jZtMM6Ijga1UNFxgVDFmD7PbpUrEC1BO8=;
        b=DBBu7nwaNiPNX49BHGGlFxehAhJ74uXlb5tNKd66mzVImWzuMMEekX4NG2GRm7ZCAb
         8Fgo7YZ/wYn1ham0/ivC9mbLEdFd9Rsom2IkcIPNh+v9b5OlqynCsNPaEveTinmsqrbR
         0Em3a+FYgsqMRucqHCeehv8GDx75vVUdOyxx9ujf33hmr+WHVfehiF4cxAm4tUlRZPc8
         Np3ACJJEGyPwlzonvofVQYi02DmdzkEZmJJANtaqcwXB2eCL4JFHPzohrIKwE1HWYWqC
         eCltFuOfya5iq5K9WKWHHBh6TW5jN7Y3EFE43pdxIiZBJvx2DHvIZfp/lB8X6aGj5lpE
         Z9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642623; x=1722247423;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL9cUWDiG/jZtMM6Ijga1UNFxgVDFmD7PbpUrEC1BO8=;
        b=h0n1WtAxpeAooVrbXnOz7LgmdHIZRQjzsKdhN8+qPnyRbeqHV6gyk7NR1rNbHSB1t9
         h/Qqw1xWw7NUF2SDlSGT0ZcthlN1bHKHtztnxJhP4vdhRFADKK2bPQYRkeX1dwkxV5sC
         lZo/EzZ0uwqiCYFE1DjkpTgL0NAONUppavoF7z0jqyJOBKT0y3sQOiDFweknur3tYHX2
         +eNxXncPg7ZAYMU1vPx9wRMarAtzaf+I4345ftXQAwn+6E8BQbOAE9azJ9Gt3fLA4a36
         RnQ92TvNf+uEJj2bKnwGQJ/e8biC53shAcdxeDwZ4BhRR+CdnkgasanQOSBRWIPD1Hfq
         uFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUM37ySHLvx9aRCtN7ZXco1xB81VKQ5qgUF68kDJWTTzXBBWZMvEACiM3LmrZBX0X06Q0zCJS8HwmiwNRQjU9rWyKzG5cRawqBZUd2zHyC8awCGI7zbvq250MWnIHkZiC8jMHLzNRwKg==
X-Gm-Message-State: AOJu0YxKn/zU917KREZLcwH+ObD7+IFIaoufhEf+EiBggJVe4SBHnAhB
	v/Xmsl3clX4AkFo/4KS0DLmP+ZjMHlZqLEAh4WotIZJ1zQ8iSEVqsX24OAm0
X-Google-Smtp-Source: AGHT+IE62JawKCAKhkLNJB/qu1W7vAGb4zU4gSpGosM+4UAr51OK7unC4qQsDDndOt2GhlwHzJC7oQ==
X-Received: by 2002:a05:6000:1f82:b0:366:e1a6:3386 with SMTP id ffacd0b85a97d-369bb2a1d34mr4478756f8f.44.1721642622858;
        Mon, 22 Jul 2024 03:03:42 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868490fsm8104360f8f.6.2024.07.22.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:03:42 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v3 0/3] iio: adc: add support for pac1921
Date: Mon, 22 Jul 2024 12:03:17 +0200
Message-Id: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUunmYC/1WMSw6DIBQAr2JYl+bxUaSr3qPpAhH1JVUMNKSN8
 e5Fu9HlTDKzkOgCukhuxUKCSxjRTxnEpSB2MFPvKLaZCQcuoYKKIno6G8s0Z1SpzkBnREZGcjE
 H1+Fnvz2emQeMbx+++zyxzf4/CsTpkxgFWkorVatZDU1170eDr6v1I9k+iR9beW55bqF1jS6Nr
 CXoY7uu6w/oKMKP4gAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
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
 drivers/iio/adc/pac1921.c                          | 1265 ++++++++++++++++++++
 8 files changed, 1365 insertions(+), 26 deletions(-)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240606-iio-pac1921-77fa0fa3ac11

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


