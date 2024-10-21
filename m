Return-Path: <linux-iio+bounces-10894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6069A9040
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F631F2361A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB091CCB3F;
	Mon, 21 Oct 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUIyDxVC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A91E0DF9;
	Mon, 21 Oct 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540409; cv=none; b=dcJewuUuss92t93mR4cMkr+53gvkj/o5A05pc8s0UTCytnnu5HwFO3nNZgWi3UwwcH7pf5zM/2Jnxp1+YKyWi8mblo2PL7x0eaxGep/9TF6ADekwmnZz4TQMNtpHF0lYTavel9z7ImdoRqMMRUpMpWBsIlUZ3QyhZdCU6aoGP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540409; c=relaxed/simple;
	bh=ZxpP7aJwaJLHATVot1wu9EBhCXPJL7g2dbLyHzIBc7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGbCGeISe82MoWg3AxAa7jQuLo3hzZ2/hQ1k4kmnfJ0kVgaGuhhQ7uY2PZiiciI0tprJExqZ7otyOUA7g77wwoTx64PI65hQqPUAqsq+Z6naTOH/OEz+JdJp6iGaTOkBmbOSBL0rs3roLcd/o8bfdi9/bbjgyLQxwmIEvxkG+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUIyDxVC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso263368a12.1;
        Mon, 21 Oct 2024 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540405; x=1730145205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gGP7bFWIQ4JodD++nMtz1bBbN0FE4q51Iek/goH/Gw=;
        b=MUIyDxVCh9LvlD4BTbstvUn8TIPPOtVFpLI0/bPBFpacqODi6Z3uoPU09F1NUKi+2q
         GlFPHx0KvINPi/rhGHBcCG1fitALNExiqfLlQrowx4IPBG5eCDXewzBXQKyD4XufNUH8
         yRIODARzVEIMdj9x85M4Rbm8Hnfq7Vqs9FWpHtAcC+engcJ3x7YH2fjl+JxzMMkgR1rk
         WVNuaurx59JRvwzBDlzJ3p27ipRP4nEl16sssxhyHW0f1TlkUwkYejUjOctRmWPeeqN6
         lr6pUWcJlNPkRaYwArpDLQ8MASk8eZ/5AjZvIyg1R0cJfUjFnSU1+WZxGFlnZvpyogkh
         72iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540405; x=1730145205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gGP7bFWIQ4JodD++nMtz1bBbN0FE4q51Iek/goH/Gw=;
        b=s6g7KpIgLWWyiFrXOi5iGXu2IavDmST0EUl0LHWiIsTHhIZBrSr8sZDssfe9UOWwaL
         vZEn+CqYQpmpLNYLn0VKGdU0M+QGkYkrnGFALTrT4FJDT2236Gu62qxSsNioXiJtE5AE
         mPJc0TcoZl729f8UH/IvdrW63K/U19kpCrOVhdIin2M2zetI90aL5rLkFelDNJuMes2H
         LNwjh9h5CIzwI9fLwzxNPOFtlDx0QhgV/RgoBK6mqx+YPWluOHXTxJoP8D8wYdQigwAd
         Plyl1w6u3PHlELKQiEi3TKeVNjwB4oFnaBuC9B/vxeHPoy+ARpyTtBy6QlF58wZnHVmI
         giSw==
X-Forwarded-Encrypted: i=1; AJvYcCUNJExXtrur7Q1bT7WaG6ZCAW04rolY4QtGVxvPFB+WvuRvTYTi6PzORe8j2RDMdG8FRegWhbx+oW9V@vger.kernel.org, AJvYcCVE4WIu3PlqAZ1MR3KNpSFCuW2FcUEady6xhlvuQyZxpUsFT0ir2566b2EfTc1A+nmXg+zofpciIJgm@vger.kernel.org, AJvYcCWZmO0Q/TU7O1HjqMKe9H0nPCxXWuAn/3HTfzWTim6WN9Z5Hzfg+sEqRTjE8hzj0uqrNn3AgsYhKTKWf6CD@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzEF2erjnCy7jmpkZ8yN2xR9AB9BD6a7n7863zFNbjfm5DLRP
	wv3h5Ixu49OxhiMsNmbDMri/CPfRtUslO2hwQ8UTtA73xA8jlCzr
X-Google-Smtp-Source: AGHT+IEOLHrwWtlApmwLQ+Se615asrYaJdL1yL//ZCA6cK6yt8cbuWqIVJw4MyA3nNKVYTXVq+MeRg==
X-Received: by 2002:a05:6402:2808:b0:5c9:1cdf:bbae with SMTP id 4fb4d7f45d1cf-5cb79479ee0mr790864a12.11.1729540405150;
        Mon, 21 Oct 2024 12:53:25 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] iio: chemical: bme680: optimize startup time
Date: Mon, 21 Oct 2024 21:53:05 +0200
Message-ID: <20241021195316.58911-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to datasheet's Section 1.1, Table 1, the startup time for the
device is 2ms and not 5ms.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index dc9ff477da34..f5be4516dde7 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -65,7 +65,8 @@
 
 #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
 
-#define BME680_STARTUP_TIME_US			5000
+/* Datasheet Section 1.1, Table 1 */
+#define BME680_STARTUP_TIME_US			2000
 
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
-- 
2.43.0


