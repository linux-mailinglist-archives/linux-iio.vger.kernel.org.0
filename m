Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D436A121
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhDXMbl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 08:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhDXMbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 08:31:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA5E61474;
        Sat, 24 Apr 2021 12:30:59 +0000 (UTC)
Date:   Sat, 24 Apr 2021 13:31:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 1/7] iio: adc: adi-axi-adc: simplify
 devm_adi_axi_adc_conv_register
Message-ID: <20210424133139.2c996f72@jic23-huawei>
In-Reply-To: <e58b460c-33c7-e544-539c-2d25f96fa17a@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
        <20210411151215.5d3e5494@jic23-huawei>
        <e58b460c-33c7-e544-539c-2d25f96fa17a@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 17:10:17 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> On 2021/4/11 22:12, Jonathan Cameron wrote:
> > On Thu, 8 Apr 2021 19:38:10 +0800
> > Yicong Yang <yangyicong@hisilicon.com> wrote:
> >   
> >> Use devm_add_action_or_reset() instead of devres_alloc() and
> >> devres_add(), which works the same. This will simplify the
> >> code. There is no functional changes.
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  drivers/iio/adc/adi-axi-adc.c | 22 +++++++++-------------
> >>  1 file changed, 9 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> >> index 9109da2..575a63f 100644
> >> --- a/drivers/iio/adc/adi-axi-adc.c
> >> +++ b/drivers/iio/adc/adi-axi-adc.c
> >> @@ -210,29 +210,25 @@ static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
> >>  	kfree(cl);
> >>  }
> >>  
> >> -static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
> >> +static void devm_adi_axi_adc_conv_release(void *conv)
> >>  {
> >> -	adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
> >> +	adi_axi_adc_conv_unregister(conv);
> >>  }
> >>  
> >>  struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
> >>  							size_t sizeof_priv)
> >>  {
> >> -	struct adi_axi_adc_conv **ptr, *conv;
> >> -
> >> -	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
> >> -			   GFP_KERNEL);
> >> -	if (!ptr)
> >> -		return ERR_PTR(-ENOMEM);
> >> +	struct adi_axi_adc_conv *conv;
> >> +	int ret;
> >>  
> >>  	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
> >> -	if (IS_ERR(conv)) {
> >> -		devres_free(ptr);
> >> +	if (IS_ERR(conv))
> >>  		return ERR_CAST(conv);  
> > 
> > Is that ERR_CAST() needed here?  conv is already of the
> > right type so we don't need to cast it to a void * and back gain.
> > Obviously was there before an not needed either, but might as well
> > tidy it up whilst we are here!  
> 
> sure. thanks for the hint. I didn't notice this. will drop the ERR_CAST.
> 
> thanks!

Rather than waste your time doing a v2 for such a trivial change, I've
applied the patch and tweaked that whilst doing so.

Applied to the togreg branch of iio.git and pushed out as testing to
let 0-day poke at it etc.

Thanks,

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > 
> >   
> >> -	}
> >>  
> >> -	*ptr = conv;
> >> -	devres_add(dev, ptr);
> >> +	ret = devm_add_action_or_reset(dev, devm_adi_axi_adc_conv_release,
> >> +				       conv);
> >> +	if (ret)
> >> +		return ERR_PTR(ret);
> >>  
> >>  	return conv;
> >>  }  
> > 
> > 
> > .
> >   
> 

