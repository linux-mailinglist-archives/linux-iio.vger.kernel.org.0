Return-Path: <linux-iio+bounces-5563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5888D6B6F
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 23:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901FC1C22633
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47CC78C8D;
	Fri, 31 May 2024 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nzVkJujF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AC1CAA6
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190386; cv=none; b=oWU3rx8+yitJM3MrxRDB6LrHo43I87RSENwSPaUVCK5B9XZz87YRYnAXddcriszJ5832xZ7YAQpHax9Ik1Pbh492pKOXAxytxHJklvG3S6SHNtpSnPJV31pd7pxYfY65jNt9CjF/NdVCLtq2WBnyvn/jC1lYCtzlbpjl7PSFN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190386; c=relaxed/simple;
	bh=ek78r9i4xgfXrjMsbmfUbdTIlxlFPKdQJjlSqdM9BrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mz/4fXQX1YgGjtg3yJstfzx4VLYkQ8CSJlPNBkLgg/90wLzjMP3+y7Sf1GXbe/3DLBfCDVEL+aB5JupR4GmfQ1JWXmldI8CnZwFDQRswupIWZvvs9MO98ZMFczyUYbyfdumUuA7iedUyrmsrePY1hQOpBtyf4s7LeJvyWJD/Cms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nzVkJujF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f8ea563a46so1493257a34.2
        for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190383; x=1717795183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf1Jh1GnZHozNnd+M9c3JoKjbK3zJd+Wb/SAaafdMJI=;
        b=nzVkJujFWF4xtO6+SPV9p5TowRucecWXsNX6IMRupBOg7G2z5Sdxj/Z/dOulvSbuGk
         +nUWW9NCeU42c5DBekY6+2yhpu//vA17UT+CfAA0Ai0mI/bz0toXXfyUrSOhDKOHgh2+
         nalJlhrzNQhhI7jo3hJ2YKlt5LYVRs2d9TMMY68m5KodsUjXw3SzCtRAkc3HB1mWSXTq
         fRCC338jyqFuURNhmG4/0YkzpFpZIWDoKamvwCp6ornqpR72jAdoqGWAE3Q5n6xuTsP7
         HD06En9TCqfq5gj0sDhzYF4xcj89byoEQKFYumITSofIWTENHOIiGux5nOjDC+/EOLCq
         KGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190383; x=1717795183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf1Jh1GnZHozNnd+M9c3JoKjbK3zJd+Wb/SAaafdMJI=;
        b=Tw1kaZ4+z3oVFPE4gVjseKwYwxPO6QcQA+GMVY7m4ETZvoojT7XsYo8oYUR/6k47xG
         ypT+Bikv3T4zYlZDEzIffBgNwLxEOzyd/2a3g+fQgdR2u3rz12eWdnpt2/qYokFGvJF/
         2URMkgo2MgwuRDHydzjVAUQt6Km6Z2+Sze5iAXoAhoR7ydN4hylQjT92uXWcKvLOpbZD
         SRRK1rjP0Np1JhLkYN4tXQznVs+pM1l3kFWk8Ct4ZzCLapWJzg6MkFGHRHorwk8VO78/
         oWgBiqkoqLk0jPkn6yNH+VaNmiBNuKHWe9gsP9gXIFdnZtjp169T1GJtcEVC8SDXjTOD
         3KdA==
X-Forwarded-Encrypted: i=1; AJvYcCUvRzAnadknwqAES6oIwPFpHvMf1CMJUGlUhuJnBGEb34Pojq3IHPLPiB/7x7I3PHhF1YAT2uCQTP2xRxZh2dyZfX72gyYl3XcP
X-Gm-Message-State: AOJu0YxaYqg/Ui6/hn87oLDUa4OjFinCx+NejkekG3ZLGAohbGaITQhT
	Bbhd8Anp8zz5SZCfcVyKFdcs3i2GzeD+ksyaDsabAyPByKtpCn8Nq7llSuOE9G4=
X-Google-Smtp-Source: AGHT+IGXRUv16oMo5Ev5KjlYDLKoeF2Bafvr70mApyYCccmsm7EegR5N7vmblOTP4jtUERC/Bl1a5A==
X-Received: by 2002:a9d:6755:0:b0:6f8:d23e:78e0 with SMTP id 46e09a7af769-6f911fc9917mr2899040a34.38.1717190383278;
        Fri, 31 May 2024 14:19:43 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] iio: adc: use devm_regulator_get_enable_read_voltage round 1
Date: Fri, 31 May 2024 16:19:31 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Following up from [1], this is the first round of patches to convert the
ADC drivers to use devm_regulator_get_enable_read_voltage().

Some of these are trivial but some aren't so I'm breaking them up into
smaller series to spread out the review load (and my work load).

[1]: https://lore.kernel.org/linux-iio/20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com

---
David Lechner (5):
      iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7944: use devm_regulator_get_enable_read_voltage

 drivers/iio/adc/ad7192.c | 98 +++++++++++++++++-------------------------------
 drivers/iio/adc/ad7266.c | 37 +++++-------------
 drivers/iio/adc/ad7292.c | 40 +++++---------------
 drivers/iio/adc/ad7793.c | 24 ++----------
 drivers/iio/adc/ad7944.c | 62 ++++++++++--------------------
 5 files changed, 77 insertions(+), 184 deletions(-)
---
base-commit: 15895709c7dc5f1a8b53b3564fc2bed724209611
change-id: 20240531-iio-adc-ref-supply-refactor-93f962d40c23

