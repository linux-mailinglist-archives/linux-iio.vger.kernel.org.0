Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9E2917EC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgJROtG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJROtF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 10:49:05 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6AC061755;
        Sun, 18 Oct 2020 07:49:05 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q63so5973223qkf.3;
        Sun, 18 Oct 2020 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2maPjMmKBO3qJ6bj1ZIa+1fen/LaHDMz2hjlt9FyXpM=;
        b=edJ76NFhzlLWq4H5mSoCVT3A4RvvvjDB6Y8RN1FPfruryMA0JG3jdQwm4GX2wjTtwk
         1JP17TlZMkcSrV5F9kL8us5xOVeMCF1pNtk0kdUK2tQ+zV3gBTNmP7i7F1DG6pVKHwjz
         lVPAKKXnOeguxignj6FcqpP75KmNmRWpV+05v9SPCOIUrQg8+mF/RAfOzvVgc0BG3wk3
         8jKDO4b/+Y+4lu5Uj+XwW55qjt5FpIigYFxQ+aVAGh6CNqQO4pg5JIH+fsIR3g0jtZN2
         q4fybDMigAFCikAu3niYmfIwCKv4JU6tfsbPRzCDoo2C5K2QUZnRZxMSNnHgonreyFrF
         uOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2maPjMmKBO3qJ6bj1ZIa+1fen/LaHDMz2hjlt9FyXpM=;
        b=KZoXUt3+7lIGpSAAFVgajSZfO+AhIlaeL/x4rtKmRe4x+9JttkLvvY5RiScEfCrHP8
         TQjZQRtqoGOnVs7IC/D12kiVivgbk4hThwigX/3cBLi1h9xUloTkqjQ7SzsyZQL6b0oc
         19RTeRaXxF1nVYrtGuITscHeldeu1QWRMRsQHpJAE30kmhsPBfq+OEu9AYCw7dO4YVxM
         GTYsjtVrO/QWZyOjenlvhn3Ptx4iWdKqAfFJGyxsjj/wgceEuGIeM5OVXBw94RU4+jFh
         9ZvBXPupD0UREJguEMsfSCI74eDZRU10whHgj9LwlxaRzOrDsfuouvr1z1RYK642X0lD
         4qow==
X-Gm-Message-State: AOAM5313Fsxy30dK+wNMwB/YKFO1IZaQlQsNX8Ymj7HRxNcAQnrWvIu5
        wf9lFQjBpngFMml7sncRHaPbHO1y1pouVw==
X-Google-Smtp-Source: ABdhPJxfNufcArwekK4WupgO67MI7ytQp56+WBT8GVqq/2Q0K9iOmMl1ClyTr5Q0NwnGIFfLbbMtRw==
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr12155152qka.175.1603032544414;
        Sun, 18 Oct 2020 07:49:04 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id 6sm3175635qkj.75.2020.10.18.07.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 07:49:03 -0700 (PDT)
Date:   Sun, 18 Oct 2020 10:49:01 -0400
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
Message-ID: <20201018144901.GB231549@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <e38f6dc3a08bf2510034334262776a6ed1df8b89.1601170670.git.vilhelm.gray@gmail.com>
 <157d1edf-feec-33b5-7ad5-94f99316ca6e@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <157d1edf-feec-33b5-7ad5-94f99316ca6e@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 09:15:00PM -0500, David Lechner wrote:
> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> > This is a reimplementation of the Generic Counter driver interface.
>=20
> I'll follow up if I find any problems while testing but here are some
> comments I had from looking over the patch.
>=20
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > new file mode 100644
> > index 000000000000..987c6e8277eb
> > --- /dev/null
> > +++ b/drivers/counter/counter-core.c
>=20
>=20
> > +/**
> > + * counter_register - register Counter to the system
> > + * @counter:	pointer to Counter to register
> > + *
> > + * This function registers a Counter to the system. A sysfs "counter" =
directory
> > + * will be created and populated with sysfs attributes correlating wit=
h the
> > + * Counter Signals, Synapses, and Counts respectively.
> > + */
> > +int counter_register(struct counter_device *const counter)
> > +{
> > +	struct device *const dev =3D &counter->dev;
> > +	int err;
> > +
> > +	/* Acquire unique ID */
> > +	counter->id =3D ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> > +	if (counter->id < 0)
> > +		return counter->id;
> > +
> > +	/* Configure device structure for Counter */
> > +	dev->type =3D &counter_device_type;
> > +	dev->bus =3D &counter_bus_type;
> > +	if (counter->parent) {
> > +		dev->parent =3D counter->parent;
> > +		dev->of_node =3D counter->parent->of_node;
> > +	}
> > +	dev_set_name(dev, "counter%d", counter->id);
> > +	device_initialize(dev);> +	dev_set_drvdata(dev, counter);
> > +
> > +	/* Add Counter sysfs attributes */
> > +	err =3D counter_sysfs_add(counter);
> > +	if (err)
> > +		goto err_free_id;
> > +
> > +	/* Add device to system */
> > +	err =3D device_add(dev);
> > +	if (err) {
> > +		put_device(dev);
> > +		goto err_free_id;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free_id:
> > +	/* get_device/put_device combo used to free managed resources */
> > +	get_device(dev);
> > +	put_device(dev);
>=20
> I've never seen this in a driver before, so it makes me think this is
> not the "right way" to do this. After device_initialize() is called, we
> already should have a reference to dev, so only device_put() is needed.

I do admit this feels very hacky, but I'm not sure how to handle this
more elegantly. The problem is that device_initialize() is not enough by
itself -- it just initializes the structure, while device_add()
increments the reference count via a call to get_device().

So let's assume counter_sysfs_add() fails and we go to err_free_id
before device_add() is called; if we ignore get_device(), the reference
count will be 0 at this point. We then call put_device(), which calls
kobject_put(), kref_put(), and eventually refcount_dec_and_test().

The refcount_dec_and_test() function returns 0 at this point because the
reference count can't be decremented further (refcount is already 0), so
release() is never called and we end up leaking all the memory we
allocated in counter_sysfs_add().

Is my logic correct here?

> > +	ida_simple_remove(&counter_ida, counter->id);
>=20
> In the case of error after device_initialize() is called, won't this
> result in ida_simple_remove() being called twice, once here and once in
> the release callback?

I hadn't considered that. I suppose the ida_simple_remove here is not
necessary because we will always call ida_simple_remove() in
counter_device_release() when we call put_device(). I'll remove this
ida_simple_remove() from counter_register() then.

> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(counter_register);
> > +
> > +/**
> > + * counter_unregister - unregister Counter from the system
> > + * @counter:	pointer to Counter to unregister
> > + *
> > + * The Counter is unregistered from the system; all allocated memory i=
s freed.
> > + */
> > +void counter_unregister(struct counter_device *const counter)
> > +{
> > +	if (!counter)
> > +		return;
> > +
> > +	device_unregister(&counter->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(counter_unregister);
> > +
> > +static void devm_counter_unreg(struct device *dev, void *res)
>=20
> To be consistent, it would be nice to spell out unregister.

Ack.

> > +{
> > +	counter_unregister(*(struct counter_device **)res);
> > +}
> > +
>=20
> > diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-=
sysfs.c
> > new file mode 100644
> > index 000000000000..e66ed99dd5ea
> > --- /dev/null
> > +++ b/drivers/counter/counter-sysfs.c
>=20
> > +/**
> > + * counter_sysfs_add - Adds Counter sysfs attributes to the device str=
ucture
> > + * @counter:	Pointer to the Counter device structure
> > + *
> > + * Counter sysfs attributes are created and added to the respective de=
vice
> > + * structure for later registration to the system. Resource-managed me=
mory
> > + * allocation is performed by this function, and this memory should be=
 freed
> > + * when no longer needed (automatically by a device_unregister call, or
> > + * manually by a devres_release_all call).
> > + */
> > +int counter_sysfs_add(struct counter_device *const counter)
> > +{
> > +	struct device *const dev =3D &counter->dev;
> > +	const size_t num_groups =3D counter->num_signals + counter->num_count=
s +
> > +				  1;
>=20
> It is OK to go past 80 columns, especially for just for a few characters.

Ack.

> > +	struct counter_attribute_group *groups;
> > +	size_t i, j;
> > +	int err;
> > +	struct attribute_group *group;
> > +	struct counter_attribute *p;
> > +
> > +	/* Allocate space for attribute groups (signals, counts, and ext) */
> > +	groups =3D devm_kcalloc(dev, num_groups, sizeof(*groups), GFP_KERNEL);
> > +	if (!groups)
> > +		return -ENOMEM;
> > +
> > +	/* Initialize attribute lists */
> > +	for (i =3D 0; i < num_groups; i++)
> > +		INIT_LIST_HEAD(&groups[i].attr_list);
> > +
> > +	/* Register Counter device attributes */
> > +	err =3D counter_device_register(counter, groups);
>=20
> This function name is a bit misleading. At first I though we were registe=
ring
> a new counter device (struct device). Maybe counter_sysfs_create_attrs()
> would be a better name? (I wouldn't mind having all functions in this
> file having a "counter_sysfs_" prefix for that matter.)

Good point, I'll rename these to make it clearer.

> > diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> > index 1ff07faef27f..938085dead80 100644
> > --- a/drivers/counter/ti-eqep.c
> > +++ b/drivers/counter/ti-eqep.c
>=20
>=20
> > @@ -406,7 +414,7 @@ static int ti_eqep_probe(struct platform_device *pd=
ev)
> >  =20
> >   	priv->counter.name =3D dev_name(dev);
> >   	priv->counter.parent =3D dev;
> > -	priv->counter.ops =3D &ti_eqep_counter_ops;
> > +	priv->counter.parent =3D &ti_eqep_counter_ops;
> >   	priv->counter.counts =3D ti_eqep_counts;
> >   	priv->counter.num_counts =3D ARRAY_SIZE(ti_eqep_counts);
> >   	priv->counter.signals =3D ti_eqep_signals;
>=20
> This looks like an unintentional change and causes a compile error.

Yeah, it was an unintentional change. I'll fix this. :-)

> > diff --git a/include/linux/counter.h b/include/linux/counter.h
> > index 9dbd5df4cd34..132bfecca5c3 100644
> > --- a/include/linux/counter.h
> > +++ b/include/linux/counter.h
> > @@ -6,417 +6,195 @@
> >   #ifndef _COUNTER_H_
> >   #define _COUNTER_H_
> >  =20
> > -#include <linux/counter_enum.h>
> >   #include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
>=20
> struct list_head is defined in linux/types.h. Is there something else
> we are using from linux/list.h in this file?

I think this was left over from when I had list_add() in this file in an
earlier version; I'll remove this header now since it doesn't look
necessary.

> >   #include <linux/types.h>
> >  =20
>=20
>=20
> It would be helpful to have kernel doc comments on everything in this fil=
e.

Ack.

William Breathitt Gray

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+MVcoACgkQhvpINdm7
VJKPlQ//fPGvfc3H6TKRGzQSDSpXJW4bTJ29II448RW8Pz/tigHvfZwfxjGY4t0f
2smaXA9xC//7Ss7xgW+hNNP54v+eQxzOoRlnqwoYiT9lTnELiEmIGmneP+ThGVk/
0zx4xGwcTrQgsxoTlkyyg27uSL3w4a6/CFwmaI0LLNWBiYTmE5osD7s/rbP6gm6J
oJWWeoJXwI3ky9hqvVUE4hpPiJQz4GAwFKULMzVfCiR9lG9IaUVFfOLzryByuHEx
2W5ffOsJ1nyeCY4A9+fme7/dJG/gRJxvGnaCqDwLMHEHgI30p2ZBjvX1gjhRTUlN
cFPIi4JhbI0J0hfBbglAU7SB/ZqfqzfNVw233j6CH0LL+tJCiJPl+goafx7iyQ4+
D/856GZDG+Ns7NZjoAemw85owD/p63Jjx0h5OCchBhE6hhvty1fleeV5WPc7ayU0
wcUHCUdRU3Vq7hpkFqClXU928vTHXR15yi+Ieo3IPiMMiMgq4ovdCsQbeHs489fT
C1EpMnPo0vpPA59SOXKLht8fCS02yw2IqnjwfePOs00hl59sQc4blJe7eEN7J7s4
wAgHnARxaQ12lhAa8n8E8jZmyGSSPSm4U/0d//RLz5G4DDrCsOhL7d6PjFp6HdHp
qaAdI6nIiDV3rVzUCDA5G92YLxd6ZHFychfbgbEjkXT/wI99yfk=
=Xn8e
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
