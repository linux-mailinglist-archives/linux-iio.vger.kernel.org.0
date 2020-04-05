Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C984019EB0F
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDEL7y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 07:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgDEL7y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 07:59:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F37F20675;
        Sun,  5 Apr 2020 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586087993;
        bh=SgSsLDvot6khgvlqMhImBKJ2FpjIYxBtnMY4l9XrFrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XoaYpNNmT9y4ScrFclTpsZEW2T1GNhNyQKsXDFnux2aICGdGAKaviD9IJvwZv/WRG
         y6tPNf5fcJpoUYMC8dMuOolOHN3pbv8UEhLj+0E5AJzD7I41dxu6nkojsS31o99Vnn
         zJvgybrv95Qwa1nAysXa+mvp3+5xhlKKLg/1G65Q=
Date:   Sun, 5 Apr 2020 12:59:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: dac: ad5770r: fix off-by-one check on
 maximum number of channels
Message-ID: <20200405125948.76aa343a@archlinux>
In-Reply-To: <84628ce3f18d1a1ab50f76d04386dbef46f151b3.camel@analog.com>
References: <20200403125838.71271-1-colin.king@canonical.com>
        <84628ce3f18d1a1ab50f76d04386dbef46f151b3.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Apr 2020 13:26:00 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2020-04-03 at 13:58 +0100, Colin King wrote:
> > [External]
> > 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently there is an off-by-one check on the number of channels that
> > will cause an arry overrun in array st->output_mode when calling the
> > function d5770r_store_output_range. Fix this by using >= rather than >
> > to check for maximum number of channels.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> > Addresses-Coverity: ("Out-of-bounds access")
> > Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to the fixes-togreg branch of iio.git.

thanks

Jonathan

> > ---
> >  drivers/iio/dac/ad5770r.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> > index a98ea76732e7..2d7623b9b2c0 100644
> > --- a/drivers/iio/dac/ad5770r.c
> > +++ b/drivers/iio/dac/ad5770r.c
> > @@ -525,7 +525,7 @@ static int ad5770r_channel_config(struct ad5770r_state
> > *st)
> >  		ret = fwnode_property_read_u32(child, "num", &num);
> >  		if (ret)
> >  			return ret;
> > -		if (num > AD5770R_MAX_CHANNELS)
> > +		if (num >= AD5770R_MAX_CHANNELS)
> >  			return -EINVAL;
> >  
> >  		ret = fwnode_property_read_u32_array(child,  

