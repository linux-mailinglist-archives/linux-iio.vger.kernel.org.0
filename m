Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A963092C6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 10:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhA3FCq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 00:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhA3FA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2021 00:00:27 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC2C061573;
        Fri, 29 Jan 2021 20:59:42 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so7537259pfk.1;
        Fri, 29 Jan 2021 20:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iuWsF8GDl/hi9MxuXzy2n4gX9Xml0dieu92Tb2P0Obw=;
        b=uuAZ7w9gMS/po3hziG54J7JhVOhSPc9YguELWtu4lK2bZIBX1QQHUlgf8TfbqITj+W
         +X+I/w+67aHJClZC/822/6x3fYwgBvw61vF9dzhyJrxTPuRGG1Nlc8/T1aZsuT2aU/u5
         pfcT72QnFyByl1pftmipjHpIGilcjirPJ76LYLqVcLRiTyatBfAyqAFBg5rI4VqBR660
         QNCIb8Z+osMJ1XZYYuCgiel8pgG3HASC8VlubOLBXtOE0FfTFVvJsom4zocaWLNPGCJN
         ZlOIeqkc4Y7GXPNO4Q/lxT3DcVEfZ4Dhe/auKmkOlunOB+uLfSmtyI/urM3IpYX49kz6
         96Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iuWsF8GDl/hi9MxuXzy2n4gX9Xml0dieu92Tb2P0Obw=;
        b=HZN1wxVd52CramPKt7Va9KuvPexzVye6g74dJB6NOvuCnNlgchnQBh92rey4OyLqC7
         Kg+b5I1Ao0RUjebv53+Jzueeq61Uit2x3lW4lhCAcwqFEEbyyOA+8TA9eKuTeoANF6pp
         21BhunUZIXpnrg5Gqtow3Ym3Yc8AlBqULWdgp+m5mGhLxzZ+ubr5/j+TCUIft1gOSkcY
         3yEGaGbDEn/RQE6w4oUuAxVdMqQEcWgyebR27z8EuI2j36tEVECz7Jb8tz+EJetvAULq
         R0JzodWAAQqjSY97dczJRr5zXOpNvJeu6A7VDWEWVXcmaA/hl40A4+WQfr9AIoM+FXKT
         HgKQ==
X-Gm-Message-State: AOAM530dNj/AEOricZtx+5K29cI9v7zosRRc1Gm6T2og594jkuUU56eN
        r3iQbWfIixO8N916xRWc0Z4=
X-Google-Smtp-Source: ABdhPJwKSxuQV6xtbs3H20e4fo5ykBo6wQEM2X4e8TrZUG+ZaQQVEgQZpBjCyI1pZchR5sLW4mv+rA==
X-Received: by 2002:a63:33c4:: with SMTP id z187mr7777053pgz.312.1611982782449;
        Fri, 29 Jan 2021 20:59:42 -0800 (PST)
Received: from shinobu (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id l2sm9463930pju.25.2021.01.29.20.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 20:59:41 -0800 (PST)
Date:   Sat, 30 Jan 2021 13:59:31 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 3/5] counter: Add character device interface
Message-ID: <YBTns6IzaNUrMSsq@shinobu>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <57bc509273bf288d74835e6ebdaebf27b4991888.1608935587.git.vilhelm.gray@gmail.com>
 <e9102ed7-d4e1-0c81-96f3-8d3c297d037f@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ELMJ14pDjrGcIjMp"
Content-Disposition: inline
In-Reply-To: <e9102ed7-d4e1-0c81-96f3-8d3c297d037f@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ELMJ14pDjrGcIjMp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 03:36:35PM -0600, David Lechner wrote:
> On 12/25/20 6:15 PM, William Breathitt Gray wrote:
>=20
> > diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> > new file mode 100644
> > index 000000000000..7585dc9db19d
> > --- /dev/null
> > +++ b/include/uapi/linux/counter.h
> > @@ -0,0 +1,123 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Userspace ABI for Counter character devices
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#ifndef _UAPI_COUNTER_H_
> > +#define _UAPI_COUNTER_H_
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +/* Component type definitions */
> > +enum counter_component_type {
> > +	COUNTER_COMPONENT_NONE,
> > +	COUNTER_COMPONENT_SIGNAL,
> > +	COUNTER_COMPONENT_COUNT,
> > +	COUNTER_COMPONENT_FUNCTION,
> > +	COUNTER_COMPONENT_SYNAPSE_ACTION,
> > +	COUNTER_COMPONENT_EXTENSION,
> > +};
> > +
> > +/* Component scope definitions */
> > +enum counter_scope {
>=20
> Do we need COUNTER_SCOPE_NONE to go with COUNTER_COMPONENT_NONE?

COUNTER_COMPONENT_NONE alone should be fine because it already indicates
that the 'component' member of the struct counter_watch is to be ignored
(i.e. type, scope, etc. will not be evaluated and that section of code
is bypassed).

> > +	COUNTER_SCOPE_DEVICE,
> > +	COUNTER_SCOPE_SIGNAL,
> > +	COUNTER_SCOPE_COUNT,
> > +};
> > +
> > +/**
> > + * struct counter_component - Counter component identification
> > + * @type: component type (Count, extension, etc.)
>=20
> Instead of "Count, extension, etc.", it could be more helpful
> to say one of enum counter_component_type.

Ack.

> > + * @scope: component scope (Device, Count, or Signal)
>=20
> Same here. @scope must be one of enum counter_scope.

Ack.

> > + * @parent: parent component identification number
> > + * @id: component identification number
>=20
> It could be helpful to say that these id numbers match
> the X/Y/Z in the sysfs paths as described in the sysfs
> ABI.

Ack.

> > + */
> > +struct counter_component {
> > +	__u8 type;
> > +	__u8 scope;
> > +	__u8 parent;
> > +	__u8 id;
> > +};
> > +
> > +/* Event type definitions */
> > +enum counter_event_type {
> > +	COUNTER_EVENT_OVERFLOW,
> > +	COUNTER_EVENT_UNDERFLOW,
> > +	COUNTER_EVENT_OVERFLOW_UNDERFLOW,
> > +	COUNTER_EVENT_THRESHOLD,
> > +	COUNTER_EVENT_INDEX,
> > +};
> > +
> > +/**
> > + * struct counter_watch - Counter component watch configuration
> > + * @component: component to watch when event triggers
> > + * @event: event that triggers
>=20
> It would be helpful to say that @event must be one of
> enum counter_event_type.

Ack.

> > + * @channel: event channel
>=20
> It would be useful to say that @channel should be 0 unless
> a component has more than one event of the same type.

I'll make this clearer.

> > + */
> > +struct counter_watch {
> > +	struct counter_component component;
> > +	__u8 event;
> > +	__u8 channel;
> > +};
> > +
> > +/* ioctl commands */
> > +#define COUNTER_CLEAR_WATCHES_IOCTL _IO(0x3E, 0x00)
> > +#define COUNTER_ADD_WATCH_IOCTL _IOW(0x3E, 0x01, struct counter_watch)
> > +#define COUNTER_LOAD_WATCHES_IOCTL _IO(0x3E, 0x02)
> > +
> > +/**
> > + * struct counter_event - Counter event data
> > + * @timestamp: best estimate of time of event occurrence, in nanosecon=
ds
> > + * @value: component value
> > + * @watch: component watch configuration
> > + * @errno: system error number
> > + */
> > +struct counter_event {
> > +	__aligned_u64 timestamp;
> > +	__aligned_u64 value;
> > +	struct counter_watch watch;
> > +	__u8 errno;
>=20
> There are error codes larger than 255. Probably better
> make this __u32.

Are error codes larger than 255 actually useful in this case? I noticed
the exit() function will only return the least significant byte of
status to the parent: https://man7.org/linux/man-pages/man3/exit.3.html

William Breathitt Gray

--ELMJ14pDjrGcIjMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAU57MACgkQhvpINdm7
VJJRZRAApPY7C5W6wFI/RES8FynKQPvVbA8y2f9aCWjF2ir1uxdCF/vQQXNDxa46
O06eBUhB6NWeXG8bKWvCnQ+84mBbnH+v9wlXiX0NbYUhQ44kKSVcJ26n+78Vj5l0
tJTPLtIgtQktPuu8Uuqtzxh4LAvSd/vn2exidqqLfpsF3EwucLRQa/++j+/uXUTu
fPp0zi9sLUUcohSDAgf404mllaRTyeivwHyqRoztLUN/QDWI42UakQYGmg1gRItu
v3UHxYKh+mFpfWM28fJQXvqsErUZQpEfu3zwddn3rVSLpW/9Ja28NCPfIqR0dlhB
19OhtYT0MmfLpmuR+E+2M0ht41F2gJadXp7+/c8dZ3LsnOM7eqKZlH8/mgTlLRmm
tphEIh/uAIN8jm7SACr2bH4VbjoTRfug56k5X25APg4TEYmRvrEBXlkOU7hOAKvx
UA+7c5ql0QpeGRNQtztn7Cxt6agQNoZScmQ6y3wc2pWfC+dOZwiw/A+u1BrhrQ0Y
gfFwZ2A/X8Q+oevhNzmwPq/zqiEyr60gmLPvt2RzznnjkzyCPq3EceHKe5DGGEA1
Vzo6UIaAihwYAB1nivmVg7wzMRnMf/mdTzkLjBrlkoZ6aGZBQV0BJAvXaYOsToV4
7SRyLCgmHi9e758Vdo6CH4B/k9wRoOQ0da6epTmoYDkp9u0hsTE=
=zNAQ
-----END PGP SIGNATURE-----

--ELMJ14pDjrGcIjMp--
