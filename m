Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE84A3C5AAE
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 13:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhGLKPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 06:15:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3377 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhGLKP3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 06:15:29 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNfN93h2Qz6BBGZ;
        Mon, 12 Jul 2021 17:58:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:12:37 +0200
Received: from localhost (10.47.25.8) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 12 Jul
 2021 11:12:37 +0100
Date:   Mon, 12 Jul 2021 11:12:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
Message-ID: <20210712111219.00006d51@Huawei.com>
In-Reply-To: <CCQKRT3BAWMZ.808X3PQPIH4R@shaak>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
        <20210709155856.1732245-3-liambeguin@gmail.com>
        <20210710173940.60764398@jic23-huawei>
        <CCQKRT3BAWMZ.808X3PQPIH4R@shaak>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.8]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Jul 2021 15:58:27 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> On Sat Jul 10, 2021 at 12:39 PM EDT, Jonathan Cameron wrote:
> > On Fri, 9 Jul 2021 11:58:54 -0400
> > Liam Beguin <liambeguin@gmail.com> wrote:
> >  
> > > From: Liam Beguin <lvb@xiphos.com>
> > > 
> > > This driver supports devices with 14-bit and 16-bit sample sizes.
> > > This is not always handled properly by spi controllers and can fail. To
> > > work around this limitation, pad samples to 16-bit and split the sample
> > > into two 8-bit messages in the event that only 8-bit messages are
> > > supported by the controller.  
> >
> > Hmm. I assumed spi controllers would all support 16 bits, but a quick
> > grep confirms otherwise... ah well!
> >  
> > > 
> > > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > > ---
> > >  drivers/iio/adc/ad7949.c | 69 ++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 60 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > > index 93aacf4f680b..770112ac820f 100644
> > > --- a/drivers/iio/adc/ad7949.c
> > > +++ b/drivers/iio/adc/ad7949.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/spi/spi.h>
> > > +#include <linux/bitfield.h>
> > >  
> > >  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
> > >  #define AD7949_CFG_REG_SIZE_BITS	14
> > > @@ -57,6 +58,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
> > >   * @indio_dev: reference to iio structure
> > >   * @spi: reference to spi structure
> > >   * @resolution: resolution of the chip
> > > + * @bits_per_word: number of bits per SPI word
> > >   * @cfg: copy of the configuration register
> > >   * @current_channel: current channel in use
> > >   * @buffer: buffer to send / receive data to / from device
> > > @@ -67,28 +69,60 @@ struct ad7949_adc_chip {
> > >  	struct iio_dev *indio_dev;
> > >  	struct spi_device *spi;
> > >  	u8 resolution;
> > > +	u8 bits_per_word;
> > >  	u16 cfg;
> > >  	unsigned int current_channel;
> > > -	u16 buffer ____cacheline_aligned;
> > > +	union {
> > > +		__be16 buffer;
> > > +		u8 buf8[2];
> > > +	} ____cacheline_aligned;  
> 
> Hi Jonathan,
> 
> >
> > This union made me a little nervous given issues with them under c spec,
> > but
> > seems that you only use buffer or buf8, there is no mixing. I think I'd
> > rather you didn't have the union though as it makes it look like there
> > might be.  
> 
> I don't particularly like unions either..
> If I'm not mistaken, the only place where the union is useful is
> in the spi_transfer struct definitions. I'll use a local buf8 there
> instead.

Make sure it's either DMA safe, or that we can be sure it doesn't need
to be for some reason.

> 
> >
> > Given we are doing cacheline spacing anyway for dma safety it take no
> > more
> > real space to just have
> >
> > __be16 buffer ____cacheline_aligned;
> > buf8[2];
> >
> >
> >  
> > >  };
> > >  
> > > +static void ad7949_set_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
> > > +{
> > > +	u32 adc_mask = SPI_BPW_MASK(ad7949_adc->resolution);
> > > +	u32 bpw = adc_mask & ad7949_adc->spi->controller->bits_per_word_mask;
> > > +
> > > +	if (bpw == adc_mask)  
> >
> > if (bpw) is sufficient I think.
> >  
> > > +		ad7949_adc->bits_per_word = ad7949_adc->resolution;
> > > +	else if (bpw == SPI_BPW_MASK(16))  
> >
> > I'm missing something here... If the resolution is 14, but the SPI
> > controller
> > supports 8 and 16 I'd expect us to hit here . adc_mask will not have the
> > 16bit
> > bit set though so bpw == 0..
> >
> > else if (ad7949_adc->spi->controller_bits_per_word_mask &
> > SPI_BPW_MASK(16))
> >
> > should do the right thing.
> >  
> > > +		ad7949_adc->bits_per_word = 16;
> > > +	else
> > > +		ad7949_adc->bits_per_word = 8;  
> >
> > I'd like a comment here on why this is the right default. Took me a
> > while
> > to think through it.
> >  
> 
> I'll rework this function based on your comments and fail early on
> unsupported cases.
> 
> > > +}
> > > +
> > >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> > >  				u16 mask)
> > >  {
> > >  	int ret;
> > > -	int bits_per_word = ad7949_adc->resolution;
> > > -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> > >  	struct spi_message msg;
> > >  	struct spi_transfer tx[] = {
> > >  		{
> > >  			.tx_buf = &ad7949_adc->buffer,
> > >  			.len = 2,
> > > -			.bits_per_word = bits_per_word,
> > > +			.bits_per_word = ad7949_adc->bits_per_word,
> > >  		},
> > >  	};
> > >  
> > > +	ad7949_adc->buffer = 0;
> > >  	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> > > -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
> > > +
> > > +	switch (ad7949_adc->bits_per_word) {
> > > +	case 16:
> > > +		ad7949_adc->buffer = ad7949_adc->cfg << 2;
> > > +		break;
> > > +	case 14:
> > > +		ad7949_adc->buffer = ad7949_adc->cfg;
> > > +		break;
> > > +	case 8:
> > > +	default:  
> >
> > Default here should be an error. Imagine a 12 bit device is added. Then
> > the above set_bits_per_word() might return either 12 or 8. If it returns
> > 12 then this is not the right thing to do. I'd argue we want to know
> > about
> > that rather than papering over it. Possibly we want to not let anything
> > other
> > than 14 bits through in set_bits_per_word() so we print an error
> > early...
> >  
> 
> Sorry about that, I added that default case maybe a little too quickly.
> I'll fix that.
> 
> > > +		/* Pack 14-bit value into 2 bytes, MSB first */
> > > +		ad7949_adc->buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
> > > +		ad7949_adc->buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
> > > +		ad7949_adc->buf8[1] = ad7949_adc->buf8[1] << 2;
> > > +		break;
> > > +	}
> > > +
> > >  	spi_message_init_with_transfers(&msg, tx, 1);
> > >  	ret = spi_sync(ad7949_adc->spi, &msg);
> > >  
> > > @@ -105,14 +139,12 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> > >  {
> > >  	int ret;
> > >  	int i;
> > > -	int bits_per_word = ad7949_adc->resolution;
> > > -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
> > >  	struct spi_message msg;
> > >  	struct spi_transfer tx[] = {
> > >  		{
> > >  			.rx_buf = &ad7949_adc->buffer,
> > >  			.len = 2,
> > > -			.bits_per_word = bits_per_word,
> > > +			.bits_per_word = ad7949_adc->bits_per_word,
> > >  		},
> > >  	};
> > >  
> > > @@ -147,7 +179,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> > >  
> > >  	ad7949_adc->current_channel = channel;
> > >  
> > > -	*val = ad7949_adc->buffer & mask;
> > > +	switch (ad7949_adc->bits_per_word) {
> > > +	case 16:
> > > +		*val = ad7949_adc->buffer;  
> >
> > buffer is __be16 and *val is an int so this isn't valid.
> >
> > Now curious bit is I'm assuming original code worked... Given big endian
> > platforms are rare, that makes me suspect something odd is going on.
> >    
> 
> Hum... that's probably my fault. I changed the type of buffer from u16
> to _be16.
> I'll add calls to be16_to_cpu() around this and the 14 bit case.

On most platforms that's going to reverse the bytes. So if this
worked before without it, then it will now be broken.
That makes me wonder if it was either broken previously, or the
only user was a big endian host, or more likely the byte reverse
isn't needed, meaning we have a wrong assumption here somewhere.

I might be missing another option though!

Jonathan

> 
> > > +		/* Shift-out padding bits */
> > > +		if (ad7949_adc->resolution == 14)
> > > +			*val = *val >> 2;  
> >
> > *val >>= 16 - ad7949_adc->resolution;
> >
> > No one likes conditionals if we don't need them!  
> 
> Will do.
> 
> >
> >  
> > > +		break;
> > > +	case 14:
> > > +		*val = ad7949_adc->buffer & GENMASK(13, 0);
> > > +		break;
> > > +	case 8:
> > > +	default:
> > > +		/* Convert byte array to u16, MSB first */
> > > +		*val = (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];  
> >
> > Use unaligned_get_be16()
> >  
> > > +		/* Shift-out padding bits */
> > > +		if (ad7949_adc->resolution == 14)
> > > +			*val = *val >> 2;  
> >
> > As above make this unconditional.
> >  
> 
> Thanks,
> Liam
> 
> > > +		break;
> > > +	}
> > >  
> > >  	return 0;
> > >  }
> > > @@ -280,6 +330,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > >  	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
> > >  	indio_dev->num_channels = spec->num_channels;
> > >  	ad7949_adc->resolution = spec->resolution;
> > > +	ad7949_set_bits_per_word(ad7949_adc);
> > >  
> > >  	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> > >  	if (IS_ERR(ad7949_adc->vref)) {  
> 

