Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184C6113FC
	for <lists+linux-iio@lfdr.de>; Fri, 28 Oct 2022 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiJ1OGE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Oct 2022 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiJ1OF4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Oct 2022 10:05:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445251D5869;
        Fri, 28 Oct 2022 07:05:55 -0700 (PDT)
Received: from mercury (unknown [37.84.150.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 85B346602925;
        Fri, 28 Oct 2022 15:05:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666965953;
        bh=ZKWOJrdPclNKs3XXHSb+DRfOCLdcNJAvkWIYYQjz6uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhWvOXJogvEpW0qPuuxRy1WbfW4T5zOb4qok+o8llbMOxu0lnt5T+nf/1uHNs1iJD
         ZzelAFRwj55TSj8tgnnCw8elDiaKlVlLT2WeYjNLViOZWv92by44/k4RKAZbYGpNDm
         zDn4KyNon3T2gwvmYduow7wlrcn75oU5iYUt3OVqQH9DfkDJtPoGTjMgokjzXIDasW
         t+G3CZ0YnDbatO9J4BQfF+37fGJojZ2X/rueFmDe8kw7nh2K2fJyajTS82M3dSccLE
         TQrKnBo0+CdR5Fg6GLR+YmO4rqZ/Nm7C8PCiAW2OTVJ5EohCaFRcZyMkVfKBc6K88v
         UQPi0h9WNygjQ==
Received: by mercury (Postfix, from userid 1000)
        id 2D0D810607E8; Fri, 28 Oct 2022 16:05:51 +0200 (CEST)
Date:   Fri, 28 Oct 2022 16:05:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jic23@kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 6/8] power: supply: fix failed to get iio channel by
 device name
Message-ID: <20221028140551.cerlozkr4ixj772z@mercury.elektranox.org>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
 <20221024132757.3345400-7-sravanhome@gmail.com>
 <CAHp75VcvZ9drkFfbpVJFz0UWQvOMgAu3+JmV4HvOG3dPKDoN5w@mail.gmail.com>
 <049e0cf3-49b9-ed25-c595-06de22117f1a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oae75tq66mg3uoqn"
Content-Disposition: inline
In-Reply-To: <049e0cf3-49b9-ed25-c595-06de22117f1a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oae75tq66mg3uoqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 24, 2022 at 04:02:21PM +0200, saravanan sekar wrote:
> On 24/10/22 15:49, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> =
wrote:
> > >=20
> > > The mfd cell devices name populated on sysfs entry is dynamically der=
ived
> > > from an auto instance which introduced a regression. As a result
> > > mpc2629_charger driver failed to get adc channel because of iio consu=
mer
> > > name mismatch with the sysfs.
> > >=20
> > > /sys/class/i2c-adapter/i2c-1/mp2629_adc.0.auto/
> > > /sys/class/i2c-adapter/i2c-1/mp2629_charger.1.auto/
> > >=20
> > > Fixes: 466a62d7642f(mfd: core: Make a best effort attempt to match de=
vices)
> >=20
> > Wrong Fixes tag format, moreover the fixes should be grouped at the
> > beginning of the series, so it will be visible and splittable based on
> > this property.
>=20
> Thanks for quick review Andy, I will correct fixes tag format and group a=
ll
> the fixes beginning of series in v5.
>=20
> Thanks,
> Saravanan

Also the patch subject has incorrect prefix. It should be "mfd:"
instead of "power: supply:".

-- Sebastian

--oae75tq66mg3uoqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNb4bsACgkQ2O7X88g7
+pq2EQ//XBXjtJ09TZDmfNp+pWsRRw9og5GmYViAnjmcMbpqHBtlJbQa3AnSsvF+
fRxJDnJCRXgw9uja/oS3aIBak9h0ugT9d/9URUWlErsETlqfMlYxABGg8SCkoeZq
ThHprYkjoiApva3fOrhCciua7nmjZ2urWKjVMQgGghtcgjSzk6FojrocS+GElsQu
882iUjtFrxX2lQit3+1dROiQxF9VBbt+19P9aeBbw83sHhirvW23XxgwsQxTkqNb
o7sys5nBzudRC0hwgvhvyg4pkB7NkTkIQKDgXpXhEmrt7DsKwhyixJg6+1eOEmlr
mg47yxQJbAqosvuLqv0hCR0H5reQ09nJf4vqCn/FJUqlXigiJwOJRspYeH66L77R
zfGNeihOn8LWMWNLeuelym1T2j+XBPjYjiDhQor11+z/KXJrgwjBanPhr7zsQfTJ
mPThE1vnchfD92MEW/L3IC28W8wsgZ4IzZNZsGc3c0kAXxY2okXy1vS2QdZx6zvG
rUbbhhQcEJn5mjuqaPwuNQ3jHf5HlLVyLoEGY9Dj1yd52lEfiCg5ZtsoPJ57U/kl
doLnF1jeWK93HzsyrA65CD/QY9mO5OOpZRIdKenb3szIDeSRtf8SSx3eHsaOLf6A
lm8jlSYyrDE25CDeMSW/UboEXxTY4iIFmu6VsNebCp1fKnlPfro=
=rGEa
-----END PGP SIGNATURE-----

--oae75tq66mg3uoqn--
