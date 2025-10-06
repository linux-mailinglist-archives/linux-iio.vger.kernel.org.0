Return-Path: <linux-iio+bounces-24763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F0BBCF8D
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 03:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1305F4E75C3
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2D1A9F8D;
	Mon,  6 Oct 2025 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgaBAixA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8E19E99F
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759715518; cv=none; b=s8DLU6fedZS89Af4eOqFv8dAauksd5ZFJnXZDcLYHHjXniH/ya9R7tNf6hh31+Uhl5hHH4M4DqHPXuKGLFI9bz4Zz56Y3hU0z/KPZ4ylh7iSmReuECxP5kDqA4AspGYzZCFK2I3XmsE158HnHe/zfWtEVpW6ZXusjxmZP0bw/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759715518; c=relaxed/simple;
	bh=r3J55PeaRG814QCbKVDeY9KzzV4nhvki7yHQo7Jt1Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQbhTIN/OGdXTpU5XULuW7eyjk2/tC3+m4CxkXLZq+M5AJ7PWUQtxVWfBp5bXww0BsqPZtiUjh4l4D5qLtTp0pSTZCvLM1JkKj5eoCKpDy4ILFhO3AWEcOWhRgxhUwtHXYuw/HQAzgYSurZf4nqAX4Hd4i1RMvYvk9KxbKHSlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgaBAixA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-279e2554c8fso40830945ad.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Oct 2025 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759715516; x=1760320316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=goKbEbgE/E18+yRZTN33NxanKAJ4gGWuYT8V2iu/uiY=;
        b=UgaBAixA8KnI91s1WIgbhjtJ8m23naDtbHliCfUSNlU4ZJAIRXhR1RPobyzpgrrjM1
         VzQxRVj3e/+jfLnOFAbS/j9865Id++c9NmUhtAIlqsD5fqZBtPWWvFdKCcekWLbw3+km
         A2OMbnx4y4dsNFGBP8OoUYWUfezJK32O7JBFPK7NrUUXPYGtFuJGoxpYSqWb1g3/VhvJ
         Lp+yZWzAj7U3GSLCugZVEA94ezoNsYso05EWLBVmBPgKfxY1brFupC3gTPFVsnGk0hiQ
         PtDfZc+91IsrvzDBO4ls1STIENe5M4Wy6+Ex3nYlz6wR0J/zGMd3sBqjAvjnLrNxzCb8
         nksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759715516; x=1760320316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goKbEbgE/E18+yRZTN33NxanKAJ4gGWuYT8V2iu/uiY=;
        b=irOUDgkCuWWh3pe+jM3o+2OciC7PTA+F5gWtA4imGYiqd6ZLEwIJjQx3QfkUxIlftT
         eXbm7pGaD7KBtIyB5vT3N5unU1UbEA+g6t5CCjbSnwXNIp6jhMku5MijYt2riXDseQ3U
         EpOYi1QLYR2xV7DdZIRpnTf/J2EEBCOD8RsgIraHUbLhWb5OLQSidnASEipK5swGI9Xs
         dkmtlhutddNZQad0Kf4auc/Qv1/2lhCBHfDr+0iUDWC76uR8NJ+tP1s+x8g3mjW6RcwI
         hy3LoS6D5E2ob52V6jWLS4k3jl2o29rj4z9wkGcR+UwOs8mv994hcyJbmKtv4hmZ5EYW
         ekzg==
X-Gm-Message-State: AOJu0YzQ0nYNYp2aiaOKGZRu3ZMPTcdkfZPUqcayyBvpL32TgZkjtVzQ
	OKppRsoLbz87TxKChAX/z3ebNjDWc19NjYp3w3ghne1UoyqY3Y0rpYdF
X-Gm-Gg: ASbGncsJqNz/6QdhDHSQGabdVMSjeqF3oE7JiQiHKkcM4qK3g6HJshUjO9RwZzvwciv
	2juIJ3GDu99kJV4qKU7BzX4H0PPiTlOaYQatMmuY0Fn+c0tihOyixuuCZGEBwBnfFCV1BmRHn73
	VnML66BGaGDeq380JN6DHjjFP0/uZhMg+2xTmKrIEv8IwFNamjrCnDBZlKeJXqmoralkLURs66s
	WS5703BRKW/nJvvDZ6QbK+eB2tXvnE7PdykH5TeTWueTsdY7rhBVue+yPEFombkICBJ1tFLDdZN
	skLKLRJzmEKD8ICMqZYj3y4NwMOUkTx6W2e68TztDSEh/5+4d6aMYQwcxaJI+UI0P7qBUDfKHEf
	mbY2BiupNQdcXF78Q2dYNqcsjgHX29j7mLG2RP/vQzxhIzDfixslfpzCSaB8VYGvL+Q==
X-Google-Smtp-Source: AGHT+IGLOExElo8lCBc2H4M2ejAP9tWofhBut9eIDjWbU1ZaBGpjpGOOs07iERHmFfP35KAK2I5czA==
X-Received: by 2002:a17:903:19ef:b0:25c:e2c:6653 with SMTP id d9443c01a7336-28e9a64853cmr110646785ad.48.1759715516026;
        Sun, 05 Oct 2025 18:51:56 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3399bf9fee1sm7796628a91.2.2025.10.05.18.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 18:51:54 -0700 (PDT)
Date: Sun, 5 Oct 2025 22:52:51 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v12 2/3] iio: adc: max14001: New driver
Message-ID: <aOMg87Mds-Ww3IT4@debian-BULLSEYE-live-builder-AMD64>
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
 <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>

Hi Marilene,

...
> I have one remaining question related to the max_register attribute of the
> regmap. The register regions that can be accessed are 0x00–0x0c and
> 0x13–0x1a. As suggested, I used max_register to set the upper limit of the
> register region that can be accessed (0x1a). Beyond this address, there is
> a reserved region that should not be used (0x1b–0x1f). However, there is 
> also a reserved region that should not be used between addresses 0x0d–0x12.
> Should I use something to mark this region in the regmap?
> 

Yes, use rd_table and wr_table as suggested by David.
If you haven't implemented it already, I think the reg ranges would look like

static const struct regmap_range max14001_regmap_rd_range[] = {
	regmap_reg_range(MAX14001_REG_ADC, MAX14001_REG_ENBL),
	regmap_reg_range(MAX14001_REG_WEN, MAX14001_REG_WEN),
	regmap_reg_range(MAX14001_REG_VERIFICATION(MAX14001_REG_FLTEN),
			 MAX14001_REG_VERIFICATION(MAX14001_REG_ENBL)),
};

static const struct regmap_range max14001_regmap_wr_range[] = {
	regmap_reg_range(MAX14001_REG_FLTEN, MAX14001_REG_WEN),
	regmap_reg_range(MAX14001_REG_VERIFICATION(MAX14001_REG_FLTEN),
			 MAX14001_REG_VERIFICATION(MAX14001_REG_ENBL)),
};

see drivers/iio/adc/ad4030.c for an example.

> 
> I tested it on the Raspberry Pi modified kernel version rpi-6.12 with
> Raspberry Pi 5 hardware, using the MAX14001PMB evaluation board, and it
> seems to work fine.
> 

I finally managed to give this driver a try.

max14001_disable_mv_fault() does make the memory fault flag (MV) clear out.
Both register read and register write work fine through debugfs.
Though, even after I plugged a bench top power supply to the ADC inputs, I read
0x80 from the FLAGS (0x02) register. That flag indicates "input voltage detected
without input current" so maybe I missed or miss-connected some inputs.

The _scale looks good. Eval board data sheet says each ADC input is DC offset by
VREF/2 (1.25 / 2 == 0.625 Volts), and I do get readings that float between
0.623779 and 0.629883 volts. We know that the PMB board also significantly
attenuates the signal. At 10V input, I start getting data that scales to
0.631104 volts (_raw == 517). And it looks the same if I go to 20V. Interesting
thing is, the readings peak only after I disable the power supply output. One of
the eval board user guides [1] has an example connection diagram to an AC
voltage/current circuit, but no example connecting to a DC circuit. So, maybe
I'm just being silly trying to test this with a DC supply. Though, despite the
outcome of my rudimentary tests [2], the driver provides a proper _scale and
grabs sample data from the correct register.

[1]: https://www.analog.com/media/en/reference-design-documentation/design-notes/ds25-isolated-adc-with-integrated-dc-dc-converter-simplifies-field-side-circuitry.pdf
[2]: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/max14001

Thus,
Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>


About the data averaging, my suggestion is to remove _AVERAGE_RAW stuff from the
initial driver support patch and (optionally) implement it on a follow up patch.
It will make it easier, faster, and safer to get this driver merged without the
averaging thing. max14001 averaging feature is uncommon. Even though we have
in_Y_mean_raw documented in IIO ABI, adding more interfaces is a commitment.
Once it's there and people start using it, we cannot change. 'We don't break
user space'. So, the Linux kernel community may want to think about it
thoroughly before committing to new ABI. The max14001 driver don't need to be on
hold until a decision about max14001 averaging interface is made.

> +static int max14001_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max14001_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
Drop/remove IIO_CHAN_INFO_AVERAGE_RAW from the initial driver patch.
Optionally, add IIO_CHAN_INFO_AVERAGE_RAW on a follow up patch.

> +		ret = regmap_read(st->regmap, MAX14001_REG_FADC, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
...
> +static const struct iio_chan_spec max14001_channel[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_AVERAGE_RAW) |
Same reasoning here. Can be introduced in a separate patch.

> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};

With the averaging related stuff dropped from the initial driver support,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

btw, well done.

