Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470153DCCCA
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 18:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhHAQ6p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 12:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhHAQ6p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Aug 2021 12:58:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B3960EB5;
        Sun,  1 Aug 2021 16:58:31 +0000 (UTC)
Date:   Sun, 1 Aug 2021 18:01:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH 2/2] iio: chemical: Add driver support for sgp40
Message-ID: <20210801180111.28a1c4d1@jic23-huawei>
In-Reply-To: <42e31edc-445c-06ac-dd3a-80db1b439996@roeck-us.net>
References: <20210727163517.GA3468@arbad>
        <20210731173928.08d6812f@jic23-huawei>
        <42e31edc-445c-06ac-dd3a-80db1b439996@roeck-us.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Jul 2021 11:06:25 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 7/31/21 9:39 AM, Jonathan Cameron wrote:
> > On Tue, 27 Jul 2021 18:35:19 +0200
> > Andreas Klinger <ak@it-klinger.de> wrote:
> >   
> >> sgp40 is a gas sensor used for measuring the air quality.
> >>
> >> This driver is reading the raw resistance value which can be passed to
> >> a userspace algorithm for further calculation.
> >>
> >> The raw value is also used to calculate an estimated absolute voc index
> >> in the range from 0 to 500. For this purpose the raw_mean value of the
> >> resistance for which the index value is 250 might be set up as a
> >> calibration step.
> >>
> >> Compensation of relative humidity and temperature is supported and can
> >> be used by writing to device attributes of the driver.
> >>
> >> There is a predecesor sensor type (sgp30) already existing. This driver
> >> module was not extended because the new sensor is quite different in its
> >> i2c telegrams.
> >>
> >> Signed-off-by: Andreas Klinger <ak@it-klinger.de>  
> > 
> > Hi Andreas,
> > 
> > Non standard ABI in here, so we are missing documentation in Documentation/ABI/testing/sysfs-bus-iio-*
> > 
> > Otherwise a few suggestions inline.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> >> ---  
> [ ... ]
> 
> >> +static int sgp40_read_raw(struct iio_dev *indio_dev,
> >> +			struct iio_chan_spec const *chan, int *val,
> >> +			int *val2, long mask)
> >> +{
> >> +	struct sgp40_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +	u16 raw;
> >> +	int voc;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		mutex_lock(&data->lock);
> >> +		ret = sgp40_measure_raw(data, &raw);
> >> +		if (ret) {
> >> +			mutex_unlock(&data->lock);
> >> +			return ret;
> >> +		}
> >> +		*val = raw;
> >> +		ret = IIO_VAL_INT;
> >> +		mutex_unlock(&data->lock);
> >> +		break;
> >> +	case IIO_CHAN_INFO_PROCESSED:
> >> +		mutex_lock(&data->lock);
> >> +		ret = sgp40_measure_raw(data, &raw);
> >> +		if (ret) {
> >> +			mutex_unlock(&data->lock);
> >> +			return ret;
> >> +		}
> >> +		ret = sgp40_calc_voc(data, raw, &voc);
> >> +		if (ret) {
> >> +			mutex_unlock(&data->lock);
> >> +			return ret;
> >> +		}
> >> +		*val = voc;
> >> +		ret = IIO_VAL_INT;
> >> +		mutex_unlock(&data->lock);  
> > 
> > You are holding the lock longer than needed - it would be good
> > to reduce this, hopefully removing the need for unlocking separately
> > in each of the error paths.
> >   
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return ret;  
> > 
> > Drop this as you can't get here.
> >   
> 
> Are you sure ? I see several "break;" above.

Doh! In that case, return directly where it has break above so we don't
need to go see if anything else happens in those paths.

> 
> Guenter

