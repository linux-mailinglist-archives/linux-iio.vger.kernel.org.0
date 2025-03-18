Return-Path: <linux-iio+bounces-17045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD6A6800D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30351894599
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76820ADE6;
	Tue, 18 Mar 2025 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KmWkAcQ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B52066CF
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338339; cv=none; b=dfwvC7HX85zbgavsxtL5W5Q5p78gvDM36AKqPobASMjERHt3MRgVZcB89nZT9wW1PyoZNL/62YSi5lEKqz75bhgt2BdnaqnFrn2hoaf1r7oUyilNUlYnj5fyhQ9DSjIWnfLqzP1DqFnXBmCj01k222gZBmJGuR9bT+mw0JzscVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338339; c=relaxed/simple;
	bh=X98dmSEv6nyPPL/MZ8C5uSILXPlFcIN6I8wPX7J2RiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtvYXk57KxQaekVUAKBszpSt1AsEQCwMDZIPDC0ASW1u6+MZ6wtBzbVv2UxJfTtHUyvLJP+wCzVE7CPsWj7ObaU/Nwkjr5ydz/Ihf6INvN0CQV1M/mQNCGOa0T5/YbRjRlqLJ28LQTb4KbUmQnhsFOcGnekoqDRBpYxbP5SDeLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KmWkAcQ0; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72bc3987a05so78478a34.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338336; x=1742943136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJIlNfW4nypssk8mR15yEyt2R1u7i2DlqX+TWabZSgQ=;
        b=KmWkAcQ0Dhkmi66hCjFJESbBDEnPwBw7mPcl5dwLWgkWJZFmEV/joIuYT40o7yPMRJ
         gq06NKHMrL7gcakGQYSwGFALV5SgJ9jBnIP9cemsnfxpRweZwosQLFsk04sx8W075U5B
         LaNM162q8Brr7NS3DUevWSGlD/r/8IQWQH1gvsZwEBtof0qwXG85K+Flik4ED05jaQHT
         21/0X/ce5G+ArdV4x0zjIzDVw4IGuNvp/BHu1J5Gb8f/ydWvnEryCxNgqric/3xC3pW3
         eghh1X6jZQg1n63FgBXg7WqQuVH3pPjBPfkRuUte95NygSVoAqbUZ/fsi6og6XdBGIvj
         svjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338336; x=1742943136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJIlNfW4nypssk8mR15yEyt2R1u7i2DlqX+TWabZSgQ=;
        b=SGbeTBDnjn1vJiVnvr4+JrVY6k5b4NOJzwjxhd1CfIV+0fz84m1xVeHwGQPzZwtK4F
         00ITsUpmv5VLMnyxSK8XPMlIJ/2OLZojDxk5xDkemA1RXJ/ATvAjmFSmhJdP4Lpgaghk
         AvigRBuVIEnDUZvdtixueBhbtu+3SyJIUf0Uk8ZJufz+cSzxwk8DZrvZtUHsu/lgsaDS
         M4FUWRWkCI998QTT2qrFQ88SXa4gYa7VwKEg3Ub+yz1Nq+xM3DZa3G0WhmNPGAzuySNF
         KmatqRBvjoWjzy5W/jR8fea9aTfgY51UzSm9Css3E4uj5xTw+oAarqPZrlVEwErjgOdT
         JAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHIYcCshIb2DOb99WQ7ewB1Pg4W36s3SvGzXMrW23VMGrt1TQUT01aZ5EOApylM5mweZ5sPvu5U/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfU8wLN0e7R5+CdNDO5+cPAfPlMoh1zdkTrYSrcEwBtWwC5NF
	veA63B6Mv8t1D9E5efyyZZ7M1KyD2zv7WkB6V8mg+vD9CQjIRcyb4qZC0qsYtlM=
X-Gm-Gg: ASbGncspzgu3hfZSlERPrHQM0Muh9IJzKI+HSrYJFhU1M0ubpKVs37E0F7jbrx44Ajc
	BtleH5IqIqnqnW13c+v0ZITYfPZPWBULhl9njStufayRdFTHTYULVL2S03klgYBphkyOCg0n8z2
	repfQ7Ncj6Xol8UWt1p3TKWAr3v1FoI+Xih2uodddQSJSTI/VBc0W9HDQfFlz8/7okRltLU8aXP
	xFxDCrkseo7H+ESVrn6OXjYPDIfxxf3ZWtX+01PYqKHGDQBbmKl6DM5/Db4dayo/V6xFYXD7R27
	EW+i3uiqQDxYZ4aY/FXHmLhL9DEGqDgmYVWqkj7UOqu1XK/QZvPVLfJWJ7FNUmaSEhtHoJEXCFT
	R
X-Google-Smtp-Source: AGHT+IHyBSE7aQkFAESKJ5WO4Y1YIAnYZVe7AY2lZBH6VHfOdLdnJE1ZI4TyWt0SnbNjMJZWPZEeAA==
X-Received: by 2002:a05:6830:3c10:b0:727:3587:fd1 with SMTP id 46e09a7af769-72bfc0decebmr316162a34.3.1742338336082;
        Tue, 18 Mar 2025 15:52:16 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:09 -0500
Subject: [PATCH v2 01/10] iio: adc: ad7606: check for NULL before calling
 sw_mode_config()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-1-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=X98dmSEv6nyPPL/MZ8C5uSILXPlFcIN6I8wPX7J2RiI=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkcq+owq2DWioHRX9mFfda3N8Z9nZD6A1J2D
 yHxaowpfP+JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANJHxAAvQR8EsGdrcFpP4Ksusr6GUKGSEfPp3EyQOFTGnG
 PlBXZJ4E8mB3H8lACeij3nPZ/2T8bfjCTmFTODH//7O1U27dLkqDmXLErJVZDUYBXO0hJzZdBOy
 04eC5H7GjIh0WD2QyHhQo4LZfqckVOVqTnR+9zqJeHy5JrVDZnwXBqp+usvv3YG1yalKYnX9NzY
 u4GNzyjewuUwpFLEU6PU4b78Ixjyu+KqRlxdE/I0b+vclbwF59cncEG4tpCqBCx0H9ttMWUbnLI
 4WdYD1DKWTh7srnQSyvQAgKdLF2uDK6znZZn+INaFTRZgaT2Ds1nribHUl3bTFOMbmhzL36GhPG
 A//9KJiSC4+NCA9+Bix5olUNpubpvUY0OYCcSvB2kPdeo+hwoaUCbl6AAXnBIuYcB/yaUNv7nzc
 /SYwkX46PpQ5EzEIMjCDfUzPsvUlEolG3+Iru1IGkvUb35dPsn861fqV3kFYVmBaPeH6oCI+ox9
 nMNJ+UZxQd2Q87f18SqWBck4XLvTb3y0jYu9AYmFif49y7RscGl6e8K6nZqI+YRlHmGxR3WgV/I
 MyNnfepqWelJVsrmp/Q68kn9n1DOjoVclUYkHynGwJCO8/+n2CyWp4lyTMMLt+cp46M3/ydTtRo
 6pUL53nryia4VmnJrnhgF1oOO6uUHrSKQcDsZ0gs9+gQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Check that the sw_mode_config function pointer is not NULL before
calling it. Not all buses define this callback, which resulted in a NULL
pointer dereference.

Fixes: e571c1902116 ("iio: adc: ad7606: move scale_setup as function pointer on chip-info")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 1a314fddd7eb987b52016ce7242b446677f66427..703556eb7257ea0647135c4b268a8ead93115c6f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1236,9 +1236,11 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7616_write_scale_sw;
 	st->write_os = &ad7616_write_os_sw;
 
-	ret = st->bops->sw_mode_config(indio_dev);
-	if (ret)
-		return ret;
+	if (st->bops->sw_mode_config) {
+		ret = st->bops->sw_mode_config(indio_dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Activate Burst mode and SEQEN MODE */
 	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
@@ -1268,6 +1270,9 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7606_write_scale_sw;
 	st->write_os = &ad7606_write_os_sw;
 
+	if (!st->bops->sw_mode_config)
+		return 0;
+
 	return st->bops->sw_mode_config(indio_dev);
 }
 

-- 
2.43.0


