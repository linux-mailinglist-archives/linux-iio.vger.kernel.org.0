Return-Path: <linux-iio+bounces-6688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A1912EDC
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD2EB25622
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2461617BB2F;
	Fri, 21 Jun 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O5GPFEHW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39017B4E8
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003100; cv=none; b=atnKnVmHVoIujdodPRddDtvojDZyNmjLkfY5tzZAIwv8FP+w+kCZOqOO/dCjXDf9vEA9bvwicu2GBFCnuGJ+zuiASlkWBiPrQTvsvsp40SqpV2JHm/QgrhJknUcduyGCVO+hD0A8d4k12J2e35QEyf07WfiymHg5fGIBqAEN6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003100; c=relaxed/simple;
	bh=3hdGVUorPp9c3chARv02ErSOyGivV5Bdav1bowW+7Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m67k9LzCZuFEdaZtdea2HmQOzi5zAsFomkrx+kz5Zvbwujy9RkHy+zTC3Az/Ug5WVxAcPm2+VCkAVAqf8l8zjlFh0b3IbhskpPy96pMFxIWpY0iyvN5HF6MVvtVzyUjz0RZ6fRm+JhVf2MPNpZHo+NTLCF9Vh7Ni+p5nuCZiSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O5GPFEHW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d361cf5755so1363713b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719003097; x=1719607897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoA9hZ9WnRsqQql+yaAmrG9puGVAmGMo+xjRJ7s2mms=;
        b=O5GPFEHWhsU8kp+qt4EqDMRx0jr13fg65+28kdOFYTnFi0t2mDgDGGgB+O97YzOcKh
         8/k7xrWaKvkVKm75MU+fEBYH84C0njb3QIa1z6oCLWalem9mAyQVo9c3DcliG/XxcJY9
         uMSP8aa0Ij9gOqebKxdYt2X+WcSxptWGAwcFi1fkKIZHc1P++shNC9krSM/Gfbxrwdy8
         5IgYD2S7qyb4qHO36DII/IsiQt9e1qJHQc47tWz5Vllw6jEyOiO8r/TsH8Y+sZLqeijK
         WCTxc0gIAu3YKHsjWr4rg4jykGLp2culo8hniNvQA/44gzNb8RS958LgHI13BJudtRy2
         Fq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003097; x=1719607897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoA9hZ9WnRsqQql+yaAmrG9puGVAmGMo+xjRJ7s2mms=;
        b=Q3dkrtFoFKORiYWeXotnhAumvyls+PkKhqejFDjP0/9xRyAdgJvYMg5MWDI8ARWRNn
         DnXlRZLXkZ7lRJ6l9gg94XViWR8wVziAJeMevcK3DyEnxWwYMn1XzQUOWLbOeRYzTSAO
         z7pRq/uk3RNdSmVMrge3wZ3dQT0KlyuL+r+MWIpYPchwsiesfzC+vcehEruSQGw5TuNI
         8Ozs1NW9mZSUiJBLwhJ+UkCfOcIytpZGI2I4kvBTKnVE015x+OX4trULfRQjKB99IEwA
         Zcq1fqEpCSsb4vq7ml4IC70jvVhLEVGlJCJjhmq2XO8eZ65SZCBTqYxseoR6T1yg7Ge0
         sddw==
X-Forwarded-Encrypted: i=1; AJvYcCXqeDp//nqVcOmriV6t443A10zFDxL0gDckoKtKrVERyZZEMry+GHn6bbFrwpHFP/gtfJyIVM7eXibXkx4vWHjwGmCpsnM585vK
X-Gm-Message-State: AOJu0YwLAvNBbC0rmc+7K5E9m6KbdHX4hJjp+7GJqFOc90V0GySr51KR
	JwHdNx/I7chO1KFBiS59Gf8QnIyeLTflg4MKa7qzv9vePpve6yA0b4ceYCVt/oI=
X-Google-Smtp-Source: AGHT+IG4xUoDcwuELvZwr6LG9uss5vNKlYqqi2OOZdEWOEtWwrPLCmPvrHot1em53eidvgyCgrkzcw==
X-Received: by 2002:a05:6808:238f:b0:3d2:2a43:1c03 with SMTP id 5614622812f47-3d51b96c6e0mr9705037b6e.9.1719003097507;
        Fri, 21 Jun 2024 13:51:37 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345e584dsm428089b6e.55.2024.06.21.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:51:37 -0700 (PDT)
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
Subject: [PATCH 0/3] spi: add devm_spi_optimize_message() helper
Date: Fri, 21 Jun 2024 15:51:29 -0500
Message-ID: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
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
David Lechner (3):
      Documentation: devres: add missing SPI helpers
      spi: add devm_spi_optimize_message() helper
      iio: adc: ad7944: use devm_spi_optimize_message()

 Documentation/driver-api/driver-model/devres.rst |  3 +++
 drivers/iio/adc/ad7944.c                         | 26 +++--------------------
 drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
 include/linux/spi/spi.h                          |  2 ++
 4 files changed, 35 insertions(+), 23 deletions(-)
---
base-commit: 0ca645ab5b1528666f6662a0e620140355b5aea3
change-id: 20240621-devm_spi_optimize_message-ebbde029dd7a

