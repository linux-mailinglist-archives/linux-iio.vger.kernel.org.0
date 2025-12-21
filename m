Return-Path: <linux-iio+bounces-27262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152CCD3D0A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 09:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA5B8300160D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18C274B37;
	Sun, 21 Dec 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9XpxzEb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C6273D77
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766306371; cv=none; b=gfDcsCug1b90mAYqay7Hg7Y7dIWlsUhU9IVOssrkSAVYpYZFzbbzyeYRira/nwLko3G1K2275Bn8hXXCksU1CsrmWcPJMuCt4lS+2AD9+dqNp6JMPfcmZc1ntgiElOpzUsniJV5yOn1E0qPPBUEiLzbXHaEUverZu+oGy/IX2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766306371; c=relaxed/simple;
	bh=lpb9/3DK7ALY+1M/QPt26J7EyO42orqOgUYOaDKIbU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLkCT6fI5GuGkoyMsoiuwGlP5j0yttrL4zDLULapdDyN6E4cCOmpmgHVL7jHUQGsEC3gu2dedV8yxk78be49HvthLtRjCDeI0k2qrsRGAvviy38HTtnQLbPLfngUAWvc+0vO/RLIkUhtAP66TFIiE6KJSH00LCEKedj5lrvE7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9XpxzEb; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7f216280242so1266298b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 00:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766306369; x=1766911169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJdCkCbfYuG1MRzNXkV+YupMxNU5tXNQgZDynoVb6bo=;
        b=l9XpxzEbLlqsE7+L2lAqI9s68YtjlTHYppSGxUJ4eOI2iFJRHScEVJNqva0ur35v4D
         pG0SU4IkhyInnMySn//R4AEXPSTEkqX2i5EdtPHcja4lwWM31FSXvPDK6GCaX4Ua+cmK
         0E1M22eYcRusAjs71twZqEx3X+2TG3jI7C/MsDws8L+Ylbdv9q/UOAKLvpf5GAWqSoc/
         vjlgLPiMxOWSC8IP1PLh8qGSVTNRewrbpPE0n16+q+LN/CkkFAELWmotyHHHrdbtnNji
         74M7PFZVcRchv9V3IkuqZE5GFwuBZTCZSbvRQriAf3J1EG7joUd2RCh8/TazpkEIuMyk
         YKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766306369; x=1766911169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJdCkCbfYuG1MRzNXkV+YupMxNU5tXNQgZDynoVb6bo=;
        b=nUKsraNSRPg6+641jVoGhc03RGS+LYG7BEwVaZJ6kG58EpTX4xPgp7JBENm6Jvsl4G
         4BOZ4C2m4fbaOCPGQ+jr/LDPv0PVrEJOMgGMYwYGMQar0OvqMwuWjg6zOH56Jiagwm1I
         Svd/OHLCM6wBAkTw2HA94hq+ueGeaurP9/h5JtLRzxscU7kOF80pTRhDilXxe5M7fAIl
         uL/rJlHDWb/HePx1EM4neaaSCnugUjDPTCjj1NvQ8V06NKYkEr37h8pcayGHfs5XsrhR
         mcH1o4ouuoeCZEFJXX5QNfBFBplej+8W3dQ1WE0ysmtMpwOT7tZmarkN63dstpCc96eA
         Y98w==
X-Forwarded-Encrypted: i=1; AJvYcCUhest4HRIarNeGY5KaGfqhQZSPbbIiqeqsaFSnE8u8fMGE4EUWFpx12UZDXxF+WRXeK5ZwthttTSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUT8nwo97a/a0NRmVieRDFZTk390TTMTEaTN9WAW6wHl62Y/D
	kNznAHL2KwaB3cu7atKN2adfbOg0IgxqQepRSjnO3AnpUSj9wY7Pn0hU
X-Gm-Gg: AY/fxX5YV6IkdGHTIp9j9GVpxaZLLiKHdQfLPaRdEwBUwKZamhiIvVci2D320oliIxe
	gpAcwB2DRsmhJj5UMkcev/UrrAwxx4YWu2hNAg1RrCyK4Xg6J7huwZuNHzxunsiszkJs7Z/2I1/
	Zxnl2RnaEkS+Fdq9o0kj3hU9RvEaVqBJbReRZgJxBqBjaUcKywQ38E9rQuK1wrkJxC8G8ym6jjP
	SlLw3RbiKY3ja4LydccQPWiIQmj6QPwep1dHpGHyCHyQX/ztTa+hZEKu49F6NQAeYITUNvgfY95
	ClFyb0+p1Vdy0VU5X90mLh21ft3I/BLQrQstap4rM1MBTQqwmsp1LxkHGqpvVPs5g/H61WXGtRH
	7U8P//Pg3lYdXYQOZs0e2pL3KgRBfSYH3uzcrYDbGu+nZ5i03leRK1yGG8G3/7s+tOaQZcI/2jW
	oseQSJlB9cUbPShw==
X-Google-Smtp-Source: AGHT+IHXUQeCPQBqGmqZFoHhbNBLeMa9tKpuVdgrE/dzWGTwr6zB+0eGuvqwal9ABefR5JWG7Cqztw==
X-Received: by 2002:aa7:930d:0:b0:781:1110:f175 with SMTP id d2e1a72fcca58-7ff5330cca8mr8545745b3a.14.1766306369511;
        Sun, 21 Dec 2025 00:39:29 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f258sm6932678b3a.47.2025.12.21.00.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 00:39:28 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v3 0/4] iio: proximity: Add interrupt support for RFD77402
Date: Sun, 21 Dec 2025 14:08:58 +0530
Message-ID: <20251221083902.134098-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds:
 - Add RF Digital vendor prefix
 - YAML binding for RFD77402
 - Add OF device ID for enumeration via DT
 - Use kernel helper for result polling
 - Interrupt handling support
 
These changes enable DT-based configuration and event-driven
operation for the RFD77402 Time-of-Flight sensor.

Changelog:
Changes since v2:
- Add 'Reviewed-by' tag to dt-binding patch.
- Update commit message in OF device ID patch.
- Update commit message in the third patch.
- Replace rfd77402_result_polling() with read_poll_timeout().
- Add 'struct rfd77402_data' details in kernel-doc format.
- Arrange includes in order.
- Add comment for completion timeout value.
- Remove blank lines.
- Indent the comments to code.
- Convert mutex_init() to devm_mutex_init().
- Remove 'IRQF_TRIGGER_FALLING' flag from devm_request_threaded_irq().
- Drop the duplicate message.
- Replace 'dev_info' with 'dev_dbg()'.
- Update 'dev_id' to 'pdata' in rfd77402_interrupt_handler().
- Drop 'interrupt mode' comment
- Use 'if(ret)' instead of 'if(ret < 0) for consistency.
- Use 'return i2c_smbus_write_byte_data()' in 'rfd77402_config_irq'.

Shrikant Raskar (4):
  dt-bindings: iio: proximity: Add RF Digital RFD77402 ToF sensor
  iio: proximity: rfd77402: Add OF device ID for enumeration via DT
  iio: proximity: rfd77402: Use kernel helper for result polling
  iio: proximity: rfd77402: Add interrupt handling support

 .../iio/proximity/rfdigital,rfd77402.yaml     |  53 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/rfd77402.c              | 149 +++++++++++++++---
 3 files changed, 183 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml


base-commit: d8ba32c5a460837a5f0b9619dac99fafb6faef07
-- 
2.43.0


