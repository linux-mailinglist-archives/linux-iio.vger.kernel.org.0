Return-Path: <linux-iio+bounces-15562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7704DA374CC
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F6D16D908
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD071990A2;
	Sun, 16 Feb 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbiV0dug"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0E19755B;
	Sun, 16 Feb 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739717087; cv=none; b=ok4QVY/RljFA139sqJxe2w+uLk+YmnQx9azV5YQNvYBSxjzpew8SAj2HZFsbU3B2kXfNcOU4Q/XznxhqRSQvJAICJxuCzEUSdd4/5kNbw9UMQr1+HMGh+OEmloOc+JjhJAzK0WwiaAtKLiGMZD49lx1XNILXXmi0Y9C3Nqy4i2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739717087; c=relaxed/simple;
	bh=HUXeE93HUWmwSWE2DNlCQ6wi1Dmd4yxC3MTLyhyLT6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpCzxxtXymwmMoPSQJ1t12dE2cxyvDYAXTchJf+/b/09PdxeUqgYxC2EiH0ofVu4bufaszsSO9p0X8hLFJxyyGDyWn25ROelzLIIERsT5bfb6kIQSSkxiZzj9LL8iWjlxYCej876yZzaMdft74XwiO0yKryLDuDgs5Jy2amtU+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbiV0dug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A4CC4CEDD;
	Sun, 16 Feb 2025 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739717086;
	bh=HUXeE93HUWmwSWE2DNlCQ6wi1Dmd4yxC3MTLyhyLT6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sbiV0dugI2pytUK3ePCDtacuQrV1jt5qGWPYFFBY2t0oN+kNRcudp1tBjT7jLXKUF
	 7jLx+4HC0eADTb12IeTO7OqFQgFZnOE+/m8aQ6gAxKb0N2v2divflg+d4ijsBgwbmB
	 smRgJu9ynFGAfzqpkPeU7U47lB+rYhLdRrmQW8PVlDpS/aKDTaOspj4FkjcfE1GYPS
	 5rRZCkbQnBJH6zUjeNAjE8ASWjvfjc/s7mX5BCEJeTkmyeeL4L+LFd3rSjJHgiDn9Z
	 jIsEGlOiE2rdIc1g2gWVZDhd+fx0BftUPS0zUxF7JpVYpxfa3EnSaK2ZyaLbVdw7db
	 vZlVIq4lRy5ww==
Date: Sun, 16 Feb 2025 14:44:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <20250216144436.70ff78c3@jic23-huawei>
In-Reply-To: <CAPVz0n1T_jXXDhm6gF7gDDqZ=b6abR1Tqk=5kLo=Ws4FF2EVJw@mail.gmail.com>
References: <20250215103159.106343-1-clamor95@gmail.com>
	<20250215103159.106343-3-clamor95@gmail.com>
	<1597453a-31fc-49eb-8b69-efeb8805c67a@ixit.cz>
	<CAPVz0n1T_jXXDhm6gF7gDDqZ=b6abR1Tqk=5kLo=Ws4FF2EVJw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +
> > > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > > +                         struct iio_chan_spec const *chan, int *val,
> > > +                         int *val2, long mask)
> > > +{
> > > +     struct al3000a_data *data = iio_priv(indio_dev);
> > > +     int ret, gain;
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_RAW:
> > > +             ret = regmap_read(data->regmap, AL3000A_REG_DATA, &gain);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             *val = lux_table[gain & AL3000A_GAIN_MASK];  
> >
> > Why did you chosen to do post-processing in the RAW channel instead
> > doing it in INFO_SCALE (same as al3010 does)?
> >  
> 
> From my observation INFO_SCALE will just perform multiplication of RAW
> to SCALE. In this case values which are read are not actual raw values
> of illumination. Next is my assumption (since there is no datasheet),
> but values obtained from register are similar to values from adc
> thermal sensors, they need be converted via reference table to get
> actual data.

Please add a comment somewhere here to say that we don't know the
relationship of these values to illuminance hence providing
_RAW and _SCALE would not be helpful.

> 
> > Except this, LGTM.
> >
> > Documentation and DT patch:
> >
> > Reviewed-by: David Heidelberg <david@ixit.cz>  
> > > +
> > > +             return IIO_VAL_INT;
> > > +     case IIO_CHAN_INFO_SCALE:
> > > +             *val = 1;
> > > +

Don't do this.  The above lack of known relationship has to be
expressed by not providing the _scale attribute.

> > > +             return IIO_VAL_INT;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static const struct iio_info al3000a_info = {
> > > +     .read_raw       = al3000a_read_raw,
> > > +};



