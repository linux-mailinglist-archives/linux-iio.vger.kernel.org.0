Return-Path: <linux-iio+bounces-27839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D68D274FD
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 19:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BD2A31A6FB7
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178953D5D8D;
	Thu, 15 Jan 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2HZKIMeY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD683BFE42
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499639; cv=none; b=F3ak3/R8Wxrpw91mxguvfKyD/1KlRmGt9kZQbjGLrlre0UqyKvd0DtkwSOsfGanzkpd9K9Lli2Zn8IdMSat5QAkyD3WlJnhM/2R7HfYuuI3TvH+09Ctx5u70zPuy/ZF+qjH+7YqiOW9RqimuU0QYT0moIEHUcUvzQGgs6KUVjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499639; c=relaxed/simple;
	bh=yyI20jVWNWTUy84I+ZyIFJqORDig0qSSVkjZPqANWQA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loiBytE/dPyW/6qflAlAL/E5NDm6v+d6azZCHiSV/06nuh1XhFTzvVW2loD/rblYQLI9rksGT+K9X22EzHlBzGZu84d1eymoJhNzDCbICSC7QSdIMPkkNUgyMUH5zvOYhDRwPieoa0mZnObg0mzhJfxpEQ6iR35b7wZcp40elPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2HZKIMeY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6536e4d25e1so1767060a12.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 09:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768499633; x=1769104433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myRiFWFQn6sexHXyaXh+8k7jGRQeuYgTjCHMW3qRIq4=;
        b=2HZKIMeYO/1IqRfNnkYCkejh4oo2odiJVGECHSNFwODxE/UEVM4Ko3zRLKm1N7vy5L
         Koh+z/oZwnL0yAnmooGB+hj+ZrfHXVmjQMYK8tImxb8mdnMVNb70eZIK+GW3NbBYrmlI
         +vi8wbWlj4Lzs/3JRZsVQqs5Yle0F5ziAaVo5kOKuNN3Job83Njo1G4pG/Wo0jNrWTqf
         T3IbzGu8sMvKvcTx+IsNWjGX1DPM9dBE45sewUCCh1clx4xMYTI4tW7trfMws1dLV4Z/
         ev10iA/MNuBmCYoHZBCwdXl2qk+0izsdbqoJ3yIgodZs8CgIz3tDOlWQsHIuPMTAq+Kc
         q+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499633; x=1769104433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=myRiFWFQn6sexHXyaXh+8k7jGRQeuYgTjCHMW3qRIq4=;
        b=X2YULSWRG//6v+oZPt9fZFk697mBfHwcGzgtid334J/BFJgINiMMt0FaDHyfYpCP+8
         On/7fVaT9kMRgUwXH1bxWqHG/40mvFNxbK2XGZ5e9LjbgYIdMe8omh3oERtPTwSYEZCg
         34fP1EPPP9zVNw5kGbW+TeXwW6aDDqchz/WycvxOLN+JkUgEMJ5B57tOB+TkyX5BKj7g
         kslSPuRmMu0bD7mQ7Ne7/ufBReGpZ3ZVAhaeDUqOJhmA4vJhjvL4+s9hMPuWEq7FT651
         NhQcXWtA2n39yP70A+sBMOllMFNBRYZhiRroFTiDtqZSJSst7HPwuY+3E9ut++jfTv2S
         Ys1w==
X-Forwarded-Encrypted: i=1; AJvYcCVGnvE6F3Aek3bZj9c9hsprXE98SU1NVKRffOdbFvl7ywKn///IQi7WCTfr/2RFtLZo9R0fmhc/EUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhkluR3NYexLSNzSTnsz/IfQOlLVQ1cZs/g7/F1WEseufyR+Lb
	SFggLQUTPcacFM7L/iJeSSFFy4Mb2U9TK0Z3gn8TkN4Bl12KquOfjCJ64ulMX5W19Gw=
X-Gm-Gg: AY/fxX5jOApjtdQxV5yXxi8hjsCoHGqDmqHs97xmt8enCYXm8weYkPg+tMd4T9Fr5EU
	LtS68FK6s/7UZW75dJZHFdQ0XZCSYksDkrYvDonYDIG/xrL8SVzYkQyux0hZplKhxcsn9+vyp9V
	Y2E1IiaKr36KWRM6yh/gm1ciT2Ef9/Uex4Ql4hkuUwL3TQPN8ZLWruQFdujHw16EWVJJ/P5gmiV
	FZYhJIHM7fQOq+ofLO1z/Pi6J/vUwR5Y2CeoY86HH0aaeKHPRCjaiHdrSSEDWrtV+70FI9gAlrH
	qStOiCYZNIZg6ZqTP8Qw0BGFT/aImCImPBzuVQRWMXhyvagE+sP0JOpaGZLFHYN7XKz6wY8o06i
	KimbhOwwOzS5bxVUmZyIQH0UH4eOEgACPUsz/DCLRxWHv29FykDhO8GP8xBQGE75Hahk=
X-Received: by 2002:a05:6402:1446:b0:64d:88c:c2b7 with SMTP id 4fb4d7f45d1cf-654526c9031mr249087a12.14.1768499633459;
        Thu, 15 Jan 2026 09:53:53 -0800 (PST)
Received: from localhost ([151.43.128.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc45asm200999a12.21.2026.01.15.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:53:53 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: accel: adxl380: Store sampling frequency index in odr struct member
Date: Thu, 15 Jan 2026 18:53:48 +0100
Message-Id: <20260115175350.1045887-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260115175350.1045887-1-flavra@baylibre.com>
References: <20260115175350.1045887-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=flavra@baylibre.com; h=from:subject; bh=yyI20jVWNWTUy84I+ZyIFJqORDig0qSSVkjZPqANWQA=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaSmf4a/795W7rhjvH9CD+ZSoLIO4v3wGP6UBR xS+YsOn68uJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWkpnwAKCRDt8TtzzpQ2 X1kHC/4hZHw4/46splV9XSMPLjH/FkNrL7aOvSWFfIRnPoUp2vjL9uGGvAQG7rqnm7gfmx6/iNc vocR7TfMtHjIAHddT0kJMwAuU2KBsVly/fPtOVgy5carT0jJgnz/VaUJ/68IyuWrno2ROOHIeWR 549Ord0hMvLWqbbAlD4b7culRBDeFc6w8VI/aG3tEaDhLB12DUH/h6Vu+xgq0Uson5bXmIl5cae PnzhhwqNhBmr53E9puAF50bcRmtDIrJFFdiSK6nJHguNCbQqSFxhplYfJWuSqGRUordD6cDSDXN ytsvs1dt6nC5Jh+LQkl2eUN9vymzkcvfDWhSRv6nTcvJo0tfpQ+k4Vsunc2jNIXS9eFA1WRKrX2 q5F3EYHImSZADzM+9eI/jjtgzYSfbI2V4/lfET7adTiQkp7/k2u5/+DT08459+65pFwMFsb6J6g ljRSyV2f4ktEyd1LT0uiMb708JRjdN7+WFGIHiUtepfoeaIRLRg8bBJAabWVQ0TMw6y/M=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The ADXL380 driver assumes that acceleration samples are always retrieved
via the high-performance DSM signal path; as a result, the sampling
frequency value depends exclusively on the decimation filter settings in
the TRIG_CFG register.
In preparation for adding support for sampling frequency values that rely
on the low-power SAR signal path (on which the decimation filters are not
supported), use the (currently unused) 'odr' member of struct adxl380_state
to store the sampling frequency value, and when userspace requests the
current frequency value, retrieve it from the struct instead of calculating
it from the decimation filter settings.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/accel/adxl380.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index ce3643c5deb8..bbf1f88ca781 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -417,17 +417,7 @@ static int adxl380_read_chn(struct adxl380_state *st, u8 addr)
 
 static int adxl380_get_odr(struct adxl380_state *st, int *odr)
 {
-	int ret;
-	unsigned int trig_cfg, odr_idx;
-
-	ret = regmap_read(st->regmap, ADXL380_TRIG_CFG_REG, &trig_cfg);
-	if (ret)
-		return ret;
-
-	odr_idx = (FIELD_GET(ADXL380_TRIG_CFG_SINC_RATE_MSK, trig_cfg) << 1) |
-		  (FIELD_GET(ADXL380_TRIG_CFG_DEC_2X_MSK, trig_cfg) & 1);
-
-	*odr = st->chip_info->samp_freq_tbl[odr_idx];
+	*odr = st->chip_info->samp_freq_tbl[st->odr];
 
 	return 0;
 }
@@ -500,6 +490,7 @@ static int adxl380_set_odr(struct adxl380_state *st, u8 odr)
 	if (ret)
 		return ret;
 
+	st->odr = odr;
 	ret = adxl380_set_measure_en(st, true);
 	if (ret)
 		return ret;
-- 
2.39.5


