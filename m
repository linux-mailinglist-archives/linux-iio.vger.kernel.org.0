Return-Path: <linux-iio+bounces-11037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285109AD8BD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2B11F26586
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5A1EABAE;
	Wed, 23 Oct 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IWeF66v7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23621BDDF
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727680; cv=none; b=sN9Xhx39TRS0tuZaj2wQmzLzx1Q9zVfU/6+E30U5ikL8gHeI/0Tuqu4Kk5drBsFmYpbFIM867MQF6ciQ+avz+WunagBxNSMJNLMuae+5wo4jm/RJ8Yzs6maBkRJrQF5Cy0IuoZU5rdTJ6xDjMQOD77IPxCQMSZ64PVnqY6biJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727680; c=relaxed/simple;
	bh=I4GmRGGB3tkiacRF5gleikU6SA37GO6iMlLu3WWb6eo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JP3HzEiOpaucVLw1zv4L66fVr+eanGLLD3ljDoToT7jJztl7pRpkI5ls1U0KFmLBZ/BaFfcNEFjYzqYwietOztaUtzHwQ8lHhXRlKrt4RY5EYH9CFTElN6vFzwl6Aqa56ZZM1poWl+vb6ZDCD3DMxy1QqnBVpkReHyhizyCEJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IWeF66v7; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5eb5be68c7dso161251eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727677; x=1730332477; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DPfmr5DaiqCsn7BKKUPbilfPKXqx/V+Fx2eV3zkRXcw=;
        b=IWeF66v7rhFiW/6y0xDEIAV9FDw4s4i9RxbCf3PcJGb6Flh5lVzKeTJOvkhGo/YBmM
         PJu1fLHw4r1pTeJmni9PnRnK0SaRW9f4S2mCYL3R/YoD/ZOmIra3UdrGWYgD7+qiB3Jq
         b1Eyk7NeLz3TFCyA7p/5pkOGOCXx3ZMq62sJZNH61dhRMbx+l+4Pvny70v7UxUpME5/E
         RfrBetPO85/cEo05jx5dE1LU20Zf21d3iIVMnKpXj6oE9W2nVLelmgHKMV6cJIEfFHgh
         ViKB3Dc081mWA1PndJfQ2MSJc2LT8+72fYM3Eyn+cUIroEvMZRziRnFU4uIcri1W1f/6
         K4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727677; x=1730332477;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPfmr5DaiqCsn7BKKUPbilfPKXqx/V+Fx2eV3zkRXcw=;
        b=MiNwx31Qd2H6Ib19clq1YjrvuptGlQlHh7eYKmR/86FxT/hNo5sgjhh+o9tCtzfKRw
         Pe0ZSPk5UL+Qzs2GD33hASMLLRYpW4G2IkFkk53PQ+BaC7uDgMRh9KpKEOrJzazXYxKN
         WtbL+RZPfviJr0sqQZb5mi7zdVkZ043wWeF6APUqaCK8r0yiVbg8JgB3w5xdif8CMPE8
         JDxBPkzBA8SugoEjs4CIvPPIgafbGRizhCCrTlxPkK7oKwENvnwrQBAJ6JBaJxpk0KkN
         Y4AFHix1yDBsePScEqa73GEgYX+dJCjUcVDRUqYGanQHSaYE7PFTsjnN4IbuxwK3F39m
         WM5A==
X-Forwarded-Encrypted: i=1; AJvYcCWKpRKKXBYwuHH6UyN0v2A3buu8DHGmbe/HnGhTPaELSvHWKG65EpwrykZSkSPsfteXc1E/CVU7AH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7CxxpGcbTwrC6doOawuqhbGAiWipJsxRK1kNn1IyB81LtUjud
	LeirnoGKOuP71rMRKMi6788Sqfw0K48C74/a6UNtBq+WVP+RtDzuZ8EwHseFJ7o=
X-Google-Smtp-Source: AGHT+IEVKSKJy6sL2E5e5mWOJyf6hp0HoBDaNv5hM2DcLgkFq6rNlqassOJBWoptlq0H1kHReioeYg==
X-Received: by 2002:a05:6820:541:b0:5e5:d0c8:8030 with SMTP id 006d021491bc7-5ebee8e372emr3546007eaf.3.1729727676897;
        Wed, 23 Oct 2024 16:54:36 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/11] iio: use devm_regulator_get_enable_read_voltage
 round 5
Date: Wed, 23 Oct 2024 18:54:04 -0500
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyMGWcC/1WNywrCMBBFf0WydiSvSuPK/5Au8mwHaiOJLZbSf
 3fszsXAPcPlno3VWDBWdjttrMQFK+aJQJxPzA926iNgIGaSS81boQAxQ4n9PNp3LpSS9UfI8xS
 gASV1a4zyRjnOaORFDfwcgkdHPGCl+nr4FvH7/k/b4On01TTg5pRiiYEkNsAigYNxTpjkhZHa3
 Z1dR3QlXnx+sm7f9y+ZWKZfzQAAAA==
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Here comes another round of reducing boilerplate code by simplifying
getting reference voltages and dropping more driver remove callbacks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (11):
      iio: dac: ad5380: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5380: drop driver remove callbacks
      iio: dac: ad5446: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5446: drop driver remove callbacks
      iio: dac: ad5504: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5504: drop driver remove callback
      iio: dac: ad5624r: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5624r: drop driver remove callback
      iio: dac: ad5761: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5761: drop driver remove callback
      iio: dac: ad5770r: use devm_regulator_get_enable_read_voltage()

 drivers/iio/dac/ad5380.c      |  85 +++++++-------------------------
 drivers/iio/dac/ad5446.c      |  77 +++++++----------------------
 drivers/iio/dac/ad5504.c      |  59 ++++++-----------------
 drivers/iio/dac/ad5624r.h     |   1 -
 drivers/iio/dac/ad5624r_spi.c |  71 +++++----------------------
 drivers/iio/dac/ad5761.c      | 109 +++++++++---------------------------------
 drivers/iio/dac/ad5770r.c     |  41 ++--------------
 7 files changed, 88 insertions(+), 355 deletions(-)
---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20240813-iio-regulator-refactor-round-5-3248993c93b0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


