Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDFC78B330
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjH1Oao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 10:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjH1Oak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 10:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF510B;
        Mon, 28 Aug 2023 07:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB7F5614F1;
        Mon, 28 Aug 2023 14:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3A9C433C9;
        Mon, 28 Aug 2023 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693233037;
        bh=uGfY1+KfKzu5RqDngEFRkZ3utbsgY5Y9Q8d6VMG/7pQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=foTjTIF1xkOGWKk4yhmZ2KPQ06FW63wTTjloT1m374fRw/NifiXErMWDIawu3ewg/
         VwNyGbR46GWg6xX0vzUpmxiLoJqAoxNFvy92o1aYHiuSaPppB9jwn+A1D/uqpKVDX1
         lD5z0rG8baDpqScH3cTxYr/vwbFb4ikcjm6FMwB1olXLM2219snlYpCW8AqGTWG6Oi
         vSxt3Xp6VuVvKZDZVAEAdJd3TOtVTtB1P0HWgAhr8I0o8yv2aer+hrU3kH1oM5P+eu
         CbawtH7h7FQSNEBV07m/VC1pG/mL0QzRkmfbgu76Kr8RwKHWeLXxOBxgfwo4tMV3PH
         7Wx1IOgV8lm+w==
Date:   Mon, 28 Aug 2023 15:30:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Message-ID: <20230828153056.1a19cbc7@jic23-huawei>
In-Reply-To: <20230828152712.65414a75@jic23-huawei>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
        <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
        <20230828152712.65414a75@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Aug 2023 15:27:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 18 Aug 2023 08:56:00 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> 
> > Sort OF table alphabetically by compatibles.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>  
> I adjusted this for not taking patch 4 and applied.
Dropped this one again as I just saw the suggestion to
group the prefixed an on prefixed version which is a good idea.

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > v2:
> >  * New patch
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > index 295b7be5e36d..7cc443a86995 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -1073,8 +1073,8 @@ static const struct i2c_device_id ak8975_id[] = {
> >  MODULE_DEVICE_TABLE(i2c, ak8975_id);
> >  
> >  static const struct of_device_id ak8975_of_match[] = {
> > -	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
> >  	{ .compatible = "asahi-kasei,ak8963", .data = &ak_def_array[AK8963] },
> > +	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
> >  	{ .compatible = "asahi-kasei,ak09911", .data = &ak_def_array[AK09911] },
> >  	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
> >  	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },  
> 

