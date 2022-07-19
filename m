Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7723657A187
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiGSOay (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiGSOab (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 10:30:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A859E88
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 07:19:06 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnLWP17W8z67wr1;
        Tue, 19 Jul 2022 22:17:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 16:19:03 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:19:02 +0100
Date:   Tue, 19 Jul 2022 15:19:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC] iio: multiplexer: Copy scan_type details from parent to
 child
Message-ID: <20220719151901.000020cf@Huawei.com>
In-Reply-To: <f845f910-fb46-e38e-b4e2-709ae4da006b@axentia.se>
References: <20220718184312.11840-1-macroalpha82@gmail.com>
        <20220719095116.3dc46f3a@jic23-huawei>
        <f845f910-fb46-e38e-b4e2-709ae4da006b@axentia.se>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jul 2022 15:27:24 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> 2022-07-19 at 10:51, Jonathan Cameron wrote:
> > On Mon, 18 Jul 2022 13:43:12 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> >   
> >> From: Chris Morgan <macromorgan@hotmail.com>
> >>
> >> Copy the scan_type details from the parent iio channel to the child.
> >> The scan_type is otherwise empty and things like the storagebits are
> >> zero (which causes a problem for the adc-joystick driver which
> >> validates the storagebits when used through a mux). I'm submitting this
> >> as an RFC because I'm not sure if this is the correct way to handle
> >> this scenario (a driver that checks the storagebits used with the iio
> >> multiplexer).
> >>
> >> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > Seems sensible to me. Though Peter is expert on this one.  
> 
> I really doubt that it is this simple. I'm no expert on buffered channels,
> but after a quick look it certainly looks like adc-joystick requires
> buffered channels. And iio-multiplexer does not support that at all. I
> think it could be supported, but in that case the only obvious support
> would be to support buffered channels one at a time, and the way I
> read adc-joystick it expects to get one sample for each axes in one
> go (i.e. the way "normal" ADCs deliver multiple parallel samples). See
> e.g. the call to iio_channel_get_all_cb in adc-joystick, which dives
> right into the buffered iio department.
> 
> So, the stuff in scan_type (along with scan_index, which is highly
> related) is only relevant for buffered channels, and iio_multiplexer is
> currently limited by its
> 
> 	indio_dev->modes = INDIO_DIRECT_MODE;
> 
> which is ... not buffered. :-(
> 
> The simplest way forward is probably to lift the requirement of buffered
> channels from adc-joystick, but that might be a hard sell as that driver
> would then probably be a lot bigger and more complex.
>

Got it in one ;)
There is a recent series from Chris adding polled support to adc_joystick (not yet merged)
https://lore.kernel.org/all/20220705190354.69263-1-macromorgan@hotmail.com/
That just reads the channels one at a time via same interfaces used for
sysfs reads so would work with the iio-mux I think.

Jonathan

> That said, I would of course love to see the generic solution with support
> for buffered channels in the mux, but my guess is that that gets much
> more difficult, at least if you need the kind of buffered support
> expected by adc-joystick.
> 
> Or, am I misreading the whole situation and you have actually gotten it
> to work with the below one-liner? If it works, fine by me, but I think
> you also need to do something with scan_index?
> 



> Cheers,
> Peter
> 
> > One comment on the comment inline...  
> >> ---
> >>  drivers/iio/multiplexer/iio-mux.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> >> index 93558fddfa9b..1de01ec878c4 100644
> >> --- a/drivers/iio/multiplexer/iio-mux.c
> >> +++ b/drivers/iio/multiplexer/iio-mux.c
> >> @@ -322,6 +322,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
> >>  	if (page)
> >>  		devm_kfree(dev, page);
> >>  
> >> +	/* Copy scan type from parent to mux child. */  
> > Comment is in the obvious category, so drop that.
> >   
> >> +	chan->scan_type = pchan->scan_type;
> >> +
> >>  	return 0;
> >>  }
> >>    
> >   

