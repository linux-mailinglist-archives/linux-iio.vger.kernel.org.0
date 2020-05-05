Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E8D1C5434
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEELPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 07:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgEELPp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 May 2020 07:15:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128C8206B9;
        Tue,  5 May 2020 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588677344;
        bh=vtu5GHsCjBoB2Bedh5aRks/mxahJYgZlfE34xp2wlIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfNfW74SAPPvuZBiqOh+oyuxA4W7PhgS2sqto2isWgf0GkDP1HvE12vOqBpdEDTH3
         3JJKJiWRsEAkqIDxdPRivgstpfyHjirzHSB7dkmBQSNF5EuU2KV/ETkeyaHa5C1GDy
         lJ1XykGskWnkg2UXe9KQec/8WX+KB06Cy70oPhtY=
Date:   Tue, 5 May 2020 12:15:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leslie =?utf-8?B?SHNpYSjlpI/pgqbpgLJfUGVnYXRyb24p?= 
        <Leslie_Hsia@pegatroncorp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hermes =?utf-8?B?SHNpZWgo6Kyd5pe75YqtX1BlZ2F0cm9uKQ==?= 
        <Hermes_Hsieh@pegatroncorp.com>,
        "jesse.sung@canonical.com" <jesse.sung@canonical.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] ASoC: tas5805m: Add TAS5805M amplifier driver
Message-ID: <20200505111541.GB5377@sirena.org.uk>
References: <754706C925201D4896E92CCAD6B38E4401F0F7B98A@PTW-EX-38.PEGA.CORP.PEGATRON>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <754706C925201D4896E92CCAD6B38E4401F0F7B98A@PTW-EX-38.PEGA.CORP.PEGATRON>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 10:36:29AM +0000, Leslie Hsia(=E5=A4=8F=E9=82=A6=E9=
=80=B2_Pegatron) wrote:

> +struct tas5805m_priv {
> +       struct regmap *regmap;
> +       /* mutex for getting the mutex and release */
> +       struct mutex lock;
> +};

This actually appears to be for device initialization somehow - the
comment isn't super enlightening.  It's not clear to me that there are
any potential races here - the PM stuff and device probe and removal are
already locked further up the stack.

> +/* Initialize the TAS5805M and set the volume to -6.5db,
> + * and set it to Play mode.
> + */
> +static const struct reg_sequence tas5805m_init_dsp[] =3D {
> +       { TAS5805M_REG_DEV_CTL2, TAS5805M_DEV_STAT_DSLEEP },
> +       { TAS5805M_REG_DEV_CTL2, TAS5805M_DEV_STAT_HIZ },
> +       { TAS5805M_REG_DEV_CTL2, TAS5805M_DEV_STAT_DSLEEP },
> +       /* set volume to -6.5dB */
> +       { TAS5805M_REG_VOL_CTL,  TAS5805M_DIG_VOL_DB },
> +       { TAS5805M_REG_DEV_CTL2, TAS5805M_DEV_STAT_PLAY },
> +};

You should use the chip defaults unless the configuration is so obvious
that almost all users would want the same setting.  This avoids the
kernel having to take decisions about which use case to support, a
volume that makes sense for one system may not make sense for others.

> +/* Setting the TAS5805M state and save the config in the default page. */
> +static int tas5805m_set_device_state(struct tas5805m_priv *tas5805m,
> +                                       int state)
> +{
> +       int ret =3D 0;
> +
> +       ret =3D regmap_write(tas5805m->regmap, TAS5805M_REG_DEV_RESET,
> +                               TAS5805M_DEV_STAT_RESET);
> +       if (ret !=3D 0)
> +               return -EINVAL;
> +
> +       /* Saving the config to the default page of the default book */
> +       ret =3D regmap_write(tas5805m->regmap,
> +                       TAS5805M_REG_DEV_BOOK,
> +                       TAS5805M_DEV_BOOK_DEFAULT_PAGE);

regmap has support for paging, you should probably describe the pages in
the regmap config.  Right now I don't think things are going to work
well since there are no pages described but caching is enabled which
means that regmap will cache values that are getting paged out.

> +static int tas5805m_i2c_remove(struct i2c_client *i2c)
> +{
> +       return 0;
> +}

You can just delete empty functions like this, if things can safely be
left empty then they can just be removed entirely.

> +MODULE_DEVICE_TABLE(acpi, tas5805m_acpi_match);
> +#else
> +#define st_accel_acpi_match NULL
> +#endif

This is redundant, ACPI_PTR() won't reference the value unless ACPI is
enabled.

> +#else
> +#define tas5805m_dsp_power_pm_ops NULL
> +#endif
> +
> +static struct i2c_driver tas5805m_i2c_driver =3D {
> +       .driver =3D {
> +               .name =3D TAS5805M_DRV_NAME,
> +               .acpi_match_table =3D ACPI_PTR(tas5805m_acpi_match),
> +               .pm =3D tas5805m_dsp_power_pm_ops,

Use SET_SYSTEM_SLEEP_PM_OPS() and remove the else case above.

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xSt0ACgkQJNaLcl1U
h9CiMAf/ZKvO/0B6pAjUy/yQVw4VWZBx6OHrixkNWwV7g1HLaYngtK6Tp3mbn5bE
k6pUrhlRYfcY0djwIAxjfnEn/ZWSaHXkz35ihcxewxtd2BTMvekDsoIDjoFEfRFe
qsYiiNXB9s//7rt88m2oZdKhFPEC/rqIjZJhN5LLlEcfctfDFoOWMQIOIPyMFf7C
Ee7xV7i6H9+HwseTQBXUjME/m4yJBmUnQTgmuNp1BJwaPpNHi6qXcKnNx7KASo++
n566C4jap0vQ0eFERtUkdOEp4tR5Lm2rbMnxMmrj6lynAJNOzhqe30yhxKvmZBfi
ggBxKBnsLSnFN67EhYFw24Gr7qOJgA==
=cB/8
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
