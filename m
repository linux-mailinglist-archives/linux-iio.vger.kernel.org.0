Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B4B1355F
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfECWQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:16:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45659 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECWQZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:16:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id d5so318007qko.12;
        Fri, 03 May 2019 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HXos2jVvt23sEGQ2FQBQJsKRHBVFtxk8JTRDuuOZjhU=;
        b=cshVJY3SgZerxIj0AHhggAibB5NZbPleKezdrPUdWojsti39ecMZQU/GdNIbxlhrYu
         jkcn/oslpB1yTTpXF5+cBKLS3JTLfkGsWuWlqNRp8FnSXSGjdhUaoRcxaB1fiwkFL28O
         L8H8TCMUJ64MaQZlHsePK5mBFq/OsUqCFBRpE3LwHv6ed7Eetpxhhrz7G1ipwt8RoLFN
         2VxwMozP6w/7IccThhvPKf1UDFw5oTJ6FvZ0czG4U3APBy1gnCnlp56lNnluraNqwx5Y
         coAUj0L4rf/TTiwYb+DdbQmjk/OcVSqM61xn4FvLzjJdUWlBncBeNs0UGumszChPweLZ
         gS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HXos2jVvt23sEGQ2FQBQJsKRHBVFtxk8JTRDuuOZjhU=;
        b=Bw24jrWtsjDfnymean2rC2GD2JiQ6oLX04UKReZ4oIFHnlZcjqPMbl5V1X3KlMC7PG
         ygVh7PhMTXvTqKTizDtbNEIP9wVWQx4wKCB1EZOltbX/GSQIXpDP7uwZBvXndcL2+8bI
         iJW9aruRh5oDKDxEp7jYDdLaDijcSh1W5qAtnDftBrV9XaR5PLD7MWNmk7QeFlPWMFvJ
         hwhORWl9nBYZk8wCNy84oFKHCtnDxGI7F3ueloZkFyFyzdVNAwvcHGWlNGOvr0tLLz4s
         KmSezMPh7glblmIOcQdCA4N8/SRGmlyWsjXWnQo3MB2prtdlR/G/Qx3aR4nHoX+HMcbn
         VJwA==
X-Gm-Message-State: APjAAAWT2TUId3UPpWcbp6mlbs3Yy7nqJE5crQTdbkzuMnUQKLWL1mo7
        Ru9AYBgUO/sFVKvZDa4Lzjg=
X-Google-Smtp-Source: APXvYqwloUvPCdvnkCdnkj6YxY613wMJymZiRu4zYZ9KXa+nkanvvNwayrSaDiyLrWtFFgviThhyZA==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr8885799qkj.265.1556921784672;
        Fri, 03 May 2019 15:16:24 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j39sm2050285qtj.69.2019.05.03.15.16.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 15:16:23 -0700 (PDT)
Date:   Fri, 3 May 2019 19:16:13 -0300
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
Subject: [PATCH 4/4] staging: iio: ad7150: clean up of comments
Message-ID: <35ccb46902d0a9a79b5c481d3d3cb9256a390c99.1556919363.git.melissa.srw@gmail.com>
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

General cleaning of comments to remove useless information or improve
description.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 3a4572a9e5ec..775818b0761e 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -162,7 +162,8 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-/* lock should be held */
+/* state_lock should be held to ensure consistent state*/
+
 static int ad7150_write_event_params(struct iio_dev *indio_dev,
 				     unsigned int chan,
 				     enum iio_event_type type,
@@ -484,10 +485,6 @@ static const struct iio_chan_spec ad7150_channels[] = {
 	},
 };
 
-/*
- * threshold events
- */
-
 static irqreturn_t ad7150_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -576,10 +573,6 @@ static const struct iio_info ad7150_info = {
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

