Return-Path: <linux-iio+bounces-8719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB895D51F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433FB284D32
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5BE191F81;
	Fri, 23 Aug 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJrGf8If"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807918E02E;
	Fri, 23 Aug 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437042; cv=none; b=XbHw/X0qo0c0i3Nenjf9XizjCFiCxDpzcWobvNPTHpppKp+VffeIB8TFxbJavi0BUaIttIUDG4sSKrA3a/V2NIf/PnVtxXy/itdgmJv+udApulR19FRPykaPeUXCQcqjca7TkGlIR8QEIBkJKtbynvKoTFInfPnt6Z4fiZpA5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437042; c=relaxed/simple;
	bh=s9+PU91HOsnvN69dHOcgiVrBMPVH6NbyLtFUFs+4qos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvLThNLJispsbKiyPTNEyQoesekyqyBWbt1OFxwcDLIDx47+vXjCOi1So/ARQek6oD5PZD07V0mATlvVBks1+IUZ/N9FzNHIJ8/c2l4cEsiMrtrzWQPyU881lVM3W1WIh0t7WPVgBmQ+PDT7tLMLqdK5TLZ0pRQrVDzTkfLKBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJrGf8If; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428178fc07eso17219095e9.3;
        Fri, 23 Aug 2024 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437039; x=1725041839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YbHgXuYc8WVmqRaVNRxIWkQql4xPfWAG9gyqOHYiFQU=;
        b=RJrGf8IfGX7R+v5+rTy5LGd4sH7/CI36CNMp0C9wFWXuXsWRk5Fmc3GoiNJCpZvLaW
         kst04QetQBJisVqWXDNgS9F71wC4MLuQBxpQjqGSo2hssSFLLjfKvLwD0UtnoJosc/qw
         33j+92tujYGjFMYgVpxJYjH+cbPwH4FUCRbwPy8Be8YiKSgsXV4yoG0NzVZ+o4wrFwWH
         h23rqrbJtm3Ywp3FivG7GgNhFupd1x5y+UyX8hnJjAsLI664e/IULM0cdkj4dPMKFZPC
         5BMivli61xpH0nH3eB2Pk+2rY9o3RdNyTSrAwB87QLh34hJqi0AVPTbvsfwrBUw+MuAQ
         b8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437039; x=1725041839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbHgXuYc8WVmqRaVNRxIWkQql4xPfWAG9gyqOHYiFQU=;
        b=A48nxtNfIg9tH4EIeQf7dL/xc3iPNUOTvOixpQ0hCqCxYgwcjVV0PPaM5h/Xbm8Gi2
         uk/wCcFtnyjoSxoCdrL2M2wUyFJRiIPNbbmZlLgUAXwPBoTYCezyCogbhd91x6IIsQ+g
         apzWCOgsr3d6kecBq0R2YvMqA3lhNBXq+4C+n/ao3AWs4PAH8zXsDQWRsCwHZjqYgfeQ
         b86x78ovYrI8cJsBtr/RwicP9379rPRcUBl9w65KzH6vANiNe4Xynbmx6sTLXTNrIDpc
         pBuFiPe8gw36j7oO4JqnTswtK15Du+0N8zsFVrHkYG780Au99Cdj2wBKZBSbi9QyTVdd
         Q0wA==
X-Forwarded-Encrypted: i=1; AJvYcCUOpxNw+bzwzIigOKKSPx2MZHPIo+NIlEG+i6hPZyF4QQxVzbPc4y6aCKN65C5XevfVw3n+9WLY4ZGUYdjt@vger.kernel.org, AJvYcCUf+QzAenml3K0oFbfVohJ7HgeYLubTlmHFVHAqvxv7VvkakyRmmIN+6agTYU7h6sD6XfRJy//oS65j@vger.kernel.org, AJvYcCWwvukGRj9T3wCVJaD4XMrrq8wCzbZQxqeNh4wzOtX09v4N9n/Pvt3rDW/hz1mPkxpggMhi9CF8TqwG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pnAidR9KTSQbH/JF3XypsB6lHzAjQtb1Qm/Jy3sTgNJqHYSt
	Vcgo0XzgJePsVAsnXIA2K2Ynai1m36x5u7SEZT9p6v4hyYlyQi4p
X-Google-Smtp-Source: AGHT+IHUpne5bcgyg59dEnxMMu8YpwxY1O31b9h55pFrr4+/0pywbv0ZolURjU5JE5mUCPXcT2hKmQ==
X-Received: by 2002:adf:a11e:0:b0:367:99fd:d7bb with SMTP id ffacd0b85a97d-373118fde37mr1702754f8f.63.1724437038584;
        Fri, 23 Aug 2024 11:17:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:18 -0700 (PDT)
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
Subject: [PATCH v3 0/7] pressure: bmp280: Minor cleanup and interrupt support
Date: Fri, 23 Aug 2024 20:17:07 +0200
Message-Id: <20240823181714.64545-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com

Changes in v3:

[PATCH v3 1/7]:
	- Moved the indexing enum on top of the calibration buffer and added a
	  comment that the reason for the complex accesses can be found in the
	  datasheet.

[PATCH v3 2/7]:
	- Use dev_err_probe() instead of dev_err() since the .preinit function
	  is called only from the probe.

[PATCH v3 4/7]:
	- Made static the const int arrays.
	- Changed the comment from "future" versions to "newer" versions.
	- The current state of the board is saved into a variable in order to be
	  able to be recovered after a suspend/resume operation.

[PATCH v3 5/7]:
	- Corrected syntax error.

[PATCH v3 6/7]:
	- Merged the bmp{3,5}80_trigger_probe() functions to one by using a
	  general __bmp280_trigger_probe() which takes the sensor specific
	  functions as interrupts.

[PATCH v3 7/7]:
	- Fixed the bmp085_chip_info array by duplicating the bmp180_chip_info
	  and just adding the extra variable for the bmp085 interrupt.

v2: https://lore.kernel.org/linux-iio/20240725231039.614536-1-vassilisamir@gmail.com

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

 .../bindings/iio/pressure/bmp085.yaml         |   7 +-
 drivers/iio/pressure/bmp280-core.c            | 691 +++++++++++++++---
 drivers/iio/pressure/bmp280-i2c.c             |   4 +-
 drivers/iio/pressure/bmp280-spi.c             |   4 +-
 drivers/iio/pressure/bmp280.h                 |  52 ++
 5 files changed, 667 insertions(+), 91 deletions(-)


base-commit: 0f718e10da81446df0909c9939dff2b77e3b4e95
prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a
-- 
2.25.1


