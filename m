Return-Path: <linux-iio+bounces-4998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F888C391B
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 01:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4477A281555
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7FD58ABF;
	Sun, 12 May 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgdjSx9O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F3253E30;
	Sun, 12 May 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555133; cv=none; b=DkenzUlLexy7qXls7mHQVA6BK/lIW54sSJ+gjkF+ifab4ScrqMEdQnqjbvxNDKvXNYwGXfaS9bY4j1eg3cAGPm+tVAniywoAYkQijyFfgYgBjP92bcmwxleEjh4d3YDQy5cQ6WwDMRUszk0xC/uTru62Wn2ER98+VGLNidgiFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555133; c=relaxed/simple;
	bh=3Tz69QkrUqo1aONgap+B/x+PuSq4v/ij4h9Va5JIDMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5mCiTWjYlcyekgGCkIA1Kc3viRxNptV0FozkQQcSenwj7yE6GovoyoMnN3yPGRwTSRghAkYU1+zGYSmjJmCe5o/mFdtL2noHAQEsaTmwhhm3Z2EOGWwG1LiCRZxHofm/sFRbmZgVTj6WQvji2XTJYq0OANnMlTxwnyHwt7EXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgdjSx9O; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso828735e9.1;
        Sun, 12 May 2024 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715555130; x=1716159930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGTqy+N/1EzIcQlQ9Z56+2LbirXamvloxKpP5KP1LeE=;
        b=hgdjSx9OpU9QFViklK69Hk9khMGkWUrA+UM3qAAuQ9JqebVPnVHESn5OO+clh3RuuN
         I0l87W39w/TtxEibMtC4vBxMX0eMFhFymnX/v/GBFS0s8NLRkOOc/DZvWSnwMBV2Idp8
         9hSspNsCiENrUXfB1WuaMFpEXaK1X00ApLL5MQIT0h8FC2YHv0o/uVbyVMFcN0c/3tgB
         3mPf0uB70v88qvnhLste3Uc80WxiOGqHL2sPZK1FDKY+8givq7OunXr0bwIOtigGNqV7
         MpdiQRtpd3KIL/YQFKEgLc5EUgNmw0EUoM2M2W7NjxDT9xILaat3CGmuYTqz9/mk0kU7
         Ev5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715555130; x=1716159930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGTqy+N/1EzIcQlQ9Z56+2LbirXamvloxKpP5KP1LeE=;
        b=kH4UEIQYC8s1+Cii2u+x+NoD6JJrRuafN+RP5HR1FG4RAQmP2P7DguKXodB8u122oT
         UnhSRdMzxiPtqz9ucysEY2GIIq3b/8d59x060nt5l4ARqUUuZo0mpVx6GwW8GBv4o8vp
         cUp/+tVV3CrVuC2An20t8ajZAmI4eZDVIYKQXEmwx4Rp0mikQt9yvKOwlawxQvSTiNLv
         zdtU0uyBIOOrHhY1kRdEGh8+1eEMV7WjMR8aEQ3VCURfzzZV5rFF0DgllvZ30ha+M1gK
         HmST53EPnW/DlC1yuS9VQPWW4h9kbnEQUzjPvROitXd/ccg3eSbAg/YSCewTQELFDUMl
         +gVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhXGsR+bPX3ExLRw0NlJPlfoKjdqV+inTDxs8CsULJLEKWICKPfRYjvAKaOm8UckarHRFYinVUKm70C8cVt2zpFvdahU5d04+UTbL7H7toiznA0cYlOctOZ/ZjNvICM4UzM1srBWVM
X-Gm-Message-State: AOJu0YwlurPMda1R3J6dNwyqV9QbBKackmfEhiD5562FZ7JghNrY8+GA
	uYDN6xOAId5qDXEb1bnqjXkqKVqvlMFmvOrN3coxQxeavuavL/YR
X-Google-Smtp-Source: AGHT+IFwMyC1WUr6OUe/ZRNmfCzdEeOolRyN+wnGUX+2e5IM2nI5PS62Ra551vRRZRNmwf0K8xnaqQ==
X-Received: by 2002:a05:600c:a41:b0:41d:7d76:ffd4 with SMTP id 5b1f17b1804b1-41feaa2f3e4mr53063235e9.8.1715555129871;
        Sun, 12 May 2024 16:05:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:ce14:864c:436e:5c6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm136720935e9.36.2024.05.12.16.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 16:05:28 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v7 0/5] iio: pressure: bmp280: Add triggered buffer support and
Date: Mon, 13 May 2024 01:05:19 +0200
Message-Id: <20240512230524.53990-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on testing branch of iio.git

IMPORTANT NOTE: There are already upstreamed fixes for this driver [1], [2] and
there is an upcoming one [3]. They will probably conflict with the the last
three commits PATCH [3-5/5]. The solution should be quite trivial with minor
changes in these 3 patches. When it is deemed necessary I can resubmit the
patches or help with resolving the issue:

Changes in v7:

PATCH [1/5]:
	- PATCH [5/9] of previous version
	- Moved comments to correct locations and dropped unnecessary casting.

PATCH [2/5]:
	- Used bmp580_nvmem_{read/write}_impl() functions for the read/write
	  operations and bmp580_nvmem_{read/write}() for applying the power
	  managent functions in order to keep correct order of mutex unlocking
	  and power management with the guard(mutex).

PATCH [4/5]:
	- Used ARRAY_SIZE(bmpxxx_channels) for the .num_channels variable in the
	  bmp280_chip_info struct in order to make code better and more
	  maintainable

PATCH [5/5]:
	- Adjusted changes for the addition of ARRAY_SIZE(bmpxxx_channels) in
	  the previous commit.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=546a4f4b5f4d930ea57f5510e109acf08eca5e87
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ca29ea4e4073b3caba750efe155b1bd4c597ca9
[3]: https://lore.kernel.org/linux-iio/043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com/

Previous versions:

v6: https://lore.kernel.org/linux-iio/20240508165207.145554-1-vassilisamir@gmail.com/
v5: https://lore.kernel.org/linux-iio/20240429190046.24252-1-vassilisamir@gmail.com/
v4: https://lore.kernel.org/linux-iio/20240407172920.264282-1-vassilisamir@gmail.com/
v3: https://lore.kernel.org/linux-iio/20240319002925.2121016-1-vassilisamir@gmail.com/
v2: https://lore.kernel.org/linux-iio/20240313174007.1934983-1-vassilisamir@gmail.com/
v1: https://lore.kernel.org/linux-iio/20240303165300.468011-1-vassilisamir@gmail.com/

Vasileios Amoiridis (5):
  iio: pressure: bmp280: Refactorize reading functions
  iio: pressure: bmp280: Introduce new cleanup routines
  iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and
    refactorize them
  iio: pressure: bmp280: Add triggered buffer support

 drivers/iio/pressure/Kconfig       |    2 +
 drivers/iio/pressure/bmp280-core.c | 1057 ++++++++++++++++++++--------
 drivers/iio/pressure/bmp280-spi.c  |    8 +-
 drivers/iio/pressure/bmp280.h      |   34 +-
 4 files changed, 810 insertions(+), 291 deletions(-)


base-commit: 34d3aa6a60c8e0d053e8df5ff4a2b211951f06a6
-- 
2.25.1


