Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4A10E6D8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfLBIV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:21:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43980 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLBIV3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:21:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so15787628ljm.10
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFIxBLUU4ugi7j/NPMYuH6TZPTJJxnhaWcFoK4Zr7n4=;
        b=fuHR1otUG/RrwlGcje/RLeAUE+Gc273RRB0FPpp+1LNyuzalMAnKY1omcRBkVoFaBw
         QhcslHtLBf9J7ccxPNYR7oxfK4ra+J641gx6ywplx7P7EVMFMX2V2WBJhT2NPRhFGMiY
         IEuAnKe37Wi8c9XZWoz/t6YzKTuLj46Tx9ITLCyIlDj/hLtVNOVNCMYVbdhPjVsiqc/X
         T8cch81aiUsokDaZS3PDfSs9yXgZBdhlre9K7r+EOzhokFgI0ehFjQeXPYqjKbtUTswR
         Ae9daoqc3vTt963ZgH2t6GKDDvGoi6cBPU4Zm0Kb8GX34a/2OVNQsrkeJAHLHlESu8ac
         Ukyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFIxBLUU4ugi7j/NPMYuH6TZPTJJxnhaWcFoK4Zr7n4=;
        b=PtpZtV7Abeoojnd06Jot4gMQ7XFD0tQZVSOP5K5XnKUMSbNTGOJ9rpe9jZJOXqnZiM
         /A+zpWPi+SkALNx4r4yk8UILUCkVoXCAhPRQFWf2XCg6P9q/MjkTGWLohXOMNLyef53z
         bd1rIJETpMMEGHz/pz2E+chtsSivR8VT6bJiahgI2cGP00wP5SZvqdk2BsowoH4OMGJE
         7t3ol4ZdImNpW7PjHNlfqOv8rbYrzW13cxiSzwGe2B5cuB7jOax2Lhd633fM5bHYbOKv
         I5Ues5nhbFmuEoRF1llulI1WvJqPGdEj5HlYG5zWvEbeFlCs8Mn8QG3hGoFlwDp3tqGe
         FKVw==
X-Gm-Message-State: APjAAAXuGpweR+GlQVx5P8bhRHvZeUa+0eu3znmJBPY5/IEUiAJEf5d1
        zoZS4mf/SgUM00iQEq3W9oUeRQ==
X-Google-Smtp-Source: APXvYqybZhDRCBXxEgTmaQF6vwCS/QYfRl4VqkPFo7Pg127b+XuTwwUB97LTOsshvSL/lLcIL5jZ7g==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr45887984ljj.105.1575274886308;
        Mon, 02 Dec 2019 00:21:26 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id p14sm14586444ljc.8.2019.12.02.00.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:21:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: si1145: Drop GPIO include
Date:   Mon,  2 Dec 2019 09:21:23 +0100
Message-Id: <20191202082123.62350-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver include <linux/gpio.h> yet does not use any
of the symbols from the header, so drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/si1145.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 982bba0c54e7..0476c2bc8138 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.23.0

