Return-Path: <linux-iio+bounces-7511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C3692F0D6
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA339B2300C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CCA19E7F9;
	Thu, 11 Jul 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8DW5D3h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7203DF43;
	Thu, 11 Jul 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732580; cv=none; b=q+groCjExOBCDMIqnB2R9JONfO+DKuTf4U1RMKd4Tm58z57aDznqzZi75iv1wNZlFvSPweUhzsdiviYb5YuSdvKm8AGQ17zp/AZADuB+Pz9oTjSyXCMYyXPRkH3Nq1d3DnR8U85I0Y22vzcXOIa/kotBCDSzR7zv0whldzy4ZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732580; c=relaxed/simple;
	bh=a7yazs1xUtE9P0araaPaKejrAU7Cdx+ImscFaG1kZoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DoVtg0oQdv8N4mWHWrqxBvM3Jfru0dS6gRIDgp/LvGnUkP08diV2zsq3NHhBNSwfnoCskb5yOiBmNPx91KiMDh9kTMiOSL6zY/a9NSjk2u/1Deusea7LnLL07NdJkYfHunynhCUAFxTaOtLr9f5gOOT7ruZik19VrlJhaJUQAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8DW5D3h; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so1917290e87.1;
        Thu, 11 Jul 2024 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732577; x=1721337377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EedlVb5fhOj1nEBA4Q9Z5b7KOkOJ/YvTGeDUrfXWz4A=;
        b=Y8DW5D3hCcG7D9pI/4OeOqnaygwKyPRACIYeoH0Xy6Voa2tOloObl0NUl496piLi8D
         mfmyfMTlyKRb54pY/nBCKjENiuG80ZVmudQXpQMMHfBrM+PiTNRY3hW1IUPo9nmLWBHd
         voB2lkFvhwZBwpx5UEJNLcrkvevrfSFLLoN0qLjFKM5JUJFTPj492mZFt9aDdVE2O6It
         4dve0NA1XBceon9yzgtW0v1auDWOFA2MR1ycZLjxt7HE06VQmJIm/Ef2RxhBjAr36r3A
         c6vNTtjFiNICZfs4baAd8lJd003tBaXgPzRFBkNhnAn0o3/fHkVH874PF2/p06jiYNkD
         IGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732577; x=1721337377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EedlVb5fhOj1nEBA4Q9Z5b7KOkOJ/YvTGeDUrfXWz4A=;
        b=gDuNqBtui89wsgOeFTWpMaWhtJqFk0T9sR1lEpFI+zUH2nG1nOinQNxkNPQ02IrU/+
         An5e4q07hp9VgYpEycKuevIwIq8JkMMFmpH68HQO76CnpfuL93NR5OVTRi2bZjm/45ey
         kGrR+LZiRkAp6RZDre5vec8/r5Ig0XvK1bkdoTHCdymNlEnlJkWoLxUvDAh+pYWSV/xx
         HtGzKJGfR6Sdr7NRT2j9Z8mpQw4R02DNKietSiQoYse5h/qjR6+tdUtt4Ih5KRdRlo4o
         HG/+75erCItSoh44VVhVTwT/NnpVqHONHtJyqP3d+oq+e+EgX0rVbnQsodyDY8lEK1Tm
         ezlw==
X-Forwarded-Encrypted: i=1; AJvYcCUpzcLBsv8mwj8umqQtmdTdW43GESXMiqsFXSCEVqruN50doIeYgg5HySZNrMyXIaYnx3BpNyT4AUeNktzhoJVlHvTnliLhB7WJXwSzKWw6gEeKuzeEGPElcZyigd3/yNO/U89PuP0gbXO/geBDfXhd27Wq/Lesvkhaa1L4u/uF0XHilw==
X-Gm-Message-State: AOJu0YzSi7S6KJEeRazQOpVOQroBauu7yVOACDcoOss9CWUDBsAo3oCx
	pG9RDRFrEqGV8/Kj+BeTaPMT6QF5p3DjkBP3D1mI8XiRb7t71SBR
X-Google-Smtp-Source: AGHT+IE5uIvHROMQ26wCdjQCEJOgPVXYlNG47dT/NnCc1OeL53BGuII/l36pWNUVehM8DNdPeODUDw==
X-Received: by 2002:a19:f80d:0:b0:52e:97dc:f5c4 with SMTP id 2adb3069b0e04-52eb999b36cmr5521574e87.25.1720732576591;
        Thu, 11 Jul 2024 14:16:16 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:15 -0700 (PDT)
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
Subject: [PATCH v1 00/10] BMP280: Minor cleanup and interrupt support
Date: Thu, 11 Jul 2024 23:15:48 +0200
Message-Id: <20240711211558.106327-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on iio testing branch.

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

[1]: https://lore.kernel.org/linux-iio/20240628171726.124852-1-vassilisamir@gmail.com/

Vasileios Amoiridis (10):
  iio: pressure: bmp280: Fix regmap for BMP280 device
  iio: pressure: bmp280: Fix waiting time for BMP3xx configuration
  iio: pressure: bmp280: Sort headers alphabetically
  iio: pressure: bmp280: Use bulk read for humidity calibration data
  iio: pressure: bmp280: Add support for bmp280 soft reset
  iio: pressure: bmp280: Remove config error check for IIR filter
    updates
  iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
  dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
    BMP5xx devices
  iio: pressure: bmp280: Add data ready trigger support
  iio: pressure bmp280: Move bmp085 interrupt to new configuration

 .../bindings/iio/pressure/bmp085.yaml         |  13 +-
 drivers/iio/pressure/bmp280-core.c            | 717 +++++++++++++++---
 drivers/iio/pressure/bmp280-i2c.c             |   6 +-
 drivers/iio/pressure/bmp280-regmap.c          |  47 +-
 drivers/iio/pressure/bmp280-spi.c             |   8 +-
 drivers/iio/pressure/bmp280.h                 |  47 +-
 6 files changed, 735 insertions(+), 103 deletions(-)


base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
prerequisite-patch-id: ffe99ffe927e3309f0cf49ad0109818f58f4048d
prerequisite-patch-id: 5e534cafdd556c49ed1041a8d2e448713021a08e
prerequisite-patch-id: fe806efc601fc318d7240953d44491217de3535f
-- 
2.25.1


