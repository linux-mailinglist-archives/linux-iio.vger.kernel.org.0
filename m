Return-Path: <linux-iio+bounces-19935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC50AC3DA4
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF7D18982B1
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AB91FCF41;
	Mon, 26 May 2025 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KXB3e99F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36291F8937
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253893; cv=none; b=DailgOUvFotyL9p49OYB2cotvmBKnA3sxKoWrjDXkM9wQPQTQ4j3IGCK6V2up3u806JMqA4/E9UDZdUyFoqDopJN3aUbhy2eO6nklwn7tt9IC5jWWiwp4A9rJcVzNooZq9pFc2YSt8plp18xzygKNjmo2I30CFgs7O2sygoUDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253893; c=relaxed/simple;
	bh=G/PHL2H0hCT1vJawFGnuZDviCmco7m1K7dYprLhxJYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePqX7HrZ2xhWIhpdkQnBxawkNkaeg5ynbEeN3iaQWfLDWHCkIeWanPPWN6wh/22/MxLw9N6qIxXfP6x2PXelpoAUP815X3gSh3k154QMOlnZjBPwRX7WeCfWS0mf+WPhhJ0uCXCYj0QSOAtFOmivlaksLkDU1nHt7Np1pBnCzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KXB3e99F; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4c6c0a9c7so1317933f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748253889; x=1748858689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1cI5SBD7MAWLfTRQEXjlnF27Z0y/aSH849T67R+rYk=;
        b=KXB3e99FGF1qMzkt23oiJUXYA9k/OwdBog+tgP4k63Mm9jf9x+DQmezeCPJB5IIx2D
         dYDko93fSKXfDkEICWt3pO3237OJVfYiJpWAUPMm4me/TwQXJFMCYtI+7rnspJaVMu1G
         74hiwfX2Hjfo/7YCEovhRZ/tVajMH/JGiSm0b1B+BlORdj6GQg+Qbh7xB7ydc/W6J7mW
         WmG9suiIotiSPS4fh2GVyLmw5yiugKBErexR7FrW1eAHBaxUC1V7FnCpWVjLlqUvGCoY
         w0kj3bcY6YJbVC4l5xLZvkabSwCoue6npnDLaKLMZr7GL2igZbEyz1NXYD5SDHLdslgg
         duow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253889; x=1748858689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1cI5SBD7MAWLfTRQEXjlnF27Z0y/aSH849T67R+rYk=;
        b=Wc8x9yEwg5pycco2Uup6qG9jqCKWGsKjfPxDwzOc305xfLJkmcfXIjPAW9t5i1rw9B
         7QTlpv1doVW52PUmHtyvPsbIeB7t1Oi5Atpkkc/LNCin/TGCYsNaMJcd6LgzytltH9Xu
         U+Kp045WNMsDRdy2OFJ2P25kzKFuleSDUlUkaESKXDRA6cV/xuH8hbDKRZCEgo41icaa
         JF+UsYINjGTo9YlD9YF9UUHuYHLQTb1gpLoB6CdgfQjWCqGj4VU8jX0Tv9fgUBfPJSiI
         ctEse3aJNCgz5G9DH203h+ZM4HOb8kcUZi2xBd16Ov9IHXysDaQyOXLsHsigKFhH359c
         YYXQ==
X-Gm-Message-State: AOJu0YztmCmibobIR16qfxkZesDufJc0AIHb29RnnvX4mB9gmO5dxd+9
	PWmOflCHR6DduRmRvoJaon00qs7/h4gM5o6RnZDFOlRQ1RmBJM2j/bLUYJ/FaN50kQ0=
X-Gm-Gg: ASbGnctl4BVVTWRcOeNh+lM0Cx3Hq4fZ6aF9tl8vao4Tg4xEBjAQR4P3Zvp8Y3Q5YL+
	+k4I4z4fmy2UOuI6674Z55JadtI6QUXTC/8t0KOionF1rkxE8Y+Ub6xc4k+9VbxcdZQwaCzWw44
	dRj+Bpm41lBbSzG3fOicM+QTNDgAFt0p6+3UahZihNTC1Yb5IgwR1BmOAhv7qO3f1r+RMIeUyhV
	O5dfW9PNkdCm6T3qJyzOH2FejUOj4B8CDxIQZJ7nAHsEvhMgT2Ds9En5I1GnlaW3sZMu0VQIwC7
	+1BrL94NodCpea7tcAm1URqRrDPOYGkni4o+Uf+BWRUtm0dWpH66OrUxdBlRJYQaqNqDdmZGJPY
	69V8i8tIighCOc4Y2wIXGbtD4IBBQWh8=
X-Google-Smtp-Source: AGHT+IF6mIEWndbTmsmJpL6uEi7nCS8HyYelPhOXO26l0/vLChjcCpiljRuyV20XEkmMAv/G/rTqCQ==
X-Received: by 2002:a5d:64c5:0:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3a4cb4c6b6amr7756998f8f.52.1748253888985;
        Mon, 26 May 2025 03:04:48 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca888fcsm36141834f8f.78.2025.05.26.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:04:48 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 26 May 2025 12:03:20 +0200
Subject: [PATCH v7 5/6] iio: adc: ad7606: exit for invalid fdt dt_schema
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-wip-bl-ad7606-calibration-v7-5-b487022ce199@baylibre.com>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=rfCHNvDJGZ9CfpNWbsvNZme06fPzQKFo7DAhEkye3IU=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgwscm+2v1T8ol0YNBhvvbjfEkvOALyAjny9P0etAV9O
 Odwp+1bRykLgxgXg6yYIktdYoRJ6O1QKeUFjLNh5rAygQxh4OIUgIl8KWb4pzo9WHbnmyN2Bcrd
 z3p0jzFP2z1XryXLPjr209wrjV2LxBgZuqQN1t1mc9TelL5SyFGohb1IYdOMoKtX77tKXr8nc9+
 eDQA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ad7606_get_chan_config() fdt parsing function to exit for error in
case of invalid dt_schema values.

Idea is to not proceed when there are values that are not allowed under
the dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 9a9bef0cfbb37138f71ba5b1babeaa423eaf4d5a..e0a666cc0e14255754e74daa9e1e88bc4ad1665c 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -319,15 +319,13 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret)
-			continue;
+			return ret;
 
 		/* channel number (here) is from 1 to num_channels */
-		if (reg < 1 || reg > num_channels) {
-			dev_warn(dev,
-				 "Invalid channel number (ignoring): %d\n", reg);
-			continue;
-		}
+		if (reg < 1 || reg > num_channels)
+			return -EINVAL;
 
+		/* Loop until we are in the right channel. */
 		if (reg != (ch + 1))
 			continue;
 

-- 
2.49.0


