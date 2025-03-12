Return-Path: <linux-iio+bounces-16748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED914A5E3C4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 19:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622CF3BC314
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10703257458;
	Wed, 12 Mar 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t3XgssdA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB1256C9E
	for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804741; cv=none; b=KJAPP2KpEZXsrQEm5uMgCzbcF2+aToQKDYGDCynmZu5F4iRY8ejTSDq2UnduGEeg6JIQ7eo3aN9Y75iescKFWkv7X2nnhAy8AIgc9Dlll4izaPLmbmD346CbDtdz4PlIb/bzfqiWnlCBxtBL3U4QCFuCWmg8WvQ48xxDwdnJaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804741; c=relaxed/simple;
	bh=ybvzWnOhRYfgBYshSdaHXiCr++OHbzY7pf+1qHaz14k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2TnsfJ0ti5zh7BPE0kFOGjEFxoSJ8EtlHqvFC5EaEssRcPTwJ8QOeO86HeIzYz6DWF+HMDOMxUinObyR5XR49N1yFjacr6bPwxuL8BoqqvOUzQ7q6H4hjBj9p6fBj+RtKIM9mUdW3+yrrjExiI2cJvQdxNL1DcdQ8ZDe7MvHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t3XgssdA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so874965e9.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 11:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741804738; x=1742409538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtLYpayuYzvEWTlJavaNg0+iXTVFgLMi3moTuSzVabw=;
        b=t3XgssdAGN5Ggwub9+RrD0PAoglCSmN8VvFiXtNdrNj+W86SxOj8JHpqcofoc+z7oO
         Oa0DqbRNsEHIlPOZOzag5lPmyd8VgDvSfxTIpTNY0AVOX1Z4r9RqyLZOSr29kTfgpUcN
         fu5q+FdNd10AoAsJA1A6H6bDzAIAUsVCtJm3XshMgO7DcB0a0reZBt+dBQweBov+aTdX
         d2R9GOCCcjrlNppUxsfwW6XBiqMV+VjfBXPeYrby1HkotTXeihbsTFdqX6wjDK5JcdpA
         Lt1ANlxUjjS+h2eugSTHv1ROuARrhEznjgbjf+Jc2FC/PWDxmfxU5Ui37zpSCD0QLyXX
         s10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741804738; x=1742409538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtLYpayuYzvEWTlJavaNg0+iXTVFgLMi3moTuSzVabw=;
        b=fNR79CF8acp2fYybBtBR2sC+lIgODUlW8ZPi9ADmRNpt4eyK73EBJDuXpxZaKpLeVT
         VeyHSN8uqRGgWgYmjQ5wwEdSctVmY+fUyS9CKm4hOBDnvWck0erU7ezLwZfeLztUl6+n
         P2ZjsWEr3ZB6QjfQJnlv0JYB/J3VG6yolplxkFN6QWn00eOFs7QDY4vLQtLn+QKeeSUM
         2W2WVrA8Pfn+gjhtLxwnKbdfrykn2sHXl+MsKxm0Tbh2lpLXle+Zj7CW/uTe1/f034Af
         EMr3NtaVXUqCJeLvaO5OhJSwJ2PlzEUt5auIFVO3QBFiHTzpQuzuKvX5nJFHEGyyA7CI
         sdZw==
X-Gm-Message-State: AOJu0YxH1g/TpvOmv0O7QDMy/mopMKekjvbLpIBhlaPWwhmvTujOzp0B
	wWA6c5LrCU5ai/v5SWBJi33UXdhnhjqDQhY5qMH0LuGFgOq4QvZ8sDwTIPlyzEU=
X-Gm-Gg: ASbGncttRwkQrqodVpEohpP7Fm6+ymtoQkx/hireJVpwE90oaO5nHDZiEhTHj6dpTFA
	3ERjkDWtgHvyPJocRekZFKFMgUbaHPbjhCuo1cLnqnc9RXZETfGXRkB84gAyROZ/3b4VpzqG5e8
	yMUFQTmbjKAAL2tmDf4jqrfnMqUDp4+7BPhvrZHyFTfCLrnNPcoo8oiAfD6IxcwktLuH2tcJSMn
	/UX2vPQerG+G8vXlLvciGUQ837PpfEF/XeJ+NZYiftUh7JAByzK8zJ0BcuylQjNtW3awi+sptp1
	ALmO7XyC5By44nhMhKzNU6ogS/HHcfe9+BsY30e2O/q5JHn7z92KJRdZDJG82qDG/Sujwj1B9J9
	/AAix0dYTAbE=
X-Google-Smtp-Source: AGHT+IGSZj8ut+DGZbFla/xcPv9OOVse8iW5Dvb3qC2rVqO5fAw00n8meg1Jm1Y9nV5o2qyOVbDlAw==
X-Received: by 2002:a05:600c:3155:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-43d017258e1mr87517315e9.29.1741804737657;
        Wed, 12 Mar 2025 11:38:57 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0ac26758sm27391765e9.35.2025.03.12.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 11:38:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ad7124: Fix 3dB filter frequency reading
Date: Wed, 12 Mar 2025 19:38:38 +0100
Message-ID:  <6d31f9559939ec04066bec612a59bc7ace2ca548.1741801853.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
References: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ybvzWnOhRYfgBYshSdaHXiCr++OHbzY7pf+1qHaz14k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn0dSyXL3WAK2DzN4gXyq6QxoNunMIFEss8gSgV jCSN9RC4WCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ9HUsgAKCRCPgPtYfRL+ TkspB/0d/fQQ1AOvrJM4bEb2vBshYbcdzOoB5XNNY2KEI3etSZGqd0bZ0GmbipFWDQpf0Ohd4zj S6LDel1vI5zdm4bP78js/3SB0sDgFI/IRKkVLHNBe1djHbK+vLQ0wo5M5pGG7jZIpETAbap22Px DTSqPsx5TZaYSYON56mUm6dATf12y1Xy2CdVF9zSSZ/pSTP3tF41QjuZe7ZH5qGd6KFphSwQ0c0 WuvRwrl13Dia+0Ma9ZbhT3j7B1wTYteeqAa907Or81xpVmyDRJ0UHoB6JD+RZ7PbVGey/M2N3Wd 2bPOeAN1IcZds+28SSrHTQ1nMPQvufomAUwe99aNgWMsB3NS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
and for sinc3 the factor is 0.272 according to the data sheets for
ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).

Fixes: cef2760954cf ("iio: adc: ad7124: add 3db filter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 67d49e6184f7..a3cb47ca3901 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -291,9 +291,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 
 	switch (st->channels[channel].cfg.filter_type) {
 	case AD7124_FILTER_FILTER_SINC3:
-		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
-	case AD7124_FILTER_FILTER_SINC4:
 		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
+	case AD7124_FILTER_FILTER_SINC4:
+		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
 	default:
 		return -EINVAL;
 	}
-- 
2.47.1


