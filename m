Return-Path: <linux-iio+bounces-12952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA29E081B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 17:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC75BA7BBC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D348205AD0;
	Mon,  2 Dec 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWmLskC+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FD20E316;
	Mon,  2 Dec 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152303; cv=none; b=dQlU9sSICJuZv7ev3sdGguFI9tb2DQiX5zhUUT3Rc+Mj0EMTUH7iosaNOfE9Ay+mPXus9MVRktffa+1jd0PNkDX1CA0TfBbTeNp92hm6NOU1l5wOQAPlIAU4ICRFa66J5/jNrc3DCwr/m3TmHI6WdxVPhfwsV5OXW/5Y3mZJv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152303; c=relaxed/simple;
	bh=YxMgzNRRz3wVdrUzCGMfJ+jt/0auNaIGlNq72sywoXU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=koHfe+XbRLkqjxN8rgoyL7zkEV+hgbiUStg2Y1Wkl3ArF1R3X6o6bukFWwMFwABXTCMafKb1eClkvOuzOgdr8LLJ1Ny0PHNNOPBNiBo3HJEQbUCUOmjDYt8PfoCt528hEKK7BC6muyYO+32rLFYQeB5Kx1RYf/Mnx2khOQi20YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWmLskC+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43494a20379so35644775e9.0;
        Mon, 02 Dec 2024 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152299; x=1733757099; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nV4l2lLVkQn7AKJu1TpC/+VW5wMnOQmxpRS243GTK9g=;
        b=iWmLskC+oQl8GahOPvKc6e4v6AvLTJCQuRUmbBoBqrp/4/uR1uwfXy2aKSCgWz52A+
         65m8fBO9Bw1BBfDJ/5lcOJxy9pLSq2ml2rrvwSyAzKkzJud3NNccYFfBl0wfP0T0cL4S
         SbyeNvx7EGSRfkFm8coEEKrYH0b6bO2joWSMy0WrtbNfyD4lkEBSkNFLyal0IL2YeNWT
         gn8Pi3boZDV8ZdMNlKvVqaBTd2hc+KN+uinx88TMAg1lYePsWS34jyV0h4gvlXXal9Xp
         /BE56piiBkvRZAMK2iBKCHBVhE9bWtrSVfbj9h8q9ubQyoJ0n9Jpm6gYpZly1oMjaQtR
         QZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152299; x=1733757099;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nV4l2lLVkQn7AKJu1TpC/+VW5wMnOQmxpRS243GTK9g=;
        b=pkOCI5cgjj0lAxJQBVYKTUnVO580QOuDnbM7/N35q2652nldFWYShz1kkUn8rDFqCA
         D1PfmhVgkoRGfpCG0haT7HfDUh9lrTOyFGpvR217Wwkp7fJp0FefLapfaSZ8D3gToW99
         7cq4C1wyxYeZIVtc+JB5kVw2tIbAFEGSocSg9nEqdjXJ9bLSZ+xd1usnf/J6QOVazkXz
         Qdl6zyJoGNq0o6T2kDxrIdD49kJGdpcIRoqXY3PJDWXgdkV16qBb+0CuX/3dFCbhZcF4
         2mg+IBq7lvJNRYZg7XCkH9ekognBGxjdtycZ1WKGwZSS1cK93twoBc5QSKa5cFaOBlO5
         DgpA==
X-Forwarded-Encrypted: i=1; AJvYcCXzAxS1dZWzRVk1zO19/Vjp/mc3n2iDX0mjGxCr70wfNqSTegG7/v1gQg9Fm+TIW8DSOBp5d21+rVWX8eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9W9CT+JL+sV5ztSwWu4Dj5lK9KVgQ6tGYdo/pSfsxYc8pNx4S
	iVJFI4/9x5ySbqUayOYKEDcH6n3Avcebmrk5THjB5ZfJLtl4+hut
X-Gm-Gg: ASbGncu3QnJ7xvpBWJwSOGSSmZXTLVNzOnXmmvoh06XjkHHjeOg3RW+6kFu1TK028Dv
	redO0Tp/FRi4PatKWW0xRvF1ghKmz/fXOiMKduEoXEbBHHyvtQkKyPguAJtqozCm77YQp7vMzYg
	JlkEJR1xUDW7/Vno7DoXaFMleec13ZS0ps85t8nCoHqdUvq5dSnUG0dWOYp0pXbpxMDvPYhMGhX
	RVMGeX8HSgvaxxMXOkgl6BXGUymL/rQZPj5fgTcANYEAU5sKUGGj/MavJE9CjOEJTRimGFn6c9p
	anrPs7P9WCAAA796vaxM
X-Google-Smtp-Source: AGHT+IFqsTbKUWf24PW7pFizyUZDs2575ldIjokvTIMOJTyNmWAWMxhDYbFZ+pC936i08xukQkI3wQ==
X-Received: by 2002:a05:600c:5022:b0:434:a6af:d322 with SMTP id 5b1f17b1804b1-434a9e10ff0mr189046995e9.33.1733152298396;
        Mon, 02 Dec 2024 07:11:38 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d264dsm186082535e9.33.2024.12.02.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:11:37 -0800 (PST)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH 0/2] iio: consumers: ensure read buffers for labels and
 ext_info are page aligned
Date: Mon, 02 Dec 2024 16:11:06 +0100
Message-Id: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAArOTWcC/x3MQQqAIBBA0avIrBtIKYKuEi1sGmvINBQiCO+et
 HyL/1/InIQzjOqFxLdkiaFCNwpot2FjlLUaTGs6rc2AIhGP03ofCa2XLaClYXHkuGdqoXZXYif
 P/5zmUj5ilUSlYwAAAA==
X-Change-ID: 20241127-iio-kmalloc-align-ac7bfcfe5ec0
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

This patch series is a follow up of [1], where I described an issue
related to the fact that devm_k*alloc() functions do not provide
alignment to the requested power of two size, leading to potential
errors when used together with sysfs_emit* helpers which expect
page-aligned buffers.

From that discussion, it became clear that this issue currently only
affects iio consumer drivers, as they can directly access providers
attribute formatted using sysfs_emit* helpers. For instance, the iio-mux
driver allocates a buffer with devm_kzalloc(PAGE_SIZE) to read provider
ext_info attributes, which could be handled via sysfs_emit* helpers.
This leads to an error in the provider ext_info read callback since the
allocated buffer is not page-aligned.

Summary:
- Patch 1: harden the consumers APIs to ensure read buffers are page
  aligned for attributes which could be formatted with sysfs_emit*
  helpers by the providers. Currently labels and ext_info attributes.

- Patch 2: fix iio-mux consumer by switching from devm_kzalloc to
  kzalloc for the ext_info buffer.

Tested with the iio-mux consumer driver alongside the pac1921 driver,
which provides an ext_info attribute (the shunt resistor in this case).
After applying patch-1, the error was detected during the iio-mux probe
rather than in the pac1921 ext_info read callback. After applying
patch-2, the error condition no longer occurred. Additionally, the extra
check in iio_read_channel_label() was tested with the iio_hwmon consumer
driver temporarily modified to allocate the buffer for retrieving
provider labels using devm_kzalloc(PAGE_SIZE) instead of
devm_get_free_pages(). The error was correctly detected during the
iio_hwmon probe when attempting to retrieve pac1921 channel labels.

[1]: https://lore.kernel.org/all/c486a1cf98a8b9ad093270543e8d2007@gmail.com

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
Matteo Martelli (2):
      iio: consumers: ensure read buffers for labels and ext_info are page aligned
      iio: iio-mux: kzalloc instead of devm_kzalloc to ensure page alignment

 drivers/iio/inkern.c              | 11 +++++
 drivers/iio/multiplexer/iio-mux.c | 84 +++++++++++++++++++++------------------
 include/linux/iio/consumer.h      |  4 +-
 3 files changed, 59 insertions(+), 40 deletions(-)
---
base-commit: 20fd1383cd616d61b2a79967da1221dc6cfb8430
change-id: 20241127-iio-kmalloc-align-ac7bfcfe5ec0

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


