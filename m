Return-Path: <linux-iio+bounces-7020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9466191C49B
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482FE281480
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1E1CCCA6;
	Fri, 28 Jun 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1P9fNpq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329E2263A;
	Fri, 28 Jun 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595053; cv=none; b=B7xzYbILCdGdHLPxktEJHe8zX18uMcqwT8mqvuEnWv8/6iwVT21OPRwvBGX7Ky7VePPiYntI1paUsoZOliSk58C/LCiYXbrx1FuRK+qHLm13XGYUbmU0j1jUrTGLRd1nLFE0/IWe0lXIyJX+B9TvqRiKa/n4JS0aW7rdgMeT/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595053; c=relaxed/simple;
	bh=a2QdUFdCrVHZvLa2i9UQ29D8Y4D6LDYjt8Ud1V26Xqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIt8pb3hfPXqbdzVL8XQtsyKtrJoF2XHcXEjsguOcE00A3F7cgyCY4Ta435Ih3cTia7t+M+y/SV6SxaqpNgivCsVf3AoYWn9EKhAbQlzL/Pq1YbvXEVIyn+0BnPjwPoYfRiedUrhJ0uLxcAczW8AtvJ8M70zB0cokJYK+k5YFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1P9fNpq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso1222055a12.1;
        Fri, 28 Jun 2024 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719595051; x=1720199851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTST/eFGakUKuwh/lrH2QvgO1bTvysSfAcD8QlMwAdw=;
        b=M1P9fNpqGpNirijrhBs5RWFjQVwX9PdE22EHMa4x11hhGo1/gBYBDJcnh4r2WWn4gp
         JTNedTZfxdi/vBnl7cXo2yFSMW57r1KEWOg5G42xMLXmKa0XSYxbQsh8ngnVSYUPzAyy
         C7GpRkcfcHOV3y/xIv59GrY2KH1sce6Rehp9Q3UPBQsPDfXx6XE9LsP+8aO5ZaM1MQKs
         EOtYTEkJYpWY0Cm+I8upSK1XtCahuQLq+p6gVgMW/2JB44jK9mT0dYD+uXbrxzPlFEBV
         txFuZVTHXfIvPkCQSdxZBZo86y4t4am38S+rwoZpHNMYWG1uBwv1lcQNUa6BjdkZrzpj
         oKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595051; x=1720199851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTST/eFGakUKuwh/lrH2QvgO1bTvysSfAcD8QlMwAdw=;
        b=aYs1Ytp9t/ZcDpY+fB3nn3vY2HKctOpdQHu+aPHTq7sJqRRQTCuQkn+X7cqfZkAdXi
         rnGI32SP9dTl+02qZt/hFJ4RIn5IIQbOA5wB3mgwEqr9d1P/4b1JB1T7ZowAl8ObWgHm
         7FRqNH9gri3ZKEZ8ve57W9L3PH/QSKF5C2Gz0zpEE9yeSog9GRx+WDg8ryiIijoWPZI2
         yd3ZbnBdMXLhiuf31PxhiHsXjEEP6o99knfn9IzMbxymGOolJrD0lGGtSO2/rO9X88AJ
         eqarGIgi7mGrCd6vAL8EQVgUDwA69VtlvW0221ltoT3b5aZ82z0FbQn4N8YkZXUMvfJl
         xwEw==
X-Forwarded-Encrypted: i=1; AJvYcCW+5avbuuaPj9mS+Ym5Re6+Yu1yNmZgbv70KfX1CxhPbbGOjj+3ebFerSoj6VI5ZO0TbBZk1gF76PZPrGcmCOHGkjuhPnMkDEu0X8xmdz8MaSmgY67YN6r9aacUClOcQwbFNRtdUM33
X-Gm-Message-State: AOJu0Yxa50e+bwn1nJzPcu07jneaZtEwYeSBhder6/0+ks1x04Mff+yC
	arMeDREh8n1jK0eJP0CJPOJW0cTkgmjlbs0tnIrKH7vOkHzD9Nbx
X-Google-Smtp-Source: AGHT+IHmUdL82/wYwYskebpQ316xeg9Oc0QfGcemXCHQzIumPjonJJxeWIJDAJxUFdxZygfGjzro8A==
X-Received: by 2002:a05:6402:51d1:b0:585:4048:129a with SMTP id 4fb4d7f45d1cf-58540481658mr4302988a12.31.1719595050448;
        Fri, 28 Jun 2024 10:17:30 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b996:e85b:4fbf:5c89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c838casm1271039a12.4.2024.06.28.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:17:29 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: petre.rodan@subdimension.ro,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	tgamblin@baylibre.com,
	ajarizzo@gmail.com,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	andriy.shevchenko@linux.intel.com,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/3] iio: pressure: bmp280: Minor cleanup and triggered
Date: Fri, 28 Jun 2024 19:17:23 +0200
Message-Id: <20240628171726.124852-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v9:

Patch 1/3:
	- In bmp580_temp_coeffs, instead of *1000/2^16, now we have *125/2^13
	  to avoid overflows, as it was proposed.
	- Type casting to (s64) to temperature read in the read_raw_impl
	  function was removed as well as it is no longer needed.

Patch 3/3:
	- Renamed "buffer_handler" to "trigger_handler" to keep consistency
	  with the rest of the drivers.
	- Added new iio_channel_spec for bmp580 in order to use IIO_LE and
	  real_bits = 24.

v8: https://lore.kernel.org/linux-iio/20240617230540.32325-1-vassilisamir@gmail.com/

Vasileios Amoiridis (3):
  iio: pressure: bmp280: Generalize read_*() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and
    refactorize them
  iio: pressure: bmp280: Add triggered buffer support

 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 643 +++++++++++++++++++++++++----
 drivers/iio/pressure/bmp280-spi.c  |   8 +-
 drivers/iio/pressure/bmp280.h      |  34 +-
 4 files changed, 589 insertions(+), 98 deletions(-)


base-commit: 3341d69268accb5294b569ec37e55212a8a28ac5
-- 
2.25.1


