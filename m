Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80F64AC227
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359447AbiBGO5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382636AbiBGOfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:35:18 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE9C0401C1
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:35:17 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BED996000D;
        Mon,  7 Feb 2022 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLf2au0TqgtM3Ygq+ySleMDOJq/AtdiLKPkOQplgmAw=;
        b=aomU2cjJxSrqUnrzQWepNfgnBRItuUSbd9UWGzC8vWarwoc7Dfc/TPyrv5hVmji2WXyoks
        Dcu9t96HpKiShHDR6F8+7fOCRE9/EelkzZj6YIWoTxt+ccZmLQf4jkkvhrAWRe5m4EHHSG
        tEc07lYAYVD2dycfZvCf/iGQdVT0UeESVgLhcyC4J+NuC9skvYoiV82GtqlIpIx14Hqfl3
        m/mRkUPxHxkwv/Ib+8ljFQx4TUbSPDAGvsFfr8hkWcCQEp0JC5yVlxPyAm8RaKgcAyb4GW
        1ZIqmo1Yria4Vqu+fpnByMBllpPnaJw6SEpGy08VYhEVB6TAviUam95RnxcB6g==
Date:   Mon, 7 Feb 2022 15:35:14 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 07/12] iio: st_sensors: Use
 iio_device_claim/release_direct_mode() when relevant
Message-ID: <20220207153514.74c861cb@xps13>
In-Reply-To: <20220206155520.6cca376b@jic23-huawei>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
        <20220202140208.391394-8-miquel.raynal@bootlin.com>
        <20220206155520.6cca376b@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 6 Feb 2022 15:55:20 +0000:

> On Wed,  2 Feb 2022 15:02:03 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > The st_sensors_core driver hardcodes the content of the
> > iio_device_claim_direct_mode() and iio_device_release_direct_mode()
> > helpers. Let's get rid of this handcrafted implementation and use the
> > proper core helpers instead. Additionally, this lowers the tab level
> > (which is always good) and prevents the use of the ->currentmode
> > variable which is not supposed to be used like this anyway.
> >=20
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../iio/common/st_sensors/st_sensors_core.c   | 32 +++++++++----------
> >  1 file changed, 15 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/=
iio/common/st_sensors/st_sensors_core.c
> > index d0419234a747..e61622e3bc85 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > @@ -559,28 +559,26 @@ int st_sensors_read_info_raw(struct iio_dev *indi=
o_dev,
> >  	int err;
> >  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > =20
> > -	mutex_lock(&indio_dev->mlock);
> > -	if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > -		err =3D -EBUSY;
> > +	err =3D iio_device_claim_direct_mode(indio_dev);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D st_sensors_set_enable(indio_dev, true);
> > +	if (err < 0)
> >  		goto out;
> > -	} else {
> > -		err =3D st_sensors_set_enable(indio_dev, true);
> > -		if (err < 0)
> > -			goto out;
> > =20
> > -		mutex_lock(&sdata->odr_lock);
> > -		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
> > -		err =3D st_sensors_read_axis_data(indio_dev, ch, val);
> > -		mutex_unlock(&sdata->odr_lock);
> > -		if (err < 0)
> > -			goto out;
> > +	mutex_lock(&sdata->odr_lock); =20
>=20
> This is problematic I think as the lock taken around getting sdata->odr
> in set_sensors_set_enable() but then dropped briefly before being
> reacquired here.  If someone sneaks a write in that window, it
> looks like we might sleep for the wrong amount of time because sdata->odr
> has changed.  I think you need to hold the lock across the whole
> enable/read/disable cycle (disable probably not necessary but it
> would be more obviously correct if we did hold it across that as well).
>=20

Yeah, I do agree this is a risk and I actually bet that the mlock mutex
taken with iio_device_claim_direct_mode() was more than enough, but
you're right that this this is maybe just a consequence of the
current implementation and not actually enforced by the API, and for
this reason we might want to enforce the serialization with our own
lock.

I've extended the coverage of the lock to fix that.

> Clearly this actually got introduced in the earlier patch but diff
> wasn't showing a wide enough bit of code so I missed it.
>=20
> Note it is fairly common to use iio_device_claim_direct_mode() to
> prevent data rate changes whilst doing buffered capture as that tends
> to make the data messy and can lead to skipped samples etc.  Doing
> that would have the side effect of closing the race.
> It is a bit undocumented though in the sense that I don't think
> we have ever stated that iio_device_claim_direct_mode() will block
> against another iio_device_claim_direct_mode() so accesses are
> serialized.  So better to have the local lock enforce the
> necessary serialization.  Whilst I doubt we will change the
> implementation of iio_device_claim_direct_mode() any time
> soon you never know.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > +	msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
> > +	err =3D st_sensors_read_axis_data(indio_dev, ch, val);
> > +	mutex_unlock(&sdata->odr_lock);
> > +	if (err < 0)
> > +		goto out;
> > =20
> > -		*val =3D *val >> ch->scan_type.shift;
> > +	*val =3D *val >> ch->scan_type.shift;
> > =20
> > -		err =3D st_sensors_set_enable(indio_dev, false);
> > -	}
> > +	err =3D st_sensors_set_enable(indio_dev, false);
> >  out:
> > -	mutex_unlock(&indio_dev->mlock);
> > +	iio_device_release_direct_mode(indio_dev);
> > =20
> >  	return err;
> >  } =20
>=20


Thanks,
Miqu=C3=A8l
