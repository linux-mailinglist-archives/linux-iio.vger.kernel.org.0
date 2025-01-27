Return-Path: <linux-iio+bounces-14639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3FA1DCBB
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 20:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A3165FB2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954718FDDA;
	Mon, 27 Jan 2025 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE22D9lI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F96C8C7;
	Mon, 27 Jan 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006234; cv=none; b=ChJfWJR05J2bWCQrOgtBdteM0z2i0Or60/cZJ8SCxtZMjOlrnHbjBVmAw3rDnhr/ZSLUo4YmjOS0hzcts2EhqZ9vt9URtBZz+SjnIdlaeTjNK8jY8a33wiMw3yQOxhPuVxXN23mHc7vuvGzvl9znxRrR93s5bFtqxe26Fe+CVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006234; c=relaxed/simple;
	bh=uVLBIy2xy9ySLeyH2ezdFFsaf0CMBFPMhnDdNRXqNNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EU5FP8iTY6rs9jVm607j49rybKAnAPF2zakxUtqdk5d0ARVTSJAAZ+cPrsDpzSxa4Y+6T19NpZkihvlxu2h9mzU/q3fku/WRLYv/3XCEeLnVAD4wF5eTP0bi78QCXf4dpL9+KCrYw+/zGpCyipaFNfJrjJRlQISGIHz6OrYEBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE22D9lI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso30977425e9.1;
        Mon, 27 Jan 2025 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006231; x=1738611031; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyVs8vspC0V12PbB+ardM7dGK8sLSzB/SwH89RhAdPQ=;
        b=RE22D9lIT4w/C+ZX7RFtB/CiPOyeOFlc4XPRZCYaa3SNDcNFCeYG/sOh1Qo0HePMRR
         BLrxb/EauoM2ybl1HKSrIUAN4fF05X0UX/dJ49yshKljCDmsTMPlxKoghRD0u0kwTcxn
         iP9wA+jcLUdKPKJ9pdsyQkKZEpNGgKCoabrHiiahY/Zk5RlAK7wQJfYuEmNMaRjYja2n
         nyljQqP0VUtjjbHHjPnLLYoxQ9d+ksSWuMrjJmSobhRO5gJw8ddW+OIS3iWAR3VB8FZg
         kqKE3lAkOqSc+gWv6T/pLP8X2HUGqdyNzfowlH5oSyt7Ky/3GCoKvYZtd6ycJ1cnDTxT
         o14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006231; x=1738611031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyVs8vspC0V12PbB+ardM7dGK8sLSzB/SwH89RhAdPQ=;
        b=JZlCGXbbJLnElVUUXcEue4Ds7Wh8bfH+6caKyJiQUPTsvV+dm60GSp2iTsyDFpAXDA
         yVFI35Pw/niSX1JuNFlHg+2MiMEE7sJqwxm18JVkRw5R3gcPYU6+bf6JmlBj1Hi81NOI
         BP72aediqqKW6844CEcbE/TDQyMihZIGiOe4Cu4bfule8LjH4aKY0GRDaUizgs6XOXjt
         5tbtaDSTwH4k1wCpYNgyL950ckYOgUiXbmGKDBE8dGPs/KFcireYRR2Cy9GKmuPkpJ1j
         8tgPVt/efvQgqw7Own2dwv0ysy+Y1qcQh2uT6L5KKRH+Nng/0fb/WEhMpN3I6qZVOBQt
         Ad0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdSeA0OT4hCWHHcEGENopTFaspUnJgyhY9kybv+74zUO0e7rp7hKkAQV+uTDFR7KtkIrQWD7z8wHXA5ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnqW51zVafayk670smQeysq7jxYj4KTRBrkkjl+iajIaBXvsf
	DI+fdKdKFXwyai3vkPlwgUXa282obbYUjK5aQCpnPOV2m6XIwfJq
X-Gm-Gg: ASbGncu3/W2BdQxB2I2kWDVTxxq+1zE13H3Ix3vk6Y83AMSk2QwmLNqQT0IDwFhiAcQ
	htzjEpsZ1dr6nIg3jx8+WpiKoNJDVNHLKAw5dqss3gX3xzraoYTRiFeQ2Gvdvnch0yxvDqECRCW
	6NVABmSdc4eJ2r9d1sFI6kTmNg6+GBhpb4luv1N+Mui6i2UjG4sonMaUStLI/4Jgs7jzRYpceMX
	p6S849mHfpQERCbhqm0oOBq64QmniO9Yp83X1JGKxuCUaRSf17dWU/7MCpFVXnKRLc8sNjf4OGe
	NnhL4FGnJORPqC6gnyyIsCvkDYvN5LzEjguTvy+09KyEMEfi0DSHZT5B8Ae/RWPKuYLtthPw2A2
	xm1ry0PVNeyLU9kGNdT5C9FO4mA==
X-Google-Smtp-Source: AGHT+IEFayL7bSviH9DPwnlCZthS5FMxMBsu36KQRUqyxhvcyYyjFFVuOsw9frKklBxltjKV7ifEaA==
X-Received: by 2002:a05:600c:1797:b0:436:fdac:26eb with SMTP id 5b1f17b1804b1-438d59669d4mr4740295e9.7.1738006230595;
        Mon, 27 Jan 2025 11:30:30 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b1d9-eb5a-e5fd-0636.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b1d9:eb5a:e5fd:636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa463sm142986915e9.8.2025.01.27.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:30:30 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/2] iio: light: fix scale in veml6030
Date: Mon, 27 Jan 2025 20:30:21 +0100
Message-Id: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3el2cC/2XMyw6CMBCF4VchXVszM8UWXfkexkUtAzThYlrTa
 AjvbmFFdHlO8n+ziBw8R3EpZhE4+einMQ91KITr7Niy9HXegoBKJIUy8dBrUCCjsz3LCktqVGX
 YsBY5egZu/HsDb/e8Ox9fU/hsfsL1XakTIJhfKqEEiVQhK1sDkru2g/X90U2DWKlEuxzPfznlX
 D8aV4Imqwzu82VZvpWpUDDrAAAA
X-Change-ID: 20241231-veml6030-scale-8142f387e7e6
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738006229; l=2858;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=uVLBIy2xy9ySLeyH2ezdFFsaf0CMBFPMhnDdNRXqNNA=;
 b=imSF9LJSCdaRywlCpyZOL+mFJBLa++9mS4R/QTaFBr1Dv7CIwzSDQCQrsv97d6mamwpXpSkox
 Ac4QPkfSoYXBV3pNr3ijv7dNUIJTP183a9cWE12+5v0gfcZ5WNzl9Cf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series follows a similar approach as recently used for the veml3235
by using iio-gts to manage the scale as stated in the ABI. In its
current form, the driver exposes the hardware gain instead of the
multiplier for the raw value to obtain a value in lux.

Although this driver and the veml3235 have many similarities, there are
two main differences in this series compared to the one used to fix the
other driver:

- The veml6030 has fractional gains, which are not supported by the
  iio-gts helpers. My first attempt was adding support for them, but
  that made the whole iio-gts implementation more complex, cumbersome,
  and the risk of affecting existing clients was not negligible.
  Instead, a x8 factor has been used for the hardware gain to present
  the minimum value (x0.125) as x1, keeping linearity. The scales
  iio-gts generates are therefore right without any extra conversion,
  and they match the values provided in the different datasheets.

- This driver included a processed value for the ambient light, maybe
  because the scale did not follow the ABI and the conversion was not
  direct. To avoid breaking userspace, the functionality has been kept,
  but of course using the fixed scales. In order to ease the
  calculations, iio_gts_get_total_gain() has been exported to avoid
  working directly with the scale in NANO, that would require 64-bit
  operations.

This issue has been present since the original implementation, and it
affects all devices it supports.

This series has been tested with a veml7700 (same gains as veml6030) and
a veml6035 with positive results.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Rebase onto iio/testing and drop [1/4], [2/4] (applied).
- iio-gts: document exported function.
- Link to v2: https://lore.kernel.org/r/20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com

Changes in v2:
- Rename SEL_GAIN to indicate they are in MILLI.
- Split first patch (regfields and chaching).
- Use regfield structs in chip struct instead of function pointer.
- Use total gain to derive scale, avoiding 64-bit divisions.
- Link to v1: https://lore.kernel.org/r/20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com

---
Javier Carrasco (2):
      iio: gts-helper: export iio_gts_get_total_gain()
      iio: light: veml6030: fix scale to conform to ABI

 drivers/iio/industrialio-gts-helper.c |  11 +-
 drivers/iio/light/Kconfig             |   1 +
 drivers/iio/light/veml6030.c          | 528 ++++++++++++++--------------------
 include/linux/iio/iio-gts-helper.h    |   1 +
 4 files changed, 229 insertions(+), 312 deletions(-)
---
base-commit: ed2010907caa1c838d2e565d67bbc08fe023663e
change-id: 20241231-veml6030-scale-8142f387e7e6

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


