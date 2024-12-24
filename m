Return-Path: <linux-iio+bounces-13776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD369FBCCE
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 12:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9851627AB
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B41B4123;
	Tue, 24 Dec 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3O4J2lQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B56192B69;
	Tue, 24 Dec 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037998; cv=none; b=NfIVK3/b5NaZ1721wiBkV+cLPmC8ii/b1d8zIRBqqEMbWZoxT9ufcErX92W4ItOyXrdS591o5u++UWjqXV9QxNvqNdM6oTN57QwPh23/J+oQYNzWeDy6R5lJpFlGvIrxRiH6dNwBL/bK1jXRl99ANFAyvySDcIIHF8Mymuv8gYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037998; c=relaxed/simple;
	bh=BRRd43b3a6rTZKtqLUJ4BdSp/L3PUTxVJbR7hoVhKJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FPQW3kgDGc7YO773gBqWLy0t9brbwA6/IF3Tt+iGXlHG4xeVcoGTyS8iuoy8Om3B1KhQ08x/JVaswaLVlxStja7S/XdRsVOB6B4wM0tGz6Gm1D0IFf2vIWkfZ+0g/2xIYR02c08DqL/TOrC4FTACosOiX+QbE4ATy8sz8k47RkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3O4J2lQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361c705434so36966345e9.3;
        Tue, 24 Dec 2024 02:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735037995; x=1735642795; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca6eilJMuvC47QnF0xKpDSojs8LsorClxSQ3Xpx7f8Y=;
        b=i3O4J2lQPiFfH660KYfzxNp4s7YNJnqESnVC2L0AABWyX5RGCdOBMIgeD/yYCdRr3w
         SGylRIMaWfw7J8I9HShNZyBPyIhSBKHPvNq8e+TI/6ah2QTIRvP1nntxuzDxAsDODs0G
         MNkvWl2mld/fd1Rk6dqOvlw9mWzgARuXshZFA+xZl5pJqChpzxh0LjZEfoTenwZKxSzw
         4S2S4xNM5vnmr6ApHOHhkjFDgMj/c/4wLMtR/TCq3cRcV1FnOt41iclLT9Zw4MOaOQJX
         Pf0YvXjJDUNRRvIuMtDz3S7ykd+ekS+DhExZFQ15kBZdI8KsaBjb5WgK9WYEA5feFbiO
         SSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037995; x=1735642795;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca6eilJMuvC47QnF0xKpDSojs8LsorClxSQ3Xpx7f8Y=;
        b=sQTM26JYnqYrqHRsYO6hNso1er0vgnoZPrnrnDHyJCvIfXkq5EL+2u/SpbYmF61U1A
         xI2vCqf8WgkTpaVfhrTf4+uUNkzqVs1aDH6VpFT/5kKydpd4w7iAKiV36cT1ZNO0oZIy
         LoisC+E4MQVQ/GwXRqBMFrnO/NEznmbH4vULEgkmJQGmsdIxZyx7Q923lhAfdOQdP+Zf
         C60FmrCLy/6TQoOTYOfxWnYPHH7LBtJZl4lb2b0xCYLocKuBERjIiuVCPw7LhFbfZ3bK
         qZOQL041Tdiz/CvkUu86+xb2NmO5mAzkLKK9CCNqIlkRUNqKAFvJL1fag5GeyQvoSAP2
         k3WA==
X-Forwarded-Encrypted: i=1; AJvYcCXa/qPq/k+kffjwRdM3DmPRxYWTXpF6soGD39n80O3rTmoWDALEsNNp1DJVQclKtNym71/sdZZqg9+lilc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZscrO6KZHtPpNTKg3hQmc+iYaCKkjid+GLXj95PFZOaiq9cL/
	MmK9nga/09UaVmdrMHbClskz47fpeurXIFcbLYMtLGU2tWEI0NJv
X-Gm-Gg: ASbGncs3IiJ4GvUofRbS44Ym8VIah45Hcr1WCJVA5dq46Ow9McwTTsGb8LPTwmIutNO
	MSRLvNw6G6jFJZr0VWQdR0RagX+TVpvxZKJQdFqX4VRHllB5rlk3r8vnJkwqOcQIlKBL+CVn2y/
	1qajS3CbIprz7yeKPqijx87MNzS6QFOuJI92eKGwOkWvyVoqiG5YsmrrhjiEbc2Q4hTPXOxwF60
	q9nKS2Y3NEeU1dMJhHeBmIOiF6wfuHrPp2r5gllxRiqgBXkNkzC3jNOkQuDcQ1dbwwHH9opsbEB
	zqze9piwUXmrDvXUBLUtuYJR+YRkH9ZEyMoD5PLafTTwETamGButLjBEPN/i8A3XFufKubSdVWr
	o1A==
X-Google-Smtp-Source: AGHT+IEt71P0XPCR6PscFrAuc2KHYhXt+rAvqbOCNdONdo9Qn1sYvBwZTqEprkIyJ09i/eMP4tG6hQ==
X-Received: by 2002:a5d:64e5:0:b0:385:fb56:fb73 with SMTP id ffacd0b85a97d-38a221f9bfcmr14797321f8f.15.1735037994384;
        Tue, 24 Dec 2024 02:59:54 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a49-0b63-5213-952a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a49:b63:5213:952a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb85sm13699427f8f.103.2024.12.24.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:59:53 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] iio: light: fix scale in veml3235 and add helpers
 to iio-gts
Date: Tue, 24 Dec 2024 11:58:59 +0100
Message-Id: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPOTamcC/13MywrCMBCF4VcpszaSTJpqXfkeUiRJp+1AL5JIU
 Erf3VhcufwPnG+FSIEpwqVYIVDiyMucAw8F+MHOPQlucwNKLBUqIxJNo0Zt7tHbkUSFLdVnf3K
 ms5BPj0Adv3bw1uQeOD6X8N79pL7rj0L5TyUlpHCldqqWzrnKXvvJ8nj0ywTNtm0fT2AZfqwAA
 AA=
X-Change-ID: 20241215-veml3235_scale-62de98c7b5fa
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735037993; l=2462;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BRRd43b3a6rTZKtqLUJ4BdSp/L3PUTxVJbR7hoVhKJQ=;
 b=qPuyhNv4ai5OK1i0pZrNvasyWpeNkcfosFh3Qths4d3rvqUpiyBwtjOo2JYnhp2DUWqEDBV5C
 iKdSs8OTylWC82CTnYEWVSJBbiwC1FnJvyPRpZ6ST4df52OMG2Lcbru
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
Javier Carrasco (4):
      iio: gts-helper: add helpers to ease searches of gain_sel and new_gain
      iio: light: veml3235: fix code style
      iio: light: veml3235: extend regmap to add cache
      iio: veml3235: fix scale to conform to ABI

 drivers/iio/industrialio-gts-helper.c |  76 ++++++++++
 drivers/iio/light/Kconfig             |   1 +
 drivers/iio/light/veml3235.c          | 274 ++++++++++++++++++++--------------
 include/linux/iio/iio-gts-helper.h    |   5 +
 4 files changed, 245 insertions(+), 111 deletions(-)
---
base-commit: e25c8d66f6786300b680866c0e0139981273feba
change-id: 20241215-veml3235_scale-62de98c7b5fa

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


