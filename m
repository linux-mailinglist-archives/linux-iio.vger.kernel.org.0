Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C099B18C315
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 23:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCSWlW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 18:41:22 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:55432 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgCSWlV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Mar 2020 18:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UxynVAQmB37MrV2BBnLFAl3yAnEIKuq4soEmhRhTUMY=; b=bLPyBAYAEOMNB1jI8DwJ7T0y7
        ZUDtkFc6/LyuMwPrJ4cDJKsFgBSL8M9ib+hnkTgkjt7y9um5YO/6lnplfyHTRzmuUJ6iHyeQCkCwA
        9vYzINSz0kf2H0K7s9NbW0+QsjP4ORmiHj8YMyi1xfAuaB1+18Menlst+7erJhI0iHqfw=;
Received: from p200300ccff0fcb00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0f:cb00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jF3qc-0007UW-46; Thu, 19 Mar 2020 23:41:06 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jF3qb-0007PO-3s; Thu, 19 Mar 2020 23:41:05 +0100
Date:   Thu, 19 Mar 2020 23:40:55 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH RESEND v6 2/7] mfd: rn5t618: add IRQ support
Message-ID: <20200319234055.4caddf44@kemnade.info>
In-Reply-To: <20200319161149.GB5477@dell>
References: <20200313064535.31503-1-andreas@kemnade.info>
        <20200313064535.31503-3-andreas@kemnade.info>
        <20200319161149.GB5477@dell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//EX9XsAMI56qY1RDkmzKv0C"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_//EX9XsAMI56qY1RDkmzKv0C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Mar 2020 16:11:49 +0000
Lee Jones <lee.jones@linaro.org> wrote:

[...]
>=20
> > +		if (rn5t618_irq_init(priv)) =20
>=20
> If this returns an error, you should return that error from .probe().
>=20
Ah, ok, I am returning 0 if there is no irq, so
forget my previous comment about regressions.

Regards,
Andreas

--Sig_//EX9XsAMI56qY1RDkmzKv0C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5z9PcACgkQl4jFM1s/
ye+9PBAAkD8XGU0U70Nq6g9WtazIPRJkbU7warY/dnCxjXOwPNdyFK6k548ojrxL
gnTkd9ernC1OlbMV//88bqZ+bHwRzO+ndeI1EhD9GP88t+YGhVRfzuLq9Qfc65s+
s6BMzOdzOuIuQkCxRA3ekxourgniXtG60hJVPvn6HXhBbCi7CpXWrUkl1CGwNgsc
7JkUwWJuAfHq0YoGdh1RU7L/NgBtNz/WZnL5Tdzj/KD/M1USMGDQpu7Amx57fAcR
Q91Lh3dYnp3fALNCbKLOoFph9o23bmxOAohoZugH9dLlDXH3nAESMs7Bm69C+iew
B1PY4Tr9hOuDd51HCRJXJv9Hdr3LjRWT+aVrnyq9qI6IT1HUKDoPVkgDJaFk1rtP
wHkaT72OMC2/pFGAXZQ9xc6GIIVQphE6D6rBO5fjbBroCA191taxvprxW09bxOLi
MT08eTvxwoIuz2YbI7BjO+ubAyeTZ07UT5rMHCK6cFhKfeav7EHU03uopgitZRb+
4XBIg+EimxtGk69XUNNRWXUlXuBbxik45b4evoP3vCFzia6nAbYoXerq7efD1uRC
eRpPst3mQFQCDITCW+WtiM0QlRxMuqbMjo5PtpKctu/R9M/LC0I5CyjpH7eaENln
6F6cQdPcnrATMf6xNHCvmCYW/G2BWTrI0JlAhiL29gisfQNUUxY=
=a4gN
-----END PGP SIGNATURE-----

--Sig_//EX9XsAMI56qY1RDkmzKv0C--
