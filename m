Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CB1553A55
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353182AbiFUTTJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353336AbiFUTSr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 15:18:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3032BB07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 12:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEE0EB81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 19:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF4EC3411C;
        Tue, 21 Jun 2022 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655839041;
        bh=1jhi3iafwarFxOSCslP/OIgYdypoHz29p/qpmigwE8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZSrpuaPWA2Yo0F/mEOjNQH+GMhixS7CLnLC9c6ie6reWJRwSdWGjaZM5WgkK2tPAx
         O/kcCDJcvbEMy+ashJVtc1hIhaaeSofaqse1Qar7do3Ai9Nj1Lepku1xz6F4nSjXXs
         xvA4EvJfMrcOlxq3rrzS/BLH9afxZNSAFMQ3KeNa32e9QZX8oCZH+0JtDoaSIKxzDl
         hoLm56ODDpvkIHxWF2PMF+EOeqG5T4IgJKQl+g4y0wBJz8Ay5kAWhZWRh1iSVy4KBy
         INPwm9kGd35qUMpT5vqEAzBnsKrXori3OV69NAQC1r+F/pDq9juvYsZx/xZo3tsT7S
         I3lnIzOQcQgOQ==
Date:   Tue, 21 Jun 2022 20:26:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan Lengfeld <stefan.lengfeld@inovex.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Questions: IIO type for absorbance and float values in
 channels?
Message-ID: <20220621202645.1dd9f22f@jic23-huawei>
In-Reply-To: <CAHp75VeN=C7Uy+a9fBMX8NBO2nFLeAFjjpTdZX-y8K2enxMdiw@mail.gmail.com>
References: <20220621121855.ynnv5ckymbmmvjcm@gmail.com>
        <20220621132909.00005439@Huawei.com>
        <CAHp75VeN=C7Uy+a9fBMX8NBO2nFLeAFjjpTdZX-y8K2enxMdiw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jun 2022 16:13:25 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 21, 2022 at 2:29 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Tue, 21 Jun 2022 14:18:55 +0200
> > Stefan Lengfeld <stefan.lengfeld@inovex.de> wrote:  
> 
> ...
> 
> > > Question 1:
> > >
> > > The sensor measures the absorbance[1] of a material. It's the negative
> > > logarithmic quotient of the received and emitted light. It's a unit-less value.
> > >
> > > As far as I can see there is currently no predefined IIO type in the kernel for
> > > this.  I have search the list [2], but nothing matches.
> > >
> > > Do I overlook something or what channel type should I use for this sensor
> > > measurement value?  
> >
> > So the closest we've seen to this is some of the health sensors (pulse oximeter
> > targeting devices) but in that case the processing is done with a custom userspace
> > library so we just pass values on in fixed point.
> >
> > So probably needs a new channel type.  
> 
> Wouldn't this be a particular case of ambient (light) sensor?
> 

Not IIO_LIGHT / illuminance (which is the human eye profile corrected light reading we
tend to care about), but could probably be considered intensity
with a modifier. The snag is we have colour modifiers for that and so
this is one of those corner cases where we would ideally allow
modifiers to stack, but we don't (and can't retrofit that because
of the space in the IIO_EVENT definition - there is no where to
put it :(  So it is like illuminance in the sense that it is a computed
value (or that's one implementation anyway) based on intensity channels.
I've never seen a sensor actually measure illuminance directly - they tend
to combine multiple sensors with different frequency responses using some
secret sauce (or attempt to bodge something reasonable from one reading based
on assumptions about the light source).  Arguably it's also like the
proximity devices that just use intensity of response relative to a light
source the control (the cheap ones :)

There isn't really a good answer as there is a bit too much to describe about this
channel type... 

Jonathan

 
