Return-Path: <linux-iio+bounces-9589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4979792DF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8681C21203
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2EE1D1720;
	Sat, 14 Sep 2024 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqONfvRY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157B208DA;
	Sat, 14 Sep 2024 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337614; cv=none; b=B+OOEoz/wFnMGCenAY8yduGLKYDcwsh3Q0hsV+pvDE1ttmMo5EJe7XjWWxwvlHWttM00vfV84+HAC5xJTmiI+E06vB0bxAV4iHOunaCLe9ARd/Osw1Zv2XdgcRxoZjFyujlT/drcWybFjm0vp0QG77iJDSPxEdu5ThHu4cHAsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337614; c=relaxed/simple;
	bh=hLSTtn3TltUvhN+3lkPHE++j5T7D1u0bEq1gcnpE6Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7+BNmTp87TeHoEhVYjA0Py0dMY8wdLkjmHtdvhCRryY2/RMXvrzn6k3tyKCO3YvIZ7CZXN2Sir6bjkIS2NdRalx3vkObaoOZniPVliJfuqDPcxlR72WMaVYGpfs0un2+bqTBmputuZYv9hw4DSujB9TBPnRhk0VzR14m4/Dx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqONfvRY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso2678588a91.3;
        Sat, 14 Sep 2024 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726337611; x=1726942411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPDmb6B5DNfWPEoNXlsjeYGvnQhjVErjW0XtOOeaGZI=;
        b=FqONfvRYbDyglmnHV4vvHMsj53zoIertJPH0+tGsrOSNT2EAww2fhRftrRoSh4T9S7
         SCQXk+sutANcWrN4qtrj4pXuhK3YBKYfYQneITEr3n+VJluhdQztRjt/3tQmUPBvOJed
         RIiYiLiCwtKy22xJXhbC2tziT7ZjrWb+ZTi6eZKU5XkR/gsnu9Si8muBLsOgqddBwzEh
         o7o8x8QOaqwSvyTOAXSQ3V3qTmu6ledOs+G9YLgkNeAopDRppwZd6p8h4HPn90psD/fp
         9Yh+amMLqDzfq/D0PSh7YBEvaK6gYxl6ye3g+dMCX1dqJRQ52XYK5rLoBkJsPjGlLMtO
         MU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726337611; x=1726942411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPDmb6B5DNfWPEoNXlsjeYGvnQhjVErjW0XtOOeaGZI=;
        b=N5plODEzCC8wq3ZTR182B21gp9XTsJSjeofbCwtD/UAe2mliPNJa5Bo31uOEZOjFEG
         OaSdiH+PkXfpmbGkwuZ/cB1pW2ng0Q4WPSw6Rfj1AlIacqr1ZpP5wdcJC9pSidk5vL1O
         WyP1jZJzwnVWfPy+u268Pi/7FWehFRWVvaCyr9n4Kq65o9Fg0hkDsPQAT//v7vE/7pxX
         Xf9lCo69yKVNJNRT+DcG3srJyZZwgEGg9abM5FPUmhVHuYa9dMJJZD4xlc3m/w2MCHS1
         0AEjzkU86O85u5rTMEBxxNn7Gb5gy6t0egxacl6sbgF6eZMsMBDE86Ru+cEvlvSvBlNU
         oPtg==
X-Forwarded-Encrypted: i=1; AJvYcCUE9D9bcv9EYTj7Cx113Xu4YDIq2cZmeePQAir77vXcrnC3hx8tWPsiUpse6E9rZKcbyN/8OnkLJTZp700=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6P0Fy77Si8xT02HL5U2BHl91iWQEY9Y7arYnza+PzB6mZ8xI
	JQUHoSPSkTXHTbkyoWMdXolUnBhbLQIlBC1EWRM2THWodF1xLcIZO+W2CsTmjSc=
X-Google-Smtp-Source: AGHT+IFeKqFiYrfaiXZLgLAIKw3stIstKF+2bY2CxP8+seWGYFnRh0+1QzRYl1QFRw0FU8yyettwhQ==
X-Received: by 2002:a17:90b:1c07:b0:2d8:8c95:ebb6 with SMTP id 98e67ed59e1d1-2db9fff019bmr13558554a91.19.1726337611326;
        Sat, 14 Sep 2024 11:13:31 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd26f2csm1830870a91.31.2024.09.14.11.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:13:30 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 0/4] Threshold event and Sampling freq support for LTR390
Date: Sat, 14 Sep 2024 23:42:42 +0530
Message-ID: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for configuring the Sampling frequency of
the sensor. The available values for the sampling freqeuncy are provided
by the `read_avail` callback and they are in miliHertz.

Then the second patch adds support for suspending and resuming
the sensor by providing the necessary callbacks. And registering
the ops with the driver.

The third patch in the series adds support for Threshold events and interrupts.
Exposed rising and falling threshold events for both the channels. The events
can be configured via the write_event_config callback. The desired rising or falling
threshold value can be written to from userspace.

The fourth patch adds support for threshold interrupt persistance.
It triggers when the UVS/ALS data is out of thresholds for a specific number
of consecutive measurements.
Exposed the IIO_EV_INFO_PERIOD attribute by which userspace can set the persistance
value in miliseconds. The persistance period should be greater than or equal
to the sampling period.

Changes in v3:
- Replace hardcoded mask values with GENMASK()
- Minor refactoring
- Code formatting changes

Changes in v2:
- Added "linux/irq.h" include to fix `-Wimplicit-function-declaration`.
- The above error was pointed during testing by kernel-test-robot

Thanks,
Abhash


Abhash Jha (4):
  iio: light: ltr390: Added configurable sampling frequency support
  iio: light: ltr390: Suspend and Resume support
  iio: light: ltr390: Interrupts and threshold event support
  iio: light: ltr390: Add interrupt persistance support

 drivers/iio/light/ltr390.c | 361 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 357 insertions(+), 4 deletions(-)

-- 
2.43.0


