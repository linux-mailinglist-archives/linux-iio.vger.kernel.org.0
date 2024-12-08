Return-Path: <linux-iio+bounces-13242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC689E8723
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C923F1645E7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE35188915;
	Sun,  8 Dec 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CXmPmJFZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF415624B;
	Sun,  8 Dec 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733680053; cv=none; b=egnDwEP9Nc/xhJtWSlJeZgRrZRKnEYJwmeh851JWbLi0IPmNB1SpQpWtqKDO3KnKhFK2stFDd1tzre+okZBuFlnByPAGPCHRrSkN1SUkrcNC6XPBulGGDFpqZUm7rrQVGiXX3WJgM0SLXkuw/oMuFUItLdsCNUj4c6Sqiib+0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733680053; c=relaxed/simple;
	bh=6a1IXSz697v3EaIGky9oEvnnimAUv0VbduUKs38Ly+U=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=Alq7hB9lI0YnrDR/vYaJcj0RaDELr6Z5Fbr5oLH9LsQ9g1lITEEXS80V1OHuZ8TElWMKPVo9cBJ2r3JPOzQc9HnhwA48VdOjvdmjlPUeoBOEz17Xa5pXoWwpjmE5bzSdJ/+MT2yb+lSOC9Vw7FvEDkEccv2mLsX1/2oUCo27NhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CXmPmJFZ; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id KLNJtQRwaKnkaKLNJtVg1U; Sun, 08 Dec 2024 18:47:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733680046;
	bh=ebd+Tp1v6fRh+FBN9RhAloqELrQTXUQiB8ZFG5D3eOE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=CXmPmJFZ+FytpmTgOBNgPLzgSVXjOj3xjc3FbZ5tlOD4rw5CBapYfqgEStegp1/F1
	 qiyOCIjK9wWKq8sHSQbBhB8cnZsf3m2KWgGYevrHkRlRjRE73aPn1zM2VzRGUe7BAn
	 ZYZNxGsCXiWCQveLxxT2wljtqCfdWwhgLtpCPs61EYH8J2Dsd9DOIMnd4/wKOJmXbF
	 ynT4Df22slbFxH3XOKxPInqqmRomQeUof9UQQFrTyh4luowyBN10Xub2/Vymhr1m0E
	 Qotob23zGdNh5K4mGn5N1yL04Q0VWYhHe1/qQ0/KhFu+UC6PDFRUU0LyBtoGVlL28/
	 YuwVzR5XKYNgg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Dec 2024 18:47:26 +0100
X-ME-IP: 90.11.132.44
Message-ID: <b5b43427-d0d7-43d5-bf8a-02a966ac25d3@wanadoo.fr>
Date: Sun, 8 Dec 2024 18:47:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 javier.carrasco.cruz@gmail.com, andriy.shevchenko@linux.intel.com,
 marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
 mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com,
 alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com,
 ramona.nechita@analog.com, mike.looijmans@topic.nl,
 chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com,
 openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eason Yang <j2anfernee@gmail.com>
In-Reply-To: <20241203091540.3695650-3-j2anfernee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/12/2024 à 10:15, Eason Yang a écrit :
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and the all threshold values could be set for
> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events support.
> 
> Signed-off-by: Eason Yang <j2anfernee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

...

> +static const u8 REG_VIN_HIGH_LIMIT_LSB[VIN_MAX] = {
> +	0x40, 0x42, 0x44, 0x46, 0x48, 0x4A, 0x4C, 0x4E,
> +	0x50, 0x52, 0x54, 0x56,
> +};
> +static const u8 REG_VIN_LOW_LIMIT_LSB[VIN_MAX] = {
> +	0x41, 0x43, 0x45, 0x47, 0x49, 0x4B, 0x4D, 0x4F,
> +	0x51, 0x53, 0x55, 0x57,
> +};
> +static u8 nct720x_chan_to_index[] = {

const as well here?

> +	0 /* Not used */, 0, 1, 2, 3, 4, 5, 6,
> +	7, 8, 9, 10, 11,
> +};

...

> +static int nct720x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	int index = nct720x_chan_to_index[chan->address];
> +	u16 volt;
> +	unsigned int value;
> +	int err;
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&chip->access_lock);

The IIO_CHAN_INFO_SCALE case does not seem to need the lock. Would it 
make sense to move it only in the IIO_CHAN_INFO_RAW case?

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = regmap_read(chip->regmap16, REG_VIN[index], &value);
> +		if (err < 0)
> +			return err;
> +		volt = (u16)value;
> +		*val = volt >> 3;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* From the datasheet, we have to multiply by 0.0004995 */
> +		*val = 0;
> +		*val2 = 499500;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int nct720x_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	int err = 0;

Harmless but useless initialisation.

> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +	int index = nct720x_chan_to_index[chan->address];
> +	unsigned int mask;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;

...

> +static int nct720x_init_chip(struct nct720x_chip_info *chip)
> +{
> +	u8 data[2];
> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, REG_CONFIGURATION, BIT_CONFIGURATION_RESET);
> +	if (err) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CONFIGURATION\n");
> +		return err;
> +	}
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then
> +	 * the Power Up bit will be set to 1. If not, wait for it.
> +	 */
> +	mdelay(25);
> +	err  = regmap_read(chip->regmap, REG_BUSY_STATUS, &value);

double space after err.

> +	if (err < 0)
> +		return err;
> +	if (!(value & BIT_PWR_UP))
> +		return err;
> +
> +	/* Enable Channel */
> +	err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_1, REG_CHANNEL_ENABLE_1_MASK);
> +	if (err) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_ENABLE_1\n");
> +		return err;
> +	}
> +
> +	if (chip->vin_max == 12) {
> +		err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_2, REG_CHANNEL_ENABLE_2_MASK);
> +		if (err) {
> +			dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_ENABLE_2\n");
> +			return err;
> +		}
> +	}
> +
> +	guard(mutex)(&chip->access_lock);
> +	err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_1, &value);

double space after err.

> +	if (err < 0)
> +		return err;
> +	data[0] = (u8)value;
> +
> +	err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value);

double space after err.

> +	if (err < 0)
> +		return err;
> +	data[1] = (u8)value;
> +
> +	value = get_unaligned_le16(data);
> +	chip->vin_mask = value;
> +
> +	/* Start monitoring if needed */

...

CJ

