Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80FD16AF02
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 19:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBXS07 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 13:26:59 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:59030 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgBXS07 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Feb 2020 13:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dW1HMa4rYjoRN6o4qGmlHnnb84Fh1VUVfvXVgxMfmUQ=; b=dY8IaE5CkgPLQ7YZC6gvSfchU
        3ywVvcIqgeMU25nroaLZf32pvbv+xAMcAMNa4+l0rvk0kTOsHKY+JxW591vlJ34Q9KQM97ZZDO4ew
        VF+TT6zjRvo/eTwvuiU3reMvFZeb/KMqN8fzpOH/J8kCjdTmwLO5KCmzTdd1jBxWrlowM=;
Received: from p200300ccff096700e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff09:6700:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j6IRO-00020N-La; Mon, 24 Feb 2020 19:26:51 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j6IRN-0003Su-VR; Mon, 24 Feb 2020 19:26:50 +0100
Date:   Mon, 24 Feb 2020 19:26:38 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v3 2/4] iio: adc: rn5t618: Add ADC driver for
 RN5T618/RC5T619
Message-ID: <20200224192638.5e928565@kemnade.info>
In-Reply-To: <20200221130733.240f0d6d@archlinux>
References: <20200218061725.22420-1-andreas@kemnade.info>
        <20200218061725.22420-3-andreas@kemnade.info>
        <20200221130733.240f0d6d@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8qWJlQBWjvmN_Jw+gTD8qUG"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/8qWJlQBWjvmN_Jw+gTD8qUG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2020 13:07:33 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 18 Feb 2020 07:17:23 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>=20
> > Both chips have an A/D converter capable of measuring
> > things like VBAT, VUSB and analog inputs.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info> =20
> One trivial comment inline.  Looks good to me and I'm assuming
> this will got through the mfd tree.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> > ---
> > depends on (build and runtime):
> > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.inf=
o/
> >=20
Is there anything left on my side to do which prevents merging of these
series? The above-mentioned series add interrupt support for the mfd, which
this series uses, so this series cannot be applied without that.

Regards,
Andreas

--Sig_/8qWJlQBWjvmN_Jw+gTD8qUG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5UFV4ACgkQl4jFM1s/
ye/Ovw/9G4MUqzsiPEnHC0EDXiLwMc2+0J/bKLt40RhYk1A5a2MVuB8JcYaDPsdd
zeqTnzOpbyytZtrDm1Xnp6qb2jdxBT8fO1n24GxVEpYS+0D55BBK02lxOg5J1czO
yau4y/N/F7qSYXZNOcr95zcr5/BmSy9TxOyTfiZOF6wh0EkmJi21gn1MbkouiGeM
rFTw9JzTVm8n+cw/309ltJyzL9mVgFaM/UfJU7nsvxCzjSpIvnn2fkSYCHTfhsQl
ec742IsXfS/9myKcOi401PuePAvclL52SIoNH+2oc1M1xXGjof93sALEXLF17AiF
bRGj/w0DDFXwJHnsAdDIYnrUnl0GTcny3tQMvcNVLAWxOQ5QALnIq8uWQa3FaIph
Z8mdIwCz1Awt5W1h0n/qdObuB75pDHDwChiH7OCF02e7KmXwLG+mPAWOW2IWDhIl
rsBFrRvwjyvotTCa9AwNLuMwJOl3435AI/hpCUTKsoi4J3tS2c23Cp4UYXSWEe0v
E50n6reMOof7oM71nNfq8xcvB5gI7UYl8Ay2zAE7MYG2ojyk/8yiGh5RN6it3ZY0
LUJdIXubjgaXi+EObOGalc4WSs7qqiZp5qGrCr0lLIeDU4spAcIdepcdIKPVcmzD
/8RxqVNQbIYcxqwh9wVoWNNqUhW8SmYm3ujqyQyOtlchL8X0khQ=
=sm5T
-----END PGP SIGNATURE-----

--Sig_/8qWJlQBWjvmN_Jw+gTD8qUG--
