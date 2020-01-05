Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA8D130717
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2020 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgAEKgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jan 2020 05:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEKgb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jan 2020 05:36:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCD520866;
        Sun,  5 Jan 2020 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578220590;
        bh=+/iStnPwhP542628pOw3mMn8MnVqED4tQzXbzXKLjX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jgdrO4luZGTN4hh/Bi100t2Ifh8xx+Dfu9snipBpGBvIvFPoD0jqTHFFrmD69mjyN
         oghPX5cKXINRXRzZi++u6fnogFn8k18nEvesM/YIo6oNZ8tHaJC8VrOFMWRhgk/PnD
         TG9Jw6rjP60YdIsHGQr7N+JAxul5X7yXoCZHflVQ=
Date:   Sun, 5 Jan 2020 10:36:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>
Subject: Re: [PATCH 2/2 v1] iio: light: Add a driver for Sharp GP2AP002x00F
Message-ID: <20200105103624.07b3820c@archlinux>
In-Reply-To: <20200102221533.GC8314@dtor-ws>
References: <20191228201109.13635-1-linus.walleij@linaro.org>
        <20191228201109.13635-2-linus.walleij@linaro.org>
        <20191230173919.373f4e8a@archlinux>
        <20200102221533.GC8314@dtor-ws>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2 Jan 2020 14:15:33 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Jonathan,
> 
> On Mon, Dec 30, 2019 at 05:39:19PM +0000, Jonathan Cameron wrote:
> > On Sat, 28 Dec 2019 21:11:09 +0100
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >   
> > > +	/* Enable chip and IRQ, disable analog sleep */
> > > +	ret = regmap_write(gp2ap002->map, GP2AP002_OPMOD,
> > > +			   OPMOD_SSD_OPERATING | OPMOD_VCON_IRQ);
> > > +	if (ret < 0) {
> > > +		dev_err(gp2ap002->dev, "error setting up operation mode\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* Interrupt on VOUT enabled */
> > > +	ret = regmap_write(gp2ap002->map, GP2AP002_CON, CON_OCON_ENABLE);
> > > +	if (ret < 0) {
> > > +		dev_err(gp2ap002->dev, "error setting up VOUT control\n");
> > > +		return ret;  
> > 
> > drop this return ret out of the brackets as it's either 0 or negative anyway.  
> 
> Not my subsystem, but $0.02 anyways: I like calling the temp as "error"
> and explicitly return 0 in the success path even if it could be
> collapsed, as you can easily add more initialization without needing
> to go and alter previous blocks.

That's a perfectly valid method as long as ret is only ever an error
(or good).  We've tended to go with ret in IIO, so better to carry on with
that. 

I'm not that fussed about dropping the return ret; out, but definitely
prefer explicit if (ret) to make it clear ret is never positive in the
good path though.

Thanks,

Jonathan

> 
> Thanks.
> 

