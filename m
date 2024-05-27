Return-Path: <linux-iio+bounces-5372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A8B8D09FC
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BE01F22D77
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA21667FA;
	Mon, 27 May 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqkcJUG+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFA1649D8;
	Mon, 27 May 2024 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835104; cv=none; b=QJrHobnknKrv/W0pwNtXLf382XpZj/Ub2ZbFrmux+3bEwdtGyQV7LsehLXxxS/I7bn9XAy036ajJ7n0DREPvUz0Xdo/WfzIlfjQymLOl6G3h0KDiajfS24EnjLW3+ks71/ZM75WtovLIlbdsC5qtNEk/xGSx4EkeLEx6IR1nMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835104; c=relaxed/simple;
	bh=YuJbe7/Dyr3pwoma80px3zE9SsLMR44nsh9CYslia8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5COZqfl179aBze7iEvlljAxoqe71CG5ZiRlw8KNPVng/BSv5y/gxrIqxt4jhfXVHqNZSn1nWrVetil1E5GI2kKHsY0AgybPmOhjzNfwREeMiLo4/L7uMkUDKQobPMZEyyvUH9qhNbTQwo2eveAKx4As/jIyqhV7fgdl856Pf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqkcJUG+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a63359aaacaso4333666b.1;
        Mon, 27 May 2024 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835101; x=1717439901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfVJB/jhEn4kqNiQbUpyzu1UmUuSBiyJvdH8zWQ1Egs=;
        b=CqkcJUG+0n+HdGKHh+qRsN1clHHo16h14iawoA9zfDYyVXPme/HqR1lq0xNix7hMiI
         tZq94UVAON39jt5i7ygCMHYJ0az3ksgSB3shvXTEEcP/uHaFT/VcYhAOQl9by1C6aF8v
         wBoHv3O8ckAS2ZfqE/ffNcnnNIy3lth8tAsEFM70mRIm2uoRh9IYX45FQe2BXSvw/2vd
         RZrUykPob1SXlJ82yBE6RxzT+w4Dtpta7bf05vDPJJ6kyj0slhCooWaKDJI9HaALLP/9
         RiDIxqcCkH2UOajK9iR10nx6gvFg/suBPY9qtY80gcgyAFn/EDSMTZxxU5r5yvEeFXh7
         U2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835101; x=1717439901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfVJB/jhEn4kqNiQbUpyzu1UmUuSBiyJvdH8zWQ1Egs=;
        b=bNUa+EruEy++aagugtqJGfEz89bxWagDPw9TAfIRQK/sFtzHRJL9KM45vpFdE7zVH0
         VS6ROcXqBXljxs5Z5vAIof/BC6RuvJWkmAbIfwF7zi3el/1boL/0OykeyFqZofu2Vw69
         gV+fN3lluMCuuUIroyzwaA2kzhFXajUcKAaNTuuB9NjPFjTtLmr7Lhr65D8w3BWNsWLA
         JNkxQeAiFMDHJB+56IkfEYlevHYoQpxRvkERQ0BfK0S6wWX67K9IjoYzp78z3UHNQwPy
         aUcq+nBVJCs0BrYVgVwwGzgYCeWHuWJfAiuk2H7yBXro56bmwCvHRkN13Bq1i0gamasw
         hRJA==
X-Forwarded-Encrypted: i=1; AJvYcCUJZkhNgKMwwD+WLqDwKmsAoO6tW4ByiWLsmZzDiGTR3BJN2paPCUugSdcuWA6NNHbAIIT/9Gj6V+wprHm5UZDZ9CeJJcEHzx22S9UELVHS/roRRG9whk6oCHOs50hzdkdWiFbK4G24
X-Gm-Message-State: AOJu0YxrZYPvzWeDLKy64lsKzCGvfiKIXRjjkC/gQdOeHSZIaaFCFGNu
	ccZ2FABHmCTsarcqy4rBQlikEQLDFbb3C3MHLBoey3eRw/zUU86o
X-Google-Smtp-Source: AGHT+IF0VHk+MLt0fg+OD3l293QBiGQ65VSjfBMxLrd2ZYU/Nklvjq3uzQJDjKPirhMOKnMreu1jtQ==
X-Received: by 2002:a17:906:2a41:b0:a58:f13d:d378 with SMTP id a640c23a62f3a-a62641b39ffmr647021266b.13.1716835101439;
        Mon, 27 May 2024 11:38:21 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:21 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 09/17] iio: chemical: bme680: Sort headers alphabetically
Date: Mon, 27 May 2024 20:37:57 +0200
Message-Id: <20240527183805.311501-10-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort headers in alphabetical order and split the iio specific
functions with a blank line

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index e61d1f0b67c8..96423861c79a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -12,9 +12,10 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/module.h>
 #include <linux/log2.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-- 
2.25.1


