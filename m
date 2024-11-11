Return-Path: <linux-iio+bounces-12134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CF9C4240
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAD01F25D55
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0E1A00D1;
	Mon, 11 Nov 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g88XP/oX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18071189BB5
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340787; cv=none; b=FWXDXKlq1Zw/3UnoJjaU+1j9WzhIb5pDhFd3Ng3Xgb4u+ofJLhYXhobjNY3AffXaAyYVeAMfthz5SsmBq6qSJPS5HGJD6w/vRjNlILRcvdOKuRubMkYEFgfM0Ww9wzNBtt3LtVz0a+33hs2qv/GQQiwHiU/Ao7oGS+ehxO5iGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340787; c=relaxed/simple;
	bh=mhGJZFEfk5MkHnXe7qqUfuL+zQl1LNFP4u13j9VbxHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MZXpc06xTwqC/A9bBW/Nrwfb58pd9FErOyZDD2Ea1zFaiswcJ0s/8MIrdMuiu/rxiQkf460dx0AAldN5SPYAQFWtZ28l4mMKaY9QY3eEUxsp6/4TSDSjRzAPY01lPI9yifvgAyb2sCgYcAonzv6ZeEQbORCI3V0kNHVVnqfVoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g88XP/oX; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a6c2077afcso15361125ab.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731340784; x=1731945584; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2cKPgBQ3l65Z4+uJjlyHn0q9Q0ROrxH+n4NCTmhTAGo=;
        b=g88XP/oXkyQ9M3Qvqbg6Cqs4eyijMWZO8DuuxurOeYK0PrkCh3InSpTU2yRJRnWrH0
         kcP4X5HTehI6m3DqD2N9uSCMng0M8XI4sWENPX8ag08URWMYj5sBKzk0S+nGpknC94Q6
         PbupuSaOI87ByzIe6gGF92PY21MAyNLO+NSkZ4iKePALHwU5h4auIrfZ+V8OxrFspHo7
         UEf8K87HA/R0YUtZtpyGB5w1zGF0bu5nwcTO/j6lw1cwi+a87XB6hzZT7WM7EJVQgrUR
         dpO5lvLVdCrWXh3ojvVp494lgNXTdBa3TwCG6YwjUXNC4NFhHgxr8ISUp3FytBixQLcx
         0duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340784; x=1731945584;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cKPgBQ3l65Z4+uJjlyHn0q9Q0ROrxH+n4NCTmhTAGo=;
        b=k0+edkLCJXlr3WjmWJ7Y3N7aqhTKz1rTt0O/bn0ADkBokv8JERGpiEKzkGvVquLj80
         TFEePJu2eIzRT2JGTqQB1+nZ3Z/EP8P8joIjD0i54pJQnEM/McOI05pu4iBgAETw8CK5
         HCe6NlhsV13/WpLXhh8UNooQnh7ajTzbjJPY+i2Y/Ql22iEqJA4CgRYBIulgDTA1ZqcX
         bBSHhZlTlrphplkrD8vaiIPYRn8acjYC67XEG0ulTP74OfjTcyZlkyOKKEKiC/vB/IxD
         QE0tIHY+H9Nhkyd7wuJDGNwcfe3FJbRiLfUALAqadYBW6aKL7yc+kYIe01qLmocJ12eG
         hBKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Yr1Hnaxci1Q860DHPO2MfWrAhqSGwOAkrmb9GmPuVPXpD+DeC8O4iVLWBjzfKXpqxl9VN2XVarY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWwkz6AS7n5slZyxNGhn1rbV8p6hTY6xj+xt6vQNLiOtbhpin
	Yl2qTP/swCJJ+3KMsbk/gc+RKQCUK8RsyDRaNkMwRp13y8JLyWRBXvMUELumq2g=
X-Google-Smtp-Source: AGHT+IEPM1W+ZQMFu0TrS0mFB0rJ26DhnT3cGpDFG7+8qykw873wAuNaEJ8cHZ9YoP5VuJ3St8ImUQ==
X-Received: by 2002:a05:6e02:1706:b0:3a6:acdf:1a19 with SMTP id e9e14a558f8ab-3a6f1a22195mr134301545ab.18.1731340784057;
        Mon, 11 Nov 2024 07:59:44 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d62c6sm1410986173.81.2024.11.11.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:59:43 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 0/3] iio: adc: ad4695: add new regmap callbacks, timing
 improvements
Date: Mon, 11 Nov 2024 10:59:41 -0500
Message-Id: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0pMmcC/x3M3QpAQBBA4VfRXNtisH5eRdJgMGWXdiUl725z7
 r6b84BnJ+yhiR5wfImX3QakcQTjSnZhJVMwYIJ5GlLnQmbYxCqacl0XvZjD7RcbtqdXJWVIGnU
 1ooawOBzPcv/7tnvfD5CuebhuAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

The AD4695 driver currently operates all SPI reads/writes at the speed
appropriate for register access, rather than the max rate for the bus.
Data reads should ideally operate at the latter speed, but making this
change universally makes it possible for data to be corrupted during use
and for unexpected behavior to occur on driver subsequent driver
binds/unbinds. To solve this, introduce custom regmap bus callbacks for
the driver that explicitly set a lower speed only for these operations.

The first patch in this series is a fix introduced after discovering the
corresponding issue during testing of the callbacks. This is a timing
fix that ensures the AD4695 datasheet's timing specs are met, as before
the busy signal would sometimes fail to toggle again following the end
of the conversion sequence. Adding an extra delay in the form of a blank
transfer before every CS deassert in ad4695_buffer_preenable() allows
this requirement to be met.

The second patch is an improvement that increases the robustness of the
exit message in ad4695_exit_conversion_mode(), this time by adding a
delay before the actual exit command. This helps avoid the possibility
that the exit message will be read as data, causing corruption on some
buffered reads.

For additional context, see:
https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Trevor Gamblin (3):
      iio: adc: ad4695: fix buffered read timing in ad4695_buffer_preenable()
      iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust
      iio: adc: ad4695: add custom regmap bus callbacks

 drivers/iio/adc/Kconfig  |   2 +-
 drivers/iio/adc/ad4695.c | 135 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 118 insertions(+), 19 deletions(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241111-tgamblin-ad4695_improvements-7a32a6268c26

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


