Return-Path: <linux-iio+bounces-9338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1789708E5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832121F21604
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86B175D57;
	Sun,  8 Sep 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsOVsPQt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD733FF1;
	Sun,  8 Sep 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816134; cv=none; b=kuDR0JkvjeLMNJjmmbUvVpM356kf4IlJ6Yrcef+BLaDI1oLi7nUEmP/eR0IZKv+5BxdQj1tsfVhMwZN9B3gTxthxLCp9loCS0UHhuOUQ0ntfaP9NXi1KUjceSO738pmGTUXBXSxRzsDi/gQbvHncrFpNo0uISw6c3tOB2oGO1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816134; c=relaxed/simple;
	bh=P5i1+89CNVgiI6rLqPepCwbboW9ljWdOnFqApU+po90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IvtaxM71W07g3JXR8Zsxd6u8NVo61bJht17XoawXn6rYr0zSHydvpvjnrbJi9MepL2mPPETG+Hbp3KiPXnBnQBB4Fj6VY1eVtapbLFjX4YF7XG2KDQMXd4gmf2kQzA8Cam9r0zMohKJH576PIaWtQEbvU3akhD9XG5mmOMmoick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsOVsPQt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d56155f51so17351266b.2;
        Sun, 08 Sep 2024 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725816131; x=1726420931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaRFLIiqgByI8Tt+Uc7hvPM/vlHUKYNZpdYUZBKAbGo=;
        b=TsOVsPQtA2hxKc2tHpx/E+/NzeAm7C6hd9Rydx6QwYYpf/5rdsNzQofUP7cT+XxGcr
         dXVWLzUbk3QQ5ntIa3kRYRqCeLsMSvS2wSDGmhtBqqVpFFbBJIj72nqpe5zw3r5UFT5k
         JZ+HlygSZlOJl/rsnLK5gHoJ5h0kCvav3vZBnBuI6o6bEpdoYHKkcHekPLK18aYfgXV+
         q4HLJ7+Y4ZxjX3imI8jYeA6VAwldQYWHSPuhz4wmrY3aJ7E33tWlShjaKuEeZzIN2Ev1
         jEHYX0JQo5N99vnW1xL5PzoZgr6zVivNBn61iiQW+e1b/j04RzzHunVm73YVRJripM3x
         /Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725816131; x=1726420931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaRFLIiqgByI8Tt+Uc7hvPM/vlHUKYNZpdYUZBKAbGo=;
        b=X9+J8Klxjz5lc3R4VLc/7835Fg4NK1BiWvG2NEYy1VCf8IySdKWPdBtr7GhmTDNmh5
         gtYYBik7x7ZA0lsIjIM6oQB95SC8C8ACyS/Vse6RMMiIjIfOS3bSzmSWXpx8dgUcwm/U
         nQuSHNUs19SEz3+R6ilIwHv8aN4o4xas4nEaMi2MCbi3jj1L9mRCXSgL9C7xR84mlRRo
         vb2MshLN3C+Z19786QRcUJitR/mM1R6XeShz/5Bm1OAHa9ZvobqX8QdAqA3lh186Pcc5
         i/2sbM/d5YXyReIK50/ikep7+yubMTTBMp1v3eRexvNQf2S1ISJyNzCq+hOReo/lfUWC
         2p5A==
X-Forwarded-Encrypted: i=1; AJvYcCU45apwbSweA0xp5HCUq9hJqQcCkC/7EuerJGIL9pSuK+AxAI8tmNNOvNG7Lm9x83F1kWKyo84zbOYs@vger.kernel.org, AJvYcCUha8vwsylxDkxbu99Cs25hOD3ezSJmUaaAAjlr+MdrdBPu+3byMSZlvWrRmDIm6I+pqXk/XitxUFdt@vger.kernel.org, AJvYcCXdODciqgr0xHZxEI/qAtSZ2Oy0wWlh8h3nr/vIKed1ExonXFrOSOCbb2tQWRY8ZbCFZXCmoppY3V3J22oS@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvPeSI4KK5gqPeR5uD3AkibtZYIMYQBIcTgcvdYppgC1XcHGl
	SIOHvQG83NDnAjNGETvgO0u0YpvcnaiLMvqD/okLbCC7WjBLR/2y
X-Google-Smtp-Source: AGHT+IEl6fcC1V4FK0m5YthXlzTLQG/FpPWB6CDdvX+BxJrWPi6Yi4PxTym9Iyz6YVQRn7zmNG8lJQ==
X-Received: by 2002:a17:907:e2d8:b0:a8b:6ee7:ba22 with SMTP id a640c23a62f3a-a8b70ee9498mr491177366b.39.1725816130288;
        Sun, 08 Sep 2024 10:22:10 -0700 (PDT)
Received: from localhost.localdomain ([78.210.149.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61258sm228048066b.116.2024.09.08.10.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 10:22:09 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 0/2] iio: temperature: tmp006: support for drdy irq
Date: Sun,  8 Sep 2024 19:21:51 +0200
Message-Id: <20240908172153.177406-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the data ready interrupt of tmp006
sensor. The interrupt line is pulled down once there is a measurement
available to be read. Hence, triggered buffers are used in order to
support continuous data capture for the sensor.

Changes since v1:
  * dt-binding: improve the commit message
  * tmp006_read_raw: use iio_device_claim_direct_scoped()
  * tmp006_channels[] : add trailing commas
  * tmp006_trigger_handler: use s32 to check return value of read_word_data()
  * tmp006_set_trigger_state: fix data alignment
  * tmp006_probe: check return value of devm_iio_triggered_buffer_setup()
  * tmp006_probe: remove IRQF_TRIGGER_FALLING from irqflags argument of
    devm_request_threaded_irq()
  * tmp006_probe: set avaliable_scan_masks to tmp006_scan_masks[]

Antoni Pokusinski (2):
  iio: temperature: tmp006: add triggered buffer support
  dt-bindings: iio: temperature: tmp006: document interrupt

 .../bindings/iio/temperature/ti,tmp006.yaml   |   6 +
 drivers/iio/temperature/Kconfig               |   2 +
 drivers/iio/temperature/tmp006.c              | 134 ++++++++++++++++--
 3 files changed, 129 insertions(+), 13 deletions(-)

-- 
2.25.1


