Return-Path: <linux-iio+bounces-27506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36ACFAF12
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 21:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A321A3079E8B
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138E33E377;
	Tue,  6 Jan 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Oq1kLvlJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC786345CA5
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728195; cv=none; b=PQjTB0ShIHDbGJwZD1rl9sBXurnyvhjMJ71A6AUDnjwQd2DruT/1RkGOSI+LzPS4PkybRS2lyfzK0J6YQ5ext7b9aV/KFM0eMsFv8wNzkLkqy1zD/gFnWLYFam1vgfTX7qmU8vSbUU+IcGvgUG1/l9bh+WVSTgO9ki05DjrFExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728195; c=relaxed/simple;
	bh=WaRLC/LKB8KfQ8m6QmS1keARdD2yuloMro4ENkodzwI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELs4qYVjuuZ1Ds+XUHEbhnsW3ZcVwLuIRxcIzNQgtjKMfPOKmMAKi24meVuN4fZ2uz3NEq7jw7YbKy1LWQ52R88nMvNBdzutdX7adu1DOhMBoHuFw/P43CUVDQXqVkGvXooeDbt6/TzSgggiG5qwuhXmy4ELQqLSZARLwgwi6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Oq1kLvlJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so2119406a12.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767728190; x=1768332990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bb+Tlc3jb7LZ1pkOWndTPOI/2IP/EUewgrKRR5gtT2U=;
        b=Oq1kLvlJSwks3x2Q0qVc9jsdqgYwpObnY+cv4FeNvyNrczyOMIHaZe3wt8LdP+pfrA
         H9FU8jx1Xl3HMNplQwx92LbkNi961Bd+NEbU3Saai0xutt9iSRDGeJp3TRbAsrYNwH5x
         8DPEIcm0qMtnlj8D9TjceN4aDGd0hgVu2Cjz88UkupmyGfWLn5sIWnmHTdbTTT+Iiacm
         ko6A780elkj6lWFQIsdLL+m8F/yDQHi57KXK7oodTqyQYXV+qTYq1Q71ZNXPDliPWLf/
         GTB73NRUFhVU78pHRz77d+X4XzHHJeB4Ax2V8oIE2DsQcGiexM9KiE7fzJa3bordiNGg
         ePVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728190; x=1768332990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bb+Tlc3jb7LZ1pkOWndTPOI/2IP/EUewgrKRR5gtT2U=;
        b=nN35jj86vyjNAmwgGKM1cUQe6h8B/qxZOEVG96DzAYl4oGXHg7ctln+sQIqnc1g4oC
         exckZvKmRZXw/miYFa5V22Ar6DFepv4mcC729MHKNO5k3ufmUF6rl3J25+R4c+ykP0wn
         DgLAh5ULm7imnsmBdku9WWrlmm+s7eT8XLVJQ0vIjMT1qZjcNGysXJ+hkoIGU/tVhho/
         SAEc6VEehfHRDvAq32HYlnAluv+lQsWH3AaSSeTJoAUFtLxIM7lLt0St8w6aNCTBExzZ
         ncVyrkzYQZXzkCEmH1YRhV1VMeytnrXhXXgd3hsCMrfuK3y34nwXdkk06soK72oA3vwl
         zZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6LcRvhIQfex5fRpEEz62rU2Y7q4r64d/8bY9Mgy7EKJKJMl+5kBCjUn0/vSmM7vxWMrcyKWBBMBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSIfP8W54crCi3oXmyM+24NzFSa5u3p5OLJ8nVpqVJYJpqzeT
	HUe6AUz09dSSqqUIuAKcEBPrAkkJMEuvLYJKNJ54jhzPaWRIMAXwp18KJZZWDFQyT08=
X-Gm-Gg: AY/fxX5xefpzY2yVZjbiKNKnusfBjLOfyIxBQZ7/90i0PDfg8LqEWoP7XM/nI2+jdDR
	zO2zTp8IuTnFIZf9twyoKcohE8eA30ydVLqCijiQWEFyXmxIZfOrnvTZyY5EZ+aLEZWrBC0jWtu
	Cf4yT4rnM+VA7uxcQePU4DVwGcnyeHBezMe0/GXL67ZxxWt9Qbm1P1uja9XDHwQLi75JIXe0aCD
	TsGIMFr1r6waTsCrLhY7ZY2Wxnj8WR/Z8EnTBAtjEqHRMInqyljGDmb3oQ2kIoyemLZ+9U2Rx2d
	RLPztAuFoO7iC+8nKHvoyRDKg7FLLnhrTo7Df+pxp8pgONnIsCUIssFUwWioNnLXtEUhjjNfxLt
	6FF1TUf4WO/nQ4TbJ72dLPxMxnC/Lokp9Q61vMe6qzmeHLKojXecZzWI+HTRAlM0M6HCZq31e2A
	Sn+euHRunvVi2QadnyV0mPPBEKfW7pkPeLEjOAdLUQSA==
X-Google-Smtp-Source: AGHT+IGCYGZv1+EuEqiTmc9CY6BlIdxkQvrXOvTZ/kOF9KR7ymxOR0EpQj/kfGXBdvzSr9jogyN5pg==
X-Received: by 2002:a17:906:4fd1:b0:b76:63b8:7394 with SMTP id a640c23a62f3a-b8444fd4e55mr25601166b.51.1767728190318;
        Tue, 06 Jan 2026 11:36:30 -0800 (PST)
Received: from localhost (mob-176-245-131-134.net.vodafone.it. [176.245.131.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm305666066b.66.2026.01.06.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:36:30 -0800 (PST)
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
Subject: [PATCH 1/2] iio: accel: adxl380: Avoid reading more entries than present in FIFO
Date: Tue,  6 Jan 2026 20:36:26 +0100
Message-Id: <20260106193627.3989930-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260106193627.3989930-1-flavra@baylibre.com>
References: <20260106193627.3989930-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=flavra@baylibre.com; h=from:subject; bh=WaRLC/LKB8KfQ8m6QmS1keARdD2yuloMro4ENkodzwI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpXWPR2hQ3ON2IvPxHXv6h78kYLyQPz2AuvKbM+ x9+Rhi/CVaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaV1j0QAKCRDt8TtzzpQ2 XzK+C/4uJuTc7ynmXkN/n+yWO4184teeKdM8kPe//wSUfqaqsl/JcxuVV89hTO9+YwUoDCmitk6 ABIxy4laLeKzZDmS/1iZHWllLh6rjRXelfuoW6rY3n6BK413id5Zi33EFTWBYB1PwWImlRaupql BnZa6o/V475sBUtIR+ClDIdL+SEgtXrHvAWgxUQzBjbA8m6q7kUYpsz9lktLDX6i39y9LYgD0HJ wxrGA4AnrRxls5tfSAorM//EJNPo42nevMBTF4YiS+4qnwwNHZIfU90cry6mc3P3HpXdQiAhpZ7 Wk6Z6A3CFwNZydPtUUEwl9FQ7wh7BNxOpZxtLSPZnG5plN0qFb0uQFZgCLNdzT6V51sc0A5qavy uGltoPvZMiuX5fLsVy5LymGE22L+812DgdQmO1tHIHJiEnb/fVRLEzGJDAh/ix3kZdq1NzLMaKs z0/pl9gEXGx2jhSj4SieYn5JcqdFitfU8HQJu97WrDvtweZ92KAbltme8eI0Wze9aTlsc=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The interrupt handler reads FIFO entries in batches of N samples, where N
is the number of scan elements that have been enabled. However, the sensor
fills the FIFO one sample at a time, even when more than one channel is
enabled. Therefore,the number of entries reported by the FIFO status
registers may not be a multiple of N; if this number is not a multiple, the
number of entries read from the FIFO may exceed the number of entries
actually present.

To fix the above issue, round down the number of FIFO entries read from the
status registers so that it is always a multiple of N.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index aef5109c1ddd..9f6c0e02575a 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -949,6 +949,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
 	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
 		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
 					&st->fifo_buf[i],
-- 
2.39.5


