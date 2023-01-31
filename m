Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8168369D
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 20:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjAaTcq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 14:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjAaTcp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 14:32:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58175246
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:32:44 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hx15so25246477ejc.11
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8z8Gw3YQxDK5rg5sh2/0Po/TbyoFcH34X4/IV2eUxrs=;
        b=JnuZ2fI/j4IGBr+cMyy2vUQDZRQZeTpCAG9/cFMQrLWZmxNB89SRwJR9GfeiSr4OR7
         lqE1jc+cKU8Hu7r0UEtbir1JnXX+dm5FSpLgiEiU2TB9hzx5UgdCghH//46j0E8MFzmK
         emF8ksJc3Zh6uEF2pmvL/0wIMv81jXV/S9T7aBqS7inTvVuzijEC2n2q63N0YjeYa4Ix
         F96BshP7IIu+BilXKKDFIXYMXf+hUcf+HyiEE0wRJFdIoBGnWrh6vEw4hS2lrI/EhkcZ
         wpeXn0F9Lgy00BWh7asue5AEfWTO36PmmAuhnCEaRZ4gwOuUBc5dZhxmeYsNNheABFkE
         7XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z8Gw3YQxDK5rg5sh2/0Po/TbyoFcH34X4/IV2eUxrs=;
        b=Avxlg3xdNNoxfl+3gfkjPwXyHK41DRC9k/tTcmblv2jVgWVRZSY8h5SaqGqCYMC7m9
         dCWCmn4h+Ci9J7DMknu0CrxpjSWIWQg1xzTlVOFzgP14fiiJ/akwCxyVciFWc+IxlM8W
         Qxp4Eukow+wm18Tak93Y/ULUf8l2XzIYK+3AGexq5q9L0gmo8D7YRx8tRWnw8vl57pYN
         88+87Xijrfo7jOGex103eZDqG08ZKHZKDEbLDVg8XekAnozd2xCuSGvsRrD39WlmrbgX
         KY22ScK6s+PVE2OnxHYCDgYjvL3Ec2Gr/X+sgylQuIWCzzLwRkMIHe6i9ypGCS7wcchH
         DZUg==
X-Gm-Message-State: AO0yUKV5JUyVYEgJh/4NsY/3lB4eOxQJyZYNJfBb/1Vzwo2Pv3vrOzAx
        BIpy/+aDtq0atJ3NAiDBDo4=
X-Google-Smtp-Source: AK7set/dNi/xi4zVrqzZt/YEdxc0XG41EG/L1xP228WAaXHesECqTDxiwQMyM+/UHZ21YF5necq6dw==
X-Received: by 2002:a17:906:a411:b0:878:72f7:bd99 with SMTP id l17-20020a170906a41100b0087872f7bd99mr20099498ejz.6.1675193563070;
        Tue, 31 Jan 2023 11:32:43 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::c406])
        by smtp.gmail.com with ESMTPSA id d23-20020a1709063ed700b0088d0b51f056sm653342ejj.40.2023.01.31.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 11:32:42 -0800 (PST)
Date:   Tue, 31 Jan 2023 20:32:40 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: accel: kionix-kx022a: Fix the setting of
 regmap_config rd_table and wr_table
Message-ID: <Y9ls2DgYI0wyQoBm@carbian>
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
 <0003ce97298da5afd9cfeab8ae8f93f50542fe8c.1674996464.git.mehdi.djait.k@gmail.com>
 <ddbc6f91-44e3-4337-f957-a883d315d0a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddbc6f91-44e3-4337-f957-a883d315d0a1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Matti,

On Mon, Jan 30, 2023 at 09:37:12AM +0200, Matti Vaittinen wrote:
> Hi Mehdi,
> 
> Thank you for the patch.
> 
> On 1/29/23 15:37, Mehdi Djait wrote:
> > rd_table points to a regmap_access_table with valid ranges for read access
> > and should be set to &kx022a_ro_regs which points to the read_only regs.
> > The same for wr_table.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> >   drivers/iio/accel/kionix-kx022a.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index f866859855cd..1d3af42ec0e1 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -142,8 +142,8 @@ const struct regmap_config kx022a_regmap = {
> >   	.reg_bits = 8,
> >   	.val_bits = 8,
> >   	.volatile_table = &kx022a_volatile_regs,
> > -	.rd_table = &kx022a_wo_regs,
> > -	.wr_table = &kx022a_ro_regs,
> > +	.rd_table = &kx022a_ro_regs,
> > +	.wr_table = &kx022a_wo_regs,
> 
> Have you tested this? If I interpret the code correctly, the current code
> (before this patch) adds read-only registers - Eg, registers which are not
> writable - to wr_table no-range. I think it is correct way. Same for
> write-only registers - eg, registers which are not readable - are stored in
> rd-table no-range. Do you think I am misunderstanding something?
> 

I am the person totally misunderstanding everything here (which is
expected). I was confused by the assignment of write_only_regs to
readable_table and read_only_regs to writeable_table, it's not an excuse I
should have verified more before sending a patch.

--
Best Regards,
Mehdi Djait

> >   	.rd_noinc_table = &kx022a_nir_regs,
> >   	.precious_table = &kx022a_precious_regs,
> >   	.max_register = KX022A_MAX_REGISTER,
> 
> Best Regards
> 	-- Matti
> 
> -- 
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~
> 
