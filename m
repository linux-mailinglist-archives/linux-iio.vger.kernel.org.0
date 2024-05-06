Return-Path: <linux-iio+bounces-4836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA398BCE4C
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1649528456F
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD2335B5;
	Mon,  6 May 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/vraFal"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8B3B782;
	Mon,  6 May 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999612; cv=none; b=epF4Jcyd0RYLNbLg3+bBZtK5sAssA42Y+rAtPjeE1wQertEOwgYFDZlTBqAa34ElMTNc6ZfVZhwBYu7DReL8Y5QCV8e8mnrbeTNbDRla8hSAetLnscERdvkDrOmIK2+031TbmN4HcMIDZa2o24k54ABAHik2ukV9bWKXwZOL5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999612; c=relaxed/simple;
	bh=2+5X5YdRXHQN5cM9cGGaOkH0YnShbzy7xMh8tModicA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaMS3IUCWPzuVbL8psjn35RQAhl8O7r+/TzRnpJZp5WLlKOWnUc2cavLVxVaSoeRWfmNGTa1NhnHNkeuEJyMrIdTO2sSQpCE8LdE7rvvtAocpFSBbZrdEzPGmlVDNyacdRMJy5wO9B9qJ596piZOGdrxPC3EfQ+v0wC74GQDMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/vraFal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7571C116B1;
	Mon,  6 May 2024 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714999611;
	bh=2+5X5YdRXHQN5cM9cGGaOkH0YnShbzy7xMh8tModicA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/vraFalZgRorHN4T3WKSiTwAjT3MHmBX43JRsWeRewY/K3Q4w0tdB28QlL5GwY38
	 SzF73LZ1Al5UT6un3QeRu1Pn1YSCtzg8j7pEwibDe98pSlWd7p3Zz/SrKtGyg9gG8Q
	 FrZMLjXCLIgUTtSj4gyHknid6RzGTNKBeHDM1fo7neYiqTWaxsv3S8xe3PzWP5dF5+
	 GqRhbCg3MrZShoAvCMpDe6ovl/TRxXP8rUQi2alBrdiMGRCqmF+u8P321mq8tayKEu
	 /fc3++7c5Wzn+8y6wY74LalbPWgkpfRBnGfFoehxY28VLYKmZky26lsNZeyU7I1mNE
	 89ZzF+H8JdTQg==
Date: Mon, 6 May 2024 13:46:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 06/10] iio: pressure: bmp280: Refactorize reading
 functions
Message-ID: <20240506134638.297cfbfd@jic23-huawei>
In-Reply-To: <20240505234751.GB17986@vamoiridPC>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-7-vassilisamir@gmail.com>
	<20240505202106.1c780044@jic23-huawei>
	<20240505234751.GB17986@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 01:47:51 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, May 05, 2024 at 08:21:06PM +0100, Jonathan Cameron wrote:
> > On Mon, 29 Apr 2024 21:00:42 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > For BMP18x, BMP28x, BME280, BMP38x the reading of the pressure
> > > value requires an update of the t_fine variable which happens
> > > through reading the temperature value.
> > > 
> > > So all the bmpxxx_read_press() functions of the above sensors
> > > are internally calling the equivalent bmpxxx_read_temp() function
> > > in order to update the t_fine value. By just looking at the code
> > > this functionality is a bit hidden and is not easy to understand
> > > why those channels are not independent.
> > > 
> > > This commit tries to clear these things a bit by splitting the
> > > bmpxxx_{read/compensate}_{temp/press/humid}() to the following:
> > > 
> > > i. bmpxxx_read_{temp/press/humid}_adc(): read the raw value from
> > > the sensor.
> > > 
> > > ii. bmpxx_calc_t_fine(): calculate the t_fine variable.
> > > 
> > > iii. bmpxxx_get_t_fine(): get the t_fine variable.
> > > 
> > > iv. bmpxxx_compensate_{temp/press/humid}(): compensate the adc
> > > values and return the calculated value.
> > > 
> > > v. bmpxxx_read_{temp/press/humid}(): combine calls of the
> > > aforementioned functions to return the requested value.
> > > 
> > > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > In general looks good, but a few details to consider inline.
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/pressure/bmp280-core.c | 351 ++++++++++++++++++-----------
> > >  drivers/iio/pressure/bmp280.h      |   6 -
> > >  2 files changed, 221 insertions(+), 136 deletions(-)
> > > 
> > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > > index 8290028824e9..5ebce38e99f6 100644
> > > --- a/drivers/iio/pressure/bmp280-core.c
> > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > @@ -288,13 +288,33 @@ static int bme280_read_calib(struct bmp280_data *data)
> > >   *
> > >   * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
> > >   */
> > > +static int bme280_read_humid_adc(struct bmp280_data *data, s32 *adc_humidity)  
> > 
> > It's an u16, so why use an s32?   I can see using a signed value avoids a cast later,
> > but it makes this more confusing to read, so I'd push that cast up to the user.
> >   
> 
> Bosch in general has messed up a bit with the signs on their raw values on all
> of those sensors that we use in this driver. I totally agree with you, that this
> value does not make any sense to be anything else apart from u16 but in the
> datasheet [1] in pages 25-26 you can clearly see that they use an s32 for this
> value...
> 
> [1]: https://www.mouser.com/datasheet/2/783/BST-BME280-DS002-1509607.pdf
I would be tempted to ignore that and use the more appropriate size, but be
careful that any necessary casts are in place when you use the value.

> 
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> > > +			       &data->be16, sizeof(data->be16));
> > > +	if (ret < 0) {
> > > +		dev_err(data->dev, "failed to read humidity\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	*adc_humidity = be16_to_cpu(data->be16);  
> > 
> > Trivial, but on error return we normally aim for side effect free.
> > To do that here use an internal variable first.  
> 
> I am sorry, but in this part, I cannot fully understand what you mean
> by side effect free. I can understand the issue of storing a u16 to an
> s32 might make accidentally the sign to matter but how is this thing
> that you proposed no side effect free? You also made this comment
> in various other places in this patch (because the same principle
> with the SKIPPED is used) and in the other places the values are
> 20-bit and 24-bit long which confuses me a bit more on what you mean
> exactly.
If you get an error, e.g. if (*adc_humidty == BMP280_HUMIDITY_SKIPPED) then you 
should not set *adc_humidity.  Setting it is the side effect. Normal aim
is that a function that returns an error should ensure it leave no other
effects in data it can access.
This make reasoning about error paths much simpler because you only
have to deal with the return values.
Hence the code example I included though I make it more confusing by
commenting on the types in the middle of the code.

Key is I don't want *adc_humidity to be modified if we aren't going to
return 0.

> 
> > 	s16 value;
> > 
> > ...
> > 
> > 	value = be16_to_cpu(data->be16)
> > 
> > 	if (value == BMP280_HUMIDITY_SKIPPED) {
> > 		dev_err(data->dev, "...
> > 		return -EIO;
> > 	}
> > This is the odd bit due to using an s32 to store a u16.
> > Have to rely on that size mismatch to avoid the sign accidentally mattering.
> > Which is ugly!
> > 
> > 	*adc_humidity = value;
> > 
> > 	return 0;
> > 
> >   
> > > +	if (*adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> > > +		dev_err(data->dev, "reading humidity skipped\n");
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static u32 bme280_compensate_humidity(struct bmp280_data *data,
> > > -				      s32 adc_humidity)
> > > +				      s32 adc_humidity, s32 t_fine)
> > >  {
> > >  	struct bmp280_calib *calib = &data->calib.bmp280;
> > >  	s32 var;
> > >  
> > > -	var = ((s32)data->t_fine) - (s32)76800;
> > > +	var = ((s32)t_fine) - (s32)76800;  
> > 
> > Casting an s32 to an s32.  For the const it shouldn't matter as it'll be at least
> > 32 bits and we don't care about the sign.
> >   
> 
> In general, I kept the casting for the t_fine because it was used from before,
> but I don't see the point since it is already an s32 value. The casting in front
> of the const, I see it is used in the datasheet [1] in pages 25-26 so maybe they
> kept it for this reason. Since it will be again a 32 bit value, I don't see the
> point of casting it but I still kept it as it was, there originally.
> 
> [1]: https://www.mouser.com/datasheet/2/783/BST-BME280-DS002-1509607.pdf

As you are tidying up the code, drop the unnecessary cast. Good to mention it
in the patch description though.

> 
> > >  	var = ((((adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
> > >  		+ (s32)16384) >> 15) * (((((((var * calib->H6) >> 10)
> > >  		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
> > > @@ -313,8 +333,27 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
> > >   *
> > >   * Taken from datasheet, Section 3.11.3, "Compensation formula".
> > >   */
> > > -static s32 bmp280_compensate_temp(struct bmp280_data *data,
> > > -				  s32 adc_temp)
> > > +static int bmp280_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)  
> > 
> > As before, sign of the extra variable is confusing. It's not signed
> > as it's a raw ADC value. So I'd use a u32 for it.
> >   
> 
> Again, as I said before, Bosch has messed this up. I agree (again) with you
> that this should have been a u16 but according to the datasheet [2] in pages
> 45-46 it is an s32...
> 
> [2]: https://cdn-shop.adafruit.com/datasheets/BST-BMP280-DS001-11.pdf
> 
What they have is not incorrect, but it is relaxed in a rather lazy fashion!

...

> > > @@ -430,30 +481,21 @@ static int bmp280_read_press(struct bmp280_data *data,
> > >  
> > >  static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
> > >  {
> > > +	s32 adc_humidity, t_fine;
> > >  	u32 comp_humidity;
> > > -	s32 adc_humidity;
> > >  	int ret;
> > >  
> > > -	/* Read and compensate temperature so we get a reading of t_fine. */
> > > -	ret = bmp280_read_temp(data, NULL, NULL);
> > > +	ret = bmp280_get_t_fine(data, &t_fine);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> > > -			       &data->be16, sizeof(data->be16));
> > > -	if (ret < 0) {
> > > -		dev_err(data->dev, "failed to read humidity\n");
> > > +	ret = bme280_read_humid_adc(data, &adc_humidity);
> > > +	if (ret < 0)
> > >  		return ret;
> > > -	}
> > >  
> > > -	adc_humidity = be16_to_cpu(data->be16);
> > > -	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> > > -		/* reading was skipped */
> > > -		dev_err(data->dev, "reading humidity skipped\n");
> > > -		return -EIO;
> > > -	}
> > > -	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
> > > +	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
> > >  
> > > +	/* IIO units are in 1000 * % */
> > >  	*val = comp_humidity * 1000 / 1024;
> > >  
> > >  	return IIO_VAL_INT;
> > > @@ -930,9 +972,29 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
> > >   * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
> > >   * https://github.com/BoschSensortec/BMP3-Sensor-API.
> > >   */
> > > -static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> > > +static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)  
> > 
> > Interesting this one is unsigned.
> >   
> 
> Yes, and it is also mentioned in the datasheet [3] in page 26.
> 
> [3]: https://www.mouser.com/pdfdocs/BST-BMP388-DS001-01.pdf

I'd take the datasheet maths as 'an implementation' rather than something
we have to match.   So go for types that make sense, not what they used!

Jonathan

> 
> Cheers,
> Vasilis

