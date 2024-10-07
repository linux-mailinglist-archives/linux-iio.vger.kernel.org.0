Return-Path: <linux-iio+bounces-10301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C49937A2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 21:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851A8B22A07
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 19:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549A61DE3BE;
	Mon,  7 Oct 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+dLZPZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E713698F;
	Mon,  7 Oct 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330605; cv=none; b=PH9tPM/+30/yTVfq1bS341BRVohjReoyec8oYXQEoQQtWpK2ownsSpO8IrvF+MYk8ZhaQA8WcaOJwjPbZOP0YOTNWKmL2PH9H7mUAf+574ECitgat3YflKO6HaPELW5wDilKGvMqaJkqdRZ8HiutkEqrHJU+HGDGogJ35TmYheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330605; c=relaxed/simple;
	bh=iIA4jr4KOC37WTg1iHLrwXWgTT1Ooett3Ka2+ReVqLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u8X/o4ezxY1CvdMNajdJjH6wQpu90YkS4OmNQkcsbO/HCESCIPsIoUb372/Y3Rn902eEKjhstU3zRiTIg5WKMPPQUjyIm3pZGuNCtcKfnF62JhT4PoFh/Yt+cXmRt45uPy4MGQDO+/6Uu7DnxRs9aEBkNcgBflZRYhdXHXNqwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+dLZPZA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so49772775e9.3;
        Mon, 07 Oct 2024 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728330602; x=1728935402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1Wly9B4gCM7EziGbL1nAqrw7t/bTh/fNBe2MNqEc1c=;
        b=f+dLZPZA3jmwCGvjopBdIpRNRL5bMf7GBU/74CjyV2/kYlLGN8x0OhCegzzYGqVOW8
         x4xYy7oXVNdOAzuw9DT5tzU0JoF/m5ST/MO8tCSNiee5Es9TG3/SQp2TI9BkC69zXRxq
         UgmBPWKyoVL95y/HKfV2cG4/bxf11NhRueuyZH2HvYe8UeFPjeLZ6BvMn+KnZq0Qwxju
         gU38YJIJLKOtS9YtU/5B2/q6pRU6LXo0LqQQGr/I+JlTWu/2KCyoPlitijS5+JNjWpXr
         pjfXjijulgsuJ9dPLU/Q/eTJT5FTybPcHu/d5es18qjAPgOf7QyrT5GwN4BY1LuGG9W3
         pYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330602; x=1728935402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1Wly9B4gCM7EziGbL1nAqrw7t/bTh/fNBe2MNqEc1c=;
        b=hetX2sG0MRc/mFzANA0B9n5V0RllLVj7OuUxgQxGk9pXLZlKsa6h8lQFVnLezMNv1V
         s8d3KjCnXbNv2NZZqZGmjdpyCEBH8eDPYXVj9sxrAQ1J+Fdg3Qsg3eBCSmWYdNIMDHGq
         WJRQwGAdPxEJFN5+eNc3zMFoSWj8K1hziuKN1Fcbj8WcNJ2OVuU0ewm9xsHcnlfemsHG
         HTwqgFXKBnz7AT5suggmbJrRkbGaIrYxdfKMBIaZIFY/yrlXVvirwwsB1x+KTh04WcNj
         1uZ33qhKIw0cPKX0eeRVx6v6ben+jMr5TQrIaUHc3jVGLE7pSr9K/ZYT4SjBSyvJWRWp
         9guw==
X-Forwarded-Encrypted: i=1; AJvYcCUNi0HdI8DwKx94qcaZh1oQQ0RfqCjrw/rzbVG82DLcAy4JmwkcmcfWeQg52BwT83ZznsvDHNPxofwN@vger.kernel.org, AJvYcCUx6c5z5cEPpcSN5fB6CmENhFBTfQ/yL87QXVxI/K8r0OIVCD1Q+OQMdBqh1HtX5gy9DojINXTIoQBGgwM4@vger.kernel.org, AJvYcCX1csS55gh8cEVvUL6c5CCp5yNPBXId8sR52sy+HyVUPEwGu2VohaXMSUoHBSRygAdKmDb+sSgxiQCy@vger.kernel.org
X-Gm-Message-State: AOJu0YwtkceKFJAyXsk2gqzQEVGTADO+WIllGAQheTu0YAK2YGhmumWc
	KVj7e0v5vpdVZImraRFEmdXztw42h3Dkx9dJUJOl0SUmnOVi6jgd
X-Google-Smtp-Source: AGHT+IFWyCgyRhp5L0oLLh0VnGIEvBbDgXFbdXsw/lKoALKvIsv9QqEce+Vx9pVPE36H5kQDXoGc7A==
X-Received: by 2002:a05:600c:1c86:b0:42f:5209:f82 with SMTP id 5b1f17b1804b1-42f85aef61bmr102016785e9.29.1728330601607;
        Mon, 07 Oct 2024 12:50:01 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b658:eac0:bb05:9042])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed922esm84939655e9.39.2024.10.07.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:50:00 -0700 (PDT)
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
Subject: [PATCH v8 0/4] pressure: bmp280: Minor cleanup and interrupt support
Date: Mon,  7 Oct 2024 21:49:41 +0200
Message-Id: <20241007194945.66192-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v8:

Rebased and tested on testing branch of iio.git since [0] was accepted.

[1]: https://lore.kernel.org/linux-iio/20240930202353.38203-1-vassilisamir@gmail.com

---
v7: https://lore.kernel.org/linux-iio/20240914002900.45158-1-vassilisamir@gmail.com
v6: https://lore.kernel.org/linux-iio/20240912233234.45519-1-vassilisamir@gmail.com
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
 5 files changed, 612 insertions(+), 41 deletions(-)


base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
-- 
2.25.1


