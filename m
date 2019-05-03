Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C397813555
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfECWOr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:14:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39999 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECWOq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:14:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so4584318qka.7;
        Fri, 03 May 2019 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XY7o10BOh3Ussnn5GQ0UW2n/49hS/5+Ve7RxK2jXxNA=;
        b=eREjwxSw2EQeXDa6ksr5nzPOyVNCTRHxcTWHOnVQB7xAzBXKbRlBz1u2a7CTKV3ahr
         uwpsFRonSG8RzXz9Q++OMESMD0wEBw7K8bRAmbByfVG5IL3iqFWRzhC0NHM6HJKkuNBV
         fNxyn4sVWRcJcKF54kGwRhha/HztOU80rQBKjaHKijtVABONs6jEpGBapMrtzmLjcSYA
         3oABiLWxYY23G7oUSdA0GPDx0cOr//BkHKDp/vJyvLeAAbAwjDHJnt0ny4AhDsw6efqY
         7Ug57FMsTz/xaNTWZIPBUlmtH8Q5sG88jy7XuSYFxJTbgQyORvCmiSn8pp9V5SmQ2zQ5
         no1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XY7o10BOh3Ussnn5GQ0UW2n/49hS/5+Ve7RxK2jXxNA=;
        b=Ntw/FqLiDez9IgIe43EjHbdgXFi7I4FOB2TEV4CTYWeHJmFsztoetIkvGg5P+YcalG
         rv7J0cUcz+vwo2zJ+LBh+5PujijEX95UEOwWMng2X9KpteOaNc3/0PreTGjzn7NKRTLn
         MfCUB4x2cQ09LuTXqbV17qpnbzg3WzCENaZNK+8BofQhC4iMV6NImaILGxRnT0ZsXBR5
         4poXyde6tGoPHHQ8mofblLlkYf6n1s2oW1aKOH613/zunXbGwV2fV06kNWk062F52SXn
         Ss2H3Z+GnyHO4jRR3Chdkq8O4OosEhDXeAFKS5FSX3QK1hNRXauGELX+GuzXNZWyg/bs
         JCwQ==
X-Gm-Message-State: APjAAAVpkXszw522e++ozdQ/dCF5fW4Rmy7Goo48JwZcnQRIZJf2bQRb
        8/1u9HftBgQjO7I6oLJCyw0=
X-Google-Smtp-Source: APXvYqy5/bIS6yRa4NkV4HaJxxsvNL19MtRuXYXfmxFxNLAlDYxjEuZ0SK3X0Ba3xKcP90ctdRWWIw==
X-Received: by 2002:a37:2f05:: with SMTP id v5mr10123294qkh.157.1556921685702;
        Fri, 03 May 2019 15:14:45 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 33sm1842035qtg.94.2019.05.03.15.14.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 15:14:44 -0700 (PDT)
Date:   Fri, 3 May 2019 19:14:33 -0300
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
Subject: [PATCH 2/4] staging: iio: ad7150: use FIELD_GET and GENMASK
Message-ID: <7f7d36348bca1de25bd70350b7c665be6441250f.1556919363.git.melissa.srw@gmail.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556919363.git.melissa.srw@gmail.com>
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
index 24601ba7db88..4ba46fb6ac02 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -5,6 +5,7 @@
  * Copyright 2010-2011 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -44,6 +45,9 @@
 #define AD7150_SN0_REG				0x16
 #define AD7150_ID_REG				0x17
 
+/* AD7150 masks */
+#define AD7150_THRESHTYPE_MSK			GENMASK(6, 5)
+
 /**
  * struct ad7150_chip_info - instance specific chip data
  * @client: i2c client for this device
@@ -136,7 +140,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	threshtype = (ret >> 5) & 0x03;
+	threshtype = FIELD_GET(AD7150_THRESHTYPE_MSK, ret);
 	adaptive = !!(ret & 0x80);
 
 	switch (type) {
-- 
2.20.1

