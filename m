Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B88681B13
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 21:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjA3UFi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 15:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjA3UFh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 15:05:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357D4741A;
        Mon, 30 Jan 2023 12:05:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B0160F83;
        Mon, 30 Jan 2023 20:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13CCC433EF;
        Mon, 30 Jan 2023 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675109135;
        bh=MtoKF5tZ9iw5pxdAn2dB010tie1kooHia/5OXhX6ePo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YSKb46qnUFdgt0PQi7Is8QTjxGxVU9CAgxO+Ftw/zXo7qSWtKyQ75shjsUaf/KhEH
         eWzlz28w1euAaTiHKm65bphCmsW5GD7RVxayLUQM511tg964dAIE4uPX/yfEftm2wO
         +DwSAVRbXoSVeVLDTY4312eqKZu0ix5weH1/q24eDi8sv+fgkjNPlQaWpMMtssbjJh
         aO5bXpzdTuW2QP51k00wN/jcpzE3nO696WC9mI6jvVqomysgmEVrSQ7qs9Mk4ygpwd
         HWhNDOBEhXQZpScKxhkheQR0LR3JE0pOHC+vAQ5myb/Dc7GhpFGqLcsg4XO6bwQM7f
         4ZUvVczy5Tkng==
Date:   Mon, 30 Jan 2023 20:19:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: ROHM ALS, integration time
Message-ID: <20230130201929.52c93ee5@jic23-huawei>
In-Reply-To: <0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
        <20230130130231.000013b6@Huawei.com>
        <9b3dcc7a-a0f8-38ee-4381-d330004d436f@fi.rohmeurope.com>
        <20230130171218.00007802@Huawei.com>
        <0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Mon, 30 Jan 2023 20:19:07 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 1/30/23 19:12, Jonathan Cameron wrote:
> > On Mon, 30 Jan 2023 13:42:27 +0000
> > "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> >   
> >> On 1/30/23 15:02, Jonathan Cameron wrote:  
> >>> On Mon, 30 Jan 2023 14:04:53 +0200
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> >> For an occasional contributor like me it could be helpful if the defines
> >> like IIO_INTENSITY, IIO_LIGHT had documentation in headers explaining
> >> for example the units. Maybe also some words about the
> >> IIO_CHAN_INFO_INT_TIME and IIO_CHAN_INFO_SCALE as well ;) I guess I can
> >> cook some doc - but only for couple of defines which I have discussed
> >> with you this far. Do you think such comment docs would be welcome -
> >> even if they covered only couple of defines? Maybe others would continue
> >> from that.  
> > 
> > I'd worry about the Docs disagreeing with the ABI docs
> > in Documentation/ABI/testing/sysfs-bus-iio
> > which needs to be the 'one true source' of this stuff.  
> 
> Oh, right. It might've been just me - but I did overlook this golden 
> documentation. I did actually land on this document but didn't really 
> pay the required attention. I guess I allowed the kernel version in the 
> page to distract me thinking it is some sort of 'history' stuff.
> 
> What would have been enough (even for me) would've been a short 
> description of a define - and then the link to a entry which corresponds 
> the define in this document. Something along the lines:
> 
> /**
>   * iio_chan_type - Types of channel
>   *
>   * Please find the detailed documentation for reported values from the
>   * Documentation/ABI/testing/sysfs-bus-iio. Pointer to correct keyword
>   * in documentation is mentioned at the channel define description
>   * below.
>   *
>   * IIO_INTENSITY:	Channel for unitless intensity.
>   *			Doc keyword: in_intensityY_raw			
>   *
>   * IIO_LIGHT:		Channel for visible light intensity in lux
>   * 			Doc keyword: in_illuminance_raw
>   */
> 
> I have a feeling that this would already have helped me. Nevertheless, I 
> would not mind seeing docs also for the iio_chan_info_enum values - but 
> linking to the correct spot in sysfs-bus-iio might not be as easy.
> 
> Anyays, Thanks for the help once again :)

Both the kernel-doc for this header and the ABI docs end up in
the kernel html docs.  I wonder if a link is possible...
https://docs.kernel.org/driver-api/iio/core.html#industrial-i-o-devices
would have the iio_chan_type docs I think if there were any.
https://docs.kernel.org/admin-guide/abi-testing.html?highlight=abi#abi-sys-iio-devicex-in-intensityy-raw 
is the matching ABI doc. 

Mauro, Jon, other docs system experts...

I couldn't immediately find a way to link to a specific ABI docs entry,
is there a means to do it from kernel-doc in a header?

Thanks,

Jonathan


> 
> Yours,
> 	-- Matti
> 

