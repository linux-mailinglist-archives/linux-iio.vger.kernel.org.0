Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09520591BC7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbiHMP5J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiHMP5I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 11:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6EAA458
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 08:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A68A360EDD
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8FAC433D6;
        Sat, 13 Aug 2022 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406226;
        bh=RtRa4rONL1gnsPA3mwtVA3btdh+FWNkL3+Y3D9wkPoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vO1RfvrmggapUF4VcNPkPKG9cilFMM/emERcaacIhv+nmhlrM5XxLUXP9wSsF9S+v
         hDdvM48ePeyRQfT6HEb3O2FdpvMn2wQHcfCC6fSwhuPpZEuH+NakAYtgIA0/nvXrp2
         mfh8BQT9mbCKOJJo3eSTNPFf7RHuox9CmEul99j0KSaxcX/gOl3WcGSPRGYqrjWCCV
         fqW2FiNArGPOHEFWnz9s+Vmq8xCfMBuUGRa1gXgEKb4ZZaTa3cds83RwGKaTdUU9Ps
         7hBbx5jGPyXEwYa6BJttKsuokv+tNbyulMrPO4ODWgre99+x+dlVfoNnY7hA4QkyzR
         1e/pY8P2iCe1A==
Date:   Sat, 13 Aug 2022 17:07:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH] iio: adc: mt6360: Drop an incorrect __maybe_unused
 marking.
Message-ID: <20220813170734.042e5b62@jic23-huawei>
In-Reply-To: <CAHp75VcJ6wX4+f9TG-WhiXDu+qrxf+BOfOyDQmJHjYTM8LXP1Q@mail.gmail.com>
References: <20220807162121.862894-1-jic23@kernel.org>
        <CAHp75VcJ6wX4+f9TG-WhiXDu+qrxf+BOfOyDQmJHjYTM8LXP1Q@mail.gmail.com>
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

On Mon, 8 Aug 2022 11:22:37 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 7, 2022 at 6:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Given the struct platform_driver has one of it's elements assigned to
> > point to the of_device_id table, it is never going to be unused.
> >
> > Drop the marking.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks,

Applied

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/iio/adc/mt6360-adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> > index 35260d9e4e47..3710473e526f 100644
> > --- a/drivers/iio/adc/mt6360-adc.c
> > +++ b/drivers/iio/adc/mt6360-adc.c
> > @@ -353,7 +353,7 @@ static int mt6360_adc_probe(struct platform_device *pdev)
> >         return devm_iio_device_register(&pdev->dev, indio_dev);
> >  }
> >
> > -static const struct of_device_id __maybe_unused mt6360_adc_of_id[] = {
> > +static const struct of_device_id mt6360_adc_of_id[] = {
> >         { .compatible = "mediatek,mt6360-adc", },
> >         {}
> >  };
> > --
> > 2.37.1
> >  
> 
> 

