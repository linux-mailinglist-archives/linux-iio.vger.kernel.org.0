Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42DC3929A1
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhE0IfP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 May 2021 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhE0IfO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 May 2021 04:35:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1C6C061574
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 01:33:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so1921908pjt.1
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7WX1/w6KPDkIG1ULpvKnO+wjzisHhf2I9SnQJ402yOE=;
        b=MLLZOBAlb1LPNtpG5Shoft/ADiI7gN/595SmRNDhgQSqoWtzoQ6dIsesei+DKPLdmW
         G+OGlhagKoK8bcVF5TIi795BnsHiDv+Gw9YiAMpnKyAuiCO0u98O6noqUHrjkZXYNoNe
         khs09iJMNAeadN5DOTH0geRX9+oLW6hVepNCqfxrIi02MzWHOnuseq6PT26GWrsN/kJI
         CuhVLmzuAC4V8nciwtspNskQuW5qUh/gIe1N2OUwM7b09Dj3aBfhb3YcnlBvNphvOOW6
         K5Wc7DmqtGsTVUTMlCM8qX/ZeGLE6pSZOXtpVuVTXLQuNfKMAomz908xKGBcNYejdFvt
         RfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7WX1/w6KPDkIG1ULpvKnO+wjzisHhf2I9SnQJ402yOE=;
        b=kawoGzCS17I7c/fviDh+Rkg+XLwLArP1i8CDrKomvysyYss8HLBxJ6NVUN/KWadeqY
         E8ERu3FpfLj5xajaqqto8o+yzXxwsJ4O5Mu6ucOMpMB8w1FO5hhJB6fBfLaShSGslbeq
         ukS0paKdYzrQ7wIwEggpCSpgQ56f8zDZZcweztD0D05Rnn6ugvGJX1+dTMmpzT0JUUvN
         ymIhZ4ehyRnbWSey2IUvNilbJ96jYViniWPisGi/p58gtfod+u2wu02ZYbI/Cb8NmMW0
         4uS163lAcvjuj3Ae5SMw0vMFRDYPhiEIcm3cFwd4ezkKZXma3yyMq9rfvOtbOxdMzDL0
         LCBQ==
X-Gm-Message-State: AOAM532ZH2uS5hb3nl+j6Ia8+Jbduaa4dxeCUs62HiU1DdWmrZSpx23F
        8k2v5DxsPFcu4RILYBAxJD0=
X-Google-Smtp-Source: ABdhPJyHnBdbkwKK2eXsXCPIX+kAGZFrXiMysgfnGy2kSeGrjOPTXxgdVSzticYWenWw6XqXqxOIcw==
X-Received: by 2002:a17:902:8a86:b029:ef:5161:99e7 with SMTP id p6-20020a1709028a86b02900ef516199e7mr2268459plo.32.1622104419222;
        Thu, 27 May 2021 01:33:39 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id p23sm1306665pja.12.2021.05.27.01.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:33:38 -0700 (PDT)
Date:   Thu, 27 May 2021 17:33:34 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v2 2/2] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YK9ZXlKzfvj6P9f8@shinobu>
References: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
 <20210526150601.3605866-2-jarkko.nikula@linux.intel.com>
 <YK8BALkLzEp0CC4C@shinobu>
 <7610aa4d-23f9-9fe8-68c2-4a25d086c7a9@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aZWMHEI+LA1uVnQq"
Content-Disposition: inline
In-Reply-To: <7610aa4d-23f9-9fe8-68c2-4a25d086c7a9@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--aZWMHEI+LA1uVnQq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 11:14:06AM +0300, Jarkko Nikula wrote:
> Hi
>=20
> On 5/27/21 5:16 AM, William Breathitt Gray wrote:
> >> +What:		/sys/bus/counter/devices/counterX/signalY/invert
> >> +KernelVersion:	5.14
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Whether signal Y inversion is enabled. Valid attribute values
> >> +		are boolean.
> >> +
> >> +		For counter devices that have feature to control inversion of
> >> +		signal Y.
> >=20
> > I want to understand this functionality a bit better. So, this device
> > has two quadrature encoder signals coming in (Phase A and Phase B) and
> > this "invert" option allows the user to configure the device to invert
> > these signals in hardware before before they are evaluated by the
> > quadrature encoding counter. Users are able to invert each signal
> > independent of the other; e.g. Phase A can be inverted, but Phase B can
> > be left alone. Is my understanding correct, or is the inversion applied
> > across all signals rather than just one independently?
> >=20
> > What is the purpose of this functionality? Is this to allow users to
> > adjust the direction of the count without having to physically reorient
> > the encoding device (e.g. tracking counter-clockwise versus clockwise
> > movement)?
> >=20
> Yes, it's independent for each signal. Here Phase A, B and Index.
>=20
> According to specification idea is to remove need for board specific=20
> inversion logic. Which makes me thinking this kind configuration should=
=20
> come from firmware. As well as inputs swapped function. Which is for=20
> correcting possible miswiring of Phase A and B signals on the board.
>=20
> I'm now puzzled is there even need to have userspace visibility and=20
> control for these signal inversions and input swapping? Of course yes=20
> with my hacker hat on but for an ordinary Linux distribution point of=20
> view those inversions and input swapping should be set by the kernel=20
> automatically IMHO.
>=20
> What do you think? Should I keep these sysfs attributes in the next=20
> version or remove them? Though I don't have plans to add firmware data=20
> this time. It's nice to save room for future contributions if there is a=
=20
> real need for these features :-)

Hi Jarkko,

Right now I'm not sure whether this inversion functionality should be
exposed to userspace as sysfs attributes in this particular way just
yet. We should be careful in introducing new sysfs attributes because
once they're released we're stuck supporting them for the indefinite
future.

Because of these reasons, I think it's best for us to err on the side of
simplicity and postpone these extensions for the future if the need
arises; we can always add them later after this driver is stabilized and
merged. For now, let's remove these sysfs attributes from the next
version and keep it simple.

> >> +static struct counter_signal intel_qep_signals[] =3D {
> >> +	INTEL_QEP_SIGNAL(0, "Phase A", INTEL_QEPCON_EDGE_A),
> >> +	INTEL_QEP_SIGNAL(1, "Phase B", INTEL_QEPCON_EDGE_A),
> >> +	INTEL_QEP_SIGNAL(2, "Index", INTEL_QEPCON_EDGE_A),
> >=20
> > Is INTEL_QEPCON_EDGE_A three times here correct, or did mean to use
> > INTEL_QEPCON_EDGE_B and INTEL_QEPCON_EDGE_INDX as well?
> >=20
> What a facepalm... last minute "lets have a nice macro here and blind=20
> copy-pasting" just before sending this out.

No worries, I can ensure you I've made the same mistake as well far more
times than I care to admit. ;-)

William Breathitt Gray

--aZWMHEI+LA1uVnQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmCvWUQACgkQhvpINdm7
VJI+mBAA3L2WlaaLRUy1YhpI7E+t9NfkJMFnIh1qbrydJmlAHVWZSsRcwokCsXWq
pHwh9srjt3yya1y8UQptDywIIc5dUnCuVadb7/0sIoh2jD6QbxK4sEOsRQWOrZ3n
sbHOiLEZfc92nbjgpjy+kUNYU3Iq/nD9i9p6WqFvOS1l+rP2+xQU2ezZRMITL0o2
QnJChqPPCeWetQOWe9Cy54zOFCTo+YcaPRcLnaKLFU1r53jCCsgxg0CDyl48lapS
ywyS2W9Jqg+BrnqbOaz9dJAHsKM8lvfR+lgOhN0ELCyr74ENFx+hGb4aIQ5SNXaa
P0W58CoLozse7F4iZcb285DJSTBdhaCJllXxy992afVwlBe9hWBX0viQ7cgzra2R
w9gw31vSS7XBFy4r0aHWStz2d5nhZkG39r1IBFAaZNRoGe2DtIE5Z8wqekMZSQEL
B2JZcFK1eN6uzymtVkKwo8Alru/DNrGWnYRJ8J9usz+qRIKIkVg8RvceJICXv9ia
hY780xxWsoQD9TqtHcbnqym9FK1GmDtYQuqu7EAy+vLicSmwoDAxZryuhdLq7PKC
VxFCjK7qoBS+/VNUKPY5vJiS59S+sCuUs9Q7tOSORv3laY6Zs3UguC+EwPHovqGg
NYnP8XftY2Xo71YLCymMQq+0sUUqJRxpTjiyznPovVllUy3gOcQ=
=hFbk
-----END PGP SIGNATURE-----

--aZWMHEI+LA1uVnQq--
