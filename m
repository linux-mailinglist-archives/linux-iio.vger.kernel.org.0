Return-Path: <linux-iio+bounces-8076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7999426FA
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 08:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E35C1C2109A
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EC59B71;
	Wed, 31 Jul 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXyq4HRA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780D16C695;
	Wed, 31 Jul 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407843; cv=none; b=OcBmUDWJFT69gP/dqU/uUst2EbyqJXO7aOXoNA11VNwGPiOnQDhgpGChfrLWGq87F5n88fFOIfBKo/J9NFQLx76+YNhtKYNZKKulJIzaUIQX94w3uQrUbA6Wn40rP3skHq7T+ZZIEO7DXuJOoFS6GUojHpA5lQZHdvkwn2IG8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407843; c=relaxed/simple;
	bh=PMGZUubJJ8umfwOXQuBkzTp61GgTj6250h1dDc81FvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hnm+FuihvKMqk4jJT/1dy+qgt5RbI/VpA29a2o/J3SlL8JZpJa5kRK1AcTQudN/h+jEnqpd5ongfyOVO2Qrni0oUoJ7InSN6inq8AakZKX/lADkTq/+gScMMo/td3vEDIqxCxBzEbPrSmwi2TISErCCZpIhXwPNKOhRwDfR55YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXyq4HRA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd65aaac27so4585825ad.1;
        Tue, 30 Jul 2024 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722407840; x=1723012640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/gj7A7Iixy8zZuYKD1Pp/1Lqkird0pzzQjp0dasAE4=;
        b=nXyq4HRAilqq9sHnEgjkolG7Ts04rpzMq1tfSM2egzaGeygDlVvfXyZUnQdYeunH6m
         eRqQZ0sG69llZXY5Z53u9veBRNw5lAV6TbbfV2ARcU7B/riq01XTcfIGGtc1bmaI+Hm9
         bSraHy0I+QJwR30qMNUtG+0kj/g7A1fSbBAmQRjZblfZPLj8ckhPQQbz2sOMPUt5r9Si
         EzDvuHl+KDMI0lAga77z6c3G9H1CDLQtorUVsrYj94KpFCuT8z9u9xY7sYUM+fnonrVk
         vgBeCt1J5yvhxpbIEptZvgG6lKRI8R2oMr1WOZsAjByA04GvcqXH7nezFPcBk/7FPJsD
         4CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722407840; x=1723012640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/gj7A7Iixy8zZuYKD1Pp/1Lqkird0pzzQjp0dasAE4=;
        b=kQFIGWd37ovuK9uJTm4yqaNlKUjODsORsQDOz2HjXBHw9MJ5Ec8rVxrfgG/LbT8H4e
         eT4FQM/rF2lihV56RmgTESte8UUUga5iQnc4WWkc7D9MffQ5qRcGTB8agZMNRd123eek
         OgqhL9lmEgyOBL4ftDYxaObpxTzWEglfG/hdhrZNosipZr5FNLuRVEYPDfzVe1u3slxy
         EVSPuOjTSiQ8DBo7p1nqiKZGoyvA2HDCSqlg0J3cCwYflHlBAmWJ66dTcvpT0Ks40itS
         qVV6CgsOnSu99KH3amdEulpItH7rN6xW+8jrkJKPit20b470kCmpW0KXQjm790xWWA6U
         LrLA==
X-Forwarded-Encrypted: i=1; AJvYcCVVcOmpiB7VVduyyF0MXHBcKPUWwIfD+E5va6SwYahUO+g9a4IgGSvQazbChgpJIRvt7/+1BTbJqoNn0gtJO/VRgBfD2TuxBiJTILhT
X-Gm-Message-State: AOJu0YysK4QGCPgK/ocvq1fyZOykBZ7jcZKmVqwbY+fsJGP/NUJnKVnW
	tBRLXhpiT1TsDgJNyxAvx0FtfOQUjOtVZ5nqMUNL+YMTDwbi+k50TZ8AD9o+Ra6hPg==
X-Google-Smtp-Source: AGHT+IF8MmY2AIZk8l3U+q3JHFwmPtvte8cubN5gUQAyvu8Ez3e4FUippvIASDtwo9VTaguDAPIDEQ==
X-Received: by 2002:a17:902:e743:b0:1f7:3a70:9e71 with SMTP id d9443c01a7336-1ff37be4cd4mr60687485ad.13.1722407839547;
        Tue, 30 Jul 2024 23:37:19 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7ee4ce6sm113164905ad.157.2024.07.30.23.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:37:18 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v5 0/3] Replaced IIO_INTENSITY channel with IIO_LIGHT
Date: Wed, 31 Jul 2024 12:07:02 +0530
Message-ID: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch in the series adds support for configuring the gain and
resolution(integration time) of the ltr390 sensor by writing to the
respective registers. Then the available values for gain and resolution
that are listed in the datasheet are provided via the `read_avail`
callback. 

The second patch adds a new channel for the ALS feature of the sensor.
The same configuration of gain and resolution has to be provided for this
channel as well. As there are two IIO channels now, we would need to
switch the sensor's mode of operation depending on which sensor is being
accessed. Hence, mode switching is also provided.

Then the third patch adds support for calculating `counts_per_uvi` based
on the current gain and resolution value.

Changes in v5:
- Replaced the IIO_INTENSITY channel with IIO_LIGHT channel
- We calculate the lux value directly using `als_data / (gain * int_time)`
- Provided a scale channel where the scale is 0.6 * WINDOW_FACTOR
- Link to v4: https://lore.kernel.org/linux-iio/20240730065822.5707-1-abhashkumarjha123@gmail.com/T/#m

Changes in v4:
- Added "bitfield.h" include to fix `-Wimplicit-function-declaration`.
- Link to v3: https://lore.kernel.org/linux-iio/20240729115056.355466-1-abhashkumarjha123@gmail.com/

Changes in v3:
- Added cover letter to the patch series.
- Fixed indentation in the patch description.
- Patch specific changes are listed below.

[PATCH v3 1/3]
	- Cleaned up the spurious changes made in v2.
	- ltr390_set_int_time and ltr390_set_gain now return -EINVAL to
	indicate no match.

[PATCH v3 2/3]
	- Used enum ltr390_mode inside the ltr390_data struct.
	- Refactored `ltr390_set_mode` function according to the comments in v2.

[PATCH v3 3/3]
	- Simplified the formula for `counts_per_uvi` calculation.
	- Removed spurious whitespace changes introduced in v2.

- Link to v2: https://lore.kernel.org/linux-iio/20240728151957.310237-1-abhashkumarjha123@gmail.com/

Changes in v2:
- Split the single patch into 3 patches.
- Used FIELD_PREP to perform bit shifting.
- Used enum for mode selection instead of defines.
- Fixed indentation and whitespace issues pointed out in the comments
- Replaced `mutex_lock(&data->lock)` with `guard(mutex)(&data->lock)`
- Provided available values for gain and resolution via `read_avail`
  instead of sysfs attributes.
- Refactored `ltr390_set_gain` and `ltr390_set_int_time`.
- Used early returns instead of single exit points.

- Link to v1: https://lore.kernel.org/linux-iio/20240718104947.7384-1-abhashkumarjha123@gmail.com/

Regards,
Abhash

Abhash Jha (3):
  iio: light: ltr390: Add configurable gain and resolution
  iio: light: ltr390: Add ALS channel and support for gain and
    resolution
  iio: light: ltr390: Calculate 'counts_per_uvi' dynamically

 drivers/iio/light/ltr390.c | 238 ++++++++++++++++++++++++++++++++++---
 1 file changed, 220 insertions(+), 18 deletions(-)

-- 
2.43.0


