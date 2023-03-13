Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57146B7722
	for <lists+linux-iio@lfdr.de>; Mon, 13 Mar 2023 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCMMEi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Mar 2023 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCMMEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2023 08:04:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC03C2367F;
        Mon, 13 Mar 2023 05:04:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l12so2787191wrm.10;
        Mon, 13 Mar 2023 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678709073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgtg8JCjU4w9C5eAuNBhB2+PUMGO//HenbT6+z8Wpk4=;
        b=gvS6hrEn01OyucgxuWqnY+qFSOCKmylW+p0JSaTcaKtzCe9JYbJCX1yVx4vHmsbACg
         OydGU25xvyFvTGYCGTXG2C8ziCN/zv8+RZFSmuVSrwVpqmIM2/W68Qu344hIsslM+LTD
         0Iwrg1LXJoDCrB6UlVnfwWHL2NSEKfPSMCidT52t1d5+nvCfgfqrHUWv09TYbd2jcM9Z
         n7JDuC+rXKLy5p7kQHdsQO9RCTKr0wXiauFy86BJ4SSst/X7s9UdjgNWWFnBcBSaJT66
         RVnfDKCgwLlUMFR61anyvTyDl3r6fScxKnrxiDMqM6EpONmGtIb4efBKpa1CpPaGwtIr
         Gf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678709073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jgtg8JCjU4w9C5eAuNBhB2+PUMGO//HenbT6+z8Wpk4=;
        b=G5UsgM9KMSiobNXy0p1Xn+xy/JBWMQElvIYEFYi2mmaQ9fpc5vSbv+DFaYTurkfLdb
         h8XwapBSdCRmxgcDK019P2CkMMn//9PD7KiGBoWOCSkNObKLAIscaLZxHfd24yPlBu7P
         WbS1eLvNPh8Wjfdwp3x8MEmudSUVkqwMMjNH6hoqMpVAWvv7ts9mmLtC7grvazLEXEfn
         odMRJYUkLuOHI3d4gQ+NA6p8cxFv6hWcARbQWR7/Sn0Ut0UnurEUW9GLzimcATUZ7TC0
         MF4r+dQyHcyhg+D0LBg3pBx3yZECT6VaWP86TbcfCbqCBxcVhSJIwnqI6SNiC+R42PUp
         iXgg==
X-Gm-Message-State: AO0yUKXs8CkWK++bcw2Vt2aKVB4a12lbp62z4ZjHMc5/w2dFfM4/sUOd
        /TJAdLqjmOJcAuoUFvDKTs8=
X-Google-Smtp-Source: AK7set/hbUqYtwUAoiJDXriueq9aqf41wjVXCAFELK0SgXu9jhkKBLVvc7CFERpXg0qhsbCQuwbetg==
X-Received: by 2002:adf:f509:0:b0:2ce:a8f0:5e2b with SMTP id q9-20020adff509000000b002cea8f05e2bmr4347500wro.58.1678709073214;
        Mon, 13 Mar 2023 05:04:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a3-20020adfe5c3000000b002cfe71153b4sm135329wrn.60.2023.03.13.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 05:04:32 -0700 (PDT)
Date:   Mon, 13 Mar 2023 15:04:28 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Irina Tirdea <irina.tirdea@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: magn: bmc150: add a lower bounds in
 bmc150_magn_write_raw()
Message-ID: <23e6a7db-895a-4674-9a2d-acbb15342fd0@kili.mountain>
References: <94939714-a232-4107-8741-8867038b03ae@kili.mountain>
 <20230312144551.2baf3e8b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312144551.2baf3e8b@jic23-huawei>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 12, 2023 at 02:45:51PM +0000, Jonathan Cameron wrote:
> On Wed, 8 Mar 2023 12:12:37 +0300
> Dan Carpenter <error27@gmail.com> wrote:
> 
> > The "val" variable comes from the user via iio_write_channel_info().
> > This code puts an upper bound on "val" but it doesn't check for
> > negatives so Smatch complains.  I don't think either the bounds
> > checking is really required, but it's just good to be conservative.
> > 
> > Fixes: 5990dc970367 ("iio: magn: bmc150_magn: add oversampling ratio")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> Hi Dan,
> 
> I think this is more complex than it initially appears.
> 
> bmc150_magn_set_odr() matches against a table of possible value
> (precise matching) and as such you'd assume neither check is necessary.
> 
> However, for a given configuration not all values in that table can
> actually be set due to max_odr actually changing depending on other settings.
> 
> My immediate thought was "why not push this check into bmc150_magn_set_odr()"
> where this will be more obvious.  Turns out that max_odr isn't available until
> later in bmc150_magn_init() than the initial call of bmc150_magn_set_odr()
>  
> Whilst I 'think' you could move that around so that max_odr was set, that's not quite
> obvious enough for me to want to do it without testing the result.
> 
> So question becomes is it wroth adding the val < 0 check here.
> My gut feeling is that actually makes it more confusing because we are checking
> something that doesn't restrict the later results alongside something that does.
> 
> Am I missing something, or was smatch just being overly careful?

Okay, fair enough.  The upper bounds is required and the lower bounds is
not.

However, passing negatives is still not best practice and I feel like it
wasn't intentional here.  Let me resend the commit, but with a different
commit message that doesn't say the upper bound is not required.

The Smatch warning feels intuitively correct.  If you're going to have
an upper bounds check then you need to have a lower bounds check to
prevent negative values.  In practice it works pretty well.  The only
major issue with this check is that sometimes Smatch thinks a variable
can be negative when it cannot.

This patch is an example where passing a negative is harmless and I had
a similar warning last week where it was passing a negative param was
harmless as well.  The parameter was used as loop limit:

	for (i = 0; i < param; i++) {

It's a no-op since param is negative, but all all it needs is for
someone declare the iterator as "unsigned int i;" and then it becomes
a memory corruption issue.

So occasionally passing negatives is harmless but mostly it's bad.

regards,
dan carpenter



