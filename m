Return-Path: <linux-iio+bounces-16041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21524A43956
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854C43BA4C3
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A12566EC;
	Tue, 25 Feb 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1zbKpTs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9471A5BA1;
	Tue, 25 Feb 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474976; cv=none; b=I+ZaKthxkFCSPJ/09l5HbgeR6KqH5Gr+u5N5cFQDArwoQZ7VPpJausYxMiK0erdvrGquo63PoX6nZ24qDSb14P2J0rSjvGrkAKwc868Bxi16R7ztkVwLIy5EIm1HEKqFqXFz3SFrxX1Z/pA0HZ+xG/wNIm0PJxXdUyG59Y8RFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474976; c=relaxed/simple;
	bh=x07AImckdsutiWV6cJI2jieqhqmK1oZS3qzMypzQ/Ok=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2MWy9GgL+RO6z3gcEoQzCguAvLCjT5LpIFcMpWZXgFSeRBzKZBNmfOVwMEo/Ljbk9E13Wm7fTW1YiW/Zxl/D5unirc3enF4FCQetpdkZ8DIab0NOmck+ngInvfJ+ahgUn0aSayIf6nnzmjQEpjlPGEGcwpL9iaAtZx+2SV0d3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1zbKpTs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43994ef3872so32288495e9.2;
        Tue, 25 Feb 2025 01:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740474972; x=1741079772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND03FSByttfluhwaHZ2jqr8q/QaCO04nzZNHbR2z+Eg=;
        b=m1zbKpTsLYv7xtRFy7SDYXhETuBiALnX5iDzcphFVPvaAHJOIismFJAiJLye2Cy2fn
         djfarGIlinSyo6V0f2y9TZ3o6fO6sCb88MJXdcTAZuztY5qgtDBnfTyjXOHrHfLL/BDY
         EdxzOEsIpXXfbN18AILtsS7rDKX/RC+CGyEQ/MZBxr558hLVolYr6txP42cXmNaZGLPp
         iqWMGhqA5spEurui5Xlnkse623u6125x6Rjx9qrDut1SNsFHdetbZEmq6ljwXinIKEge
         FFmx9IGjwYRDvAeDJ5IyxapSuSIirBRum9zhzs0yz5dEGI66vDsI79dUts4zZwibhXNM
         qTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474972; x=1741079772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ND03FSByttfluhwaHZ2jqr8q/QaCO04nzZNHbR2z+Eg=;
        b=KPaGl74QxJHdLubsZkUUkK/0qO4Z7bmuTXBRxQ4X4E+F85Bh/0QIDzsfjRkbbCObZT
         7pCyS42a2FCDR2LJSwJ14PpRyFGavIFjLvkzU9wy+4OgXMAizQWQqBsNBs0UkxCUHRk6
         m/hzlzbCAWeDXcek9RsLxeiwgoRuaQAwxUiLmPZMZ2WIqv8X4qlp9nb6TfEBi7z7ATJS
         N2ixw6hGjLVBH5IklsMx1DlKC39T5Vk52eOJDYLzWGwZd3sZwxUPxPbK4YjuOq6RUhSB
         xSLkLKzv8g2FoV5D/S0qiq+K4SmKVN/6M9OnHwAlc1NdzKEIb8XyZFQFmeZQQ6wrpIjs
         +nCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNKK3CphNr1FoyI3M7xtVIgKCUDgPVVod3nFHN4hcUudWxthc1HEYiUmjYxrJOkx35yj3jwmw8fCb2@vger.kernel.org, AJvYcCX6fPQ6s7Jm+oso6VgaPx9vOi3eGqVPxnH4WJ6fZOOpzbZzqtlhOtyKstYogmrru2HVdpRFOMSWpH5v@vger.kernel.org, AJvYcCXtv7nYgJL8/9TxhwYmhbEpHECBSbwTBbmZ9gJdltcPajNRjGJeb/Cmx2FN4sLmfU56SV4w0Yi9F2tQjxNc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1/VbelB+uFA4IWTd+xtBdz7lEtw+hlILoZNJ+XSr550IdQDA
	lpX5mX8OjyJWvUooJ3YgFNnYwpxE4vsXeah7TBnxbgvZJniEHGCi
X-Gm-Gg: ASbGnctPU+67Z3UzAXwYzc35gjFF0sBXc0mgtxuBSVn0FCg3VLKXnqxX/59UKAUHa3Q
	0fjvLdV1mt+zx0XAtmIlqVB8ORhpA4vQ3fIgFeMBVwOPZ7/iAsGp+ePl9TFWU3mcee8CcUVEDba
	xtmi9wytNvG5SZUDcIcvqqDpz3mkSPFzK7xzWAeohRGQvZysOFBk+eWHVfFx2rOm4YdrQlm2IKK
	sNfE6W6/UHF3fVVCDnFq17tvgjBUQXLafOcqM8p0+on3j2j/4hES176jQpL7W66giTf1XdQTp/P
	0Gg7QXe2QftXoSOcr0OtGttuj8mt0YYdYuhyWjB22KtgMcSzV/M7A0g5Y8Sagk0j7BI0JV8FoA=
	=
X-Google-Smtp-Source: AGHT+IHkPPl0DIWuFtS3gq+AAlC/4I0hHnM9EEjvhghkzGZg2/3hI7L63xeUfFD30DTXR0o1cu2sVA==
X-Received: by 2002:a05:600c:4684:b0:439:56f3:d40f with SMTP id 5b1f17b1804b1-43ab0f6dedcmr16273745e9.21.1740474972163;
        Tue, 25 Feb 2025 01:16:12 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c4051bsm10769545e9.0.2025.02.25.01.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:16:11 -0800 (PST)
Message-ID: <3f4bb345c1d76e7521d8bdbf4b4552e727c7dc1c.camel@gmail.com>
Subject: Re: [PATCH 14/14] Documentation: ABI: testing: ad4080 docs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, jic23@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 	linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 09:16:16 +0000
In-Reply-To: <fd3ba169-c5e0-4405-961f-d7c11c68dffb@baylibre.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	 <20250220135429.8615-15-antoniu.miclaus@analog.com>
	 <8f588f4b88d122815df694660d19672e8ccd3d70.camel@gmail.com>
	 <fd3ba169-c5e0-4405-961f-d7c11c68dffb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 12:27 -0600, David Lechner wrote:
> On 2/20/25 8:53 AM, Nuno S=C3=A1 wrote:
> > On Thu, 2025-02-20 at 15:54 +0200, Antoniu Miclaus wrote:
> > > Add documentation for the ad4080 attributes.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > =C2=A0.../ABI/testing/sysfs-bus-iio-adc-ad4080=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 55 +++++++++++++++++++
> > > =C2=A01 file changed, 55 insertions(+)
> > > =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-=
ad4080
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
> > > b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
> > > new file mode 100644
> > > index 000000000000..e37bfba0e989
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
> > > @@ -0,0 +1,55 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/lvds_sync
> > > +Date:		February 2025
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		This attribute handles the data synchronization
> > > process.Because the CNV
> > > +		signal is not taken into account by the FPGA when
> > > capturing
> > > the data, we
> > > +		need a process that configures the ADC to output pattern
> > > data, writes the
> > > +		SYNC bit in the axi_adc register map, waits until the
> > > custom
> > > HDL syncs the
> > > +		data correctly, and then changes the output mode to
> > > analog
> > > data instead of
> > > +		the fixed pattern.
> >=20
> > I'll comment this one in the driver. I have some questions on how this
> > works...
> >=20
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/lvds_lvds
> > > +Date:		February 2025
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Configures the signal type of the CNV signal. The value
> > > can
> > > be either CMOS
> > > +		(lvds_cnv=3D0) or LVDS (lvds_cnv=3D1).
> >=20
> > The name seems to be wrong with what you have implemented. From this
> > description, I would think of this as a DT property? Can the signal typ=
e
> > really
> > change at runtime?
> >=20
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/filter_sel
> > > +Date:		February 2025
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		This attribute enables the digital filter functionality
> > > of
> > > the AD4080.In
> > > +		order to capture data correctly, the function must
> > > configure
> > > the ADC
> > > +		through SPI to select the filter type and enable data
> > > capture
> > > in filter
> > > +		mode through axi_adc(In this mode, data is gated by a
> > > signal
> > > generated by
> > > +		the AD4080 (GPIO1 and is not continuous as it is when the
> > > filter is
> > > +		disabled).
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/filter_sel_available
> > > +Date:		February 2025
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Return the available filter modes that can be set.
> >=20
> > There's a standard attr for this. I think we settled=20
>=20
> Yup. filter_type and filter_type_available.=20
>=20
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate
> > > +Date:		February 2025
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Set the filter=E2=80=99s decimation rate.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate_available
> > > +Date:		February 2025
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Return the available filter's decimation rates.
> > > +
> > > +
> >=20
> > I'm not yet convinced we need the dec_rate custom attr. I'll add more
> > comments
> > in the driver.
>=20
> If we do need it, in another driver recently we concluded that
> decimation rate is the same as oversampling ratio and there is
> already a standard attribute for oversampling ratio, so we used
> that.
>=20

Yeah, in theory decimation is about averaging samples. Makes sense to me ev=
en
though I never thought about using the oversampling ratio attr. I was biase=
d by
the IMUs drivers where we configure the dec_rate as part of the sampling
frequency attr since these filters directly affect the chip ODR.=C2=A0

Out of curiosity, how did you handled this in the other driver? I would be
tempted to only allow reading the sampling frequency attribute which means =
that
the oversampling ratio attr is the one we can write (which then directly af=
fects
sampling frequency).

- Nuno S=C3=A1

