Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02CC3DD38E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhHBKUx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 06:20:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3547 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHBKUx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 06:20:53 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdYtC4lkXz6DJ3D;
        Mon,  2 Aug 2021 18:20:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 12:20:42 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 11:20:41 +0100
Date:   Mon, 2 Aug 2021 11:20:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/5] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
Message-ID: <20210802112013.00000ff4@Huawei.com>
In-Reply-To: <CD8JT5A4TPLB.33HN2VCYJXKSS@shaak>
References: <20210727232906.980769-1-liambeguin@gmail.com>
        <20210727232906.980769-3-liambeguin@gmail.com>
        <20210731152921.2fcb53ab@jic23-huawei>
        <20210731155228.5cf77479@jic23-huawei>
        <CD8JT5A4TPLB.33HN2VCYJXKSS@shaak>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 01 Aug 2021 19:01:10 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> On Sat Jul 31, 2021 at 10:52 AM EDT, Jonathan Cameron wrote:
> > On Sat, 31 Jul 2021 15:29:21 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > On Tue, 27 Jul 2021 19:29:03 -0400
> > > Liam Beguin <liambeguin@gmail.com> wrote:
> > >   
> > > > From: Liam Beguin <lvb@xiphos.com>
> > > > 
> > > > This driver supports devices with 14-bit and 16-bit sample sizes.
> > > > This is not always handled properly by spi controllers and can fail. To
> > > > work around this limitation, pad samples to 16-bit and split the sample
> > > > into two 8-bit messages in the event that only 8-bit messages are
> > > > supported by the controller.
> > > > 
> > > > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > > > ---
> > > >  drivers/iio/adc/ad7949.c | 62 ++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 54 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > > > index 0b549b8bd7a9..f1702c54c8be 100644
> > > > --- a/drivers/iio/adc/ad7949.c
> > > > +++ b/drivers/iio/adc/ad7949.c
> > > > @@ -67,6 +67,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
> > > >   * @indio_dev: reference to iio structure
> > > >   * @spi: reference to spi structure
> > > >   * @resolution: resolution of the chip
> > > > + * @bits_per_word: number of bits per SPI word
> > > >   * @cfg: copy of the configuration register
> > > >   * @current_channel: current channel in use
> > > >   * @buffer: buffer to send / receive data to / from device
> > > > @@ -77,6 +78,7 @@ struct ad7949_adc_chip {
> > > >  	struct iio_dev *indio_dev;
> > > >  	struct spi_device *spi;
> > > >  	u8 resolution;
> > > > +	u8 bits_per_word;
> > > >  	u16 cfg;
> > > >  	unsigned int current_channel;
> > > >  	u16 buffer ____cacheline_aligned;
> > > > @@ -86,19 +88,34 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> > > >  				u16 mask)
> > > >  {
> > > >  	int ret;
> > > > -	int bits_per_word = ad7949_adc->resolution;
> > > > -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;    
> > > 
> > > The define for this was removed in patch 1.  I'll fix that up whilst applying by
> > > keeping it until this patch.  Please check build passes on intermediate points
> > > during a patch series as otherwise we may break bisectability and that's really
> > > annoying if you are bisecting!
> > > 
> > > Jonathan
> > >   
> > > >  	struct spi_message msg;
> > > >  	struct spi_transfer tx[] = {
> > > >  		{
> > > >  			.tx_buf = &ad7949_adc->buffer,
> > > >  			.len = 2,
> > > > -			.bits_per_word = bits_per_word,
> > > > +			.bits_per_word = ad7949_adc->bits_per_word,
> > > >  		},
> > > >  	};
> > > >  
> > > > +	ad7949_adc->buffer = 0;
> > > >  	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> > > > -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
> > > > +
> > > > +	switch (ad7949_adc->bits_per_word) {
> > > > +	case 16:
> > > > +		ad7949_adc->buffer = ad7949_adc->cfg << 2;
> > > > +		break;
> > > > +	case 14:
> > > > +		ad7949_adc->buffer = ad7949_adc->cfg;
> > > > +		break;
> > > > +	case 8:
> > > > +		/* Here, type is big endian as it must be sent in two transfers */
> > > > +		ad7949_adc->buffer = (u16)cpu_to_be16(ad7949_adc->cfg << 2);  
> >
> > Gah, I wasn't thinking clearly when I suggested this. Sparse warns on
> > the
> > endian conversion
> >
> > One option is to resort to ignoring the fact we know it's aligned and
> > use the put_unaligned_be16() and get_unaligned_be16 calls which sparse
> > seems to be
> > happy with. Alternative would be to just have a be16 buffer after the
> > existing
> > one in the iio_priv structure. Then you will have to change the various
> > users
> > of iio_priv()->buffer to point to the new value if we are doing 8 bit
> > transfers.
> >
> > Whilst more invasive, this second option is the one I'd suggest.  
> 
> Understood, I'll go with your suggestion.
> 
> Out of curiosity, other that being more explicit, is there another
> we'd rather not use {get,put}_unaligned_be16()?

We know it is aligned (as u16) so on a big endian platform that happens
to not handle unaligned accesses we will now be doing work which wouldn't
be needed if there was a get_aligned_be16() that was more relaxed about
types than cpu_to_be16() etc.

So basically it looks odd and we will will be hiding that we are smashing
data of potentially different ordering into the same structure field.

> 
> > Note that there will be no need to add an __cacheline_aligned marking to
> > this
> > new element because it will be in a cachline that is only used for DMA
> > simply being
> > after the other buffer element which is force to start on a new
> > cacheline.  
> 
> Noted, Thanks for taking the time to explaining this.
> 
> Liam
> 
> >
> > Jonathan
> >    
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > >  	spi_message_init_with_transfers(&msg, tx, 1);
> > > >  	ret = spi_sync(ad7949_adc->spi, &msg);
> > > >  
> > > > @@ -115,14 +132,12 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> > > >  {
> > > >  	int ret;
> > > >  	int i;
> > > > -	int bits_per_word = ad7949_adc->resolution;
> > > > -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
> > > >  	struct spi_message msg;
> > > >  	struct spi_transfer tx[] = {
> > > >  		{
> > > >  			.rx_buf = &ad7949_adc->buffer,
> > > >  			.len = 2,
> > > > -			.bits_per_word = bits_per_word,
> > > > +			.bits_per_word = ad7949_adc->bits_per_word,
> > > >  		},
> > > >  	};
> > > >  
> > > > @@ -157,7 +172,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> > > >  
> > > >  	ad7949_adc->current_channel = channel;
> > > >  
> > > > -	*val = ad7949_adc->buffer & mask;
> > > > +	switch (ad7949_adc->bits_per_word) {
> > > > +	case 16:
> > > > +		*val = ad7949_adc->buffer;
> > > > +		/* Shift-out padding bits */
> > > > +		*val >>= 16 - ad7949_adc->resolution;
> > > > +		break;
> > > > +	case 14:
> > > > +		*val = ad7949_adc->buffer & GENMASK(13, 0);
> > > > +		break;
> > > > +	case 8:
> > > > +		/* Here, type is big endian as data was sent in two transfers */
> > > > +		*val = be16_to_cpu(ad7949_adc->buffer);
> > > > +		/* Shift-out padding bits */
> > > > +		*val >>= 16 - ad7949_adc->resolution;
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > >  
> > > >  	return 0;
> > > >  }
> > > > @@ -265,6 +298,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
> > > >  
> > > >  static int ad7949_spi_probe(struct spi_device *spi)
> > > >  {
> > > > +	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
> > > >  	struct device *dev = &spi->dev;
> > > >  	const struct ad7949_adc_spec *spec;
> > > >  	struct ad7949_adc_chip *ad7949_adc;
> > > > @@ -291,6 +325,18 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > > >  	indio_dev->num_channels = spec->num_channels;
> > > >  	ad7949_adc->resolution = spec->resolution;
> > > >  
> > > > +	/* Set SPI bits per word */
> > > > +	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
> > > > +		ad7949_adc->bits_per_word = ad7949_adc->resolution;
> > > > +	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
> > > > +		ad7949_adc->bits_per_word = 16;
> > > > +	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
> > > > +		ad7949_adc->bits_per_word = 8;
> > > > +	} else {
> > > > +		dev_err(dev, "unable to find common BPW with spi controller\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > >  	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> > > >  	if (IS_ERR(ad7949_adc->vref)) {
> > > >  		dev_err(dev, "fail to request regulator\n");    
> > >   
> 

