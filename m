Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED05828E6E2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Oct 2020 21:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgJNTFn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Oct 2020 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgJNTFn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2020 15:05:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3DCC061755;
        Wed, 14 Oct 2020 12:05:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h140so393790qke.7;
        Wed, 14 Oct 2020 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6wjqxwtbzgIHiDQg99WolaTB10lGIX9ridUr1LerSto=;
        b=C4cJ+6ikED4y7sddfCSWORNVTWuC5T2E3whaMK6+cusw1l8WOeKtareV0Byt1OQtyk
         z2Gb2+3ge3KpfVTMHbAiiPsAR2O1n9HsO1EZ9tlgCaQf4HXgwLoDnWK9vNrkBQA5MGlO
         /4JFHF7Prlrc1a3zs26OMnayCe7V6fG1ZMh3uxT2JZfiwhmeR9sSpP1ZiCRkHkhUF9Ug
         ldlxUnytAhsdqz5mHhxIRRHa/+lGCRUNX6bOTeRAW+scdQdLyf1nSMDRFwFXjjnkRmLS
         tANYv3DYEOm07stB54QrMNQ60nzuKDFeeU7evQOo5HlH2c1ietMjAmNmbT4hLpSgTE+1
         7Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6wjqxwtbzgIHiDQg99WolaTB10lGIX9ridUr1LerSto=;
        b=U+dYnv7KWamyVTCpVP2X4DLtokA7yMJU9NP1zrrIuz+zlP7LNmZuFnkoDIAST2Z65+
         +xDwjRcK00lN1BnhvUk1FF+zVsYFEoSh6CrtWpSXZkXeQMeoLw5pPYS2leIvHQJt+VAx
         HYNoS6VgwtDBeuCXIUDi2F26PMEQG8XN1ojAyLXSNzBbLltwxiq21ey2edmOzxThdSba
         5tddyhvOUr/LZyQEGG1eegLjQaJWDahOGeIqdT/ZqbBq3Bmbx8QBwbxvNOCMGyAzNYuo
         rgAItYAlvoTEviDiGYlw4UAtwLu2eU+69xnB/nzeTlCt8wohIeo+GkR46Us5vU5plrPV
         f3cg==
X-Gm-Message-State: AOAM530keu7q9guQ8iQkPq7rfDnQq6nBuwcSUhNSvAIZgysOy2SFeRVn
        cHQFChE0kSVk4CfruTyF8e8=
X-Google-Smtp-Source: ABdhPJxtNMA2dHYbfdwX/cS1+k4VNViVtwLuSPBAgvxVBiNRGxKjZbeYrm37jqFJYa3DXkpMUa+hDw==
X-Received: by 2002:a05:620a:152:: with SMTP id e18mr465193qkn.365.1602702341697;
        Wed, 14 Oct 2020 12:05:41 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u4sm238508qkh.106.2020.10.14.12.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 12:05:40 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:05:26 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 3/5] counter: Add character device interface
Message-ID: <20201014190526.GA13439@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
 <67a0290e-731b-822a-5113-30b56bde6c88@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <67a0290e-731b-822a-5113-30b56bde6c88@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 12:43:08PM -0500, David Lechner wrote:
> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter=
-chrdev.c
> > new file mode 100644
> > index 000000000000..2be3846e4105
> > --- /dev/null
> > +++ b/drivers/counter/counter-chrdev.c
>=20
>=20
> > +/**
> > + * counter_push_event - queue event for userspace reading
> > + * @counter:	pointer to Counter structure
> > + * @event:	triggered event
> > + * @channel:	event channel
> > + *
> > + * Note: If no one is watching for the respective event, it is silently
> > + * discarded.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int counter_push_event(struct counter_device *const counter, const u8 =
event,
> > +		       const u8 channel)
> > +{
> > +	struct counter_event ev =3D {0};
> > +	unsigned int copied =3D 0;
> > +	unsigned long flags;
> > +	struct counter_event_node *event_node;
> > +	struct counter_comp_node *comp_node;
> > +	int err;
> > +
> > +	ev.timestamp =3D ktime_get_ns();
> > +	ev.watch.event =3D event;
> > +	ev.watch.channel =3D channel;
> > +
> > +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> > +
> > +	/* Search for event in the list */
> > +	list_for_each_entry(event_node, &counter->events_list, l)
> > +		if (event_node->event =3D=3D event &&
> > +		    event_node->channel =3D=3D channel)
> > +			break;
> > +
> > +	/* If event is not in the list */
> > +	if (&event_node->l =3D=3D &counter->events_list)
> > +		goto exit_early;
> > +
> > +	/* Read and queue relevant comp for userspace */
> > +	list_for_each_entry(comp_node, &event_node->comp_list, l) {
> > +		err =3D counter_get_data(counter, comp_node, &ev.value_u8);
>=20
> Currently all counter devices are memory mapped devices so calling
> counter_get_data() here with interrupts disabled is probably OK, but
> if any counter drivers are added that use I2C/SPI/etc. that will take
> a long time to read, it would cause problems leaving interrupts
> disabled here.
>=20
> Brainstorming: Would it make sense to separate the event from the
> component value being read? As I mentioned in one of my previous
> reviews, I think there are some cases where we would just want to
> know when an event happened and not read any additional data anyway.
> In the case of a slow communication bus, this would also let us
> queue the event in the kfifo and notify poll right away and then
> defer the reads in a workqueue for later.

I don't see any problems with reporting just an event without any
component value attached (e.g. userspace could handle the component
reads via sysfs at a later point). We would just need a way to inform
userspace that the struct counter_component in the struct counter_watch
returned should be ignored.

Perhaps we can add an additional member to struct counter_watch
indicating whether it's an empty watch; or alternatively, add a new
component scope define to differentiate between an actual component and
an empty one (e.g. COUNTER_SCOPE_EVENT). What do you think?

William Breathitt Gray

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+HS+wACgkQhvpINdm7
VJLA6w/8C/7Kk5FVs4czCH9uMX3PWTVzLg32XilvtRndujXVCml9iLMADLvFVyIA
dEX7rmXz/bWYSzG99VkZyHCWCeQX8+roYFDhmqbD8hQyEkqQlhHFWGdAPqGPAYeH
cesBwsFdkB3yoc28HahJfV6c3HtuO3pLtsu7qKORwbhOupqzz6BBg/imzx04+8hh
LicqVk0uFKT/v5E9o5AfOV+9cbHgZWm+TusLYTwKZCrvDVmrWkxdppPC581ftd9Q
mrW/2qfj3ltcO4VoJ6JVZpKjcXJSak8V0l+A7dV2Hbp8dBGEhC+iODBfhhAUxTz5
NM/cw+L90slS7Yli2mf1aY4lYLNv+Ob17alTK4P1Gc1ekJ9yofNevJlb8xp55KxC
jY8rUWxEkS1y1h8K7wrPzwhMwk6Ab4psdUB+9+DClArQI5ZnimG1nJlSph9p1C24
VjR6Vi8qSyUlSKrr5vK1ac1s/EDoAxwJoMr+e3rbRqrz3kktAvSN0S0sPD+xoV87
iPjdASJa3YvBkS4v2o34XoNQnsVpdzUW3emUQ56qLf2yWVqbP8PkG5xhBRtfHvtI
3VRYrSJ2dgv1u2xvrFhFhr2g7DRA9XMDOgc/aiqRnD18MHWT57GBLakOIZAYG9g3
qbtBe6fEcVlUumDSKscRfWe6bsFhldy3v5FCMiY2JGZh689pwPM=
=EhIu
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
