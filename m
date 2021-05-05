Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81BE373BDD
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 15:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhEENBZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhEENBX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 09:01:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9503C061574;
        Wed,  5 May 2021 06:00:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso1609741ote.1;
        Wed, 05 May 2021 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6/BCvyE+swEfZEm7dx62fy7UpXmf1gCYIgzc2eCpj8s=;
        b=p35u/rFxZvoWd10s8IxG5QjMDNeASuUBfDl8KvNhsQUcarDIs2CdbbwHAUfbl8ISwz
         ScHGAwb8A8JiGRqOEKDAcyrxx4DZ0YyZ9cr72Ec//iFIS8rjU8TugErVjeaGQp7mLSw4
         K4Ew+rhAcuxSCEmqgrtQzkQOoSnhUXHAp/ElIIo60mEMeShrPP+FG2qwBX0GmYjCaB2O
         ifdXIrjfPJrMPIuHbvL3qn2QIcldc+EvCnaisfRRNQRPXAj13Im9IYDGtIpH0ExTZQyG
         +Zpyvy4YajTi+my96PF6PsaBNOZJVgYS6MJwWoYa5oKkaVnCwEFsdWSO8DCbKpimQFt1
         cuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6/BCvyE+swEfZEm7dx62fy7UpXmf1gCYIgzc2eCpj8s=;
        b=USHeFnl2nS2A3VvA4FILpKftn4AmE3QxaWY0s9DH+xZ1ck2ziyndCc9jTRR8NMzzqD
         gl8eEQabSyRFI2NhC0OKHYqzDa5Px+GmaXHjKGQvvDlazpACDqNYBdcxSWOsbsxCxotp
         7yOoEwc/3x1lz0oWY11GA6s2ONM1sZn1ClNAE66Wt0yKmnk3pGnc2zB9xtTivOaBfELx
         h2XQ1N1ornIHxAzgN3YS+Yd8S63CwtdCVT0r4iAdly14L5wY5uYyHUzZMvlRtU3Ko+WB
         ilFw5yeGy3QkxG06r/YtwM0AYBqI2j2CfNLkGfmmuR0YzkK7N3iCT6kEh9ZSnBu28fkC
         g/xQ==
X-Gm-Message-State: AOAM532IkqVZ33IeOOqVrHavL0LlCN8gvt4BRqGxNauPT/Avy9e3grkB
        7Xu2QoN113FmtR6ts4VY4tQ=
X-Google-Smtp-Source: ABdhPJw0ajwlSvji6vU1NttfNQWcwxzdynIQTMExnHD+Mdt1mIqGLpGKnFso5gq0NV6p4Wnk/pvSBA==
X-Received: by 2002:a9d:200b:: with SMTP id n11mr8706329ota.177.1620219625295;
        Wed, 05 May 2021 06:00:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c95sm635326otb.80.2021.05.05.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 06:00:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 May 2021 06:00:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on
 CONFIG_ACPI
Message-ID: <20210505130022.GA3752808@roeck-us.net>
References: <20210504174019.2134652-1-linux@roeck-us.net>
 <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net>
 <20210505093235.00007c38@Huawei.com>
 <20210505093438.00005238@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505093438.00005238@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 05, 2021 at 09:34:38AM +0100, Jonathan Cameron wrote:
> On Wed, 5 May 2021 09:32:35 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Tue, 4 May 2021 11:00:52 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > > On 5/4/21 10:44 AM, Andy Shevchenko wrote:  
> > > > On Tue, May 4, 2021 at 8:40 PM Guenter Roeck <linux@roeck-us.net> wrote:    
> > > >>
> > > >> With CONFIG_ACPI=n and -Werror, 0-day reports:
> > > >>
> > > >> drivers/iio/chemical/bme680_i2c.c:46:36: error:
> > > >>         'bme680_acpi_match' defined but not used    
> > > >     
> > > >> Given the other patch, question of course is if this ACPI ID
> > > >> is real. A Google search suggests that this might not be the case.
> > > >> Should we remove it as well ? STK8312 has the same problem.    
> > > > 
> > > > For this one definitely removal. Looking into the code it suggests a
> > > > cargo cult taken that time by a few contributors to invent fake ACPI
> > > > IDs while submitting new drivers.
> > > > Feel free to add my tag or if you wish me I'll add it explicitly.
> > > >     
> > > 
> > > I'll resend and let you add the tag, and send a similar patch
> > > for STK8312. I'll wait until tomorrow, though - I sent a number of
> > > patches today already, and I want to avoid yet another "account
> > > suspended" notice from gmail.  
> > 
> > If you find some valid ACPI entries that are hitting this problem,
> > I'd prefer we just got rid of the ACPI_PTR() usecases rather than
> > added IFDEF magic.
> > 
> > The space wasted by having these is trivial and I'd rather not
> > introduce ifdef around any of these tables.
> > 
> > Dropping the ones we are fairly sure are spurious is even better!
> 
> If I get bored I'll just do a scrub of all the instances of this that
> you haven't already cleaned up.  It's worth noting that we do
> know some highly suspicious looking entries are out there in the wild. 
> 

The ones reported by 0-day are AOS2315, BME0680, and STK8312.
You just accepted a patch for -next which claims that all users of
STK8312 would be ACPI, yet Andy says that STK8312 isn't a valid ACPI ID.

Not really sure from the above if I should send patches to remove
acpi support from those drivers or if you want to handle that yourself.

Other drivers such as FXOS8700 should also generate a warning with
CONFIG_ACPI=n but for some reason don't. I have not tried to track down
the reason.

Anyway, for an "outsider" it seems all but impossible to determine if
an ACPI ID is real or made up. How does one know ?

Note that I didn't actually get any of your e-mails (nor, I notice, several
other e-mails I was copied on). I picked this one up from the linux-kernel
mailing list. My apologies if I don't reply to any of your e-mails;
that would be the reason.

Guenter
