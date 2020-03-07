Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875EF17CE52
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 14:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgCGNKc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 08:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCGNKc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 08:10:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60F5206D5;
        Sat,  7 Mar 2020 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583586631;
        bh=nhycwUYvLcc1jqIwGlYnopw0ZrxYCKb/b2OY7Uj4FwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JI8gn2W84y0ALPhrFDElK2x4Ln3mf7EtetJJZVMFop7mTZj3wlqzfklEL3NRHOxJE
         DSq6hSoMo1sH3hdbmwQeD5VGqkXjd8fRiBKxoNmz1Riw6uT2Z56oxSyKPOlWbryTw0
         xL7Mc2eCYl8CoWIzEDkxJiLX/LkqVu9WcbJ4ly1w=
Date:   Sat, 7 Mar 2020 13:10:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio:ad7797: Use correct attribute_group
Message-ID: <20200307131026.39f55a61@archlinux>
In-Reply-To: <8d7a7062af94a3531dd519bd60fe26c8530c6a43.camel@analog.com>
References: <20200302133249.23152-1-yuehaibing@huawei.com>
        <8d7a7062af94a3531dd519bd60fe26c8530c6a43.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Mar 2020 06:35:28 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2020-03-02 at 21:32 +0800, YueHaibing wrote:
> > [External]
> > 
> > It seems ad7797_attribute_group should be used in ad7797_info,
> > according to commit ("iio:ad7793: Add support for the ad7796 and ad7797").  
> 
> While the change looks good at first, I am thinking that this might introduce
> another issue while fixing this one.
> 
> It looks like the ad7797_attributes[] array may also require the
> &iio_dev_attr_in_m_in_scale_available.dev_attr.attr attribute as well.
> It looks like the available scales should be printed for AD7997 as well.
> 
> That being said, this patch is fine as-is.
> But it would require a patch [before-this-patch] to fix the ad7797_attributes
> array.
> 
> Something like this:
> 
> static struct attribute *ad7797_attributes[] = {
>         &iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
> +       &iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
>        NULL
> };
> 
> I'm hoping I'm right about this one. I sometimes don't notice things too well.

Agreed. Should have that addition as well.  If not we'll successfully fix
one issue but drop a valid interface at the same time...

Thanks,

Jonathan

> 
> > 
> > Fixes: fd1a8b912841 ("iio:ad7793: Add support for the ad7796 and ad7797")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/iio/adc/ad7793.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> > index b747db9..e5691e3 100644
> > --- a/drivers/iio/adc/ad7793.c
> > +++ b/drivers/iio/adc/ad7793.c
> > @@ -542,7 +542,7 @@ static const struct iio_info ad7797_info = {
> >  	.read_raw = &ad7793_read_raw,
> >  	.write_raw = &ad7793_write_raw,
> >  	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
> > -	.attrs = &ad7793_attribute_group,
> > +	.attrs = &ad7797_attribute_group,
> >  	.validate_trigger = ad_sd_validate_trigger,
> >  };
> >    

