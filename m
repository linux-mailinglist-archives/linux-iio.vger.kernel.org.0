Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE49641E843
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhJAHYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJAHYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Oct 2021 03:24:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE5C061775;
        Fri,  1 Oct 2021 00:22:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g41so34978411lfv.1;
        Fri, 01 Oct 2021 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UZCnsoRR6tW1pSh/IupBZu9naoc4rbVQqcvJGsUgDM8=;
        b=HKGgvPjKlFCWLm7BRyC5cSgjT8DG5b9iXAkdPjGc/vSMDpB6q3emnZ7uOPH5/FRD+/
         Zk9D/JS5ROA52aISv5HViAzvpxnNJo+1fN2I8UB6RnKn6Th4pylfQUX4z60YwgO3EuBa
         QqoktQ9TresMl42XFcfEnxG+bXWP5BYe4pKyFVrj4LzqVxU8qMmpEVB7fTFQoJNbVNTJ
         l/j8djErJs+xs1vM2bhyO41t/QMog+2Sb3GX+90JNXUOqLackzR6GZrEM9jcjeSU5l/x
         dYSvWFdj50XEnyfMZCmTJb6gKStjvBRX0mutqJQXaoIWuQmsIuZGq62Ch2Ut5dk28gnB
         RmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UZCnsoRR6tW1pSh/IupBZu9naoc4rbVQqcvJGsUgDM8=;
        b=QdYmGac1gHbDDxs4vjQpCnelZcFc4xm8he/Lftoc2iT1mJC5xTnXqxGLafNccAwBEW
         CCr15Uu8FS3tPBMLxG4z6DlpJxtFijzMncYC3hyw/buwj8VXmtY/LRj56w+mqppePvKk
         dCSAt+96nM1XbKDykcQAd1NS1AnCvFQYzKgRGSJVPSOkYDYrjs6N0+NKaXBZBTqM3rMn
         tgSbChnrSyz5giqnEN7zvWX0GsFvdPfEfNuqlUjqlNL3TFoYLDlXiUNYPCyxE5mK2qrR
         GQj0gwpSeg+c3wnUr+RZ4kfYFd6D37Kr5wg8Cjq7GhI+dvmFQTbJAcpMUvC+aRpKj0i6
         8Xwg==
X-Gm-Message-State: AOAM530d0g26EDOQJmp0I23jPloapkm3dJb4kpK8uzXAgggXKB/IGY77
        yQ650m7op3P387fqNHospWs=
X-Google-Smtp-Source: ABdhPJwvtum04dzFdOmyZug6tdJxz7a6DQk1UzdnIGCSZLXX+LPE5ovwTftul+8mAvi0Los0Xnu+qw==
X-Received: by 2002:a2e:95cc:: with SMTP id y12mr10476403ljh.337.1633072940119;
        Fri, 01 Oct 2021 00:22:20 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id d27sm583764ljo.119.2021.10.01.00.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 00:22:19 -0700 (PDT)
Date:   Fri, 1 Oct 2021 09:22:24 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/8] iio: dac: ltc1660: Make use of the helper
 function dev_err_probe()
Message-ID: <YVa29EEA0QDOIYRz@gmail.com>
References: <20210928013902.1341-1-caihuoqing@baidu.com>
 <20210928013902.1341-3-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jPhrg6tqow6ibvlc"
Content-Disposition: inline
In-Reply-To: <20210928013902.1341-3-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jPhrg6tqow6ibvlc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 28, 2021 at 09:38:56AM +0800, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--jPhrg6tqow6ibvlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmFWtysACgkQiIBOb1ld
UjJPlw/7BcTosUvT5m+Tec7d5bCXiVt6Sp7/scCFAbVVt/vOdsDQyirVVNalaAKk
+k55V9yI+zpOzdywX8XqerCXQoZxqHJMWRlKl980SZbBSTracjAgQsu5n3wrC/Fv
f5PgZS1SJFAn62xfFWAMBICxFVG0yKYBSHNOGjeWCKxUBUsKZ2sObI3/0cYpEOr/
syoeqoI5drSBTKUOeYsoQ9QX61S906K2dR896wZ3td96Vt6aDvk7qtLNcrMZWfPh
M3rQjBXIO1FedNr6BXcj52tzxTOke7aMRV6/vUeL4z4g4G3uvEfhP2SmdYy7uEnT
5nda00ezX3Pjr3P+NgiCl/Urvh6FT6OUJuE/e7H4Cz3hGTvIxMBrG//uC646IF0p
ndV/sAr246ODba6z5G7seWutG7+L+m8cOcC4tb6RNlaFsLchUaIS1ZF/WUR8jNd6
dhhwHPGEonJ5hpAwDvFew+Lhztp3eSMZwDnJJ0GPbWdr+UCqHNiQ7wneo5DAINgd
1YiG6BmT1y8ZQJYH9eCXLv5vZDZq7Xujbdk8YZFdJfvVLwCrfHVnGqcaxDf2gEkp
5o1h+WdrhFSVg4wjXUahVjo2fgNmwD68kz6U5OmP/2N0pVEIZMO6b6JiBb6LiGWz
my1pn3NRxGJ9OaAetWCrKolBli/8HGQTrlREha7utfzrPQuoPCE=
=XqrG
-----END PGP SIGNATURE-----

--jPhrg6tqow6ibvlc--
