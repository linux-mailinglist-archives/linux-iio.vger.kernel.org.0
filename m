Return-Path: <linux-iio+bounces-6131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C086F9018BC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFC51F21304
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4A78B60;
	Sun,  9 Jun 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epa9FWE1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BE770E1;
	Sun,  9 Jun 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976328; cv=none; b=HV2kX6mdLtU7AHta+6pp11V4Ix0kj7oJp3TXKzgjQawxPFLVoARAPns8rm7e+PXcRvMpPpQQHZkhQOQuJLPFbmF9iLul68n88aQAlJCG+rSGBPjJYjWFwBUcCIDWpcBUe6w2E4ooSMsVvk/VXNh+XmRLe3cOo4JzDUCEhDpt0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976328; c=relaxed/simple;
	bh=gcq9Yl8ckJVcNxRzmgJTXwGhADygY+Q2ZVzkBeW2Hhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1mvz+wf8nhfYZ48ns+NdVti9ycTGB7ZHceBN5dEC11+vQIQbEkBWEoaTtRy8Fs4ckzOPKo/rwt6MMDetyleQUvFNIDUVbD3AWsSgQ2RjzcPjO4bD/gTJSvoAobPUrfBr9ZoDVKsMLoboxCQzase4oWR73IjmcdANY/kfzfA7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Epa9FWE1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f09eaf420so136707766b.3;
        Sun, 09 Jun 2024 16:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976325; x=1718581125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBfiQOFs6JnmYnZ4Lv87OrPaVWKaEYAjVyPQYQiqi2s=;
        b=Epa9FWE17CRjMPy7qYdA0z6TBpSGRa5SOQltlIxya/BzdCDIy9Z0iMbr0vokakUarN
         n++3XFKdd7/IeKOcPaC7lM0cZoawgFAnBwmJTWpknK9tM9hFy2SGrcKUZvE/8xMOW2PU
         ny4pcqQH6f2ikvDVcuA+X0H2wCNCSoH5S8PDP/0lfMMma5C52PEavyinkxwLRL3Ha6cD
         B6tGnwck2m1fjnuezKWSGvL+tJXrMFA3yk9l7wzkC8sMv6hWlU5kaCxETSuoFcaf9Iy4
         35eILWyMeo3gRyRLiCTGB+uEGCDPhshMBtwGspLHikYJjGxNdiVa4gP05hueDLNRN8h/
         pIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976325; x=1718581125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBfiQOFs6JnmYnZ4Lv87OrPaVWKaEYAjVyPQYQiqi2s=;
        b=jmaQjDONPtX0Uv+JRh/xgohBpjEF+kb44KzpSxGr2qgYlERJ3njDGqgEv5pQt7+4Cu
         nMPksc9hsrOM9cEZ06ctGz/FX6PGcAnP+K3xyxwuyDRE9yA25I/p4KTzQ3b61XmdLIQE
         gGqGJn6PhX9QdHQVkTNUkSFoff0X6moinaIUofxMA//q9x3xNavWrbJ2Ho+cX9Df9nFj
         3Ov2ZrsVgqpJuqTTPy+OYGFkBObtPkHS7aR0HnEfI9tJ0XKHk1V8Ucw1ABBaSo+kt+kU
         ekhm0oDbZsU244Vo0V28NQxd6hY2ZzH8Gt5fxdZyn1fhUQxIQT2vGdW8E+IrrdiXD+UU
         op9w==
X-Forwarded-Encrypted: i=1; AJvYcCU44B2B3douh3VsEWDBsvjItvJRoAfI+UXUctNfa0ug/HMJLT5Sd3keGaTNpBCCilxpICWMprQ8ScXM4UP+8oRNGLDgXQxUWZCrPG31mXg+oAr59IYMtYQU06U5UL7fnnqArL8jNp3s
X-Gm-Message-State: AOJu0YxDG5EUiMJpya+CaXMn0Gz8rSjINISSDcskZc18AgM2m1OHiHjI
	3HyeztaEycJaDRJmi471h0+I2GozGqCsSjIxsIHHCdtYk+BZraDeTG0yPw==
X-Google-Smtp-Source: AGHT+IFfL8JwlJOQdE8caYhaAUZTDqEYvbRvblTKBXSp8DQ9rEFqcU3yh5UyQvEZWB8t69UGGFOlMw==
X-Received: by 2002:a17:907:9711:b0:a63:5745:e3f4 with SMTP id a640c23a62f3a-a6cdbd0e290mr626674166b.65.1717976325138;
        Sun, 09 Jun 2024 16:38:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:44 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 13/15] iio: chemical: bme680: Remove redundant gas configuration
Date: Mon, 10 Jun 2024 01:38:24 +0200
Message-Id: <20240609233826.330516-14-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to explicitly configure the gas measurement registers
every time a gas measurement takes place. These are initial configurations
which are written in the beginning and they are not changed throughout
the lifetime of the driver.

If in the future, the device starts to support multiple configuration
profiles with variable heater duration and heater temperature, then they
could become members of the ->read_avail().

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index b357871ef601..d08f32ecd139 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -683,13 +683,6 @@ static int bme680_read_gas(struct bme680_data *data,
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
-	/* Set heater settings */
-	ret = bme680_gas_config(data);
-	if (ret < 0) {
-		dev_err(dev, "failed to set gas config\n");
-		return ret;
-	}
-
 	/* set forced mode to trigger measurement */
 	ret = bme680_set_mode(data, true);
 	if (ret < 0)
-- 
2.25.1


