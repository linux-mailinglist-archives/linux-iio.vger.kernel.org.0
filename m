Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD2398CAD
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFBO0n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 10:26:43 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:43918 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFBO0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 10:26:42 -0400
Received: by mail-pj1-f50.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so1892160pja.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vxjNoFRnVQzEvnaa4Od1YyaZ4C0NbV3WZkG41+0F7ME=;
        b=nnyqEnfYqZtlJVqBKPym26EqhFv4ZwFAt1KwO2Ibhj7lscFcWUrz27rhUKlZ3/pPPq
         fxyRnOovQkxbs7c2PBsTnbIi/EY0m68NkKNGxopMLia+RZ+oP904k9orOnkbUQu7Bmp3
         DsW0AoZgiWnCAoKA2lGsMo7gp93NI3ywiTViEA8aitBTDsZyYmUlz5Z5G1tLXxw2hpiY
         eA47vg+uiH4c5y7KehSZi3OFgNA5EWUKbgxyMLBCLcaAlcjFyry+PIvqNhos041wIqtC
         nd04bUMfFYdZmSkwdroS7XhZRxFQh1Te1JBXr5pxv8M3P4gfdlVxZXZHtqLtSlG+iuqU
         hIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vxjNoFRnVQzEvnaa4Od1YyaZ4C0NbV3WZkG41+0F7ME=;
        b=TOJ54WjpbUvnH1i1HZfJdpop3n60/D9zdTmUI0JCscup/U7W0OHLFK2mf2ckt0V7I8
         4dTerZESftQnmy+E2u4H7BzCMTbwVXWRJ6CZ2vcz7stxw97S2I0LnRlcP9NriEe5tcnv
         rhKmhcD7dHfwuTzZmmFu0ZetlWXnWISRGoTUTmgy/VY/G8JlAB4kPfkAA6IwqJTqLONf
         4KxjD+EqUOWf3QKdNAHT4kKZXAqoSNoR021zUtvqdm4Q5pXUWubt3yqmqm27Lccz4gxk
         9fhGcFczOM2ohtVMFWZsJyDo3eAocu8qvIMXsLG/ZaTxAf1Agtx8Y1zM6v8M2rtB1ZHL
         8fRg==
X-Gm-Message-State: AOAM531UnW1IIDoJv5SA8K9qMODHjH0opurw50OhESnFEokSrTgMeMES
        4dlNTHxcJ+f96IcKCll4vou+BMtNeIbFDw==
X-Google-Smtp-Source: ABdhPJx+TtlXRhntd4S0dNqOvhEKHY9yWhMRoUAs9emDwXeQAJcbWuJU/o7w8IbCfCIopFzqU+N7fw==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr5838527pjq.125.1622643829896;
        Wed, 02 Jun 2021 07:23:49 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id q18sm4789968pfj.5.2021.06.02.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:23:49 -0700 (PDT)
Date:   Wed, 2 Jun 2021 23:23:44 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v3] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YLeUcMWM7pSRIFhO@shinobu>
References: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
 <YLcDJ+ZI1fXRpFRe@shinobu>
 <d9dc416f-100f-3fb8-d250-3aed8ca8f10b@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oMdAczc/ZUz0nEcS"
Content-Disposition: inline
In-Reply-To: <d9dc416f-100f-3fb8-d250-3aed8ca8f10b@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oMdAczc/ZUz0nEcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 02:41:29PM +0300, Jarkko Nikula wrote:
> Hi
>=20
> On 6/2/21 7:03 AM, William Breathitt Gray wrote:
> > On Thu, May 27, 2021 at 04:58:38PM +0300, Jarkko Nikula wrote:
> >>   Documentation/ABI/testing/sysfs-bus-counter |   9 +
> >>   drivers/counter/Kconfig                     |  10 +
> >>   drivers/counter/Makefile                    |   1 +
> >>   drivers/counter/intel-qep.c                 | 546 ++++++++++++++++++=
++
> >>   4 files changed, 566 insertions(+)
> >>   create mode 100644 drivers/counter/intel-qep.c
> >=20
> > Hi Jarkko,
> >=20
> > I noticed the intel-qep.c file is missing an entry in the MAINTAINERS
> > file. Would you be able to resubmit this patch with a proper entry added
> > to MAINTAINERS so that users have the relevant contact info to reach the
> > maintainers of this driver? You can keep my Signed-off tag on as well so
> > that we know the code has already been reviewed.
> >=20
> Ah, added now. I sent the update and didn't dare to add your signature=20
> due the sidenote below :-)
>=20
> Sidenote, to my understanding Signed-off-by requires patch went through=
=20
> that person and Acked-by is used when maintainer accepts the patch but=20
> another person commits it with his/her Signed-off-by.
>=20
> Jarkko

Is that so? I'm not really sure myself of the particular nuances -- I
wonder if there's an explanation somewhere in the Documentation files,
or if someone else can explain it more in-depth. Regardless you've made
all the changes I've requested so here's my Ack for your troubles. :-)

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--oMdAczc/ZUz0nEcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmC3lHAACgkQhvpINdm7
VJLUgg//cNCtuxaVXurps0OUiMDHQD+aaZ5GPptazgiFl9qKt6yvdwFNw9mrcA1u
TWrOq4dreZOiigm0DNJXqxAxgJUzAyfq0okaqIYpSKtOxLNa1zI0A2dgOdT37CSs
DwCcL+w+fqIWajwnls1DCk5dVtykchnpJEkTzus9cDhxsaJuyPJlUnRIcZTCMoNx
Bf+xc9oCwKuBeRBmykyk9TTRBXhbI/swuMBLli7msKtq+Kwo/iH9XwO47zd+dXUb
4rdqR6j/vBb5hzRZnX43jkkWIUeRlhNCXnux51Tj5oiNAk07XUBn38EWTJQmhha5
Iij6GFoJqbjXVg4UzjaCnbkY2HcUHEpLZouzfhuLxb3JeuMgSnX7KMYSqdonuoSK
bD3pSmibxoeU9+TNsazEGBA/HxDfgVD3FVWFClLG+IWrJDRiOQQAk5o97QkZx1f4
F+WKoY4hGLFlNT/5lC/yjiB7t7CPQDQ4KSxtEqPpmQjfJjhY3ue7MHRjfiw/jt+u
gWRUsHjM/kFw/NLHY4c5nwBBpp5HjewTDsMoVOFSjq75TJJ5LkRjgOP/p6NtfcIi
8r3gLdqnj1BApHrfyQxgSUmmGMsVzRuzLA3i+8FtdDHmeMjawUvJzy1ipB5cpbyM
KY167EPk2sN8/VoGu02JrjPC5BpWLXM6r7+lFYGuSniud6C8jw8=
=BbQK
-----END PGP SIGNATURE-----

--oMdAczc/ZUz0nEcS--
