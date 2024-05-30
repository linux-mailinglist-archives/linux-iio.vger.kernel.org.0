Return-Path: <linux-iio+bounces-5477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B378D456D
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 08:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2A31F231F3
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48190155345;
	Thu, 30 May 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1i+QwSG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B082143897;
	Thu, 30 May 2024 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717050002; cv=none; b=eDZ4DvARdvHf/bzw3OCakK82Qvc0yS2UgmKWLEXe0Z1oJhxKq4SZag8I2TQcAMUJZySFYZFMeXGijUaW84Xwu+eEM84uA9mI9nGippnecR+qhX0ncoreWO50vWv6ulWArvHjMLg+ta738N2dtg29mkb0aX8ok//EiQb5Em9vuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717050002; c=relaxed/simple;
	bh=Fe2d2A4z7f9CwxyiKX6pKntbe4v643xdTxApAlhvcfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwMSevkHR/QfUjCQtwp+sREzJJQ3Zj3YJBU5d4mu37v+/jNScWCauKtw8i0wOkQzC1ppKSiGMNjxuOS8FVOttA8H7IbPuOSXE4HV2SCmSEsIMoIZmQnMJdIVE5G6el6I2WGkLV5uAv1AX5MDdKc+l1F2HbKSu2QpVAX4/OcmMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1i+QwSG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-420180b59b7so6505745e9.0;
        Wed, 29 May 2024 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717049999; x=1717654799; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nGB5azc1AWOxeIywWywVSQOrQTdtCakw86KhzarLqxg=;
        b=W1i+QwSGN0HgnNPZ8BxXcjVbdsKkyGXSRk5CNxB6fJWc4XjmzPyQalJHonpeLGG9lm
         S1ubpsJQ2lm5zdMnxqyUoWi248yYJcYu4ndLBVwA/aNDya5IPcU0mwKNROgJwHPMBfrq
         rU5SpI/3iePD5pbvk3zew+sk+ZGCASs5g47FG8tLx+ysYd/0pnnD7/KSSkw+ZuObsDRN
         HAVbaotSr0NDd/7EYMceq23dRTIBG0hQUI1b/ykL9M9DBVcWwEJJ2166YoQMe23/lxIj
         2SHAVVW3OLluSzpYiY1YIYEEoip5VKHDHQG0Mzc/8aQmx4vGdStKlP6qPQv2Ug4kBiyH
         rwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717049999; x=1717654799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGB5azc1AWOxeIywWywVSQOrQTdtCakw86KhzarLqxg=;
        b=esc35zJmbiM1Y7n/2/MOktQjDghGmCi8fKVnd+Uau+MjC2bTKc8Xm4wDsFBI7G4GbO
         CMEcDIp67wskhO8ut2rn4DGNsjNxI6Zrr+swFdwu84kpq5MvV6TPMGNcZP2iqmQ5A1er
         K9fOzstzel19JhlTIngD4C34qF5PI7qPXOGlJyQs6J/MvDXTGQecyT63QCaS9TAFqAeL
         XB2/Al2SdCnsNl3Io0NlAVNawhnVfS9oI75EQ0Al+smhKcFBsGe0mq7Wi4tk2mccQ6OM
         zYKng9ATOimSKEGziyceI3yELXjUMFDsj8FLpBp1tG+BQU+N9vWJuhBps7A8lYl+5iEK
         7zFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdQ7a5Xbx7kmBBSyyY2EpivHfKUj/Cm7J8iqKCX85ZAY+5zg5iE+A9h55z1Q3vacXYDVURwQ1O/PeM+P+yreOwzNH4mTgaQacU97oGU2VEVK2jtKr4KHWu5ghvNu3vnfaHumyvVfES18RomxYsol8qzql9HtNE05gUlufByziCheDRhA==
X-Gm-Message-State: AOJu0Yw7i5pNT4/ialbdZh0MdkY/gezW3iF+l7XC9c6yYyyjLMZyvFG+
	IIyGo+M7tC2LhlQIKj8hZQ/5PGgAuuEb1MOmxijqtlzWdI0VDHOx
X-Google-Smtp-Source: AGHT+IFW3nvkrOa35PELOhsa1ZftPs5NlzMr19sLq7fYtR5foc5ARSf15qJmvaqrDZWxv8XH5puPbg==
X-Received: by 2002:a05:6000:364:b0:34c:9a04:466f with SMTP id ffacd0b85a97d-35dc00be96cmr710514f8f.50.1717049998317;
        Wed, 29 May 2024 23:19:58 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35b1d7a496asm6704409f8f.87.2024.05.29.23.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 23:19:58 -0700 (PDT)
Message-ID: <d3c2496deb6a1764d06a63592b416d30d43fcc47.camel@gmail.com>
Subject: Re: [PATCH v3 5/6] iio: adc: ad7173: Add support for AD411x devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, "Ceclan, Dumitru"
	 <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 30 May 2024 08:19:57 +0200
In-Reply-To: <30192c2a-5275-41ac-bc20-aa5f436846a3@baylibre.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-5-7e9eddbbd3eb@analog.com>
	 <6f18184de4a37993baedc15b44ecf0a6834a24d1.camel@gmail.com>
	 <917bc1d9-fbdc-4ca2-a156-813b57c8201e@gmail.com>
	 <30192c2a-5275-41ac-bc20-aa5f436846a3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 15:59 -0500, David Lechner wrote:
> On 5/29/24 9:03 AM, Ceclan, Dumitru wrote:
> > On 29/05/2024 15:46, Nuno S=C3=A1 wrote:
> > > On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >=20
> > ...
> >=20
> > > > =C2=A0static const struct ad7173_device_info ad7173_device_info[] =
=3D {
> > > > +	[ID_AD4111] =3D {
> > > > +		.name =3D "ad4111",
> > > > +		.id =3D AD7173_AD4111_AD4112_AD4114_ID,
> > > > +		.num_voltage_inputs_with_divider =3D 8,
> > > > +		.num_channels =3D 16,
> > > > +		.num_configs =3D 8,
> > > > +		.num_voltage_inputs =3D 8,
> > > > +		.num_gpios =3D 2,
> > > > +		.higher_gpio_bits =3D true,
> > > > +		.has_temp =3D true,
> > > > +		.has_vcom_input =3D true,
> > > > +		.has_input_buf =3D true,
> > > > +		.has_current_inputs =3D true,
> > > > +		.has_int_ref =3D true,
> > > > +		.clock =3D 2 * HZ_PER_MHZ,
> > > > +		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> > > > +		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> > > > +	},
> > >=20
> > > At some point it would be nice to drop the ad7173_device_info array..=
.
> > >=20
> > What are good alternatives to this?
>=20
> Drivers like ad7091r8 have individual static struct ad7091r_init_info
> instead of putting them all in an array. I like doing it that
> way because it makes less code to read compared to having the
> array.
>=20
> It would let us get rid of enum ad7173_ids, have one level less
> indent on each static const struct ad7173_device_info and=20
>=20
> { .compatible =3D "adi,ad7172-2", .data =3D &ad7173_device_info },
>=20
> would now fit on one line since we no longer need the array
> index.
>=20

Exactly... But up to you to do it now or defer it to a later patch.

- Nuno S=C3=A1

