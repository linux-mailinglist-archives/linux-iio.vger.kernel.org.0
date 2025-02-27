Return-Path: <linux-iio+bounces-16114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A265A47C55
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23F31889D90
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA3229B0D;
	Thu, 27 Feb 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k9OSgYyr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40A228CBA
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656144; cv=none; b=GCkxvxWAgzUXWcKiQ0V+2PiACsZUgV9cRvR7JeZuQWFfmyIA7KPMcid//clnOcFJ32YVPQQmwi+VqhFYEuZivEh6X/IE44w6fiFT+/xX7a5QklIeHh0kxTsuXn4jo/fXTYMT5ETlfgcJUmGM2LUwbGLDY1akuc2sHb5eBCves+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656144; c=relaxed/simple;
	bh=Ntm2UkVFzIgnwLARztaWT84zhIMdkU2nG47Np0Bm14Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FzVbgGTuzWy983Mt68UskubUOuXsJh0+AAxsMMheg0pNQ2La43UOaSYd9Oib3CH3QCu7Oy+rA5dFbSTimgF4N9VWkb5T6Ta4PSVogxs+hLnhoiTEu1L7XU6JhYsLdlIMDymGxy3YjnR98EW6fzIABwCzLEAg72Pt80dEYUBckQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k9OSgYyr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so1383966a12.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740656139; x=1741260939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4e+YCNs8aPYYzPMRjygKk/xU4tIfwZ+QGjZg+j7KHYE=;
        b=k9OSgYyr8L5SOrtkrt12JfMkQPbtHksS51K6pFYcw+i8a6jaHdlvPfQtj6xagqyGsg
         Vm3TUdcLeYZAWzdHBg4hVI0cQsq4yA/QtEMCNydk5bMWyLy9jPdZO3Xg9OhkAqdOxDVI
         q1hu9aEepgEmWVM+s54gTUEzGnqdWZjoUi1nrYb5CS9b4JPar7JtClehdfhj5oeGME9I
         qGBxRrwRhzRcBaPWmg12uEmh4zAGrq5FszXjVjm2YOWeOenTu0t655vPxJ0Xg6H1XpPO
         tQGfrG1ZVh77/XodOMdvDpn5j8CcWxFwCeDj/yGz7PxxtjFv0lqTCinLFUJZyDYgi1/X
         Xx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740656139; x=1741260939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4e+YCNs8aPYYzPMRjygKk/xU4tIfwZ+QGjZg+j7KHYE=;
        b=CeDz9IML6G9tB8mGljfSL7L1cX9uiyHCws6+rBoKY0rE37K0TbtMfGb/wrZXS86T0w
         IEr43TMxNIxbn6B3ejsCmaVV9MhqLlfhpFRArJo+84Vk/PuHT40fJw4OCz9OrqXWD/QS
         sVFExTEIQGydUQ4ffXMOjzelj6ploYizSRQLR6I+1MvqXkGhaficG5EwIaUpyex/r8Te
         n0vJR3WcyeBkxgmSiXED730ZO+va9ELi+7F/UzNO6aUMw+G8n6Is1lqy5zm2Ljg2k49C
         C+1Hq5NLqSe46px0rorYSjltHSHHDleEkNfGigu2A0vc67TGuUZ+7g5vEX/yPgp6jKgk
         TBVw==
X-Gm-Message-State: AOJu0YzMd4oedptGm1iZhiM+Qpv2Lv6or09/4RZteZ5tTzq87afRP9uZ
	MTeS/gZg6RBUhfevtKAsZ065xIQfrIps3XZfEhPbjRHiVXaIga3pmzXB358bci4=
X-Gm-Gg: ASbGnctXRd4drXv6lMXn8n9d2huiGjtWPHBiG5r7RG5Vi/j7YO7oiEjK8i9t0VG8mbZ
	qXNqx6ad1uhxEqRi6InPDPzEe5OfZfTHzJyKfUvHQ/z4lZ+UYyDZVl9k++OU0ih+R28hedkakbX
	/WOo4q/XlyhjZd/pfm6hA+0NgtqxUxeTVAA+/S0VsGo3F94yY3oOcRE5Ys+C+u283yrihzLg0I+
	FAdzZZCl6Q+xC/wUTuzsqYGGM7F9tgdAQBaH4O7bc3hxfJ3w2RU1eEa2zcSoDdutFPO/vK6OXeR
	rDvsifsgNxL9rDGge9UJY9SdO2BhO+959eRvp4J6kgVcJ6bV9azRZ5seGmzM3tg=
X-Google-Smtp-Source: AGHT+IFGfNqMDWb/0EoqXA+CU6pPidgWhl5VxtK1zrSabELI4p90YEBqijAdbZ/jcLpnQdFfOpZCGg==
X-Received: by 2002:a05:6402:40d4:b0:5d9:82bc:ad06 with SMTP id 4fb4d7f45d1cf-5e4a0d45f9fmr9900754a12.3.1740656139250;
        Thu, 27 Feb 2025 03:35:39 -0800 (PST)
Received: from localhost (p200300f65f2c000000000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f2c::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm949806a12.72.2025.02.27.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:35:38 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Mircea Caprioru <mircea.caprioru@analog.com>
Cc: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad71{73,92}: Grab direct mode for calibration
Date: Thu, 27 Feb 2025 12:35:26 +0100
Message-ID: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Ntm2UkVFzIgnwLARztaWT84zhIMdkU2nG47Np0Bm14Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnwE3/27JHoqS4Y+Kj01AFFQyzxliTYFSzOYmZ4 9nC58q1Y6GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8BN/wAKCRCPgPtYfRL+ TibxB/90DN1UCXvdr1y0c2xZQqVAvRf4DxkScnCrV0g4seaKghY43nNcSKj0DWDcPmvHhwWoqi1 IPegv0nUp9HN8cR7SWVHfr4v93ZFzGCvUnjZ/XrTHlFL928HtZ4pZWXELrTei3DbcLYRfSx9apC Vavjp8qun+1yKJF/xNMh0nlk0KVZDcMf+ryQ+MjnTxLowWyomMj1X4mgD5LHzlZd2veCDL+shzv AE0M4nFFe38MQZz0D6qkKBqyIeSIy/S01+axDZVb3apMivRJSCEul6H5vrPH26wK5wusJibpwEn lHl4odO32NAwh4+LZW3P1oaJWoUdpENkXa5GlxhUxo41R0NN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

in a patch series I sent last week
(https://lore.kernel.org/linux-iio/cover.1739902968.git.u.kleine-koenig@baylibre.com)
a review comment by David suggested to claim direct mode for
calibration and he also pointed out that this is missing from a few
other drivers.

These drivers are fixed here.

Best regards
Uwe

Uwe Kleine-König (2):
  iio: adc: ad7173: Grab direct mode for calibration
  iio: adc: ad7192: Grab direct mode for calibration

 drivers/iio/adc/ad7173.c | 5 +++++
 drivers/iio/adc/ad7192.c | 5 +++++
 2 files changed, 10 insertions(+)


base-commit: 66e80e2f21762bdaa56a4d63c79e5aca5f6bd93c
prerequisite-patch-id: afd7caae7616d474e5a1a68e963828a88fa9cd3b
prerequisite-patch-id: f5900fd31dc701cf190c7b451e0917e5b659f03b
prerequisite-patch-id: 3c1b44d4645eee7668f543f0e9148c52337e1cd9
prerequisite-patch-id: 9f600afd72914d22298067f86c1298d18cb335cd
prerequisite-patch-id: 16607d29f72b649d63790b9c4c0852c089d27a1f
prerequisite-patch-id: edc1a70e612a16ff5a72b05741beb02f874c7d1b
prerequisite-patch-id: 4370980539a471328b354e94529da4dfe915b573
prerequisite-patch-id: 0bdad93ca4dd031c335799abdbf6c93e36f27dcc
prerequisite-patch-id: 4aa927f0072026df1ad9627a82f73b45250ad950
prerequisite-patch-id: 027c26bf1a9c762ebb9828682a61537051835cc4
-- 
2.47.1


