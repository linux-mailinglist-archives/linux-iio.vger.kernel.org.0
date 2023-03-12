Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02936B6749
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCLOpv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCLOpu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 10:45:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71B41B50;
        Sun, 12 Mar 2023 07:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8AFBB80B01;
        Sun, 12 Mar 2023 14:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D7C433EF;
        Sun, 12 Mar 2023 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678632345;
        bh=U29WGS9Lk3M1R4JOX0nWOxZypymAplwjapVIZtIG3Es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g7yJQEGufynQIOpKBRQWiOWvtuVnUaYr7gvy6SzpfIo7H+7Cs2dWqqYLpeNECvUM9
         cFESFwC7iIhA9iTEoY9KInJHGPb761ulHJH8UGgQ8+yOUR9GkpYvbNxl8DImi/XGFV
         yLpGjyhuYQt1+Y8wb69JrZMeG8323HqMXIZzGNH8AmvxtjYihCA7axDBw8jsxt7YJX
         1lnAfroGdol2HLbLufqjLutwslegTYIHQksxTPGM4MvlzlvUJjomF5UucX7fTpBrwX
         wEIM4xCVCa1CucUqWJsL0oZK8swRzdiGE9buw1lg1OwBGLUzNCShODxq4Bk+ITrElC
         ladtH0iAs50Rg==
Date:   Sun, 12 Mar 2023 14:45:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Irina Tirdea <irina.tirdea@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: magn: bmc150: add a lower bounds in
 bmc150_magn_write_raw()
Message-ID: <20230312144551.2baf3e8b@jic23-huawei>
In-Reply-To: <94939714-a232-4107-8741-8867038b03ae@kili.mountain>
References: <94939714-a232-4107-8741-8867038b03ae@kili.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Mar 2023 12:12:37 +0300
Dan Carpenter <error27@gmail.com> wrote:

> The "val" variable comes from the user via iio_write_channel_info().
> This code puts an upper bound on "val" but it doesn't check for
> negatives so Smatch complains.  I don't think either the bounds
> checking is really required, but it's just good to be conservative.
> 
> Fixes: 5990dc970367 ("iio: magn: bmc150_magn: add oversampling ratio")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Hi Dan,

I think this is more complex than it initially appears.

bmc150_magn_set_odr() matches against a table of possible value
(precise matching) and as such you'd assume neither check is necessary.

However, for a given configuration not all values in that table can
actually be set due to max_odr actually changing depending on other settings.

My immediate thought was "why not push this check into bmc150_magn_set_odr()"
where this will be more obvious.  Turns out that max_odr isn't available until
later in bmc150_magn_init() than the initial call of bmc150_magn_set_odr()
 
Whilst I 'think' you could move that around so that max_odr was set, that's not quite
obvious enough for me to want to do it without testing the result.

So question becomes is it wroth adding the val < 0 check here.
My gut feeling is that actually makes it more confusing because we are checking
something that doesn't restrict the later results alongside something that does.

Am I missing something, or was smatch just being overly careful?

Jonathan


> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 06d5a1ef1fbd..c625416b8bcf 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -537,7 +537,7 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val > data->max_odr)
> +		if (val < 0 || val > data->max_odr)
>  			return -EINVAL;
>  		mutex_lock(&data->mutex);
>  		ret = bmc150_magn_set_odr(data, val);

