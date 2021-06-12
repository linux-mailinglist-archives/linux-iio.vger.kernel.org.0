Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016993A4BC9
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jun 2021 02:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhFLAsA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 20:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhFLAsA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 20:48:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E2FC061574
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 17:45:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k22-20020a17090aef16b0290163512accedso8073514pjz.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JXYjRTwgmumkaPzJmtu0OBRj16JRGY+E0Hv05te5os=;
        b=tZMJdlY4ojCMu32NGJUUafWfZ+pQbifXoLhNuwT1u+qnZ2iFTHyvGVOEuPE+ExzVq6
         ngDnVOLswYBKEf5v52OLYr8FXHh+Sf+uLISkZAeVqQiUyGAhACyz/+gWY/q1IbjLtXC0
         w755aUjiihWRXmhkUkSIZm6q+NRHLlJTR70+aFMmxITl3rHwG2RjaWOidcq/VSU5r6ZZ
         PeC2OvAOkp9bjNzUIoDaES+L83tzgYVgjXiTEge0gPLyiurVWsYWkTQYCL1nX1FmcZ6V
         LzHiUr8+mn8unJ7DsmfBcc+hdGei/pJUW8YUS5IPwkn1JCjJbTkE7+RVGMopNQyb8jvr
         zhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8JXYjRTwgmumkaPzJmtu0OBRj16JRGY+E0Hv05te5os=;
        b=m1fVondd9cJOHQPz+jeAApImVDPga0VyuD5jlmzIRkUAJ5/WNBIIIn2GubI1uCRi6W
         j5kVrrjB31sGPun2pz1+t66QaQpvkHM8u6PL/cAAYSPfdmLhFV0XXuuzeOVwOXtqQCSX
         /DEJRJ+Td8XQebMZAfWJuqHMHjfhTldCgy0aeh0RTvSVMy6zvUlJY/MhPZmUL1zmiXxm
         octQAABhr+hQvKlVZR75Uqb+itSaZzXaDLoRQmLGOKjlXGAeADAMl06rljnG5QgGtBa7
         Wnzj5hVzE/3SXJNKhAicMm6XEzWZMR0lHx1sJhqH2hk4X74wZwSnYbx2sLJUO9T9Nbor
         K64A==
X-Gm-Message-State: AOAM530MQvAmlbY/ffqYvaQND+41Zq+7dSHQ5W9Q1/o1Tyr64fCsYvf3
        VQxSmEliaKI697mU4LbRyvk=
X-Google-Smtp-Source: ABdhPJzF6V647TvGDw+NYcEgxTTuEiUWhr1uMGERdgAF2YQ3B2wyQDDhrtWta2BduMaja4mV+nNpig==
X-Received: by 2002:a17:902:edcf:b029:10c:768:b657 with SMTP id q15-20020a170902edcfb029010c0768b657mr6342610plk.56.1623458745777;
        Fri, 11 Jun 2021 17:45:45 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id a23sm5954695pff.43.2021.06.11.17.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 17:45:45 -0700 (PDT)
Date:   Sat, 12 Jun 2021 09:45:41 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] counter: intel-qep: Mark PM callbacks with
 __maybe_unused
Message-ID: <YMQDtZ7o0MRvVdb9@shinobu>
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
 <20210611182334.61133958@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EIbE59nRuE1B+iKS"
Content-Disposition: inline
In-Reply-To: <20210611182334.61133958@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--EIbE59nRuE1B+iKS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 11, 2021 at 06:23:34PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 14:55:57 +0300
> Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
>=20
> > Remove CONFIG_PM ifdef and mark PM callbacks with __maybe_unused.
> >=20
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>=20
> Both applied to the togreg branch of iio.git and pushed out
> as testing to let 0-day poke at them.
>=20
> William, if you want to give feedback on these, still time for
> me to add tags etc. They just seem trivial enough its not worth
> wasting your time :)
>=20
> Jonathan

Yes, these are pretty trivial and both look good to me. Feel free to add
my Ack to both patches if there's still time.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> > ---
> >  drivers/counter/intel-qep.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> > index ab10ba33f46a..a8d3dccecc0f 100644
> > --- a/drivers/counter/intel-qep.c
> > +++ b/drivers/counter/intel-qep.c
> > @@ -473,8 +473,7 @@ static void intel_qep_remove(struct pci_dev *pci)
> >  	intel_qep_writel(qep, INTEL_QEPCON, 0);
> >  }
> > =20
> > -#ifdef CONFIG_PM
> > -static int intel_qep_suspend(struct device *dev)
> > +static int __maybe_unused intel_qep_suspend(struct device *dev)
> >  {
> >  	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> >  	struct intel_qep *qep =3D pci_get_drvdata(pdev);
> > @@ -486,7 +485,7 @@ static int intel_qep_suspend(struct device *dev)
> >  	return 0;
> >  }
> > =20
> > -static int intel_qep_resume(struct device *dev)
> > +static int __maybe_unused intel_qep_resume(struct device *dev)
> >  {
> >  	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> >  	struct intel_qep *qep =3D pci_get_drvdata(pdev);
> > @@ -512,7 +511,6 @@ static int intel_qep_resume(struct device *dev)
> > =20
> >  	return 0;
> >  }
> > -#endif
> > =20
> >  static UNIVERSAL_DEV_PM_OPS(intel_qep_pm_ops,
> >  			    intel_qep_suspend, intel_qep_resume, NULL);
>=20

--EIbE59nRuE1B+iKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDEA50ACgkQhvpINdm7
VJIYfRAA0AqX93eYEWVxN4wHtl2xKAbhNVJ1as4ieu6MQ7sYbFAPNjeaIwxPfwgH
fPMP+EmpCbpvdtSkzGa0/xBUSei4hN3+Ab4pYLNAIuMYqIqgmr3r9oaAKTvwT4UI
XecBymOgTKYpR6xsSF/GF9DbiwDXqT8uCB4XlJy5bKp7rXeyCGYb9ZNqh9cCm8/z
hdISQ1cFB9X9HsRjOYUJ7SnzZkAtEg874oZaaypSpl1AxouNfpRXIrMQsMycZMaI
mMvTbDgxCR+m06kKZDJ8hHUJI+lK37q2FNX3d14ftbprP/CL61ypPv4NHtsTuSo4
z9V93QcjoMxKz0t/rAgsorZ90+FQXvC7c3QLflX69mDFJ0QHOUcNNsMUYoX0dda0
qty2NjShbJflIxT+wdWke2D1TJN9sJj5sVWPsxYDmnev/N+e0vK4KLdsBRQCS2i/
fN6NoTkX6WSRW7XQOmK7otFjpedCrgJXHODtm1VEaxUocaCBLL6vs0jcSFI+fTb1
zrtgnsmhbV3ZjYEi4N9YyzD+PXKY/+3U5jNaQEcPcL98YaNbAP9wffyYY3AIvF0U
YIIK3KbhsRGUqJQrNRRt91PL0jHQWCvcRHYyYmiOo+ia1OgGSEtsKOq+uXYvipV+
ojY1pYSqwvhMZyamRrVFntW4dB7PGyR82cgGUvq0TExwWQRLKlU=
=CdfL
-----END PGP SIGNATURE-----

--EIbE59nRuE1B+iKS--
