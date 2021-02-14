Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6A31AF9E
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 08:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhBNHoW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 02:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBNHoT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 02:44:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260E8C061574;
        Sat, 13 Feb 2021 23:43:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b8so2005071plh.12;
        Sat, 13 Feb 2021 23:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lJFDyOVFIzN+lSGdT/cCAl7SuDxLtWJ/KKIMvOWbEd0=;
        b=KmeBx3fuHvhDM69/uSuMt7MhfBsVwl+QTBFKZl1KgfqJfalNfvZ2fJC1KEYig7ELw+
         JGn1Qiq9Ay00FApfvxpXVfAs8TZoLruvqW+OBNiKqflXyG78l6N4WU7LdmPtu7yLb3b2
         WN/EryXnuY+dgVbZdER5oLTixj2z9D8u9kyXPscnGi//6sd7t6AcAoHXoLZtv3LNK8mC
         GKQTC3zL+XV2wtEvSy1G1roOum2z4WAA/7no/yfadEspDgvgB41vR6yXQgN0G83kZvb6
         IGYSTJsIgkfhduvUnk40ElsAZ5Vmfh3SyhQH4XzJUMrwRAiQ7DNBwTu2WZ/U9F6PLXXu
         5wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJFDyOVFIzN+lSGdT/cCAl7SuDxLtWJ/KKIMvOWbEd0=;
        b=nN1oDjECIwJe97AyYFPMe2pY85tYtSLKclFfNdCFsgZS9gjed511vmpPeObc3bTYNg
         MGTcLmCB/VRr8qYHcX2azRJgAj+BmaLz6Y0+PErA2G1wREmbdCO6gAg3BQmQIP9zJeWm
         6HhEEd4LI8Dt02aNqquy627sXdcDHqnmC1b2ITQrYf/Q6DuyQiQfTUEG6KxWXCYf3wup
         b+FiXBDk4/ZX0v/6LHu2xwbU32sY6EcbQEhvLSWrEEvucgeMCDH2zDQ4nrytf0nZMqYA
         SEBvQz4RyZTsYRM76FDtbQg2bJR+XqJorzCJDuvPBWiqLPa79+jbNGlTOLkkFbHQZj/4
         HmsQ==
X-Gm-Message-State: AOAM530JgrJvQ6SLvW23oA49px/2HXcnlA1zKkcyagkOOsx/fWXcSM1q
        GxhFD3hdeQ5Hnq0erI10c9LQB+is+/fVug==
X-Google-Smtp-Source: ABdhPJyEl5N6rG1eVObDXTuVU5V4XEI8M3okUE+Z4xhvAVqO51VIYerOiU2YQ6q0F3jsRK0PAYJjzg==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr2602434pjr.74.1613288618381;
        Sat, 13 Feb 2021 23:43:38 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i7sm12795861pjx.13.2021.02.13.23.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:43:37 -0800 (PST)
Date:   Sun, 14 Feb 2021 16:43:32 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 0/2] add support for GPIO or IRQ based evemt counter
Message-ID: <YCjUpIXOcZocQdbP@shinobu>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P1Ca1DfqvS/NCoUH"
Content-Disposition: inline
In-Reply-To: <20210208135347.18494-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--P1Ca1DfqvS/NCoUH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2021 at 02:53:45PM +0100, Oleksij Rempel wrote:
> changes v5:
> - rename it to event counter, since it support different event sources

At the risk of bikeshedding, I feel "event counter" is too general of a
phrase to be useful here -- not to mention that the Counter subsystem
concept of an "event" does not necessarily correlate to unique
interrupts (a Counter driver may generate multiple events for a given
interrupt, or even events for non-interrupt state changes). Instead, if
I understand the behavior of this particular driver correctly, it is
more apt to call this an "interrupt counter" because it is counting
interrupts regardless of the source (GPIO or not).

William Breathitt Gray

> - make it work with gpio-only or irq-only configuration
> - update yaml binding
>=20
> changes v4:
> - use IRQ_NOAUTOEN to not enable IRQ by default
> - rename gpio_ from name pattern and make this driver work any IRQ
>   source.
>=20
> changes v3:
> - convert counter to atomic_t
>=20
> changes v2:
> - add commas
> - avoid possible unhandled interrupts in the enable path
> - do not use of_ specific gpio functions
>=20
> Add support for GPIO based pulse counter. For now it can only count
> pulses. With counter char device support, we will be able to attach
> timestamps and measure actual pulse frequency.
>=20
> Never the less, it is better to mainline this driver now (before chardev
> patches go mainline), to provide developers additional use case for the c=
ounter
> framework with chardev support.
>=20
> Oleksij Rempel (2):
>   dt-bindings: counter: add event-counter binding
>   counter: add IRQ or GPIO based event counter
>=20
>  .../bindings/counter/event-counter.yaml       |  56 ++++
>  drivers/counter/Kconfig                       |  10 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/event-cnt.c                   | 250 ++++++++++++++++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/event-count=
er.yaml
>  create mode 100644 drivers/counter/event-cnt.c
>=20
> --=20
> 2.30.0
>=20

--P1Ca1DfqvS/NCoUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAo1I4ACgkQhvpINdm7
VJJDLw/8Dwiip/OvRVt6b2J3aSHUjS1hmsJS8krQ2XXvWToPlbG3bYbGeO1hKHiZ
Pi7lcqivLAt/cudVuNHcH36Ts9LgmiqoAVJb4ODKQx1F96O+6Kx06+0mFusJJU3J
kIwT+4oB89TLEYWBBwkKr+L4W7MDk3XWPTKoh7yFAVdWlFf+F7WVdMmq1JHpHvBr
rpg3dQM5y58xJgJXiOyaN4fG+LknonSUJZpBkLq1Mq17AOWl8PcM1/kI6vPDhNpl
/Xv/BjYXQLQjIClexa8EG1t2U7YyjUF0/b4eITltm7LQSyXqKCq4I9Z7MUhWZvHA
u2S36lJzLFZvnCo0P+xx2lvmepr4M1CXpcRqIgeOqMS8j0htKSZv99Jn2jAIj/PA
h4fySHQiM4jzV07MM5kKlErQWmRTV4jtY1FwhJf6VGUUh+gGnhLXsaExlMTqlTSi
t1CKxMMWP5Lw0HqQoW53SHamRfM94OoNjEG9GladacznLtxhXcMF8HvWNIthVSSL
O7wjvCN1Nya2PJpFBKhTph4BTwMdKOF0KFSLxRNFMbKvrFaQdUzQQBIR21yaXviS
QKPaftkXqOZHDimpIvkin7u54BPYSBAvolUeS2ob0TlFjkfGSKkZbhpfVe8KZ33t
Yl+y9WAkxPt4oKsMip0ZyliukPfZiZC3OSUFrC/8hNVmr6P4T4Y=
=YStQ
-----END PGP SIGNATURE-----

--P1Ca1DfqvS/NCoUH--
