Return-Path: <linux-iio+bounces-22186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC28B18E17
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533F17AF6B0
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34A221555;
	Sat,  2 Aug 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeVj3od/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBF22069A;
	Sat,  2 Aug 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131989; cv=none; b=Xg97mITMgEBCuwCLSwMlPPbeFnRMonGFXh9NjPZt4qQmQHDVUfKjZBxJyY10FBbTxd0DMwyZw1OLN6hzQ38Ms0qY4FfRqHPXSap159SOFh/buNwPp5aSzivKXXAFcH5Yl40SVjuMTin0Z93eVZibk3r+9xJAyOKZLKiEcfaoGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131989; c=relaxed/simple;
	bh=1F2EMW1AyFMzN8saxljctdIQCLVlSmb/qnoWy+VqL3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmKmwMgo139iYHgtYkNRa1KYaYdYNEDkYFZ6mRp1iI+pO5Q/kA+1bmAWtdFU1FYK09BPF/BDdZa5SgkSXJ9kEbbOVzhhDLECjc/Hc8xmHScX6W3L/NnLKBd1uMk2GWJp9j3P4G7pit3H9W3mZ4rx8p3+u4/73zf+C5XU+nDa4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeVj3od/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E7EC4CEEF;
	Sat,  2 Aug 2025 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754131988;
	bh=1F2EMW1AyFMzN8saxljctdIQCLVlSmb/qnoWy+VqL3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeVj3od/6SkAUN+ymf44pK9yFjHzL69zIDYhOdE5l5gc9LG3/jn6wy59iLXcGEBDk
	 6RwiII2d5iCn8IY/gHjaXJ/En9NsEwHvTWe4WaC0yLjCxpHTCZWopAvwSGsuU7HKZi
	 unR1US8MYkjlDDhLNXS0I2d80neoFVcXKvBS8oMbLQCw+V7i9kQqDz2tG+NuwD0ewJ
	 uAUMKlzhiVC9k5M7LZ4YORe91QFjLG0GbS2KE0bBa00tF0bS8Z+xqENHvU4zXtqV1N
	 s/zb2ZG6clBWEnFKNTNv5spN96e83w14HkXw6tgRn3DiCvGeH9seDFEKvL/PXuYUjW
	 3dg/RryDX9R+w==
Date: Sat, 2 Aug 2025 11:53:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
Message-ID: <20250802115300.18a4481d@jic23-huawei>
In-Reply-To: <pblyblite64vy5ghk77crga5y6f2a6bmngtxu6rlqmq3p7rzxt@srquqhwt43nr>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-8-sean.anderson@linux.dev>
	<afc6aa6ad4b633f9d834acf933734985f14c5563.camel@gmail.com>
	<6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
	<9c6f99e022270b1b9c2f178f8f415270f11e59df.camel@gmail.com>
	<11735f77-25cc-4220-b7be-e6fda8f72161@linux.dev>
	<pblyblite64vy5ghk77crga5y6f2a6bmngtxu6rlqmq3p7rzxt@srquqhwt43nr>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Jul 2025 11:52:10 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, Jul 17, 2025 at 12:00:13PM -0400, Sean Anderson wrote:
> > On 7/16/25 02:37, Nuno S=C3=A1 wrote: =20
> > > On Tue, 2025-07-15 at 13:02 -0400, Sean Anderson wrote: =20
> > >> On 7/15/25 07:28, Nuno S=C3=A1 wrote: =20
> > >> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote: =20
> > >> > > Add alarm support based on IIO threshold events. The alarm is cl=
eared on
> > >> > > read, but will be set again if the condition is still present. T=
his is
> > >> > > detected by disabling and re-enabling the event. The same trick =
is done
> > >> > > when creating the attribute to detect already-triggered events.
> > >> > >=20
> > >> > > The alarms are updated by an event listener. To keep the notifie=
r call
> > >> > > chain short, we create one listener per iio device, shared acros=
s all
> > >> > > hwmon devices.
> > >> > >=20
> > >> > > To avoid dynamic creation of alarms, alarms for all possible eve=
nts are
> > >> > > allocated at creation. Lookup is done by a linear scan, as I exp=
ect
> > >> > > events to occur rarely. If performance becomes an issue, a binar=
y search
> > >> > > could be done instead (or some kind of hash lookup).
> > >> > >=20
> > >> > > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > >> > > ---
> > >> > >=20
> > >> > >  drivers/hwmon/iio_hwmon.c | 322 +++++++++++++++++++++++++++++++=
++++++-
> > >> > >  1 file changed, 321 insertions(+), 1 deletion(-)
> > >> > >=20
> > >> > > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon=
.c
> > >> > > index 3db4d4b30022..c963bc5452ba 100644
> > >> > > --- a/drivers/hwmon/iio_hwmon.c
> > >> > > +++ b/drivers/hwmon/iio_hwmon.c
> > >> > > @@ -8,6 +8,7 @@
> > >> > >  #include <linux/slab.h>
> > >> > >  #include <linux/mod_devicetable.h>
> > >> > >  #include <linux/module.h>
> > >> > > +#include <linux/notifier.h>
> > >> > >  #include <linux/err.h>
> > >> > >  #include <linux/platform_device.h>
> > >> > >  #include <linux/property.h>
> > >> > > @@ -15,7 +16,192 @@
> > >> > >  #include <linux/hwmon.h>
> > >> > >  #include <linux/hwmon-sysfs.h>
> > >> > >  #include <linux/iio/consumer.h>
> > >> > > +#include <linux/iio/events.h>
> > >> > > +#include <linux/iio/iio.h>
> > >> > >  #include <linux/iio/types.h>
> > >> > > +#include <uapi/linux/iio/events.h>
> > >> > > +
> > >> > > +/* Protects iio_hwmon_listeners and listeners' refcnt */
> > >> > > +DEFINE_MUTEX(iio_hwmon_listener_lock);
> > >> > > +LIST_HEAD(iio_hwmon_listeners);
> > >> > > +
> > >> > > +/**
> > >> > > + * struct iio_hwmon_listener - Listener for IIO events
> > >> > > + * @block: Notifier for events
> > >> > > + * @ids: Array of IIO event ids, one per alarm
> > >> > > + * @alarms: Bitmap of alarms
> > >> > > + * @num_alarms: Length of @ids and @alarms
> > >> > > + * @indio_dev: Device we are listening to
> > >> > > + * @list: List of all listeners
> > >> > > + * @refcnt: Reference count
> > >> > > + */
> > >> > > +struct iio_hwmon_listener {
> > >> > > +	struct notifier_block block;
> > >> > > +	u64 *ids;
> > >> > > +	unsigned long *alarms;
> > >> > > +	size_t num_alarms;
> > >> > > +
> > >> > > +	struct iio_dev *indio_dev;
> > >> > > +	struct list_head list;
> > >> > > +	unsigned int refcnt;
> > >> > > +};
> > >> > > +
> > >> > > +/**
> > >> > > + * iio_hwmon_lookup_alarm() - Find an alarm by id
> > >> > > + * @listener: Event listener
> > >> > > + * @id: IIO event id
> > >> > > + *
> > >> > > + * Return: index of @id in @listener->ids, or -1 if not found
> > >> > > + */
> > >> > > +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener=
 *listener,
> > >> > > +				      u64 id)
> > >> > > +{
> > >> > > +	ssize_t i;
> > >> > > +
> > >> > > +	for (i =3D 0; i < listener->num_alarms; i++)
> > >> > > +		if (listener->ids[i] =3D=3D id)
> > >> > > +			return i;
> > >> > > +
> > >> > > +	return -1;
> > >> > > +}
> > >> > > +
> > >> > > +static int iio_hwmon_listener_callback(struct notifier_block *b=
lock,
> > >> > > +				       unsigned long action, void *data)
> > >> > > +{
> > >> > > +	struct iio_hwmon_listener *listener =3D
> > >> > > +		container_of(block, struct iio_hwmon_listener, block);
> > >> > > +	struct iio_event_data *ev =3D data;
> > >> > > +	ssize_t i;
> > >> > > +
> > >> > > +	if (action !=3D IIO_NOTIFY_EVENT)
> > >> > > +		return NOTIFY_DONE;
> > >> > > +
> > >> > > +	i =3D iio_hwmon_lookup_alarm(listener, ev->id);
> > >> > > +	if (i >=3D 0)
> > >> > > +		set_bit(i, listener->alarms);
> > >> > > +	else
> > >> > > +		dev_warn_once(&listener->indio_dev->dev,
> > >> > > +			      "unknown event %016llx\n", ev->id);
> > >> > > +
> > >> > > +	return NOTIFY_DONE;
> > >> > > +}
> > >> > > +
> > >> > > +/**
> > >> > > + * iio_event_id() - Calculate an IIO event id
> > >> > > + * @channel: IIO channel for this event
> > >> > > + * @type: Event type (theshold, rate-of-change, etc.)
> > >> > > + * @dir: Event direction (rising, falling, etc.)
> > >> > > + *
> > >> > > + * Return: IIO event id corresponding to this event's IIO id
> > >> > > + */
> > >> > > +static u64 iio_event_id(struct iio_chan_spec const *chan,
> > >> > > +			enum iio_event_type type,
> > >> > > +			enum iio_event_direction dir)
> > >> > > +{
> > >> > > +	if (chan->differential)
> > >> > > +		return IIO_DIFF_EVENT_CODE(chan->type, chan->channel,
> > >> > > +					   chan->channel2, type, dir);
> > >> > > +	if (chan->modified)
> > >> > > +		return IIO_MOD_EVENT_CODE(chan->type, chan->channel,
> > >> > > +					  chan->channel2, type, dir);
> > >> > > +	return IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, d=
ir);
> > >> > > +}
> > >> > > +
> > >> > > +/**
> > >> > > + * iio_hwmon_listener_get() - Get a listener for an IIO device
> > >> > > + * @indio_dev: IIO device to listen to
> > >> > > + *
> > >> > > + * Look up or create a new listener for @indio_dev. The returne=
d listener is
> > >> > > + * registered with @indio_dev, but events still need to be manu=
ally enabled.
> > >> > > + * You must call iio_hwmon_listener_put() when you are done.
> > >> > > + *
> > >> > > + * Return: Listener for @indio_dev, or an error pointer
> > >> > > + */
> > >> > > +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct=
 iio_dev
> > >> > > *indio_dev)
> > >> > > +{
> > >> > > +	struct iio_hwmon_listener *listener;
> > >> > > +	int err =3D -ENOMEM;
> > >> > > +	size_t i, j;
> > >> > > +
> > >> > > +	guard(mutex)(&iio_hwmon_listener_lock);
> > >> > > +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
> > >> > > +		if (listener->indio_dev =3D=3D indio_dev) {
> > >> > > +			if (likely(listener->refcnt !=3D UINT_MAX))
> > >> > > +				listener->refcnt++; =20
> > >> >=20
> > >> > I dunno for the above to ever happen :). =20
> > >>=20
> > >> Well, I can remove it if you like.
> > >>  =20
> > >> > And as Andy stated, let's just use proper refcount APIs. =20
> > >>=20
> > >> No point in using atomic ops if they are only accessed under a mutex=
. =20
> > >=20
> > > Not the point... If there are proper APIs for handling things like th=
is, not sure why
> > > not using and then coming up with things like the above? And the same=
 goes to the
> > > release path. =20
> >=20
> > The API is for doing reference counts *atomically*. If you do not need
> > atomic reference counting, then it is the *wrong* API. I suggest readin=
g =20
>=20
> Well, It won't make your code wrong. It's just about re-using what we hav=
e already.
> But my main complain was about having your own saturation checks in here.
> I also dislike the release path where you do have to explicitly check for=
 0 to
> call the cleanup API. That is all handled already. Not to mention that it=
 is a fairly
> common pattern to use these APIs even if you don't really __need__ it's a=
tomicity.=20
>=20
> > the block comment at the beginning of refcnt.h to see the sorts of
> > contortions it has to go through because it is an atomic API. Since we =
=20
>=20
> And? It's very well hidden in the API... This is also not a fastpath at
> all so performance is also not a concern AFAICT.
>=20
> Up to the maintainers anyways but I cannot say I agree with it. So, I
> guess we can agree in disagreeing :)

I'd prefer using the standard refcount API.  Sure it's not a performant
choice in all cases, but it wins on basis of familiarity and reduced
burden to review and maintenance.

Jonathan

>=20
> - Nuno S=C3=A1
>=20


