Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFD2C796B
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK2N2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 08:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2N2z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 08:28:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40896207FF;
        Sun, 29 Nov 2020 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606656494;
        bh=EpSJjFZwW/wXqvkon+HSMF7rczuaRkR4T/E+7DMirZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BQGfr3ZJCYiqQIqmP/LqKa6hOwJ+n3lketYYDaHoawVgLfvaRDTMMiXmiK2RZVdgW
         lUfSi1i2Jgdc7TFh3h6foG8/KR4bUK7WCIpoFk8WZ98/Gw2bpCEKP2ypQ+TbMIhoTr
         DiJV9pgSjo/ErIPM7f4S6PcHAoQWHcOwCI/5qKbk=
Date:   Sun, 29 Nov 2020 13:28:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 22/27] iio:adc:ti-adc084s021 Tidy up endian types
Message-ID: <20201129132809.434dbcf9@archlinux>
In-Reply-To: <20200913130604.622c1125@archlinux>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-23-jic23@kernel.org>
        <20200809184755.63d60ac6@archlinux>
        <20200913130146.46983bcc@archlinux>
        <20200913130604.622c1125@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Sep 2020 13:06:04 +0100
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On Sun, 13 Sep 2020 13:01:46 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 9 Aug 2020 18:47:55 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Wed, 22 Jul 2020 16:50:58 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >     
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > By adding a few local variables and avoiding a void * for
> > > > a parameter we can easily make all the endian types explicit and
> > > > get rid of the warnings from sparse:
> > > > 
> > > >   CHECK   drivers/iio/adc/ti-adc084s021.c
> > > > drivers/iio/adc/ti-adc084s021.c:84:26: warning: incorrect type in assignment (different base types)
> > > > drivers/iio/adc/ti-adc084s021.c:84:26:    expected unsigned short [usertype]
> > > > drivers/iio/adc/ti-adc084s021.c:84:26:    got restricted __be16
> > > > drivers/iio/adc/ti-adc084s021.c:115:24: warning: cast to restricted __be16
> > > > drivers/iio/adc/ti-adc084s021.c:115:24: warning: cast to restricted __be16
> > > > drivers/iio/adc/ti-adc084s021.c:115:24: warning: cast to restricted __be16
> > > > drivers/iio/adc/ti-adc084s021.c:115:24: warning: cast to restricted __be16
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>      
> > > 
> > > I'm a bit in 2 minds about this one.  The exact warning will change as the
> > > result of the previous patch, but the problem is not introduced by that.
> > > Technically it's not a 'fix' so I'll hold this one for now.    
> > 
> > Applied this one to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to play with it.  
> And failed my local tests. Precursor not in my branch yet.
> oops.
> Dropped again for now.
And applied again successfully.

Jonathan

> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > 
> > > Jonathan
> > >     
> > > > ---
> > > >  drivers/iio/adc/ti-adc084s021.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> > > > index dfba34834a57..fb14b92fa6e7 100644
> > > > --- a/drivers/iio/adc/ti-adc084s021.c
> > > > +++ b/drivers/iio/adc/ti-adc084s021.c
> > > > @@ -70,11 +70,10 @@ static const struct iio_chan_spec adc084s021_channels[] = {
> > > >   * @adc: The ADC SPI data.
> > > >   * @data: Buffer for converted data.
> > > >   */
> > > > -static int adc084s021_adc_conversion(struct adc084s021 *adc, void *data)
> > > > +static int adc084s021_adc_conversion(struct adc084s021 *adc, __be16 *data)
> > > >  {
> > > >  	int n_words = (adc->spi_trans.len >> 1) - 1; /* Discard first word */
> > > >  	int ret, i = 0;
> > > > -	u16 *p = data;
> > > >  
> > > >  	/* Do the transfer */
> > > >  	ret = spi_sync(adc->spi, &adc->message);
> > > > @@ -82,7 +81,7 @@ static int adc084s021_adc_conversion(struct adc084s021 *adc, void *data)
> > > >  		return ret;
> > > >  
> > > >  	for (; i < n_words; i++)
> > > > -		*(p + i) = adc->rx_buf[i + 1];
> > > > +		*(data + i) = adc->rx_buf[i + 1];
> > > >  
> > > >  	return ret;
> > > >  }
> > > > @@ -93,6 +92,7 @@ static int adc084s021_read_raw(struct iio_dev *indio_dev,
> > > >  {
> > > >  	struct adc084s021 *adc = iio_priv(indio_dev);
> > > >  	int ret;
> > > > +	__be16 be_val;
> > > >  
> > > >  	switch (mask) {
> > > >  	case IIO_CHAN_INFO_RAW:
> > > > @@ -107,13 +107,13 @@ static int adc084s021_read_raw(struct iio_dev *indio_dev,
> > > >  		}
> > > >  
> > > >  		adc->tx_buf[0] = channel->channel << 3;
> > > > -		ret = adc084s021_adc_conversion(adc, val);
> > > > +		ret = adc084s021_adc_conversion(adc, &be_val);
> > > >  		iio_device_release_direct_mode(indio_dev);
> > > >  		regulator_disable(adc->reg);
> > > >  		if (ret < 0)
> > > >  			return ret;
> > > >  
> > > > -		*val = be16_to_cpu(*val);
> > > > +		*val = be16_to_cpu(be_val);
> > > >  		*val = (*val >> channel->scan_type.shift) & 0xff;
> > > >  
> > > >  		return IIO_VAL_INT;      
> > >     
> >   
> 

