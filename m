Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC556B0283
	for <lists+linux-iio@lfdr.de>; Wed,  8 Mar 2023 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCHJMy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Mar 2023 04:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCHJMw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Mar 2023 04:12:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0EBA3378;
        Wed,  8 Mar 2023 01:12:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e13so14612544wro.10;
        Wed, 08 Mar 2023 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266766;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42Tebu01feBjjmnfdSuFij+fK1V/+T2ggLj9HPy2k2A=;
        b=BwDGpmRLGGevxzbXxe2kQZVQzqxqnTsPC4MmBdNBicw4Ha3q09zO3ROZuY2CP3MZFo
         2e9V1irp3BVx47yDhZ0t8WzO1/SqRUSkpQmx2GHDZERkkg/TynusNYg+Gjb+L7r1lXe5
         zpHZ2HU/TmvK+F/nBUd7SsGwgC3JkIzXldgttq3Cpdj5NnhY7MEunMbAWK2koJlY7e2r
         k/2ymkZzT+SazxQ6JRbFA83bLgX20mZfqJC5qfVavU0uDpYTih9zVxsjdbpYFfKo9dKi
         J0p4wt8ByIj9fFxsSapw3jrgyvxsNdnJiAlB1LvEmNT5rHMuC8mdwhgk62eQB/scLRqj
         g4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266766;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42Tebu01feBjjmnfdSuFij+fK1V/+T2ggLj9HPy2k2A=;
        b=klgEMDqCnZi1hDK7NwnxEyJXvDiooI/gJ44c7eIM+ySRtJ3TRisfwpMp0Z5CVWDblK
         HaUMkbiCCMpnDtpx/QjKib7xWf+IN6jAREp5jb3jhCtNEV27fxp09C1GezZlG2jZ8MdL
         VDW70y4JRJYgZeb6tKDfz7k2iBWN9sOPo1uFwNXe3ut0ExY0UO14w4t3Jy0b2tEaPhEl
         Nnzic/IUbL4EL7+DOEk4Tj3Y1viWJzFKvSoZsF29wH9j1oLLBlcLIQaggryIJ5xZ8QT5
         UrEa/eV/myv1NlQ7hd+djN4CyCN9fucMupDymaF6k7/7d1lEPD1azkQoygYDr6QGvl+2
         V8sg==
X-Gm-Message-State: AO0yUKWVk2UUvRIFw+lQ+QJvLH4JskwRUypYGgLz09TkKkwBBp3SZVLh
        dslkGITIidh/1HK8CVKzKIw=
X-Google-Smtp-Source: AK7set/AePNSu3Roc2C/uKr4V6FQ6Lp8IK+7vZyXjHle7GZFLuXe/Nyr48LLqEhLqoBv9kpSBlX9TA==
X-Received: by 2002:adf:e34c:0:b0:2ca:8995:38d with SMTP id n12-20020adfe34c000000b002ca8995038dmr12132661wrj.16.1678266766567;
        Wed, 08 Mar 2023 01:12:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b002c58ca558b6sm14567141wrr.88.2023.03.08.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:12:44 -0800 (PST)
Date:   Wed, 8 Mar 2023 12:12:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Irina Tirdea <irina.tirdea@intel.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: magn: bmc150: add a lower bounds in
 bmc150_magn_write_raw()
Message-ID: <94939714-a232-4107-8741-8867038b03ae@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The "val" variable comes from the user via iio_write_channel_info().
This code puts an upper bound on "val" but it doesn't check for
negatives so Smatch complains.  I don't think either the bounds
checking is really required, but it's just good to be conservative.

Fixes: 5990dc970367 ("iio: magn: bmc150_magn: add oversampling ratio")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 06d5a1ef1fbd..c625416b8bcf 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -537,7 +537,7 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val > data->max_odr)
+		if (val < 0 || val > data->max_odr)
 			return -EINVAL;
 		mutex_lock(&data->mutex);
 		ret = bmc150_magn_set_odr(data, val);
-- 
2.39.1

