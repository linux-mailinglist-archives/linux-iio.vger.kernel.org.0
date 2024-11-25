Return-Path: <linux-iio+bounces-12659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B99D8E0F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F5AB2A5D5
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE371CEEBA;
	Mon, 25 Nov 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB68AS5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE91BDAAF;
	Mon, 25 Nov 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569394; cv=none; b=su3mOZwSuW3zVk3oblRKONQo+Hm3qrJDIsQAc0nLbS+UVC8EfS7/su1yL/eZ4KKgOtfnqyzt+gq2pvC7eYnhILAWggJ1ddP34gwyNcll68EuAnyqi2dUgFVw9OQMYdp3R+H/+KM8weW0fG3juE26wu7wvaxOMk2rWuSgZHW29BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569394; c=relaxed/simple;
	bh=ldmaC1AaPS7VUE5TDQ6XOl4U63X+5znOut0PR0QpWlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNIEyDQXScl/nKXVco99veQy23vbBiFLuPlmlBr7qZaD94KIu46LGtjEXuUibbhq070k76TB5C+T1ecKJ8GAAaQpg8hi/YQ9xb60qIDPm/nMEROV7NSKBCH+xdz7It0/UZZB6BM+s7NdKFAyxiuzwoo0OTEF2YV+iGppZIG4cP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB68AS5b; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso45553595e9.0;
        Mon, 25 Nov 2024 13:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569391; x=1733174191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEfg9Xh7fWO3QvY02FKoZb33tMiR/uiIjd1V+C7lNVA=;
        b=eB68AS5bQ0/UmdCJoZPt2f9HOKK9cZVEr2epGzVZMqCpYgLtcqRxwQDkv1UULFFtPf
         hOXNu5CBiodV3JQQE783XXYJmt6mWHTifAZZZ1c1WZ0wGC8dOo93f2wE4BqPbfRif17t
         Ncs0f2HZFwWhZjr7ezVxpG5MhX21S01KjnQmk1O7q5N8CR9jQphQtdL79aFD/KZwtzfr
         t4bVuI26nW0fgf6+kncNBp/93hRq9c9L1bZvTtVlnLhR2/n7sTEmSHXmYXM3oxy1pKPA
         w5wSqhlNB/YObojiRmQS16DSEWXn2ieBQLKYbxGtAhwSeousrHO9o275kDtOTqcfm1MI
         tVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569391; x=1733174191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEfg9Xh7fWO3QvY02FKoZb33tMiR/uiIjd1V+C7lNVA=;
        b=WTAzXnEsVbuL0EgH3T9/4Mf1eexSvnMZNEVyYv5O738sjkguDmzV/ystbODZEHGl+k
         r3kutHvNPGLXcXtjrNq+MNrg4vS6WkAnwmm3riIvWKY2pC45nkqp9hZazs+jGfJEb2zm
         uvN5ANfp4VcJZSt5h1FZHljCU4xnsUJ455cWluGd9raJxxsLXmHNC89kayYNulS8Ty4O
         2lgPJOh9fdP6NtuA0raZXURWfDwxRfqWM3HobeTQzomnam3Eb+fl/A1dJeDc0L9BFZb4
         KeWPOJiXXgeRYkaJRkJsUqag0OWAkpgX5GoRG+nwvbAVIJV1Z2vvoj598/eeIhPD0t8t
         PwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUETsQRFC3gjYjq2jzvHtieKZrx1G+81ivNChFSuUlPQ+fKDUGyrS4C3RlsPldmya6PSxqtvFdji54E2JIk@vger.kernel.org, AJvYcCUUiYnb4l5uTQIxZsFTpQdqNvKs3skNba3fGs+m1LWwzRZoxy+GB8UNDVw3S4Fpdklk20OAwN0UIJQ=@vger.kernel.org, AJvYcCV5VTMQMuXNFf4JVqJyCZf6silPK3h4uqndxXpO5gziHHriPrnWB0YAqNiFwuxRsP8HIUt1svMx@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiGuW2DVWO5yqkpvN/2q35S7HVFKGUP/xzO1zOBhjHkBqBD6v
	TOxSySp9JvR/IyipS1Lyhl45gPzj90+svHh+njTavokG17cLtaIR/NFiOQ==
X-Gm-Gg: ASbGncuiaHmoZ2uTo7IfnrTL31AHFQbeUVuNixAjO8aHt8PYoLkO32oUzqH1xcMxaq4
	0vRl9mDQx2Fj/jFo9Z2leLSFGV90qLS3tlTNKlrCPEIPnkwJC2Pn8+uH+pgrMlepRC7CHl3HIyo
	HGuK0e/U+LN1qihl7EiQ5KCYOKQBk8g16d7ODdi1MEAT0mB7km1YHLnpnh1OUe6KWMIGC7/tHRs
	A1zY6FNjA/OuzQNjhqi80vI7c8/LKFkMK/7GM+Isjqq4+/GqYFLZLNhR2n9OM4BJf/KNRDqxJV0
	FjcMO2WUkEiK7FKqXkgyeLr+g+NlvyuEDFheRXJDiUOyf+8/Bb3EDBakwdZklwYd+HmFubEe
X-Google-Smtp-Source: AGHT+IGihIgvKakj2kd3HraoKzj41H+QGMaEpHFUd1DnXNAHZ7SDNk1bhVlwFbvAeK0VIXrOJtPtVQ==
X-Received: by 2002:a05:600c:1f8d:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-433ce428f89mr140833505e9.15.1732569390669;
        Mon, 25 Nov 2024 13:16:30 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:30 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:14 +0100
Subject: [PATCH 06/11] iio: light: vcnl4035: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-6-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1370;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ldmaC1AaPS7VUE5TDQ6XOl4U63X+5znOut0PR0QpWlE=;
 b=AQ3FGOpdUSCJnkM1OMJ4NlDa+CCQ7GYAakX9ehZTX4rmx5AM540NDBVqj/POAChWHrUeVpwZo
 +zUI9lwr6w/Cyx6ME/D1kW1447JQIvwLXOcdDzD0H+pXovYUL+W64J4
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'buffer' local array is used to push data to userspace from a
triggered buffer, but it does not set an initial value for the single
data element, which is an u16 aligned to 8 bytes. That leaves at least
4 bytes uninitialized even after writing an integer value with
regmap_read().

Initialize the array to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: ec90b52c07c0 ("iio: light: vcnl4035: Fix buffer alignment in iio_push_to_buffers_with_timestamp()")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/vcnl4035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 337a1332c2c6..67c94be02018 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -105,7 +105,7 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	/* Ensure naturally aligned timestamp */
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8);
+	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
 	int ret;
 
 	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);

-- 
2.43.0


