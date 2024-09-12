Return-Path: <linux-iio+bounces-9474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5797759A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 01:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C5C1F21476
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26931C2DB8;
	Thu, 12 Sep 2024 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVEhHMKc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389218C004;
	Thu, 12 Sep 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183963; cv=none; b=FrOEgZ43GNbxMknnsBo2Ghq9qQbCirLufyOoHdOHp/24ziMLszAvt+nENEzCAW/k+LXKeEOX7gzAG+9Y5VOELe0MLx404bmtXxHy4gaBZn21u3a8LUP8u0p7KdGiV5VyPBPSmn4Oj0iFg7GwTAy7TMqpxgsCDSKHAw1Y2PgqoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183963; c=relaxed/simple;
	bh=MwBiRcebgFejZ7NnmF7yso/zNLRTuVzxymdAskFQDw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pBZscQ+uSpnt8AEV2YGJEuX6C0fqSzf1iSe5FIjyOdwHh5Yd8mIAHHNBvTgyo+I67XkRXzFL+Yvfr9gp4LIEweMCIHaKWFJ0AVAEwVIWONHz7/ZYHys7PZ2A32xa51SjVRN2UdUuMcnznGiOuZ0o7/V74CJtPvXclBzMByGgnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVEhHMKc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3d2f9f896so367429a12.1;
        Thu, 12 Sep 2024 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726183960; x=1726788760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cw5p1wONQt1xZkiqpK8DnoIpAgNzaO8WQ5uVapWWj1g=;
        b=gVEhHMKcwk/zphav0lRUYwVb6JA/8fWrjFmcG7u5x2LAHZYhaXZvxaRqwP2D41pggI
         r+87wBBDg/4sgMRamP6e5J8ySPxubJyOt9NiXtoUCi6IY4O1aY9pSS3RHnxriajgtxdr
         PHI5NFgMQ/U2v61hPIKBMijkGFwgjmkhRt6qxYR7gmVju7qudYwbIBBwalQX1uzgFfCA
         732LFgnIQDUuQ5CwSK9cRxcKrbgFe7PudSfMmAe6rgdsjZq9H7XAN3hGTyXnA4NwLISR
         8Q1VFiMcSWn6NFe6Ime7gaYZ9/SiB9byXuAYPIumim7VgShbIgKAQnpA73n1AxOocMxf
         +pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183960; x=1726788760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw5p1wONQt1xZkiqpK8DnoIpAgNzaO8WQ5uVapWWj1g=;
        b=VkdElrXinVBhOIH5a/g5GgqFt8zdSTNIJmmTtGfQExFgteBBLb7n93Zpw/yxjNdqzr
         x1bDUbSuwlbUMHYG8I6CCGP3RITqt6Xj/CzghWRvWKBCYS4hIXOuIBf2/bqP2AH7nXsY
         iT2Oxju5AucV/FpgShofGEkqJrNS1nsXMQu+YXyNfv7fM0axF/EpFJGKs3yeMrSh7ibI
         eWzNdD96aooLbfgTY8OAjRRzUhuSElUr07b0FPsXQ8XK+rUSCVIupN+W8QUdme8vyUdh
         YXi1hiD6xx2R2lkNIjJ2S1kAJKHpTOWxN3jc3w7P99f33uK0s+pzPftnp9O9nqf8iHLN
         dH+A==
X-Forwarded-Encrypted: i=1; AJvYcCUuz6KgcKVdE0cgtyL3X94lbdpMQeAgCRAjXsvve34B5QTnpyM0JedNZ0/7xBXdu7CCeS437WtTUK+XgI/k@vger.kernel.org, AJvYcCWwelv7saU6lTRIp0fYwgV7wAhFq13DeAUyY/0t4aWSFJ8DPa6ny251bwQ7KCeK1323cfCjjCluZyIS@vger.kernel.org, AJvYcCXXSEZCwlWmRhCSGOX09du44Sunc5QqEAlYecJcGEgLSpXK2yFtiaTzuRRxZJFxiMBnjoMNgvl7DHxc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Z4ST5tnTcxss+rGauuaP7LM3rvVvPNJyiHlpGeLxxq02oDjg
	+rCDkgGfEvzrQJD4WeHKGxTzdpzPXMi3gH4iWFITjyCBbAiBjt+T
X-Google-Smtp-Source: AGHT+IGuHaQK4z5w1jGYkv26zOLeNWC1SWAP5EpVI/5+J9unupfzkfDZEEmbQmSJCSKALGlfaX0Jww==
X-Received: by 2002:a05:6402:2803:b0:5c3:2440:8570 with SMTP id 4fb4d7f45d1cf-5c41e1acc7amr567693a12.26.1726183959630;
        Thu, 12 Sep 2024 16:32:39 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c421aab306sm26693a12.73.2024.09.12.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:32:38 -0700 (PDT)
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
Subject: [PATCH v6 0/4] pressure: bmp280: Minor cleanup and interrupt support
Date: Fri, 13 Sep 2024 01:32:30 +0200
Message-Id: <20240912233234.45519-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com

Changes in v6:
	- First 3 patches were applied already, last 4 remain.

[PATCH v6 1/4]:
	- Remove outer parentheses and change indentation in mathematical
	  expressions.
	- Use De-Morgan's Law to make !A OR !B = !(A AND B)

[PATCH v6 2/4]:
	- Remove extra line
	- Use contains keyword where it's needed

[PATCH v6 3/4]:
	- Change string from small to capital letters
	- Use better naming for interrupt pin config

---
v5: https://lore.kernel.org/linux-iio/20240902184222.24874-1-vassilisamir@gmail.com
v4: https://lore.kernel.org/linux-iio/20240828205128.92145-1-vassilisamir@gmail.com
v3: https://lore.kernel.org/linux-iio/20240823181714.64545-1-vassilisamir@gmail.com
v2: https://lore.kernel.org/linux-iio/20240725231039.614536-1-vassilisamir@gmail.com
v1: https://lore.kernel.org/linux-iio/20240711211558.106327-1-vassilisamir@gmail.com

Vasileios Amoiridis (4):
  iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
  dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
    BMP5xx devices
  iio: pressure: bmp280: Add data ready trigger support
  iio: pressure: bmp280: Move bmp085 interrupt to new configuration

 .../bindings/iio/pressure/bmp085.yaml         |  22 +-
 drivers/iio/pressure/bmp280-core.c            | 580 ++++++++++++++++--
 drivers/iio/pressure/bmp280-i2c.c             |   4 +-
 drivers/iio/pressure/bmp280-spi.c             |   4 +-
 drivers/iio/pressure/bmp280.h                 |  43 ++
 5 files changed, 613 insertions(+), 40 deletions(-)


base-commit: fec496684388685647652ab4213454fbabdab099
prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a
-- 
2.25.1


