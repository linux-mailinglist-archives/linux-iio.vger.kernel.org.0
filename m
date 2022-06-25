Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E043355AACD
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiFYONa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiFYON3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 10:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9493B14D1F;
        Sat, 25 Jun 2022 07:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E84DB80B4F;
        Sat, 25 Jun 2022 14:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F568C3411C;
        Sat, 25 Jun 2022 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656166406;
        bh=dEPsH1gC0cjPyNyfQIWjd/eKaeFawSF+Zw3Mv3HySgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FoEhPohviHb6Z6MxNRWG+noIK+/NJBjWTdJUoZ3RjyfrTFK8DGJ3HCt1Os17HZkLr
         oY8XMG8hBsIEsNq/9gEWvTH/yRNm2yCVwqyoJZT5xbCPziQhXpQM+1hofYsOHo4lTX
         eEV2GeOnfAi1nQoNjacLWGXlWx0nl76CprIKhDHVOZ2PQPEAgWDwoczubCgiXfGqfL
         J+QjTAMYPjmOxpmiBgdwgLD8rh1NhZ4IEzXBWnakayDv5FcQ1v1lwlA5rXHkN5FETO
         faAgHz5F96jZ0kZbZY2E3bM1Ql6PWBC4tq3qjBs87w/EirTuAbus7f1fU13s1Dg8gn
         gH3EKq1Mp9pnQ==
Date:   Sat, 25 Jun 2022 15:22:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
Message-ID: <20220625152253.15fedf17@jic23-huawei>
In-Reply-To: <d51884a5-e3a9-39b9-14dc-5f002982ed6d@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
        <20220618162833.218dbe67@jic23-huawei>
        <d51884a5-e3a9-39b9-14dc-5f002982ed6d@rocketmail.com>
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

> 
> >> +static int yas537_get_calibration_data(struct yas5xx *yas5xx)
> >> +{
> >> +	struct yas5xx_calibration *c = &yas5xx->calibration;
> >> +	u8 data[17];
> >> +	u32 val1, val2, val3, val4;
> >> +	int i, ret;
> >> +
> >> +	/* Writing SRST register, the exact meaning is unknown */
> >> +	ret = regmap_write(yas5xx->map, YAS537_SRST, BIT(1));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Calibration readout, YAS537 needs one readout only */
> >> +	ret = regmap_bulk_read(yas5xx->map, YAS537_CAL, data, sizeof(data));
> >> +	if (ret)
> >> +		return ret;
> >> +	dev_dbg(yas5xx->dev, "calibration data: %17ph\n", data);
> >> +
> >> +	/* Sanity check, is this all zeroes? */
> >> +	if (!memchr_inv(data, 0x00, 16)) {
> >> +		if (FIELD_GET(GENMASK(5, 0), data[16]) == 0)
> >> +			dev_warn(yas5xx->dev, "calibration is blank!\n");
> >> +	}
> >> +
> >> +	/* Contribute calibration data to the input pool for kernel entropy */
> >> +	add_device_randomness(data, sizeof(data));
> >> +
> >> +	/* Extract version information */
> >> +	yas5xx->version = FIELD_GET(GENMASK(7, 6), data[16]);
> >> +
> >> +	/* There are two versions of YAS537 behaving differently */
> >> +	switch (yas5xx->version) {
> >> +
> >> +	case YAS537_VERSION_0:  
> > Seems like we might need more chip_info variants, though perhaps in this case
> > it is worth handling it as a switch statement as hopefully the number of
> > way s this is done for a given part number won't grow any further.  
> 
> Yes, I think I'll introduce chip_info for the variants like YAS530,
> YAS532, etc. but keep handling the versions (like 0 and 1 in this case)
> within the functions. I'll have a look again when preparing patchset v4.
> 

Up to you, though I'm guessing it'll end up better with just having a bit
more duplicate data to handle the versions as separate device types.


> >> +
> >> +		/*
> >> +		 * Visualization of partially taken data:
> >> +		 *
> >> +		 * data[3]       n 7 6 5 4 3 2 1 0
> >> +		 * YAS537_MTC+3    x x x 1 0 0 0 0
> >> +		 *
> >> +		 * data[15]      n 7 6 5 4 3 2 1 0
> >> +		 * YAS537_HCK      x x x x 0
> >> +		 *
> >> +		 * data[15]      n 7 6 5 4 3 2 1 0
> >> +		 * YAS537_LCK              x x x x 0
> >> +		 *
> >> +		 * data[16]      n 7 6 5 4 3 2 1 0
> >> +		 * YAS537_OC           x x x x x x
> >> +		 */
> >> +
> >> +		ret = regmap_write(yas5xx->map, YAS537_MTC + 3,
> >> +				   (data[3] & GENMASK(7, 5)) | BIT(4));  
> > 
> > If we can give the masks meaningful names that would be great then
> > use FIELD_GET and FIELD_PREP with those defines (even if it puts it back
> > in the same place like here).  Let the compiler optimise out anything
> > unnecessary in the way of masks and shifts.  
> 
> I don't know what these abbreviations stand for. We could do:
> 
> #define YAS537_MTC3_MASK_PREP ...
> #define YAS537_MTC3_MASK_GET ...
> #define YAS537_HCK_MASK_PREP ...
> #define YAS537_HCK_MASK_GET ...
> etc.
> 
> We need both FIELD_GET and FIELD_PREP, right? The first to retrieve the
> data and the second to place it at the right position.
> 
> Doesn't that get strange-looking like:
> 

yup. you get this sort of oddity sometimes, but it still keeps
it clear which field you are working with.

>         ret = regmap_write(yas5xx->map, YAS537_HCK,
>                            FIELD_PREP(YAS537_HCK_MASK_PREP,
>                                       FIELD_GET(YAS537_HCK_MASK_GET,
>                                                 data[15])));
> 
> Or maybe different indentation, would that be acceptable?
> 
>         ret = regmap_write(yas5xx->map, YAS537_HCK,
>                            FIELD_PREP(YAS537_HCK_MASK_PREP,
>                            FIELD_GET(YAS537_HCK_MASK_GET, data[15])));
Definitely nicer this way.

> 
> On the one above your comment, the "YAS537_MTC + 3", we would still need
> the "| BIT(4)" to place that "1" there. Or is there some other trick to
> do this?

Give it a define and FIELD_PREP() that one as well so we have some
info on what it is via the code.  Obviously it's longer code, but
generally easier to maintain as puts the register definitions in one place
to check against any docs.


> 
> >> +		if (ret)
> >> +			return ret;
> >> +		ret = regmap_write(yas5xx->map, YAS537_HCK,
> >> +				   FIELD_GET(GENMASK(7, 4), data[15]) << 1);  
> > 
> > FIELD_PREP() with suitable mask defined to make it clear what field is being written.
> >   
> >> +		if (ret)
> >> +			return ret;
> >> +		ret = regmap_write(yas5xx->map, YAS537_LCK,
> >> +				   FIELD_GET(GENMASK(3, 0), data[15]) << 1);
> >> +		if (ret)
> >> +			return ret;
> >> +		ret = regmap_write(yas5xx->map, YAS537_OC,
> >> +				   FIELD_GET(GENMASK(5, 0), data[16]));
> >> +		if (ret)
> >> +			return ret;
> >> +  
> 
>
...

> 
> If YAS537 doesn't have a .measure_offsets function pointer in chip_info,
> it skips that if statement cleanly?

Two options - either add a stub that doesn't do anything or
(I prefer this one as makes it obvious the function might not do anything) check 
if (chip_info->measure_offsets)
	chip_info->measure_offsets()...

> 
> ...
> 
> Kind regards,
> Jakob

