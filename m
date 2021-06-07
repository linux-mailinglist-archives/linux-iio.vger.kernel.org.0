Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3926F39DF2F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFGOui (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:50:38 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:36742 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhFGOug (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:50:36 -0400
Received: by mail-qk1-f178.google.com with SMTP id i68so13302539qke.3;
        Mon, 07 Jun 2021 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZEpqN5lTrDO7dxKwL5kRWjhFH4pUfCWGaaBkcuE30k=;
        b=UAxsYIy8bY8fL1e4mALCCxIFxxf0DGNT6fWLklHjZ3iV5VxX1AgFx3oy21r0KV7xMz
         OU9C10msXrzC4uwHYMFDZbJlHYgZDixraYinhL7VicS/TGHmxz1ExNZQmKpWg1Eiltj9
         DBObshrm3oKFTW1NNyUqpe65vyUJT/qLA0u7un7diRoO8WN+iKW8WmSkZ9lMqUGLacrm
         TuDYKV3nRegtVibkm/HfgAjBPHADT3SBn26G9WvHDmBhAb72pz/jRfg0dNjbMQg+6RYm
         71Ee8tJk+CVJD6QwmFvJXmuoFmh7CMSZoHOIp8hfKAqriqx2+SScd/fgVZweTovkXN51
         s7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZEpqN5lTrDO7dxKwL5kRWjhFH4pUfCWGaaBkcuE30k=;
        b=X55d9TJKkhiQOmAkLtvTtgUDhwdUM/IsbDsV5tOTxdE6Tyh57xgZUTDYR6y2QJULpe
         RbSWnm5nPR0EH3C9DFWxuislgLHrMXmOS+eit3p1Ds7aicFu0eIMYKytu9ClE2tOTQ01
         V0jw2O/7QzOOoeLXT8qNU7pp/c9Ff5fpgT3j2bKznmWBDdvadCHAggeROiFMTHk/AEfr
         BLSK2bWjPS5yVot3xjBdDmHrflrPnOrbqu9F9HVjKY/G3c+z+Mq+3bPSiwNILIWBI/se
         +S+gCGnuiknrTUY3e6SAPnQ5v/6ZQYIh1kMWG7e2iGeGLLxTqA6l2va7BKCaOyaj3Caw
         mW+A==
X-Gm-Message-State: AOAM5310IfT0mxAqtG6ueTQGYduXBqzNMt9GNmcVGHLP9gNP4Md3riUx
        taMG9KvdH5YEKT7ZOjF4r1s=
X-Google-Smtp-Source: ABdhPJzP7D2Di8IfZFHm+qtPNryI4oP9/7XIu5uDL7X92h2b6+0rX+F7hbZCE3/Q7U+qumFYZiq04A==
X-Received: by 2002:a05:620a:1675:: with SMTP id d21mr16678498qko.390.1623077252084;
        Mon, 07 Jun 2021 07:47:32 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:31 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 4/8] iio: inkern: return valid type on raw to processed conversion
Date:   Mon,  7 Jun 2021 10:47:14 -0400
Message-Id: <20210607144718.1724413-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

iio_convert_raw_to_processed_unlocked() applies the offset and scale of
a channel on it's raw value.
The processed value returned is always an integer. Return IIO_VAL_INT so
that consumers can use this return value directly.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0b5667f22b1d..00d234e87234 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -618,7 +618,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		 * raw value and return.
 		 */
 		*processed = raw * scale;
-		return 0;
+		return IIO_VAL_INT;
 	}
 
 	switch (scale_type) {
@@ -652,7 +652,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		return -EINVAL;
 	}
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
-- 
2.30.1.489.g328c10930387

