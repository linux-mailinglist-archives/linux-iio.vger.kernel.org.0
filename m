Return-Path: <linux-iio+bounces-14542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49CA19B65
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 00:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3D516C8AD
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08BC1CDA01;
	Wed, 22 Jan 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="keWhp8L5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB21C5D56
	for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587826; cv=none; b=P2ul2tf7319QPXh5udCVHQeZeSL/vYmxj6oJFQnYq/Vs7Fa0rXr/rza9kYZlOEz8m1M195qMDPOu2yxuClWfM1kucDlPNkXHyjqZ4zQ2SD1O1pcRI5yVV6P8WfxszyveK510mb/J6PsAKQFMZFRSuMpafyk8QxrAGcd4M6DTfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587826; c=relaxed/simple;
	bh=TtjQPNl6OTM2K4k/jF1u5iijij0z3buUzutigKl/igQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j4Vfcmi0+NcropW9C5qb/L/GhxLuWOBG/ooGls91sb7AlCM1YKXd13CWOoikRbZ2eHjvLGxNd9dYsibV9KsYMGLc2jdkazQJwUR5ZyV73qqXB13t/sPHJ5NFekzN6GIGkGtqHw/Gc5ECrfNh1J3WR86Ro2rdzqBwhoftGjrp80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=keWhp8L5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e157a79c8so85761a34.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737587822; x=1738192622; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OOlg6tjFXngIhlnbIWgClW+e5dHMMirNsQSGx5x/aw=;
        b=keWhp8L5NPj5NqeCWcIIqlvT/xsv1253t+pgVnuxPA1GXjcPufzTp91dzp2R9eXLEc
         HTlq2pxmzGMSXiBAfuQlwD9uRIrnqTm+SvJ4yIGqvfWWEt3412h8Ru0BrjPRZE8Matv+
         e5GFW2oHPusqGlhEu3tt9kfXF38wxd/I0pJbmQIeNhqOBMV4rPs37Ll1WjfrRp4IhLF0
         +7fXTSS/+gqYnohAD8kOvuRD8TsXRtBE/+HdvKOum55xpgyV4Vo6tfNml7A9sbp+eMgS
         WusGlAYgjLXGHhEBcUGheElwXaSFdzcuxD5eWIGaTNYdDMdxZ7YXo6RePqtkYZMO8nvR
         DwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737587822; x=1738192622;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OOlg6tjFXngIhlnbIWgClW+e5dHMMirNsQSGx5x/aw=;
        b=OIkjon7lij5Bxl3OCV1SvhsEcTEPm7tjbnW3W9E0nrHFX2lQqwfXP3s/iV1bTOPH9Y
         LrnkgWaVj9obmaIBsnskJ20smKDvNhKPxhN1VRr1VjallHWjyVwUID60wu5hysa54rOE
         nXYk+Txl31tdsNimJkqYH84NXCPnAt6YJNFGw58AgJKItzvhhPoFg+PpMrjHX0Tf81F9
         ntlMQ7og1CdXBrS5M1N2zQaBa0il7nQrgUxQpRX01ab1HeyzPySiHXdDQBwtXE5ShA6Y
         7s6+cc56WVcamGRVdnaMZvJStOErvFxywLeBuKn7dm3HK1R0lyD5gbMcIITnbeNqp3EV
         kptQ==
X-Gm-Message-State: AOJu0YwW7ZrZU7EpmYV5/B2auPmUVyl6CuPQC+51cLYB6Kmn2yRwDCxo
	oOcAGmKkhp2j/7I2ubGxHJRvNAE6mxbesxg6q51meJ3HsefA43LNfkMMrczA8TI=
X-Gm-Gg: ASbGncu7DJJ8/7jqtv3G8AunVVY2bqQI1gZtJ28RMx0oV939Ez2WPmwXA8vKK8CL3zD
	4gTd08tYF6Gop45QJS0NwrryEWaMP1ASrq/6QSiYM4vLa88cnEVbkqE8JCdQRTUc1mpSDkb/o0z
	5kIzx2JHPaRHLqqwW3Aw5n8wVdqqUBmzFfsQH7IfuRdBvs+dbS91X1NJmYO3BdoFZ0H4/9h4dUl
	U4D5ZBgx2rXgqPNczqAa6S4UG05wm3+s89AnTR7ff5czCAnuF/RACjh22cZjpWIPOKiYpGTvxlM
	OnI1ROfq/skWHNfukX2KyJuQGw==
X-Google-Smtp-Source: AGHT+IH1ycSRvH/KUUZxKDaSg/P17Bp455wQqA6ceWssIHmrDmYc01otoqmk94pQfARNXb9Y0kev4w==
X-Received: by 2002:a05:6830:6087:b0:723:28c2:aa84 with SMTP id 46e09a7af769-7249da89f3bmr15927621a34.13.1737587822582;
        Wed, 22 Jan 2025 15:17:02 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa35fe0819sm3731819eaf.27.2025.01.22.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 15:17:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 22 Jan 2025 17:16:59 -0600
Subject: [PATCH] iio: dac: ad5791: fix storage
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-iio-dac-ad5791-fix-storagebits-v1-1-53746e0f25cd@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGp8kWcC/x2NSQqAMAwAvyI5G2gLrl8RD6lNNRcrjYgg/t3ic
 WCYeUA5CyuM1QOZL1FJewFbV7BstK+MEgqDM64x1jkUSRhoQQpNN1iMcqOeKdPKXk7FIfYtRzI
 deQ8lcmQuyj+Y5vf9AESkOcVwAAAA
X-Change-ID: 20250122-iio-dac-ad5791-fix-storagebits-9f86efa07abb
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

IIO uses "natural" alignment so storagebits should always be a power of
2. Change storagebits to 32 since that is the natural size to store 24
bits of data.

The ad5791 driver currently doesn't use this field anywhere and doesn't
support buffered writes, so this does not change anything. We just don't
want anyone to think that it is OK to have storagebits = 24 in other
drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Since this is purely cosmetic, I didn't bother with a fixes flag.
---
 drivers/iio/dac/ad5791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 57374f78f6b885e1d4f2fb452ac0563b85fc222e..034228a7c059f136cdecfb4683228d0be4c37477 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -294,7 +294,7 @@ static const struct ad5791_chip_info _name##_chip_info = {		\
 			.scan_type = {					\
 				.sign = 'u',				\
 				.realbits = (bits),			\
-				.storagebits = 24,			\
+				.storagebits = 32,			\
 				.shift = (_shift),			\
 			},						\
 			.ext_info = ad5791_ext_info,			\

---
base-commit: 012b8276f08a67b9f2e2fd0f35363ae4a75e5267
change-id: 20250122-iio-dac-ad5791-fix-storagebits-9f86efa07abb

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


