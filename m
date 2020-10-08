Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819DE287424
	for <lists+linux-iio@lfdr.de>; Thu,  8 Oct 2020 14:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgJHM3C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Oct 2020 08:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHM3C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Oct 2020 08:29:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00228C061755;
        Thu,  8 Oct 2020 05:29:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id y198so6751112qka.0;
        Thu, 08 Oct 2020 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+T+Mlm/JCxCYUqi0t2sTT67u00gxB27VW90eip5Nu4=;
        b=GWZH4Wsc2aHIRWPhTfI/wUW1Cvrdnj7YM0r+U76Azji2t1Q7bjTZ8EBdQEZps/R8EA
         ak/CwZurudp06MPVVduv2rKZzDw1sosX6CPZHd+gqkVcSi3gIMaUb+/yF/6Z5qU2vo//
         MCsjt1+d6bQLCFMXcs9wf9bCJJAi1UkxqjSsj+DD8ppuX2C8BwcCoDmCXYUZMooodgg5
         xKUUOZZYiqygUgjxAeHAzJZkoxLa0etoSJHbSVtyJxe+DcJo5fvgYgwzCSw4j93b1KDw
         ilYKaxchkMZMP4paXNLq+yefqbXz/vTQ1QXK9V6QV++9U8gyG3kbYrVLMs0YOZ/7PR/A
         sC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+T+Mlm/JCxCYUqi0t2sTT67u00gxB27VW90eip5Nu4=;
        b=avZpE+PFKQWwbAIG/i5mkz61kKizybC/6itbdJSBQQUpyS1soCfc3BrcZmMqSu3Iqt
         gfDVSiJOGKznene6dIaDmjf9McFyKmS4NtGmJGUU+y51MWXY8qF3zlwM9+lJIfKjGxfg
         joqVFqxH5uW5xGdKx4Cq7Kbs7AQ353H+peonIXuPJS8KNPMTW6oc06qg2M75M6DHzx1s
         ccqHT9RFQ5jTQNhI/K2LHZLmAGgu45eitaIX019RSZyH9Pgm4anbsT60HiiZez37fbs4
         UlYbS4NUyevzQqFVnYNPotPrTQpNXF24HV79lzcuZHusZaGHgn6SAd/YvPBcLaZvCTCJ
         DJow==
X-Gm-Message-State: AOAM533AHXXhzdkqwMjYKlAX441sSUwVoEABC9OWcHWyRPPFXwKS8nOz
        vOjzOQNJWkvL1oflsF0Kfdg=
X-Google-Smtp-Source: ABdhPJwUp1exFR9P/8N0SjYBSQyJ3/neiSlBncodafR8VBncaGZtGzbfV8NnSx5b2OLKgJHopawzIw==
X-Received: by 2002:a05:620a:99d:: with SMTP id x29mr1825111qkx.415.1602160141227;
        Thu, 08 Oct 2020 05:29:01 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id 184sm27349qkl.34.2020.10.08.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 05:29:00 -0700 (PDT)
Date:   Thu, 8 Oct 2020 08:28:45 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 4/5] docs: counter: Document character device interface
Message-ID: <20201008122845.GA3314@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <54190f9875b81b6aa5483a7710b084053a44abb8.1601170670.git.vilhelm.gray@gmail.com>
 <20201008080909.GA31561@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20201008080909.GA31561@amd>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 10:09:09AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > +        int main(void)
> > +        {
> > +                struct pollfd pfd =3D { .events =3D POLLIN };
> > +                struct counter_event event_data[2];
> > +
> > +                pfd.fd =3D open("/dev/counter0", O_RDWR);
> > +
> > +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
> > +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
> > +                ioctl(pfd.fd, COUNTER_LOAD_WATCHES_IOCTL);
> > +
> > +                for (;;) {
> > +                        poll(&pfd, 1, -1);
>=20
> Why do poll, when you are doing blocking read?
>=20
> > +                        read(pfd.fd, event_data,  sizeof(event_data));
>=20
> Does your new chrdev always guarantee returning complete buffer?
>=20
> If so, should it behave like that?
>=20
> Best regards,
> 									Pavel
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

I suppose you're right: a poll() should be redundant now with this
version of the character device implementation because buffers will
always return complete; so a blocking read() should achieve the same
behavior that a poll() with read() would.

I'll give some more time for additional feedback to come in for this
version of the patchset, and then likely remove support for poll() in
the v6 submission.

William Breathitt Gray

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl9/BfMACgkQhvpINdm7
VJLlWxAA6P8iWbbwKdj7bkiAQIaSMh8Os/F1sO6AcUBqYxmMS2284jYpB1PWYm86
WMOfpjzE1TL+qc8Zl0/McZydw2huS5HvhRq4++PM/W+5Ohv/uajZiQyoC5jlmBIF
7u4ewc+X37t0T7SSdtdOPM6+em8Qdq/8ghPEgEWGHfBe/ls/eTcD4I1IZikpHyft
PM776AufGoc8A/IIaLYtO5UEI1dNXmyRrK+GOZJft+lRtMZWTjd5j6nK+vfiCaw9
hS2dJofatgyjZBxvqD6t8D+PRhyebaeKyAaK0TQPtu9P+61cZcVcCJ6iKV7Ugh/T
41kYb7opP8j9gxv9HoJbBbYtTTB5yGGO8fRBQ1vO2pLXNXuaEE9v/w+LyagKi/Kh
j+crZFgPJIpvYcm6vi7Vr5KP+jl8Rbm1i4UjoAv4a07RR+D7H3c+v9jFAQDezB48
dIww19g41Yig28jQ7Un5n4drOxPbc4lIYJDYYncsHlJea6/I2K8eM8pTakOSiv9j
aBQSoG+PaDfQnsM462KMpgiNn25Nz/WLz2dbJP6phwRJGr5auPue8EbxW5m1Cu5y
KhX7B1QALpZWo76BFYcst6GMD/dz1T5XeGGCkGZvS/8RiIfRVMLefBc9DY0QPxJz
QPrc+N2DCihZhAKPQRtptqgh36cm37FZV0jAE3YGJH4AZOxEFjM=
=kkTp
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
