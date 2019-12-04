Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E6A1129D9
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLDLHD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 4 Dec 2019 06:07:03 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfLDLHD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Dec 2019 06:07:03 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1ED1A4C7D6D6837F8347;
        Wed,  4 Dec 2019 11:07:01 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 4 Dec 2019 11:07:00 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Dec 2019
 11:07:00 +0000
Date:   Wed, 4 Dec 2019 11:06:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>
CC:     Andrea Merello <andrea.merello@gmail.com>, <jic23@kernel.org>,
        "Alexandru Ardelean" <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Stefan Popa" <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [v2] iio: ad7949: fix channels mixups
Message-ID: <20191204110659.00004987@Huawei.com>
In-Reply-To: <c3f3367f-cc78-23f3-ec89-439b9bc8f433@essensium.com>
References: <9ea595fc-d53b-3cd4-a511-db2b09726606@essensium.com>
        <20191202141336.4507-1-andrea.merello@gmail.com>
        <c3f3367f-cc78-23f3-ec89-439b9bc8f433@essensium.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Dec 2019 16:36:19 +0100
Couret Charles-Antoine <charles-antoine.couret@essensium.com> wrote:

> Le 02/12/2019 à 15:13, Andrea Merello a écrit :
> >   drivers/iio/adc/ad7949.c | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 5c2b3446fa4a..2c6f60edb7ce 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -89,6 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >   				   unsigned int channel)
> >   {
> >   	int ret;
> > +	int i;
> >   	int bits_per_word = ad7949_adc->resolution;
> >   	int mask = GENMASK(ad7949_adc->resolution, 0);
> >   	struct spi_message msg;
> > @@ -100,12 +101,23 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >   		},
> >   	};
> >   
> > -	ret = ad7949_spi_write_cfg(ad7949_adc,
> > -				   channel << AD7949_OFFSET_CHANNEL_SEL,
> > -				   AD7949_MASK_CHANNEL_SEL);
> > -	if (ret)
> > -		return ret;
> > +	/*
> > +	 * 1: write CFG for sample N and read old data (sample N-2)
> > +	 * 2: if CFG was not changed since sample N-1 then we'll get good data
> > +	 *    at the next xfer, so we bail out now, otherwise we write something
> > +	 *    and we read garbage (sample N-1 configuration).
> > +	 */
> > +	for (i = 0; i < 2; i++) {
> > +		ret = ad7949_spi_write_cfg(ad7949_adc,
> > +					   channel << AD7949_OFFSET_CHANNEL_SEL,
> > +					   AD7949_MASK_CHANNEL_SEL);
> > +		if (ret)
> > +			return ret;
> > +		if (channel == ad7949_adc->current_channel)
> > +			break;
> > +	}
> >   
> > +	/* 3: write something and read actual data */
> >   	ad7949_adc->buffer = 0;
> >   	spi_message_init_with_transfers(&msg, tx, 1);
> >   	ret = spi_sync(ad7949_adc->spi, &msg);  
> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Hi Charles-Antoine,

Why a signed-off-by as opposed to a reviewed-by or similar?

signed-off-by brings some very specific legal implications around Developer
Certificate of Origin, so is normally just the author plus people involved in
the path to upstream (maintainers).

> 
> Regards,
> Charles-Antoine Couret


