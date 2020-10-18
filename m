Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623732917D2
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgJROOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJROOd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 10:14:33 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF931C061755;
        Sun, 18 Oct 2020 07:14:32 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c13so4617628qtx.6;
        Sun, 18 Oct 2020 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wQD8dvtVrq4V8MJl2t269P6nRY45qGQQwokAStwOkWk=;
        b=sLqkvqoYyL7bDoORzLgwtKjYTyFm2yH2VYX0ISHtpB70KxnqQaVk5WrYtFap5xmV3b
         zY2daPhUl7UyatttwIktfRPPwTwoHd9gmGawqyu2i2QuBbHMxpQ3ZBVOEF7FmMCkHyT6
         cdbagoqTqHTMKBxZO+s4jlaaavO63RA+5bbQEDVof6h93xRejTA8+O6c/gdGZpTkkoqi
         IU2LgK8+EhXpIgY98TCxaCpsCPY2KguBD2ab6lV6FXPk+BOgO2eIZDYgBzbEITGw7oa1
         SfnkVcR98W7rsML9bQ8Dkyfrpe4ZWn8bSKDlTNT+M6rUs7bZ2aiGIFhlhv99F8Oh+Ovo
         tZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQD8dvtVrq4V8MJl2t269P6nRY45qGQQwokAStwOkWk=;
        b=qFXAmMy1gbFrnkays+5axJ8C5h2aNSD6HwDYg4iUbXkjG8W9CAedUpuyPSXkvf2AiE
         M69qvdTN1ll0wT2EXu1J6m3uTMzwqSjwBR5s1HwQg1rfGLArzuCxUBW2UD5BkgqrhBWd
         lA6GgZKjHBc2P+1Wlq5n01gQJmv+5J8ikbUw/jB6D8fMAE7SeLZnScq0fmAaW88e4wjH
         eg62Oz6eAemVw0YoHdEbmzoOBKj365Lzgh2o2isVhLkMnCIoBRaOMtMj/NdHMeOm2m0G
         0adn/Ca8ySie+MYoFbCBNE7ZRHut49nmxNpPZnYyDUhi7Kt3zQSLAdQue5k8d0vL4qKd
         JRDw==
X-Gm-Message-State: AOAM532nBaNFauLfoc1GxQhQlJfhdlGwQOaOSOPFK1SFmpLYHKGXlt95
        +imvNx7piP1IY+wbZwHquis=
X-Google-Smtp-Source: ABdhPJz8AqYMLj6JncUpgAzSEh01P1bIeDSVxq6zjSr5BxjFbB42zFfwuvL7QL1MnzhJ1uMLrHtPSQ==
X-Received: by 2002:ac8:1a30:: with SMTP id v45mr11101920qtj.345.1603030471220;
        Sun, 18 Oct 2020 07:14:31 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id g15sm1566143qki.107.2020.10.18.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 07:14:30 -0700 (PDT)
Date:   Sun, 18 Oct 2020 10:14:01 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 0/5] Introduce the Counter character device interface
Message-ID: <20201018141401.GA231549@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <caeeb0b2-6b66-b623-98e3-acdc261ec20e@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <caeeb0b2-6b66-b623-98e3-acdc261ec20e@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 07:35:11PM -0500, David Lechner wrote:
> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> > The following are some questions I have about this patchset:
> >=20
> > 1. Should standard Counter component data types be defined as u8 or u32?
> >=20
> >     Many standard Counter component types such COUNTER_COMP_SIGNAL_LEVEL
> >     have standard values defined (e.g. COUNTER_SIGNAL_LEVEL_LOW and
> >     COUNTER_SIGNAL_LEVEL_HIGH). These values are currently handled by t=
he
> >     Counter subsystem code as u8 data types.
> >=20
> >     If u32 is used for these values instead, C enum structures could be
> >     used by driver authors to implicit cast these values via the driver
> >     callback parameters; userspace would still use u32 with no issue.
> >=20
> >     In theory this can work because GCC will treat enums are having a
> >     32-bit size; but I worry about the possibility of build targets that
> >     have -fshort-enums enabled, resulting in enums having a size less
> >     than 32 bits. Would this be a problem?
>=20
> We shouldn't have to worry about userspace programs using -fshort-enums
> since that would break all kernel interfaces that use enums, not just
> these - so no one should be using that compiler flag.
>=20
> So I am in favor of using strongly typed enums with u32 as the
> "generic" enum member type.

That reasoning pacifies my worries. I'll test out strongly typed enums
in the next revision of this patchset.

> >=20
> > 2. Should I have reserved members in the userspace structures?
> >=20
> >     The structures in include/uapi/linux/counter.h are available to
> >     userspace applications. Should I reserve space in these structures
> >     for future additions and usage? Will endianess and packing be a
> >     concern here?
> >=20
> Since there doesn't seem to be a large number of counter devices
> this probably isn't critical. Are there any aspects of counter
> devices in general that couldn't be described with the proposed
> structures? For example, could there be components more than two
> levels deep (i.e. it would need id, parent id and grandparent id
> to describe fully)?

I can't think of any devices that would require more depth, so we
probably don't need any additional members added to the userspace
structures. The current structure should be flexible enough for future
expansion, and any additional functionality we come across can be
handled by implementing new extension types as we have for the sysfs
attributes.

William Breathitt Gray

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+MTZ8ACgkQhvpINdm7
VJK9LBAAge9m8K8GflWtmFR6Fs3MjZ4VRmuFs6SXmkK0zYWPpaw0vy5Is6poej9f
p2hXz0EBxEVSdD+/hMmnyrz3VeLrRrSKN4iekMxGpScZoiyjeh0wy9J0kcv01zTd
jYR8Jm4lCJShMW20HFHUZXR3gUGTzXXB6jot2jDk+UMAkISYK7msNt4nmb6WsaU0
4QGpNZE0uznJN1PZ8pzv4NZ7LzZpf/HDDU6XgCIT9lWrQIbVXiOXG9aeXA0nL8cJ
WmBwtSZ5KQJo9Ijjo1Rn6zhNUoKMzF1wvGNEHvpvJDZ8n9x4ljyVh9FsEMUV9MC4
jWgJMA2+7vRbrheBqAuLTB2rC46xZuSr3cS7mu9sY+DO+LSNVafLWU8vjzzK5tfX
ahPxfm7Bz/lX8zhddNPWL1t7aNFMCJJdLAmRIlHewf9mdoE0n35ifyvOpgAACtIn
qFgr0TkpZdwq7TG3FCNqXRE80cw0YWZUIXeZr0MFoETzHPs50VvFDBQB/xKU1/wo
qdV2OZAn5bdfbk/DMqg9S61+H3KbujUgQZ+k+ANB4UMKYdo3QyNgBNUpFQgUqlp2
rqFuAZTNVG1VY2mJcA+8QJe4eQkn3oEGzgvK29ruiysk6nk/GjEhtJ8qJ+NLqw7q
HpTWR26ANLXz6Iy7izaSHM3jLiAp675Ej6bDzkZRf74d+RoKf5Y=
=oiqw
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
