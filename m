Return-Path: <linux-iio+bounces-22307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2EBB1B364
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10C318A3818
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDCB27145D;
	Tue,  5 Aug 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa5hPvvI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B223D2B4;
	Tue,  5 Aug 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396927; cv=none; b=J1oaCaUTcF1BWb/jX7nGdxvUzZEvo9UAjA4ZJmRnVW8oomBIQHyBTJSQwjHArkePDzCtTmIbUeRaifahXFPjozGRgN4a6hnRE0Oe55LWKNL8ZWRkOLCas2u9MAd1jTxhUp2IDggwyVdmsulF13L7tuEZxqWMRxUnkpPNWl3KIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396927; c=relaxed/simple;
	bh=Z5FcbTahZ/RRgoaKzPKgBR73e0JYexOrxpXMw9vqpdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmYC/H9WAwpk+HXiR0ysH9oAStKJBXnMsjpqCP786dZ3yG4YwItQTM3w4+QVpBsuxtvrJP08qZszxLbZSPr4AUjwhR0PWeym8G1185IP8WWZzMAgxjDtJR+/WvcaZoJN97wm+AbHfTc6IWIkz/c4/cw3tP6wm3jJCROSFUMTzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa5hPvvI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae9c2754a00so1329754066b.2;
        Tue, 05 Aug 2025 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754396924; x=1755001724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcIvhPPK5rUJGxNryqxcF4CjZ+W21S0daDQr+2yRE+A=;
        b=Sa5hPvvI0fpUtNdOiqLNjLRg2SyK7tk5nuZ2Az1YJ3KXa4KqxczpR5T4kbEyhHA0mj
         +P0Wcgqet6pMTmZMMNFnRVm9pr+VqwJYDxcvPxTtSPm+eXfyOPd+swGCKGeuNwnaBMXp
         C2xQ9OiOE7DLAfGDvSJUjjMf8s7THu6ysc+iP5fC6zggKlsywTjR2JbG6CymrTXLz2NM
         6ZZ7OKX64qxhrpA/VFnVlu2PWRgUq+FamPQddHKdNmlADr8SGmj2jhz5kxDsQVOv6bXx
         mUaCBOg5jVAxwM2zqmH8ni6qXrIMgQbabvrRhyg+D4ZuD3s6Spkw90JdYrVuvAlZSDva
         Po0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396924; x=1755001724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcIvhPPK5rUJGxNryqxcF4CjZ+W21S0daDQr+2yRE+A=;
        b=nmPhgRPvH1v72bQ54NitRdbu4WbKEvpKHaaDEQ6buATQ8+TzZPnWxgLVdzMffBOqdA
         Z+riFNepptRaLXhatmOniUVXs5RErD75+eLcp26G6Gl5Z76WeigD1MZasja0fkODTVrQ
         gpYNmJ5fZ0cDUUGU+CQGRgxK//uYBjOku3hkA2piPRFSCL4i4XSnOQU3IX0fR3R/1mrc
         aCizbOaYvbb10RX2X5gFMa0b4OLTA5KNBxE8fBlxsUDzQGmM2C7zq3dGiau2D2UjQGaD
         gnk363zhAAtQiggo9d2fCHm4iMtlU4Wh1nBX+vreaJHaPQHeOBVHPUxi0vWluFS18FI8
         SPVg==
X-Forwarded-Encrypted: i=1; AJvYcCU83YUBNuSl6noEOa/oQ1Yrsq9MK4QPBc0GgChvJZe8gARoX0btrAUzzh3as4EGESgRqxB5s9h3krMwPz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWoV7nK3CjPcL+blCZRJsrEusUh74Lgdg54VUihCx/yIcnS2g
	VZi6I6Z65lfhh3drVvdUEXc9BU2fDA2v/wL4MlMOWaVtGvSgetq6sp8L
X-Gm-Gg: ASbGncsZ8r1zQpet2X09KJa5qCX3uLxPFRX2Ni5Oyre/cCuldhI4ObSJK2lxXHdgO96
	M9K0OvuS0vxKwxyOuFfY2VNjsFvHw31w0jZvL1NX1M+9SRdieB89sLwSkssRM2rziS6iQ7187UG
	bpaf9wOc8ENEbKpxOPhsnrkiDo3crccJxloBVDq5lJdQfEM0sv6i9k4P/kvqzj2YmCA3dcNPAXh
	2c8kIFNhP2b0p/QUbRRdqIvxCZi4EEyDKAKRgXAEePZYp/uemSFg5Hl0v2nWSwNBx5Cgu0Utxi6
	p5hSOA06Xu7rQLh51EhwwpdJG04cs7KmkWVevvTCEwprIHpOmPRBjUIbEBRSWWt8rktuvCQoYbe
	Xg2rLTqfuXaUrtpgsnn7clnI=
X-Google-Smtp-Source: AGHT+IEqVHHRxx5/5XxanTeGkzAoGd0nO1c/93cB7pjgH8vrSNN/NU3YLCNsGtlJJwX4xh0/nrdldw==
X-Received: by 2002:a17:907:3f99:b0:ae6:f564:18b5 with SMTP id a640c23a62f3a-af940007c7amr1441156266b.19.1754396923741;
        Tue, 05 Aug 2025 05:28:43 -0700 (PDT)
Received: from fedora.. ([109.69.133.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911567fsm8121712a12.61.2025.08.05.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:28:43 -0700 (PDT)
From: Stefano Manni <stefano.manni@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH] iio: adc: ad799x: add reference supply for ad7994
Date: Tue,  5 Aug 2025 16:24:23 +0200
Message-ID: <20250805142423.17710-1-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AD7994 supports the external reference voltage on pin REFIN.

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/iio/adc/ad799x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 9c02f9199139..e5167dba925f 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -826,7 +826,8 @@ static int ad799x_probe(struct i2c_client *client)
 		 * Use external reference voltage if supported by hardware.
 		 * This is optional if voltage / regulator present, use VCC otherwise.
 		 */
-		if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
+		if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)
+			(st->id == ad7994)) {
 			dev_info(&client->dev, "Using external reference voltage\n");
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
-- 
2.48.1


