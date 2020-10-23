Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6536229701E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Oct 2020 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372995AbgJWNNP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Oct 2020 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372985AbgJWNNO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Oct 2020 09:13:14 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8023FC0613CE;
        Fri, 23 Oct 2020 06:13:13 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m9so822499qth.7;
        Fri, 23 Oct 2020 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dKwShB7j5WEHxhR5oiuUjAihJ9isJepwJWV2MacDLa0=;
        b=c5u1/fdRe1TryIt+dk0dVaKDNfWt+3dershqJRZzHxVUllML0+fzPGPT7XanYwSKAX
         trRk5Vj2Hm6ZHq+TscRkPU6FTz96pb3cjlPk6CwtjR+RSvXOOcpRpqe5ukB58ZDniE3A
         6gB/+XGqW4VNURSHlpdhnCGXsknxtffvoqL2rl6GlI9l26ii/WG3QGLmRK9b7O+Jzhbi
         EB3Fg9wg6hBTG30K1WmJfKQazw6uoJLHyy1Bw8dGGKUAnKCJKlYx6rN6+4lbzZxfrQvV
         Byy+BHg/1778XnpFE6i8Ip/qsue53auGy7ek0p68fTWD/WyHjGZNEGKcgXM8lxZgNbTY
         kxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dKwShB7j5WEHxhR5oiuUjAihJ9isJepwJWV2MacDLa0=;
        b=RSyc4v3SLhC8fUzVDoz0Ne4OhzoXo7qAM+2kmKjO6YNVDOgz2lnp+lYMR0cH5uMFxG
         gbdZ9cJkV5CABhtd0JBNOP/Y2twGe7eXc9nrZpr6bpXzF7vqvcbcTpK4qehaO5TxzxTC
         N+ifP1Po4A8EB7DB46BGUk24AU7h0W3QlORYqg0e6wjjakYFybn1y/U+q2YXSbefQMl8
         cz1LtyCe3RIAQ2Vr+oiqS2lcZ5hohoWy1H49OFlU5XkimTS3JSvJFHHEiy/aQdy/YhkX
         CVhtbXU3zmUtRy8bg0cqMkrY24l+CbpQpmdX5ypBZd0qaqybtUkLT/kAU8NAErylFNp3
         EQTQ==
X-Gm-Message-State: AOAM532OueC9fiCVsEMe4UR4UhhVx35w3luFGkO2CZHliUw2HMv2YXII
        PS8Zf9IA9UX8ZqUQgY2ydR0=
X-Google-Smtp-Source: ABdhPJz5xgI/Vu6FALA7961ba27Gp5lHM6yAaQbHJCStwgE42CvcxLM7krpHPQWY+++yowlF8XxNrQ==
X-Received: by 2002:a05:622a:1c4:: with SMTP id t4mr1963479qtw.147.1603458792636;
        Fri, 23 Oct 2020 06:13:12 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u11sm805404qtk.61.2020.10.23.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:13:11 -0700 (PDT)
Date:   Fri, 23 Oct 2020 09:12:56 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 1/5] counter: Internalize sysfs interface code
Message-ID: <20201023131256.GA30908@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <e38f6dc3a08bf2510034334262776a6ed1df8b89.1601170670.git.vilhelm.gray@gmail.com>
 <157d1edf-feec-33b5-7ad5-94f99316ca6e@lechnology.com>
 <20201018144901.GB231549@shinobu>
 <d2418c64-f1c7-810d-b80e-91155e0aaffd@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <d2418c64-f1c7-810d-b80e-91155e0aaffd@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 10:38:43AM -0500, David Lechner wrote:
> On 10/18/20 9:49 AM, William Breathitt Gray wrote:
> > On Mon, Oct 12, 2020 at 09:15:00PM -0500, David Lechner wrote:
> >> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> >>> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter=
-core.c
> >>> new file mode 100644
> >>> index 000000000000..987c6e8277eb
> >>> --- /dev/null
> >>> +++ b/drivers/counter/counter-core.c
> >>
> >>
> >>> +/**
> >>> + * counter_register - register Counter to the system
> >>> + * @counter:	pointer to Counter to register
> >>> + *
> >>> + * This function registers a Counter to the system. A sysfs "counter=
" directory
> >>> + * will be created and populated with sysfs attributes correlating w=
ith the
> >>> + * Counter Signals, Synapses, and Counts respectively.
> >>> + */
> >>> +int counter_register(struct counter_device *const counter)
> >>> +{
> >>> +	struct device *const dev =3D &counter->dev;
> >>> +	int err;
> >>> +
> >>> +	/* Acquire unique ID */
> >>> +	counter->id =3D ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> >>> +	if (counter->id < 0)
> >>> +		return counter->id;
> >>> +
> >>> +	/* Configure device structure for Counter */
> >>> +	dev->type =3D &counter_device_type;
> >>> +	dev->bus =3D &counter_bus_type;
> >>> +	if (counter->parent) {
> >>> +		dev->parent =3D counter->parent;
> >>> +		dev->of_node =3D counter->parent->of_node;
> >>> +	}
> >>> +	dev_set_name(dev, "counter%d", counter->id);
> >>> +	device_initialize(dev);> +	dev_set_drvdata(dev, counter);
> >>> +
> >>> +	/* Add Counter sysfs attributes */
> >>> +	err =3D counter_sysfs_add(counter);
> >>> +	if (err)
> >>> +		goto err_free_id;
> >>> +
> >>> +	/* Add device to system */
> >>> +	err =3D device_add(dev);
> >>> +	if (err) {
> >>> +		put_device(dev);
> >>> +		goto err_free_id;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +
> >>> +err_free_id:
> >>> +	/* get_device/put_device combo used to free managed resources */
> >>> +	get_device(dev);
> >>> +	put_device(dev);
> >>
> >> I've never seen this in a driver before, so it makes me think this is
> >> not the "right way" to do this. After device_initialize() is called, we
> >> already should have a reference to dev, so only device_put() is needed.
> >=20
> > I do admit this feels very hacky, but I'm not sure how to handle this
> > more elegantly. The problem is that device_initialize() is not enough by
> > itself -- it just initializes the structure, while device_add()
> > increments the reference count via a call to get_device().
>=20
> add_device() also releases this reference by calling put_device() in all
> return paths. The reference count is initialized to 1 in device_initializ=
e().
>=20
> device_initialize > kobject_init > kobject_init_internal > kref_init

You're right, I completely overlooked this: kref_init() initializes the
reference count to 1. Therefore, the get_device() call is incorrect and
should be be removed.

> >=20
> > So let's assume counter_sysfs_add() fails and we go to err_free_id
> > before device_add() is called; if we ignore get_device(), the reference
> > count will be 0 at this point. We then call put_device(), which calls
> > kobject_put(), kref_put(), and eventually refcount_dec_and_test().
> >=20
> > The refcount_dec_and_test() function returns 0 at this point because the
> > reference count can't be decremented further (refcount is already 0), so
> > release() is never called and we end up leaking all the memory we
> > allocated in counter_sysfs_add().
> >=20
> > Is my logic correct here?
>=20
> Not quite. I think you missed a few things I mentioned above. So we never
> have a ref count of 0 until the very last call to put_device().

Ack.

William Breathitt Gray

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+S1s0ACgkQhvpINdm7
VJIUCA/9H4U4VQUw5cCxP0N7nT9UimOljvgGcou0GNnv1ZB9gg52QQfWXvkIXZmL
2TT15CA+RE3truIWSgJtVOQq2Jir59zh57EamE3ZUtmmZRVwraN2Ne42cx6gj/Th
q8xfynbUJIZ8LGGNsFp34K5dk1ME7w68/5c880HTdcroadW2XZkkrwzzw8d4vde/
eDDv9yCRbZsrVAFTfrdNEGajJktiZfTjWy+XQZcrjZl5No/zoO4wuXwGAGorxUkt
DlC594HMJAsjDI+6DcswkjcvYNrSE+T5iKbp+J5wW86jBoHcaz9MrXH26sRsCpGx
RJ0vUzDtpqFpaM2s6x+yG8Lb4M0kJYe8wGQH1meXL2ypppmJ9Fa3yu1MZ4Ic6aOT
5GZnVzzvpjZoamOjoCTVPUl4AC+rC/bo+bNfPydUsriow41augsH2TIs9MioYSem
KirIumFrBMh/ZYc4IGxO3quJoneinz5evcradtjX0vj5YWxeNrfk5l5Bo9onjYWx
iJXz+o4TghJNxC4vzBngE1TwhI3343GUHIESA6I0BvHpiW/ZXFfAg0d8VPvzAElD
rXzva+ZtzlwrC46iDoeyDTG/5/aqCdUctD82TGORH9yvQfW6AQXur+auEjHHai+q
5PjM/uVDiFEZntsV9ucuj/q4Cf71dHrQ+1TMy55P1iO56+siZCM=
=dPgv
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
