Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2372B1161
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 16:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbfILOnk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 10:43:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732654AbfILOnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 10:43:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id l16so28681188wrv.12
        for <linux-iio@vger.kernel.org>; Thu, 12 Sep 2019 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxB2q1Y40lbfz2eJu63DEyuUv8iiUDK1+WsBkxB5X8I=;
        b=GC5qOSUzjcOMMSTkHH3Ts4FYcAwJakJSPuZ54LTM2W98ycN0hoUsTw/Qmqk3WgnnmK
         oMZIa3KmbJsaxsnonDV0/BVEK9y0AB/nQOqEo6m7dRDn62BE5bpqVVnxeJh5CwtAhk0e
         hW/jpeWUoIphs6r1xtVUaEKjFN7GR0lfqBxwyWnomEzaKwwv+z4rcepSwKkhULA1yb+l
         RMNQnGM8RtoHdb2QXKzPmfS5U0HkCh7Xqi/aZzppx5o7SDT9ykRRKn1myUHalWmlbSH4
         cjM4vbsoOWOh/E2Qw/MCxqqSmvCQLNPIkhb8wg47TEkCMPACV7IEL2FFs8vGEldCCkst
         wgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxB2q1Y40lbfz2eJu63DEyuUv8iiUDK1+WsBkxB5X8I=;
        b=f8vkfaTc079A4AhganxQE0w4tLe+ESdG0E8HECOW9+Ak3+NVtRvHEnXovgTXw1sWJy
         uT15veWapf1iPiS2ll+hfi4y0bnDbTq4ZR40H5RC8DpZt/0q849WHgGmFhHQjSihzfR0
         WnUZrB7Yhb1bctsq6GhezOyIU2u47ORgx8NZrybUuyADc/70EE8wEH97e2mGeqxnsq7i
         NqCSQpdT6EgKPemZJk+kTDrDsl3zvGyLIOCRleF4klxnkd71L4sFCDKmTpi8dq35xMxr
         Xp1e9Q4GgzWnRvq0By6oPBaXh/zp4/RxApNpTIsquKI9f2ck7wg1xso2O/Ot+y7K+2Ne
         /BBg==
X-Gm-Message-State: APjAAAVfpSPjAVOr2HO0jcw4BPKwSZA6KlrvmWYLapYHfd8ju99ftDrG
        rJneaK3261nEo/xoX5Y9E/s=
X-Google-Smtp-Source: APXvYqyGlHvAmDME1asPRpaLM+IL53z785wZ6P77jjCH3lfqHAorwB/HmQ5X8EgXNO56jjob0+XrjQ==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr940121wrn.207.1568299417982;
        Thu, 12 Sep 2019 07:43:37 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id q19sm35175256wra.89.2019.09.12.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 07:43:37 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 4/4] iio: ad7949: fix channels mixups
Date:   Thu, 12 Sep 2019 16:43:10 +0200
Message-Id: <20190912144310.7458-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912144310.7458-1-andrea.merello@gmail.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each time we need to read a sample the driver writes the CFG register
(setting the channel to be read in such register) and then it performs
another xfer to read the resulting value.

This does not work correctly because while writing the CFG register the
acquisition phase is ongoing using the _previous_ CFG settings. Then the
device performs the conversion during xfer delay on the voltage stored
duting the said acquisitaion phase. Finally the driver performs the read
(during the next acquisition phase, which is the one done with the right
settings) and it gets the last converted value, that is the wrong data.

In case the configuration is not actually changed, then we still get
correct data, but in case the configuration changes (and this happens e.g.
switching the MUX on another channel), we get wrong data (data from the
previously selected channel).

This patch fixes this by performing one more "dummy" transfer in order to
ending up in reading the data when it's really ready.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/adc/ad7949.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 25d1e1b24257..b1dbe2075ca9 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -85,6 +85,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 				   unsigned int channel)
 {
 	int ret;
+	int i;
 	int bits_per_word = ad7949_adc->resolution;
 	int mask = GENMASK(ad7949_adc->resolution, 0);
 	struct spi_message msg;
@@ -97,12 +98,19 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 		},
 	};
 
-	ret = ad7949_spi_write_cfg(ad7949_adc,
-				   channel << AD7949_OFFSET_CHANNEL_SEL,
-				   AD7949_MASK_CHANNEL_SEL);
-	if (ret)
-		return ret;
+	/*
+	 * 1: write CFG for sample 'n' and read garbage (sample n-2)
+	 * 2: write something and read garbage (sample n-1)
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = ad7949_spi_write_cfg(ad7949_adc,
+					   channel << AD7949_OFFSET_CHANNEL_SEL,
+					   AD7949_MASK_CHANNEL_SEL);
+		if (ret)
+			return ret;
+	}
 
+	/* 3: write something and read data for sample 'n' */
 	ad7949_adc->buffer = 0;
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
-- 
2.17.1

