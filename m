Return-Path: <linux-iio+bounces-20485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629AAD6163
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190D13A685B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0199242D94;
	Wed, 11 Jun 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x/d154/y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC323AB94
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677627; cv=none; b=ZloYnNDIyVg1X03WDfsSK10ddhkYLS7aSVUJAdAuNllJyEk/E3Yk38nLMLa03V/yShFpedCXqydi+c+AsONRBMDmTkE6z7jA2G9YoZYcFA91+3zBwn0fIBEWFhAJ7JbJr6df1JxWjatHQPycRlKteQ0qNlY2FwjlokkJBLR5K8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677627; c=relaxed/simple;
	bh=3xGbjEvhtWNk9UZDW4oDQlZf3t0OoAAqRkGj1GJGXjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tLWQWc56JjgYBPGqveJ6FlnycxYoxpIKinklDe36+/T1b9/xjbmoVrNBot6NzVudmXvL/tKruQ8PnYGaG9A94vMH3S4oCPjf0IuESukyQ5fHCZMCLRJI3OFUroywrXzUv1Oj+sQ3VPJd8k1Kv58sKkNDXjlJih+GkwA2SVH7+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x/d154/y; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-408d14c7ebeso176946b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749677624; x=1750282424; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy6UWwrY4Tniy+czQvdxOfPUTPr6mmKu08OTScCjXL4=;
        b=x/d154/ynLwxgipqS6zH+Jp0vkDJV/uijutulFwNZHN2Me8yAZ18COkZhNUIoPY3+i
         M/Mce1SMSH0nMPw+sx3hZyhRrOK6Yy4F/9RJEvgZywYyqkOoptvpERTm83SNYjog9QEQ
         FJ8ztk8N4IAKrHrTEzxcWP11fnmFa3/SnwUi8bflZFLwvSdMWsz3EfO5Fg7K/e50Z8Eb
         J/vE0YiDiLI8ea8TjMhdGYe1K4nMYntgfq7wem7+AD3I9tLrEzXcaSMf3EqIY8DLr4sg
         W2z/2ms8MPyzMUmAbyJRC/H7N1+Ij+cZs57OYuAxSvqR/nj0nqRqR2ZMPy3HfwaLjOyN
         YSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677624; x=1750282424;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy6UWwrY4Tniy+czQvdxOfPUTPr6mmKu08OTScCjXL4=;
        b=WuGPnonsYFf64Xn/kpElm535WABJBiUc1DOMwqLtChA79fpA9j5lOG604VFbLXdD6r
         1qihJ+4hTcVYfqLx1DfAyUr6XXCQ47DvwX0JD18EXUfl2WTuSVwVyy3zPPG3Kyd2FOHo
         DtS89zHKOSW3j9Mevq0lj6bxJRQvfeZm/tbK4F6qpjxKm7YxObWQxbPHuvNKHUNt1oq/
         eIJc6FZD4xQ4xLhFMF3kOeI75eUYm+f/oYY/DJ6eG7X9NAfZe/4kEwqWFCAXg6ChyYRt
         l6f4hMIcd0aN90rj/EtH7iAoRN+nuryOzUJ6zA7iJYJHIO+3Vmy2GkShwdIkl/4dp5yW
         cKZQ==
X-Gm-Message-State: AOJu0YwYSgYAc6pgNhMkC8uocHDYZf61MbVmhuCkDlg/RFAl6s6sdnp+
	l+XtNco9VuYCcckQcsSTv40gl4N0DZGYUI3eOb305bWiM9ai1eKOyqVoeCIIsNpGwr8=
X-Gm-Gg: ASbGncvsy0J1KFVfix0zvCom92X8qdjz3eoQeRXUInuD1uzeWMYqmidMACh+EInDAV2
	ukJMq2eOAdo/8bXwU2nO4+Rt+f4jTvAb4L4FzKxoHi1hSvklY+7oXNyidYEk5zqBL44JPQwbURQ
	FMybjeiBYyUVW2gLXGLXTcOxw17656mDwoNiaOBNKfEdJzXxZXA2DcXXQbPVFnf/kCqd4qwqZeN
	gOZuvs0+ODtlc63n488teF4dsvh4vUgfRHQvoGG81l5GvVBTM3ezxWYmoG7WMjKqtreqP+4jaHf
	FiUwBzPhSmMpvi6VX1EashIaaTrIQicPAeEISG54k19lv5THOEMPCxuLynMXVvEl+Jkehmv56HU
	n4GY=
X-Google-Smtp-Source: AGHT+IGSrMqexpW6ugcP80DLENJRmDJg90YGu+YfvZUzRlil4e88131PLFwRMPRkaCzUBoSu4y7+9w==
X-Received: by 2002:a05:6808:7005:b0:403:3673:65f0 with SMTP id 5614622812f47-40a5d16118cmr3627488b6e.31.1749677624463;
        Wed, 11 Jun 2025 14:33:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fb0bdsm2262b6e.23.2025.06.11.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:33:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/5] iio: amplifiers: ada4250: various cleanups
Date: Wed, 11 Jun 2025 16:33:00 -0500
Message-Id: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAz2SWgC/63Ouw7CMAwF0F9BmTFqHqWUif9ADE7jUEt9KSkVV
 dV/J+3ICpKXey35eBGRAlMU18MiAk0cue9S0MeDqGrsngTsUhYqU3lm5AWYe8B2aNgzhQjo0KQ
 NRN67GRyOCPblPQXgLg2PUGqyVmpjVJmLdHkI5Pm9q/dHyjXHsQ/z/sQkt/Y3b5IgoaDCurNDZ
 5S+WZwbtoFOVd+KjZzUHxiVGGl9aTOtEX3+xazr+gFAV9a6YAEAAA==
X-Change-ID: 20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-93ebb1344295
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=3xGbjEvhtWNk9UZDW4oDQlZf3t0OoAAqRkGj1GJGXjE=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGhJ9hCiXPBgFvY9Ne8YAtoEsFFlNoNxKf6+93hubX6RyKnwD
 4kBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJoSfYQAAoJEMLMIAH/AY/AyggH/0B2
 MKafUNkwRK8U0wJm/ZABhuZBykM3VFl6kaSOvdbVGTgtcmBryRKkc7yZGhwtkXXld07hfFjZM6F
 uYs4z2zNLh/3U9r9fxN8iFwq0yQqAp5xAtOxW81xGJH/yFnI2tDM+2yY4wc4hnh0W/0CCGlNmlz
 ELSrJt7j7jDTEOtRtoplFB+aBw9BsEL+lNT9DCokOzGDs2ZyNpxPdD1e3lcw80tOJq35towUe1j
 0LxMWpv6g3jBMd+3SVMlnKRFc18liG+9IKsM5iSARCmqahGOmTlh1W7JSxYA5h0Sgzw9VPSEX6x
 +zfv8rxRLMmZVbqtIKlSsnxrDe/pipsKE1FHRP8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

While investigating some potential bugs, we noticed quite a few
opportunities for small improvements in the ada4250 driver.

---
Changes in v3:
- Split into multiple patches.
- Added even more cleanups.
- Link to v2: https://lore.kernel.org/r/20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v2-1-1bf9b033aaf5@baylibre.com

Changes in v2:
- Totally new patch.
- Link to v1: https://lore.kernel.org/r/20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com

---
David Lechner (5):
      iio: amplifiers: ada4250: used dev local variable
      iio: amplifiers: ada4250: don't fail on bad chip ID
      iio: amplifiers: ada4250: use devm_regulator_get_enable_read_voltage()
      iio: amplifiers: ada4250: move offset_uv in struct
      iio: amplifiers: ada4250: use dev_err_probe()

 drivers/iio/amplifiers/ada4250.c | 45 ++++++++++++----------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)
---
base-commit: 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
change-id: 20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-93ebb1344295

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


