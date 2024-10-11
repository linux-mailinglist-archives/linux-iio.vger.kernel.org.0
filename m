Return-Path: <linux-iio+bounces-10437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4FE99A048
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E992858C8
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2978020CCF2;
	Fri, 11 Oct 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNCdYAzh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52320CCD0;
	Fri, 11 Oct 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639651; cv=none; b=NK/Rr25uNCNIp+fkACCgN8Ul1rzMBEB389PyPoki9irFmJQdc6mzJXTGP+R+fK6pEb7OrullKSWy3qCfWsOlhlQueRuZW9w8FnmZG2VS20NrETgbZAiBQFFF876waKjxjIRwmKN1e/3OAz2ode+d/kAVjVFJrjjN4ogWdkGtl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639651; c=relaxed/simple;
	bh=iQNhq+CQhhscdKGYDFLYkitEdQ89YDdaFMFypvyo1dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRdOglqVAtAE3Lw5vNNXvtvYPCcmr1JuFjHDhbOlRq7evdSLBHOx/ALuPihJTqIL3YOA5faJNKW/M9Z3hn173rl5CaqaS9GFPxcrCDurtiSgbrtUxz4rhDQiBYT6xfEv2pcLDBpt0bWxc+OsUjsHsmwbzd5Jq3joY5gWbK7yEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNCdYAzh; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7afcf9f3c96so184377185a.1;
        Fri, 11 Oct 2024 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728639649; x=1729244449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7AhjpOVVAnhOPJgZn0n/MxJSbqlC44iwzEWSMXLlrU=;
        b=ZNCdYAzhfrDneiXphSLPn9XngeGaXs3/oAPVGj1vQ11hDV5qOaSF+q9RvKT1iZWQLf
         c7BjSq0oamX2APTLNWlU1EEl+OWUmuV77nNlMbI0tUROJQ2NBeza0LMQ22bvgF+3Vi+a
         hkVhsBO2D2D4bD7WkgMtnCG0W1zeXOQsWy8n7IDj1t/6Ajs/5zDFERhI4CN92W1CO3nr
         laouUHh2y9BwJMaV3oQS/jxLLHuTzbufAICGHzWhJm6XAfciQPFw9VZTVWdIlrLInLT1
         z2+aOZG/OLgG7O/nDYAsWzhrnEMUgGbO1p/G8pxMyb9N4A+XYg0K1mpSd4GYuxWJ4AsC
         lQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728639649; x=1729244449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7AhjpOVVAnhOPJgZn0n/MxJSbqlC44iwzEWSMXLlrU=;
        b=bzLmYXp5H/tCjrZol4fyj/O4p5fwfBmHk4AGOPV23GrNox5ZeCFk2tIbgaPTq7a+jp
         4yewL+dwLvZzpRqnOW33r0ZEJpoK/on3iY2v2vxdvOqej8pfIrUz78hvPtt8zTzAhtfA
         RI3e07zJejSakh5ML0nqYI/2kLoW3jTON45APglyRFMcBA3BrMSZhR2xRYch8VLyzNGj
         oeBGFLuLYZ+d7B1+yJJqjIdzcqcbk7hiJaXOnGv54TF420ZjPOBvidT+nfMeFRUWFwOl
         1AKeNzuGE6gJ36UJg/Pc4PV0Da9qu7nKHgOHh7FF/e4N8NEUZAydIe62uhgvedfW91zV
         M7AA==
X-Forwarded-Encrypted: i=1; AJvYcCUScRaHJYDsDQy6XVYo4RyA/jDSEYPv6yEybd5raDf0alm0KjFCkPJjbubcsitqDuwweQvzGAKX+KXnlHs/@vger.kernel.org, AJvYcCWQqqI7J58ALLd6u5E5Zy7K+PAcadfcyyX3CXm36WlTrg4oA33l2XbY4pTCv1PRn4ZWfQbwMEQnV+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+ZpudI5YKL4oObln+TPFtM5ZpLROFc+xs22gy1szb8f4kw0d
	moH6lLyZjQGoVRAzBo1fGXJFl14sKdTmDbju7/cFURMz7LfTgtJO
X-Google-Smtp-Source: AGHT+IG/+cAgSQ+5fGXIcN1uMcpXrVrmlk8jdj2JQFkFspeYwHXnn69GCnIs8Iu6eLdEN3k7633Y6A==
X-Received: by 2002:a05:6214:449b:b0:6cb:e770:f50b with SMTP id 6a1803df08f44-6cbeffc1ee7mr36700466d6.33.1728639648775;
        Fri, 11 Oct 2024 02:40:48 -0700 (PDT)
Received: from ernestox.. (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6cbe85a5b7fsm13855256d6.2.2024.10.11.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:40:48 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Adam Rizkalla <ajarizzo@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] iio: Fix uninitialized variable
Date: Fri, 11 Oct 2024 17:37:45 +0800
Message-ID: <20241011093752.30685-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang found that the "offset" in bmp580_trigger_handler doesn't get
initialized before access. Add proper initialization to this variable.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f4df222ed0c3..7d4151826b86 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2210,7 +2210,7 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret, offset;
+	int ret, offset = 0;
 
 	guard(mutex)(&data->lock);
 
-- 
2.43.0


