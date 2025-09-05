Return-Path: <linux-iio+bounces-23801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC4B461EE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 20:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF331CC46F2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97EB31C598;
	Fri,  5 Sep 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sSiolotQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F531C56E
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095970; cv=none; b=Dp+IAdtrA7rE9EvPdT3dIET8aNPj6//OM6qfFaSoOVXqK7+dFi5Qdt/3pMBXeQNzOz0sI+d8OD5giTrl8MNvNg1zRNU+AvDTHRt2B/hiGes+YQGRe9l6LQkMx6LapX0gwdif0S/fqa+FtBw1N6uc+dx3HkYEn25LAUd3d+6MQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095970; c=relaxed/simple;
	bh=aRfBzEhu9pJri4r6TxRz2ZjFBxLSwzNywqlNQlQhkbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3iS6wkktU9JYwpatXLo81d8GQNFau9Q7irr3pe11sPAMDoaqu9hq9WwvKWWRrC/ziVGUSXQFr0fiTUAttpvHC6Ok3ZdTMd7b0tF6iMcoIgC7r0vO9tF5TmrbLIkFrnUu9tqEorLLzaL20KLSt2H5s1aSvWTZ4GxzvjOBNVTE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sSiolotQ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30ccea94438so1906195fac.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095967; x=1757700767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Rel3qpsff+gDGTMnN0Ax6EW5tJ8mX6ZG/EwN44Ue6Y=;
        b=sSiolotQ78ML35Q1d1qfRZqAWX02ov8ayKFeBDK/J+rCE8DSwLyzA7e9vLGpSb8pUj
         /EkaXKLOBYbQ3LkxXU1aECQ814bCcm/pVprYRkleYXhyGF9WDG09vpeehXEGJOpqtvud
         4RwYJal/Vft/RkPvAS68dPzec9AUaY0PgHTjOEf9DW0rCYd5tc0d+jdMJ3W1zKPS6+7J
         F9Dw6/6G/iDlYp1DLFSyY0AqHKon+dRrnjbJwUKgxoUFQW4Pr+eG4qAhDp5zld2iyIoY
         lPBURpNoitZK6NSUDZj0Hti+/Qin/0jqmjgVMLeqUxTy4uBRwyG9V67sw/QMgTIuwOiR
         Qyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095967; x=1757700767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rel3qpsff+gDGTMnN0Ax6EW5tJ8mX6ZG/EwN44Ue6Y=;
        b=GiRSCoG2QoYiKrs2W+zf4VobgqGOJhv3tyzEED++dGM7twKZvqBQYLm/EPGd9eoExt
         1Tb7KKPULJrWdaZRH0/U6Jk9VaxzizTK/7piLaDedLmCjjkqBU3BLIgCNI7JdNter+CD
         HEuh5ZSXGWotwrVCBgV2M3mXIGW/Pf3ZOlrYbXJz0dR4EV0/kP2U48DSHe0eapxrwnjf
         jXp3elda6rvFiw5NuL6FZFU/4nzOJ+lnIwstCkjSDkkOSHpi6B2uGx7vR87E9Cwp8dZ/
         MGC+by4TclLzL6v3SFpzLt58SkH06Gash37LKhMALdcIaHUFHRhDxmrreABm1AHgZvhv
         oTyA==
X-Gm-Message-State: AOJu0YwzVbYKDcRxDPWKMF7MBpEUktsygpn7nWJ0HCBZz/8JKWLRPVH1
	3Xl+761o23UqBl9ki8IwghJMETMl8GXKzeiE7u8fpe582BPVqA3M16gz5lriFELEcIM=
X-Gm-Gg: ASbGnctbGLqaZWcvihECnkkmzs7zuFrTu5gBJUHZeK5X6gyZf5ndrtzFD2vzj1Mg6+d
	QYnjaHBX9jETqBI+ZoI5h2SH+WcvYVuEcWXjuq0bqkkICfEjUqWRGSvOBxkaMzSYN34lzeXgP1w
	mgMiLsuXwJeHfkOxteZcQ3j17QCgVd2eZYGqY04pXaLFR5p+ewuhfNmdTHydjooYiYLU4Mb/77x
	RNGq97HR3MZ0uU0OoVnTMQMa3G7HMMU7GNYuXKaa4fZvhzK2vqR4UzzJjBBW6arDPMa7Y62pxxH
	3nxbm/LAt7m3vio2ZWRGNvBqUOS7m5IUJ/ic9CN1d9BVqOx/GrbuxIb+WXmFD0C3bw6PZYj+hmb
	YlmuewKSJybmxH2WjGa3PuiMOQWA=
X-Google-Smtp-Source: AGHT+IGqggS7ImmH+ozn+4pHmV0yVb9SKPD6zm7ihmdJjtBN01yI79Prlbl7ZlaGcmfJAzqIX3im4Q==
X-Received: by 2002:a05:6871:114:b0:314:b6a6:688a with SMTP id 586e51a60fabf-319633cba8bmr10194612fac.42.1757095966053;
        Fri, 05 Sep 2025 11:12:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 13:11:56 -0500
Subject: [PATCH 1/6] iio: adc: ad7124: use clamp()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-1-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=aRfBzEhu9pJri4r6TxRz2ZjFBxLSwzNywqlNQlQhkbQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouyf04cLLwK890vtIhWNBsqRs22IatbAYDNJzJ
 HFtVhBFMRuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLsn9AAKCRDCzCAB/wGP
 wKnECACA92Gh+z/nR0gemOyoVcCM6t20IP9jDEYOOkB9GQPL1fabyAMAaqJ/xrkFeu2p0cu6a8i
 XRZYrIo54EAEz5+NFyt+wGuXyLzgqmsu4ZGIuEpUV+hBtJ5kjEwf0GGejP2lWP9BqzjmrlLe1Ug
 bW91kC3W3RS8/PwSnvM317o2+zzBDVzjcG7UdMjnTVbCBdDho1WGNnQ9HRsYV7ByBRkP5LmjnpP
 zNj7ZWgkU7pNMquiBQvv36aAVDZIktYC0m1O/5UqMhhqGLzShDmc82kbkto7g8DJA//ZYcqFzXf
 IkZZ6aOr+734VbjI6TM9CJY6/Sh8K9B+iMfl/A6wLHdI2d7C
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use clamp() instead of open-coding clamping.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 70f458e3ccc12db884dda9003abcffdf48989e5e..117777fc8ad05b773da09c113cf84927c75d6b7b 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -301,11 +302,7 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 	 * FS[10:0] can have a value from 1 to 2047
 	 */
 	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
-	if (odr_sel_bits < 1)
-		odr_sel_bits = 1;
-	else if (odr_sel_bits > 2047)
-		odr_sel_bits = 2047;
+	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, 2047);
 
 	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
 		st->channels[channel].cfg.live = false;

-- 
2.43.0


