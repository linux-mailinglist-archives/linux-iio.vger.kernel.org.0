Return-Path: <linux-iio+bounces-13862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B19FE779
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F8F162717
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A221AA1FE;
	Mon, 30 Dec 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEu+XATM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14630CA5A;
	Mon, 30 Dec 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571656; cv=none; b=Y5SXEXEvHGczjUA2h8nF88PUvPURCzl9OOsJJX+M+3uZhlKtvJf1s7iHiCej0Sl792Jd2JYYTy6PEpTFySSvsg0Tu44KkAeMhD0WyPWQYKg8ARCrxzC8pQ+gurH5ixh0+j96e2HAS1DaK3qDuH30jsZK1bOfXkQTRASr1o0Z38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571656; c=relaxed/simple;
	bh=oqCz24Fgg9/n1n1vopL9lhr1nx2E0CIwJAKl2YZr9n8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P+r0uJq6XStkpPNwe51YijB+qH1jaUjK7hEIreLLMYJf8G9a6ef3Q9MztdTSpEuSNFRjk+gk2V7BVokLIDM0Ewy7WIBpRc1GLIynTSfsILjdK3pQzhdJZHaEzvsGXx1kgChHZWlq1vlZc7idG0t4u1VNMAtnn0/2f486lc+wQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEu+XATM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43675b1155bso77665395e9.2;
        Mon, 30 Dec 2024 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735571653; x=1736176453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sk87IWR4Gic1bbY+XCfjlhvtgID08HekhRhQb08ayY0=;
        b=TEu+XATMlLYX2zBH0imGoMc+cfbHfJFg3O3s7eBDjl8Jvp47yKHoZ4NIhltlf8EFLP
         7eArvIYtvl711YZ02kuXKFqu7n78eyoER1gqZHOK18BAtwtiPOzrXfU4QZwk9xcA/5+j
         UORPsAXxIB6pWlecSczsKmR955paNMQr1CM6PErMtd3f3t0aCxCBdIGJFdugxH18IEbu
         Ia0q7wp1J6zmo33DAAdDC+KcMAtZXXgXV5zK14kiBKrne5wR2iL0/JXR6PkEMDWE+J72
         g2U3+t115heO+o0RBCLqlC2jaP42OJTqo8cjgd3Iune6WlyjrjUN5oQzlWbbg/EEybxf
         y9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571653; x=1736176453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk87IWR4Gic1bbY+XCfjlhvtgID08HekhRhQb08ayY0=;
        b=iAqtKqmnjqoU/H+cZIYP0N+NGLSimHVdLftcLA/X4mKAIBlA4ecjE0LuqldlcvoaPh
         xRz26mdcayuOaGHCftuzhiyIj7ZxleLDEXzOMlSTUL1kxjf5+oeRkA2m0Om5McpW+ARY
         6Y0ZTNKeRbZvmctdv5ql4liJxEV13eazJgUjrrN6ciMQeDqkOsHT3YdPjoYWq/7D/6a6
         UhA7t6YxggkXUSiNszh2HrlCRZo4oXaKEtmozUps8HeIadLKrA6h2+Dzde0Z10zo/Itr
         qzgeJ+IKMZMc5X3IdsyxBAC9zcSyiAuVTF/nnwGwPha5Ama0S+ObLBeXzB/ORPc2tp+A
         yUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZC7FZa9qJ26B708LJPpU8wxxwTmVzYgDVjDC/QzgYX03g6e9Z28W4lQG4f5zNj8pdTvo6lk1LE0/XO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRuSvOPaON8ef1/mA2hhvusor99jXf/kzghwRYlcVY5sslrlm
	gArC7Fj870BmaWuzfofMlMzlltteaQCdZeLc745jVrA2I601HL91
X-Gm-Gg: ASbGncsKixIe6KFBZIu+IuicsD3HnmoPQgbukiuf4fsXWPVVtrpEGSdCsqV8Yza9HLh
	3tFKrdc2JKup1Td5EGS5msuhLyLMgZaBj37p9RZm4r2PDTV7tiCX8xtCWc4ZaGXUCU2YvPh8Mp4
	3HPMT1WUTqKfviXEHGdN2YlHQS3IVBJGGwvxL4/RtxQFassQxR+11Z/W6ekH6l2555FMIr3DPP/
	N/0WZj6C0TsTFg3yzYHV1EyHLEXDKhD5tOsToeZL0ThsfjgZVPwMwTE/HopzQye0GxJhATeHBGl
	ipOMu7mtnLTFLCfGnSzF0xk7Bns6
X-Google-Smtp-Source: AGHT+IHr0nMtr9+td1w7DMjCAT5EECoxTCZ+u2O7hDNYM7Wevg0IEJRwJqZXqhRxpyZjR/zejSjKQQ==
X-Received: by 2002:a05:600c:468f:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-43668b785ddmr278207365e9.24.1735571653034;
        Mon, 30 Dec 2024 07:14:13 -0800 (PST)
Received: from [127.0.1.1] (82.158.190.253.dyn.user.ono.com. [82.158.190.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea47asm358056485e9.4.2024.12.30.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 07:14:12 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/2] iio: light: fix scale in veml3235 and add helpers
 to iio-gts
Date: Mon, 30 Dec 2024 16:13:51 +0100
Message-Id: <20241230-veml3235_scale-v3-0-48a5795e2f64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+4cmcC/2XMSwrDIBSF4a0Ex7Xo1ZjHqPsopai5SYQ8ihZpC
 dl7TeggtMNz4P8WEtA7DKTOFuIxuuDmKQ1xyojt9dQhdU3aBBhIDjynEcdBgMjvweoBqYIGq9I
 WJm81SdHDY+teO3i9pd278Jz9e/cj394vBeyXipwyaqQwvGLGGKUv3ajdcLbzSDYqwjGXfzmkH
 JBDqUqpbFEc83VdPzwboS7rAAAA
X-Change-ID: 20241215-veml3235_scale-62de98c7b5fa
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735571652; l=2657;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=oqCz24Fgg9/n1n1vopL9lhr1nx2E0CIwJAKl2YZr9n8=;
 b=ys2DdfudbNwO7YaxZP0Ea4yZ9uiFf2TH1vr6m96G4/eahnJx5bjq/OVmm/hD0vcXMGN/u8gDS
 gXD3eumoJQ7BSpkJ+2bG8hR3m9PYT8bpYEUbq/ZYlx/Z2GvLxN6Oc1H
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series addresses an issue in the veml3235 that was inherited from
an older driver (veml6030, not covered here but probably addressed after
discussing this series), where the scale is does not follow ABI.

To simplify the gain/integration time handling, the iio-gts helpers have
been used. And to further simplify the process, two new helpers have
been proposed to address repetitive patterns that are found in all users
of iio-gts.

The additions to iio-gts are wrappers around existing helpers, and I
have tried to keep their names short, as adding more prefixes to the
existing functions looked too cumbersome and inconvenient to follow the
80-char/line recommendation. I have not added any test for the new
helpers because I would prefer to discuss them first.

This series has been tested with a veml3235sl under all supported gains
and integration times as well as with a few unsupported values to make
sure the operations fail in those cases.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Rename iio_gts_find_gain_sel_in_times() to
  iio_gts_find_gain_time_sel_for_scale() and update its documentation.
- Rebase onto iio/testing, apply tags and drop applied patches.
- Link to v2: https://lore.kernel.org/r/20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com

Changes in v2:
- industrialio-gts-helper.c: explicitly return -EINVAL if
  iio_gts_find_new_gain_vy_gain_time_min() fails for the minimum gain
  fallback.
- industrialio-gts-helper.c: check the non-zero value of ret to continue
  to the next iteration in iio_gts_find_gan_sel_in_times().
- veml3235.c: drop code style fixes and move them to a separate patch.
- veml3235.c: add patch to support regmap cache to simplify value
  updates.
- veml3235.c: put 'val' back in the arguments of set_it() to drop the
  diff, and check it internally as before.
- veml3235.c: fix typo in comment.
- Link to v1: https://lore.kernel.org/r/20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com

---
Javier Carrasco (2):
      iio: gts-helper: add helpers to ease searches of gain_sel and new_gain
      iio: veml3235: fix scale to conform to ABI

 drivers/iio/industrialio-gts-helper.c |  77 +++++++++++
 drivers/iio/light/Kconfig             |   1 +
 drivers/iio/light/veml3235.c          | 237 ++++++++++++++++++----------------
 include/linux/iio/iio-gts-helper.h    |   6 +
 4 files changed, 213 insertions(+), 108 deletions(-)
---
base-commit: 627f3c41ca005398cf1e86a312c5043147ec7ea6
change-id: 20241215-veml3235_scale-62de98c7b5fa

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


