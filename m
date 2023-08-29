Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8D78C362
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 13:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjH2LiL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 29 Aug 2023 07:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjH2Lhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 07:37:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF43129;
        Tue, 29 Aug 2023 04:37:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZlfs5vQSz67K8h;
        Tue, 29 Aug 2023 19:33:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 12:37:43 +0100
Date:   Tue, 29 Aug 2023 12:37:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mighty <bavishimithil@gmail.com>, <lars@metafoo.de>,
        <liambeguin@gmail.com>, <linux-iio@vger.kernel.org>,
        <peda@axentia.se>, <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
Message-ID: <20230829123742.0000033e@Huawei.com>
In-Reply-To: <CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com>
References: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
        <20230824073933.80-1-bavishimithil@gmail.com>
        <CACRpkdYOpz7gDQsM+tgxj7sjKzv8FtehEsjezD8_bpDk-F_b=A@mail.gmail.com>
        <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
        <20230828191859.2cced5cb@jic23-huawei>
        <CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Aug 2023 09:17:00 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Aug 28, 2023 at 8:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Not 100% the follow is relevant as I've lost track of the discussion
> > but maybe it is useful.
> >
> > Worth noting there are a few reasons why RAW and PROCESSED can coexist
> > in drivers and indeed why SCALE can be absent.. (OFFSET is much the same)  
> 
> That's fine. If we have PROCESSED the rescaler will use that first.
> 
> What we're discussing are channels that have just RAW
> and no PROCESSED, nor SCALE or OFFSET yet are connected to
> a rescaler.
> 
> > 1) If SCALE = 1.0 the driver is allowed not to provide it - the channel
> >    might still be raw if OFFSET != 0  
> 
> I'm not so sure the rescaler can handle that though. Just no-one
> ran into it yet...
> 
> > 2) If the channel has a horrible non linear and none invertable conversion
> >    to standard units and events support the you might need PROCESSED to
> >    provide the useful value, but RAW to give you clue what the current value
> >    is for setting an event (light sensors are usual place we see this).
> >
> > 3) Historical ABI errors.  If we first had RAW and no scale or offset because
> >    we had no known values for them.  Then later we discovered that there
> >    was a non linear transform involved (often when someone found a magic
> >    calibration code somewhere).  Given the RAW interface might be in use
> >    and isn't a bug as such, we can't easily remove it.  The new PROCESSED
> >    interface needs to be there because of the non linear transform..
> >
> > Odd corner cases...  In this particular case the original code made no
> > sense but might have allowed for case 3 by accident?  
> 
> I think it's fine, we make PROCESSED take precedence in all cases
> as long as SCALE is not there as well.
> 
> rescale_configure_channel() does this:
> 
>         if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
>             iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
>                 dev_info(dev, "using raw+scale source channel\n");
>         } else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
>                 dev_info(dev, "using processed channel\n");
>                 rescale->chan_processed = true;
>         } else {
>                 dev_err(dev, "source channel is not supported\n");
>                 return -EINVAL;
>         }
> 
> I think the first line should be
> 
> if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
>     (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE ||
>      iio_channel_has_info(schan,IIO_CHAN_INFO_OFFSET)))
> 
> right? We just never ran into it.

Makes sense to me.

Jonathan

> 
> Yours,
> Linus Walleij

