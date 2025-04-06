Return-Path: <linux-iio+bounces-17665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B91A7CDB7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BBD3B28CF
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE01A7045;
	Sun,  6 Apr 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKgje2hp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ABD2AEF5;
	Sun,  6 Apr 2025 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743938797; cv=none; b=NH2Ia31nCH+V5r4H9FfoAKedNl5j76tZp+645mCKBIEvM/DwlV1DMZrGJd5m36VuFtY9VCdOXmF44Z3AK/9sb0t/bUD0V/mv4of465Ph0KMarwAKOg3I9eG1NjZT4zSjsZBdZlExMQFVOJiXwonzn4pD2Y+oBwfwFiVEttB46qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743938797; c=relaxed/simple;
	bh=jL/8D2qCZPKTmwi777Tx43TnzWuJu6d9pmmYBT1sfe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beNXHvVZSB5cwyqBilDl8Ai6rtofX6wSrZ5RQGpURF4dnXOO6ZYPXhUH7dnyocst5OO3hoErcDDextPrt/aTsXHJM/xbB9WDSV8onCL6oEs+bDfmxFfBoRdBUyJSByogVdHqKJ6GZFV6o6ONmk5tg9Szx0VAsan/6paIVnfOFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKgje2hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458EEC4CEE3;
	Sun,  6 Apr 2025 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743938796;
	bh=jL/8D2qCZPKTmwi777Tx43TnzWuJu6d9pmmYBT1sfe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKgje2hprWREMBbm/vS7rpVOjWc173idvFeLKlPCYzOg+jR+Gy+xUh6irF0BA8a6o
	 M+7/0vpCyp7YkjNoyFuDIGy7L4ipSr9M6BJf3lIR8Kgmb80UJ8w0cyr0nk9msbTXzQ
	 3Fc5lG3FIgvIFoHxZYk+TASuuUxRrZsuEYQ3wBU6IPbNNYyHXvyo0ltpQDu04lGujB
	 aL//m5mDBnW3Z998fp9VXWpeyFD0pGAWfA2GTZAaZiQyefSWju1O4mH4WU2ixKXOa5
	 ChOSI1uvVTCIhmWKTDeMH6vYdVIZE+Owep9mJ3z6zu2Nok+HUhWRfqXkVEf8LflC+s
	 cdNOzpWb7G07Q==
Date: Sun, 6 Apr 2025 12:26:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gyeyoung <gye976@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
Message-ID: <20250406122628.7511e1b0@jic23-huawei>
In-Reply-To: <20250406122048.3d59c2b5@jic23-huawei>
References: <20250403053225.298308-1-gye976@gmail.com>
	<20250403053225.298308-4-gye976@gmail.com>
	<20250404123308.00003d72@huawei.com>
	<CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
	<20250406122048.3d59c2b5@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Apr 2025 12:20:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 5 Apr 2025 22:47:45 +0900
> gyeyoung <gye976@gmail.com> wrote:
>=20
> > Hello Jonathan, thank you for the review.
> >  =20
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19=
b b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > > new file mode 100644
> > > > index 000000000000..6cdfd34be016
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > > @@ -0,0 +1,7 @@
> > > > +What:                /sys/bus/iio/devices/co2_range
> > > > +Date:                April 2025
> > > > +KernelVersion:       6.14
> > > > +Contact:     Gyeyoung Baek <gye976@gmail.com>
> > > > +Description:
> > > > +             Writing a value adjust maximum measurable PPM.
> > > > +             should be 2000 or 5000.   =20
> > >
> > > I haven't checked but assume this also results in a scaling of the
> > > measure _raw values?  If so the control should be via the standard
> > > ABI scale.  If you need to be able to establish the range, provide
> > > the _available for the _raw via the read_avail() callback and setting
> > > appropriate bit in info_mask_separate_available
> > >   =20
> >=20
> > In this device, changing the measurement range does not affect the
> > unit or scaling.
> > As far as I know, increasing the range just leads to a decrease in accu=
racy. =20
>=20
> That's unusual but fair enough.  hardwaregain is perhaps appropriate
> as this doesn't really map to calibscale which is the other thing close
> to this.
>=20
Actually - any idea what the gain is doing?  Is it adjusting a analog
amplfier, or messing with the integration time (I have little idea
how these sensors work!)=20

Jonathan


> >  =20
> > > General rule is don't introduce new ABI unless it is impossible to
> > > provide the same information via existing interfaces.  The decision
> > > to use scale rather than range info to control channel scaling was
> > > made a very long time ago and having a mixture of the two would
> > > make for very complex userspace code.   =20
> >=20
> > I=E2=80=99ve reviewed the sysfs-bus-iio documentation, I think there is
> > no suitable interface for this case. So I'll drop this option.
> >=20
> > Thanks,
> > Gyeyoung =20
>=20


