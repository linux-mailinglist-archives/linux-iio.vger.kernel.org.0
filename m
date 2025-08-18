Return-Path: <linux-iio+bounces-22907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C62B29C14
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2896A3B223E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03102FFDC4;
	Mon, 18 Aug 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh8Z2d4t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84628C849;
	Mon, 18 Aug 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505481; cv=none; b=Gy6goB9IhB6QPH20MpVfWtYUtYjT7oFLu33wbgU3YqzjHsDnLFj/B/pBvJwIdoQZr11j4Ni1Hko2C2h0wmdRqkUX5nzHsshgSaFTNThZIhSzoPi6Uj0n9dleMl0pzFqcPYbcx2G+mTVCid8CkpAE8BymwyoVPYkA3DmXnmxynJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505481; c=relaxed/simple;
	bh=dxpe8aA0NDPM07o/fCGnJPe+dkVLsQeArSJFXVbAhEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evBtEQBPrnVL6er/tRYMQCi9q9NBoEHKLXkiX6VLEQhp1S7Ilu2IvK6QMq3koI+9c8fu/VlgW5DmgEwFS9OugOLvAYBZ7bn9FNFkTtYOsQGPKE3mds5NxQh69YRiDEWaQug5oHwk3etLFByz3n2EN+dQYBpeONDrUyaseII24Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh8Z2d4t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso27417645e9.1;
        Mon, 18 Aug 2025 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755505476; x=1756110276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmdjK9UebULbcMt04uH82Nfk5/1T4hy7+EliweCIJN4=;
        b=hh8Z2d4tmxrFsO7a+pE4gGzSprc/T9vq0xJs+8XBIOKUgrelxhNAoXVrggeuIyauww
         eOiuGtXkA83/XCZSvDezF0+jWdENd0xLZYCstWMtD6OAQ/+/Xbe4zLIT/QF9gDEjLYYU
         kBW8CnU5w0PewOiTEWyvv3eO5SFk1h2zYIiOpKXppFi1qrQ9xfplwQ8N7Ex0P6nOGvgs
         QKHk2lBsaTd3UxZFvjLKkyiB7nmTQPvOQkKdy3alZgNZfQ8GGSlPosomJAF6FhG/a58l
         maqtZ95eHHApb+7UZ6ksRYHlSgWgeE7ZzhRFhOngPQsOWim7wAC5IarQjixDy0fS91XZ
         p/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505476; x=1756110276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmdjK9UebULbcMt04uH82Nfk5/1T4hy7+EliweCIJN4=;
        b=MiDu8g+uyoPhP4JZDyJV3k7Xn5Nv+zan3NWHdoPACxSfEGdmsyAhQajDdkv1JPATkK
         Wk6mt5mn842qKEpkFtgkajAuH7pJcVKm3wQM9tYRQDvCOqrVNOfTtEK/lwhUYwPAAA8m
         wOLfjlIrBXHDy7y24VMxJgDWfjgGaSDI6G4dFCcr4AkaQ4c7kDKl2XTtyx+4LXzyj8o0
         oAL8MQlQ/suEkWq4sccBW9VLWnTNg6CZYunabfez2Ewp+LHyF0obmA6a56QcQG4We43L
         7tWX+4JGxnqgXPYjpdD/HDOjkALiF+LNsSvh72Ut2hiPjGbdIfjfbTUW7SEZYc6F8Owd
         2KgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBDJ35eIIItH4HX1cQJJOzebD74By56czM12ZswqPOh/rNz2wg0nkOpCzO9mA2H1JlxTsC3uD3AUHBzXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwN9C/dnUQdLuLwAdR0ZAkGuaLO37Q0jHR4kvX+XSgC8T2hyp
	HlxP58hNUCFUutgLwQj1SuU4k83M3SmHm6yBqIlqbo6rvgFXi6g6HO1gMIVPrw==
X-Gm-Gg: ASbGnctn2X+oRK0ScoluSWSBB4Xv0FOn1Y4kIrF2DyO8W1nLhP38x/KXbEoXSbPEEuA
	u0BSpWB8MRWyNivJTSqwFMeNotIFJc5cNzZnEeF5xCGS0DhGSSk3d8kQLpuANo90THpeWqRv82W
	ILuUTo1/y3nF6as7DrR7ppwK3PJuq0Ji4Hou/X2gTb8Pnebu4DE/W+EB+5hNb1puMb18kq2yQXR
	Ioh0+BOVM0L2fiFN+xUXV2LNt1bb2bjqmw7sBr2TvT0dWVXZyqkJUA+Hdoa+UxuLL72YH7z7IhA
	jCuGzIyg2hyereWc3J/8IFGu2BpjmGRJccrjVoyJXygIaSII4ujocPI6B6YNcgwtCA08vYQvPnq
	gHDOHeXLlt+MNRC7+r5Ha5McKeveAd7rGiFgazBkIn/Zf162YAw==
X-Google-Smtp-Source: AGHT+IEBNtwT9spSTXwJedKPCMoGwCkm1vx89mWQKiXQgD/LeFYcLxz096KxIqcW2UEX0eoSp9oKEQ==
X-Received: by 2002:a05:600c:4715:b0:458:b4a6:19e9 with SMTP id 5b1f17b1804b1-45a2180417cmr2344045e9.13.1755505475864;
        Mon, 18 Aug 2025 01:24:35 -0700 (PDT)
Received: from localhost.localdomain ([196.235.158.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223299ebsm126848085e9.23.2025.08.18.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:24:35 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Markus.Elfring@web.de,
	salah.triki@gmail.com
Subject: [PATCH v3 0/2] iio: pressure: bmp280: GPIO error handling and cleanup 
Date: Mon, 18 Aug 2025 09:23:29 +0100
Message-ID: <20250818082409.543197-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series improves the GPIO handling in the bmp280 driver.

Changes in v3:
  - Split into two separate patches, as suggested by Andy Shevchenko.
  - Improve the error message to "failed to get reset GPIO", as
    suggested by David Lechner.
  - Add Fixes and Cc tags where appropriate, as suggested by
    Markus Elfring.

Changes in v2:
  - Use IS_ERR() instead of IS_ERR_OR_NULL()
  - Drop dev_info()
  - Use gpiod_set_value_cansleep()
  - Improve commit title and message

Salah Triki (2):
  iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()
  iio: pressure: bmp280: Use gpiod_set_value_cansleep()

 drivers/iio/pressure/bmp280-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


