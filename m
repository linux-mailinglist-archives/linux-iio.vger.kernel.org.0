Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE38E1DFFE9
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgEXPf7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEXPf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 May 2020 11:35:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B69C061A0E;
        Sun, 24 May 2020 08:35:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y16so562444qto.4;
        Sun, 24 May 2020 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XSCyThDWyT3fRTEHc54P7I+5QHzke3yyM7FEulzWvu8=;
        b=YR6PZ0L19epbm54KSIM6jkDTWp4P7VfPRm5s9CPSLA5FHrEftyANl9d+s3YeuNnsy7
         JWythQbTQyISwhHYEKUJbb81KkDsS0TkezrJzD0chKFVa2NgH7COgHoyyOhW8n/Zz7Le
         qE8RsUHAE8v5P+LC0H47nX/7rpYWgyjTIxk3EBFD6Xdq1iY/KwMXil2yxMrBBhgLA66R
         g7YFYBDW6CTm5UyiiT6z5wpwI5ctLdYPCOliVJRLpk5i/ZHX9DqUUDgdteeMxuboittP
         cDQawHSbAZkLtpCdGkcu0fpgqZGfLzm4OAHqA6i85n7z+FRybiMA4NTroioqGuJqiqaq
         wshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSCyThDWyT3fRTEHc54P7I+5QHzke3yyM7FEulzWvu8=;
        b=mtN2mKgQo4B0S59QNEes5EFU8X0xP8CbvtYWU20Icu1lCqdQU/qxgVpWRvQUgYo3CH
         Yei5+7gXUjUjlNZn5K0itsJiyyZn6m38cVE1pO3bEhbJbt3UWXJB6P9tP129ACZJ/43u
         /IML16pQ0Z29GryN07Sh5Yj/NqqepWH3C4RcHTxVYBioNya7VlLZYbmV1JeIi/PQVuEK
         VqiwwiPQRf6ZMDtCfrkn0avrlr09slmEwTKANwcJ/3HE7YSFOAlrqmtxJzxDKL9PEb6l
         tqdBLJm8Jn9AtrqqqN3gOnNCoB+0OUQf/deaU6MkDZtx2Brppeg6agpxgq1wXpvbbjyh
         0AnQ==
X-Gm-Message-State: AOAM531GW/C9FT2D1f5co7YRrmX0Ts76zqM5z0Ra5TX9DeH5AZ+nGl47
        T8I1M+58I0lWDsCnfKy8eGrglFH72uIRHQ==
X-Google-Smtp-Source: ABdhPJzcdoAUJKNz0W5YPodIcHyX0Rwi2/R6t/LiimRGcL49J8cUWFiqg5PdX9DFLQiPedJJRgqhFg==
X-Received: by 2002:ac8:7b2b:: with SMTP id l11mr24573932qtu.307.1590334558128;
        Sun, 24 May 2020 08:35:58 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id g5sm13165613qti.87.2020.05.24.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 08:35:57 -0700 (PDT)
Date:   Sun, 24 May 2020 11:35:38 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/5] counter: Add microchip TCB capture counter
Message-ID: <20200524153538.GA12461@shinobu>
References: <20200519083716.938384-1-kamel.bouhara@bootlin.com>
 <20200519083716.938384-6-kamel.bouhara@bootlin.com>
 <20200524161624.2c932a30@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20200524161624.2c932a30@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2020 at 04:16:24PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2020 10:37:16 +0200
> Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:
>=20
> > This drivers allows to use the capture mode of the Timer Counter Block
> > hardware block available in Microchip SoCs through the counter subsyste=
m.
> >=20
> > Two functions of the counter are supported for the moment: period
> > capture and quadrature decoder. The latter is only supported by the
> > SAMA5 series of SoCs.
> >=20
> > For the period capture mode a basic setup has been chosen that will
> > reset the counter each time the period is actually reached. Of course
> > the device offers much more possibilities.
> >=20
> > For quadrature mode, both channel 0 and 1 must be configured even if we
> > only capture the position (no revolution/rotation).
> >=20
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Looks good to me.  After reviews from William, DT and maybe
> something from SoC side if intent is I'm taking this.
>=20
> Jonathan

I'll defer to the DT maintainers for the dt-binding changes. Regarding
this counter driver, I believe there have been no changes since I
signed-off for it in the v3 patchset thread. If that's true, I haven't
changed my mind -- I'm still statisfied with this particular version and
have no objections if it's merged. ;-)

William Breathitt Gray

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl7KlDQACgkQhvpINdm7
VJIzLxAAkUJg6LHVXHAStbGJFDBPydEKceoWzIEgLZ/vm3dG1y7LyBGkng33mKQS
MtCM5M9/l+WF1cy6xhfAMaq2A74pPRnGmYaNuMov44MnHeTezlv6udD3nn9R/Dyz
S/a0ZGI+ASgY4RxvomRWiQCe1lP9Fx4EQGxjL+1Q+f1+Z9RlpAVwO+2ayGWhmu3u
NDT3jF4KKpgQuSBQb4HHC/3MUgEuAn5tg6YIND4eP8sZ31C+HvY0AReg9G2pILEF
ISxHTZEJUFQ2W1KFBhoytEueebjUzXLFe9DUGJ9oRkL2FyCt6SNcKajFHkNQ3cKN
dh514IIQ2MoUHXS7775y08Ad3AHhRVyBAuLCoyAqeUlvxZbmrC9uGpvYq5sudDbH
MoPGTAOwJUTEW1Qk+K3S9b20ebNYxkchClt19QeGhV9Inl9NJAFnqWwu9rTujO1n
YXjjZUCioWFt80v+lkuEgIVE3ZKxFNAL4RdTBH1LvDYTgJiCh+0OOsDmv4Vxzjee
jVWxMcUyHZ+rXb5roWmqUkWoWgynTBEnZP1B+22NfLCTsffATOkFKIvGwx1Nmgo5
6EQSrIDVSXYa3xoIBTcIfQFp7CDCOf1CwkxjRtKSBjoXpzW/zU7AnVAwZJIJMArN
1SiaQaG7ZMWQO4o6qjfACamGAvH1H8AUvryTYVy/MwTZOVZQYoc=
=ENit
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
