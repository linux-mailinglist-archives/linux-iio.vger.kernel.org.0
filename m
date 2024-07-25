Return-Path: <linux-iio+bounces-7894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7595A93CB0C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304EC28225D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEFC148312;
	Thu, 25 Jul 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSmzx+h5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92314A82;
	Thu, 25 Jul 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949049; cv=none; b=bap8tJs08NQJB6bn5DkE/AMZUJoTEHqsY8FF9nAVJzz0qByyBIsM/xdJ+socUGw9trfs707NJHxD8eAKnJR/cT7B0UcF7MFmt8ActoVQ1V7h7dT5wzs2FFqVeEDd61lRAb+Sx5DzBcc+6QNuUYWwEwKHkC/1jdrIjsT2vncIq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949049; c=relaxed/simple;
	bh=VnYebjk/GhSb9asuRPpOFP2BMDHhXlf0oWLcJfjitIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtjZgy8ct81HsUVeBtWlG5I/8OSiZwxKfbBO+EBNwk5TukxqymZPOxrhmT/RFbMTz7rxqTq5iY4jhhRYad3uaLDtZGLHEkh07LorCSTljouxRzxsyCDVIxRPFFvFgOvUqG4ZdgVyAoPDeLZoqnX2xPVwMXJRMTBW+l/bZIXv4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSmzx+h5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efba36802so1166564e87.2;
        Thu, 25 Jul 2024 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949045; x=1722553845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xkiAxUA99k94EKGzdDATteXCdqHZl62UByB9jYiwg7Y=;
        b=QSmzx+h5UzCqpQHAd678n+FlkQ49qrpyX0wTOccd++eaIGaiUhMB1XI54Tw9LMQ5Tf
         U7RnbL73u/+tKSZt6i2uJvYdTlMBqAy7rPPYgb2T9YmAPtrs0xOIv0VteqY63U+xon29
         xcZXqPpBigjIxLRzfi0iI7w36zAxILOA2q4kkwNLPj8CZl96+5FX2I8XVYsK4+s93Bx8
         QatkxkxkcZQ/A1rmjGVrsVuV/QgM/q7QTnUpItLb7NzGoVa7aYjpYFPsHwC1cwu1FfY4
         tnrNxK5um12dzV6zttlsiF7MdpKwNlH7lV6LS1muy8+/jX2HpWm8/tmJqMkSwLtC9BJ4
         /kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949045; x=1722553845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkiAxUA99k94EKGzdDATteXCdqHZl62UByB9jYiwg7Y=;
        b=bfvTobcQD2U1vlDmPpwkqdhAcnw/Wxr1Y5KTgWPEbY/op4y3Wi0ZzodjId8czB8BDl
         7VrJ9MS9kh1doj25mdnndARLBEYpzAcRNcaVfrnt2dVSOBcRvaATgp1Gh6RFfQvh5u3C
         95Ffwji9NhMHVPHDfRRmNSko1hx6YFwu02eUeEBrVGDudbqsEQgDdwrIZ5tsQAvn+Gzr
         ovzBtvIeAXawR79c1q5i8k4lHZOtPQxXY6v0Od3AeQkmmKQU4JLTRrd88pfU9FLllMYt
         7iA9llsKoM3WkHPjpwSz4f8rNnMlBjrbcCdZpvkd0m1P8RYQfRs8w/lT9Mdc8bdNtFrG
         8njQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9WGeppXB7TIWmAhdNjlITUfbBemm7F4LZywHWoxP6zUWu3wnpM4ZumrOEDQOwqBGhoBTBBCTYTA08IerWzEF5fURs8ZDzTaggBTYNk4L85SpdAwMeQi4iAzw4UoqF+rlNECqPucLcI9oX3C1C9ohtG9aq6T74FyhlEtOvy/oJggHv8g==
X-Gm-Message-State: AOJu0Yw5fzE5as+D4f4Lq6XBocF+NZZ7L8rxrIqBWsJSdRjwPDJm74Zc
	5SFXekcNHdQCGOt/G01kRvKvpHKoSQ5dgjwby3qbnNp5WZayQN616cvKhsK+bOA=
X-Google-Smtp-Source: AGHT+IHYbl/pfsg1rXzynKAbk7rzdJ6Gtjix8KBNERgF0OsjhkOr02JY+L8gytZO08uVod0jt6HBpw==
X-Received: by 2002:a05:6512:3a95:b0:52c:dfe6:6352 with SMTP id 2adb3069b0e04-52fd608b82emr2059522e87.48.1721949044811;
        Thu, 25 Jul 2024 16:10:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] pressure: bmp280: Minor cleanup and interrupt support
Date: Fri, 26 Jul 2024 01:10:32 +0200
Message-Id: <20240725231039.614536-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on iio testing branch.

Changes in v2:

[PATCH v2 1/7] <=> [PATCH v1 4/10]
	- Added comment to enum indexes for humidity parameters
	- Made more clear the bit handling in case of calib->H4

[PATCH v2 4/7] <=> [PATCH v1 7/10]
	- Used const arrays for local BMP280_MODE_* variables
	- Added comment for why we check humidity oversampling
	- Added comment on stubs

[PATCH v2 5/7] <=> [PATCH v1 8/10]
	- Used only INT as interrupt since the device has only one irq line
	- Used drive-open-drain

[PATCH v2 6/7] <=> [PATCH v1 9/10]
	- Generalized IIO trigger code to be able to adopt more easily FIFO
	  irqs by using a bmpxxx_irq_thread_handler() function which handles the
          irq handling.

---
v1: https://lore.kernel.org/linux-iio/20240711211558.106327-1-vassilisamir@gmail.com/

Depends on this series [1].

This series aims to add hardware trigger support and extend the functionality
of the driver. Sensors BMP3xx and BMP5xx have an interrupt pin which can be
used in order to inform about a specific event in the sensor. For now, the
data ready event is used, and is added as a DRDY interrupt in the driver.

The interrupt is supported only in rising modes for now, and it doesn't support
latched mode.

Other interrupts such as, FIFO-FULL, FIFO-WATERMARK, Out of range values etc.
are not supported for the moment, and only the DRDY interrupt is supported.

While working on the trigger, FORCED MODE instead of NORMAL MODE was added to
the driver for use in the oneshot capture reads. There is no need for the
driver to continuously produce data, without using them and without properly
notifying the user when those data became available. This can produce high
incosistencies between the acquisition time and the readout of the sensor.
The data now, in the case of the .read_raw() function is using the FORCED MODE,
which samples and calculates the values at that moment.

Last commit, is just moving the interrupt interface of a very old sensor to be
consistent with the new ones, and no functional changes are intended.
ubject: [PATCH v2 0/7] *** SUBJECT HERE ***

Vasileios Amoiridis (7):
  iio: pressure: bmp280: Use bulk read for humidity calibration data
  iio: pressure: bmp280: Add support for bmp280 soft reset
  iio: pressure: bmp280: Remove config error check for IIR filter
    updates
  iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
  dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
    BMP5xx devices
  iio: pressure: bmp280: Add data ready trigger support
  iio: pressure bmp280: Move bmp085 interrupt to new configuration

 .../bindings/iio/pressure/bmp085.yaml         |   7 +-
 drivers/iio/pressure/bmp280-core.c            | 739 ++++++++++++++++--
 drivers/iio/pressure/bmp280-i2c.c             |   4 +-
 drivers/iio/pressure/bmp280-regmap.c          |   2 +-
 drivers/iio/pressure/bmp280-spi.c             |   4 +-
 drivers/iio/pressure/bmp280.h                 |  51 +-
 6 files changed, 715 insertions(+), 92 deletions(-)


base-commit: 47ee461357f9da5a35d5f43527b7804a6a5744cb
-- 
2.25.1


