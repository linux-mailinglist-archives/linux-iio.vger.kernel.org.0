Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2C3BE046
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 02:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGGAbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 20:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGAbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 20:31:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6201C061574;
        Tue,  6 Jul 2021 17:28:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so2532876pjb.0;
        Tue, 06 Jul 2021 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wgMqBY62hL/9zc2/Y9RJScdFpoJ7MDAsy5QSUueWpmQ=;
        b=cDMJD5q1dceLz4P4a4N1PWPbj3mpKCyHl+kpmuFvBSFCLjxJhTu83hIsv9j0g7WNjt
         Ha5rraiLkj9M2ZepNiX9oUxJ7OcOz0tSY00XoutscCtagvsbYk6MI5/YILSNojz/bqF2
         1Qrsm4Kj0OnJpFvdCLLfxL1LDXLpu5ximyhL/IgMUmUrLn70Di23tlAKRml1sYMZlnWG
         oUcvZ4oRK2y0K8XEg509UdXAZftNPlIGd3cFjof+q3/5KnF1Htm88ueE4LAzrq8uhPYW
         4vfFEidyMKlJ3qumCNjW62GIxYmZ5ECj+csgHpDGiadmWY3zozzKRWRT7xOqxj/7NVQ0
         ko3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wgMqBY62hL/9zc2/Y9RJScdFpoJ7MDAsy5QSUueWpmQ=;
        b=M71qsPpVmmBIPDPE6eieRAQ1r3vcSRv8P5//CZMPjtKSfkV+EPoMZvIPHfhPERDEVK
         VeF8FEg6vKF7a8xl0+0iZBxIwLolMa9y7SNWYb+sbukiBcB4nBhJ1iD5ZASIMASRwdZu
         E/mm44VzqkzmcAMQ+Z94MVobOGwROnViva52rOyN/6iF3jEm9In1Szzv1/PxQ5MyM1Fx
         jUKP+LuJkrAY3VsuiIy00S6Tfcc4xNphH+x0xr2ljtyyuC5nA24C3jD2z49i9v9H9cZ/
         lTouQ+RmUHkGRKmlqmrMpUqZC5/iAlwT51JpKmuO8XU4fXd/BNNpydS2Evr37oIZBPiW
         Qdfg==
X-Gm-Message-State: AOAM5326MfEQA1MyU4QG2NTKCxftiqaiYopH5/kajr88TmM9K31aCO4W
        d72Fjb60jPDCmYU66fp4aqM=
X-Google-Smtp-Source: ABdhPJwyOfj2zNPpVkjW7izeLTHLXWRgoCKm6b8nqpc4pgmLX5lWGHIprfF5CJaY5N2CsLka8JsAxw==
X-Received: by 2002:a17:90a:e7c4:: with SMTP id kb4mr2943529pjb.43.1625617723085;
        Tue, 06 Jul 2021 17:28:43 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id j6sm16042192pji.23.2021.07.06.17.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 17:28:42 -0700 (PDT)
Date:   Wed, 7 Jul 2021 09:28:35 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v12 00/17] Introduce the Counter character device
 interface
Message-ID: <YOT1M1qcfHC2PpuF@shinobu>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <5bdd9ee6-86af-3bcc-43ff-418fd1a2e3e8@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9KoXz8sgYVDVTxwl"
Content-Disposition: inline
In-Reply-To: <5bdd9ee6-86af-3bcc-43ff-418fd1a2e3e8@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9KoXz8sgYVDVTxwl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2021 at 02:40:01PM +0300, Jarkko Nikula wrote:
> Hi
>=20
> On 7/5/21 11:18 AM, William Breathitt Gray wrote:
> > To summarize the main points of this patchset: there are no changes to
> > the existing Counter sysfs userspace interface; a Counter character
> > device interface is introduced that allows Counter events and associated
> > data to be read() by userspace; the events_configure() and
> > watch_validate() driver callbacks are introduced to support Counter
> > events; and IRQ support is added to the 104-QUAD-8 driver, serving as an
> > example of how to support the new Counter events functionality.
> >=20
> I quickly tested this set on top of linux-next next-20210706 and didn't=
=20
> see any issue with intel-qep.c. However I noticed two mutex issues in=20
> patch 15/17. Perhaps visible due the CONFIG_DEBUG_MUTEXES=3Dy etc. I have=
 on.
>=20
> I'll be out of office next few weeks so cannot test if you have a new=20
> version meanwhile but wanted to share no show stopper from intel-qep.c=20
> and those two mutex warnings.
>=20
> Jarkko

Thanks, these seem pretty straightforward to fix so I'll wait a week or
so to see if any other issues pop up before making a v13 submission.

William Breathitt Gray

--9KoXz8sgYVDVTxwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDk9TMACgkQhvpINdm7
VJL/+A/8DfP+wFOuOhzB4lVMNXXWQgDSk/bZskGmbS2ZZLobkAQ260t+W1F8L7vj
q9ghHKWyLScDZ6EnRxY+1CdtT4eYXUcDeqJ0H0uLROcluzVYgBw7ZiJdt1nrEjmz
abeflZ2T0hz1/fsX5zfUDRE2gdjjhdK/92iMmdiYXhOav8y3LyaAhmlN6d5Vqob4
NwPZlf46LbvG3N0ExnT0ZP2B8q0LDJBXdxJbe4QoHY8239xFfins+2AhdhHAGfE6
nAszv/Bq1igVzQ04M+MbvMbVf6zPlyphAudOa9pi5+up2fB/dBGVIE5hrZ4LHlQn
chEpoCZ5/ZI3ZuEN3OoFuiiCDdbT06Pvn71x7Fm5Oio51JkFa8AysnEbGTr9k/NX
9/FERGf+fQBSGou1XO1ujPFLtZxwYyvUE/a/Kw2AdLDVLBoQ6AqF3m6s/wP/vGlE
tbrqdNkucZ9tMWJQGCM/528XztqDayILvKSkTS+RwkoBdv9G3HzKejW8EOkneTEp
/5QAODb+TuvGMtvFyDuKxHkbZ1WA3ps6mgwguS5BaUkcnatur8s8JBT/IRR9WUxn
5PLXV6+HGVoTu6Z179l2D7msc2iXwiETZEZjdVkMIrmQ+xgb+MhUUHeyZX4FLD+s
pYmZ10G+ccSpXQucUP0hKygdkXjX7ZwTB1oT+9EG4t5aYu3e/FY=
=xXkJ
-----END PGP SIGNATURE-----

--9KoXz8sgYVDVTxwl--
