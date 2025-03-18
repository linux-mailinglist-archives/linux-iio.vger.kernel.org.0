Return-Path: <linux-iio+bounces-17044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BEA6800B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A68117AD6D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32913207DE0;
	Tue, 18 Mar 2025 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yYJKW1LP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8E155753
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338339; cv=none; b=bWJ28hTBtIHUZk2xYet++iATHe2ElYO0nuf8H4o3G43za43BT9Y0FcRD3j+i4JgcHVAlPjSei6ume4GB0ovlQkXDgdiKpph5qC/MOGyDiL5b80AIHOO5+XNOyPsVZNKiO+slScnNVl6vCf7I5XxRKDTGsrtb+DzbEdplrxsBydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338339; c=relaxed/simple;
	bh=4V1uGJlbLS2MNFYwT/TiisjGHzY0Zo2NuWy91P1iRtk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DQ8M+Ay+xrgXfjvG5Ob7jhZC3vHuuF/wk4hAi51I2kzVKZRT9cp5+xmDbcCKy8/cL3bAzRkSFHxF3Ln0LJGfw62eZVmHqy87K06t3t0QQ+oXbeQUDc4VYE3tKZNJwDF7YqyGxHpuCAVe2hIQ4n0V3P/CbYdQgTF4tLWRz9PCdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yYJKW1LP; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c72cb91e9cso81294fac.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338335; x=1742943135; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NWEIJVyqdW+4MLLiF4tT/tt3BAv+zIxNfF/pTyFrgo=;
        b=yYJKW1LPipwZW1lRuLmOjUqseNXVfqiCmF4+UEOxnvvHY1ZrL+ZoB8VYlJirAuYENF
         /PWq6V7QO+TDFWtewb46cTt9XLRqwWujL5etpqx3HvMbGBX6Qhd68X/kLL5V+X/UJAR7
         LN1YZVja1hbq73nQkyHiQtdkIk70Fxvaz19GoidYCY++a+qcptUZN6X2jz6Ka6V88PYa
         PJerCuCI+FT/ctf03vquX1VBImHLiZxJ1Nme5aIKsOojDQDp5lrr+S9AWEkpjfAfsBlY
         Ets8VVHcmpo2/4rPHhOh8UPNJIMD+NPtURtlCb7pP2/+URQZVhUQqTJ2s3tBbBYskXLp
         bPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338335; x=1742943135;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NWEIJVyqdW+4MLLiF4tT/tt3BAv+zIxNfF/pTyFrgo=;
        b=nt/b/aKR3j9/hoIo3bE9IBGnim+s5TnUwyTN7KNHGrifovjDtvnHaMi3u4d1m4uL0Y
         2TjguQGoGhgNluxY0Ds+vB1YnxWXzuWNn3VkpVAhAEg6o+3ot3jgoNeegrFqI3XFweJv
         7qsSqs1SmR5kAVu/Ghbcn6F6Ijm/qiv32Zq6E76K3hgm0jAKYjE+WZP4Su+p83PNgEmN
         YjiCwoDuGrnUT62H+Juc8OnrxSS1LIwFjt3DEmNTlHRHJV1GYr6J3PsyASEGPoncjC4w
         Y7Bwd32v18nAJh5+oyruqlN4wj+lBg4kJee8RGumLd/UlaF30K6g0rVIwfV4GeKs7fE1
         iquA==
X-Forwarded-Encrypted: i=1; AJvYcCWCLBPU9DZstfhWSIkW7HJ/Z9gLWDNrgvDh87zgRaW59oSwPa5zbb9IqLi2V/kw77Zuyc4mEl9ItQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwInXgv8hrdo6pgsYp2crno2KO+eR0R6ENX3bszW5vTzONood0Q
	tmTwuj0EKMb9zMifLbQ5M/SiAJ2U+bzBG5a+6pKWPutHGG9qhHFSeRFD4x+H1VQ=
X-Gm-Gg: ASbGncuZySOnLqJXsMqRxWooDwJan7c4TqUhlUsn3fsDeaLylI5xVBFw2OQ627+hMUB
	icBIvSXklp0dcM/KV9pRlt05Dy4jNeaIel5b2GRigGC2S4czEKKKmEDK1SAEET2jV35H/nFugtU
	BCoqDS+D29cV2T46gO1AmsLlZTMp9aXlBjM5gxsChCFDYh9r7SGWSCzJl1Ud3pOVf78RHzsSf+U
	BU44qwghvB3+iEaQYM5mErNN73Yoz24Sk7T+7CtPrswTjMy4xVhzrtLqjYNS2n4ldVDXcA52cPs
	2eG+J6raoIfwJs5B7CgdDr9A34bKRm4VmGpLcn8O0L/hoXYCSOKh5DcW9tYAh23mCD86/xJCWE9
	u
X-Google-Smtp-Source: AGHT+IHP7YeqDHfTVZSt2Z/oJn9G/GILCI0z6SaMCMVOSjuS3Rrjx28rql18dk+ptVjoUvWj82yR8w==
X-Received: by 2002:a05:6871:a0cc:b0:2c1:539a:6071 with SMTP id 586e51a60fabf-2c743322232mr345465fac.10.1742338335040;
        Tue, 18 Mar 2025 15:52:15 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 00/10] iio: adc: ad7606: improvements and ad7606c
 parallel interface support
Date: Tue, 18 Mar 2025 17:52:08 -0500
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABj52WcC/33NsQ6CMBDG8VcxN3umLUjByfcwDKU95BKhpCWNh
 PDuVhJXhxv+N/y+DSIFpgi30waBEkf2Uw51PoEdzPQkZJcblFBXUUiJzB6Ns/l0JSrkcQ4+0Uj
 TErFptNOmV7KmArIwB+r5feiPNvfAcfFhPcaS/H5/rvrrJokCnSQryrrUhsy9M+uLu0AX60do9
 33/AGq9GufJAAAA
X-Change-ID: 20250311-iio-adc-ad7606-improvements-997d7af218e3
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4V1uGJlbLS2MNFYwT/TiisjGHzY0Zo2NuWy91P1iRtk=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkc35NB8XrXynOk+iy9jvkM+vl9tAhHk1BnW
 Mj/WCZjEbaJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMciRAAt+lPIvlxV86kDM0Zg3v+oph/pEQI9++a/IGePdq
 4YktjNwPiEXqxpNI/603PlK+Ic/4SzUNeWGxhA3Qx/cVIiCyqj3eDI01nVYt9Kc5oWN7a/bITZO
 oSQLGtTZhTsnL8FoB30IRwAoL65hkK/psaS6YdROMt7rpsY+HTm2/NFtP9YAZVIOc3PwA17IuXi
 uYhQxQL9phKx2fyAnKfVji4aXmlGCWmFeWtxhz6aYVXMAmTHhSnhxPpeY5GVzbR8BNscu/f6K29
 L0qD1OoBCyWEB++hKKNxjt/9aC6uJnvsAEV01WyrscRpBahWUjPMEw3T2JaK1v3qVR0y0YbKBRq
 lb0mqQg696PrR1YxOJuHPIJb5cIPV8MZDZagCNZnxqXwSOClw6cY6UI41XORfaAjzvRPsQgRDzv
 ZaO8/EttpRpvwukOdNXSOFKrcHEHn6JCnM6QXAP7+NIzi4zlPnSEGuR3pjF64KGweRzgoHC7d9F
 GhbOnY07Lk3TNxM0MLh1m6EwWtS1ECSW5azixruHa7ywp0JI7Cm5DUFHcP0E/fo8bx91V5fy4Ur
 erskC+/YMNc2ydGvUC/7/vM3gjBlQc3StnWwY7mvz+Utw6rU5CA6Kg9Rmg9jCmdmgXWX+OM46Q2
 SKp0mGV335aWExN3u+Q3kqtWjgfMKLOtfWwHj3AEss/M=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The main purpose of this series is to add support for the AD7606C chips
using a parallel interface. Along the way quite a few improvements were
made to the driver which in the end made adding the additional chips
trivial.

The first 8 are some minor cleanups (one could be considered a fix). The
2nd to last patch is the big one. As explained in the respective commit
message, the channel data structures were getting out of hand and only
going to get worse with the addition of SPI offload support. Instead, we
are opting to dynamically allocate the channel data structures to avoid
a bunch of the existing complexity in the driver.

I have limited access to hardware, so I was only able to test this with
ad7606c-18.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:.
- Dropped Fixes: tag from patch "iio: adc: ad7606_spi: check error in
  ad7606B_sw_mode_config()"
- Dropped patch "iio: adc: ad7606: fix scales_available attributes".
  This wasy actually fixed already in commit bead181694df ("iio: adc:
  ad7606: fix wrong scale available")
- Added a few more improvements to the doc comment cleanup patch.
- Fixed a wrong comment style.
- Link to v1: https://lore.kernel.org/r/20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com

I declined to move slow_bus assignment to the declaration since it will
be extended in a later series.

Also in v1, we discussed that we would merge the fixes first and wait
on the rest of the series. However, I since realized that the one
important fix is already in greg's tree and the other fixes are not
so urgent (I only triggered the NULL pointer dereference because of
later changes in this series), so could be nice if we could have
everything picked up since we have another ad7606 series that will
quickly follow this one.

---
David Lechner (10):
      iio: adc: ad7606: check for NULL before calling sw_mode_config()
      iio: adc: ad7606_spi: check error in ad7606B_sw_mode_config()
      iio: adc: ad7606: add missing max sample rates
      iio: adc: ad7606: use devm_mutex_init()
      iio: adc: ad7606: fix kernel-doc comments
      iio: adc: ad7606: use kernel identifier name style
      iio: adc: ad7606: don't use address field
      iio: adc: ad7606: drop ch param from ad7606_scale_setup_cb_t
      iio: adc: ad7606: dynamically allocate channel info
      iio: adc: ad7606_par: add ad7606c chips

 drivers/iio/adc/ad7606.c     | 312 ++++++++++++++++++++-----------------------
 drivers/iio/adc/ad7606.h     | 171 +++++++-----------------
 drivers/iio/adc/ad7606_par.c |  37 +----
 drivers/iio/adc/ad7606_spi.c |  98 ++------------
 4 files changed, 210 insertions(+), 408 deletions(-)
---
base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
change-id: 20250311-iio-adc-ad7606-improvements-997d7af218e3

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


