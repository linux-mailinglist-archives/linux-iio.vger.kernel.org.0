Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7596113C4
	for <lists+linux-iio@lfdr.de>; Fri, 28 Oct 2022 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJ1N6G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Oct 2022 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJ1N6D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Oct 2022 09:58:03 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 06:58:01 PDT
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D51DC0A7
        for <linux-iio@vger.kernel.org>; Fri, 28 Oct 2022 06:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666964565; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Gd06fh5uJT94PD6DiH7jQD3L5iONUdOykkWc6sGXN5Y3XBtKScRM9715a9HR/LuABotZDZbMRqvdD4T3k5UtSiSxbOqd6IQA+loyQiM4wDmJ/j1hvKdYIjSrtSzH+CnDR/KZpcTICz2CJWWGjrlcpYHorI/BXzGIGF8pxf3ynYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666964565; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yzXH4QioP+retWboLDmFMYnNsxEgOfAhafDDmBwUWRQ=; 
        b=JEj0E9Du+zisdX4Mh04GQYvb6cykof3oyvNZlOHnl5kUAwhEgPlO2rrvVS2slMtvSNE5b912CcL4rgwHX81RNrZHYYvhPzpkTFQ8zJA78EkZSKvN+3tGzDEqGgzbApl2lsTHaKHDUQgvIgQXM6+51GWVw+wkZ3MDl75h8f1UPMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666964565;
        s=zoho; d=dlrobertson.com; i=dan@dlrobertson.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=yzXH4QioP+retWboLDmFMYnNsxEgOfAhafDDmBwUWRQ=;
        b=EQXnKVZ07gf1ZZv/lyzqSX9emZYo4B8QR99jC3eOdf5DHbPsFOJ3nIQhL/XUzucN
        LxZrAg/zxQZPCcFIgMbX/9Ay3KGorSoYIeUmcWd3MMj3pqeuOOZkdLAXKVRAdEhzDS8
        REbJfWu23boWTva0p9UpySD2IQSWnEGyjN/m317Y=
Received: from dlrobertson.com (pool-108-28-201-96.washdc.fios.verizon.net [108.28.201.96]) by mx.zohomail.com
        with SMTPS id 1666964563045800.2838128436016; Fri, 28 Oct 2022 06:42:43 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:07:47 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: bma400: Ensure VDDIO is enable defore
 reading the chip ID.
Message-ID: <Y1vUI9ppqVkoEuuv@dlrobertson.com>
References: <20221002144133.3771029-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nzSwB/NAjeTXSfkK"
Content-Disposition: inline
In-Reply-To: <20221002144133.3771029-1-jic23@kernel.org>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--nzSwB/NAjeTXSfkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 03:41:33PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> The regulator enables were after the check on the chip variant, which was
> very unlikely to return a correct value when not powered.
> Presumably all the device anyone is testing on have a regulator that
> is already powered up when this code runs for reasons beyond the scope
> of this driver. Move the read call down a few lines.
>=20
> Fixes: 3cf7ded15e40 ("iio: accel: bma400: basic regulator support")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dan Robertson <dan@dlrobertson.com>

Thanks for catching this!

Cheers,

 - Dan

--nzSwB/NAjeTXSfkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAmNb1CMACgkQRcSmUsR+
QqXKQRAAs4Vi84aLazoo/5gRUor4a/f78V6ETn8ecYLKZZe9LIbtnIU+ndqRhLkx
OMBAEopreXZTEsPtZ/iM/5mpZzcnnbrsNSSCPhWMPeMqD0JgDzAofZ2he7QxnPmC
9la8g1Dur9WkuisfGhiPOC2+PsYo+zQexsnT+TS4tCE8uKJe7bu67QEGjVyiEBkd
dPJNllVG0vOQoIUUnQjPwYNaxYbjqtVrW/3ku1hUxIgrg1XAz8RD9FiAhI8LgHx3
e+6sNTuHDBwzxA4Mv/PnzdCtjGWOeVkDMRKA/VUbLZFC1wkp9JFLtx3nZPc9Gg6E
Hj4SoIEnLM0IXf0CevuuNGzd42pKBdytlC52qSl8Xl9ZMysKf0+vWRBOjvD4PnWG
g42SKri6edyVpQFYl2KWsycYuKLpENpj7z/YGS1sUdtLNpnseYYQxfryRiXqZWOz
DzHb5doVENzaNFcFk6Ac0MlQRxmtzI3IlBqEdjMVJ46BJVuVYOOCih67mcT2C9Gd
j8bmmRVEcp6glQqupu4f30AOopyy1opLtgT7q+vNJlUi/iiEG8IqYN86wBX5N/SK
4FmOBfFTgSvJbmpG2liXtir5HVMd+5hvet0J28BaRY8iLAjowkZAjlUkCBrzEHvP
S49H0wPLxb+0Z0EyBWkgXOAbYPFnvBNpvZVQP6FCVpD5C0x0du0=
=DrFv
-----END PGP SIGNATURE-----

--nzSwB/NAjeTXSfkK--
