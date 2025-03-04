Return-Path: <linux-iio+bounces-16321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4BA4D8EE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6941791EF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997111FF1A9;
	Tue,  4 Mar 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vE7b76Iv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84F1FECA9
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081181; cv=none; b=bmQqiwn4vHJUn3vbl/l7uVDfKz/JtSzVZzUwyKT+Wkgy/6IBu13JxsoraMOOf3Nb3zpQwyXAdO30YIuIIMKHHgNbwiWEChuQKALBQpsGMj4+ILbimYdNubxlcGTIerZdu3ogbe7Mw077fi2dxWNapMzUw1zCby9L6FnLtPj8o8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081181; c=relaxed/simple;
	bh=aOGadUaD55/7NjVi9olJnWxHY2EQr81G0BMQB3FqhzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HBP4XUhUNKFkL0gcEPiPhTZD8jzjj+A2daXB/diIHb0OG4Fxms2NtexqfRBzgMMr4D/D7yBRFbFhkWUs/dlbFcftwd2/kfpRHiovQVJf9sUxEJBKLXzNnGDoHTw4SbKAf/KsJFTyhdMMUQ7YlknNtF8cir7VtVcmEbxHzGQ6xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vE7b76Iv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43995b907cfso34409915e9.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2025 01:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741081176; x=1741685976; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzSd2WWwaJ30wmCeIbpT1A/lGBwbvt5bCwq5/4oCS6I=;
        b=vE7b76IvIy0hog7qW6HDTGl/PAw6bW7Adl2xf6+9tIfZ0V50hZffFnsnv3IKp9F1mz
         8UVjdEGN0AndDgYH6sDggkyf9ppbwh1pp+84q7VBgmQ7nKzOZp7kBlXeXwDgfMysCooL
         D5TbwBfv1W4OhSczgB58nzWukuQvKbLF4AytutKvRrvLuf7jzTfG28MsS6oG9gOJ3HT4
         xiM7R3oz7ybaIGUfrX5vZmRgWOlYFjvzssNOPlXCSFrKgcACWKxPH9rvXE2ULmhgEpbS
         Fxuj5KlTtYLw7vWj1+Fot5QLKFSS7+k6SjSg6FtT8o9QET42BZMBxkYUKeSdFuO2ushN
         HGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081176; x=1741685976;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzSd2WWwaJ30wmCeIbpT1A/lGBwbvt5bCwq5/4oCS6I=;
        b=RVfBm7feyrZw6mw/UvuFCX5wr6gF4uaXPw4PQC/SgAw0ow6hswDKn9YqZvXx6zDiST
         e5xF+NiOgqK6pSIG1l12RNJoni/LpP+9hwGnFcaXkTVpwDK4UZ436hlxYQyH6w9zMkMf
         fgqyXsnWHpjZFALnDMBhZg0jujz5O28qZr7YxQfo/q4fakvwiO+JjDKHsIAgsI1olKB/
         dnkKIcMDkilqN3kQd8J+9WqFOQiu+RkTuaDoyJh08jQenm8UNy75Gfnpv5MBAqocM3Sf
         3+S1Mf4g6V+6rdhoJfU1vC7psWzUzgbsCjgLwIweJtPkv/9GMtJsweZJCDD25y81xZBE
         qAEw==
X-Gm-Message-State: AOJu0YwNTAf/G7SMcCzSDx9umTynHFBO0pIEm8XibM5TJrCKewaqPpgp
	r5qI26TbaFtRIz3yOv1xUMzONsU2fbqgO+ymBhT5kIz9jm4zrqXpYNYBdsrhsVc=
X-Gm-Gg: ASbGncvHY+V4JBgoM9K03aAf0DzD/4ZGSmgNUjtfIO+CfisAqs7Pa2uWN0KITTZmXgV
	KOx1zvbJApxE5jJH/sqGyPrqy2xAoQn8UIf2tjxuxuGyKXUc0fuhKc4sm5ydfL29quyt71YXa1/
	gRx/Lyd1BqOeK12vhR08UUc20w3wiEfLZ233P34PAPmqBG6j+G7WRZjjNLMmHmlFCxlTlPP4SFH
	twXtCIe/e/07RP6Jy+bVjeSvp+Di8PBvN2bN5hZ3KGFDsFHdeHi8oCQbusJ34yn/ym4chQc+i2S
	D6jqNiekbP2QeuqxK1gdEFj4tc+w+ypV1Y/IJi51MMMyMFIjWMG0W/o3jfFwF2spqo/I44jTkyq
	7YgZSlq9CBqpZsCZD8OgQ6KdQR8UsFwY28Q==
X-Google-Smtp-Source: AGHT+IHj42i+Jh0hoXFnYJNDz31oiilscLISu0w5fjYK90iskecg4D7mRgp2rynwPpr1wC+EJx98Hw==
X-Received: by 2002:a5d:6d89:0:b0:390:f815:78ca with SMTP id ffacd0b85a97d-390f8157bf2mr8815914f8f.30.1741081176166;
        Tue, 04 Mar 2025 01:39:36 -0800 (PST)
Received: from [10.2.5.157] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7ddesm17307844f8f.57.2025.03.04.01.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:39:35 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v2 0/2] iio: ad7380: add SPI offload support
Date: Tue, 04 Mar 2025 10:37:49 +0100
Message-Id: <20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3JxmcC/x2MQQqEMAwAvyI5Gyhxu4pfEQ/VJhoQW1pQofj3L
 Xsa5jBTIHNSzjA2BRJfmjWcVahtYN3duTGqrw5kyJrOfPDWiMuBOSoGkSM4j8733WAqvr0VciR
 2hdrHxKLP/z3N7/sD6aD5zWsAAAA=
X-Change-ID: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Add SPI offload support for the ad7380 ADC. 

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v2:
- fix return value on offload probe,
- add documentation patch 2/2.

---
Angelo Dureghello (2):
      iio: ad7380: add support for SPI offload
      docs: iio: ad7380: add SPI offload support

 Documentation/iio/ad7380.rst |  54 ++++-
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7380.c     | 509 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 518 insertions(+), 47 deletions(-)
---
base-commit: b7508a5a672275694c2a1b09a5f491ca2a56bbcf
change-id: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


