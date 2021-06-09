Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604F73A0EB9
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhFIIaP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 04:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhFIIaP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 04:30:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37FC06175F;
        Wed,  9 Jun 2021 01:28:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3219697pjx.1;
        Wed, 09 Jun 2021 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=puGwaOMDT26719cQFE7/Yjic9yAlIAlsYvRcNj+B5nU=;
        b=BZ4TybxfQj4ufSrSUmRlBSZpJgceWCA7FM7IAgOG2x74ABWeWB+Sj7LoXEnnIS1bZI
         7TqLriNnLkeDalM1/nkxCX1NSrDQrsB4Z5CxsESxAQMUD9FoE51E64h6XJAE9am9Zdch
         8OHOezAljyLgPURvrgg8hDcu+DzdgiMIJvr3yyU25lUhuAhEwKMH3l15ShpeuQBdwSe3
         0yM+NxbC1qC0LjQlwgCmBh65z3bAH8qPU7vH1xY8u5RGr8Y7rVBDQTOmi/GOh2HZhA7x
         JJMThyiFy3RntW0SQx6tA6xKA5EXRhbHSQ6hHjEnASssA3REtoTgCOuddVlgh/B48gBC
         wBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=puGwaOMDT26719cQFE7/Yjic9yAlIAlsYvRcNj+B5nU=;
        b=Q5UPKuxYPAqVFtDzi6a01GRxf2/L59CQlqQk5sY5bRR7Km7h0SaH6stVX54M7hbGAH
         5ZNlrwq2q8z4dv0n8HfbQU8/G7NfvxVhBeXmj7JSQLnCvU3bj5ze1/UcZj5g/k9aeMGj
         wfDa8cH+6jZpVph7GZD1uoHou+jV1hzXldgOPFA388O/yWFc/NuUf8uw066CtLcjQFAO
         CBTcQ39PfXsi+w0+e0A6MVFhW5JqCgYQ1zCRrByNJjFzzhRzhIndE69BCvkci3vUFfd1
         lz6/kH9ClNBYDkAduv3zbOONe/oRoj7txPr1QPSZiS604Ra0wnpzAYrQtB81mBrDzmf8
         NtEg==
X-Gm-Message-State: AOAM533E2vw+OhEGqlF8EMzO4hCCCqSFUIgK+1npOFUB6myu0HNx+Gji
        HtxgoCTiM3O1QUQKAQ8fIK0=
X-Google-Smtp-Source: ABdhPJyhu5I84q3D44AwVRdsKNxgLUGoLOqz7ZrLc2Vp/RCdPXk302yCQG0QbUolnPmW9yvqV8MjHQ==
X-Received: by 2002:a17:90a:6305:: with SMTP id e5mr9406398pjj.232.1623227300895;
        Wed, 09 Jun 2021 01:28:20 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id q24sm13728484pgk.32.2021.06.09.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 01:28:19 -0700 (PDT)
Date:   Wed, 9 Jun 2021 17:28:10 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v11 26/33] counter: Add character device interface
Message-ID: <YMB7mq0LHqmyAAzb@shinobu>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
 <2b9526ab7f2de91bb867cbd3b12552c77c00b655.1623201082.git.vilhelm.gray@gmail.com>
 <20210609080708.GL10983@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9wrHIhMj6VuHeXH8"
Content-Disposition: inline
In-Reply-To: <20210609080708.GL10983@kadam>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9wrHIhMj6VuHeXH8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 11:07:08AM +0300, Dan Carpenter wrote:
> On Wed, Jun 09, 2021 at 10:31:29AM +0900, William Breathitt Gray wrote:
> > +static int counter_set_event_node(struct counter_device *const counter,
> > +				  struct counter_watch *const watch,
> > +				  const struct counter_comp_node *const cfg)
> > +{
> > +	struct counter_event_node *event_node;
> > +	struct counter_comp_node *comp_node;
> > +
>=20
> The caller should be holding the counter->events_list_lock lock but it's
> not.

Hi Dan,

The counter_set_event_node() function doesn't access or modify
counter->events_list (it works on counter->next_events_list) so holding
the counter->events_list_lock here isn't necessary.

> > +	/* Search for event in the list */
> > +	list_for_each_entry(event_node, &counter->next_events_list, l)
> > +		if (event_node->event =3D=3D watch->event &&
> > +		    event_node->channel =3D=3D watch->channel)
> > +			break;
> > +
> > +	/* If event is not already in the list */
> > +	if (&event_node->l =3D=3D &counter->next_events_list) {
> > +		/* Allocate new event node */
> > +		event_node =3D kmalloc(sizeof(*event_node), GFP_ATOMIC);
> > +		if (!event_node)
> > +			return -ENOMEM;
> > +
> > +		/* Configure event node and add to the list */
> > +		event_node->event =3D watch->event;
> > +		event_node->channel =3D watch->channel;
> > +		INIT_LIST_HEAD(&event_node->comp_list);
> > +		list_add(&event_node->l, &counter->next_events_list);
> > +	}
> > +
> > +	/* Check if component watch has already been set before */
> > +	list_for_each_entry(comp_node, &event_node->comp_list, l)
> > +		if (comp_node->parent =3D=3D cfg->parent &&
> > +		    comp_node->comp.count_u8_read =3D=3D cfg->comp.count_u8_read)
> > +			return -EINVAL;
> > +
> > +	/* Allocate component node */
> > +	comp_node =3D kmalloc(sizeof(*comp_node), GFP_ATOMIC);
> > +	if (!comp_node) {
> > +		/* Free event node if no one else is watching */
> > +		if (list_empty(&event_node->comp_list)) {
> > +			list_del(&event_node->l);
> > +			kfree(event_node);
> > +		}
> > +		return -ENOMEM;
> > +	}
> > +	*comp_node =3D *cfg;
> > +
> > +	/* Add component node to event node */
> > +	list_add_tail(&comp_node->l, &event_node->comp_list);
> > +
> > +	return 0;
> > +}
> > +
> > +static int counter_disable_events(struct counter_device *const counter)
> > +{
> > +	unsigned long flags;
> > +	int err =3D 0;
> > +
> > +	spin_lock_irqsave(&counter->events_list_lock, flags);
> > +
> > +	counter_events_list_free(&counter->events_list);
> > +
> > +	if (counter->ops->events_configure)
> > +		err =3D counter->ops->events_configure(counter);
> > +
> > +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> > +
> > +	counter_events_list_free(&counter->next_events_list);
> > +
> > +	return err;
> > +}
> > +
> > +static int counter_add_watch(struct counter_device *const counter,
> > +			     const unsigned long arg)
> > +{
> > +	void __user *const uwatch =3D (void __user *)arg;
> > +	struct counter_watch watch;
> > +	struct counter_comp_node comp_node =3D {0};
>=20
> Always use =3D {};.  It's the new hotness, and it avoids a Sparse warning
> for using 0 instead of NULL.  #IDidNotTest #CouldBeWrongAboutSparse

Thanks for the heads-up! I think this is the only patch where I have
this, so I'll hold off submitting a v12 for just this change unless
something else comes up with this patchset (I can fix this spare warning
in a subsequent patch).

William Breathitt Gray

--9wrHIhMj6VuHeXH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDAe4gACgkQhvpINdm7
VJL7BBAA3+1/yr5bhewW4LafcCUbzU1wyuT5jrmB1Ru3YTfniv9LBoq0EZCMkI+e
PzR5jkXM5cZK2CBE/byhsJPBQvJ1C0pNGi4jUDBbFPElYpkEB8cAOhskimabCkGF
pWghRQp5KQzl3GSgB+Jak/5Rt8IqWGtQ+8oK3hpP6oj5EFeXRO6NxgmjiUjrpEAp
DsFvizy3KVdLlQjfq1yxYlXkaz54zzndsXyWAw9LbGMs6ioRvmiFsqgK7beW6i4a
V9U9CPeda6HCeJ3nkPIorclXXc3m5OwbY2FuAewFVpy2fInsSeGjpcnfBIs1onMl
zkdIEKcjOi1v9g8IXdn5lgW8OPXc1IjaF1LZGQ939Iu0oiwYNC+g6ie/nQwM1ZqT
BJlurA8LdpNo+baCWNTZdPAAVQ6GMNCLilYUJmG99j8s7PzdAU12l/e1kjzv/M0O
wagcrNhCdkSSb0FyQjGc5CrQdNlpVNadk3dWhbO0eNEDJszZObBQRQzfe0k8lQPx
pKTpkA1q/R+9E0VD/K5IP0xuCIwW5QM6V57uG7EuP5rRRh686FeDeirvFuJXyVpG
vdWH2keUIRpuxmRd1PvOaA8d/USnzfXhoJyYt1vAyeb6HO8PjQV6zuhTsWzq36kG
TT925QHbUQH7t7b2/hmrLLPmsDKHwuTyGuW9gh+a3n49cEnqjXM=
=MpJ2
-----END PGP SIGNATURE-----

--9wrHIhMj6VuHeXH8--
