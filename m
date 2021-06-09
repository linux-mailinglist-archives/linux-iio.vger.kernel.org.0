Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197CC3A172F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhFIO2T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhFIO2T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 10:28:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCDCC061574;
        Wed,  9 Jun 2021 07:26:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so1484040pjb.1;
        Wed, 09 Jun 2021 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hp5U48n4wg9mZ0AYRVRn+zgfrqRQSHiITR3eP7pEJMg=;
        b=bs9FGwM1j7QUlNYWptvyG6/EezinJo5RlgC44qFmqjqP+qFgx1Jl1TXJRcfraB4I9c
         WdCiV6OkuU50XRwsGHCjfO1VSlNZKkCqfJvwauma5L0Dq3E+0KNDgEtU0H9pyBwSIsg1
         ccbQeuaqmqxyeQZhBeQVe3iFe4dgQ8NNqmkgM8o+IoL6GGkS8BtIw4yhsIZgIRzPaXvA
         0c3RStQ+XQLXnSYyKaU5IcxqQabqCHJs/fa0fOEEzKC4GS3w1wxGHDm84VJw6G+8dHuX
         A2xGfue8uihkueL4RxhN2XFKWvH4idOuuc0ORi6mCkNB5mW5Hf6LW81L5cYvGpfZMguC
         kjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hp5U48n4wg9mZ0AYRVRn+zgfrqRQSHiITR3eP7pEJMg=;
        b=hmo3MxOfvuMFEePGj9+LWRewf2k+1lJacDDv9eDkcSNO7V3u+qCu978f0cxXkqHUkM
         uLCixT9e7P1ikxbreRsNrTaHbGIpXqCv2+Bl85GNzPula4+JuMeXreNM04yaAxeSz7+7
         twEy5nUE8ocdBaabGgJLuXEc9l7vGU3hPVivTrSDliznKifeXoRW/xYQhfV1Y1RQfjYk
         W2c0/9PsBVQClY3w2YhXBn5bcofG8HFPF1moDdY5UzgCGFBds1E5GrNwQIND6w1yPqpS
         sFFHI76m7T9cZUldA2jGVETXXlRTs3vaaE8rrxH7iHmmsNT9Z38hD0TGtSM1LEvWOKoc
         WGyQ==
X-Gm-Message-State: AOAM530VEQP9rvm883QVbNAR36VrCxfvkDIAg/2VNIjcRudWS1fw7+hC
        iILMdmDc+noy0LWYPM2cK18=
X-Google-Smtp-Source: ABdhPJzpJsV/R5ZXCR2Bzf4vXC4Otslvg433qXauhn4Nd1J36dS84pYzA04daAmtODElupg5m/16Zg==
X-Received: by 2002:a17:90b:1d02:: with SMTP id on2mr10851104pjb.128.1623248775940;
        Wed, 09 Jun 2021 07:26:15 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s29sm39329pgm.82.2021.06.09.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:26:15 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:26:08 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v11 00/33] Introduce the Counter character device
 interface
Message-ID: <YMDPgGHRP/rUTBAm@shinobu>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
 <20210609145951.000005dd@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1vaXBG1dwQTa2gEo"
Content-Disposition: inline
In-Reply-To: <20210609145951.000005dd@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--1vaXBG1dwQTa2gEo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 02:59:51PM +0100, Jonathan Cameron wrote:
> On Wed,  9 Jun 2021 10:31:03 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > Changes in v11:
> >  - Migrated Intel QEP to new interface
> >  - Context adjustments made for documentation
> >=20
> > I pulled out a lot of bits and pieces to their own patches; hopefully
> > that makes reviewing this patchset much simpler than before. This
> > patchset is also available on my personal public git repo for anyone who
> > wants a quick way to clone:
> > https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v11
> >=20
> > The patches preceding "counter: Internalize sysfs interface code" are
> > primarily cleanup and fixes that can be picked up and applied now to the
> > IIO tree if so desired. The "counter: Internalize sysfs interface code"
> > patch as well may be considered for pickup because it is relatively safe
> > and makes no changes to the userspace interface.
>=20
> Let us aim to do that in the interests of cutting down on the volume for =
future
> versions!
>=20
> However, it is made tricky by the fact patch 22 hasn't made it to me or
> lore.kernel.org.  Could you send that one again.  Hopefully the in-reply-=
to
> will ensure it's correctly threaded.
>=20
> Jonathan

I think patch 22 just took a while to be processed by the servers
because of its size; I went ahead and submitted a RESEND of it
regardless just in case. You should be able to access both on
lore.kernel.org:

https://lore.kernel.org/lkml/87dec6c889e40068ed27cbb3e66a6376856e2267.16232=
01082.git.vilhelm.gray@gmail.com/
https://lore.kernel.org/lkml/20210609141145.Ci-kBe7zxq4hPKS98nEi0JK7WOv0DHL=
OIm8pmrIDvVY@z/

Let me know if you encounter any other problems.

William Breathitt Gray

--1vaXBG1dwQTa2gEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDAz4AACgkQhvpINdm7
VJKzUw/9HA1egC/vNivHLayOweGIxZCvXJaAlFM32hu+mSsfgpz/ghluquiCWNQZ
y2+70dUOmATlZn3YQaUKxmo1nrXJxbemSt9oh8u4Drtu5rrnUbYsMFL7vS4pWknX
LhKeusDBtXHEu9FvVbOxHSdNkEZcB/XPSqmu2Ln8Gz+7X8NNcBkMs8I6mT9HTZlu
AWQM8prHkZkNlEyqSH9LZ5xhnxEr3JHZ94jJl56nTuCFrNBwLcRlbuF74/dvjxNv
czoM00eQEHfxKBnBRcIJMQaidUm/8IaOj+ddt9vGLPGVp6tJdcjXPGysea+ZPozm
JG+AdQIMSh6U3bIwfPOzLZqYcM28iQnsnRX0WDOUg+m8p80tsCdJO26mKDN0V4aY
J7IJLJ/vjgRwgV7bV9BKfLgrHsVGHpP8J4kGJzS4Q3fJzABOY2wlEBrRqI9NOB7I
XhlEX4HG1hsxXvGZZrzbNsjG0Nn5H9PSnX2C+EazmKvIybIVVqbKJ0Xq1ETaZhkG
MyZQisp7J8t5Nio84Uqnu5hUaTCuH2QK8dwtTZOUohz4rjCkVGhADweuahFy71r9
0/GK4Tz1A/F8ltgK+svLuDqjNTmeWhUtrClav36hWtgUR3rOg++MzHiPWXVLErs1
pa8nwusWFQe+/VYlnjfMDApok1bf6UDGRA8Frcv8AmkPNYfVGBQ=
=fj6m
-----END PGP SIGNATURE-----

--1vaXBG1dwQTa2gEo--
