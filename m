Return-Path: <linux-iio+bounces-4887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51B8C0202
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395441F21EA4
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9761652;
	Wed,  8 May 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FylmqufR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290B622;
	Wed,  8 May 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186075; cv=none; b=Udmo4KFSmYYpE0ATgcl8eHCUrUyKJ0nl7QOfnwbkRwjdSjcA73XuwxEtOfGsF0LhE/2BTtNRpamJ8ZQz7vNixF2BBxXzfeyMlhhKZBq1DEdlwq2XSlSC3WqZhvp8sFAGg84BS+gORfvhKyz6XJBIhYCQEpLFhqm8/1nlxrK5RnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186075; c=relaxed/simple;
	bh=D5lI9tZL1V+2jG505+yREVMB16rC/g6xFy9eD+Dl0UI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UPk9H5/U4zqhI04eIbUQm/TUH3bxzadVxDjWZiPXLB/+V6hfAGp2LbVspu1cpTj8x6KSpml5hA6uxdYzK9uPfoa1Hs2MSSIFRsE1Rl3YiBLZBs7JrMZsKX0SAeTOklYtgamVAEP5V2EnuwaIikge2nZL2A14649/iXlkvjaTeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FylmqufR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59ad344f7dso943959466b.0;
        Wed, 08 May 2024 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186072; x=1715790872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EFyb4OwW6O36XIPrRKUTzT1X2HopZig+7SPq2MNRbdE=;
        b=FylmqufRDahCgZrGeRAQ9APYCcZPX7y3fzGQ0nWw02Nx5vkAN8V04FEkhOFNNLzzzJ
         0zRYfTQsbZlf3cqbB5z6vzi1jRxaTeSfPiNk3EFiBCm3TL2TPODHFV3IXn3C9eveg/FQ
         AVIpxPgPP8h+Q57aUBxMpu+qow97eVkS8YPhZOjKB89MKh2oyGj0Px0HrfehduiQhleA
         7gDWPj4LdLzK0P+otRSjbr1pXMx3pVVgVCV0qz5PIF8++AQhhhzfgVZHIjFqLGraPeZr
         YZOnbnqQaT6GnI4IwdhuxpJ1jR35sfpCiJlSlKEXxAeOTS8Bfd1uRk7/rgddWNXeXehb
         IOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186072; x=1715790872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFyb4OwW6O36XIPrRKUTzT1X2HopZig+7SPq2MNRbdE=;
        b=UOWwMHmc8gURRNjiW3ism9V0O9qoSprtWT6eYzsx03p91Z0Hx7fOD1rtqCO4lWmCOx
         IhQKuzbh69kWl6QJnfeYMK+4wDE7BklgMNmrLGnPrF1i7QDQY9irO9kBQmvtIP1UIU8V
         EW3vSWqe31btNVCR5AiztH/5ENjgAB84Hzcg3ksB/WN65tOrRZ5vff/cprYLU+k76ML/
         9ycpHlbJMHf9y3HuFcRSANB7RFfPT6tWeLo2gQC8yyCML00depgi1DRsEsCGhQgE6piv
         0t/dTYHNbF9omAfyXWfqFpWoowBnWjuNT1wndOE67Lpi+MguoAiUGt5D/s/b0iZq6Pln
         8Deg==
X-Forwarded-Encrypted: i=1; AJvYcCXOc1oap1j2y89ChwH5b1XjpqQ/q7ICa2ml5rcApnC8LU6OLp5C7irHM6g5CZ6DI7glNtDZ1PndJr9k+yyMusRFPTbvCTvN2xz7YOOO8TSLX+3JoS8GLHzMH09lcL+wFSn08MZQgE5c
X-Gm-Message-State: AOJu0Yx74XMVetiX2FNCLHHNH7gs9dJeJZ5mR0RsCO39/gMT7nlRXsl/
	YgoNY+vtkMNQmLP/xHEDAKPy5jOW7WYjurVvguq0YEAf0ectPLFf
X-Google-Smtp-Source: AGHT+IFYqeqsepYfgiw6k03M+NbCt1gTnq3ajyaZT03GdKNGce/5iAQhZrlsI5IGa62US7Xrv8gPAw==
X-Received: by 2002:a17:906:260a:b0:a59:f3f9:d24c with SMTP id a640c23a62f3a-a59fb9e6872mr209208766b.76.1715186072215;
        Wed, 08 May 2024 09:34:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:31 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
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
Subject: [PATCH 0/9] iio: pressure: bmp280: Add triggered buffer support and
Date: Wed,  8 May 2024 18:34:16 +0200
Message-Id: <20240508163425.143831-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on upstream master with the previous patches of this series applied
as well.

IMPORTANT NOTE: There is a fix queued up for this driver here [1]. It is going
to conflict with PATCH [7-9/9]. The previous patches should be fine. The
solution should be quite trivial with minor changes in all 3 PATCH [7-9/9].
When it is deemed necessary I can resubmit the patches or help with resolving
the issue.

Changes in v6:

PATCH [1-3/9]: new:
	- split of PATCH [5/10] of v5 according to proposal here [2].

PATCH [4/9]: new:
	- split of PATCH [6/10] of v5 according to proposal here [3].

PATCH [6/9]:
	- Removed mutex_lock() and added guard(mutex) to
	  bmp580_nvmem_{read/write}() functions as well.

PATCH [9/9]:
	- In the buffer handlers, add 'goto out;' instead of just returning the
	  error because iio_trigger_notify_done() wouldn't be called in case of
	  error.

[1]: https://lore.kernel.org/linux-iio/043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com/
[2]: https://lore.kernel.org/linux-iio/20240505200818.1e70c664@jic23-huawei/
[3]: https://lore.kernel.org/linux-iio/20240505202106.1c780044@jic23-huawei/

Vasileios Amoiridis (9):
  iio: pressure: bmp280: Remove dead error checks
  iio: pressure: bmp280: Remove, add and update error messages
  iio: pressure: bmp280: Make error checks consistent
  iio: pressure: bmp280: Use unsigned data types for raw sensor data
  iio: pressure: bmp280: Refactorize reading functions
  iio: pressure: bmp280: Introduce new cleanup routines
  iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and
    refactorize them
  iio: pressure: bmp280: Add triggered buffer support

 drivers/iio/pressure/Kconfig       |    2 +
 drivers/iio/pressure/bmp280-core.c | 1130 ++++++++++++++++++++--------
 drivers/iio/pressure/bmp280-spi.c  |    8 +-
 drivers/iio/pressure/bmp280.h      |   34 +-
 4 files changed, 844 insertions(+), 330 deletions(-)


base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 
2.25.1


