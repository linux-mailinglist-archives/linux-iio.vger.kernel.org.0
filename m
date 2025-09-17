Return-Path: <linux-iio+bounces-24222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A076EB80F85
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2879A3B561F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C22874E0;
	Wed, 17 Sep 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="B1+cRPXk"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CF34BA42;
	Wed, 17 Sep 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126340; cv=pass; b=HtHaP+xXLyU6SsgohBcnTOJuZj1Z28B8wPDLB8CDPc8FIbFPu0fRxIMcQwZ1vFJpaq+wxp/oBrWdT1Y2oNFTaYlMf16e9ofMWHd+l0M0BiIzMC5lx7fwyPwNfma0gS7+++BX9oMyP9z30ZyTNTysolCPE7LNMtY4V1Cz4hcITME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126340; c=relaxed/simple;
	bh=E2xoPDGeSVO0PLklH+sUA3dvhuCum19UEvEz2dbu8jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuVCIepGp4Es0zIbsJ/Bkjte2i2VlAJUOGjxpACTwmdFfsEBGcyRj45DYNQNO8M9UqdcdT9hBKjPaVtvX5/tYqZY3O00OtTy9KuEvdWADTahYTIxm+/1KWWj2kwQ0h7WJBUqqNOkRVwp46VD5ur0Xc8NMzbfieCsZIO5i3ge6lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=B1+cRPXk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758126283; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UoUxm3TG+Xdqdt4n6U36BzI+ZArx0id4xIhPohYJk3DcYQKQ3gFw6Bm+XpQRDTul+ELzmkXOAwgOG8WJMQ2VP6txBjz7QSu79IYoaJBOCb8gtqfyzlYEtIDLEqQHjmEyRQhIUhE3LKHczAiNtmLZHMA+NHtnQMAIjLMRZckikOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758126283; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dUV4xEya8An9AsAZIkFaG1G41M6EhB9SXM95Zf2aVOs=; 
	b=T5ygtmluYn6j1nGKR6dCuqGrwo8jgjwQ7HRQB1kFGDR3TV+ZbvUMPUXLreIpws72ahMaTDVRpM468xuR2abHclMk96T83OxFmhWZagKCIEXxY0Y5u6rKK5JZ6nACNBsBrS5rc4a4DcuA8sQhNGqkJVyS2tjCWSwQsJZkBMKk/a4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758126283;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=dUV4xEya8An9AsAZIkFaG1G41M6EhB9SXM95Zf2aVOs=;
	b=B1+cRPXk0cJs3HmKjgPbf4rOEZkW5FzCMbo/y7pyOUdeGT0CNzMTg53IAdty9WTR
	hkgBpU6u3XxrNpbfC9M+rPMZjNW+rjJ6GMIenoAQ6iP/OhbeJGjoGGkOLa6kO6KB/R5
	PveNckwFRHSTIxxLF7cHSDs38Qchjg+1BPit9+sE=
Received: by mx.zohomail.com with SMTPS id 1758126271855414.6769814303776;
	Wed, 17 Sep 2025 09:24:31 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 0F592180265; Wed, 17 Sep 2025 18:24:26 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:24:26 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org, 
	casey.connolly@linaro.org, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <zfe2q5sw5pphfyzidhe6d564j6yw32lnxzv4etxcr3hhi2ychy@34qka6dllzxe>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b73zeyu7mpwvdb3l"
Content-Disposition: inline
In-Reply-To: <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.96.42
X-ZohoMailClient: External


--b73zeyu7mpwvdb3l
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
MIME-Version: 1.0

Hi,

On Tue, Sep 16, 2025 at 10:44:39AM +0200, AngeloGioacchino Del Regno wrote:
> Some devices connected over the SPMI bus may be big, in the sense
> that those may be a complex of devices managed by a single chip
> over the SPMI bus, reachable through a single SID.
>=20
> Add new functions aimed at managing sub-devices of a SPMI device
> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
> for adding a new subdevice and removing it respectively, and also
> add their devm_* variants.
>=20
> The need for such functions comes from the existance of	those
> complex Power Management ICs (PMICs), which feature one or many
> sub-devices, in some cases with these being even addressable on
> the chip in form of SPMI register ranges.
>=20
> Examples of those devices can be found in both Qualcomm platforms
> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
> sub-devices, and in newer MediaTek platforms showing similar HW
> features and a similar layout with those also having many subdevs.
>=20
> Also, instead of generally exporting symbols, export them with a
> new "SPMI" namespace: all users will have to import this namespace
> to make use of the newly introduced exports.
>=20
> Link: https://lore.kernel.org/r/20250722101317.76729-2-angelogioacchino.d=
elregno@collabora.com
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Link: https://lore.kernel.org/r/20250730112645.542179-2-angelogioacchino.=
delregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

It would be nice, if this patch lands in the 6.18 merge window. That
way we don't need to do an immutable branch for the different involved
subsystems.

Greetings,

-- Sebastian

>  drivers/spmi/spmi-devres.c | 24 ++++++++++++
>  drivers/spmi/spmi.c        | 79 ++++++++++++++++++++++++++++++++++++++
>  include/linux/spmi.h       | 16 ++++++++
>  3 files changed, 119 insertions(+)
>=20
> diff --git a/drivers/spmi/spmi-devres.c b/drivers/spmi/spmi-devres.c
> index 62c4b3f24d06..8feebab0365b 100644
> --- a/drivers/spmi/spmi-devres.c
> +++ b/drivers/spmi/spmi-devres.c
> @@ -60,5 +60,29 @@ int devm_spmi_controller_add(struct device *parent, st=
ruct spmi_controller *ctrl
>  }
>  EXPORT_SYMBOL_GPL(devm_spmi_controller_add);
> =20
> +static void devm_spmi_subdevice_remove(void *res)
> +{
> +	spmi_subdevice_remove(res);
> +}
> +
> +struct spmi_subdevice *devm_spmi_subdevice_alloc_and_add(struct device *=
dev,
> +							 struct spmi_device *sparent)
> +{
> +	struct spmi_subdevice *sub_sdev;
> +	int ret;
> +
> +	sub_sdev =3D spmi_subdevice_alloc_and_add(sparent);
> +	if (IS_ERR(sub_sdev))
> +		return sub_sdev;
> +
> +	ret =3D devm_add_action_or_reset(dev, devm_spmi_subdevice_remove, sub_s=
dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return sub_sdev;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_spmi_subdevice_alloc_and_add, "SPMI");
> +
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("SPMI devres helpers");
> +MODULE_IMPORT_NS("SPMI");
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index 3cf8d9bd4566..e011876c3187 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -19,6 +19,7 @@
> =20
>  static bool is_registered;
>  static DEFINE_IDA(ctrl_ida);
> +static DEFINE_IDA(spmi_subdevice_ida);
> =20
>  static void spmi_dev_release(struct device *dev)
>  {
> @@ -31,6 +32,19 @@ static const struct device_type spmi_dev_type =3D {
>  	.release	=3D spmi_dev_release,
>  };
> =20
> +static void spmi_subdev_release(struct device *dev)
> +{
> +	struct spmi_device *sdev =3D to_spmi_device(dev);
> +	struct spmi_subdevice *sub_sdev =3D container_of(sdev, struct spmi_subd=
evice, sdev);
> +
> +	ida_free(&spmi_subdevice_ida, sub_sdev->devid);
> +	kfree(sub_sdev);
> +}
> +
> +static const struct device_type spmi_subdev_type =3D {
> +	.release	=3D spmi_subdev_release,
> +};
> +
>  static void spmi_ctrl_release(struct device *dev)
>  {
>  	struct spmi_controller *ctrl =3D to_spmi_controller(dev);
> @@ -90,6 +104,18 @@ void spmi_device_remove(struct spmi_device *sdev)
>  }
>  EXPORT_SYMBOL_GPL(spmi_device_remove);
> =20
> +/**
> + * spmi_subdevice_remove() - Remove an SPMI subdevice
> + * @sub_sdev:	spmi_device to be removed
> + */
> +void spmi_subdevice_remove(struct spmi_subdevice *sub_sdev)
> +{
> +	struct spmi_device *sdev =3D &sub_sdev->sdev;
> +
> +	device_unregister(&sdev->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_remove, "SPMI");
> +
>  static inline int
>  spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 sid)
>  {
> @@ -431,6 +457,59 @@ struct spmi_device *spmi_device_alloc(struct spmi_co=
ntroller *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(spmi_device_alloc);
> =20
> +/**
> + * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
> + * @sparent:	SPMI parent device with previously registered SPMI controll=
er
> + *
> + * Returns:
> + * Pointer to newly allocated SPMI sub-device for success or negative ER=
R_PTR.
> + */
> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *=
sparent)
> +{
> +	struct spmi_subdevice *sub_sdev;
> +	struct spmi_device *sdev;
> +	int ret;
> +
> +	sub_sdev =3D kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
> +	if (!sub_sdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
> +	if (ret < 0) {
> +		kfree(sub_sdev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	sdev =3D &sub_sdev->sdev;
> +	sdev->ctrl =3D sparent->ctrl;
> +	device_initialize(&sdev->dev);
> +	sdev->dev.parent =3D &sparent->dev;
> +	sdev->dev.bus =3D &spmi_bus_type;
> +	sdev->dev.type =3D &spmi_subdev_type;
> +
> +	sub_sdev->devid =3D ret;
> +	sdev->usid =3D sparent->usid;
> +
> +	ret =3D dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
> +	if (ret)
> +		goto err_put_dev;
> +
> +	ret =3D device_add(&sdev->dev);
> +	if (ret) {
> +		dev_err(&sdev->dev, "Can't add %s, status %d\n",
> +			dev_name(&sdev->dev), ret);
> +		goto err_put_dev;
> +	}
> +
> +	return sub_sdev;
> +
> +err_put_dev:
> +	put_device(&sdev->dev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_alloc_and_add, "SPMI");
> +
>  /**
>   * spmi_controller_alloc() - Allocate a new SPMI controller
>   * @parent:	parent device
> diff --git a/include/linux/spmi.h b/include/linux/spmi.h
> index 28e8c8bd3944..7cea0a5b034b 100644
> --- a/include/linux/spmi.h
> +++ b/include/linux/spmi.h
> @@ -69,6 +69,22 @@ int spmi_device_add(struct spmi_device *sdev);
> =20
>  void spmi_device_remove(struct spmi_device *sdev);
> =20
> +/**
> + * struct spmi_subdevice - Basic representation of an SPMI sub-device
> + * @sdev:	Sub-device representation of an SPMI device
> + * @devid:	Platform Device ID of an SPMI sub-device
> + */
> +struct spmi_subdevice {
> +	struct spmi_device	sdev;
> +	unsigned int		devid;
> +};
> +
> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *=
sparent);
> +void spmi_subdevice_remove(struct spmi_subdevice *sdev);
> +
> +struct spmi_subdevice *devm_spmi_subdevice_alloc_and_add(struct device *=
dev,
> +							 struct spmi_device *sparent);
> +
>  /**
>   * struct spmi_controller - interface to the SPMI master controller
>   * @dev:	Driver model representation of the device.
> --=20
> 2.51.0
>=20

--b73zeyu7mpwvdb3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjK4LMACgkQ2O7X88g7
+pquRQ//fllBLsQUj+gMWiKvHca0QRVBivSZq0aVidiaTPryqzJ/vEJWq/KjpSJP
W8Kx9YHDiHh3cBqBQ+KW1EyQRmYhUmhGeuwVbYdjdtWpPKDcCcsPo1QqBFQL+Z0U
V4Kd1WGg1Gwf5FEXAXFrsCKhdBasWoRlyMsyNUiwbEDi92hLq/t8dOdmyuQH+EcA
a/KRM7YmIBIeej6E7lx3pdizHPBdVKijMK4pd8j+4fNOxUBpPi/7XT81K9X2Nzic
lEyUcgsjpjTs2FJbFW8+EZODMLmgd6UGyA5Pv3jzHPgZBWZI6zZubgfFuVVCNttu
qxXskmzHKyF9rman3tvWVbFL/CC/m5f11hxJstG1sBPmrrgOpsD5iN0XerOuta24
tnxIQQMjrVG/1+1uMVRuBy2v7OqBnP7PBHkK1icudPB2zxTZN6XVaULOS+htaYJc
jAPDSKS4wjOULAg4vLQORtXIBhN1lBBbgRNH+jXCtBA6W1HmWwI0NJ3MaippHMjw
Nqeo50Tv7xEgIWn8ZiS+AP0+xBR1bBXqNaydZuf/plzklqFl/Sk9x1qGKCZZZOLW
jufnq18D9wxl53JHztTwLIlNILdxwvIVDrkhbFgrHk/BaeXIT4txniES2lq0FLFf
CeBsQeBJ3GHT+HaUQnOcRJwqfUZo7Y8mqMeImzZCnTAgL6NDvtI=
=AZLG
-----END PGP SIGNATURE-----

--b73zeyu7mpwvdb3l--

