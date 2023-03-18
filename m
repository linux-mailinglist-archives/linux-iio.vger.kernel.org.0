Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5451F6BFBCC
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCRRQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 13:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCRRQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 13:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0C265A3;
        Sat, 18 Mar 2023 10:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CCA1B803F5;
        Sat, 18 Mar 2023 17:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F802C433D2;
        Sat, 18 Mar 2023 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679159773;
        bh=9A2fgv5oQbxynJAYMRA2toHVpzS70vkHPEQb8wWQvP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/h5RHcd+9uw139/ETE4kVAQuQT9Vm1lkk8uwwZUn30CtHULLYoCs6p0sOU6ScoYa
         CeChAuaeHKSdU68FeKmc2FzKADSK2dgS+/lY0X/QtRX4ABIGfo2AOKg4NX3pZ1yM93
         umQ089CWba7cdJnj2h82cZA2bYEsrhgKhB26s/vVPVNlo2wT+33dvUZ5k2RGikm1aW
         QmFZLnFUmM+ZwEGkSL74702LRCvmTp/QhXAAOV8xV4er27wWc0y8dXbt7V0kgXazfo
         PxDwKl7ZcDjjiONfOhEyRP3j/JdK8uNIOVfC5HNLlFmEsh9j40N/P5X6WhTfkRU6SE
         Ugty5DdQ+8Eog==
Date:   Sat, 18 Mar 2023 17:31:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Irina Tirdea <irina.tirdea@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: magn: bmc150: add a lower bounds in
 bmc150_magn_write_raw()
Message-ID: <20230318173106.78ae91d7@jic23-huawei>
In-Reply-To: <23e6a7db-895a-4674-9a2d-acbb15342fd0@kili.mountain>
References: <94939714-a232-4107-8741-8867038b03ae@kili.mountain>
        <20230312144551.2baf3e8b@jic23-huawei>
        <23e6a7db-895a-4674-9a2d-acbb15342fd0@kili.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Mon, 13 Mar 2023 15:04:28 +0300
Dan Carpenter <error27@gmail.com> wrote:

> On Sun, Mar 12, 2023 at 02:45:51PM +0000, Jonathan Cameron wrote:
> > On Wed, 8 Mar 2023 12:12:37 +0300
> > Dan Carpenter <error27@gmail.com> wrote:
> >   
> > > The "val" variable comes from the user via iio_write_channel_info().
> > > This code puts an upper bound on "val" but it doesn't check for
> > > negatives so Smatch complains.  I don't think either the bounds
> > > checking is really required, but it's just good to be conservative.
> > > 
> > > Fixes: 5990dc970367 ("iio: magn: bmc150_magn: add oversampling ratio")
> > > Signed-off-by: Dan Carpenter <error27@gmail.com>  
> > 
> > Hi Dan,
> > 
> > I think this is more complex than it initially appears.
> > 
> > bmc150_magn_set_odr() matches against a table of possible value
> > (precise matching) and as such you'd assume neither check is necessary.
> > 
> > However, for a given configuration not all values in that table can
> > actually be set due to max_odr actually changing depending on other settings.
> > 
> > My immediate thought was "why not push this check into bmc150_magn_set_odr()"
> > where this will be more obvious.  Turns out that max_odr isn't available until
> > later in bmc150_magn_init() than the initial call of bmc150_magn_set_odr()
> >  
> > Whilst I 'think' you could move that around so that max_odr was set, that's not quite
> > obvious enough for me to want to do it without testing the result.
> > 
> > So question becomes is it wroth adding the val < 0 check here.
> > My gut feeling is that actually makes it more confusing because we are checking
> > something that doesn't restrict the later results alongside something that does.
> > 
> > Am I missing something, or was smatch just being overly careful?  
> 
> Okay, fair enough.  The upper bounds is required and the lower bounds is
> not.
> 
> However, passing negatives is still not best practice and I feel like it
> wasn't intentional here.  Let me resend the commit, but with a different
> commit message that doesn't say the upper bound is not required.

That works for me.

> 
> The Smatch warning feels intuitively correct.  If you're going to have
> an upper bounds check then you need to have a lower bounds check to
> prevent negative values.  In practice it works pretty well.  The only
> major issue with this check is that sometimes Smatch thinks a variable
> can be negative when it cannot.
> 
> This patch is an example where passing a negative is harmless and I had
> a similar warning last week where it was passing a negative param was
> harmless as well.  The parameter was used as loop limit:
> 
> 	for (i = 0; i < param; i++) {
> 
> It's a no-op since param is negative, but all all it needs is for
> someone declare the iterator as "unsigned int i;" and then it becomes
> a memory corruption issue.
> 
> So occasionally passing negatives is harmless but mostly it's bad.

Agreed.

> 
> regards,
> dan carpenter
> 
> 
> 

