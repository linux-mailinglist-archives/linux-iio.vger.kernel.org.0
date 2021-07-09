Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D93C1F9B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 09:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGIGv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 02:51:26 -0400
Received: from first.geanix.com ([116.203.34.67]:33146 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhGIGvZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 02:51:25 -0400
Received: from skn-laptop (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id E65294C6131;
        Fri,  9 Jul 2021 06:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1625813320; bh=G0vkrddXVJRk86vG8AulMVgWg2Euen3OkHPG0N5Lqzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GJVzd35pmHfMihPaCrCIIrePwsC6hhHg1u9rv11Sm3xm5WOW1fxP+6zFytNabgF5v
         yb50kv8LdqD/KALAMcDnwR1raf6tiK36mVm5kC/Ao1P6O8RRE9POF4LfCCCNj82aQH
         6R/DpzFRfbS4fJVR6WuRPeKqgqqtZEyVDOq38XqMDJxohXSR6Sdai6PFBm9j0EOxe0
         wn6DmqhkQnn9HtLM3iDPg+9Q9nUGGKCdilm+qLFU3tEL5O7NGr2RmAgN4ASnBj3ojJ
         LBtfbAMwGnfnQqMX6x43MUWNINjk6i2QxgNKUi1KJdvFrX6a+RrksBLW2nkN6Xaw5g
         vV7DQZJFoZZGw==
Date:   Fri, 9 Jul 2021 08:48:38 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: Initialize return value
Message-ID: <20210709064838.wtuqgm3qwguhpfjn@skn-laptop>
References: <20210709031526.30746-1-jrdr.linux@gmail.com>
 <CAOMZO5BHDBR5y5q559UexTmYbhPwSp1MV3TJ3k+z4W8ehE-5_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMZO5BHDBR5y5q559UexTmYbhPwSp1MV3TJ3k+z4W8ehE-5_Q@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Souptick and Fabio.

On Fri, Jul 09, 2021 at 12:36:25AM -0300, Fabio Estevam wrote:
> Hi Souptick,
> 
> On Fri, Jul 9, 2021 at 12:17 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > kernel test robot throws below warning ->
> >
> > smatch warnings:
> > drivers/iio/accel/fxls8962af-core.c:640
> > fxls8962af_i2c_raw_read_errata3() error: uninitialized symbol 'ret'.
> >
> > Initialize it.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Missing fixes-tag ;)

[ ... ]

> 
> Would the change below work?
> 
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -637,7 +637,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct
> fxls8962af_data *data,
>                         return ret;
>         }
> 
> -       return ret;
> +       return 0;
>  }

I have already submitted a patch for this :)
https://patchwork.kernel.org/project/linux-iio/patch/20210623113115.581609-1-sean@geanix.com/

/Sean
