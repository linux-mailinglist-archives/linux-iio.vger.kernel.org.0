Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFABA611400
	for <lists+linux-iio@lfdr.de>; Fri, 28 Oct 2022 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJ1OGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Oct 2022 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJ1OGd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Oct 2022 10:06:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCF418E17;
        Fri, 28 Oct 2022 07:06:32 -0700 (PDT)
Received: from mercury (unknown [37.84.150.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2262A6602925;
        Fri, 28 Oct 2022 15:06:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666965991;
        bh=crpskktVlJPb6RlCf3GvXbAV1EjkatqdA1qxthq4wGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huR7yR2SgtpVU0/fot+kRCEo9RI0dgdoa6Dcx0j9RuIm6KerTBZbpIo4G3bCn0+Wc
         wzevobFhVxnG2lfE2bYKsWBOiffHRDF3DCWZKGbF7LeBgjGhd2i56uj0+jE1kovxmu
         L0IEndA8Na6C7mQeYqoUfDikDhgmQ3a5Y+letOxE4cUwAtdJXPoExghmaplOMJn6Gk
         g9EY2M7ttNOhJa54NyrFIcl4+TCjPFk/C7tRrKRZbo0vi1aoPlM3t5MatoLlnS73Sy
         skdYWPddTTQgLBYMd/J7Y63c7xDNjkFcSPIUiX+gBF6WHzNl75xabNSpwsQl1q9Cav
         GyQF9xG5cuFlA==
Received: by mercury (Postfix, from userid 1000)
        id E248810607E8; Fri, 28 Oct 2022 16:06:27 +0200 (CEST)
Date:   Fri, 28 Oct 2022 16:06:27 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/8] power: supply: Add support for mp2733 battery
 charger
Message-ID: <20221028140627.ddm2stx63tu6l3ra@mercury.elektranox.org>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
 <20221024132757.3345400-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5ivbd5hwmeiyko3"
Content-Disposition: inline
In-Reply-To: <20221024132757.3345400-5-sravanhome@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--s5ivbd5hwmeiyko3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 24, 2022 at 03:27:53PM +0200, Saravanan Sekar wrote:
> mp2733 is updated version of mp2629 battery charge management
> which supports USB fast-charge and higher range of input voltage.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/mp2629_charger.c | 223 ++++++++++++++++++++++----
>  1 file changed, 192 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply=
/mp2629_charger.c
> index bf9c27b463a8..9e4111aace4b 100644
> --- a/drivers/power/supply/mp2629_charger.c
> +++ b/drivers/power/supply/mp2629_charger.c
> @@ -30,12 +30,15 @@
>  #define MP2629_REG_INTERRUPT		0x0b
>  #define MP2629_REG_STATUS		0x0c
>  #define MP2629_REG_FAULT		0x0d
> +#define MP2629_REG_FAST_CHARGE		0x17
> =20
>  #define MP2629_MASK_INPUT_TYPE		GENMASK(7, 5)
>  #define MP2629_MASK_CHARGE_TYPE		GENMASK(4, 3)
>  #define MP2629_MASK_CHARGE_CTRL		GENMASK(5, 4)
>  #define MP2629_MASK_WDOG_CTRL		GENMASK(5, 4)
>  #define MP2629_MASK_IMPEDANCE		GENMASK(7, 4)
> +#define MP2733_MASK_FAST_CHARGE		GENMASK(2, 1)
> +#define MP2733_MASK_FAST_CHARGE_RESET	BIT(0)
> =20
>  #define MP2629_INPUTSOURCE_CHANGE	GENMASK(7, 5)
>  #define MP2629_CHARGING_CHANGE		GENMASK(4, 3)
> @@ -62,6 +65,17 @@ enum mp2629_source_type {
>  	MP2629_SOURCE_TYPE_OTG =3D 7,
>  };
> =20
> +enum mp2733_source_type {
> +	MP2733_SOURCE_TYPE_NO_INPUT,
> +	MP2733_SOURCE_TYPE_NON_STD,
> +	MP2733_SOURCE_TYPE_APPLE_1p0,
> +	MP2733_SOURCE_TYPE_APPLE_2p1,
> +	MP2733_SOURCE_TYPE_APPLE_2p4,
> +	MP2733_SOURCE_TYPE_SDP,
> +	MP2733_SOURCE_TYPE_CDP,
> +	MP2733_SOURCE_TYPE_DCP,
> +};
> +
>  enum mp2629_field {
>  	INPUT_ILIM,
>  	INPUT_VLIM,
> @@ -72,11 +86,30 @@ enum mp2629_field {
>  	MP2629_MAX_FIELD
>  };
> =20
> +struct mp2629_prop {
> +	int reg;
> +	int mask;
> +	int min;
> +	int max;
> +	int step;
> +	int shift;
> +};
> +
> +struct mp2xx_chip_info {
> +	const struct reg_field *rfields;
> +	struct mp2629_prop *chip_props;
> +	bool has_impedance;
> +	bool has_fast_charge;
> +
> +	int (*mp2xx_get_usb_type)(unsigned int rval);
> +};
> +
>  struct mp2629_charger {
>  	struct device *dev;
>  	int status;
>  	int fault;
> =20
> +	const struct mp2xx_chip_info *chip_info;
>  	struct regmap *regmap;
>  	struct regmap_field *regmap_fields[MP2629_MAX_FIELD];
>  	struct mutex lock;
> @@ -85,15 +118,6 @@ struct mp2629_charger {
>  	struct iio_channel *iiochan[MP2629_ADC_CHAN_END];
>  };
> =20
> -struct mp2629_prop {
> -	int reg;
> -	int mask;
> -	int min;
> -	int max;
> -	int step;
> -	int shift;
> -};
> -
>  static enum power_supply_usb_type mp2629_usb_types[] =3D {
>  	POWER_SUPPLY_USB_TYPE_SDP,
>  	POWER_SUPPLY_USB_TYPE_DCP,
> @@ -126,7 +150,25 @@ static enum power_supply_property mp2629_charger_bat=
_props[] =3D {
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>  };
> =20
> -static struct mp2629_prop props[] =3D {
> +static struct mp2629_prop mp2733_chip_props[] =3D {
> +	MP2629_PROPS(INPUT_ILIM, 100000, 3250000, 50000),
> +	MP2629_PROPS(INPUT_VLIM, 3800000, 15200000, 100000),
> +	MP2629_PROPS(CHARGE_ILIM, 320000, 4520000, 40000),
> +	MP2629_PROPS(CHARGE_VLIM, 3400000, 4670000, 10000),
> +	MP2629_PROPS(PRECHARGE, 120000, 720000, 40000),
> +	MP2629_PROPS(TERM_CURRENT, 80000, 680000, 40000),
> +};
> +
> +static const struct reg_field mp2733_reg_fields[] =3D {
> +	[INPUT_ILIM]	=3D REG_FIELD(MP2629_REG_INPUT_ILIM, 0, 5),
> +	[INPUT_VLIM]	=3D REG_FIELD(MP2629_REG_INPUT_VLIM, 0, 6),
> +	[CHARGE_ILIM]	=3D REG_FIELD(MP2629_REG_CHARGE_ILIM, 0, 6),
> +	[CHARGE_VLIM]	=3D REG_FIELD(MP2629_REG_CHARGE_VLIM, 1, 7),
> +	[PRECHARGE]	=3D REG_FIELD(MP2629_REG_PRECHARGE, 4, 7),
> +	[TERM_CURRENT]	=3D REG_FIELD(MP2629_REG_TERM_CURRENT, 0, 3),
> +};
> +
> +static struct mp2629_prop mp2629_chip_props[] =3D {
>  	MP2629_PROPS(INPUT_ILIM, 100000, 3250000, 50000),
>  	MP2629_PROPS(INPUT_VLIM, 3800000, 5300000, 100000),
>  	MP2629_PROPS(CHARGE_ILIM, 320000, 4520000, 40000),
> @@ -174,6 +216,7 @@ static int mp2629_get_prop(struct mp2629_charger *cha=
rger,
>  {
>  	int ret;
>  	unsigned int rval;
> +	struct mp2629_prop *props =3D charger->chip_info->chip_props;
> =20
>  	ret =3D regmap_field_read(charger->regmap_fields[fld], &rval);
>  	if (ret)
> @@ -189,6 +232,7 @@ static int mp2629_set_prop(struct mp2629_charger *cha=
rger,
>  			   const union power_supply_propval *val)
>  {
>  	unsigned int rval;
> +	struct mp2629_prop *props =3D charger->chip_info->chip_props;
> =20
>  	if (val->intval < props[fld].min || val->intval > props[fld].max)
>  		return -EINVAL;
> @@ -311,6 +355,16 @@ static int mp2629_charger_battery_get_prop(struct po=
wer_supply *psy,
>  		default:
>  			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
>  		}
> +
> +		if (charger->chip_info->has_fast_charge) {
> +			ret =3D regmap_read(charger->regmap,
> +					  MP2629_REG_FAST_CHARGE, &rval);
> +			if (ret)
> +				break;
> +
> +			if (rval & BIT(6))
> +				val->intval =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		}
>  		break;
> =20
>  	default:
> @@ -344,6 +398,40 @@ static int mp2629_charger_battery_set_prop(struct po=
wer_supply *psy,
>  	}
>  }
> =20
> +static int mp2733_get_usb_type(unsigned int rval)
> +{
> +	switch (rval) {
> +	case MP2733_SOURCE_TYPE_APPLE_1p0:
> +	case MP2733_SOURCE_TYPE_APPLE_2p1:
> +	case MP2733_SOURCE_TYPE_APPLE_2p4:
> +		return POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID;
> +	case MP2733_SOURCE_TYPE_SDP:
> +		return POWER_SUPPLY_USB_TYPE_SDP;
> +	case MP2733_SOURCE_TYPE_CDP:
> +		return POWER_SUPPLY_USB_TYPE_CDP;
> +	case MP2733_SOURCE_TYPE_DCP:
> +		return POWER_SUPPLY_USB_TYPE_DCP;
> +	default:
> +		return POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +	}
> +}
> +
> +static int mp2629_get_usb_type(unsigned int rval)
> +{
> +	switch (rval) {
> +	case MP2629_SOURCE_TYPE_SDP:
> +		return POWER_SUPPLY_USB_TYPE_SDP;
> +	case MP2629_SOURCE_TYPE_CDP:
> +		return POWER_SUPPLY_USB_TYPE_CDP;
> +	case MP2629_SOURCE_TYPE_DCP:
> +		return POWER_SUPPLY_USB_TYPE_DCP;
> +	case MP2629_SOURCE_TYPE_OTG:
> +		return POWER_SUPPLY_USB_TYPE_PD_DRP;
> +	default:
> +		return POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +	}
> +}
> +
>  static int mp2629_charger_usb_get_prop(struct power_supply *psy,
>  				enum power_supply_property psp,
>  				union power_supply_propval *val)
> @@ -367,23 +455,7 @@ static int mp2629_charger_usb_get_prop(struct power_=
supply *psy,
>  			break;
> =20
>  		rval =3D (rval & MP2629_MASK_INPUT_TYPE) >> 5;
> -		switch (rval) {
> -		case MP2629_SOURCE_TYPE_SDP:
> -			val->intval =3D POWER_SUPPLY_USB_TYPE_SDP;
> -			break;
> -		case MP2629_SOURCE_TYPE_CDP:
> -			val->intval =3D POWER_SUPPLY_USB_TYPE_CDP;
> -			break;
> -		case MP2629_SOURCE_TYPE_DCP:
> -			val->intval =3D POWER_SUPPLY_USB_TYPE_DCP;
> -			break;
> -		case MP2629_SOURCE_TYPE_OTG:
> -			val->intval =3D POWER_SUPPLY_USB_TYPE_PD_DRP;
> -			break;
> -		default:
> -			val->intval =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> -			break;
> -		}
> +		val->intval =3D charger->chip_info->mp2xx_get_usb_type(rval);
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> @@ -550,11 +622,72 @@ static ssize_t batt_impedance_compensation_store(st=
ruct device *dev,
> =20
>  static DEVICE_ATTR_RW(batt_impedance_compensation);
> =20
> -static struct attribute *mp2629_charger_sysfs_attrs[] =3D {
> +static struct attribute *mp2xx_batt_imp_sysfs_attrs[] =3D {
> +	&dev_attr_batt_impedance_compensation.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(mp2xx_batt_imp_sysfs);
> +
> +static ssize_t usb_fast_charge_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct mp2629_charger *charger =3D dev_get_drvdata(dev->parent);
> +	unsigned int rval;
> +	int ret;
> +
> +	ret =3D regmap_read(charger->regmap, MP2629_REG_INTERRUPT, &rval);
> +	if (ret)
> +		return ret;
> +
> +	return  sysfs_emit(buf, "USB DP %u:DM %u\n", !!(rval & BIT(2)),
> +			 !!(rval & BIT(1)));
> +}
> +
> +static ssize_t usb_fast_charge_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +				     size_t count)
> +{
> +	struct mp2629_charger *charger =3D dev_get_drvdata(dev->parent);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > 3)
> +		return -ERANGE;
> +
> +	ret =3D regmap_update_bits(charger->regmap, MP2629_REG_INTERRUPT,
> +				 MP2733_MASK_FAST_CHARGE, val << 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(charger->regmap, MP2629_REG_INTERRUPT,
> +				 MP2733_MASK_FAST_CHARGE_RESET,
> +				 MP2733_MASK_FAST_CHARGE_RESET);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(usb_fast_charge);
> +
> +static struct attribute *mp2xx_fast_charge_sysfs_attrs[] =3D {
> +	&dev_attr_usb_fast_charge.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(mp2xx_fast_charge_sysfs);
> +
> +static struct attribute *mp2xx_all_sysfs_attrs[] =3D {
> +	&dev_attr_usb_fast_charge.attr,
>  	&dev_attr_batt_impedance_compensation.attr,
>  	NULL
>  };
> -ATTRIBUTE_GROUPS(mp2629_charger_sysfs);
> +ATTRIBUTE_GROUPS(mp2xx_all_sysfs);
> =20
>  static void mp2629_charger_disable(void *data)
>  {
> @@ -564,6 +697,23 @@ static void mp2629_charger_disable(void *data)
>  					MP2629_MASK_CHARGE_CTRL, 0);
>  }
> =20
> +static const struct mp2xx_chip_info mp2xx_chip_info_tbl[] =3D {
> +	[CHIP_ID_MP2629] =3D {
> +		.rfields =3D mp2629_reg_fields,
> +		.chip_props =3D mp2629_chip_props,
> +		.has_impedance =3D 1,
> +
> +		.mp2xx_get_usb_type =3D mp2629_get_usb_type,
> +	},
> +	[CHIP_ID_MP2733] =3D {
> +		.rfields =3D mp2733_reg_fields,
> +		.chip_props =3D mp2733_chip_props,
> +		.has_fast_charge =3D 1,
> +
> +		.mp2xx_get_usb_type =3D mp2733_get_usb_type,
> +	},
> +};
> +
>  static int mp2629_charger_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -578,6 +728,7 @@ static int mp2629_charger_probe(struct platform_devic=
e *pdev)
> =20
>  	charger->regmap =3D ddata->regmap;
>  	charger->dev =3D dev;
> +	charger->chip_info =3D &mp2xx_chip_info_tbl[ddata->chip_id];
>  	platform_set_drvdata(pdev, charger);
> =20
>  	irq =3D platform_get_irq(to_platform_device(dev->parent), 0);
> @@ -586,7 +737,8 @@ static int mp2629_charger_probe(struct platform_devic=
e *pdev)
> =20
>  	for (i =3D 0; i < MP2629_MAX_FIELD; i++) {
>  		charger->regmap_fields[i] =3D devm_regmap_field_alloc(dev,
> -					charger->regmap, mp2629_reg_fields[i]);
> +					charger->regmap,
> +					charger->chip_info->rfields[i]);
>  		if (IS_ERR(charger->regmap_fields[i])) {
>  			dev_err(dev, "regmap field alloc fail %d\n", i);
>  			return PTR_ERR(charger->regmap_fields[i]);
> @@ -613,7 +765,16 @@ static int mp2629_charger_probe(struct platform_devi=
ce *pdev)
>  	}
> =20
>  	psy_cfg.drv_data =3D charger;
> -	psy_cfg.attr_grp =3D mp2629_charger_sysfs_groups;
> +
> +	if (charger->chip_info->has_impedance &&
> +	    charger->chip_info->has_fast_charge) {
> +		psy_cfg.attr_grp =3D mp2xx_all_sysfs_groups;
> +	} else if (charger->chip_info->has_impedance) {
> +		psy_cfg.attr_grp =3D mp2xx_batt_imp_sysfs_groups;
> +	} else if (charger->chip_info->has_fast_charge) {
> +		psy_cfg.attr_grp =3D mp2xx_fast_charge_sysfs_groups;
> +	}
> +
>  	charger->battery =3D devm_power_supply_register(dev,
>  					 &mp2629_battery_desc, &psy_cfg);
>  	if (IS_ERR(charger->battery)) {
> --=20
> 2.32.0
>=20

--s5ivbd5hwmeiyko3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNb4eMACgkQ2O7X88g7
+pocyQ//WG4VuV6A+ijHrbYeD2xEiZU0wgCkpOwmOthZ+7v7Tn6TTmGwa7fchsOL
5xyTfi5y7G+ODIVKGhqgckWXd2Jsbpb1S6DDZSILeMAbL8Oi8fgAl6ZyNRdFPTIi
AXYM03pGuITH/22TM0hdcQ/218Q/flpp+ENbgKNgTpPRyR0nfSSNqvST/aVm1ElG
Z4iTW58PbWB0mEBGMkz/tRjLq7yDr9lti/Qay+WZl1IHgcJK2sTsjF9nSwH+UYUH
BEx5IBj83uTajjtuwslj4+u2b/9lI+Jl6nMi6+arFML4qlp8YIKlnI+24qouo5xg
uxrMk2RwOWpXvDQaWVDoXfyKtRmaYXYdPhkSnhALRYEkJXkDLs+o/lRUDymMGHRH
FXKN3a7noyOVCFO4FilgUuUCQd1UrvkjNXb3wsfIfGNHHO7TK6dXzk1os4liWQFI
MLuG569T2sjJyFI9c1nISIwEU2metqHza4eGQNzsrzoRuAELHcmbtwgmbdHCbAGo
f+Lszs2vkTLZ6oV0Dlh/ZE3sN2D71fL6K9ad13KJW6By0a5I90nlyHuBkleC6j8U
+0daSfVTVUpe3jgUOQGgewoB+9IzbeRr02mqdomn9Dj544ER7b4kgKGpnVPypDTY
SzvvmPqr19DaSQ1GsH0NOTe11rx5+1BgTVwy7otvKnzpjoEpib8=
=E2Vh
-----END PGP SIGNATURE-----

--s5ivbd5hwmeiyko3--
