Return-Path: <linux-iio+bounces-21863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AABB0D5E7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 11:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A277A6842
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75E2DCBF5;
	Tue, 22 Jul 2025 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyYMQuTx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611D2DCBEC;
	Tue, 22 Jul 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176287; cv=none; b=f27Qmod5Z8hsvrcbki8PtX+yD+zj/Pu6mWOezJaD+YdKMlpscEYYufzRxbYq3kD/ak6+NkgHWcL4QsLOG/wBKDhxaYibECNp2PfECsvK7RzDcv+MpB9hcgMjQiAJ/wOCctSY4WJ+NdMmkoe3xg4pVxBd5DLauVCd6ufg+r/AA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176287; c=relaxed/simple;
	bh=vq9nwGCbpNJCvIIWiXBqGK2FeNXxXaFw/7Fny809tjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7K1G/FLnCew3e/yScjBVdUrke1DZQe3VQub2gECzjgZoGMYquzHy8+Je/78osegldvTOKff9qJujBZzldVMAf2gNvIiMVmSetinj6I6cK5nLadMXcaTeSmDbzvEZnCObbGHASewKjVSHAHJ+xom7WvdXUjg64DrMdQw+B+rywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyYMQuTx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45629702e52so23182135e9.2;
        Tue, 22 Jul 2025 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753176284; x=1753781084; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+//jYCN9fJ3UKB3gQrh8TeOMN1LQzo1k6VYys+m57I=;
        b=ZyYMQuTxvzAIOYmTkb9Bpm+4l7FXviKmQF29wYHJ2/lWOWkUzOR+T1oATvrh22EveH
         BQzjr4zZ20A8nGcw/qV31vFAzNSmjUJcl6xNrBfesexnfTA8nXk3bb1vjGRz5hpwj5cZ
         730HeCjY+XF1vvtUUG7f733jC/Tt0PWKtcVaoO+RwXhLPn7m0YnTx9aevaW42QUNw2tn
         pxIhKIxJNKAokpoDjfozelB3h07ovyDvvu+7051UWZCaBX7itdyhxFBJxHRo6Jn/pp6Y
         r+41db+9AOpvZzcDJKYYyVqxB+MTOh4yvt4yfS4nQBc8i8RNHbS7b8UEPLAQcavcFQ7l
         +WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176284; x=1753781084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+//jYCN9fJ3UKB3gQrh8TeOMN1LQzo1k6VYys+m57I=;
        b=d7/hUfjUY0ixhfNOKPwPZrpOX21X5EkjtokRYZtXwXgqI3vqvYLRVXvam2z6IB6CE5
         ENUoa5jcAxVOszPo61/khXNDXM6IZ40ZEVJKuvUbu3htJQMzop/orWc3RyWRf/wOh5ON
         vqbILLoEVqYqMyOrfvXi5bGUX8iltmJB027IQ2oyP8Lew+PF4HeM1rqYUoftbMYsuVaM
         5zqi3eJ35zjM/RM0cBHL1WYqNoLcE5KUfR2yH4VNy/GlMf6q/l6CY6hNbkgl8y8mkUCR
         d0UsVQLhjC3nbQTYRav6DSp7b7TKpi858A4+dHYV4I8NeZafTAf2SdfVRsvg4eUC93xS
         DCUA==
X-Forwarded-Encrypted: i=1; AJvYcCURKIS6O5C1YgEnAIFZBc0lKNBomCU2YsUP2SsZ1GSpF7zcvHjPY8Fkha0lkqnLBXTFe8pKmGVrqho=@vger.kernel.org, AJvYcCWlhJtjhHkGusAmu+cR6mFz9jEflWsQedO2R42deQWAXY7YJlEcqkM7k9gmzSgspQ9mvitWtFH1yk2wBreQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AlUikif8WhXifIlUKr1cdSwd2UikXMMPe4VgrUBLoh74fc90
	YDhEKhlUiAuHsfJdRD1fcTRmXwJDv6T0UuYzdjiw73ZLFCImhaaf5Af4
X-Gm-Gg: ASbGnctmbJuCIq0Gvh+ubhC1yENt9IQq11K+GzdfX5Q5x8FSk/nQNfCNbpdTnlBe0MZ
	cP5v8p4UKyjBpOr8RGEbRY3Q0nBoo+j6A2JT09+QaWyoJbb4WPd9ZWCY99AkmCa5GYtJU8s5jcC
	qGefsQpIGli0BakvHOabA/MMoxpCzjApLuMXdCINrhsGWeA3q7rZ/+lstmN3AG8ooL87oGcDx/f
	EOttCglrCG28Ml0TbDyqUmHIMGADbQQNKcpdF8eqsK70yHBo29BrZdW1rx/4iRhuhH+lUMPhEkY
	7xmdPhwn/ZbXcyizjd7HeDBt8NWXNtmLl5BHKofmQQ0YseWuXkmNhov9TPd/Sb9aFFDckrfZPDm
	S5q14xiO2gA==
X-Google-Smtp-Source: AGHT+IFS4JFdYUjRXvwa6PQG6LzBe+yHOPx1nP72j3LNTxLgT1+qD+QgeFECSpuWPgbAAOPMEXKNLA==
X-Received: by 2002:a05:6000:420f:b0:3a3:5f36:33ee with SMTP id ffacd0b85a97d-3b60e4f2d43mr18277380f8f.32.1753176283506;
        Tue, 22 Jul 2025 02:24:43 -0700 (PDT)
Received: from nsa ([89.40.212.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bac1sm12944186f8f.25.2025.07.22.02.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:24:43 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:24:56 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: maxim_thermocouple: use DMA-safe
 buffer for spi_read()
Message-ID: <pj2pzpd33covkhi2ho3nsoazqqqpfeiy6n42fkmada6drpr6bj@2dm4iqxdhotj>
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com>
 <bd5c1587-c830-40e6-90d5-be7fad215cef@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd5c1587-c830-40e6-90d5-be7fad215cef@baylibre.com>

On Mon, Jul 21, 2025 at 06:06:39PM -0500, David Lechner wrote:
> On 7/21/25 6:04 PM, David Lechner wrote:
> > Replace using stack-allocated buffers with a DMA-safe buffer for use
> > with spi_read(). This allows the driver to be safely used with
> > DMA-enabled SPI controllers.
> > 
> > The buffer array is also converted to a struct with a union to make the
> > usage of the memory in the buffer more clear and ensure proper alignment.
> > 
> > Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim thermocouple chips")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > Changes in v2:
> > - This is a new patch since when looking at it again, I noticed a bug
> >   with passing stack-allocated memory to spi_read(). So now the primary
> >   purpose is a fix and converting the array to a struct comes free with
> >   it.
> > - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com
> > ---
> >  drivers/iio/temperature/maxim_thermocouple.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> > index cae8e84821d7fd521d59432580d51def939fa4d1..fa648a6542a4e2f08adb556c776b68331ae69631 100644
> > --- a/drivers/iio/temperature/maxim_thermocouple.c
> > +++ b/drivers/iio/temperature/maxim_thermocouple.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/module.h>
> >  #include <linux/err.h>
> >  #include <linux/spi/spi.h>
> > +#include <linux/types.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/trigger.h>
> > @@ -121,8 +122,15 @@ struct maxim_thermocouple_data {
> >  	struct spi_device *spi;
> >  	const struct maxim_thermocouple_chip *chip;
> >  	char tc_type;
> > -
> > -	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
> > +	/* Buffer for reading up to 2 hardware channels. */
> > +	struct {
> > +		union {
> > +			__be16 raw16;
> > +			__be32 raw32;
> > +			__be16 raw[2];
> > +		};
> > +		aligned_s64 timestamp;
> > +	} buffer __aligned(IIO_DMA_MINALIGN);
> >  };
> >  
> >  static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
> > @@ -130,18 +138,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
> >  {
> >  	unsigned int storage_bytes = data->chip->read_size;
> >  	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
> > -	__be16 buf16;
> > -	__be32 buf32;
> >  	int ret;
> >  
> >  	switch (storage_bytes) {
> >  	case 2:
> > -		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
> > -		*val = be16_to_cpu(buf16);
> > +		ret = spi_read(data->spi, &data->buffer.raw16, storage_bytes);
> > +		*val = be16_to_cpu(data->buffer.raw16);
> >  		break;
> >  	case 4:
> > -		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
> > -		*val = be32_to_cpu(buf32);
> > +		ret = spi_read(data->spi, &data->buffer.raw32, storage_bytes);
> > +		*val = be32_to_cpu(data->buffer.raw32);
> >  		break;
> >  	default:
> >  		ret = -EINVAL;
> > @@ -166,9 +172,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
> >  	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
> >  	int ret;
> >  
> > -	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
> > +	ret = spi_read(data->spi, &data->buffer.raw, data->chip->read_size);
> 
> Compile check didn't catch this. Need to drop the &.
> data->buffer.raw is already an array.

Neither did I :). I should have looked into this email __before__ (and
not after) sending my tag. Anyways, consider the tag with the above
fixed.

- Nuno Sá

> 
> 
> >  	if (!ret) {
> > -		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
> > +		iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> >  					    sizeof(data->buffer),
> >  					    iio_get_time_ns(indio_dev));
> >  	}
> > 
> > ---
> > base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> > change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc
> > 
> > Best regards,
> 

