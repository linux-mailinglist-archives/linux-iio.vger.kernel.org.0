Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64623375523
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhEFNvx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhEFNvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 09:51:53 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C007C061574;
        Thu,  6 May 2021 06:50:54 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so1263108ool.1;
        Thu, 06 May 2021 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eOWzmw7LWup9POWTY0PXeEW1iZlr/eM2G/EkgSsH3k4=;
        b=NzPx4BLu+UPLMOVMFmfhlKyxll4sLdE1pCLQEkMi1JxwhRVzTQYMf6WnrpUnygSiif
         NlXvryB8WU2gHdS7eG3uQonU3jKA8BhqbQoXjKXpayqM8NOIgZP4l0GRvcUWygfp6DYI
         Mp0xepIeJVYbBc6oHU+jvcidoU2dwDf+cvNIoXpcDi1y31QuQH0FaPXK6BNd3DKKxlvZ
         J+o6PMkdEaILrWw0NyVkPq8X4cpYBqXq1to+nCsQ9r3PJ5JQTAxLFed9LvS+mi/rI3iW
         C6oXokvZMwq/HwzXiQgccgkZxCOUPl8wDwdTRLPNuHR47mO5839x9JmFDtF8JWjOTO1N
         NxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eOWzmw7LWup9POWTY0PXeEW1iZlr/eM2G/EkgSsH3k4=;
        b=sPA1mrfh5TUhPZjUAPctQen28SJmSRe6AWQiWx/NmgReIQHeH5JEYr/4B4gR303mZ8
         Wvd0opPCbE9eCcR5dX4jCTiXLKyAmEeLtTgiykV9zyg8E4IZik/b04mBak9coPOioMwM
         nNqtRRN4S104EYuWLnEjP1+yBiUPfi0SxVOQeIJDAN4kPDi51rt2Q2i8PEXmk7pR5zm6
         pMwAuBbh4wi+0TNW2q1R394IzkxUj3BIc9HbtcgTv8m0786BA7SRbUREMzs1nB5NpTFN
         v+TvWkb9Fs/VnGBG9IGt9XA/nt4fqWP46mHykglBRPwd/ATHXdfOHkh4q5Q0SBVZzv/h
         uM6A==
X-Gm-Message-State: AOAM532o/UmsVRVuTVCKzxC4PgDftycf2vR1/LyeyreZ8G1183IhcSaL
        MjmfKsW16FEPt+kHWN/3C14igjttT5I=
X-Google-Smtp-Source: ABdhPJxdAFwhh+kB5y90jD50aP4k3GzVzP/G3PBYrS6EsM+Zpr0baZ2Z6MhsC+aKX3nKCUJOwZE5FQ==
X-Received: by 2002:a4a:a223:: with SMTP id m35mr3466234ool.39.1620309054111;
        Thu, 06 May 2021 06:50:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m67sm557989otm.69.2021.05.06.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:50:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 May 2021 06:50:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
Message-ID: <20210506135052.GB2267050@roeck-us.net>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
 <20210506133754.GA2266661@roeck-us.net>
 <768c06ff-663c-eacb-fd3c-628b4e4ba449@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <768c06ff-663c-eacb-fd3c-628b4e4ba449@redhat.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 06, 2021 at 03:42:08PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/6/21 3:37 PM, Guenter Roeck wrote:
> > On Thu, May 06, 2021 at 12:28:40PM +0300, Andy Shevchenko wrote:
> >> On Thu, May 6, 2021 at 6:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>
> >>> With CONFIG_ACPI=n and -Werror, 0-day reports:
> >>>
> >>> drivers/iio/chemical/bme680_i2c.c:46:36: error:
> >>>         'bme680_acpi_match' defined but not used
> >>>
> >>> Apparently BME0680 is not a valid ACPI ID. Remove it and with it
> >>> ACPI support from the bme680_i2c driver.
> >>
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>
> >> with the SPI part amended in the same way.
> >>
> > Right. I just sent a patch doing that. Oddly enough 0-day didn't complain
> > about that one to me, nor about many other drivers with the same problem.
> > No idea how it decides if and when to make noise.
> > 
> > Is there a way to determine invalid ACPI IDs ?
> 
> No, unfortunately not. There is a format which ACPI IDs are
> supposed to follow, but some "out in the wild" API ids don't
> follow this; and many fake (made up) ACPI ids do follow it...
> 
> We (mostly Andy and me) are not even 100% sure this one is
> a fake ACPI ID, but we do pretty strongly believe that it is.
> 

What a mess :-(

Guenter
