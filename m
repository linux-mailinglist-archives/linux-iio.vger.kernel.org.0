Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D310A2EB985
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jan 2021 06:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAFFbv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jan 2021 00:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAFFbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jan 2021 00:31:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BB6C06134C;
        Tue,  5 Jan 2021 21:31:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id t6so1006172plq.1;
        Tue, 05 Jan 2021 21:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rjwtCC4s5qF5toeFU9GqGpGwIgLC0h9CcPJ0B42v4CQ=;
        b=RccYso2/RvfnZPsOPln1soDDi57lHypQ9ziIwjDaB1mI1AtFwVwLmUpLhmiCyQ8SY5
         XLT1LEBooSNcVA/pX9ZggD/PtJZABE7GjlpTMzgfrii4pVTQgdFWVGnXUUcHDC1olw7w
         xrKu6zO8tWzeWJHbNvBOowUQubckFC0G/ax3ER44SmtxJ2tKZY20yInAzCjdM1nq7zWW
         gQKZeIYTVfPq6/4mLomEL0VSXyNfKs2l8EjJugp8NBcHcBP+hZndk7IeZWxsxQcXi0f4
         RWFL6eZmWdYlUEz6WIbEWf5rg5ez52VptftTN4H/TYBYop0Hl2jgRiiPP18DemXCRyt5
         rTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjwtCC4s5qF5toeFU9GqGpGwIgLC0h9CcPJ0B42v4CQ=;
        b=jTGkHccYb4XIgHxnuqOCT6twD6Gq0zuwOEEshaO4fy556IFFRwiZ4E7/h4SMohAoya
         mRIJBKnktDrbrb+Dd6GevZqLk4mOXh5EnUkCij2Bgjr3YBwpv0p1xBloQ6TOF1yimcAw
         U8IQ23h82Z6thkfLgAHEso6/eG4wCGe6CbdLbG/PNdgSEMkP7TyRuQf9ECPbJ1S6H6iW
         0jxpR8oEgGZyziT1I+JWUgBaY6MfltAsPKmbmrb0eVvR6Ogvq8YJuvdEa/+XVBUOcNy/
         xmTjAIdqQd2ZYL2Ch8G0m4StVDUXG3TLJwynrZp30Zhf5n2dCZCugoOLFcLqePrERXen
         O/Pw==
X-Gm-Message-State: AOAM531yxhR31nDGUJL6tUt9y7fjD/bNYS6TH+6A5uwTpxskOTyDI/cQ
        z4lraBfMZRO//eLQlaXe+Vk=
X-Google-Smtp-Source: ABdhPJzePowiEcDtoDOO8mVrej19Pwo3YcDLae7GCXSALEteC7xAeNRoG2w+P4XOe/IgaZlQxsHmNQ==
X-Received: by 2002:a17:902:cb95:b029:dc:3a38:c7df with SMTP id d21-20020a170902cb95b02900dc3a38c7dfmr2906008ply.49.1609911069942;
        Tue, 05 Jan 2021 21:31:09 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id u12sm978052pgi.91.2021.01.05.21.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 21:31:09 -0800 (PST)
Date:   Wed, 6 Jan 2021 14:30:59 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 1/5] counter: Internalize sysfs interface code
Message-ID: <X/VLE0wPPifNZFhT@shinobu>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <fc40ab7f4a38e80d86715daa5eaf744dd645a75b.1608935587.git.vilhelm.gray@gmail.com>
 <2f950b79-fb83-9800-2690-ec81c6be6348@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TS0nwI4oX3M9MM/u"
Content-Disposition: inline
In-Reply-To: <2f950b79-fb83-9800-2690-ec81c6be6348@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--TS0nwI4oX3M9MM/u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 05:24:34PM -0600, David Lechner wrote:
> On 12/25/20 6:15 PM, William Breathitt Gray wrote:
>=20
> > diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> > index a60aee1a1a29..6c058b93dc98 100644
> > --- a/drivers/counter/ti-eqep.c
> > +++ b/drivers/counter/ti-eqep.c
>=20
>=20
> > -static ssize_t ti_eqep_position_floor_write(struct counter_device *cou=
nter,
> > -					    struct counter_count *count,
> > -					    void *ext_priv, const char *buf,
> > -					    size_t len)
> > +static int ti_eqep_position_floor_write(struct counter_device *counter,
> > +					struct counter_count *count, u64 floor)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> > -	int err;
> > -	u32 res;
> >  =20
> > -	err =3D kstrtouint(buf, 0, &res);
> > -	if (err < 0)
> > -		return err;
> > +	if (floor !=3D (u32)floor)
> > +		return -ERANGE;
> >  =20
> > -	regmap_write(priv->regmap32, QPOSINIT, res);
> > +	regmap_write(priv->regmap32, QPOSINIT, floor);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
>=20
> This will conflict with 2ba7b50893de "counter:ti-eqep: remove floor"
> (in Jonathan's fixes-togreg branch) which removes these functions.

Ack, I'll rebase and remove these changes.

William Breathitt Gray

--TS0nwI4oX3M9MM/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/1SxMACgkQhvpINdm7
VJKIcw/+LDra2XrlrRaFeux8tWBB93EDHYQEEzd7WeMlC09xQ0aZwEeUojZtJ5/E
IV1ZeWHxVRikgxL9GMBjwLO+IAg2fsiko74ruXbmylQad1AOuI/MDCLfN7Z6vSXW
BMYXiXq5bH/cKGRLf0bqRWJNRCUPvd7wrh4G3l8Q91BsKWeUNAxypwVjmfFtpspJ
7Y0EqvmDD890fNFPZOajKU8EbGEBzfUt+mDuFNXkkhM38bhGT+8PQ6APoaA1OQ3W
xhpjtzW4mEg0V8DnMFdpmeI0MHsV6yYM8tnK+NvY/EbbGRQbfy5x1tqnjSR+KKZm
TIlYCJnI/95mdjEmNL0qvC7K8gypB6F1ScmNZ2LiaNqT4ztoJebFXIpqVhiWl9X1
j7pGX+0xGHiLBKJ+1cubpuyoqoYWLWKzZuxv5GAAQ7BYP4b02iaUqmahKciQlrGX
cieLke92Mhi6YOQf3/FA+kw1wOGtIOTBbHc3Ng4fL7JYztKSg7FQ48H1jnLKhlNe
QOHBVz7tXasa2GxtDAYKa1fPLXv9Hz8pADP105UJEDaLDoSggWwnrItGvXT5CBjM
1+VTNc9PR5kqyo5yDRe3fIBHn1+GOCwNBDZcF85RQcccwYce6s3WmHe77IK24Kgy
TIeVZYUz5l7HWnI3eM4hl0PCL2yHFj4lLPkiVnQ8Qg3MoPm+JSE=
=iNKk
-----END PGP SIGNATURE-----

--TS0nwI4oX3M9MM/u--
