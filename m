Return-Path: <linux-iio+bounces-16202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B70A49F9B
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B4D169D83
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904201F0995;
	Fri, 28 Feb 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFBe+ny5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B191F0985;
	Fri, 28 Feb 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761959; cv=none; b=cFrIGO7pV2s+ywy8W1hM9QzcH32I6+KFilMXtAcs6XOz1mCx6tX6r3mYstM8x8gP5UUjJwFS52I2ImHsNVHnNfHV/dsnnwl2LRQnWeR4U3Cl0bb4MGLK/fc8w9vZaw5fcNmzlH+xcczDm7gOC3vn28YJLgVv2D6rdVDYkEd2mrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761959; c=relaxed/simple;
	bh=qOHi6yDNAQDvAh2OBX2mIKesEC+zW55DOff8GRvWCg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAKFnDp0JBQhltA2lhNf/7rA7ZCqg5LxzfsLhjQPMoV45LSw9LvfqcMkMmi+n1Zpxh6nJQ0xSWD5NO/0ozR15+9cWa8B3j0dhzW5fWEnDvLkQynIQ09syj4i3wfL695E1FLXaOxtPKgbPcQj7KFBGmMw4bbdTl7N07JbSxty9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFBe+ny5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C26C4AF09;
	Fri, 28 Feb 2025 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740761959;
	bh=qOHi6yDNAQDvAh2OBX2mIKesEC+zW55DOff8GRvWCg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vFBe+ny5ptgIJQELJvKn89Ugx6KnDBOPhrEyrHfs9HOSDBZmlcgBgRmR71kqGtjKh
	 C07djVodfYSYAFVJohZHLtJ9TTRuLy73cKn/oH8BDx4ijxHqwG1kkXJezGYbRng3sO
	 3Faq7MPtuOx/6wnxpz/qeU6iyXGfwzIDnocx6SSD+glc4fqgGxKRrUM/6tzvKBQLi3
	 ZW7jlkzsXb0DzGui4K8kVnGAma3uyL+EYw+rMqJTx5fBAeEPvlkhBWYFPSuDpBknTo
	 gAd84rrjtYkjXLzGyQn+0KeR2CTjhxbvKGqf9ZVn3f0uqRDKmW1ZWZfGKHwAmx14Q8
	 tm0y+QiIM/qgA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab744d5e567so401802266b.1;
        Fri, 28 Feb 2025 08:59:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiPt4vx06mZWsAhCStvF8pbrgtPgYbEg660HxAcPLoPwCWi1jtOEh3+NPVtK8Lutcpop/JUypEfmGgidIs@vger.kernel.org, AJvYcCUnwR6kQhWPu2peVFNvUyvby9oXwm7jfc826G0hTLwtlL/E/ON2Qy9LMzF/T5vnIfP/k4YJX37sJtLR8Q==@vger.kernel.org, AJvYcCV/8GR2w28vod9Ujkvtk08nQxVRycg533eVno+FT2NzRZcl6IErDLrbmKMhcRnIGY3pLZT8hyguZBFY@vger.kernel.org, AJvYcCV/L9Ygw78jzoTnijOe9w73txxY4jyW/Rd04zXAoB2X4TB4DPpJptXyPdh1wyMVeQUuOjlURyt/IuWv@vger.kernel.org, AJvYcCXSSFgRimCbDB7h6OUL8sJYblQpAyZSF1wkVzWGNQJko9Ww5RQqcrV7goNXhTy8k5k4ChmGDmZ5FqGScVnxSvY1aUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTmzwnRLF+PyFBrpJW69XrGgpQY8bThCtfwhDgkYg7FpCqmXv
	yYwlYawrsqkBDklP6pKn/kTLCpm6sK3Vrg657ML0loW7ZPqi1bKijYin79rNpYdd4eNRL7c0LGt
	2d6rW80I7nntzpuNu/a6667Vsxg==
X-Google-Smtp-Source: AGHT+IHA0zPRZLteCxoYig/yVyHsZYfuDj8GOG99a9h83rXOpmBqH7x7Q6QAw1T0TGyfEJFB+8YgmxVupI+GLspZlUw=
X-Received: by 2002:a17:907:7212:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-abf26430310mr376479566b.8.1740761957482; Fri, 28 Feb 2025
 08:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com> <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com> <Z72d7TzZ21WITW3f@smile.fi.intel.com>
 <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com> <Z73M3Ua6u1FpgBEK@smile.fi.intel.com>
 <720f9c69-ca1f-45cb-9f6e-c8e4703c9aad@gmail.com> <Z78g_uiXumn4mvET@smile.fi.intel.com>
 <d7982b76-3da7-47ff-b2b2-f964610af1f7@gmail.com> <Z8B7h4_IWz43gFhO@smile.fi.intel.com>
 <c9424f3e-1ff0-4c01-823a-19801cc3e7a7@gmail.com>
In-Reply-To: <c9424f3e-1ff0-4c01-823a-19801cc3e7a7@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Feb 2025 10:59:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tkXAAVK2D_AtENuXJZOF2eK=sUnjv3=7PM8nAyAB7Xw@mail.gmail.com>
X-Gm-Features: AQ5f1JoN6diiX-hK5SeGqaOY2e_sxsMHOrauD5SGgB18pP2IXFo3RXN1kEkkKSk
Message-ID: <CAL_Jsq+tkXAAVK2D_AtENuXJZOF2eK=sUnjv3=7PM8nAyAB7Xw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] property: Add device_get_child_node_count_named()
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols <gstols@baylibre.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:06=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> On 27/02/2025 16:49, Andy Shevchenko wrote:
> > On Thu, Feb 27, 2025 at 10:01:49AM +0200, Matti Vaittinen wrote:
> >> On 26/02/2025 16:11, Andy Shevchenko wrote:
> >>> On Wed, Feb 26, 2025 at 04:04:02PM +0200, Matti Vaittinen wrote:
> >>>> On 25/02/2025 15:59, Andy Shevchenko wrote:
> >>>>> On Tue, Feb 25, 2025 at 03:29:17PM +0200, Matti Vaittinen wrote:
> >>>>>> On 25/02/2025 12:39, Andy Shevchenko wrote:
> >>>>>>> On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
> >>>>>>>> On 25/02/2025 12:21, Andy Shevchenko wrote:
> >>>>>>>>> On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote=
:
> >
> > ...
> >
> >>>>>>>>>>
> >>>>>>>>>> I did not check how many users are you proposing for this, but=
 if
> >>>>>>>>>> there's only one, then IMO this should not be a global functio=
n yet.
> >>>>>>>>>> It just feels to special case to me. But let's see what the ot=
hers
> >>>>>>>>>> think.
> >>>>>>>>>
> >>>>>>>>> The problem is that if somebody hides it, we might potentially =
see
> >>>>>>>>> a duplication in the future. So I _slightly_ prefer to publish =
and
> >>>>>>>>> then drop that after a few cycles if no users appear.
> >>>>>>>>
> >>>>>>>> After taking a very quick grep I spotted one other existing plac=
e where we
> >>>>>>>> might be able to do direct conversion to use this function.
> >>>>>>>>
> >>>>>>>> drivers/net/ethernet/freescale/gianfar.c
> >>>>>>>>
> >>>>>>>> That'd be 2 users.
> >>>>>>>
> >>>>>>> I haven't checked myself, I believe your judgement,
> >>>>>>
> >>>>>> I took a better look and you obviously shouldn't believe :) The gi=
anfar used
> >>>>>> of_node instead of the fwnode. So, it'd be a single caller at star=
ters.
> >>>>>
> >>>>> ...which is the same as dev_of_node(), which means that you can use=
 your
> >>>>> function there.
> >>>>
> >>>> I'm unsure what you mean. The proposed function
> >>>> device_get_child_node_count_named() takes device pointer. I don't se=
e how
> >>>> dev_of_node() helps converting node to device?
> >>>
> >>> dev_of_node() takes the device pointer and dev_fwnode() takes that as=
 well,
> >>> it means that there is no difference which one to use OF-centric or f=
wnode
> >>
> >> The proposed device_get_child_node_count_named() takes a device pointe=
r. I
> >> don't see how dev_of_node() helps if there is just of_node and no devi=
ce
> >> pointer available in the calling code.
> >
> > ???
> >
> > The loops are working on
> >
> >       struct device_node *np =3D pdev->dev.np;
> >
> > which is the equivalent to
> >
> >       struct device_node *np =3D dev_of_node(&pdev->dev);
> >
> > which takes device pointer.
> >
> >> (Well, as I wrote below, I could
> >> alter the gianfar code by dropping the gfar_of_group_count(), so that =
I have
> >> the device pointer in caller). Anyways, I don't see how dev_of_node() =
should
> >> help unless you're proposing I add a of_get_child_node_count_named() o=
r
> >> somesuch - which I don't think makes sense.
> >
> > Are you forbidding yourself to change the function prototype to take a =
device
> > pointer instead of device_node one? :-)
> >
>
> This is our point of misunderstanding. As I wrote, and as you can see
> from the prototype, the function _is_ taking the device pointer. Hence I
> didn't understand how dev_of_node() should help us.
>
> >>> API in this particular case. Just make sure that the function (and th=
ere
> >>> is also a second loop AFAICS) takes struct device *dev instead of str=
uct
> >>> device_node *np as a parameter.
> >>
> >> I think I lost the track here :)
> >
> > Make gfar_of_group_count() to take device pointer. As simple as that.
>
> that'd just make the gfar_of_group_count() a wrapper of the
> of_get_child_node_count_named(). I prefer killing whole
> gfar_of_group_count().

Sigh. This is not that hard.

- unsigned int num_grps =3D gfar_of_group_count(np);
+ unsigned int num_grps =3D
device_get_child_node_count_named(&ofdev->dev, "queue-groups");

And remove gfar_of_group_count() of course.

Rob

