Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3824A46434
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfFNQcb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 12:32:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNQcb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2019 12:32:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so3170995wrl.9;
        Fri, 14 Jun 2019 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bk25I9bYJ1QkQE44oNBhQvDFUFwOGY+qKAFcfRif1YY=;
        b=u0OqxJ8w+zUXf1Wq56t/UtX2iY9Bnt5XmPJgxTE76bhzUIwdkWTp/aq3zzK03/kx3G
         dBfQWt76sNup1zwZxbZF4HN6BCuOrCg5ab+ng6DvY8Ec1l+7n3mNR4nQVWp/m2Rsnquh
         QoODp8H8okYFK9mawBvo7m9h4/AIajPEQO766drLGTyaCWQqnVmwMuYqNiishkrjoL3S
         fc+ZqTQVs5pw9P/1bk0qTZnK2u3slwLYu4BZouFS/B3JZNkloh1uvgDxjOd37MGXVXQ7
         XTwy8p01wNLRjcdPQiJjl//zitZjiGh3l+NUV7y3Uql76uRrJSGoaPJnyVH7Weg0pV7d
         M3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bk25I9bYJ1QkQE44oNBhQvDFUFwOGY+qKAFcfRif1YY=;
        b=n1mwd7eqhRlG4Z2Mtag+ELwKt1qaz1t2ekjH1xEXgbjP1fQJr2YeYgQnQWKzhZ5kNW
         RxH8fiRJH0cY3g4ifUnYWeYTf/JPiB9O0lqW7WZadTsN08Ue2dmQ1GyHhaCGj23Ner1f
         nAq33utULbOC4gWppFro2yKRCGD6C7LF2QrtaP0MeLTM6T2hniY9WF9vIGlfek0G7QNw
         KYBxeqIzY4vfo/pHklv9MEWaUdPEznLLqfnXNbrQPsCE/kJ+7mthLQoJw3bR3FP0JY+m
         VQTM3f7cy+UCWgUADHkTRr6A8Vp82yHkB/UJrSMjtszwpyql6FQCN8VsVexrv0xxBwRM
         49IQ==
X-Gm-Message-State: APjAAAUGydPmYHfkbDWgnHQwYLBl2908DOYx7szYAgmMUGQCBjiQ4hoE
        1Et6S1IrSLlN+khSU4sUjIk=
X-Google-Smtp-Source: APXvYqwCqZPFUEltPB18dZHXPPr0GSGxTfJkT0oIbrSP8s/I7DkUQUrJKgTZImT1/eaVo9AJ0TapSg==
X-Received: by 2002:a5d:620f:: with SMTP id y15mr8792301wru.262.1560529949634;
        Fri, 14 Jun 2019 09:32:29 -0700 (PDT)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id d17sm4880775wrx.9.2019.06.14.09.32.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:32:28 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:32:21 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 1/3] staging: iio: ad7150: use FIELD_GET and GENMASK
Message-ID: <4f88fd66e478289006353645d84b7af1b5aa345c.1560529045.git.melissa.srw@gmail.com>
References: <cover.1560529045.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560529045.git.melissa.srw@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the bitfield macro FIELD_GET, and GENMASK to do the shift and mask in
one go. This makes the code more readable than explicit masking followed
by a shift.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 8234da4b8c65..091aa33589d7 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -5,6 +5,7 @@
  * Copyright 2010-2011 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -45,6 +46,9 @@
 #define AD7150_SN0                 22
 #define AD7150_ID                  23
 
+/* AD7150 masks */
+#define AD7150_THRESHTYPE_MSK			GENMASK(6, 5)
+
 /**
  * struct ad7150_chip_info - instance specific chip data
  * @client: i2c client for this device
@@ -137,7 +141,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	threshtype = (ret >> 5) & 0x03;
+	threshtype = FIELD_GET(AD7150_THRESHTYPE_MSK, ret);
 	adaptive = !!(ret & 0x80);
 
 	switch (type) {
-- 
2.20.1

