Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1096C398D49
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 16:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFBOlq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 10:41:46 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:46723 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBOlq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 10:41:46 -0400
Received: by mail-pf1-f174.google.com with SMTP id y15so2315780pfn.13
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z7wnDZeKfMuozrPjOOOWNFQiu1XiXNRamAu5LwSlU0U=;
        b=BhVwmZLMaAnf5gUjIck9LoDzm44Hf1nGKOvv3xEZJFY2akHQh412fDf6Afe/ADE8bd
         P0kCKGjtiygG8f83XIRjzgf3uAi69VVg6Vs7m746m9bH2eHqkYok7VqWOcSrHEwM/Yxr
         16sAuxO6q2SJlaxw2tcBYbtKTuUpQoS2Rsbu8FuPPeCbjzoFOQwLTbsHsNvSkkvZXhKy
         hfWZAYe8gNptOxxl5RrfXafBr4SNDvChyI9gLg+OITbf3pC889AT6psXhibd1NkLtzAo
         cj3hmu75QWlNGQXhOyl1bInjcdOwQ/RHWLMUbZ4NC6zcvUKW0+P/LhAM9Mjkcgr9J62H
         CI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z7wnDZeKfMuozrPjOOOWNFQiu1XiXNRamAu5LwSlU0U=;
        b=YbU+wzwPBT74R16Ae2DL+2YVC9Y8I8f7w6URLfXjtZP3f0O/kOSPlHgAck9mBlyiqP
         R6qIqkrw+375T/REE1cjXIGa3vDjjsQu11qMAd2PXq/uNa6hvoC7Mgjrymy5nsGlFBa3
         65jEi2Q07T7hmFdLzaFDPIMZ5R3kVYHYDf2YlfomDmqk06IZYEH+7WEOXm7EDzUQLq3Q
         Y7/kEFIVaZs/o1cY7MwryLAsNL6lbSEtm3GsdhjqqW4ruEDx0Ro8JC7tmDTgMmJwmWQz
         Fq1BGpXhmTOlgTKlQH4kH1PTWoRIJITlHyfLBoGCEVO/VdLcEpig4Xksczwd2MSvtQGJ
         dx5g==
X-Gm-Message-State: AOAM532/Lcun0oKh7akt6kAtLLzoGhWRECKD6eoa1J4OwreipDAU9t+q
        jWOK7V6da1s7pUHSkjhvyhEzHCPilrZt+A==
X-Google-Smtp-Source: ABdhPJzeiPY1AAk3N+vupsFGWPEWAeZzb6TUIUlhdj4DAefltmwI55CDJ7RN7WBO0CCaaZNhz+MOEg==
X-Received: by 2002:a65:624b:: with SMTP id q11mr34161994pgv.375.1622644743682;
        Wed, 02 Jun 2021 07:39:03 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id j4sm5095345pjv.7.2021.06.02.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:39:03 -0700 (PDT)
Date:   Wed, 2 Jun 2021 23:38:58 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v3] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YLeYAiKHHjk6Ucv8@shinobu>
References: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
 <YLcDJ+ZI1fXRpFRe@shinobu>
 <d9dc416f-100f-3fb8-d250-3aed8ca8f10b@linux.intel.com>
 <YLeUcMWM7pSRIFhO@shinobu>
 <20210602153706.00003bbc@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4stnZyexDvAXH6q2"
Content-Disposition: inline
In-Reply-To: <20210602153706.00003bbc@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4stnZyexDvAXH6q2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 03:37:06PM +0100, Jonathan Cameron wrote:
> On Wed, 2 Jun 2021 23:23:44 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Wed, Jun 02, 2021 at 02:41:29PM +0300, Jarkko Nikula wrote:
> > > Hi
> > >=20
> > > On 6/2/21 7:03 AM, William Breathitt Gray wrote: =20
> > > > On Thu, May 27, 2021 at 04:58:38PM +0300, Jarkko Nikula wrote: =20
> > > >>   Documentation/ABI/testing/sysfs-bus-counter |   9 +
> > > >>   drivers/counter/Kconfig                     |  10 +
> > > >>   drivers/counter/Makefile                    |   1 +
> > > >>   drivers/counter/intel-qep.c                 | 546 ++++++++++++++=
++++++
> > > >>   4 files changed, 566 insertions(+)
> > > >>   create mode 100644 drivers/counter/intel-qep.c =20
> > > >=20
> > > > Hi Jarkko,
> > > >=20
> > > > I noticed the intel-qep.c file is missing an entry in the MAINTAINE=
RS
> > > > file. Would you be able to resubmit this patch with a proper entry =
added
> > > > to MAINTAINERS so that users have the relevant contact info to reac=
h the
> > > > maintainers of this driver? You can keep my Signed-off tag on as we=
ll so
> > > > that we know the code has already been reviewed.
> > > >  =20
> > > Ah, added now. I sent the update and didn't dare to add your signatur=
e=20
> > > due the sidenote below :-)
> > >=20
> > > Sidenote, to my understanding Signed-off-by requires patch went throu=
gh=20
> > > that person and Acked-by is used when maintainer accepts the patch bu=
t=20
> > > another person commits it with his/her Signed-off-by.
> > >=20
> > > Jarkko =20
> >=20
> > Is that so? I'm not really sure myself of the particular nuances -- I
> > wonder if there's an explanation somewhere in the Documentation files,
> > or if someone else can explain it more in-depth. Regardless you've made
> > all the changes I've requested so here's my Ack for your troubles. :-)
> There is quite a it in https://www.kernel.org/doc/html/latest/process/sub=
mitting-patches.html
> =20
> >=20
> > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >=20
>=20
> Reviewed-by also fine for this case given I know you are the maintainer
> and will only give that if happy.  Exactly what the meaning of
> Acked-by / Reviewed-by when given by a maintainer is a question that
> has been hotly debated a few times in the past.
>=20
> Jonathan

Thanks for clearing that up for me!

William Breathitt Gray

--4stnZyexDvAXH6q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmC3mAIACgkQhvpINdm7
VJLvVw//Xi9YaYb6AO/wp8sNFgIVR9k4Vr5sZJlLtt7et13jaVJ7QQa/8IDbu0Uq
KHYYE1UwLyG2itA9wnHVUpRKErnZr6SgL1Pp8ckQf0knUlgrfhilndfrUcgUOesW
l0jygQOgabcoZnGKClYeyoQbvYizbrZyK7DEZ1gU+rL9nhE+W3mXAfvHhtTSHBJs
PMM/3Dd+uXICgcUQUGjeolFtBOExLQj3GsQ1ZHxAjwuc0B5ledl4l/lVWEmHIo+1
xnu+263DZbVJ9SMGm5/824dfYGm9Wgz5rprqZ4HmIrsptHbyJuJ6R7ClVZEP3Oq7
QAU4iKU7FgBU2Xo2SZOo+FZlHhSZP/Sg86TYHfowT//7AA3O6jQzWRxK1kJdMByv
7fi8JThsbzUkGIrVSA4uvJuTF5sLjqMyR847doqE/oFtfCZzjDSmfiwayUAojOFn
+Y9IqGtdPhVajOB7xDIqfASIKqqVJJF71UuITt0E+rJooKkIzcm2Tj2JDw+ebQPr
/lECtqTOF8VMGUrCzHWEorJ1NmZ2OOXpbibsbI+2itq2G/APG4SoKTRVq1SBSxbW
EYGmXtKx4fX8FF0lnC6UVfUgrJ81T3h6h1b/enYuvUFE8AujIPmg2qwtVWt0hlH6
urWKK/Zxl7QC5+OtEo0Nd9TSjhyBhrDwC5XMTQfJLlgmvJ892Io=
=qwfY
-----END PGP SIGNATURE-----

--4stnZyexDvAXH6q2--
