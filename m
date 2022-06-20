Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91A5523CC
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbiFTSYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 14:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbiFTSYG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 14:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544013FB1
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2CB615AC
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 18:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75391C3411B;
        Mon, 20 Jun 2022 18:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655749443;
        bh=jpUofyi6Y7xfckXYM9209uEB0Qp67LTUjQ9HKJJ+4Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aBVNHI+TRT244gOJOsKflMoTs1OCAS20GLJaMPUuD6mfRm8bOkyrFWIBlZGRq0L7y
         HMv5AhMqefJ8g2nrOs7bo7vpar/qbnZFZVogww1u9SPOavcur/tFl5R89dFUR1opJD
         s+ENlTbU/JWIneMC9ec7HEhWr/C9HRltBNeVrj5QHQw7goVoSckH52kzvFTgqHqi62
         s1hhcZdGuIYzeFf8VffLRF491plN2C0ID7FlkhKMci3nT7HtWT926ksWxvDKbGweqo
         EbDQpQ5j6cUk9MzTEX8K902jbsgxX670bQ3INNYbvApIWpxbJMgs2hbZ9FcFCXd+Ss
         J/HyYuxBZfYUQ==
Date:   Mon, 20 Jun 2022 19:23:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 05/17] staging: iio: cdc: ad7746: Use local buffer
 for multi byte reads.
Message-ID: <20220620192358.787faa92@jic23-huawei>
In-Reply-To: <20220620174236.00002543@Huawei.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-6-jic23@kernel.org>
        <CAHp75Vfp3rzi_NPHZ76CDC43X3Mpm=vthBw6Og9Ya=OjCEeAHQ@mail.gmail.com>
        <20220620174236.00002543@Huawei.com>
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

On Mon, 20 Jun 2022 17:42:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 20 Jun 2022 01:00:23 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > I2C does not require DMA safe buffers so there is no need to ensure
> > > the buffers are in their own cacheline. Hence simplify things by
> > > using a local variable instead of embedding the buffer in the chip
> > > info structure.    
> > 
> > ...
> >   
> > >                                                     sizeof(chip->data),
> > >                                                     chip->data);    
> > 
> > How will these compile? Or am I missing something?  
> 
> Nope.  Something went wrong in the rebase. I should have rechecked
> build patch by patch.  Later on, this code is factored out, so I guess
> that fixed up the build issue.
> 
> Will check properly for v3. :(
yikes rebase went very wrong.  Anyhow, will fix up.

Turns out I as being an idiot and building with the roadtest makefile
which doesn't actually enable this driver until the last patch.

Jonathan

> 
> 
> >   
> > > -
> > >                 if (ret < 0)
> > >                         goto out;
> > >
> > > -               *val = get_unaligned_be24(chip->data) - 0x800000;
> > > +               *val = get_unaligned_be24(data) - 0x800000;    
> >   
> 

