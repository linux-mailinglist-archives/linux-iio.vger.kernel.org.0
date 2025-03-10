Return-Path: <linux-iio+bounces-16707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB2A5A530
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C723C1891A0A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91451E0DDF;
	Mon, 10 Mar 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ogjHy6f7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1BE1DF972
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639396; cv=none; b=iUmjtxkrH4ohuUDouth5+CObCEb1Ts2gncdMv5EqvWaVAnSAehPVRyPJCwQeMATHoJWmHybuiW+ngsc+SSi9+XDjvZMV9/BqO0CMAfq81O2FJAELRteW6KvqENI5VRrZa81NyBv+ruqimvqGKqdBnDSOMLWL/hXGepoGcZ4pgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639396; c=relaxed/simple;
	bh=+TwVZuYTQ79b6GanjN1EGzCICapQzRmhbxGUNH4cu2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/gEiz2bt+lvP76SSYsdVdykzrcRa2p1II2c0D+1CqeRhxFBvXN0+Ut1/NTfWkQ0T5vn4+BtBbzWENj5su5AruUuAXgM7cJhTwLqXdSiBadG6eBoqzUVqemqSYnRzPNMEePrpb0BvUU9qaK3fTtTWWnX/X1fVJgJlu8UFRwqYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ogjHy6f7; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f682a2c3c8so2365887b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639393; x=1742244193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/i1+yoCcGTJxasoeXpfqdr+aTaqF2C4mUZj0mRPSSrE=;
        b=ogjHy6f76y//+fUvR1oAMBdS1vmIRIcT4n99bWIGJXvQCc1Eku4DWaKybQeGj9R4Z9
         Kerva0ioQI5XowMFk4hu9pEGcg4PCGtk3riEXP3/oiIr2P/9ZVS0XlTE8vmlUF6Wz57s
         i4F5RF8VES7stnPQ6cRsTRIqLMfVcIg+6fDa8nm0ozITEEdPsvLfFvfDlgrhKX+ADVnr
         48qRB8ssMCEV8P/9RvLghST2qQOkoC+ZY3NJF4V7fmqSyy0F2X5pZ1pybjSWQaiE/CGF
         JqmqUUd9lKSnD7wUWfAzeVJCpZAdXFrp2PomCDxMe36JJOMAiyF2eP9jONbv4TcVQK0k
         NZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639393; x=1742244193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i1+yoCcGTJxasoeXpfqdr+aTaqF2C4mUZj0mRPSSrE=;
        b=wBv1SCmaBiRaTe3FDb53Y3qQ+exUxZTi/66otJX9zxrU/3P6wRMgjrLnpdXsOm60fX
         X4hIKvIIoOWsKBp/48RuzQE13ZDl4hapqfDwyWjPMBpOedlvQx9HfF7mV6pRBXDpgXmX
         iW8eJt5p8HmY+tpMXq28cVFp41AS95Ho1NTuKmiTz6UzKDt04uHTvEoQntGTHkCm5oH2
         g/7MUuErP7Hz0hs0qQgbwEFcJ/BW80r2A6+bq1HaHl7eGVVkgEa58Tm43P3cJPa/DoWJ
         S4aZxu9WRptlVZq7jemJQTxCtXFvvUzzUfgvL33TMpkXAGSP5N8QSmGZnJacqhDEJLx+
         Lbcw==
X-Gm-Message-State: AOJu0YyNQK29nuTL+zCdSQhhI4ZLFPa9mXcNmeaHfWxDyXIMDAPE+/bv
	aAX2qy1HtkZIoVQGi8G4Um0hGXUzdZdLeFocfIBeh8IoAkx/ZHdTYlGpLQafGUo=
X-Gm-Gg: ASbGncsYoBn3qTTIcRRCaG0BX2M5E/MGNQHNMCEkRWjFnaOJ8+IFjErx7o0I91fa/fV
	cCwrs29aiAcUbnOzgKw4psorjCnEjB45MX4xKw2wBYQJoOBhI0YDyuSP6bvnGDbvkqSt88ODfqv
	q/7MHTd6obOrJohW6gwXGwl0QhBdICOnGSXSFapMPbhCdytZ65rHBwligTGTYHbr2VbB58CMEzr
	mNq+6UeQS+lXvxeR2k+tOVluc9pJDQbwn1KjzlxrkFSr0sdZ2dFVoFoKz53JKwG4BPfLJLQIUBQ
	icXG6cncNIOqm0VVZGg+STg5AqKzetpvacBn2dP7UpRJGLfLorIkdtQRsqnTXIl65CYlUGxC32a
	x6kFmttdYpJs=
X-Google-Smtp-Source: AGHT+IHBMhf/BYV0XxOJGMPZZruARQUkU+s6sttBVMMSnUfo+mtwN1idPSs1v7/aEHUiuzefAJwfrA==
X-Received: by 2002:a05:6808:1b27:b0:3f6:6b64:665f with SMTP id 5614622812f47-3f697bb581bmr7694565b6e.27.1741639393469;
        Mon, 10 Mar 2025 13:43:13 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Mar 2025 15:43:05 -0500
Subject: [PATCH 2/5] iio: adc: ad4030: remove some duplicate code
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-2-589e4ebd9711@baylibre.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Remove some duplicate code in the ad4030_get_chan_scale() function by
simplifying the if statement.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index af7a817e8273496e8856a5ba1a9c2e66a11f0a84..f24b46164a477f9b6b5c93ffeba0a335f7b3de5a 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -394,14 +394,13 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
-	if (chan->differential) {
+	if (chan->differential)
 		*val = (st->vref_uv * 2) / MILLI;
-		*val2 = scan_type->realbits;
-		return IIO_VAL_FRACTIONAL_LOG2;
-	}
+	else
+		*val = st->vref_uv / MILLI;
 
-	*val = st->vref_uv / MILLI;
 	*val2 = scan_type->realbits;
+
 	return IIO_VAL_FRACTIONAL_LOG2;
 }
 

-- 
2.43.0


