Return-Path: <linux-iio+bounces-27581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3387D0BCF6
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCAD3056559
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10555363C6C;
	Fri,  9 Jan 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NnKNyeqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C559366546
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982538; cv=none; b=LKRFAy0JRT4J+TH0qTr18eRewt+v0LM/1sCEh8P7xcqk9vpcTYTqcBdm1L/yBC+VAYStm+HdjTOQ0IoGh/4qleUW6WiY8nY/HD/K+E3C1ZLwk/6xDeD8FyefWyO4UY/RaR6n75bKpvGpKyMEm1nMF7nJ6n2jhNRwY18n1pdeCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982538; c=relaxed/simple;
	bh=HyDQvFt38CbL24666SIbmPISPjsBCOGkvrEjkNdUEYM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoKovHzy1hNAjvWC7V6HWSVOGycU/R0fl7FMOEq7NCLaEwJo62SoBBP+9ipkR9zNC8CX9/ys2rgs3N/00k75VqFd4jcrF8Y8eZUGLsZBy7O9O4wInoLH/OoxoOlGsX9ZK/iFEGVrVreNRK30JISM02VQPRY1KncKz+mrn+IxNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NnKNyeqr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7cee045187so585646466b.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Jan 2026 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767982536; x=1768587336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNKSanGi/682T6/bpK1636gCehsHDuuGDNYO8lX6fUQ=;
        b=NnKNyeqroKLkE2zQ779Kfmyc9snzuvfWVB/2zayT0v/80DEzE4jLXHXzZ6t2jw9bvI
         i6x3XEBuUTeDeTxfg7h+OuKxecPre4vUaDpFuPfjtKEmouCiT5Rvpp86FTbGlF2QrL+/
         AQzI0RBvt3DojRpzK6kTISxS0zZGj2SM9SOnGKhfzA3C0AGFeniSYaE6rZxC3C6E1xaL
         E6KDXCztqIRfDIRYr8M4rEZcN53Na2sixbBxNv73TUKhymTUhuBMmeDA2dp+66m3bWxk
         19rPaMNq5zi1unlBZYtuUzehprCJkLzWxTpO88jK0qlKGjDK6REACWyFffpGmsnhXdAO
         DJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767982536; x=1768587336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jNKSanGi/682T6/bpK1636gCehsHDuuGDNYO8lX6fUQ=;
        b=PR+1bJ1oAHOwipl+Ov5n3uXeOuhM1YjRxKFgW5SXl+tK4DlnatJ4CI3XmdZ8aQF0cr
         VhV7Zq+7i4xXAdZyrvb35w7e3fqddLbpFYlNpE8veGzezOiaDxRJmm9/EmO9wDPpShwF
         WXrkghqGDd/m63RiIR3qgMMNt62PNp9LqsIIWdgy5mbGX4NF8NtZ4sQow4TV4V+QqTga
         aDKqjp6BVSrXERkewUa7pYic5oaQqG9zOqiKKFLzaMzQ1n+cRrdxoWM7Pe0YmdQa5qO7
         3yn5UC14wCGOmxgZTg9c9T5I/TATAsqYIkMlrHwx+t7kv6g3+OopN626nHQ7D/WoVA7N
         9b5A==
X-Forwarded-Encrypted: i=1; AJvYcCVYNRg071RgV3z8ppUe9rLBY3x2WnEXctI+XtHEho5zWoqw0nZpacSPsw5kJP73Nz9uWUEB1znpGNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXeMdBY5a5IvAGL1xaIzr44DqaDXEQ5r6VdlTjypZVHG5x4FW
	eddSwLXBa8gXxDf6WRggIZt79rzfWAEJuVWqmxnakLLc3Gsu2wtxKHXeaatoSaa/nYw=
X-Gm-Gg: AY/fxX6DVQ5AMfYn8xWiDx/PgmoCaV+4+x+6yiW96yyQZZCR79O/CHNuguy1dbh9x/L
	fjh6Vlo6Bg02ZQeo+eZXCF8JitrpBSxgAAIbi2jaxcVclTU0GE4yoa06TuyVM8WuhHyFEYn7Jnt
	C//V98VcwUtHPDxKdZt9UjpkZqxuyyxGAvXzxddLEz7iMqgZqmFPjE9+I4bDvTZLWWuQ4R88vMB
	JrEeHc7DywYHbOXgFCunmj5/cwaIlTmxjUkzIdw3HGasUr/SWQpGYPZ/Rx6LoNPl+cUDCeduFRQ
	24En1weQ0MsBOl+Fb/0+3ZScb9tssbgz3DHwhU8PG/AB8xpOno3yKzjxY60cknSD2Fnx2FVZBIq
	nAVgwpMVtwizI/yH307hTxK40AT55Po95u0pjZBbPYMNMR4NI/iihiF6jYw==
X-Google-Smtp-Source: AGHT+IEdAr73dmVnN674sxfFpbGODRqcsy8dZfQgBLgbGjQzIlujJ+Urus5GqDJjCqurPfWcvbCuOQ==
X-Received: by 2002:a17:907:971d:b0:b80:3ff7:e43d with SMTP id a640c23a62f3a-b8444faa4femr1109183766b.26.1767982535706;
        Fri, 09 Jan 2026 10:15:35 -0800 (PST)
Received: from localhost ([151.47.174.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe6bsm1174309566b.34.2026.01.09.10.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:15:35 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: imu: st_lsm6dsx: set FIFO ODR for accelerometer and magnetometer only
Date: Fri,  9 Jan 2026 19:15:27 +0100
Message-Id: <20260109181528.154127-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260109181528.154127-1-flavra@baylibre.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=flavra@baylibre.com; h=from:subject; bh=HyDQvFt38CbL24666SIbmPISPjsBCOGkvrEjkNdUEYM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpYUWGk8yDBpa5cnHA5yE2LmLq9JwJ7/3Z7nuTl Ak+T8zMK/2JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWFFhgAKCRDt8TtzzpQ2 XymmC/9F2DC5VZETvTqxNEzTvp8IPesMArEGV9mIXgu3f8Yg6KfzKa/xNifgCmH7NghoMeMIPpq F/DZnPYO7foWKEuCJ5d3pP9FNZ0+a8pe4wgpmGsHugtkI6wqtAjS2AaJp/0kfDokLodSu7EFwvP xqbcbkCC5esPEygIoUO0cWCeJPjw/4r/rN8QWOPY/YPZjLA8PMZkVjg3FWGk5p9Mi8+ujIeGiCR zKv7Xhtk8yX+yOWJklFqjo0BgUgrzsbIsO1JemYhkaFWVGx2vvbiljBQ5azsJGzRqs8Z3kDbsRw 0qVbafSIHisScaszRNO0hg0LkbEeULnPR9bAUCbPMWbOTS9ejGdVtObQW9bzbunbLJsYsio5/5o miI27lYfAlHHTF+kl9Z8Qqyu7BX2U5D+0sVOnlFaNCU7N8AyXi8RBVS5K0cYPMbvPmx2V9OlkM7 LVN2Lj67FSXetieHNATuqnw4zCAIMa//68w1ufgVAXVCPSNp/z51Sv3jpyAPqf3CXkpQM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
disabling the hardware FIFO, checks the contents of the hw->settings->batch
array at index sensor->id, and then sets the current ODR value in sensor
registers that depend on whether the register address is set in the above
array element. This logic is valid for internal sensors only, i.e. the
accelerometer and magnetometer; however, since commit c91c1c844ebd ("iio:
imu: st_lsm6dsx: add i2c embedded controller support"), this function is
called also when configuring the hardware FIFO for external sensors (i.e.
sensors accessed through the sensor hub functionality), which can result in
unrelated device registers being written.

Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
not touch any registers unless it is called for internal sensors.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5ac45e6230b5..9db48e835d4f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -225,6 +225,9 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	const struct st_lsm6dsx_reg *batch_reg;
 	u8 data;
 
+	/* Only accel and gyro have batch registers. */
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+		return 0;
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
 		int val;
-- 
2.39.5


