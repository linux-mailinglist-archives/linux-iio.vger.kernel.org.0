Return-Path: <linux-iio+bounces-6849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A7915836
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B989C1C23209
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0D1A072D;
	Mon, 24 Jun 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3dS2QjA2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538638F9A
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261995; cv=none; b=BLjrQ/i+d7mtzPI0cbnVKxQVLz0dJjXWi+uCWKHCL1OQ2fC9wdkpyIIdjB8ZhdAonzNw+se2pdPmj1jVeJf43eQVLYCTYn/+oGtcGRCyoO9LtmRcSZzUGGygHjMjkv2U6RD/wKeOSHBrRula17zTMwv4nsyLre/Gf55lC/D9nAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261995; c=relaxed/simple;
	bh=tCXzVBZeQkYUQmfx5cQmS4D3jLS7f/ITU23R6yQNPr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B38kzvrRD0zjtvUVzsSqCujBDGUcp6f+S31zFmMxxJ1T8f06ayXS9PjIFZ9Hvfl+QPxHPw8mW9fjduvnatmzQHRI7IJAdp3X9exGwc6te+nZkKAhDf+6tyHyGouolKCmaF7rwNDNWjua2DwnaJRWtwhwT3kaSPbSoldBwNUrSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3dS2QjA2; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d229baccc4so2553324b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719261993; x=1719866793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qutv/oto4k3CHjLiYH/LMJi2JaaZ7OyJ6RrFkaOKj9U=;
        b=3dS2QjA2YE4G5SDaQ3MoDZeXb5XGKGUoyqkW2FW05PGjE9WNgWJA7FBFNiAhbHkbO/
         Y56p6KrrMSmbTJ6qpQyRwJIasqMteHLD6PsUjEo+76qVGpV3f51bBSuVNDlW7dAr42pg
         kLVM00awAXz+y2DBGmAARlm7pKSB2CQ9EQJhUlBONp7CWydF+xVVn9fSGTXINcc1Pjk4
         8EZB2mGRlOTtX+Vv+ck/I3go33bXRGaFWj/lG5ALyt+e3Uayl5gRpflwgDHNouq6fXwL
         6oSUG+w8YD52JAo8qJ0tLz6hjGTjRTWdPq0bgh14Pmi1ulZmFZ07vb7XSSJ+1q7e4D6L
         C+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261993; x=1719866793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qutv/oto4k3CHjLiYH/LMJi2JaaZ7OyJ6RrFkaOKj9U=;
        b=GDTDmanKN2oVRBhVd6t/wWyaggff1Zyp9L+Pvg+3e8t0ACBe+7wToAocLlCZKQ2gAW
         WHC04/SrMAJx5dsu5dzc0UHpqrw8sgGzpPWZx/qvcruSS8ZrG+QDQ6pnjh8Ouysq5dVF
         /Tuxz3S/HoPCvhbkNinsR7voWZ7gP8c4CM8c9jWSmAGtIc2KehssQbMCOXEjY3jCPdku
         KTrp8T/idPkVAvx+y7Vv4yrMKISmzLYvJvOy50wCuS312YXX+5xZzV114qq1VZQ5MuWk
         qwJ9rPN4R/TkTroXfIA7VHZtebAYFIM9fw8EvRxhQjxeI7yQ5vIJGpcWDZQ2GDB3+Qg6
         CsaA==
X-Forwarded-Encrypted: i=1; AJvYcCWmcR4qH9/row1tIP3Z6p+jkQW9QWPudmNqrrZu2Qgxb9Oo6dAxRFZCO2eZMwZXbDIYaVi6w+HsXcF3zGlQvoVr64KK54IGEezJ
X-Gm-Message-State: AOJu0YwkdPUIqz4XddGTYddcSMfxN8EKC0jZZpDCyb5z3ZoDIofBi6z4
	lTdjXsA2xf/zzxHoGL5cUpkscBs9kE/xj72KFdhCxxMjKoiuGGD1xS9C36V9G6U=
X-Google-Smtp-Source: AGHT+IFKOQDpiTUJU2A2+v8zlTfOM45cY66xTxm8sWLHxiwbGiPKNt1W2dkZi7GJrORgPGXVhGnxtQ==
X-Received: by 2002:a05:6870:c69b:b0:254:9392:e5a2 with SMTP id 586e51a60fabf-25d06cb7c07mr6125166fac.25.1719261992786;
        Mon, 24 Jun 2024 13:46:32 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c106dbsm2092849fac.58.2024.06.24.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:46:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/2] spi: add devm_spi_optimize_message() helper
Date: Mon, 24 Jun 2024 15:46:06 -0500
Message-ID: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
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

In the IIO subsystem, we are finding that it is common to call
spi_optimize_message() during driver probe since the SPI message
doesn't change for the lifetime of the driver. This patch adds a
devm_spi_optimize_message() helper to simplify this common pattern.

---
Changes in v3:
- Fix commit hash in Fixes: tag in first patch.
- Link to v2: https://lore.kernel.org/r/20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com

Changes in v2:
- Dropped already applied SPI patches.
- Added patch to fix missing EXPORT_SYMBOL_GPL.
- Link to v1: https://lore.kernel.org/r/20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com

---
David Lechner (2):
      spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
      iio: adc: ad7944: use devm_spi_optimize_message()

 drivers/iio/adc/ad7944.c | 26 +++-----------------------
 drivers/spi/spi.c        |  1 +
 2 files changed, 4 insertions(+), 23 deletions(-)
---
base-commit: 17436001a6bc42c7f55dc547ca5b1a873208d91d
change-id: 20240621-devm_spi_optimize_message-ebbde029dd7a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


