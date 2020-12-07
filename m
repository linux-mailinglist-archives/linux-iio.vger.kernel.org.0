Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC71D2D1741
	for <lists+linux-iio@lfdr.de>; Mon,  7 Dec 2020 18:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgLGRMr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Dec 2020 12:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbgLGRMr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Dec 2020 12:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607361080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwM0jw/7vO1FjtfKY9ZNvwNI9gOsh0XqCv3cLSl5/M4=;
        b=BoeUUgd4pcDx3g3lcCp6r6u2uSjTuU6z5No49OwVWZZBgtXdviMjRX+jlCboBprveXiMMg
        f/eb+hqWDmeTiVkVYP1yLl4rPxhTgeO4o5bggQxzzG/bQ7HMngbELjFB/9NATwYTxEc+eM
        zXGGvDFOUzbjhYPvI8e2ov/cOJhLumI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-VPjLweZ1M4qYyTME0fq-kw-1; Mon, 07 Dec 2020 12:11:17 -0500
X-MC-Unique: VPjLweZ1M4qYyTME0fq-kw-1
Received: by mail-ej1-f70.google.com with SMTP id 2so4071026ejv.4
        for <linux-iio@vger.kernel.org>; Mon, 07 Dec 2020 09:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WwM0jw/7vO1FjtfKY9ZNvwNI9gOsh0XqCv3cLSl5/M4=;
        b=oqrnko/vFKyGVLKPrT07NCcRu7yuTP6vlRFZuAhF+t7L5WpxV3VR/U9IH4gUl5zmVb
         adlRG/42DJ9nHZhq1uDsDURWZbAZPbyeII0IebJfVuKgE6IWmSVu32h2D6c0jC8/RFfI
         HU0XP+FYiJPUez2uMvidpe/BzdQCvZYU7p6uvqVNHghqosjW4pDEH/Yh8et8+KzhFVb5
         g8KkeZqiJF3idnPekmRbBYlSwuIEkpqIgYL04IVg9cj7a2+Owl17OjYdgV7VNugMgmxk
         9QneDfLukD3LTi9YNpEYLSQb7SU1M8s8xc82O3qCrIbxwi5SGXIkzs7+FMzJe32X+AA2
         +fpg==
X-Gm-Message-State: AOAM533kc0LJELatpfn7pJUTH9/nYHJ23mxM1SLwagI4ZLyvnSz8hQC9
        wJMi/dDu83lyUv5UjT5Gj+pOL5yHjmrFZg8RSqNDG9Yhf3HJVc5OxTNU/KukImBCDP3a9D1Cd86
        9vrFYHLj/sk7XpiMH+i8z
X-Received: by 2002:a17:906:f949:: with SMTP id ld9mr20122091ejb.401.1607361075852;
        Mon, 07 Dec 2020 09:11:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlb58wYq211udY/Sc9WKllU6OThGBWhnKkfJT2jsL/UqzcjBuK3y5oSxDFUIjQrgI8hXg/gQ==
X-Received: by 2002:a17:906:f949:: with SMTP id ld9mr20122061ejb.401.1607361075570;
        Mon, 07 Dec 2020 09:11:15 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id f11sm13048079ejd.40.2020.12.07.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 09:11:14 -0800 (PST)
Date:   Mon, 7 Dec 2020 18:11:11 +0100
From:   "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Denis CIOCCA <denis.ciocca@st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: common: st_sensors: fix possible infinite loop in
 st_sensors_irq_thread
Message-ID: <20201207171111.GC292338@lore-desk>
References: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
 <AM8PR10MB4209021B3239B1CE06D2824DEDF20@AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM>
 <20201205151121.70d31d71@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20201205151121.70d31d71@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 3 Dec 2020 04:06:44 +0000
> Denis CIOCCA <denis.ciocca@st.com> wrote:
>=20
> > Hi Jonathan, Lorenzo,
> >=20
> > I am not able to test it right now, I can probably do this weekend.
> > My comments inline.
> >=20
> >=20
> > > -----Original Message-----
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Sent: Sunday, November 15, 2020 6:38 AM
> > > To: jic23@kernel.org
> > > Cc: lorenzo.bianconi@redhat.com; linux-iio@vger.kernel.org;
> > > linus.walleij@linaro.org; Denis CIOCCA <denis.ciocca@st.com>
> > > Subject: [PATCH] iio: common: st_sensors: fix possible infinite loop =
in
> > > st_sensors_irq_thread
> > >=20
> > > Return a boolean value in st_sensors_new_samples_available routine in
> > > order to avoid an infinite loop in st_sensors_irq_thread if stat_drdy=
=2Eaddr is
> > > not defined or stat_drdy read fails
> > >=20
> > > Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> > > Reported-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > This patch is just compile tested, I have not carried out any run test
> > > ---
> > >  .../common/st_sensors/st_sensors_trigger.c    | 20 ++++++++---------=
--
> > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > >=20

[...]

> >=20
> > To me this should return true. When a sensor does not specify the addre=
ss (because there is no such register ie) the interrupt should be considere=
d a valid interrupt.
> > In the original code from Linus indeed the if condition that is using t=
his function is checking && -EINVAL that is considered true.
>=20
> Good point!
>=20
> Ah, so we have an issue here because the function is called in two differ=
ent
> circumstances.  For the initial test of whether there is a sample I absol=
utely
> agree with you, we need to say there is even if we can't check a status r=
egister.
>=20
> In the second case however, we would end up in an infinite loop if there =
is no
> status register.
>=20
>=20
> So the function is..
>=20
> static irqreturn_t st_sensors_irq_thread(int irq, void *p)
> {
> 	struct iio_trigger *trig =3D p;
> 	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> 	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
>=20
> 	/*
> 	 * If this trigger is backed by a hardware interrupt and we have a
> 	 * status register, check if this IRQ came from us. Notice that
> 	 * we will process also if st_sensors_new_samples_available()
> 	 * returns negative: if we can't check status, then poll
> 	 * unconditionally.
> 	 */
> //CASE 1: Trigger if we don't have a status register.
> 	if (sdata->hw_irq_trigger &&
> 	    st_sensors_new_samples_available(indio_dev, sdata)) {
> 		iio_trigger_poll_chained(p);
> 	} else {
> 		dev_dbg(sdata->dev, "spurious IRQ\n");
> 		return IRQ_NONE;
> 	}
>=20
> 	/*
> 	 * If we have proper level IRQs the handler will be re-entered if
> 	 * the line is still active, so return here and come back in through
> 	 * the top half if need be.
> 	 */
> 	if (!sdata->edge_irq)
> 		return IRQ_HANDLED;
>=20
> 	/*
> 	 * If we are using edge IRQs, new samples arrived while processing
> 	 * the IRQ and those may be missed unless we pick them here, so poll
> 	 * again. If the sensor delivery frequency is very high, this thread
> 	 * turns into a polled loop handler.
> 	 */
> //Case 2, don't trigger. =20
>=20
> 	while (sdata->hw_irq_trigger &&
> 	       st_sensors_new_samples_available(indio_dev, sdata)) {
> 		dev_dbg(sdata->dev, "more samples came in during polling\n");
> 		sdata->hw_timestamp =3D iio_get_time_ns(indio_dev);
> 		iio_trigger_poll_chained(p);
> 	}
>=20
> 	return IRQ_HANDLED;
> }
>=20
> I think the reality is we can't safely support edge interrupts unless the=
re is
> a status register as we will always be prone to the race conditions.
>=20
> As to a solution, I would suggest we make the status register existence
> check separate from it's use.  That way we can always poll in case 1 and
> never poll in case 2 if we don't have a status register.
>=20
> To prevent the edge based interrupt without a status register case could
> be done in various ways. Probably easiest is to check it at time of
> interrupt registration and refuse to probe if we can't handle it.

ack, right. So what about applying patch v2 and add another patch to return=
 an
error if edge interrupt is requested and we do not have status reg? Somethi=
ng
like:

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/i=
io/common/st_sensors/st_sensors_trigger.c
index d3f047e9d778..2bff3350b498 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -176,9 +176,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_=
dev,
=20
 	/* Tell the interrupt handler that we're dealing with edges */
 	if (irq_trig =3D=3D IRQF_TRIGGER_FALLING ||
-	    irq_trig =3D=3D IRQF_TRIGGER_RISING)
+	    irq_trig =3D=3D IRQF_TRIGGER_RISING) {
+		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
+			return -ENOTSUPP;
+
 		sdata->edge_irq =3D true;
-	else
+	} else {
 		/*
 		 * If we're not using edges (i.e. level interrupts) we
 		 * just mask off the IRQ, handle one interrupt, then
@@ -186,6 +189,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_d=
ev,
 		 * interrupt handler top half again and start over.
 		 */
 		irq_trig |=3D IRQF_ONESHOT;
+	}
=20
 	/*
 	 * If the interrupt pin is Open Drain, by definition this

Do you prefer to add it in the same patch?

Regards,
Lorenzo

>=20
> Jonathan
>=20
> >=20
> > >=20
> > >  	/* No scan mask, no interrupt */
> > >  	if (!indio_dev->active_scan_mask)
> > > -		return 0;
> > > +		return false;
> > >=20
> > >  	ret =3D regmap_read(sdata->regmap,
> > >  			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> > >  			  &status);
> > >  	if (ret < 0) {
> > >  		dev_err(sdata->dev, "error checking samples available\n");
> > > -		return ret;
> > > +		return false; =20
> >=20
> > This part indeed is probably the one that before could cause problems b=
ecause in case of failure -something returned it is considered true.
> >=20
> >=20
> > >  	}
> > >=20
> > > -	if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> > > -		return 1;
> > > -
> > > -	return 0;
> > > +	return !!(status & sdata->sensor_settings- =20
> > > >drdy_irq.stat_drdy.mask); =20
> > >  }
> > >=20
> > >  /**
> > > --
> > > 2.26.2 =20
> >=20
>=20

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX85iLAAKCRA6cBh0uS2t
rHDmAQCiAxWnW1Tb9k0mOuoOYR6yA+/dQs8xTdCaO6msyV/lWwD/ZC6pREmNHcZl
PqRqxy0rsmK04/S0z+JODMoQnAb8wA8=
=a2Ei
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--

