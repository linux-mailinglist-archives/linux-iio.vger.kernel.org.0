Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637112E2C06
	for <lists+linux-iio@lfdr.de>; Fri, 25 Dec 2020 18:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgLYRat (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Dec 2020 12:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgLYRas (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Dec 2020 12:30:48 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A7C061757;
        Fri, 25 Dec 2020 09:30:08 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id w79so4335507qkb.5;
        Fri, 25 Dec 2020 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6tNoeU4rdX0Rp7YesclVSlEoPPasvtmAb8rPCs2D1UA=;
        b=IIbk73+3Kn9m25AbiWeCyLcszXZliqbmEyDL1AOj0RVNhCQYa3sLxEQIqXZBW3Ypic
         DQ4wzgFr5B4rLcyjNdl29h0/7/ozhfpbDAocjKdrhtE2hO6WAEXbSpgu+JcR17vgO+sa
         rQhPpLky45RnexFX4O4NU7kW+Yu2yJBXHMJcLcGRrcFkuwEcTYEHk2G13VPL9sSen70j
         hSb/9en/J29uqP5MdAdokGjqlxKm4Dhuhv3vLtTcgjZkJhyIDqdlvQ02S5HhEn9hMPGO
         zktoLKSE4Re4ZHtqIBCUPKVtxs9/k+iyh7tTUzAe1vd+nBFPIspR9ejhvtS0sF/nfH/X
         gVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6tNoeU4rdX0Rp7YesclVSlEoPPasvtmAb8rPCs2D1UA=;
        b=KLGT+B5iL0Hr6J0kKoz0sdEaPI+J1dMnH1FjSpVgcY5yIaWFv14KgrUdoeSFj+oqkY
         al2ELnvyIP6dlma6rdneAHrVdzfC8RIJlP+35Ow7vDDanJb0ZtHq35vZOy9dS5xAhRwa
         a5lBfBhWF0ttr1ZLOoXvyb/dgEhn0S3EsuRy629P1Sk2GyDxNUtGDvQlMX3nKfhSPrZm
         teZtXEGM7T/UDuWVmH42xQVwEygAl3QMpAkqxoLxGY7dhmVw6wDutZeA65RjFccvKxqy
         v+VzKUUZRyjP5oqu5cyyjVXMha0cja+mQ64wP/xlFA63LK1T1u25hJVNbQqfT3wfXZv9
         W3Uw==
X-Gm-Message-State: AOAM531bJw93frHGG7jFX8d24XzMnKYas3TfLtxQ5pnh19XTazjCORSK
        ZdeWvgEnJNY4Z/gmXnhWGcTfLNXTaj60vA==
X-Google-Smtp-Source: ABdhPJw0R+1fIgZCorc4miRt0cUFZr5DYuK5D7K1Bsb8++9DlhiEtxJFg2kyayH/6OeJ0qRyV9381w==
X-Received: by 2002:a37:a796:: with SMTP id q144mr35953703qke.38.1608917407683;
        Fri, 25 Dec 2020 09:30:07 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id p34sm15771442qtd.62.2020.12.25.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 09:30:06 -0800 (PST)
Date:   Fri, 25 Dec 2020 12:30:04 -0500
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
Subject: Re: [PATCH v6 3/5] counter: Add character device interface
Message-ID: <X+YhnDqLZ7Ad9b2O@shinobu>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
 <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
 <b5d49a3a-99ab-e5c0-3f0b-601eed9b54f5@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bi9bW/svyG+8ZjzL"
Content-Disposition: inline
In-Reply-To: <b5d49a3a-99ab-e5c0-3f0b-601eed9b54f5@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Bi9bW/svyG+8ZjzL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

I agree with your suggested changes -- just a couple select comments
following below.

On Sun, Dec 13, 2020 at 05:58:26PM -0600, David Lechner wrote:
> > +static int counter_add_watch(struct counter_device *const counter,
> > +			     const unsigned long arg)
> > +{

[...]

> > +
> > +dummy_component:
> > +	comp_node.component =3D watch.component;
>=20
>=20
> In my experiments, I added a events_validate driver callback here to
> validate each event as it is added. This way the user can know exactly
> which event caused the problem rather than waiting for the event_config
> callback.

Yes, this is a good idea and I have use for this in the 104-quad-8
driver as well. I'm going to name this "watch_validate" however, because
I need to validate the requested channel as well as the requested event
here (both part of the struct counter_watch).

> > diff --git a/include/linux/counter.h b/include/linux/counter.h
> > index 3f3f8ba6c1b4..98cd7c035968 100644
> > --- a/include/linux/counter.h
>=20
>=20
> >=20
> > +/**
> > + * struct counter_event_node - Counter Event node
> > + * @l:		list of current watching Counter events
> > + * @event:	event that triggers
> > + * @channel:	event channel
> > + * @comp_list:	list of components to watch when event triggers
> > + */
> > +struct counter_event_node {
> > +	struct list_head l;
> > +	u8 event;
> > +	u8 channel;
> > +	struct list_head comp_list;
> > +};
> > +
>=20
>=20
> Unless this is needed outside of the drivers/counter/ directory, I
> would suggest putting it in drivers/counter/counter-chrdev.h instead
> of include/linux/counter.h.

The "events_list" member of the struct counter_device is a list of
struct counter_event_node. The events_configure() callback should parse
through this list to determine the current events configuration request.
As such, driver authors will need this structure available via
include/linux/counter.h so they can parse "events_list".

William Breathitt Gray

--Bi9bW/svyG+8ZjzL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/mIZwACgkQhvpINdm7
VJIZxxAAhAKczPADq8u05OkOAmgVD7IeT9cUBIB/XnT0VVSVX46G473g78mZwlsx
qnfK1l4uDvwjAY+YFFKanUztxg/j60BzJOt9BK4NqWR4ic7J0FPj9i4YgN9J+9oo
JmFSjqT8Abo7rEdB426yT9Fof9cBU/oPdOpNSufDNidrxXnTIOKnjA9odG/vgOzl
mlXTQHs2glKeLrHIvJOnK7mwy3l11Ew2xhRvBEsMfbzXIYoOkVC8Ax146tHpqBVl
hN/vCEU49+JCbZrSOk9EmtjRZ7DiF8AoV7GFUjqGWxkECKx1ov2WeR62DFhUJMvI
qC/boNu0BZW2N8HgIvgsgKP0r/v0E+RuRFzcahpS/0YhsNh8fgEVfeIWS2ZaVXWT
7e4FZIOw4Vuk0E2DXw0rWRzvNCCstRsqY9fQ7ee1/WruCHRvZEeiifJADx7E7LBv
XwQynYXOgFe1hxXFejwSTgTCMl5y25CaT8JVU8GLYgHYnPKkIVSsOJ5dUgTbRCOu
RBbMgZbcBuB1tUy45SP6Rx8in4joA+AGAt6oj4kxrd+/+O2+uvUoNILqoYHAMyV6
EBP78O/sAHNObYnwVJNaM1Bc1VYIF7+pMjotOTtHmkZhs5Ac8qxXih4r+mIZgItu
yGeJ9cG82fkziDp+TtNuYXsfLQQhxtdicKmAqzZeg5VSyGQWkQY=
=vH3L
-----END PGP SIGNATURE-----

--Bi9bW/svyG+8ZjzL--
