Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91BF2568FA
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgH2QEo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 12:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgH2QE3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 12:04:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8825A206C0;
        Sat, 29 Aug 2020 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598717068;
        bh=wAtTGXzByuZkl4YxA/doRZdDexZLsFSOeIVcGObOrLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hqx+QuVmG0IN6gSS6z9ooKtLDMPA8IN8wLj+mFvAYlGm7PALOu7aXLv0JLqJOWAvl
         DyUk8LWwJDujxotTbECimceMzm7fsbxpS5sGWFmiKrIULO9FicTCJsiVYDBArwpYLk
         UvVMsvGIJ1YeGm3UPv39Q/ulK0P5qejRf3IX9osQ=
Date:   Sat, 29 Aug 2020 17:04:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "William.Sung" <William.Sung@advantech.com.tw>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Campion.Kang" <Campion.Kang@advantech.com.tw>,
        "Shihlun.Lin" <Shihlun.Lin@advantech.com.tw>
Subject: Re: [PATCH v2] iio: dac: ad5593r: Dynamically set AD5593R channel
 modes
Message-ID: <20200829170423.4c8e8a11@archlinux>
In-Reply-To: <fede086b9dd54a37bd539ab864bd8c55@taipei09.ADVANTECH.CORP>
References: <20200825101614.2462-1-william.sung@advantech.com.tw>
        <CAHp75VceTBHJ1p3amCQ0PpDSEP8L5+Tf-Qro69+G1WZBrt2oDw@mail.gmail.com>
        <fede086b9dd54a37bd539ab864bd8c55@taipei09.ADVANTECH.CORP>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Aug 2020 05:33:08 +0000
William.Sung <William.Sung@advantech.com.tw> wrote:

> Hi Andy,
> 
> Thanks for you to take your time reviewing this patch. Would you please let me explain your questions?
> 
> =========================================================================
> > +/* Parameters for dynamic channel mode setting */ static u8 
> > +update_channel_mode; static u8 new_channel_modes[AD559XR_CHANNEL_NR];  
> 
> Huh?! Global variables?!
> 
> ---
> 
> > +EXPORT_SYMBOL_GPL(ad5592r_update_default_channel_modes);  
> 
> What?!
> 
> ---
> 
> > +/* Parameters for dynamic channel mode setting */ static char 
> > +*ch_mode = ""; module_param(ch_mode, charp, 0400);  
> 
> We have sysfs ABI, what's wrong with it?
> 
> ---
> => William:  
> 
> The module ad5593r is dependent on the module ad5592r-base, there is also another module ad5592r dependent on it.
> In the original progress of AD5593R probe up:
> 1. ad5593r_probe(), and then it will call the expose function ad5592r_probe() in ad5592r-base.
> 2. During ad5592r_probe() function, it will:
>    * Create ad5593r/ad5592r state structure (including the channel mode settings buffer)
>    * Read all 8 channel mode settings from acpi/dt and write to the state structure
>    * According to the channel mode settings, write the appropriate value to the registers
> 
> Would you please think about a scenario: 
> The channel modes descript in the acpi/dt are 4 GPIOs and 4 ADCs
> If a user wants to change the usage of the channel to 2GPIOs, 4 ADCs, and 2 DACs, no interface can do this.
> The only way that he can do it is by modifying the settings in either acpi or dt.

Sorry, but no to doing this.  If a user actually wants to do this then they need to
use something like a device tree overlay.  The only reason to make such a change
is because the external hardware connected to those pins has changed.
The person making that hardware change should be describing the hardware
that is sitting on those DAC and GPIO lines.

It may seem overly restrictive and I appreciate that quick routes are handy for
makers etc, but there are standard ways of supporting such hardware configurability.
If those do not meet your requirements it is those standard ways that should be
improved, not adding a custom hack for a specific driver.

Jonathan


> 
> To increase the flexibility, we use module parameters for the user specifying the desired setting without modifying the acpi/dt.
> However, during ad5593r_probe() function, the state structure in ad5592r-base has not been created. 
> Since the other module ad5592r is also dependent on ad5592r-base, we try to keep the compatibility for both ad5592r/ad5593r as 
> possible. So we export a function ad5592r_update_default_channel_modes to catch the settings and store in the global variable 
> as the buffer. And the it can keep the original process flow until the module intent to allocate the channel modes.
> 
> If the user manually probe the module without specifying the parameters the module will keep the original flow: Read from acpi/dt as
> the channel mode setting.
> 
> ==============================================================================
> > +       if (strlen(ch_mode) != AD559XR_CHANNEL_NR)  
> 
> This is interesting...
> 
> ---
> 
> => William:  
> My thought is to prevent the typing error. If the length of the input parameter is not matching the number of channels, we can ignore it.
> Is that a weird way to do it?
> 
> ==============================================================================
> > +                       pr_err("%s: invalid(%c) in index(%d)\n",
> > +                               __func__, new_mode[idx], idx);  
> 
> Oh...
> 
> ---
> 
> => William  
> 
> Maybe it is more appropriate not to show this message, doesn't it?
> 
> ==============================================================================
> > +               if (kstrtou8(tmp, 10, &new_ch_modes[AD559XR_CHANNEL_NR 
> > + - idx - 1])) {  
> 
> Shadowing errors?
> 
> ---
> 
> => William  
> 
> In the prototype of kstrtou8, it will return int to indicate this function is successful or not.
> I just want to make sure all the translations from string to integer are correct.
> 
> ==============================================================================
> 
> For the others, I'll fix these.
> 
> Thanks again and please kindly give me your advice if any.
> 
> Best regards,
> 
> William Sung
> Phone: +886-2-2792-7818 ext: 7644
> Advantech Co., Ltd.
> 
o

