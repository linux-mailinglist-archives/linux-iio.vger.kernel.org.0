Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B371B5BBF2E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIRRpE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIRRpD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 13:45:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAA12619
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 10:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F1D2B81161
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 17:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23099C433D6;
        Sun, 18 Sep 2022 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663523099;
        bh=gTsTMslYq63p4MPVyfgJBCusWYIPoZb4yRy8hEqJSG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qzm6HNYVZl+ykR4mR4Pb8vugFoVBVj0VkrByw0+oy+pym4eAFuYHFu8Wu6hcxx/su
         gXy4DJQuCvcv3Epd0XGNI08KAB2SkW4QVz9sqtBlISAuf4c/8rJl1leXQrNnN9HPfY
         +vdUX56jwshfYQn0Tb70iW8CbH+e9NiP3Gpn/viAvM5f5hlRUkVmH5bnaioAb8CUdN
         7gJqOR6RODX1w+0prt3Ievm30hAYSasaZUbo6eLJsuu9zA6yawhsq63pXrZHwFNqr5
         aLciPfdKOGQqua97syfHgIOMxG9rnz5+YpRWpfhzQ1m1Wp2vyMU9YX6KJmQNWijLBJ
         2qOVURkriXKYQ==
Date:   Sun, 18 Sep 2022 18:45:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] iio: accel: bma400: Fix smatch warning based on use of
 unintialized value.
Message-ID: <20220918184503.0db7e82a@jic23-huawei>
In-Reply-To: <CAM+2Eu+YCtCMKoWS9yJToEV__YB=enh=54b5thO+q4wGE80wZA@mail.gmail.com>
References: <20220917131401.2815486-1-jic23@kernel.org>
        <CAM+2Eu+YCtCMKoWS9yJToEV__YB=enh=54b5thO+q4wGE80wZA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun, 18 Sep 2022 20:05:48 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for sending this patch.
> If you need a tag for this fix.
> 
> Fixes: 961db2da159d ("iio: accel: bma400: Add support for single and
> double tap events")
Good point. I'm careful about fixes tags to stuff still not upstream
because they tend to be a little unstable. This should be fine.
I'll see if it's valid when I rebase the tree (hopefully in a few days
time).

Also helpful if you give an Acked-by!

Thanks,

Jonathan

> 
> Thank you
> Jagath
> 
> On Sat, Sep 17, 2022 at 6:44 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Only specific bits in this value are ever used and those are initialized,
> > but that is complex to reason about in a checker. Hence, initialize
> > the value to zero and avoid the complexity.
> >
> > Smatch warning:
> > drivers/iio/accel/bma400_core.c:1287 bma400_tap_event_en()
> > error: uninitialized symbol 'field_value'.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Jagath Jog J <jagathjog1996@gmail.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/accel/bma400_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index eceb1f8d338d..ad8fce3e08cd 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -1184,7 +1184,8 @@ static int bma400_activity_event_en(struct bma400_data *data,
> >                                     enum iio_event_direction dir,
> >                                     int state)
> >  {
> > -       int ret, reg, msk, value, field_value;
> > +       int ret, reg, msk, value;
> > +       int field_value = 0;
> >
> >         switch (dir) {
> >         case IIO_EV_DIR_RISING:
> > --
> > 2.37.2
> >  

