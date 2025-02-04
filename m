Return-Path: <linux-iio+bounces-15023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85AA27FB8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 00:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBBD3A3257
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174B21B1A7;
	Tue,  4 Feb 2025 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKwivGzI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC520C034;
	Tue,  4 Feb 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712256; cv=none; b=KBVSDnKtIMNM36wIX4OQ5EGwWBFu8C32DaU3ogJGLkiWbUoYOSTh84vFbfOolq2j/2C8GCyYCKkKC82Y6gFp3cG2xeA4wP5L+cKSaycbtnHE8NG8+YUuWdYl8wysD0K+uzN6P+ybUkdCaLpmTm4JmG1jYysTBQElXhG5wpgO28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712256; c=relaxed/simple;
	bh=vAY8VLfiDAEQkW2QlXq5vU119DGdr5y1FVx5inPsSCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiGAocK+tW3qfHabs3f6Ha2Rs8+nOgYgT7Wuj57GR5gdVR3PdtWbchDcwh8F7kdU+DN8uajHrvRaRw7duqZQgKDc9tTARDbzIO4HRtBCgm04vobMckbi2S3qwIZVtrs3YR14XD6PRHpbrR7Y9HfD33Q1K6Wtu2K/Zi39712qYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKwivGzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B77C4CEDF;
	Tue,  4 Feb 2025 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738712255;
	bh=vAY8VLfiDAEQkW2QlXq5vU119DGdr5y1FVx5inPsSCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKwivGzIB7KSq8KgreBnpiCDIjWvwHPgeYknYhX3Kg9ltR4fZRZzNRDG51LxUu/Jc
	 gVAvk+DnI1G7ghRdVUhcmgy+fSsdLf9bcno5Bv7v7jXBceCtmhzs5AUY1sUDv5nQmH
	 p4lI5fHO8QVFY2PQ+XVxcFx55XQ94tgxGrBuADzVofn3/QM+FgFH0XGdyWdIxNLj3C
	 w6M0DUGXhf9Dp9h8DNfP3IoPo9dhQE15o1JgqD6yx88avgOIPGHR1pAuPwJdJIDIKO
	 cz2nGON1ELjxaDLMl0fywiP1a4s5FWAYHi+4z2zPXVJz8WFNQ9ABzFYk8RdectrZY/
	 qjS4w3OSQueIA==
Date: Wed, 5 Feb 2025 08:37:30 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, timestamp@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dipen Patel <dipenp@nvidia.com>, dlechner@baylibre.com
Subject: Re: [Q] Frequency & duty cycle measurement?
Message-ID: <Z6KkusvLFPcNvEfl@ishi>
References: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
 <Z5efcokgHix-k3lW@ishi>
 <dffc0f18-799a-4fc7-a6b5-2fa270e1fc58@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2a9wQicw+mxwAn3v"
Content-Disposition: inline
In-Reply-To: <dffc0f18-799a-4fc7-a6b5-2fa270e1fc58@prolan.hu>


--2a9wQicw+mxwAn3v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 02:59:20PM +0100, Cs=F3k=E1s Bence wrote:
> Hi William,
>=20
> On 2025. 01. 27. 16:00, William Breathitt Gray wrote:
> > If RA and RB are provided as a memory buffer on your device, you can
> > instead expose them via DEFINE_COUNTER_ARRAY_CAPTURE() such as the
> > ti-ecap-capture driver does, then perform your userspace computations
> > by utilizing those respective "capture" array attribute values (via
> > chrdev like the example above or alternatively via sysfs).
>=20
> Thanks for your extensive explanation! With DEFINE_COUNTER_ARRAY_CAPTURE(=
) I
> was able to expose RA and RB as
> `/sys/bus/counter/devices/counter0/count0/capture{0,1}`, and could verify
> that by replacing `devmem` calls with read()-reopen(), our PoC code still
> works. Now I want to use the chardev interface, but I couldn't find how to
> set up the watches appropriately. So far I have:
>=20
> 	{
> 		.component.type =3D COUNTER_COMPONENT_EXTENSION,
> 		// also tried COUNTER_COMPONENT_COUNT
> 		.component.scope =3D COUNTER_SCOPE_COUNT,
> 		.component.parent =3D 0,
> 		.component.id =3D X, // also tried this instead:
> 		// .channel =3D X,
> 		.event =3D COUNTER_EVENT_CAPTURE,
> 	},
>=20
> However, with this, the first read() never comes back.
>=20
> Bence

Hi Bence,

Are you still having trouble with this? Is "X" the
capture{0,1}_component_id value?

I apologize, the Generic Counter character device interface is
underdocumented so it can be a bit confusing at first; I'll submit a
patch improving the documentation later this cycle when I get a chance.
For now, let's walk through how to create an appropriate Counter watch
for the capture extension components you have.

The first step is to decide which event we'll monitor and on which
channel: we want to monitor Capture events so that's
COUNTER_EVENT_CAPTURE, and we want event channel 0 (n.b. 0 because
that's the channel parameter value passed to counter_push_event() in the
driver).

The next step is to choose the components you wish to watch: Count 0's
capture0 and capture1 extensions. So type is COUNTER_COMPONENT_EXTENSION
because we want to watch extensions, scope is COUNTER_SCOPE_COUNT
because we want Count extensions, and parent is 0 because we want
Count 0's Count extensions.

Finally, we need to set the component id for each extension. You get a
particular component's id by reading the respective *_component_id sysfs
attribute: so for capture{0,1} you would read capture{0,1}_component_id
respectively. These component id values potentially can change with
future driver updates, so for robustness your userspace application
should read the respective *_component_id sysfs attribute itself rather
than hardcoding the component id in the Counter watch.

However, for the sake of simplicity in this example, I'll assume the
component ids are 42 and 43 respectively for capture0 and capture1. That
gives us the following two watches:

        {
                .component.type =3D COUNTER_COMPONENT_EXTENSION,
                .component.scope =3D COUNTER_SCOPE_COUNT,
                .component.parent =3D 0,
                .component.id =3D 42,
                .event =3D COUNTER_EVENT_CAPTURE,
                .channel =3D 0,
        },
        {
                .component.type =3D COUNTER_COMPONENT_EXTENSION,
                .component.scope =3D COUNTER_SCOPE_COUNT,
                .component.parent =3D 0,
                .component.id =3D 43,
                .event =3D COUNTER_EVENT_CAPTURE,
                .channel =3D 0,
        },

Does this resolve your chardev read issue? If you're still having
troubling, just let me know and we can troubleshoot further to figure
out what's going on.

William Breathitt Gray

--2a9wQicw+mxwAn3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ6KkugAKCRC1SFbKvhIj
KyJaAQCCZ5Mnusdt0BDtO1DMxjwY6w6GX5ZblIIVbjUWAzAvIQD9E7WICJ4aGJSf
5ohM1mSLRyf1qHJCM1IvPkVSD/qZrwg=
=2fNK
-----END PGP SIGNATURE-----

--2a9wQicw+mxwAn3v--

