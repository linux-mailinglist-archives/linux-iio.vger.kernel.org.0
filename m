Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC855AACB
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiFYOFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiFYOFa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 10:05:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC615809;
        Sat, 25 Jun 2022 07:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46252B80B6A;
        Sat, 25 Jun 2022 14:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E05C3411C;
        Sat, 25 Jun 2022 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656165926;
        bh=M4LKJfPNpT+x8nTjj1pC9k2cXwJjs5nM0SQKtE/4Ibw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u4NWM2RdL9R7YQDwQs7Ps8BawmdfsjWTh6HAL3c+BZSfLBFI/1E37JdfE1EaDaRlI
         M/lrhRh3VmDSUcZctkkeysmtCrrVym8tNfXTgnz2elvhCRCCYWYi3la7BibATmmPYT
         zlxnPm8P+41I9GEPKGoYxHlfjISTLzEebsMUqwGx3BjPxjeEfU9a5U5WCYijwL8LAy
         bFQggbovVLzrjk7QzzTYYxgVx9feKLQ/VQTR1clzy/E5DJwjq5ef2kHaN45u2+O/ti
         e2o/GXBl6zmRHVKqU8eE52/Ymw5rNO8jdyi+bqr+73pa9/QfP37vsWfYpjUq2cX0Hs
         dbLF20HuYio7A==
Date:   Sat, 25 Jun 2022 15:14:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 4/8] iio: magnetometer: yas530: Correct temperature
 handling
Message-ID: <20220625151453.036a4b22@jic23-huawei>
In-Reply-To: <a348dbb6-8d4a-bcdb-e992-9b11e1c9f23f@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <076e87f66378be8c729723cb9be5bc9151c081ab.1655509425.git.jahau@rocketmail.com>
        <20220618155331.5da93b88@jic23-huawei>
        <a348dbb6-8d4a-bcdb-e992-9b11e1c9f23f@rocketmail.com>
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

On Tue, 21 Jun 2022 02:48:46 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> Hi Jonathan,
> 
> On 18.06.22 16:53, Jonathan Cameron wrote:
> >
> > On Sat, 18 Jun 2022 02:13:12 +0200
> > Jakob Hauser <jahau@rocketmail.com> wrote:  
> ...
> >>  /* These variant IDs are known from code dumps */
> >>  #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
> >> @@ -314,7 +315,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)  
> > 
> > Hmm. I'm not a great fun of big hydra functions to handle differences
> > between devices.  This could easily all be one code flow with some
> > lookups into chip specific constant data (as btw could a lot of
> > the other switch statements in the existing driver).  
> 
> I'll try to implement the chip_info approach. This should become a
> separate patch.
> 
> Concerning the patchset, I would prefer to introduce the chip_info
> approach rather late. That would mean to leave this patch unchanged and
> introduce your suggestions later within the patchset. I think it's
> easier to follow the changes along the patchset.
> 
> However, you probably would prefer to place the chip_info patch rather
> early in the patchset?

Whilst I'd prefer it earlier, if it's a real pain, just put a note on
that in the cover letter and I'll cope :)

> 
> >>  static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
> >>  {
> >>  	struct yas5xx_calibration *c = &yas5xx->calibration;
> >> -	u16 t, x, y1, y2;
> >> +	u16 t_ref, t, x, y1, y2;
> >>  	/* These are "signed x, signed y1 etc */
> >>  	s32 sx, sy1, sy2, sy, sz;
> >>  	int ret;
> >> @@ -329,16 +330,46 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
> >>  	sy1 = yas5xx_linearize(yas5xx, y1, 1);
> >>  	sy2 = yas5xx_linearize(yas5xx, y2, 2);
> >>  
> >> -	/*
> >> -	 * Temperature compensation for x, y1, y2 respectively:
> >> -	 *
> >> -	 *          Cx * t
> >> -	 * x' = x - ------
> >> -	 *           100
> >> -	 */
> >> -	sx = sx - (c->Cx * t) / 100;
> >> -	sy1 = sy1 - (c->Cy1 * t) / 100;
> >> -	sy2 = sy2 - (c->Cy2 * t) / 100;
> >> +	/* Set the temperature reference value (unit: counts) */
> >> +	switch (yas5xx->devid) {
> >> +	case YAS530_DEVICE_ID:
> >> +		t_ref = YAS530_20DEGREES;  
> > 
> > One thought to simplify the divergent flow below.
> > 
> > 		t_ref2 = 0;  
> >> +		break;
> >> +	case YAS532_DEVICE_ID:
> >> +		t_ref = YAS532_20DEGREES;  
> > 		if (yas5xx->version == YAS532_VERSION_AC)
> > 			t_ref2 = YAS432_20DEGREES;
> > 		else
> > 			t_ref2 = 0;  
> 
> The t_ref2 approach looks confusing to me. Because for the most version
> it's "t_ref2 = 0", only one version out of four needs this.
> 
> Another approach: I would rather introduce t_comp (for compensation). In
> the chip_info, for the most version it would be...
> 
>         .t_comp = t,
> 
> ... and for the one variant it would be:
> 
>         .t_comp = t - t_ref,

That looks sensible to me.
> 
> A problem: I would include the YAS variants like YAS530, YAS532 etc. in
> the chip_info. The versions like "AB" and "AC", on the other hand, I
> wouldn't include into the chip_info, instead I would handle these in the
> functions. In that case the, "t_comp" thing would need to be done in the
> function using an if statement, similar to what you suggested up here.

I'd assume there won't be too many different versions that need separate
support and have a chipinfo for each of those versions.  So you
select the chipinfo based on both the device part number and version.

>
Thanks,

J
