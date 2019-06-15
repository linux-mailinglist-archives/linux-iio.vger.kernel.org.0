Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A146F07
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2019 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfFOIgF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jun 2019 04:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFOIgF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jun 2019 04:36:05 -0400
Received: from localhost.localdomain (unknown [77.246.15.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD262070B;
        Sat, 15 Jun 2019 08:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560587764;
        bh=NLSC/mu6mVMoEWOASZchyIsfRe+/mbdxFSvaBLlj6Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2lzM1PmG62ESlqtte7GBnKtYyEES27jH2ruMPVkLfmFxKu6YAsQS1fPqzF3k36NK
         TyV9TU4/fhLieY6Jk2qaFxHNQS47KUbOdO3clmV/1sQsJtcbKFbDJH90Tz0tA6unTU
         VecLC4pdg2NhFCrkyqCQdhf/mOqTuUkhyztUCKPI=
Date:   Sat, 15 Jun 2019 10:35:58 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        martin@geanix.com
Subject: Re: [RFC PATCH 3/3] iio: imu: st_lsm6dsx: add wake on accelerometer
 threshold hook in sysfs
Message-ID: <20190615083557.GA5778@localhost.localdomain>
References: <20190614122604.52935-1-sean@geanix.com>
 <20190614122604.52935-4-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190614122604.52935-4-sean@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This adds a wakeup threshold hook in sysfs, it enables us to
> change the threshold value on the run.
> For now this is the raw register value...
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20

What about using write_event_config routine pointer for it instead od addin=
g a sysfs
entries?
@Jonathan: what do you think?

Regards,
Lorenzo

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 2c8ad7d65d2f..cbcd7920f05d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -657,12 +657,45 @@ static ssize_t st_lsm6dsx_sysfs_set_wakeup_enabled(=
struct device *dev,
>  	return len;
>  }
> =20
> +static ssize_t st_lsm6dsx_sysfs_get_wakeup_threshold(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +
> +	return sprintf(buf, "%d\n", hw->wake_threshold);
> +}
> +
> +static ssize_t st_lsm6dsx_sysfs_set_wakeup_threshold(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	int threshold;
> +
> +	if (kstrtoint(buf, 0, &threshold))
> +		return -EINVAL;
> +
> +	if ((threshold < 0) || (threshold > 31))
> +		return -EINVAL;
> +
> +	if (!st_lsm6dsx_set_wake_threshold(hw, threshold))
> +		return len;
> +
> +	return -EINVAL;
> +}
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_=
avail);
>  static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
>  static IIO_DEVICE_ATTR(wakeup_enabled, 0644,
>  		       st_lsm6dsx_sysfs_get_wakeup_enabled,
>  		       st_lsm6dsx_sysfs_set_wakeup_enabled, 0);
> +static IIO_DEVICE_ATTR(wakeup_threshold, 0644,
> +		       st_lsm6dsx_sysfs_get_wakeup_threshold,
> +		       st_lsm6dsx_sysfs_set_wakeup_threshold, 0);
>  static IIO_DEVICE_ATTR(in_anglvel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> =20
> @@ -670,6 +703,7 @@ static struct attribute *st_lsm6dsx_acc_attributes[] =
=3D {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>  	&iio_dev_attr_wakeup_enabled.dev_attr.attr,
> +	&iio_dev_attr_wakeup_threshold.dev_attr.attr,
>  	NULL,
>  };
> =20
> --=20
> 2.22.0
>=20

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQSt6QAKCRA6cBh0uS2t
rPiwAP9nN4SlOTxwBE2NoWVMaPWJNVuJb1ei+M0FaUxDM86eRgD8C5+EEQU4Dck/
oTOpbngoP+2LEOIw6aVbs6uZzgSLZwY=
=/PNl
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
