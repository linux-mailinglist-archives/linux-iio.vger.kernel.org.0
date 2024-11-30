Return-Path: <linux-iio+bounces-12842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C19DEDD0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 01:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C94B22626
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33B78C76;
	Sat, 30 Nov 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRWzOmK5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8A70815;
	Sat, 30 Nov 2024 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926452; cv=none; b=Ib8+meh8qlOtIwgsbfARSQ8koAvqFDSJ6VVHXWwSJ2J/rezHm4tDmKQaDxgSPKBLsXBsmTXSK22m9OJdtzzzGwqxDK01jKn+dp78JrzYE+/KXFeDoEUPo1TJRgIOkSiIlDqHKMuYp6Vb55/00oEsfFLufXK+pH7rgPo3uU1GILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926452; c=relaxed/simple;
	bh=iK9SpgFGEwbDnkbJKJAu0EMEWhwPxUHiWV6sBfC7nAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+sbRHbRpsuoDxuPon/Hr5skt90qFz7XLdXL7SNLYot9Fe9XQsrf9G8cRkPMErXZFay7+XPSMXNW8oZ28o563+Mt2C2RqX+6im+md0m7jkUGdQ5SToV/GaTpdwRvmt9CGXozdSSTPv3Xa2h3wZGdeZE00Sgu+IXaipP6nd4N4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRWzOmK5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e27c75f4so245945f8f.2;
        Fri, 29 Nov 2024 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732926449; x=1733531249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x5HbkMUGVcybCzCkxnY7lPZTEVlJ6/80ReGefbDjA8=;
        b=eRWzOmK5ffblWxnNrU3uCP41vx6ekcNOvhugyJiXLA/3tx3I57MY5wTo1LAI2yQKkF
         DLqAE4YQMDyllOz67dA3nwIkhXDQ/1SbWw2PoDjYlTyE4ELfmnIRyiWjfXPAHWor6FOl
         d/PbCip5c+Vi33E/fSzasRznVMgwrzOe0rFhKUFllfvmlBgQGgLovKtdi+dv5cAHm6s7
         BwpojgHnB2+V8+M6aphA+Pq1DDmUHRSL0tTfwBnAbfYZbgbqUTP4PtRGHPst8H84GVDW
         E/Ks77e9NG3c/5FTlWtNdnHTfZyCh/5OtIxePmz2xaHLkOZeX9+bY7MzGpUv0qXkLAL5
         8uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926449; x=1733531249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x5HbkMUGVcybCzCkxnY7lPZTEVlJ6/80ReGefbDjA8=;
        b=FJHLW0zTmlqY/Gnr52u/1U/V9CCBBeNM1YZEXMjYbL57NkG8YzeG+cM7ve6seGGAGr
         J795UAFxJNqh1iCLpO1FlINCaYZFsX9MOcnBxL5dTJBA84wfvi5hk1hsAJBIhhilM/Sm
         Lyit+nAeQx09FFujj47HDGQ4Lh9h0wy+zj/r7QGakSfBe3SO0V/ic5hkuFSTOgBlsJKw
         ve+o+ARusCQbjzRr2JzsDRyykuGCFnagi8IyLvA7IPGsPq/n4k+Pr+wXxJaBkrdIonYq
         F5/Idb64SnrMgUTbZU9F9cpVWrmbEvUDKjyC7raBBWDL6NsW9YlwUtUkUDgI5jGzu8zt
         WFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB5O/gCjx0Lcdn7kGD1aFo9+WI7ysgOf8rWwv602P/6DBkvb+2HSrFZsJ3swbQzJfftxiD3CEuSyUuVprd@vger.kernel.org, AJvYcCWdf5w3AIZCjFZzIO+cYSkwawMd/ozS5TPaqFbiiNli8Sr4UXCKHfqQ8rGN6KxHqJ+QzME5l4u6iHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQREbeDFcvyBymRl5yH+hDTYKf7IAlcwvRGOfWsFceqiwcoGaD
	0uyJ7oA554IMmckpnsEmgAOLD0vEb2jzP3OJHJwzzcfV2AjOQnPY
X-Gm-Gg: ASbGnctXZNyT8HxFBtPE8qd+D+Clv1I2n3tWht91jWQLInEvzepo3cwFNdaX0RKFM8Y
	VgtkzFec9kNdJ2MWUuIfgyyjomlMsU5r5vazWGJ+Z/OLvpsnfYQwsEnwUeNl381UYl9hVopJ7J+
	yaOsH136W5aa0OwoK1OZWhroh8jkIBLyQtFinbCCMh2omLi7QjNEgNUCo5IhG13uAsBezUHmQe3
	J9ys5tL+SNxJd+I1Nr6u1w05jvoREG+Kh2wJRj9Cum39/+tH+H0VeFyEUKrBQ==
X-Google-Smtp-Source: AGHT+IGsSVbsdXgTAQ/VfQnr8ARrP0EQ5AOfBluWjl/TLhz1ETPPJfSn6R9NkBoPgog1k8Q6GU8CBg==
X-Received: by 2002:a5d:5888:0:b0:381:f5c3:1d02 with SMTP id ffacd0b85a97d-385c6edb219mr11696070f8f.44.1732926449198;
        Fri, 29 Nov 2024 16:27:29 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm5873345f8f.7.2024.11.29.16.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:27:28 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH RFC 3/6] iio: adc: dln2-adc: make use of iio_is_soft_ts_enabled()
Date: Sat, 30 Nov 2024 01:27:07 +0100
Message-ID: <20241130002710.18615-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241130002710.18615-1-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the iio_is_soft_ts_enabled() accessor to access the value of the
scan_timestamp. This way, it can be marked as __private when there
are no direct accessors of it.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/adc/dln2-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 30328626d9be..f9cf132c41e6 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -128,7 +128,7 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
 		in_loc += 2;
 	}
 
-	if (indio_dev->scan_timestamp) {
+	if (iio_is_soft_ts_enabled(indio_dev)) {
 		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
 
 		dln2->ts_pad_offset = out_loc;
-- 
2.43.0


