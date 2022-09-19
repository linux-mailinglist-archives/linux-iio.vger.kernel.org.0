Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157515BD1D1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiISQGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiISQG3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 12:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5A82DA
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 09:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3480C6190E
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 16:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34855C433C1;
        Mon, 19 Sep 2022 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603587;
        bh=0CtAFKp+jgQrWFFG1+BL6Fa2OUbowRBJ+FXtO9oofCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o+/rYtvJY/CL6IRZjd/f2Pb8G/D/FM/jrRmPD4iBx9cHhQiI8cW74aiBEwbkiFQ6z
         Notu3Au1iy1tn6TQl4cOb9ox29Ru4YJnzkecFJp1/uizMvQNetFGR1cktMgWA8vnZq
         lh4yFMK+tLWuqFZAshB5LxQ2kXRtsk2jCCWxr3/ceMIh9WWUcEvTPhV7DDYpD0tXg2
         4/PZOaX2hd0qCrUpOEXgNj07sAQspzvaLI3DkqZfJbLadHiD0jH6ZJq0p+1IH4fMZz
         ANosqvlnFCpZ0dnuCnQQrnsykXUqodnB0wX4CH3CeQ3xUTlKvF4oo1HCIu0ykDV4c1
         3xGL84gWAqDJw==
Date:   Mon, 19 Sep 2022 17:06:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] iio: accel: bma400: Fix smatch warning based on use of
 unintialized value.
Message-ID: <20220919170632.2c8c79c6@jic23-huawei>
In-Reply-To: <CAM+2EuKsr0sE8Y2PdR7aqUBSX+65RU-=HcMegiUveoB=XtUMKw@mail.gmail.com>
References: <20220917131401.2815486-1-jic23@kernel.org>
        <CAM+2EuKsr0sE8Y2PdR7aqUBSX+65RU-=HcMegiUveoB=XtUMKw@mail.gmail.com>
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

On Sun, 18 Sep 2022 23:50:44 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

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
> 
> Acked-by: Jagath Jog J <jagathjog1996@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan
> 
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

