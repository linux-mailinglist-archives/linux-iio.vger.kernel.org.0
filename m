Return-Path: <linux-iio+bounces-12045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBF9C24C0
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 19:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EF11C2404F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 18:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877EC199385;
	Fri,  8 Nov 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="23rrlFR3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11639233D6E
	for <linux-iio@vger.kernel.org>; Fri,  8 Nov 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089914; cv=none; b=F++DNadttteCOWG4lgiN2sgNJpw3pUNzQA8fPhI0mNIdRnND/OmrV1s+1TrsditzK72tqE0jpULycsPna5buydUVOiyK5gLgouswLFR82R3ZJIhE6mDm3edP2BpfUozzZkR6A6tNx2X9qGe1/B/p1tuO2IrkaGnnba/SS66B7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089914; c=relaxed/simple;
	bh=cjRKdYHBHNVHP6Fotye3+v8JOF2asOuCY4GPsoQWFqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mavrjqbP+CQXARb9D9BW2nxWBeNQ+3nogsq+RJKij5ngQDfxYLV2PMBwZ08gLGVlUCAyTcN4Bj3RF5zo5aOlJFcqAFqvoSDwqQvjt7fsfmacyO6mCA9aPwAljQ0oEQNa1kBPB+9q8+yN1DlG2YSh8eVy/CJ6yIS35oGF1C1ZDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=23rrlFR3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1668539f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 08 Nov 2024 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731089909; x=1731694709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXROKBTRhfzx82tvNGW7LzVaWoVZjpDaqjC7g8WHMCQ=;
        b=23rrlFR3Y9XWvdrH3e6y4dnhYz5eWZoFv+WgwyxMq9jlYrFx8YqeqbF/ihqTceH/tA
         wMzGKxM3srRrXZGA18RJU9qi28b/RzH8ejwITrXT9wTvwhhC5/r2xYVq489tB6SM9h/+
         Jyux2FBrU6lUiPj/DxgfMfjz/jycm9fXXB1CAawEqwVbth50qO0iTZfXz65+KYhEhgdZ
         49cH9wHyMDkimDuL+KDvsVGo01KE5z+lecR6r7FOTI6d9qoLJQzdldHs8RWOVDteSDo2
         fp3CIrDygL90EweubgZgwteJZvXPDyXnVCAr++IKHtKsMlIjLmFZgy74wnaZo6JATvEl
         Vi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089909; x=1731694709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXROKBTRhfzx82tvNGW7LzVaWoVZjpDaqjC7g8WHMCQ=;
        b=XZaBkIejmyFO83DCdMYsU8FAJQFR6XTYeYwx0mY1JVLDsk91NfKN5aN8an9qcAHCfZ
         ZuDK+Gb3AiT9wZTInMX0UWdsz81kK1/SR12DQ/I/M1lMbVfmJNWgW/O65+GKqAbXKeR+
         ykhQTpOhTlyaRgJfEyjMs7fdwyn9RDuw0KxJF+JYULI2QPtE4dLSxQx7a5qtM0nhBGeO
         y0lo5NnIO/wMbf1GEY1EqE/919Nxcu8r0wzWo2DKjaPTUIC9zzAxAJobLpLHfwNmQMx+
         DqcycBa1XK72m18GCmpzJ+UjhhqYsT+YEfAkhASjMnPOKGV1bqeLOdtV11620/eBceEz
         caXg==
X-Forwarded-Encrypted: i=1; AJvYcCXFMDEuvEfL4jNozXeWIdPomHQY0O7Cql2z6LKt4y3oDuZmXg5evULMmpkAQAK7g3dOXdEf4AvEbkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+0v7zIkHK1plY+iaQqeyIIEHvtcgXyQm7cSmqFtG1dZ9OugCg
	bSOdAswuDXZGMfm+qKj9GH5ep68DCY6D8Pv6D7jJjC1EwQBjLd3NStX+nyiWh+Q=
X-Google-Smtp-Source: AGHT+IE81tirHxVLXKF1FlPHw0TZSSkGzDKWjP9p0nY6/149orxHmtthAP8CMk9oJc7uvQECHWgFWA==
X-Received: by 2002:a05:6000:789:b0:37d:3e5b:feac with SMTP id ffacd0b85a97d-381f1854128mr3406333f8f.59.1731089909392;
        Fri, 08 Nov 2024 10:18:29 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b60cfsm112703025e9.7.2024.11.08.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:18:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Mircea Caprioru <mircea.caprioru@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad7124: Implement input validation
Date: Fri,  8 Nov 2024 19:18:02 +0100
Message-ID: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cjRKdYHBHNVHP6Fotye3+v8JOF2asOuCY4GPsoQWFqY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhnS90GevJVLCjXu1NmbMnnqv23Lj6tqZCeJS4ed9pl2du mfa3YjOTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAm8mAF+z+7otMTdyncTnNa suuF5eMei8OHlxyQqTybmjnp1dlkkzXGgX97M+bs7dkVN6t3mmOmc8KnDWszV/X4Lqqz26PMdt4 jelW54wHpdJUYxqMiZbmcc4UleWy2H+eb2GPEteCdbtOPiv1XU5Y7rn5daZQszTJlx4cFJ4oDX4 teeSadzuf1LajH9JgK53Ll5AnKlqd4w/8p/3kzv1w8vvDjfB0e5RjfqdLa5/zrLn/Kl9c2ck5SW cUcknr/qEB6c0rEsfhN0nbRmbeE29l8uZnPrGJO5lPM2mex7E4H86nHbxLV31mmuEt4JCy3LHNa sDmT58wiJ4sW5XIZ17Ubd+izCC3T/lUYuKJFciJDV1EkAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here come two commits that add some input validation of the number of
channels and the diff-inputs property values. The first limits the
number of iio channels to 16 which is the number of channel registers
for both hardware variants and so is the maximal number of (logical)
channels. The second commit refuses invalid channel numbers, that is
8-15 for ad7124-4 and values bigger than 31. The initial driver refused
all input specifiers > 15, but this limitation was lifted by commit
f1794fd7bdf7 ("iio: adc: ad7124: Remove input number limitation") with
the intention to allow values 16-31 but dropped all checks.

Note that at least some of the input specifiers in the 16-31 range are
different and using these yields bogus properties. E.g. 16 and 17 are
for temperature measurement, while using these in the device tree
results in a voltage property and the respective scale and offset
properties are bogus. Still these were explicitly allowed in
f1794fd7bdf7, so I didn't refuse these.

These patches don't conflict with the other ad7124 patches I sent
before, at least git can apply the series in both possible orders.

Best regards
Uwe

Uwe Kleine-König (2):
  iio: adc: ad7124: Don't create more channels than the hardware is
    capable of
  iio: adc: ad7124: Refuse invalid input specifiers

 drivers/iio/adc/ad7124.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.45.2


