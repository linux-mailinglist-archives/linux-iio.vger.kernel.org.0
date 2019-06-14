Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEADE46441
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFNQd3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 12:33:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35224 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfFNQd3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2019 12:33:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so2948215wml.0;
        Fri, 14 Jun 2019 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fFqxIRcGH8oZzLwiEq09xzWUQlnGrozgrNZLPkvhIj4=;
        b=YNTWic+1630gnNTb8Sch4/BCNM++THosM5ESxK7efvK/NDqX1sXG4qNMCR5f5rC1nd
         n8QoPEdC1SHcx6nrTfTfubnsLaC7ny7AtItLgAGfU/TO02I7g9RT1kd2I1IW+T2/mu6i
         MV029DbEAYFmZR8tXvdtpd0uyW4verAT15QQTJeznWlLfI5+aXkZnl2/Zv7T3kDoxtzQ
         4aI/vsNRAEM7Wym4D892XSVxXOrjiQogg2yJWUMZzdcZNLK6IS+vjMioakjvaVS/RXrW
         /gRQCdbIWWW31q7fRau0RSX1yqM2cdgqSZmLL2Me1dtzHXB13BViKgWORjzqDoDOxP+v
         RuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFqxIRcGH8oZzLwiEq09xzWUQlnGrozgrNZLPkvhIj4=;
        b=lRT5+UX9r8GP9SOId7z68ykoNkgBBATBY20lgfSelipQJBtv/Fkj5Cc1F4OoMd+Yeo
         6hI4Og1sXiArOIGl+HCIm/BVbk3yVoKYNlvrWxdMhbWuXePUBxPNDycv4oVR8QLX+T/X
         7h16SWQzJ6n8Q1OgsNXvXVXhzkYZZZrcOeP9nVHq46Cc41iCYiz3mNpgOH3L4oXQaLB1
         IlqSLnaNmeCZ/EBcDEGHSJQFZKdMx6Wo6KP1ZoHzAbh5fh/85yPdZCB03N/1ia0uzJO1
         NIUIJlX1Hccfvc0jbW8uL7yBp29FIJNSmKMvgSYDY3iju27j6ZE7J+1t9r3BVfcwCUMj
         wnkA==
X-Gm-Message-State: APjAAAVeKV8o/UAnCslFq1GErASCLadhPceXg2PaUIPnpplXNEhrC/dX
        VUTiQYNchPUHzYVEZEcPI4A=
X-Google-Smtp-Source: APXvYqz0OZbvPa2/1qYozLjynroXmsbH+4PiBzYOo8j3wFczAh/yCK9MUv672sSvaRrw7qPIY0NPgg==
X-Received: by 2002:a1c:452:: with SMTP id 79mr8895726wme.149.1560530007368;
        Fri, 14 Jun 2019 09:33:27 -0700 (PDT)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id y6sm2864580wrp.12.2019.06.14.09.33.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:33:26 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:33:19 -0300
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
Subject: [PATCH v2 3/3] staging: iio: ad7150: clean up of comments
Message-ID: <a88f36a998eb3fc91cc70bc8fc76e3614706cdbe.1560529045.git.melissa.srw@gmail.com>
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

General cleaning of comments to remove useless information or improve
description.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 7d56f10a19ed..51d6b52bce8b 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -163,7 +163,8 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-/* lock should be held */
+/* state_lock should be held to ensure consistent state*/
+
 static int ad7150_write_event_params(struct iio_dev *indio_dev,
 				     unsigned int chan,
 				     enum iio_event_type type,
@@ -479,10 +480,6 @@ static const struct iio_chan_spec ad7150_channels[] = {
 	AD7150_CAPACITANCE_CHAN(1)
 };
 
-/*
- * threshold events
- */
-
 static irqreturn_t ad7150_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -571,10 +568,6 @@ static const struct iio_info ad7150_info = {
 	.write_event_value = &ad7150_write_event_value,
 };
 
-/*
- * device probe and remove
- */
-
 static int ad7150_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-- 
2.20.1

