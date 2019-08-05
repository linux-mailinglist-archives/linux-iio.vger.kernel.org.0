Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952A08202E
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfHEP30 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfHEP3Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:29:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C51B21738;
        Mon,  5 Aug 2019 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565018964;
        bh=KZoZhIg+Ku63ddEXj59y9xDS/EYnXHJ38GB5+0ZbPpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b7LFwM5y5YwWKYElAOtCo1Nat/J1W1xyxp+6tXkk7mYuZ30FIt/BcpbBumIeYhfEL
         YiL7TW14qIBnivEaMg6UAPRFqSo8mgKsI4lDLagCpGr0P5Pt3xqyUNASq0BrVuIFvY
         FFnDAIK3zpWxIo6qE2mGeC1y9w8GqmofFcHJYu28=
Date:   Mon, 5 Aug 2019 16:29:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: tsl2772: Use devm_add_action_or_reset for
 tsl2772_chip_off
Message-ID: <20190805162920.762c48b5@archlinux>
In-Reply-To: <20190801093526.GB27653@onstation.org>
References: <20190801073605.9635-1-hslester96@gmail.com>
        <20190801093526.GB27653@onstation.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Aug 2019 05:35:26 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Thu, Aug 01, 2019 at 03:36:05PM +0800, Chuhong Yuan wrote:
> > Use devm_add_action_or_reset to call tsl2772_chip_off
> > when the device is removed.
> > This also fixes the issue that the chip is turned off
> > before the device is unregistered.
> > 
> > Fixes: 4e24c1719f34 ("staging: iio: tsl2x7x: rename driver to tsl2772")
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>  
> 
> Let's use this Fixes tag instead:
> 
> Fixes: c06c4d793584 ("staging: iio: tsl2x7x/tsl2772: move out of staging")
> 
> I'd wait and see if Jonathan wants you to resend out the series if he
> has any changes.

I've added a note to say this will probably need a backport for stable.
Actually in that case we should be looking for a more minimal solution than
this anyway.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Brian
> 
> 
> > ---
> > Changes in v4:
> >   - Split v3 into three patches.
> >   - Revise description to make it more precise.
> > 
> >  drivers/iio/light/tsl2772.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index 29cfd8ae2700..e866ae40f157 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -860,6 +860,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_dev)
> >  	return tsl2772_write_control_reg(chip, 0x00);
> >  }
> >  
> > +static void tsl2772_chip_off_action(void *data)
> > +{
> > +	struct iio_dev *indio_dev = data;
> > +
> > +	tsl2772_chip_off(indio_dev);
> > +}
> > +
> >  /**
> >   * tsl2772_invoke_change - power cycle the device to implement the user
> >   *                         parameters
> > @@ -1877,9 +1884,14 @@ static int tsl2772_probe(struct i2c_client *clientp,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	ret = devm_add_action_or_reset(&clientp->dev,
> > +					tsl2772_chip_off_action,
> > +					indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret) {
> > -		tsl2772_chip_off(indio_dev);
> >  		dev_err(&clientp->dev,
> >  			"%s: iio registration failed\n", __func__);
> >  		return ret;
> > @@ -1926,8 +1938,6 @@ static int tsl2772_remove(struct i2c_client *client)
> >  {
> >  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> >  
> > -	tsl2772_chip_off(indio_dev);
> > -
> >  	iio_device_unregister(indio_dev);
> >  
> >  	return 0;
> > -- 
> > 2.20.1  

