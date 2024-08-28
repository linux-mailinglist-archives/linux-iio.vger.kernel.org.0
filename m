Return-Path: <linux-iio+bounces-8847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B619632F4
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50612840D1
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C31AC459;
	Wed, 28 Aug 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCh9yF8+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A615C146;
	Wed, 28 Aug 2024 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878298; cv=none; b=VFA3pwEr4+SYaxenOv5KC9ZuzD5Ol2/0Vk689KWqqI9E351HMKcqDLiXjSixYwXBZIcJPS7PqVWX2P/iauXeZh7C5YFywhhFYgbHkRMgGqhvwuSPMZSJGjUGhs3IFp0FViqDOqRlV5uuSWu8T/KTZy3BzBUEep5IQNXLi/1CSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878298; c=relaxed/simple;
	bh=Yt4He6JNa79hvnCAPK/BHO3qzmvg3VKIUb0OeXwskaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EowLO/KxMhdjGyokpMvFcDJ7olr7ytgkPvrdURLMhMFQpoWLurETV1dLyO9sWQF3v3o4EijVunZLTz70MLP3E+StlaxZMXioz2pje6zKYt8eaAyfKz3/s6HE2Anm3MAn/RY5lpM9+RRBFu3XW2xnOrfJeJl1sYbjaWuzcCa/TI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCh9yF8+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so8956559a12.2;
        Wed, 28 Aug 2024 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878295; x=1725483095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7pH7g9HyU2YWJKOePQTMMkr1OSwcCLkYdR/Pys+Au4=;
        b=DCh9yF8+L/G/fVu6vs+h9lPre7rmwKwXy3pchUlURkn9ijPJPdAxZFXj+7K6H4JLmb
         XQgFjwJ6z/6lH4UiyGSYKkuZQYjDiwyuHkvE+3rCP3so36W8EQwKBL2+pFDGJBM+vGBZ
         YGNmgYOFp6Kum7DWv5F5kEM2cqa28ZAm1JQ7YvG2s0wnylje6cMp8rmaCFhKuIazHTWz
         fegFyOUQ3TmdZntvYBavL3XnZPwBEeag3HM6Tj4ylCrOyeBv36+bzCBp5Sa59qUEkrDQ
         BYQMlIQ1z4xhYREXA25tIfoMp+v2JCa/gX+E+78sIh22PO+7pBaU75EjE7fpFMm4S2Pn
         6xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878295; x=1725483095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7pH7g9HyU2YWJKOePQTMMkr1OSwcCLkYdR/Pys+Au4=;
        b=jE65PKmb1KO3OSSYPl81lpmeAS/bznPziNDv7JGp22R/wlgf8mVGOAKPCxoRbLsWLd
         tTGVFyHuvss2OQrYuWUHkP4XapNJJ0B7sLqPcUxwM125K4abgeP0Mmuhq7TfbEQ9YZf4
         VIasN3+/TAH5J0uhWs23k0Q+njegBGiujSuUHCaDacFiy3NGADk6WDM+De5PqCTEyQN+
         hLGq44tsAvxYjXdyq/Kz+AKMQy1ZPa4UTG8D5yZLLJd4uSDIfxrB49Qt1I2emgqDXHCI
         9z7/J7kQYaXq3GPfKXBaH9iWVu1fEd1eY9/g0WisZkj8eUOQvwc2kb+JO4HTm4BvCTd5
         51gg==
X-Forwarded-Encrypted: i=1; AJvYcCUkx0cys83EH+4Wv84K51v8ENaDI08BrlggbjSeD/f7MYyoNcqoq0P1nRo8vTLOoGDVGc54i+VkAlMa@vger.kernel.org, AJvYcCXQUxojH3XKrjq/fW7u2m757UcThimq6Uc7BQswmLs9lkj8jsrElc94mOBGPk3TYDhHWVcOsWbGewE4CMJB@vger.kernel.org, AJvYcCXrigHNamnofelF9nIAQO1XChH/7OnI5sMVtNXZui39/M3kaJZq5UqXjX1untuPL8d/VQzy22/M9M3k@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTmgQ0RRzFQ6LY5QBA3jrxwn9cqOFJkD6FmNksjYShk09cXQz
	FkCjUi5HCUikU9/hbKtW9ZCOgUg2t/xkM9g7zzPGGJ2FGmrA/r7o
X-Google-Smtp-Source: AGHT+IESq9jcS5QJcegpBWnWuFxps21NkjYT0Ee9tHuUbx5KafvSNpYnXOynhKLplml+HG+0HQpHdg==
X-Received: by 2002:a05:6402:42c3:b0:5c2:126b:8749 with SMTP id 4fb4d7f45d1cf-5c21ed86a38mr626991a12.29.1724878294729;
        Wed, 28 Aug 2024 13:51:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:34 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v4 0/7] pressure: bmp280: Minor cleanup and interrupt support
Date: Wed, 28 Aug 2024 22:51:20 +0200
Message-Id: <20240828205128.92145-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com

Changes in v4:

[PATCH v4 1/7]:
	- Use better names and split value assignments for better readability.

[PATCH v4 2/7]:
	- Move to fsleep() and add comment on top
	- Use appropriate return error value in bmp280_preinit()

[PATCH v4 3/7]:
	- Split lines for logical and better readability

[PATCH v4 4/7]:
	- Change style in static const array assignments
	- Use BIT() function instead of bit shifting
	- Change usleep_range() to fsleep() and add comments

[PATCH v4 5/7]:
	- Add allOf:if in order to allow the interrupt in the device-tree
	  only in sensors who support it.

[PATCH v4 6/7]:
	- Change function pointer return type to irq_handler_t
	- Remove extra check in dev_fwnode()
	- Fix check in fwnode_irq_get()
	- Fix shadowed error check
	- Remove extra check in irq_get_irq_data(irq);
	- Improve indentation
	- Fix return values in certain cases
	- Fix identation and if checks

[PATCH v4 7/7]:
	- Fix commit message

Vasileios Amoiridis (7):
  iio: pressure: bmp280: Use bulk read for humidity calibration data
  iio: pressure: bmp280: Add support for bmp280 soft reset
  iio: pressure: bmp280: Remove config error check for IIR filter
    updates
  iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
  dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
    BMP5xx devices
  iio: pressure: bmp280: Add data ready trigger support
  iio: pressure: bmp280: Move bmp085 interrupt to new configuration

 .../bindings/iio/pressure/bmp085.yaml         |  22 +-
 drivers/iio/pressure/bmp280-core.c            | 692 +++++++++++++++---
 drivers/iio/pressure/bmp280-i2c.c             |   4 +-
 drivers/iio/pressure/bmp280-spi.c             |   4 +-
 drivers/iio/pressure/bmp280.h                 |  52 ++
 5 files changed, 684 insertions(+), 90 deletions(-)


base-commit: 0f718e10da81446df0909c9939dff2b77e3b4e95
prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a
-- 
2.25.1


