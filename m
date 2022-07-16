Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E4577073
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGPRlz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPRly (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 13:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEA1C108
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 10:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE7BA611E4
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 17:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DA1C34114;
        Sat, 16 Jul 2022 17:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657993313;
        bh=tRix/Vc7FZ/n1uFH0Cwqj6uxQZGr96G9yflp9+fA4K0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tzjg8MbPujs5q4L0a1xvxrSEEcv/KXSeW0Ycskql4jV5whhobxvs9AtJ5eUGXStwi
         Ir6KJwGXTRld9NZyLq4Fo9joLxJjEce2Hay0GopcGWNMs+FgkzzI2geF10Mp+gJ0sA
         yDUN8jHfhFeoOnaCzYo7kRk066JKc1hGKljgOrEhr1kXp/GIVNOdNoevsQ1bJ7qrAt
         Nu5i00bHV8dsFCpwstUSwBxGu61/5f7ypi2dP8G0Cl7fWpA5wzmLTBUiee6lwvTbg8
         YpxlQ+SOa44ATbI7/TDr0GVFdtnPczvfv++MnYxwGEcI9sV/AjQ4qkHVG48fuGWFLe
         7snCVbKpsrEHg==
Date:   Sat, 16 Jul 2022 18:51:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Thorsten Scherer <t.scherer@eckelmann.de>
Cc:     Liam Beguin <liambeguin@gmail.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7949: Fix error message
Message-ID: <20220716185147.3b0176a1@jic23-huawei>
In-Reply-To: <20220709053810.wb4mnwk5icjygz4r@NB142.eckelmann.group>
References: <20220708201720.16523-1-t.scherer@eckelmann.de>
        <Ysi07nn5JpIUJHS3@shaak>
        <20220709053810.wb4mnwk5icjygz4r@NB142.eckelmann.group>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 9 Jul 2022 07:38:10 +0200
Thorsten Scherer <t.scherer@eckelmann.de> wrote:

> Hi,
> 
> On Fri, Jul 08, 2022 at 06:51:26PM -0400, Liam Beguin wrote:
> > On Fri, Jul 08, 2022 at 10:17:20PM +0200, Thorsten Scherer wrote:  
> > > Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> > > ---
> > >  drivers/iio/adc/ad7949.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > > index 44bb5fde83de..12fb5f9971db 100644
> > > --- a/drivers/iio/adc/ad7949.c
> > > +++ b/drivers/iio/adc/ad7949.c
> > > @@ -400,7 +400,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > >  
> > >  	ret = ad7949_spi_init(ad7949_adc);
> > >  	if (ret) {
> > > -		dev_err(dev, "enable to init this device: %d\n", ret);
> > > +		dev_err(dev, "fail to init this device: %d\n", ret);  
> > 
> > Maybe 'failed' or 'unable' instead of 'fail'?  
> 
> I decided to be consistent with the wording of the other dev_err's.  If
> anyone cares, I'll send a v2 adjusting the others as well.

I've taken the view that this is obviously an improvement so applied
it to the togreg branch of iio.git (note given timing this will only be
pushed out for now as testing, and later rebased on rc1).

If anyone wants to follow up with a grammar improvement patch, that's
fine with me, but the meaning is clear enough either way in my view.

Jonathan

> 
> > otherwise:
> > 
> > Reviewed-by: Liam Beguin <liambeguin@gmail.com>
> > 
> > Cheers,
> > Liam
> >   
> 
> Best regards
> Thorsten

