Return-Path: <linux-iio+bounces-17678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA8A7CEB8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39933AD8A7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4821D3FE;
	Sun,  6 Apr 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaE8YnwO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927584A24;
	Sun,  6 Apr 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743953627; cv=none; b=qePmzCu7Y5TSVRjuf/1O4GYYAwQ9hskJMszVu+OPV9uDvyOq0J5dL0/wpQZi4kri4MNgJF22wKyK6T7+ssN6DyfEPE/So18rjjyZIon/XghNq8KYbcFtLXT2Cj5z+nKXHrl2YqmPFy34ZPFy8gHJkGDM5CleI3fJboeL+EPsAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743953627; c=relaxed/simple;
	bh=uRWwzf3Cqc2TNq4pcFtLXlg0tm7YFWMhYe4BcVk1eZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dy9qYoesgbPLxHXWWgdQNHYcSe3vc9eYd5K8BS/HwdZebOnnlRe4QFUkR+8dDg5XjBjQvuiSMZ2ZM13J1FLjFmdfIiIHmnhvM9s14c0jgHn5mOErrpNNKwvL/t10jPWOIogmx4OvmWcEGP9OMOoVUNktKi/N/YAi2BSz5zX038E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaE8YnwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCBEC4CEE7;
	Sun,  6 Apr 2025 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743953627;
	bh=uRWwzf3Cqc2TNq4pcFtLXlg0tm7YFWMhYe4BcVk1eZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jaE8YnwO3sKsTjNAEwaElTfocYoAyJ4KUTlkagwI3KPTEE9Hy5MeW1FyvoI65zzoY
	 uJBNth60gBiS85bfjRiVRp4+5UAU2k7/3Q1heEIvIuBGxoHXDZL4kqdvAdZCy126v4
	 MTggGwKlS1Hqs00NoFmf9TP8fCCVKQVX+iEufzeBwvYuQ6fwvsPp0bGqV1aCLRGpw8
	 HyGKObyxwu/R5ct/9QYvABeqLd8veWTj5gUZ5asDbSfz8RFiLlwbaPppflLdGzyVne
	 t58K75IRtipoOTAylpDmhVgbynUdIXFYOk9w+f5DYEgd/NWwBRb4kofLz+x05CaI7X
	 Twjmol2QSqT3g==
Date: Sun, 6 Apr 2025 16:33:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gyeyoung <gye976@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
Message-ID: <20250406163338.7457f940@jic23-huawei>
In-Reply-To: <CAKbEzntnZ+SJ07An+tD3ByrxqOR0FrJ09bymoUZODM0XXjYFQQ@mail.gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
	<20250403053225.298308-4-gye976@gmail.com>
	<20250404123308.00003d72@huawei.com>
	<CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
	<20250406122048.3d59c2b5@jic23-huawei>
	<20250406122628.7511e1b0@jic23-huawei>
	<CAKbEzntnZ+SJ07An+tD3ByrxqOR0FrJ09bymoUZODM0XXjYFQQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Apr 2025 22:31:43 +0900
gyeyoung <gye976@gmail.com> wrote:

> Hello Jonathan,
>=20
> On Sun, Apr 6, 2025 at 8:26=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sun, 6 Apr 2025 12:20:48 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > =20
> > > On Sat, 5 Apr 2025 22:47:45 +0900
> > > gyeyoung <gye976@gmail.com> wrote:
> > > =20
> > > > Hello Jonathan, thank you for the review.
> > > > =20
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-m=
hz19b b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > > > > new file mode 100644
> > > > > > index 000000000000..6cdfd34be016
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > > > > @@ -0,0 +1,7 @@
> > > > > > +What:                /sys/bus/iio/devices/co2_range
> > > > > > +Date:                April 2025
> > > > > > +KernelVersion:       6.14
> > > > > > +Contact:     Gyeyoung Baek <gye976@gmail.com>
> > > > > > +Description:
> > > > > > +             Writing a value adjust maximum measurable PPM.
> > > > > > +             should be 2000 or 5000. =20
> > > > >
> > > > > I haven't checked but assume this also results in a scaling of the
> > > > > measure _raw values?  If so the control should be via the standard
> > > > > ABI scale.  If you need to be able to establish the range, provide
> > > > > the _available for the _raw via the read_avail() callback and set=
ting
> > > > > appropriate bit in info_mask_separate_available
> > > > > =20
> > > >
> > > > In this device, changing the measurement range does not affect the
> > > > unit or scaling.
> > > > As far as I know, increasing the range just leads to a decrease in =
accuracy. =20
> > >
> > > That's unusual but fair enough.  hardwaregain is perhaps appropriate
> > > as this doesn't really map to calibscale which is the other thing clo=
se
> > > to this.
> > > =20
> > Actually - any idea what the gain is doing?  Is it adjusting a analog
> > amplfier, or messing with the integration time (I have little idea
> > how these sensors work!)
> > =20
> sorry, I'm not affiliated with the vendor,
> so I do not have any information other than the datasheet.
> And the datasheet doesn't specify any trade-offs related to adjusting the=
 range.
> (only "=C2=B1 (50ppm+3% reading value)" is here)
>=20
> I think this range setting would be better implemented in
> some other way (like module parameter) rather than IIO subsystem.

I'm not in general keen on module parameters effecting policy (and noise
vs range is definitely a policy thing) so I think we would want to figure o=
ut
a suitable sysfs ABI.

> For now I'll just drop this range setting code..
Makes sense  - can revisit when needed.
>=20
> Regards,
> Gyeyoung


