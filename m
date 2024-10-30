Return-Path: <linux-iio+bounces-11656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 436BD9B6E6F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 22:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE5B1F225E5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F622144C8;
	Wed, 30 Oct 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hUJ+M//G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A31EF940
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322587; cv=none; b=R0UukweS7ATlTL91j/+93cMQrGppln3fybUL1OHpUaKfwQu/08+IpiaX172nrU/dDmh2uGq94eYI+jTRe3Nd9E1PzG8L51P5u6cSGRjgtXh2VSUwjnFCE08x//nTba0AAV3MaGlDJZuw+FRz0XlbswwPjy87hdw5IL1MuJxApEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322587; c=relaxed/simple;
	bh=dtzSsuOsjrMsDUkaJ8ZCN4Md4sSP4PrAoDcNwjhOekA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gY0qESoeTrkuOTrlYQg/GoTp0H0iXDqGZiAxvrdA7suRjCudf7iWZXGyrAiFKowRfVU2TeVZgFmcZf5nLTsyJGp+SmYkZ7+yLhDq0w996mcddT7lyWiOwo1LWAvod86izSBJ8q83mfYExACz4Dc5zhJtSQWWfgj7rEO+k0epDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hUJ+M//G; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7180a400238so164689a34.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730322583; x=1730927383; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v946MMe7vLct0HqxsJKsBrfIkZPTq8ZRm2oG1sT2VpY=;
        b=hUJ+M//GSSAAc92pM/Fi7+R0kxyQkIjMpATbVwpc7r/xWDa2v5Z9VXSRr7yIAAsEUK
         29liW6bus9rugEJC50He17dnng3ToCVOhROghpysIkQUtTzf2cbV+E0x3QIoKzSpSkco
         pGEpNBdZMrZwDVnwp3Hf3CG/wL9sY4T3EW6LSUGltVS4Fya4Yci6XiEyWjQ8y95nxuIo
         Hk8gW6tS6wAUq5qieqRZJcAUH6O8t3wq7RpsEx7KUy6ClHWbfG/cyIdI8eHVaA0++hwQ
         wcwpkv69u7cdS3O+LThaer87w5DoCYyEfgMDLh0Jr3dxiiH7MqPtRSEpDvdxul+dPiDn
         2fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322583; x=1730927383;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v946MMe7vLct0HqxsJKsBrfIkZPTq8ZRm2oG1sT2VpY=;
        b=QBftGCRtkZlw8LSkg0dQlcGuXlpSPGvDSfvnwLKQz4khW+tYNiWDS2yM+uVtRoGPxy
         +SiOziDlzz7EJ7xM5JsRl2rZC3frIHr+xb9vp9vSwn7FzNfrtMFHFb2tZhztWt5XDyhO
         reYvImNrzjQ8Whrw8bfKsSY4cbllu2EHcX9GGtMHqVyaVR3KR4K+zMN0G07/SRzZ+jQL
         XjNYsOd23VfPOAm6s/vbXLDcB8gToyhW4ooMX3sbqzZB79QWhI/O3XzeOZmqgebQS4ts
         oyWGW4axBxRo6Dvgkv5ICerwBdj1YB2fVkOF1G+rQHiKxU+0YBzEbTuGOIMmt9lrRTau
         LU5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1dngOKM9ML0gycMCm7KD8RJmYdsvMBeYKiu7dHfFyoWJNWgccGS4zySckrLHDVx6WSoilJ3ktEUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxutO6aFvScKnj9s/KViY71kMNP/MTcnG9orRsA7EHv1SlFMxut
	/6DjnNKQAoK9+r7YvpsczKRFvGK2LW3lJMMvsZRnFeEdIBl87X7WRnQhMmGIdg4=
X-Google-Smtp-Source: AGHT+IGTjtKWZENtiMSPHMMhWP5XL9suYtm5rdO9OICFcYMD33T6XZ+W6/+ori11obVOa0lQc20Hjg==
X-Received: by 2002:a05:6830:358e:b0:709:3a3d:6cca with SMTP id 46e09a7af769-7189d50dc56mr38971a34.11.1730322582945;
        Wed, 30 Oct 2024 14:09:42 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc7ff23sm38814a34.41.2024.10.30.14.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:09:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 30 Oct 2024 16:09:41 -0500
Subject: [PATCH] iio: adc: ad4000: fix reading unsigned data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-iio-adc-ad4000-fix-reading-unsigned-data-v1-1-2e28dd75fe29@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJSgImcC/x2NQQrCQAxFr1KyNpCplQ5eRVyESTrNJpUZlULp3
 Q0u3uLB4/8DujbTDvfhgKZf67Z5SLoMUFb2qmgSDiONU6IrodmGLCWYiAgX27Epi3nFj3erroL
 Cb8acOYnmXJbbDDH3ahrx/+rxPM8fTDyDj3oAAAA=
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix reading unsigned data from the AD4000 ADC via the _raw sysfs
attribute by ensuring that *val is set before returning from
ad4000_single_conversion(). This was not being set in any code path
and was causing the attribute to return a random value.

Fixes: 938fd562b974 ("iio: adc: Add support for AD4000")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
FYI, there is also another unrelated bug I noticed but didn't fix.

We are calling iio_push_to_buffers_with_timestamp() but there isn't
actually a IIO_CHAN_SOFT_TIMESTAMP() channel. I assume the intention
was to have the timestamp channel?
---
 drivers/iio/adc/ad4000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 6ea491245084..fc9c9807f89d 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -344,6 +344,8 @@ static int ad4000_single_conversion(struct iio_dev *indio_dev,
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+	else
+		*val = sample;
 
 	return IIO_VAL_INT;
 }

---
base-commit: fa4076314480bcb2bb32051027735b1cde07eea2
change-id: 20241030-iio-adc-ad4000-fix-reading-unsigned-data-88a1de88cf57

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


