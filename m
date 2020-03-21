Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAC918E4AA
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgCUVDZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:03:25 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55301 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgCUVDZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:03:25 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so4140850pjb.5;
        Sat, 21 Mar 2020 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISJDxYcNYwrHzHLY1hairRUTWGOjeAfmeJMLZDyJzbM=;
        b=RA7I2FyCwTXqAIFLyAcHsYuaPekEEPhXzhOyMHBed7fO5es13LbkG+NQel8BIK6wGj
         ZGkfBtMOtj0gaY2hg/zh+kLNHHqHiT6aPTqjyODcoGF497kddcLgz6jEDpa2teBrZ8t1
         12DN3xOu6cgrsKJzK5wBhPOpH0LccPdN9ysKsaAbgS3PZAG7ViCpJGlWIAtKooAYL2YW
         5sQ5dAjDQeEb6lWAit/zPwtl5jRcHEA4FuPMkjdXpoYAU3uCymLDn7o7XgtsrZpM4NZp
         qd0G6CmZNoqfklflZvo6Wbv+BACM7y473NTLi47KnTlC4JZWSon5J2OXxPexpRU++aqr
         B/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISJDxYcNYwrHzHLY1hairRUTWGOjeAfmeJMLZDyJzbM=;
        b=i+J2tPOT4cd6htPJrHRv3tt8L5nCAei7bR3B5bsjYmCWA3YjVG/FNliNO/+e/g+2Mh
         E6xObYPJB9nm3EK3kCH7PwvdE5HNua6ZAosafyjaNjnHVCbg6aBDbhvAVpzvaLgY+U3E
         l2VbE/yy+VHx9d1Ejfonq3XQ5NwJVIxnhcRlx4GX+MqlBt0ItTkgsuVkCgPPiu1bK4lD
         QevHvEJ7VjsUDDJqF+Vm5qFroS8tOBcmJVjp2TSsTJjrUXVMrJZt+rNZVFg/ieTPmJ83
         5I+V3+Sb8ZIH/MTGRvIFYIeq8h52stzidEnvMilASQSeH9Lx0sv35SHsVWFfCB1j9wSI
         pRuA==
X-Gm-Message-State: ANhLgQ2piLCLlguQyTP227+JOkXo8Te0BfskPbNDNr3RtepS7/lqvdll
        pFnRD5t/USQ6QGJaejFAynNC0yrfSak=
X-Google-Smtp-Source: ADFU+vvajlpR5QRnV3pGnxcrHEBhRSUrvVqR6LmKzk8FmuW7RRq8AbM6m7Pjc8w2az+lOimebYxdeQ==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr14561917plf.255.1584824602950;
        Sat, 21 Mar 2020 14:03:22 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id f45sm7839396pjg.29.2020.03.21.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:03:22 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] iio: st_sensors_spi: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:32:04 +0530
Message-Id: <20200321210204.18106-14-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321210204.18106-1-nish.malpani25@gmail.com>
References: <20200321210204.18106-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide more suitable format specifiers while printing error logs.
Discards the use of unnecessary explicit casting and prints symbolic
error name which might prove to be convenient during debugging.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Based on conversations in [1] & [2].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
---
 drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 1275fb0eda31..052fb21f2769 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -101,8 +101,8 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_spi(spi, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap (%pe)\n",
+			sdata->regmap);
 		return PTR_ERR(sdata->regmap);
 	}
 
-- 
2.20.1

