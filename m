Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F433C5B0C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhGLKvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 06:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhGLKvV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 06:51:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE1C06139F;
        Mon, 12 Jul 2021 03:48:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t9so17805433pgn.4;
        Mon, 12 Jul 2021 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ESPXz5y1c2khlg1Rn0L9i5TuNerGKV1irqF9zD9bF5M=;
        b=YLFo7K+Y5jNmz3M7zsM6opHRT/H1FDsq+SeD+U7kY0BOrONZ6GTK0Zu6dXJcbzhn4m
         eAWls7qlyNxlKoydExwKxmwLMIyuz2uweBUogCV2Qz5VQxh7c+B52OBLDl9tgzk69ept
         ubgwme4jvZMOYxm7s1soZwQtKTRkwkU7QTWCiuefmW/heZjJVOtPc+StMQCetsyKkDCr
         lGirw8hTQzQIqH8OSy5HQQkoiviRFdVKm+EdVXz7heKsBHGfhibopwrX7IMNluCfx+up
         5UcrLy6Sh0Olx/LfkvU+8vt10Nyn5sto2U1nitQDN/ngqj5lsOdsoYWsFvd2UXm+oQlt
         Pfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ESPXz5y1c2khlg1Rn0L9i5TuNerGKV1irqF9zD9bF5M=;
        b=atdgZQ1x1BsfgxBy0wrNWY3xVkPSmVYbWM2d5bGy70xCNXCxfw6R6RziQv/kQBL7BT
         /oSoakKT3xHi9F7niAStbVgmrJBRDm0LR0Oo/BRZwL+Iiy7OMVE9BwJx8bkAqISNr+4O
         5K6hO6hjJd3fzD7UTqUepkXERGCJgdOt0/tyKRWEw05J+6h6oIyhpsGMgYCbBhFexLw3
         0cvas7VpOe0zzLAP8uwqU/KP3vqE3/XLINWBv2UHI1CpvNS6SwndEGVZqRhhEi8bm9Uu
         MOGdnkiyz5Wno5QSl3b/tFFNyiHJj4xTYbqGbikyGmVMKzp0oAhQvPmdeSVlhD76QKWE
         IGdw==
X-Gm-Message-State: AOAM533ChREU6XPVIJJNGfQIVajBf5koIrDS0JNvLpRQX+5Iwhp1BSiG
        zJ2sIry/750xrajXVzxPK2k=
X-Google-Smtp-Source: ABdhPJwlgRt1pAolTWnhq4aL43Ac7wLCqMdkczwSCzNih0XOJ1UaeY22kjHwxod3K1Fi0SG+mXGs3w==
X-Received: by 2002:a62:bd1a:0:b029:2fe:eaf8:8012 with SMTP id a26-20020a62bd1a0000b02902feeaf88012mr51314180pff.45.1626086904813;
        Mon, 12 Jul 2021 03:48:24 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i8sm15269574pfo.154.2021.07.12.03.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 03:48:24 -0700 (PDT)
Date:   Mon, 12 Jul 2021 19:48:17 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v12 00/17] Introduce the Counter character device
 interface
Message-ID: <YOwd8aL+K+U+9GXz@shinobu>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <20210711144828.795ca342@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4C9OArlWXnF+XzXG"
Content-Disposition: inline
In-Reply-To: <20210711144828.795ca342@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4C9OArlWXnF+XzXG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 11, 2021 at 02:48:28PM +0100, Jonathan Cameron wrote:
> On Mon,  5 Jul 2021 17:18:48 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > Changes in v12:
> >  - Move unlock to after register set in quad8_count_ceiling_write()
> >  - Add locking protection to counter_set_event_node()
> >  - Fix sparse warning by using {} instead of {0}
> >  - Clean up and organize comments for clarity
> >  - Reduce boilerplate by utilizing devm_add_action_or_reset()
> >  - Use switch statements in ti_eqep_action_read() to make possible cases
> >    more obvious
> >=20
> > I pulled out a lot of bits and pieces to their own patches; hopefully
> > that makes reviewing this patchset much simpler than before. This
> > patchset is also available on my personal git repo for convenience:
> > https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v12
> >=20
> > The patches preceding "counter: Internalize sysfs interface code" are
> > primarily cleanup and fixes that can be picked up and applied now to the
> > IIO tree if so desired. The "counter: Internalize sysfs interface code"
> > patch as well may be considered for pickup because it is relatively safe
> > and makes no changes to the userspace interface.
> >=20
> > To summarize the main points of this patchset: there are no changes to
> > the existing Counter sysfs userspace interface; a Counter character
> > device interface is introduced that allows Counter events and associated
> > data to be read() by userspace; the events_configure() and
> > watch_validate() driver callbacks are introduced to support Counter
> > events; and IRQ support is added to the 104-QUAD-8 driver, serving as an
> > example of how to support the new Counter events functionality.
> >=20
> > Something that should still be discussed: should the struct
> > counter_event "status" member be 8 bits or 32 bits wide? This member
> > will provide the return status (system error number) of an event
> > operation.
>=20
> Hi william,
>=20
> I've looked through the lot and where I haven't commented, I had nothing
> much to add to David's comments.
>=20
> I'm not planning to go through the whole thing again unless major changes
> occur. Fingers crossed for v13.
>=20
> If it looks like there are still some unresolved issues after that, perha=
ps
> applying up to patch 8 or so makes sense to reduced the volume of code you
> are carrying.  Let me know if you'd like me to do that.
>=20
> Thanks,
>=20
> Jonathan

Yes, much of the code has remained stable for some months now so I think
we're pretty close. If we do need a v14, then applying up to patch 8
would help me a lot (most of the merge conflicts I encounter when I
rebase are due to the large subsystem refactor in patch 06).

William Breathitt Gray

> >=20
> > William Breathitt Gray (17):
> >   counter: 104-quad-8: Return error when invalid mode during
> >     ceiling_write
> >   counter: Return error code on invalid modes
> >   counter: Standardize to ERANGE for limit exceeded errors
> >   counter: Rename counter_signal_value to counter_signal_level
> >   counter: Rename counter_count_function to counter_function
> >   counter: Internalize sysfs interface code
> >   counter: Update counter.h comments to reflect sysfs internalization
> >   docs: counter: Update to reflect sysfs internalization
> >   counter: Move counter enums to uapi header
> >   counter: Add character device interface
> >   docs: counter: Document character device interface
> >   tools/counter: Create Counter tools
> >   counter: Implement signalZ_action_component_id sysfs attribute
> >   counter: Implement *_component_id sysfs attributes
> >   counter: Implement events_queue_size sysfs attribute
> >   counter: 104-quad-8: Replace mutex with spinlock
> >   counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
> >=20
> >  Documentation/ABI/testing/sysfs-bus-counter   |   38 +-
> >  Documentation/driver-api/generic-counter.rst  |  366 +++-
> >  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
> >  MAINTAINERS                                   |    3 +-
> >  drivers/counter/104-quad-8.c                  |  728 ++++----
> >  drivers/counter/Kconfig                       |    6 +-
> >  drivers/counter/Makefile                      |    1 +
> >  drivers/counter/counter-chrdev.c              |  498 ++++++
> >  drivers/counter/counter-chrdev.h              |   14 +
> >  drivers/counter/counter-core.c                |  182 ++
> >  drivers/counter/counter-sysfs.c               |  953 +++++++++++
> >  drivers/counter/counter-sysfs.h               |   13 +
> >  drivers/counter/counter.c                     | 1496 -----------------
> >  drivers/counter/ftm-quaddec.c                 |   59 +-
> >  drivers/counter/intel-qep.c                   |  150 +-
> >  drivers/counter/interrupt-cnt.c               |   73 +-
> >  drivers/counter/microchip-tcb-capture.c       |  103 +-
> >  drivers/counter/stm32-lptimer-cnt.c           |  176 +-
> >  drivers/counter/stm32-timer-cnt.c             |  147 +-
> >  drivers/counter/ti-eqep.c                     |  205 ++-
> >  include/linux/counter.h                       |  716 ++++----
> >  include/linux/counter_enum.h                  |   45 -
> >  include/uapi/linux/counter.h                  |  133 ++
> >  tools/Makefile                                |   13 +-
> >  tools/counter/Build                           |    1 +
> >  tools/counter/Makefile                        |   53 +
> >  tools/counter/counter_example.c               |   95 ++
> >  27 files changed, 3501 insertions(+), 2767 deletions(-)
> >  create mode 100644 drivers/counter/counter-chrdev.c
> >  create mode 100644 drivers/counter/counter-chrdev.h
> >  create mode 100644 drivers/counter/counter-core.c
> >  create mode 100644 drivers/counter/counter-sysfs.c
> >  create mode 100644 drivers/counter/counter-sysfs.h
> >  delete mode 100644 drivers/counter/counter.c
> >  delete mode 100644 include/linux/counter_enum.h
> >  create mode 100644 include/uapi/linux/counter.h
> >  create mode 100644 tools/counter/Build
> >  create mode 100644 tools/counter/Makefile
> >  create mode 100644 tools/counter/counter_example.c
> >=20
> >=20
> > base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
>=20

--4C9OArlWXnF+XzXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDsHfEACgkQhvpINdm7
VJLk+g//YfH/GBLnKtICCwZQ2UF4svFlAv69fbT+wssz23VkBOpKtx9UVvy+rsMo
B4gkt3ipqYDwJC+tLMBl2KvXVqgrIlMP0vLOzEWz/PzKZinJMbRS1wMsuGPOWkxn
PNZJ+rrcmsgQzTRoJlrx9szsEz4kGepvCpbrYmTxWaY/8RxeSNUMWPgOndrQ89Cp
bFCRddrZ2tjEbuY+88OSBCAFzIvN1/fgXRxt6JhRBB79dEdtBz1xAIHZFBsLPWeC
3eKYjOc5dUhuFlcEFLg9SiH317VbNF7SMzJUzWrIr+hBBms1eZvLJ8RQbu80FcPu
T01R9iZcOiNFDbAsnhtUstF/8WrMwBeAEe0aIh70H/Pu9cCAtWucJEO87GrFmSfC
iGZYZPlvaWXi55nU4aNbz3QViiLlu3JQV2L2fNTXSvvdWGFNgWXetu770CtbOXSE
I23l6ixwWUnuRFEn/Dh2xbpDY3i41LQhVjXtuvxrVOusjjmB4uesuV3yyfvGYN37
fvNWdiE8GBJ0DeLbIkwTUBUuhhRjJFF12qvNvtuJxZSDZ764uvqoTsKAqhWot9df
16uF/hAD3dAOo6nSvCFqS8Nj+bB+E/YCbGuuRP5PyfVoOK5YikQ7gUU/SZMdO5tv
M50D6TdabsoKWNrJTJgAqmfOWwMxq9I8yNY+MpPIDK4U+ykDoM8=
=Ud8E
-----END PGP SIGNATURE-----

--4C9OArlWXnF+XzXG--
