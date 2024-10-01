Return-Path: <linux-iio+bounces-9970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697798C570
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690FE1C25C2E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA01CCB26;
	Tue,  1 Oct 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFxoa5Y/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D91CB321;
	Tue,  1 Oct 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807574; cv=none; b=TfnA50WtU1Kg4IPNrbwax55UwzlkIR//Qb65fsXV0p2xzj184/oqEwk//Ax3zBNJZvjl7FRZgAe6O3gN4x963vgx7NJf5MXbtS8chsKp+nrTXCupyxDA7xGz3/66FtFwGGS+iKz0eugIS8U0Baf11bjcZfer+l6j3W0LvmkD2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807574; c=relaxed/simple;
	bh=d23Q00gU+FeycgK4tDLG1W5Ncp40bUeGPY6agYfsGUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZW4spKfTMgtU33DOoPlXCRrTr9+0ooGmt9rGXE0cdB1Q2txs3x27OmYX5GLxVLhWTqFhZVZXfADf5nI+2n2BTef3R9fnmlWMtY7J2fIZ8ZGNlEyrVdTMYfQE6WfB7Z33bwAJSgUEUPduPze0SkUulIPevx3anqEemwDQx+p00oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFxoa5Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D316C4CEC6;
	Tue,  1 Oct 2024 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727807574;
	bh=d23Q00gU+FeycgK4tDLG1W5Ncp40bUeGPY6agYfsGUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CFxoa5Y/ISG8+4SVhk+d/qGfIHfTgybr8sOvrxJ93M5LNrvfbWc0kM9mrZZgZd38S
	 VN4w8CIgboOcwKrePIU75cXFHvQES3pr13+b2zBh0nBryiC8hbBzGFkp/v6u6ARvcW
	 R4IGK5ZQDuS1MnL9XgIzF//qF7UHwQ9bx1z6RstSvilwSJ/hd0K/Xs9vNB94X4X/UK
	 IZ1YJaP6QkanxN6jIdl5fkIp0mPzRaofrxqvCxPSYTXUPJ3Kstwx/cdOiy3o4PKrmg
	 q9LJf1yb+kPZdRfhzc52SmJrtqNdH+vfWi8ywlgCjpmTTa8Pj3B24wXF1BeK714oyQ
	 xw233mtnzeqyQ==
Date: Tue, 1 Oct 2024 19:32:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
Message-ID: <20241001193244.4503b667@jic23-huawei>
In-Reply-To: <urf6tm7iosewgb42cd6q3ssx2hjaysuzhk2weu4xmoq5xsm7ir@hvwb7qgxko2h>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
	<20240929120535.6b41c37e@jic23-huawei>
	<c9e30ebf-c661-4345-87bd-3169b57175fc@baylibre.com>
	<3370ba6d9a6bb8da5ca1415c354a6076de6f1d79.camel@gmail.com>
	<urf6tm7iosewgb42cd6q3ssx2hjaysuzhk2weu4xmoq5xsm7ir@hvwb7qgxko2h>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Oct 2024 10:35:17 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 01.10.2024 10:14, Nuno S=C3=A1 wrote:
> > On Mon, 2024-09-30 at 14:25 -0500, David Lechner wrote: =20
> > > On 9/29/24 6:05 AM, Jonathan Cameron wrote: =20
> > > > On Thu, 19 Sep 2024 11:20:01 +0200
> > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > >  =20
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >=20
> > > > > Extend backend features with new calls needed later on this
> > > > > patchset from axi version of ad3552r.
> > > > >=20
> > > > > The follwoing calls are added:
> > > > >=20
> > > > > iio_backend_ext_sync_enable
> > > > > 	enable synchronize channels on external trigger
> > > > > iio_backend_ext_sync_disable
> > > > > 	disable synchronize channels on external trigger
> > > > > iio_backend_ddr_enable
> > > > > 	enable ddr bus transfer
> > > > > iio_backend_ddr_disable
> > > > > 	disable ddr bus transfer
> > > > > iio_backend_set_bus_mode
> > > > > 	select the type of bus, so that specific read / write
> > > > > 	operations are performed accordingly
> > > > > iio_backend_buffer_enable
> > > > > 	enable buffer
> > > > > iio_backend_buffer_disable
> > > > > 	disable buffer
> > > > > iio_backend_data_transfer_addr
> > > > > 	define the target register address where the DAC sample
> > > > > 	will be written.
> > > > >=20
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com> =20
> > > > Hi Angelo,
> > > > A few trivial comments inline.
> > > >  =20
> > > > > ---
> > > > > =C2=A0drivers/iio/industrialio-backend.c | 111
> > > > > +++++++++++++++++++++++++++++++++++++
> > > > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 23 ++++++++
> > > > > =C2=A02 files changed, 134 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > b/drivers/iio/industrialio-backend.c
> > > > > index 20b3b5212da7..f4802c422dbf 100644
> > > > > --- a/drivers/iio/industrialio-backend.c
> > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct de=
vice
> > > > > *dev, struct iio_backend *back) =20
> > > > ...
> > > >  =20
> > > > > +/**
> > > > > + * iio_backend_ddr_disable - Disable interface DDR (Double Data =
Rate)
> > > > > mode
> > > > > + * @back: Backend device
> > > > > + *
> > > > > + * Disabling DDR data is generated byt the IP at rising or falli=
ng front =20
> > > >=20
> > > > Spell check your comments.
> > > >  =20
> > > > > + * of the interface clock signal (SDR, Single Data Rate).
> > > > > + *
> > > > > + * RETURNS:
> > > > > + * 0 on success, negative error number on failure.
> > > > > + */
> > > > > +int iio_backend_ddr_disable(struct iio_backend *back)
> > > > > +{
> > > > > +	return iio_backend_op_call(back, ddr_disable);
> > > > > +}
> > > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND); =20
> > > > 				 struct fwnode_handle *fwnode) =20
> > > > > =C2=A0{
> > > > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/back=
end.h
> > > > > index 37d56914d485..41619b803cd6 100644
> > > > > --- a/include/linux/iio/backend.h
> > > > > +++ b/include/linux/iio/backend.h
> > > > > @@ -14,12 +14,14 @@ struct iio_dev;
> > > > > =C2=A0enum iio_backend_data_type {
> > > > > =C2=A0	IIO_BACKEND_TWOS_COMPLEMENT,
> > > > > =C2=A0	IIO_BACKEND_OFFSET_BINARY,
> > > > > +	IIO_BACKEND_DATA_UNSIGNED,
> > > > > =C2=A0	IIO_BACKEND_DATA_TYPE_MAX
> > > > > =C2=A0};
> > > > > =C2=A0
> > > > > =C2=A0enum iio_backend_data_source {
> > > > > =C2=A0	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
> > > > > =C2=A0	IIO_BACKEND_EXTERNAL,
> > > > > +	IIO_BACKEND_INTERNAL_RAMP_16BIT,
> > > > > =C2=A0	IIO_BACKEND_DATA_SOURCE_MAX
> > > > > =C2=A0};
> > > > > =C2=A0
> > > > > @@ -89,6 +91,13 @@ enum iio_backend_sample_trigger {
> > > > > =C2=A0 * @read_raw: Read a channel attribute from a backend device
> > > > > =C2=A0 * @debugfs_print_chan_status: Print channel status into a =
buffer.
> > > > > =C2=A0 * @debugfs_reg_access: Read or write register value of bac=
kend.
> > > > > + * @ext_sync_enable: Enable external synchronization.
> > > > > + * @ext_sync_disable: Disable external synchronization.
> > > > > + * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> > > > > + * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> > > > > + * @buffer_enable: Enable data buffer.
> > > > > + * @buffer_disable: Disable data buffer. =20
> > > >=20
> > > > This needs more specific text. What buffer?=C2=A0 I think this came
> > > > up earlier but it needs to say something about the fact it's enabli=
ng
> > > > or disabling the actual capture of data into the DMA buffers that
> > > > userspace will read.
> > > >  =20
> > > > > + * @data_transfer_addr: Set data address.
> > > > > =C2=A0 **/
> > > > > =C2=A0struct iio_backend_ops {
> > > > > =C2=A0	int (*enable)(struct iio_backend *back);
> > > > > @@ -129,6 +138,13 @@ struct iio_backend_ops {
> > > > > =C2=A0					 size_t len);
> > > > > =C2=A0	int (*debugfs_reg_access)(struct iio_backend *back, unsign=
ed int
> > > > > reg,
> > > > > =C2=A0				=C2=A0 unsigned int writeval, unsigned int
> > > > > *readval);
> > > > > +	int (*ext_sync_enable)(struct iio_backend *back); =20
> > > > I know we've done it this way for existing items, but I wonder if w=
e should
> > > > squish down the ops slightly and have new enable/disable pairs as
> > > > single functions.
> > > > 	int (*ext_sync_set_state)(struct iio_backend *back, bool enable);
> > > > etc.=C2=A0 If nothing else reduces how many things need documentati=
on ;)
> > > >=20
> > > > Nuno, what do you think? Worth squashing these pairs into single
> > > > callbacks? =20
> > >=20
> > > I'm not a fan of combining enable and disable functions into one func=
tion.
> > >=20
> > > The implementation will pretty much always be:
> > >=20
> > > if (enabled) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* so stuff */
> > > } else {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* do other stuff */
> > > }
> > >=20
> > > Which just adds indent and makes code harder to read.
> > >  =20
> >=20
> > Hi Jonathan and David,
> >=20
> > Yeah, I have this on my todo list and to be fair with Angelo, he alread=
y had
> > something like you're suggesting. I kind of asked him to postpone that =
so we
> > don't have mixed styles in the file for now. Then I would convert them =
all. My
> > plan would be to squash the .ops into one and then have inline
> > enable()/disable() helpers (at least for the current users in order to =
keep
> > things easier to convert).
> >=20
> > As for David's comment, I see your point but one can always improve thi=
ngs a bit
> >=20
> > if (enable) {
> > 	/* do stuff */
> > 	return;
> > }
> >=20
> > /* do disable stuff */
> > return 0
> >=20
> > I'm aware the above is always not that straight... but I do think there=
's always
> > ways to rearrange things a bit to make it better. Because even with the
> > enable()/disable() approach, if you start to have a lot of common code,=
 likely
> > you'll add an helper function. In some cases, one can even add the help=
er right
> > away with an 'enable' argument effectively doing what is being suggeste=
d in
> > here. It always depends on the person implementing the ops :)
> >=20
> > Anyways, I really don't have a strong feeling about this. I had in my m=
ind to do
> > something like this. It feels that Jonathan would already be ok with it=
. If it's
> > not that awful for David, I'll eventually send the patches (unless Ange=
lo wants
> > to take care if it in this series).
> > =20
>=20
> I agree a single function for enable/disable may be good, reducing the ca=
lls and
> also the code size should benefit of some few bytes.

Normally I'd be on David's side on this but I don't really want to end up
with hundreds of callbacks (vs a single hundred). Thinking more about it, m=
aybe
I don't care about keeping them split.

>=20
> Honestly, i would not do this in this patchset since i am a bit in diffic=
ulties
> to have this job accepted as is, and also cannot retest all of them prope=
rly
> right now.

That's fine given it's an open question on whether it is even a good idea
and not really related to your work here.

Jonathan

> =20
> > - Nuno S=C3=A1 =20
> > >  =20
>=20


