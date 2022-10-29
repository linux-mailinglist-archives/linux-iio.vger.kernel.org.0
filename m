Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1F61242E
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ2P2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2P2D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 11:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE9956016;
        Sat, 29 Oct 2022 08:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A97F60AFF;
        Sat, 29 Oct 2022 15:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAA2C433D6;
        Sat, 29 Oct 2022 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667057279;
        bh=S4bpRu0FVsMSPhlwgV3ljsWKf3miW7HmEgml5YUYsLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHKzb6MBVx1mBs8xUN18pWQvn5yjlTtFF2ay+UyPLWMvTcbB7wdo2/xI1RK8C0JBI
         dlvzjcKgif1I2kpjdnOXt/gFNo2WjV8Us5lp5DqFZrLMyLdUy/XCW6KB2twvDAH9qk
         w7qKHme3+1E3ITueUTo/uI+qy2XPGUala65/Viskh+IyoPoDbBRn9D7P2sdRmD2fOL
         2wINI3TbGOcgRBs44gFccrMWm0Mr+/x8BjMr19pLcUcn5FlXRn2CLwloBwucESK/pk
         vb/rT1bBLreLacBQXGqqcBrwINlODWpRF/XuJsMtpFcVsAZTXmTGuuDgyjb8CeM4Vh
         Cg6I0ZCgTzvig==
Date:   Sat, 29 Oct 2022 16:39:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrea Merello <andrea.merello@iit.it>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: uninitialized variable bug in
 bno055_trigger_handler()
Message-ID: <20221029163956.2a70dc94@jic23-huawei>
In-Reply-To: <20221015173359.20c7928e@jic23-huawei>
References: <Y0kuaO9PQkSQja+A@kili>
        <20221015173359.20c7928e@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Oct 2022 17:33:59 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 14 Oct 2022 12:39:52 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > This bug is basically harmless, although it will trigger a runtime warning
> > if you use KMSan.  On the first iteration through the loop, the
> > "best_delta" variable is uninitialized so re-order the condition to
> > prevent reading uninitialized memory.
> > 
> > Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>  
> 
> You reported this a while back along with a second issue (false positive)
> with hwval.
> 
> I posted a patch fixing both 
> https://lore.kernel.org/linux-iio/20221002145324.3776484-1-jic23@kernel.org/
> 
> I don't really care which patch goes in, but curious to reasoning to not also
> deal with the hwval warning here?
> 
Meh. Rather than not applying either patch, I'll pick this one up.  We can
deal with the hwval warning at a later date if necessary.

Applied to the fixes-togreg branch of iio.git.

Jonathan

> Jonathan
> 
> > ---
> >  drivers/iio/imu/bno055/bno055.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> > index 307557a609e3..52744dd98e65 100644
> > --- a/drivers/iio/imu/bno055/bno055.c
> > +++ b/drivers/iio/imu/bno055/bno055.c
> > @@ -632,7 +632,7 @@ static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
> >  			return -EINVAL;
> >  		}
> >  		delta = abs(tbl_val - req_val);
> > -		if (delta < best_delta || first) {
> > +		if (first || delta < best_delta) {
> >  			best_delta = delta;
> >  			hwval = i;
> >  			first = false;  
> 

