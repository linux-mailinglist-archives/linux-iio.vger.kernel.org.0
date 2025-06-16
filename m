Return-Path: <linux-iio+bounces-20727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6620EADBDDA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 01:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641C83B5EEB
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 23:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFC231C9F;
	Mon, 16 Jun 2025 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5xha2k9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4D22F74A;
	Mon, 16 Jun 2025 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118005; cv=none; b=mu6hqkTdU3QIpPBZFHUcEINHE0+qoA+bc7r0f/JEBxsRLuW4B0DdcycStCgPVAlOPX5tWz0E8ZAt00LfwtH3kDPa1OcAR3kW5/dbV0TYIcMH/Ofi2U3c/lY7WtlJUxkgk5mI4Ci0qlWCyEoxK58DHjc5erX2dsMrm10K/ru1Xzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118005; c=relaxed/simple;
	bh=Jx97UoH7P/w41US0BD/g6Nys4EWg7n8oWtNxLnSbhm0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iAr6bndkz2gzmAzeRK4aIAtgmPldXumTaMQm5HZFji8kQAaXdHputmcgT3iVWoMeRgcSEBoC3uIpplYh2XxR42r0qzf3gOsHr2Nn0iegWRNS1LFgWzpmICg1F/upOwYbpmgvgh2uGNr4gLUlgJ7r7dntSsRxcakMqZ2E5v0aT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5xha2k9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-312116d75a6so4349348a91.3;
        Mon, 16 Jun 2025 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750118003; x=1750722803; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdL48KiHdZltRPqGUZ1bW91mCWuQPcva+6EqLTRDcDI=;
        b=h5xha2k9OKVjMQJVhQB/JsluZahOXv06pdJW3plmr0tb38wt4PzBFzKMSfh8W9w9zl
         u69MpKkAWFU2M+hXrejXJZHe5x9aG3zHfM2Xbs3V0ZoV79b7JFm4LY4h6FGZ4Rb8y2+q
         ZCWh2agBQwdynMF4rFEFhKF77E4GQfUuZ/5PV6WeeNrd1C+Llqhj884ndtgeQthvqnbi
         mR9rl6oBUyGBM8oVVzzmol9T1nDJTS92A9+5HQ3QZJcKYcTEFAOYr3Ca08fZAsgTxK4l
         B0qkpKU1OaOLd/YjOp/0LoUfWusxRPqZAGCWpedJWq9nfWvj39ZW9GYrVnQZCj+qwtcl
         ROKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750118003; x=1750722803;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdL48KiHdZltRPqGUZ1bW91mCWuQPcva+6EqLTRDcDI=;
        b=BqlWMa36ep0Zk8JsCoyDifZzDySH/GFWBWI+ql//CRpsNtK4ZbUAxQZ2KbrZR6lgxV
         cA4U5Daj1kd+0pv8fokrK4AuFB6WiwEWACqCqMllsBQpeNc/pbf0tB9927ZQlRBvfO7+
         2UtQuU5R1/ALI8xwo/zKZcMsLRapmlFRGmcc5sep30tZwfDHFCeipHpX3Oyl+Bx8D51z
         +UW7XaVSNx98lkgZ39c0X3oJBdTFWC2G2Lvx9uRIYC77fJpJCPj81SFIZDyZb2LCNmlV
         nnQgrgJnCpsaeVzPrYRidlGRXkTnFI+p4nU/O6wEsRl5VpfayhcqdL2wL0Ba7wqP5Err
         EEBw==
X-Forwarded-Encrypted: i=1; AJvYcCVQGpCg7lzZH3mOHEeR3mWfqnAn5sciRvt18oTHpph1iqdtUcPz3DiyexYv6FJWBOvKXnvOL7DY5pS2sDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkd6G7uq9GiP+GzlEdLnt+cziyJjamk06z/7TmBXbec8k/lSxK
	cKrp7InImAofHdyEQXTXM6tXfXKxd0jBwAK1InRwK7QcKQPG9V9FQTlz8/NRvAT7
X-Gm-Gg: ASbGncvf+Fwsc09vIjjZ3u+k63xKv6yep+u7kEr14ajmVodw5CCOeyqJ0TCC6tYBr5h
	gfZAqFS+X5tDLUBVSXI78K5pSJ6H5FHiM7Uv/IB87RO2s1J3aVsEsgmO18R97I8gSB98+IzDr9b
	EyKFTDiSnuqRrKxIQR5VA2SZnzMe4czzF4EOkn4GTmApruqL89OejAgqK/Shn9s8Cz7PP4xDVjA
	1hRGeO0HmUDCGK8dyWxR1yXf4Z/qiY5S7Qq0KsX4nN1MYCpwA61ilGFJtQllqAbU1emlTvPIBoS
	nizcP+JgnND6Nmc0V1rCsX63xobHl7BV7DklCTpk1+IqupQr9Z5Vp/5a5iBdwYyQh8HK0gs=
X-Google-Smtp-Source: AGHT+IEVUyYRT4CmeZBOd/g21z5hS5CoHRLVi+fAxcPwyAxyPfOqy6Tf29XYMOO6CTuuPYiqIz4jCg==
X-Received: by 2002:a17:90b:4b4b:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-313f1e15230mr14601272a91.32.1750118002641;
        Mon, 16 Jun 2025 16:53:22 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782d3sm67515395ad.115.2025.06.16.16.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:53:22 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Subject: [PATCH v3 0/3] BMI270: Add support for step counter and motion
 events
Date: Mon, 16 Jun 2025 20:53:08 -0300
Message-Id: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSuUGgC/3WMQQ6CMBBFr0K6tmaY0ta48h7GBZQpTCJgWtJoC
 He3sNGYuHz/571FRApMUZyLRQRKHHkaM6hDIVxfjx1JbjMLBNRQYSWbgdGCpETjHKWtnCGvfX6
 UyM4jkOfn3rveMvcc5ym89nwqt/VfKZUSZG2cRTRWkfaXbqj5fnTTILZSwo9tQP/amO1Tgw5sC
 w5L9W2v6/oGgRUPaugAAAA=
X-Change-ID: 20250424-bmi270-events-74c6ef5f4243
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lothar Rubusch <l.rubusch@gmail.com>, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750117999; l=2270;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=Jx97UoH7P/w41US0BD/g6Nys4EWg7n8oWtNxLnSbhm0=;
 b=KCYxHDJsS9OCj6MSZ8oC/gsXgo0NsnrDXpgjsHpeq9sa9Ca8sC2x0DakKu/5uL00wllkyAbNw
 Lna+IDMAIUrDqsaNed2RzOsxdnY3AWXlLdL9h5swfYuYoj6y0B2FjoT
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

This series adds support for step counter and motion events using
interrupts in the BMI270 driver.

The step counter can be enabled, disabled, and configured with a
watermark, all from userspace.

Any-motion and no-motion events are generated by detecting changes
in acceleration on each axis.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Changes in v3:
- Avoid the usage of set_mask_bits() macro on 16-bit integers,
  use the bitwise operators instead
- Fix indentation, alignment and style issues
- Link to v2: https://lore.kernel.org/r/20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com

Changes in v2:
- Reduce the scope of mutex lock when clearing the step counter
- Change the type of the 'steps_enabled' variable from int to bool
- Add a new DMA safe variable to the device's private data to access the
  feature registers
- Remove unnecessary mutex lock
- Fix a build error found by the kernel test robot by initializing a
  local variable in the `bmi270_update_feature_reg()` function
- Remove dead code in the `bmi270_write_event_config()` function
- Add macro definitions and corresponding datasheet references for
  relevant constants: step counter maximum value, step counter factor,
  and threshold upper limit
- Remove the event bitmask from the device's private data. Read the
  registers directly to retrieve this information instead
- Use IIO_UNMOD_EVENT_CODE instead of IIO_MOD_EVENT_CODE where
  appropriate
- Fix shadowed error codes
- Change motion event to be enabled on a per-axis basis
- Create pseudo channel of type accel_x&y&z for the no-motion event
- Change no-motion event type to IIO_EV_TYPE_ROC
- Link to v1: https://lore.kernel.org/r/20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com

---
Gustavo Silva (3):
      iio: imu: bmi270: add channel for step counter
      iio: imu: bmi270: add step counter watermark event
      iio: imu: bmi270: add support for motion events

 drivers/iio/imu/bmi270/bmi270_core.c | 603 ++++++++++++++++++++++++++++++++++-
 1 file changed, 600 insertions(+), 3 deletions(-)
---
base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
change-id: 20250424-bmi270-events-74c6ef5f4243

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


