Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C911CC9EF
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfJEM1b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 08:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEM1b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 08:27:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6652133F;
        Sat,  5 Oct 2019 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570278450;
        bh=0AzfT4oxB27Lyhc/PIW8AgMogugaqnPneuW+B49XY/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HXYvYLELZ8kadFnsrHq7PSaLF3mdwOyf8eqoaQtX849NKqo+kaVyaUEKuIqwwyK+n
         5hJ0p0rviyJd0aZOfz53LsUR4KY9tiUXoxo2j9xDojUawp6DZE5jc6KfX+aritTk/a
         lnyaImTbOUCvaaEHQhg7ObmBEfvkCAIbv9FQCbbE=
Date:   Sat, 5 Oct 2019 13:27:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, knaack.h@gmx.de,
        lars@metafoo.de, tomas@novotny.cz, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] iio: light: fix vcnl4000 devicetree hooks
Message-ID: <20191005132725.329becbf@archlinux>
In-Reply-To: <2eb045ee57319a3c1981adf90df80325@akkea.ca>
References: <20190917145637.22605-1-m.felsch@pengutronix.de>
        <2eb045ee57319a3c1981adf90df80325@akkea.ca>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Sep 2019 07:46:56 -0700
Angus Ainslie <angus@akkea.ca> wrote:

> On 2019-09-17 07:56, Marco Felsch wrote:
> > Since commit ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
> > the of_match_table is supported but the data shouldn't be a string.
> > Instead it shall be one of 'enum vcnl4000_device_ids'. Also the 
> > matching
> > logic for the vcnl4020 was wrong. Since the data retrieve mechanism is
> > still based on the i2c_device_id no failures did appeared till now.
> > 
> > Fixes: ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>  
> 
> Reviewed-by: Angus Ainslie (Purism) angus@akkea.ca
Applied to the fixes-togreg branch of iio.git and marked for stable.

It might not have impact, but it's clearly wrong so lets get
it fixed in stable branches.  Oops to letting this one through.

Jonathan

> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c 
> > b/drivers/iio/light/vcnl4000.c
> > index 51421ac32517..f522cb863e8c 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -398,19 +398,19 @@ static int vcnl4000_probe(struct i2c_client 
> > *client,
> >  static const struct of_device_id vcnl_4000_of_match[] = {
> >  	{
> >  		.compatible = "vishay,vcnl4000",
> > -		.data = "VCNL4000",
> > +		.data = (void *)VCNL4000,
> >  	},
> >  	{
> >  		.compatible = "vishay,vcnl4010",
> > -		.data = "VCNL4010",
> > +		.data = (void *)VCNL4010,
> >  	},
> >  	{
> > -		.compatible = "vishay,vcnl4010",
> > -		.data = "VCNL4020",
> > +		.compatible = "vishay,vcnl4020",
> > +		.data = (void *)VCNL4010,
> >  	},
> >  	{
> >  		.compatible = "vishay,vcnl4200",
> > -		.data = "VCNL4200",
> > +		.data = (void *)VCNL4200,
> >  	},
> >  	{},
> >  };  

