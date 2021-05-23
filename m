Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6429438DC19
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhEWRNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhEWRN3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:13:29 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A271C061574;
        Sun, 23 May 2021 10:12:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o59so13048107qva.1;
        Sun, 23 May 2021 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cWkW7YZCHAm4pyy3lSS9WKOT49WrgEzTAvg74zMHMjM=;
        b=A9KpUksGilU2qYWa3EBXb3HoXKhU/fhbXwShcPp5/icop3aJxNj7N5xfniHJwtFKtq
         MNit3H/qoGVovfeNjKjeA3Vsq2cvxqWm2uJQnqJ6LZ6xJSQIAAUvlUPpVPHy2bsSYZOW
         PWNuCpJH2jZy/VxPnX4dPDhfv4T0HvLnSp0Q2IbEGCifd7hMbM1HTrvk2VYvXEL5k61m
         RVj4nfxTqqgxPgjxtCPBnucpEp1aISdtDapwQd65aUOHziroA2cO223K4Un/YDMeooZ8
         FcIVmi1y3Fcq07EXxnfRJ3wXQXtj7OpzfPpvb2ZvxtZ2Xrx+ZpVKCJBm9VW2BBdWAwI+
         bBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWkW7YZCHAm4pyy3lSS9WKOT49WrgEzTAvg74zMHMjM=;
        b=TUkXkW9gWSrqVzJK01oaDxq2tYB9vyhdZB+i9wH/6jEZ87tauRiuSKXbMJhTQXf+85
         CFgs8IKogbosRAh0nJKx6ozH3/9x26n2mC+aICAXGX1/Ex/RV4FBhwZpZhYwJQSToVz4
         UC/Yom74ua1GZ1Sh+t7i2A9W69y4VdZBl7p6G7Y5XXdWynwMefRCIJ6QxR9wCOX58ulU
         nG52+WWgM+cKHdyRz9//knaM50rjnURfAGTDKyWN+KHJoQx0PgUPcuGE/mUYAVBtWqMd
         6EInCq+0q5tNnqCs0BbgEIJ2GMrE7q1vvYTTtRRPCTBT7WlMJfaG9whDVhIaD6qVuPBJ
         pwbA==
X-Gm-Message-State: AOAM531PjyqUIGeb4e8MnOiADJRH0ymG/a2DyyC+5YHjJeFFnJ9NoJpC
        fBT+NFIH0RUThYsH2NMW+Y4=
X-Google-Smtp-Source: ABdhPJz7YKGJaYTbBhzf4mC/3Aeto2nd3Qjgo1xRMFjaAp936ZLFaMNKtuX6oHANG8brCcEIHOaOGA==
X-Received: by 2002:a0c:ecd1:: with SMTP id o17mr20596533qvq.4.1621789921488;
        Sun, 23 May 2021 10:12:01 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1003])
        by smtp.gmail.com with ESMTPSA id w5sm9159633qkf.14.2021.05.23.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:12:01 -0700 (PDT)
Date:   Sun, 23 May 2021 14:11:57 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: iio: cdc: ad7746: remove ordinary comments
Message-ID: <e93e5efb19cee53546a339c1caf1ab344e9ff282.1621786036.git.lucas.p.stankus@gmail.com>
References: <cover.1621786036.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621786036.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove ordinary comments about typical driver structure.
Also align one comment with wrong indentation.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index c42fffa8b60e..12b2554a85b5 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -82,10 +82,6 @@
 #define AD7746_CAPDAC_DACEN		BIT(7)
 #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
 
-/*
- * struct ad7746_chip_info - chip specific information
- */
-
 struct ad7746_chip_info {
 	struct i2c_client *client;
 	struct mutex lock; /* protect sensor state */
@@ -562,10 +558,10 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		switch (chan->type) {
 		case IIO_TEMP:
-		/*
-		 * temperature in milli degrees Celsius
-		 * T = ((*val / 2048) - 4096) * 1000
-		 */
+			/*
+			 * temperature in milli degrees Celsius
+			 * T = ((*val / 2048) - 4096) * 1000
+			 */
 			*val = (*val * 125) / 256;
 			break;
 		case IIO_VOLTAGE:
@@ -667,10 +663,6 @@ static const struct iio_info ad7746_info = {
 	.write_raw = ad7746_write_raw,
 };
 
-/*
- * device probe and remove
- */
-
 static int ad7746_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-- 
2.31.1

