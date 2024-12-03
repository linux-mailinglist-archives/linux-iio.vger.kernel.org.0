Return-Path: <linux-iio+bounces-13061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE609E302A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 00:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F328D166FC8
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2FC20B1F2;
	Tue,  3 Dec 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfeVbRJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AF817;
	Tue,  3 Dec 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270150; cv=none; b=RPp171zWQ5OWTCcbDy58qdbqlyZi+NN/XftCixPwbDeQDyyytQ9nfqXMUXMKXCan6UcnlLZ2gC8QFZpxJBzX14a+oH9/sboWw8A60S/HSo9sKxpe+dCeVfrO8E0ninb7iqcntyEtwtP+Bgm+tZT+M5c/fjm5V2ijSvTDug94dBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270150; c=relaxed/simple;
	bh=ABNONvwzwbZ9lYuHjxb+GeVAhQsC72921kdHY2c44Kw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eihwOt4dlODmyc4aTbbUYnKFQpm+VToTWsG19dieM0teyQE88zjkhqO1ZBRx30GPo94bv+VnqnCTkJ/LjDiSOKaa5Mcm/5tWw8xLDwdh55f0zUQKehIC59+Dqai720J9a7rXBjipKSmconv5tEsv/zcrrCepHOrvusKasSMrZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfeVbRJ4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a742481aso50506045e9.3;
        Tue, 03 Dec 2024 15:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733270147; x=1733874947; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbmK8djA4c+Q1mS6i8LDpnbtdWAMJS0PnO8F/s9zXkM=;
        b=CfeVbRJ4BWwH8w5ZlGKkE3Zf0uuRjxnYe1uzZxclvGjTAK2DzlBga8hrwZHWNrHGE4
         ngd1pDWByjXmqYf560NdOWiNLvv10ugK3dey4qxexipKsAj+UNTxxGtVK2v9qjfSjFl9
         /RSJZ848gk31c5Qg1ovC/633OCiu/NYSnppkaXzawqUpSo03wf5Yxdy4btXayhMPS12V
         LyhIJ3zu0jTk9wgPsk0zwwZaHsfCYzjTrYx+XW57Eq1Y16xIp1upJ3K6RYjqusHUcuR4
         xU5fUYIO7pFEJtQFbn/zpgDQf0CN7bGHayJ7pM8WDjL6AxHuLq38Og/WuQeIY3n3f7w8
         6znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270147; x=1733874947;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbmK8djA4c+Q1mS6i8LDpnbtdWAMJS0PnO8F/s9zXkM=;
        b=ejJCPt2yjNZJGn0Gp5txvQZDbYbkXsQTe8kc13TFE/3A/obb53/ol28JzJIXXxm98L
         pMPh5imSAO1N80bZojbXu0yX+mgkaC+ZYPHMaed5rpaMdGlBreZjcweet2IxmJscKxYj
         FPSVH316evjFIO62y3+ZKGHWWU1Uy+xFv7Z8FC0TtQJcc81B0CKlC3Xc8BvEtRqewcL5
         DkQtjYOtgG1HaimSzagLTnA2ILPnHxT0kWEosRx33UuuiwXSAiVaGa32xEv4oIAO0DKC
         rds3rUcrCBkxpBiggvvErW5SkGlxDkRww0hMopH+Dy+zKIkEVRwC1k4vDGTjn/7DFqHH
         6lbA==
X-Forwarded-Encrypted: i=1; AJvYcCWUEcY/ciUUK/QcVVe1+nRKL5rZHEgsQTiBA6Wm7J4p0vkL2jkV4k2XoPkcus8XomkyaByBMlrhRHEBbbQa@vger.kernel.org, AJvYcCXOx/QZ4VL5y7tNsN/ll67i83BxaNjFzivl6eZ6oRaAK1PpcbV0470XAy7f2HkgtuQ+Bo3ftVM3sMA=@vger.kernel.org, AJvYcCXx+DX+8T9ZhQC7bW7yEJRgQRceO87bKeioQxUSvdD+I/E728P1vIU6JSMDT6t9FHDZTtBb+TSl@vger.kernel.org
X-Gm-Message-State: AOJu0YyBl2epaMNN0YLJHdXSlZHEAFX5SIJd2nKy+TjH/OtEOyCeWvLm
	eZ7++pOMo5UYp+SYDsQauXoyovx/n4EAgSHBWo9/i6m8nIJ+Lt0O
X-Gm-Gg: ASbGnct9E57u4DN2U1nZDAhpIcbfGMt8oSGbJyDktynhm+tFIuU/r7ZjvxUQ9mtHh/b
	nfRCzKGKtkKQiArEOkovBEoMloKJYEj3n/6VlgHM0Nfg750OrqDpVKPVblabrXVPw3N5TDE1ZYM
	Ccuz0klH8XCjwXS2LiA4dCLpfGhuhZiYBcDwcBl4hLkj6C2hTv8k9x+RUW1Y2E7muGrLG0Xmp9c
	LGzaXtrYLXrNxAi3T8XcbqR0oBOd1SpyTsV2gsEwQdB9v5pjBiqtuqwzcgw1M3MiRCRwMLGpHr/
	8GOqRFWYpBscFUfTmueQTz12Yke9mOyZRwTC9S4UGh0PmB35ka6w2aNnnrBs0hWnZ2xc8jiC
X-Google-Smtp-Source: AGHT+IE9/EzGzkQS9vezRYLj70UVFeDcv857tluybd5MreEdUegU/VqnQppt1LenU3InEpjdD4XpKA==
X-Received: by 2002:a05:600c:512a:b0:434:a4a6:51ee with SMTP id 5b1f17b1804b1-434d1e21892mr35078485e9.16.1733270146970;
        Tue, 03 Dec 2024 15:55:46 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-5e3a-77ab-7b2b-a993.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5e3a:77ab:7b2b:a993])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e287sm3871025e9.12.2024.12.03.15.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:55:46 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] iio: fix information leaks in triggered buffers
Date: Wed, 04 Dec 2024 00:55:30 +0100
Message-Id: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKaT2cC/3WNQQqDMBBFryKzbopJqlVXvUcRSeOoAyYpGZEW8
 e5NhS67fA/++xswRkKGJtsg4kpMwSdQpwzsZPyIgvrEoHJ1kVJpQRQ6h45x6dga301hRhamvOp
 KaxxqrSBtnxEHeh3de5t4Il5CfB83q/zaX7H4U1ylyEVuHyXWVV/Vhb2NztB8tsFBu+/7B4jCQ
 ou6AAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Christian Eggers <ceggers@arri.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733270145; l=1668;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ABNONvwzwbZ9lYuHjxb+GeVAhQsC72921kdHY2c44Kw=;
 b=7cP8gL9VAoCLycqNLU6uYFvlnfWTIUl4/owGsTzXArXV81jbxYygFRfAh1BvSKb1hEbEvthyu
 1dQLccUwkYhDvKHrSStJhRhGjy0JRbuMjSydNsxBJZ19c3tkdxr/GHl
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This issue was found after attempting to make the same mistake for
a driver I maintain, which was fortunately spotted by Jonathan [1].

Keeping old sensor values if the channel configuration changes is known
and not considered an issue, which is also mentioned in [1], so it has
not been addressed by this series. That keeps most of the drivers out
of the way because they store the scan element in iio private data,
which is kzalloc() allocated.

This series only addresses cases where uninitialized i.e. unknown data
is pushed to the userspace, either due to holes in structs or
uninitialized struct members/array elements.

While analyzing involved functions, I found and fixed some triviality
(wrong function name) in the documentation of iio_dev_opaque.

Link: https://lore.kernel.org/linux-iio/20241123151634.303aa860@jic23-huawei/ [1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- as73211.c: shift channels if no temperature is available and
  initialize chan[3] to zero.
- Link to v1: https://lore.kernel.org/r/20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com

---
Javier Carrasco (2):
      iio: temperature: tmp006: fix information leak in triggered buffer
      iio: light: as73211: fix channel handling in only-color triggered buffer

 drivers/iio/light/as73211.c      | 17 +++++++++++++----
 drivers/iio/temperature/tmp006.c |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)
---
base-commit: 1694dea95b02eff1a64c893ffee4626df533b2ab
change-id: 20241123-iio_memset_scan_holes-a673833ef932

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


