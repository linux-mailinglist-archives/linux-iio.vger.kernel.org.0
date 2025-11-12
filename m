Return-Path: <linux-iio+bounces-26190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6724C54C36
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 23:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B32F4E1FA2
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B42ECD31;
	Wed, 12 Nov 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI7RZwQy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212562EA723
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988247; cv=none; b=F8MSwr2MbLTvQiZHuCR0VbgnndOxmd19H+0cwPdihR52Zpd5QpdUqlLewh6Gv0tn8UnEr1uwnnNA1V8TsJlOT+BOxEMOTuBs0E1THDvWQGlgTwKCyaKr9XxmCGI79TTT6l/0xG9RjkvD4//e+E+QsaVMtE/msv11Rr3d+qhIGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988247; c=relaxed/simple;
	bh=4R9uJSwfRDFDC4yeCtA2URaQMWypx5dHgLVpcs09cS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MunIFzX4ZXaIgCkisc6tA8DzbOmfZ8I+8LDWfrW+aecbMofjwlQDsq1nOaSnERKjwK5YhoF5ZmpfZklMO9fxbrRrx1qWwTgoDmhIq5657+InMfdv0DHCL0poDDk0XKCp6cJz+be09WN9gu09Tz3SXqnkPLLgcyriJSCahWUjBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI7RZwQy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3108f41fso108063f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988244; x=1763593044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7502WjO5EoP4P++yfuX6KQ8nm9HsOVK8ctMCfYyteQ=;
        b=RI7RZwQyJyhgcL/81aggSimqFOzcGHv9XpO3DADaThX7Uv694ufufowg0WKV/iLvai
         2TvIAdkYlxFWmL4gD0uV8MUBt/r/RAwa8nW/ARmWNZ4rLDXKGfuX7MHmVINt4Aq8+qxu
         U9NBMbqcm7YkqI4Ol74FFACNGOC+G50h9fszoPikZRlQ6Ursy0FI9iYUNo4P5OHn2tdM
         UjPxu69eZxzGtzfTuM39i4QhP5/dBdOXzNyxE92SyKhacKQM6pQR/SHoJr7nXmG0pAo7
         eILzDel/GV1GGkWDLfmZaK4HBQDHQkOTiGyJ8XFxZ3iHD1ef6AMt2sGgcTk7/SJ+urTx
         w7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988244; x=1763593044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7502WjO5EoP4P++yfuX6KQ8nm9HsOVK8ctMCfYyteQ=;
        b=UmIYR7yo1oqZEYyGClfR4xuADUndgZuRZaKUQyNtBebe+/+Y/Ktf77YDz7S/OR9Ow2
         kLob+Ykhd7rKqt/ZsnwsqyoWYj35XfGN8KK9PRP1i8RawrCYwl2rAA8f9ro+MCHGmuac
         fEBRJrOIsTlKUnJjCrU1dTX4Hf67BcYVfC38LkW2XPZLbuAVF+XeyE1UWqvisiNDoFUL
         +7Vj/DdSCv35rjxbj/vabLKIdbZyrBB8F2IRvu5k3ajedSs5HmiM91VjPBQ7M+vnvNY9
         2teIxdXiH26YM3GCk5yZaqRxaKGhz9BcClcRmlGe4fLDLOKA3pZ1hbEsfQYN0V0vnKZx
         9nug==
X-Gm-Message-State: AOJu0Yz19R11g1D9cnISQAqEEhWYNNz27SU4Gg2i43K8KvNzt+5aYqOB
	BaBdHBAcTcshnQSl3BjkSTpqslQ+NxWVg8LmfoUqFP/NqyJDGQ1swQKQ
X-Gm-Gg: ASbGncvDjhf78RJDxt3MCwvZcQ5O2PlCtdnLPowt9IwxEqm/+tfFhmyK+pN2e6R+sun
	HsdiChx14emXFonlKIBxPf2xQzMgJW3ss+hNcZSq2OMWVRlAS+w5cTDNCwsn7gaw9P6m7DR1Fy2
	F/mWTXHCcCK0tMLwWnPKag/Ah8xe288xeu8Basstj0VGYEWX7okIUdgbR3tbiiLIp5AwztWmB3H
	a8ZP7h6suLSzgzkYE+4igW8oaEZCTThFz4G70Frg/v3FxMUgvflVhVCI0U1DzS412BchrpAeF1x
	95uGNh59b9cs8LHTrlMJS/nD01qOXUtV5jzSCNxITmDFGYk5N00vyPc5uTPWsQ6WuQt+O7MeimC
	dmq3G9HP4VQP35YZn6rJ9bou2tlgwkXpmoZT5v+1peXyOunzULLgJD7upTwhWVEPTYKIQt/cr9D
	Ppxsx/qrc=
X-Google-Smtp-Source: AGHT+IEZeLFhjKlX+2oecgSyqmpUsjOHozvWH5fS1TJhDkljS6rsAK5pW51JKAcYLMQ4PnfaBkLYDw==
X-Received: by 2002:a5d:5848:0:b0:42b:3298:4690 with SMTP id ffacd0b85a97d-42b4bdb020amr4463095f8f.33.1762988244234;
        Wed, 12 Nov 2025 14:57:24 -0800 (PST)
Received: from localhost.localdomain ([78.209.131.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm236979f8f.17.2025.11.12.14.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:57:23 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 1/3] iio: mpl3115: use get_unaligned_be24() to retrieve pressure data
Date: Wed, 12 Nov 2025 23:56:59 +0100
Message-Id: <20251112225701.32158-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112225701.32158-1-apokusinski01@gmail.com>
References: <20251112225701.32158-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pressure measurement result is arranged as 20-bit unsigned value
residing in three 8-bit registers. Hence, it can be retrieved using
get_unaligned_be24() and by applying 4-bit shift.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index c212dfdf59ff..5594256fffbd 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -125,7 +126,7 @@ static int mpl3115_read_info_raw(struct mpl3115_data *data,
 
 	switch (chan->type) {
 	case IIO_PRESSURE: { /* in 0.25 pascal / LSB */
-		__be32 tmp = 0;
+		u8 press_be24[3];
 
 		guard(mutex)(&data->lock);
 		ret = mpl3115_request(data);
@@ -134,11 +135,17 @@ static int mpl3115_read_info_raw(struct mpl3115_data *data,
 
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 						    MPL3115_OUT_PRESS,
-						    3, (u8 *) &tmp);
+						    sizeof(press_be24),
+						    press_be24);
 		if (ret < 0)
 			return ret;
 
-		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
+		/*
+		 * The pressure channel shift is applied in the case where the
+		 * data (24-bit big endian) is read into a 32-bit buffer. Here
+		 * the data is stored in a 24-bit buffer, so the shift is 4.
+		 */
+		*val = get_unaligned_be24(press_be24) >> 4;
 		return IIO_VAL_INT;
 	}
 	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
-- 
2.25.1


