Return-Path: <linux-iio+bounces-9954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D722A98B695
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 10:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862E4282187
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 08:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C371BE24F;
	Tue,  1 Oct 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emJxK/jt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6C1BDAA8;
	Tue,  1 Oct 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770238; cv=none; b=HK1szR9lBTFeOHPRYyzVsBWU+42MaXvoOf7KiSQpOwtxri4iyQaOB4nkwBbWEltEA4SUUn8I5/F7DJ9qUev8U+3bkYFO+jwIpVQlL0+vKbzrp9eXICpOdZnmyA+Tzn52ai0ppMDLjzdERRRaF01NJq51olNlUW4KWsUj+JZWJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770238; c=relaxed/simple;
	bh=42O3WG7idEz0kt6z2OClF0wZmbxLAUMQFZADcf0A7DQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBHwQvfmmJJzZ5HrxERrocs3ztMLRqpNKfkCq3/mjYwpFg4VinyZKGBYXqnGl9BU/Ld24hO4aPbxJIG6vBpbA9sDLBEAOnllsVvxkINS3YzF78SfAccPoU1M5gjgZzWr4PSxsediAhCU/52THPUVRrz+dCItgPJ6alloGTp4xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emJxK/jt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cdb42b29dso2166921f8f.0;
        Tue, 01 Oct 2024 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727770234; x=1728375034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gCFgGTaj2mpysw+k4DdlR3/nJ2KKF9nZPNZv+TdifjM=;
        b=emJxK/jtQlR60or3AcaLQde0mgq4nl4FSeaRbYSChFlEY4jnF5F6YxUTjj1EAaEX5g
         Hj8ec9Izpa5y6doxB9sqLVJjV3mjNdjdDbE7k5i/NoHeTkp6YuqlksicinWjPPz9z+n3
         SmRaZUkctAB1yMfAYePnNcxPyncT27reWD08xnwNKTaz/0umSYHnkzAOmN6bvgPnvwBR
         a+n6Sg5FRrSC2BzLnwO843qlLh7cCAiQxKYIY7uM2QuhaRQVxdoq/26kB43syiXQulk1
         jfYyhdM62tgWsWf2QgBHyE/VhqZHDZYtQ6j3gF4KeoxSRA1o0pbDOE7xrWGODBTkVtjN
         p1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770234; x=1728375034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCFgGTaj2mpysw+k4DdlR3/nJ2KKF9nZPNZv+TdifjM=;
        b=ZZ4ERzDi0Mb9Itzng3poIIO80GANkh106KKcvd/bkn/NDZogqjD/9TIc2qLMBsD+Z2
         8k/ZJA+G3oDI0nQJdzz5uQJ/YpxjZZobePVfOiVkXptXYN+qOlwHMhn4aMRQMQhkBDOY
         05Wls6BJraPPcGQbzwtmEdy/iyoBSaPzUW9+b1MpB7KO/lYoXyeVCa4/LbOUfAAmLVnG
         rF44luGd1UvbxVs3C+JKTVaVpEmDDwFT0fTJTrA2v8XVdFf9FFCqMS4COr9iWMpavD3x
         PFTMUzOEh+PAaPvV0KDGWrnGwyvj/nebNKO13x1bObd1QziuCG7YzQppUuYcZzwOYCX3
         hf1w==
X-Forwarded-Encrypted: i=1; AJvYcCUYLVq2oy0G5mT1gkTMfr4QHYmSciN3rwterLxsQAxH+7s4BgHnwQuyr1MizSXCy9mD+JdMSdNnIQ3n@vger.kernel.org, AJvYcCWM9LsbVITpddv5CcFYoaNnsc2XbE1aqRyFQku1PZGFtrNksgNm5+mN89EizfZO0lNqnNAQb16x+NyK@vger.kernel.org, AJvYcCX4YEMdtn71aRJ+rPX6S98ei3KjfdeTUL421FXDwW1RqilrApOocwp7X7KWcgCnKobrIlGVrFxxTehUfDjj@vger.kernel.org
X-Gm-Message-State: AOJu0YzMS5SboAj2xqfbMb1VZaZkQ+dZyPv3reFPkNRXNzHQnPUsO2QF
	7UYt9LUmdaRqRBJ+ar6lRK3R677QGIumeL+3dinNi5HOU+w4sKoE
X-Google-Smtp-Source: AGHT+IG8zsGXHj764hEucv2Jn32Z7x2kMFq36S9oUI53hN/t80pUkIhlERR7i1FrvE9QOrLC3TLRfw==
X-Received: by 2002:a5d:6751:0:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-37cd5aec57cmr8224211f8f.41.1727770234141;
        Tue, 01 Oct 2024 01:10:34 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7684:3ff1:6790:3866? (p200300f6ef02270076843ff167903866.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7684:3ff1:6790:3866])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575d459sm11131609f8f.113.2024.10.01.01.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:10:33 -0700 (PDT)
Message-ID: <3370ba6d9a6bb8da5ca1415c354a6076de6f1d79.camel@gmail.com>
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Tue, 01 Oct 2024 10:14:45 +0200
In-Reply-To: <c9e30ebf-c661-4345-87bd-3169b57175fc@baylibre.com>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
	 <20240929120535.6b41c37e@jic23-huawei>
	 <c9e30ebf-c661-4345-87bd-3169b57175fc@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 14:25 -0500, David Lechner wrote:
> On 9/29/24 6:05 AM, Jonathan Cameron wrote:
> > On Thu, 19 Sep 2024 11:20:01 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >=20
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Extend backend features with new calls needed later on this
> > > patchset from axi version of ad3552r.
> > >=20
> > > The follwoing calls are added:
> > >=20
> > > iio_backend_ext_sync_enable
> > > 	enable synchronize channels on external trigger
> > > iio_backend_ext_sync_disable
> > > 	disable synchronize channels on external trigger
> > > iio_backend_ddr_enable
> > > 	enable ddr bus transfer
> > > iio_backend_ddr_disable
> > > 	disable ddr bus transfer
> > > iio_backend_set_bus_mode
> > > 	select the type of bus, so that specific read / write
> > > 	operations are performed accordingly
> > > iio_backend_buffer_enable
> > > 	enable buffer
> > > iio_backend_buffer_disable
> > > 	disable buffer
> > > iio_backend_data_transfer_addr
> > > 	define the target register address where the DAC sample
> > > 	will be written.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > Hi Angelo,
> > A few trivial comments inline.
> >=20
> > > ---
> > > =C2=A0drivers/iio/industrialio-backend.c | 111
> > > +++++++++++++++++++++++++++++++++++++
> > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 23 ++++++++
> > > =C2=A02 files changed, 134 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c
> > > b/drivers/iio/industrialio-backend.c
> > > index 20b3b5212da7..f4802c422dbf 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct device
> > > *dev, struct iio_backend *back)
> > ...
> >=20
> > > +/**
> > > + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate=
)
> > > mode
> > > + * @back: Backend device
> > > + *
> > > + * Disabling DDR data is generated byt the IP at rising or falling f=
ront
> >=20
> > Spell check your comments.
> >=20
> > > + * of the interface clock signal (SDR, Single Data Rate).
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_ddr_disable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, ddr_disable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> > 				 struct fwnode_handle *fwnode)
> > > =C2=A0{
> > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.=
h
> > > index 37d56914d485..41619b803cd6 100644
> > > --- a/include/linux/iio/backend.h
> > > +++ b/include/linux/iio/backend.h
> > > @@ -14,12 +14,14 @@ struct iio_dev;
> > > =C2=A0enum iio_backend_data_type {
> > > =C2=A0	IIO_BACKEND_TWOS_COMPLEMENT,
> > > =C2=A0	IIO_BACKEND_OFFSET_BINARY,
> > > +	IIO_BACKEND_DATA_UNSIGNED,
> > > =C2=A0	IIO_BACKEND_DATA_TYPE_MAX
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0enum iio_backend_data_source {
> > > =C2=A0	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
> > > =C2=A0	IIO_BACKEND_EXTERNAL,
> > > +	IIO_BACKEND_INTERNAL_RAMP_16BIT,
> > > =C2=A0	IIO_BACKEND_DATA_SOURCE_MAX
> > > =C2=A0};
> > > =C2=A0
> > > @@ -89,6 +91,13 @@ enum iio_backend_sample_trigger {
> > > =C2=A0 * @read_raw: Read a channel attribute from a backend device
> > > =C2=A0 * @debugfs_print_chan_status: Print channel status into a buff=
er.
> > > =C2=A0 * @debugfs_reg_access: Read or write register value of backend=
.
> > > + * @ext_sync_enable: Enable external synchronization.
> > > + * @ext_sync_disable: Disable external synchronization.
> > > + * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> > > + * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> > > + * @buffer_enable: Enable data buffer.
> > > + * @buffer_disable: Disable data buffer.
> >=20
> > This needs more specific text. What buffer?=C2=A0 I think this came
> > up earlier but it needs to say something about the fact it's enabling
> > or disabling the actual capture of data into the DMA buffers that
> > userspace will read.
> >=20
> > > + * @data_transfer_addr: Set data address.
> > > =C2=A0 **/
> > > =C2=A0struct iio_backend_ops {
> > > =C2=A0	int (*enable)(struct iio_backend *back);
> > > @@ -129,6 +138,13 @@ struct iio_backend_ops {
> > > =C2=A0					 size_t len);
> > > =C2=A0	int (*debugfs_reg_access)(struct iio_backend *back, unsigned i=
nt
> > > reg,
> > > =C2=A0				=C2=A0 unsigned int writeval, unsigned int
> > > *readval);
> > > +	int (*ext_sync_enable)(struct iio_backend *back);
> > I know we've done it this way for existing items, but I wonder if we sh=
ould
> > squish down the ops slightly and have new enable/disable pairs as
> > single functions.
> > 	int (*ext_sync_set_state)(struct iio_backend *back, bool enable);
> > etc.=C2=A0 If nothing else reduces how many things need documentation ;=
)
> >=20
> > Nuno, what do you think? Worth squashing these pairs into single
> > callbacks?
>=20
> I'm not a fan of combining enable and disable functions into one function=
.
>=20
> The implementation will pretty much always be:
>=20
> if (enabled) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* so stuff */
> } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* do other stuff */
> }
>=20
> Which just adds indent and makes code harder to read.
>=20

Hi Jonathan and David,

Yeah, I have this on my todo list and to be fair with Angelo, he already ha=
d
something like you're suggesting. I kind of asked him to postpone that so w=
e
don't have mixed styles in the file for now. Then I would convert them all.=
 My
plan would be to squash the .ops into one and then have inline
enable()/disable() helpers (at least for the current users in order to keep
things easier to convert).

As for David's comment, I see your point but one can always improve things =
a bit

if (enable) {
	/* do stuff */
	return;
}

/* do disable stuff */
return 0

I'm aware the above is always not that straight... but I do think there's a=
lways
ways to rearrange things a bit to make it better. Because even with the
enable()/disable() approach, if you start to have a lot of common code, lik=
ely
you'll add an helper function. In some cases, one can even add the helper r=
ight
away with an 'enable' argument effectively doing what is being suggested in
here. It always depends on the person implementing the ops :)

Anyways, I really don't have a strong feeling about this. I had in my mind =
to do
something like this. It feels that Jonathan would already be ok with it. If=
 it's
not that awful for David, I'll eventually send the patches (unless Angelo w=
ants
to take care if it in this series).

- Nuno S=C3=A1
>=20

