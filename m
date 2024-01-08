Return-Path: <linux-iio+bounces-1478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F9826A30
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 10:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923A91F2112A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2131FDDBD;
	Mon,  8 Jan 2024 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRHCx1tb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83411C80
	for <linux-iio@vger.kernel.org>; Mon,  8 Jan 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e47d74824so5026845e9.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Jan 2024 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704704826; x=1705309626; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvlSIPhnSxsAgUZ5VOCaG02vTPapjaMyzZC3lbOeJWU=;
        b=cRHCx1tbGGdbpx0wfS45W8o4Ix9oH6s8GjAShrv6W6Zrxh3Vv0lBERvsn561cbvdBA
         FYPuZ46pLfNV6nNPYyuIjgx8mFmz2BRZSKXIhfKbwE7ukOanYYyAmR+ch8iw4L2ErUav
         vgNt75p2TmTC5m171jlrt/7xEfm7y/sBsr+KIhIhPuS/irQmp/RuvDKvYDuLK5J66KLq
         2jRMUyAR4/CBXtJK9kW0PVmv/4/mIm/f5XRMZuUmy4LfzKQ4F32ElxBH9DTUTvEvsqEo
         2bNcjJu92hrYIUcBpVju9kHEznihl4zr+TWMfXJoEiSRdwprJJMRzwqCHoXU2ymI3Twx
         8Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704826; x=1705309626;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvlSIPhnSxsAgUZ5VOCaG02vTPapjaMyzZC3lbOeJWU=;
        b=h/qjDWzVGRVdOg+WqOpGnhiM2K15dSlkPssliBMi8QWDq+P7CO+wBQCXjAdit6XgoW
         woMsJjTA/VPR9QxCfkM63plRhDMV6YkcRAvLH0Wwyjg/d7mbStTykBF0xHen7LPQFrHe
         rmG6Xx+exOA2Ije8NsuqWwrXRLgXDXqaggl4N4avPUuyEkYHs2AyNf457rPeLX8TtLaE
         HjclMXbBOKQrb/PKcOGAoq6LZChT1aG5q7HnMrZ0oiILNDev3R0kFhUUya8dXWLqPsdk
         icsF5O2MgbMuDwBtwO8/bYh4pBWMDqPomWaqAaI51pug3rlDXYAXkXVU7WmKVX84nF8e
         f2Eg==
X-Gm-Message-State: AOJu0YyfvHn97InZVO0T163N7keQy02AKqqFsf6gI/WaM1YxL5XMTNXa
	e1dYPJGiWHCT86WGyhbdxvTuUlwedepOxg==
X-Google-Smtp-Source: AGHT+IEWNfg091q6tWh0kqNPnDplnj2PkfU7WHRqqW4eF4QRA44j6syz81m1KGHMf+/2yX7v+dgEfw==
X-Received: by 2002:a05:600c:5d5:b0:40d:560e:26f3 with SMTP id p21-20020a05600c05d500b0040d560e26f3mr920797wmd.136.1704704826697;
        Mon, 08 Jan 2024 01:07:06 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b0040e395cd20bsm10132486wmo.7.2024.01.08.01.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:07:06 -0800 (PST)
Date: Mon, 8 Jan 2024 12:07:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: ad7091r8: Fix error code in ad7091r8_gpio_setup()
Message-ID: <fd905ad0-6413-489c-9a3b-90c0cdb35ec9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste error so it accidentally returns ->convst_gpio
instead of ->reset_gpio.  Fix it.

Fixes: 0b76ff46c463 ("iio: adc: Add support for AD7091R-8")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/adc/ad7091r8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
index 57700f124803..700564305057 100644
--- a/drivers/iio/adc/ad7091r8.c
+++ b/drivers/iio/adc/ad7091r8.c
@@ -195,7 +195,7 @@ static int ad7091r8_gpio_setup(struct ad7091r_state *st)
 	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset",
 						 GPIOD_OUT_HIGH);
 	if (IS_ERR(st->reset_gpio))
-		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
+		return dev_err_probe(st->dev, PTR_ERR(st->reset_gpio),
 				     "Error on requesting reset GPIO\n");
 
 	if (st->reset_gpio) {
-- 
2.42.0


