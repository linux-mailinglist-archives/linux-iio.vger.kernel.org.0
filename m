Return-Path: <linux-iio+bounces-27505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4FCFAF3C
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 21:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E14B3027A53
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3033B6EF;
	Tue,  6 Jan 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Er+Ha+Tl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01460346796
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728195; cv=none; b=dOBXIIwSGNc5BiipZUPnUCKgY1tFbgSmzQeZv8polr3Yn6AtsygSfxQmlvQIJbGG6IFgychmmaExbg815smLwsatl/c7IKaGWBz9MBKcVy9ejn2cJxQcWlDwREJD/sia6LVET7eWRG6XJkTwEdeltcFx68YVycx6xA2MpXCe558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728195; c=relaxed/simple;
	bh=Hv+4Td7imHc66YvbfhKCd05nmjS6AFCfOJi3FGBPJHk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cV2XNuZVs/pno7Bl8ua8KW99GEBv9LgeuPoHSJ+h8dNXtOr3q7IscocnrxhzHNG7dtR5x3Sq5TUop5KLjJ1aQOr0F/wsaBMV7oEeXF6nEu0jgokjc9ugKC2MC38YQizcSFkzexGMeVEb5mZdB2frdJrN3okdg4xhdsZyucIO84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Er+Ha+Tl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324054so241013966b.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767728191; x=1768332991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIsy4zlRCSb3g+IcnxxPTLfEgVdaWceO+4E7k1hxNNo=;
        b=Er+Ha+Tlojob9s9XC5br9NWpvRdnk2YnuwWg1t9KDOpOrudDEELpMgQk5vgdGLQ71U
         aIYzfREKIvnDkElHraFxfpiC2MZED1379NGYJEaTN1SWLGdsy+GQXEoFM45N6QheGpS7
         mhqDrtCw2dcqb+2Z3p5WP+QJc4Ca8d0NT8OO7JaF4wkjJJM3XAtQnmdCv2pMtluBv/mf
         XAzS02/MMmLwWUiZ6qtdCvTzQroxRO5A7kYo+S7kwQg3xyqG24kSie0nQPwIcGZ4XfdA
         +7N66fH8OVgCZuQgi6qX55nXmPdHr0fxgXCQ0B3W2DS5Nl72CHnslXBUV+XGpPrdUPTX
         rUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728191; x=1768332991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fIsy4zlRCSb3g+IcnxxPTLfEgVdaWceO+4E7k1hxNNo=;
        b=iCsl4pNNt15BKOx5AR8GhNelY6HDx9e0bDeJWWgd+5qFC2O1SON5i48XoLwH/dSowi
         q0/vzFc7T+NVhMeD95dtQj03JDycVm/vaa/kahvDmDulZa8MMMKnCVsaSO89FlW4NbP+
         II+wMIh8zOEHvodD9+TovUcl3r+5jpj+j8SvYXzM/Dt8VfksKQuRUN0pvFtLX/lA4uJE
         cCA9mU+QI4Fg1WSkWVJgJ/uJ9aXybB1vna2AjkK3c7NDTmRLTJ6QZtG5cJ7xBBdC9tO5
         oF9lh4qpTm3qtXuSkmAwGP+MhFmpKwdegvToP3OMumdcilB5iiPq8EkIz7KdItPUiI+7
         4d4w==
X-Forwarded-Encrypted: i=1; AJvYcCVuR0cBjEgmU8TjI+FSX59vghnCO4vlLAiliKn8RT1veFCDhv7VQYqSJcALZU1Yrh2COm861K2NQhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwawwdHJ5aGoyM2wqQcDpaJX9H+tdh2+Kk+bc2J/H6wEWUvbOUk
	Wys23vThvxqt7ONpSrWJPYRGa0zBogGpCGVuD4GK/dtfkr81vUkxWg48gCJA9muWO4g=
X-Gm-Gg: AY/fxX69BC9EcF+7NJFaIWVuwcDF6stylwebIaLJQk+++E8F6HVCCWHKPbY8VWVFJqJ
	s4BN2gZ9vBGzHdC9I1GB3K1kaPXxTXcrhrgTt6WBZjV/3LHhIt3AgU2eG9xIJ1oy/QWcykAV31L
	nSq5tD0Wwf+ozgAytLyVmW3Qht7koNv5QRjvCSWUdEVZYy6qd+uJxPKcaEhBYf1A+9WCXjNzK7f
	oxZGLDThpr/BrelHJe7iWhK+62nud894dVVBJVu8wMn7kn/9EhtsDrY+IVPA/2XhBuId5h1lUlE
	g61eCTn25lziom/RM8g/vXMkyF8aOfPEsMwKwl6RC1uZBj+d0WLyDwPrI9qpVQa/rb2QNbqWW9o
	VOxdMeTrAbZjMI/VZA7eqvm73Q3qzaW9D1NiZsOAX9BXkFXDSOLvnD+yst8m4Ozql+ggK0woccH
	AVPyNppPTuyskbFGIC3ItKAeUo9iGDh7eDdn6B16kh0w==
X-Google-Smtp-Source: AGHT+IGHslxzKv8h3YydnagEsr9OTmsVNjwXar8tIg+Hw3tJSVZ8OjYLZtqr3XlA6LOtw/xV5bqxKw==
X-Received: by 2002:a17:907:6e93:b0:b83:ee0d:e03d with SMTP id a640c23a62f3a-b84451bd516mr21119266b.19.1767728191386;
        Tue, 06 Jan 2026 11:36:31 -0800 (PST)
Received: from localhost (mob-176-245-131-134.net.vodafone.it. [176.245.131.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe60sm295763366b.45.2026.01.06.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:36:31 -0800 (PST)
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
Subject: [PATCH 2/2] iio: accel: adxl380: Optimize reading of FIFO entries in interrupt handler
Date: Tue,  6 Jan 2026 20:36:27 +0100
Message-Id: <20260106193627.3989930-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260106193627.3989930-1-flavra@baylibre.com>
References: <20260106193627.3989930-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=flavra@baylibre.com; h=from:subject; bh=Hv+4Td7imHc66YvbfhKCd05nmjS6AFCfOJi3FGBPJHk=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpXWPSYNm/sCZ9PlbzOgzKR/J/Va7BlVRGafiJd saURpEKC3SJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaV1j0gAKCRDt8TtzzpQ2 XxlPDACiqss/sHDs48h4kpmUERyNxijtJvnCjBHO33SfXSAs7jjEWrMrKHS9ITWFXoZJjGOI4AG sVALL9CguQQfN2MGEM/TgU0zl9stW2EYuQtzRW/pOVZQMFe4YKciuOFApFT0GEgZ0OjE1Qh393c bryd6QLemeKFUEr+EF0Jm1k1vBerexWSyO3wBEdUPVpAYUuXgInt7wlOPJxLQyhtsrkJSVW/qGm bN4NDm8c8kgAVcQnXTB1rSy5XNBsV+namcukcFp/GXniX0XGJPj2wa2yI+K5p4eKMXIVneVDVSn ot2zTckodOO/PYvhMwIMz+UwpVRhc8xHvA4FSf1Cc9QSe78AhciT602i2JYN4pqCsrqJxkphR90 5xbb75uGInjlSsW+6kv7bnBJB56zol1s3mqNH8sdT7g2NekHAkC5Xqf5vcFs9NpgLY2qaDQjTOC RkgQxQq2uFySwfhTvoNhGZOB6ufhw5MaS8d4lv2nUqarFlWMBrJrASUZ8ciRcPtuhUcnY=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In order to minimize the time required for transferring FIFO data from the
sensor to the host machine, perform the read from the FIFO in a single call
to regmap_bulk_read().
This allows reading acceleration data for all 3 axes at 16 kHz
sampling frequency using a 1MHz I2C bus frequency.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 9f6c0e02575a..ce3643c5deb8 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -950,14 +950,12 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 		return IRQ_HANDLED;
 
 	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
-	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
-		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
-					&st->fifo_buf[i],
-					2 * st->fifo_set_size);
-		if (ret)
-			return IRQ_HANDLED;
+	ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
+				&st->fifo_buf, 2 * fifo_entries);
+	if (ret)
+		return IRQ_HANDLED;
+	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
 		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
-	}
 
 	return IRQ_HANDLED;
 }
-- 
2.39.5


