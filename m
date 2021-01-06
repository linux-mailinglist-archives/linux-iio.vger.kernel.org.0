Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132E62EB981
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jan 2021 06:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbhAFFaQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jan 2021 00:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAFFaP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jan 2021 00:30:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B89C06134C;
        Tue,  5 Jan 2021 21:29:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s15so981426plr.9;
        Tue, 05 Jan 2021 21:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hOGze9DgXpm0gt+vBnhQVhta/mGdE6h/HGR0vUoYLzc=;
        b=OHUCL11vF4yJqF64mxEIhfOQvKfdNwwAwJ/aCx+33nhEqrfzg9jMeYeaHMH2xuTLAG
         esVUtQtrOWI84nm6dBn6WhdXD+Ii69/WoV65dN7hYF6dGYW/S4ZtCJGFWVbUytKO7ExN
         pziyWfvjvVGFa9Iu4hP+x4JoZvT+30SmFMyngUtnhM9gn3UifsJKxUExYjMCnl8JZJ4e
         gI+MZfLzb3nAlHIQuIooylomnU8G65qHg+BsiMaZO8t7S4yheZ1EqcuB/GJRQrqBderm
         yzdi88ZDfcl1YznHrt7J2RlawO1K3k13aqKUibh+mQ1Yj/rL0NnGaRcd9XIEuWuCcS/y
         x3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hOGze9DgXpm0gt+vBnhQVhta/mGdE6h/HGR0vUoYLzc=;
        b=jmS4ecU4rjpBWY+ja9zB8P0TdmEg7Oi9aWGsWZTUc5jt95mzNGHEJPx6rXuRlrzYUq
         BIr/AVDLeN+quBRJji2UOYpELYgsYkinzFZGk3SGEx9YqUm178JBNYAJHUQYVkOojtQi
         zJiq8gr4kn/ptV8ZSXDG5RTz+GY34PDRFjUAV1GsvSZEyiTmaib/ZbrVjY7lx0xRfeJm
         b8c+7ueH7mNtEtvLHomRIQOoLfwCzehTv4251G+5RFHqLuCEW/EsPMxs8GWXg6Jz4ofM
         LJ15iFO1kzQT+5lOBI1DT9PpIJ8WwKcSdMew148nA1G7XQCY7JXJDDVz7bwkODfCJeLJ
         7VjA==
X-Gm-Message-State: AOAM530h3VtQWpXKuc9BpLo6T2RygvVSbDH9lc0eC5OfNrS5eVoCpWRM
        TUlNLZefP2BEnChhgPvYNA4=
X-Google-Smtp-Source: ABdhPJyTza6OFX58O1ZtxKbuFduSV3nk0HA/uLR752GboGjO7C9zQWW2xXABJQa8YI+aD7xHDPH8Lg==
X-Received: by 2002:a17:90b:4b06:: with SMTP id lx6mr2579783pjb.224.1609910974430;
        Tue, 05 Jan 2021 21:29:34 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id t1sm908329pfg.212.2021.01.05.21.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 21:29:33 -0800 (PST)
Date:   Wed, 6 Jan 2021 14:29:23 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 1/5] counter: Internalize sysfs interface code
Message-ID: <X/VKsxuYGkgMhx80@shinobu>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <fc40ab7f4a38e80d86715daa5eaf744dd645a75b.1608935587.git.vilhelm.gray@gmail.com>
 <20201230143719.28a90914@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sk+7ExK6E/6TxWPH"
Content-Disposition: inline
In-Reply-To: <20201230143719.28a90914@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--sk+7ExK6E/6TxWPH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 02:37:19PM +0000, Jonathan Cameron wrote:
> On Fri, 25 Dec 2020 19:15:34 -0500
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > This is a reimplementation of the Generic Counter driver interface.
> > There are no modifications to the Counter subsystem userspace interface,
> > so existing userspace applications should continue to run seamlessly.
> Hi William
>=20
> Been a while since I looked at this series.  Its rather big and I'm lazy
> (or busy depending on who I'm talking to :)
>=20
> Hmm. I'm a bit in two minds about how you should handle the huge amount of
> description here.  Some of it clearly belongs in the kernel docs (and some
> is I think put there in a later patch).  Other parts are specific to
> this series, but I'm not 100% sure this much detail is really useful in t=
he
> git log.   Note that we now have links to the threads for all patches app=
lied
> using b4 (which this will be) so it's fine to have really detailed stuff
> in cover letters rather than the individual patches.

I'll simplify the description here to something more succinct.

> One thing that would be handy for review, might be if you put up a tree
> somewhere with this applied and included a link.

This is such a large set of changes that having a tree to checkout for
review would be convenient. I typically push to my personal tree, so you
can check out the changes there in the counter_chrdev_v* branches:
https://gitlab.com/vilhelmgray/iio

I'll include a link to it again in the cover letter for v8 when it's
ready.

> Mind you I don't feel that strongly about it if it you do want to maintain
> it in the individual patch descriptions.
>=20
> I've been a bit lazy and not cropped this down as much as I ideally should
> have done (to include only bits I'm commenting on).
>=20
> Anyhow, various minor things inline but this fundamentally looks fine to =
me.
>=20
> Jonathan
>=20
>=20
> >=20
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > The purpose of this patch is to internalize the sysfs interface code
> > among the various counter drivers into a shared module. Counter drivers
> > pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> > module handles the translation between the sysfs interface.
>=20
> Confusing statement.  Between the sysfs interface and what?
> Perhaps "handles the translation to/from the sysfs interface."

Looks like I cut that line short by accident; it should read: "between
the sysfs interface and the device drivers". I'll fix this up.

> > This
> > guarantees a standard userspace interface for all counter drivers, and
> > helps generalize the Generic Counter driver ABI in order to support the
> > Generic Counter chrdev interface (introduced in a subsequent patch)
> > without significant changes to the existing counter drivers.
> >=20
> > A high-level view of how a count value is passed down from a counter
> > driver is exemplified by the following. The driver callbacks are first
> > registered to the Counter core component for use by the Counter
> > userspace interface components:
> >=20
> >                         +----------------------------+
> > 	                | Counter device driver      |
>=20
> Looks like something snuck a tab in amongst your spaces.

Ack.

> >  static int quad8_signal_read(struct counter_device *counter,
> > -	struct counter_signal *signal, enum counter_signal_value *val)
> > +			     struct counter_signal *signal,
> > +			     enum counter_signal_level *level)
> >  {
> >  	const struct quad8_iio *const priv =3D counter->priv;
> >  	unsigned int state;
> > @@ -633,13 +634,13 @@ static int quad8_signal_read(struct counter_devic=
e *counter,
> >  	state =3D inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
> >  		& BIT(signal->id - 16);
> > =20
> > -	*val =3D (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> > +	*level =3D (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL=
_LOW;
>=20
> This bit of refactoring / renaming could have been split out as a precurs=
or patch
> I think.  There may be other opportunities.=20

Ack. I'll look around for additional changes I can pull out as precursor
patches too.

> > =20
> >  	return 0;
> >  }
> > =20
> >  static int quad8_count_read(struct counter_device *counter,
> > -	struct counter_count *count, unsigned long *val)
> > +			    struct counter_count *count, u64 *val)
>=20
> Could the type change for val have been done as a precursor?

I don't think we can pull this one out as a precursor unfortunately.
Since unsigned long is passed in as pointer, we could get a type
mismatch if we're on a 32-bit system. For this to work, it requires the
u64 change in struct counter_ops and subsequent dependent code, so we'll
have to keep it as part of this patch for now.

> > @@ -785,18 +782,21 @@ static int quad8_function_set(struct counter_devi=
ce *counter,
> >  		*quadrature_mode =3D 1;
> > =20
> >  		switch (function) {
> > -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> > +		case COUNTER_FUNCTION_QUADRATURE_X1_A:
> >  			*scale =3D 0;
> >  			mode_cfg |=3D QUAD8_CMR_QUADRATURE_X1;
> >  			break;
> > -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> > +		case COUNTER_FUNCTION_QUADRATURE_X2_A:
> >  			*scale =3D 1;
> >  			mode_cfg |=3D QUAD8_CMR_QUADRATURE_X2;
> >  			break;
> > -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> > +		case COUNTER_FUNCTION_QUADRATURE_X4:
> >  			*scale =3D 2;
> >  			mode_cfg |=3D QUAD8_CMR_QUADRATURE_X4;
> >  			break;
> > +		default:
> > +			mutex_unlock(&priv->lock);
> > +			return -EINVAL;
>=20
> This looks like a sensible precaution / cleanup but could have been
> done separately to the rest of the patch I think?

Ack.

> > @@ -1229,30 +1194,28 @@ static ssize_t quad8_count_ceiling_write(struct=
 counter_device *counter,
> > =20
> >  	mutex_unlock(&priv->lock);
> > =20
> > -	return len;
> > +	return -EINVAL;
>=20
> ?  That looks like the good exit path to me.

You're right, this should be a return 0.

> > +/**
> > + * counter_register - register Counter to the system
> > + * @counter:	pointer to Counter to register
> > + *
> > + * This function registers a Counter to the system. A sysfs "counter" =
directory
> > + * will be created and populated with sysfs attributes correlating wit=
h the
> > + * Counter Signals, Synapses, and Counts respectively.
>=20
> Where easy to do it's worth documenting return values.

Ack.

> > +static void devm_counter_unregister(struct device *dev, void *res)
> > +{
> > +	counter_unregister(*(struct counter_device **)res);
>=20
> Rename this. It looks like it's a generic way of unwinding
> devm_counter_register which it is definitely not...

Ack.

> > +/**
> > + * struct counter_attribute - Counter sysfs attribute
> > + * @dev_attr:	device attribute for sysfs
> > + * @l:		node to add Counter attribute to attribute group list
> > + * @comp:	Counter component callbacks and data
> > + * @scope:	Counter scope of the attribute
> > + * @parent:	pointer to the parent component
> > + */
> > +struct counter_attribute {
> > +	struct device_attribute dev_attr;
> > +	struct list_head l;
> > +
> > +	struct counter_comp comp;
> > +	__u8 scope;
>=20
> Why not an enum?

This should be enum; I missed it from the previous revision.

> > +	switch (a->comp.type) {
> > +	case COUNTER_COMP_FUNCTION:
> > +		return sprintf(buf, "%s\n", counter_function_str[data]);
> > +	case COUNTER_COMP_SIGNAL_LEVEL:
> > +		return sprintf(buf, "%s\n", counter_signal_value_str[data]);
> > +	case COUNTER_COMP_SYNAPSE_ACTION:
> > +		return sprintf(buf, "%s\n", counter_synapse_action_str[data]);
> > +	case COUNTER_COMP_ENUM:
> > +		return sprintf(buf, "%s\n", avail->strs[data]);
> > +	case COUNTER_COMP_COUNT_DIRECTION:
> > +		return sprintf(buf, "%s\n", counter_count_direction_str[data]);
> > +	case COUNTER_COMP_COUNT_MODE:
> > +		return sprintf(buf, "%s\n", counter_count_mode_str[data]);
> > +	default:
>=20
> Perhaps move the below return sprintf() up here?

Ack.

> > +		break;
> > +	}
> > +
> > +	return sprintf(buf, "%u\n", (unsigned int)data);
> > +}
> > +
> > +static int find_in_string_array(u32 *const enum_item, const u32 *const=
 enums,
> > +				const size_t num_enums, const char *const buf,
> > +				const char *const string_array[])
>=20
> Please avoid defining such generically named functions.  High chance of a=
 clash
> with something that turns up in generic headers sometime in the future.

Ack.

> > +static ssize_t enums_available_show(const u32 *const enums,
> > +				    const size_t num_enums,
> > +				    const char *const strs[], char *buf)
> > +{
> > +	size_t len =3D 0;
> > +	size_t index;
> > +
> > +	for (index =3D 0; index < num_enums; index++)
> > +		len +=3D sprintf(buf + len, "%s\n", strs[enums[index]]);
>=20
> Probably better to add protections on overrunning the buffer to this.
> Sure it won't actually happen but that may not be obvious to someone read=
ing
> this code in future.
>=20
> Look at new sysfs_emit * family for this.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2efc459d06f1630001e3984854848a5647086232

Ack.

> > +static ssize_t counter_comp_available_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	const struct counter_count *const count =3D a->parent;
> > +	const struct counter_synapse *const synapse =3D a->comp.priv;
> > +	const struct counter_available *const avail =3D a->comp.priv;
> > +
> > +	switch (a->comp.type) {
> > +	case COUNTER_COMP_FUNCTION:
> > +		return enums_available_show(count->functions_list,
> > +					    count->num_functions,
> > +					    counter_function_str, buf);
> > +	case COUNTER_COMP_SYNAPSE_ACTION:
> > +		return enums_available_show(synapse->actions_list,
> > +					    synapse->num_actions,
> > +					    counter_synapse_action_str, buf);
> > +	case COUNTER_COMP_ENUM:
> > +		return strs_available_show(avail, buf);
> > +	case COUNTER_COMP_COUNT_MODE:
> > +		return enums_available_show(avail->enums, avail->num_items,
> > +					    counter_count_mode_str, buf);
> > +	default:
> > +		break;
>=20
> Might as well return -EINVAL; here

Ack.

> > +	/* Store list node */
> > +	list_add(&counter_attr->l, &group->attr_list);
> > +	group->num_attr++;
> > +
> > +	switch (comp->type) {
> > +	case COUNTER_COMP_FUNCTION:
> > +	case COUNTER_COMP_SYNAPSE_ACTION:
> > +	case COUNTER_COMP_ENUM:
> > +	case COUNTER_COMP_COUNT_MODE:
> > +		return counter_avail_attr_create(dev, group, comp, parent);
> > +	default:
> > +		break;
>=20
> return 0 in here.  Also add a comment on why it isn't an error.

Ack.

> > +static int counter_sysfs_synapses_add(struct counter_device *const cou=
nter,
> > +	struct counter_attribute_group *const group,
> > +	struct counter_count *const count)
> > +{
> > +	const __u8 scope =3D COUNTER_SCOPE_COUNT;
> > +	struct device *const dev =3D &counter->dev;
> > +	size_t i;
> > +	struct counter_synapse *synapse;
> > +	size_t id;
> > +	struct counter_comp comp;
> > +	int err;
> > +
> > +	/* Add each Synapse */
> > +	for (i =3D 0; i < count->num_synapses; i++) {
> Could reduce scope and make code a bit more readable by
> pulling
>=20
> struct counter_synapse *synapse;
> struct counter_comp comp;
> size_t id;
>=20
> and maybe other things in here.  Makes it clear their scope
> is just within this loop.

Ack.

> >  /**
> >   * struct counter_synapse - Counter Synapse node
> > - * @action:		index of current action mode
> >   * @actions_list:	array of available action modes
> >   * @num_actions:	number of action modes specified in @actions_list
> > - * @signal:		pointer to associated signal
> > + * @signal:		pointer to the associated Signal
>=20
> Might have been nice to pull the cases that were purely capitalization ou=
t as
> a separate patch immediately following this one. There aren't
> a huge number, but from a review point of view it's a noop patch
> so doesn't need the reviewer to be awake :)

Ack.

William Breathitt Gray

--sk+7ExK6E/6TxWPH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/1SqAACgkQhvpINdm7
VJIndQ/6Am6yxb8q8CFpvW0tp1/UlZUCwDYZEagvSmRXDQboQa8NZr0LAP3DzOKW
ZT8y6PI7XvI9foabuqf5JZsFsDh2ITOM0GSzfekRHkLWZ5Q9fsRrUH2Actt4IVns
itwKRzqYDAstn9rS8e+DizXgG53xMkgw/vArIKRCkTe61ww3zMxhvdqC1DGfqNfp
VbqlteY/xB1/zA06qSY76O34L5Qqe9mrzB7wepA/IegMrTCg1Tw8WhtpH5XnlW3o
jULZzLOaEOLWOwtruKDmBcB8QgWzyBv/mGfOjqjVN30v6+QTtAl+IcrKj/Ignf4f
qWD2ad5lHHUPYpiIEVgf+y0jDLxCV6n2qFJkXLk33YdvTrfZ2fNxVoZABRYhyqUG
Q4LEv5Eupq2mD8blZZ6MJKd1KGvkSYxNOgDKexTBCuOgVWoksVjGLtXazZTBs0UT
J0G+dxMNE7t594rbVXenOcFk10fsRw6b5jfWq4ZpJNNAKh5IxYMl5KPODNArdziO
mF9kfvCunFal5A6nG3EwnssGMVeQ76IZXBG32px7Yx+Sq7C05Bgn/+Qk+ordyJB4
hToilC5Djks+JzwHKKcveQGymUBcUbT3FfW8SIParMzxu9btlE9xrZLG1bxyOZwH
XMJROKVwkZtW9Dwpto8glpZ7Kci5d+OF0+bRDBVGJhTuED0jDws=
=AN0Y
-----END PGP SIGNATURE-----

--sk+7ExK6E/6TxWPH--
