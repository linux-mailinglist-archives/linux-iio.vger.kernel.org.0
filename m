Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9851704D0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 17:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgBZQte (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 11:49:34 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:51194 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBZQte (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Feb 2020 11:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P56BFZWamG7JVi5EgA3IO5By5L2fJQkXtDUqwdKc7H8=; b=nhwrU49dYAVK7MXWS2u8nYT/9
        +bdVoX9QXCfQjOzVTqQuTGRXrzgHudnjPG6MGpBHPtZxI1bmFu9jSEtHHOyyoZIMJR6eSJc4v/Jcd
        faMn/39D6dLBopiZfQAkiaqC0fgYRj7aCKmtCNbTiBSm9AjQUcG+QEMBDpBWUvlP8gM1g=;
Received: from p200300ccff0a4d00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0a:4d00:e2ce:c3ff:fe93:fc31] helo=eeepc.fritz.box)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j6zsF-0005wQ-To; Wed, 26 Feb 2020 17:49:28 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j6zsF-0008HY-A5; Wed, 26 Feb 2020 17:49:27 +0100
Date:   Wed, 26 Feb 2020 17:49:14 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200226174914.047667d5@kemnade.info>
In-Reply-To: <20200226154055.GQ3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
        <20200223131638.12130-2-andreas@kemnade.info>
        <20200226154055.GQ3494@dell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L_RLDD1+TTq2HvsW_OIvA3r"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/L_RLDD1+TTq2HvsW_OIvA3r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2020 15:40:55 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Sun, 23 Feb 2020, Andreas Kemnade wrote:
>=20
> > This adds a subdevice for the ADC in the RC5T619
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > depends on:
> > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.inf=
o/
> >=20
> > Changes in v3:
> > re-added it to the series because of
> > "Oh, it looks like there was a conflict.  Could you collect any Acks
> > (including mine) rebase and resend please?" =20
>=20
> Looks like there is still a conflict.  Sure, it's not a complicated
> fix, but that's beside the point.  What tree is this set based on?
>=20
It must be applied on top of my rc5t619 rtc series here:
https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/

I expected it to make it into 5.6 and when I first sent the RTC series
 (in October) I had no idea when I will continue with other stuff.

That is why I sent this ADC series separately, also to give the IIO
maintainer plenty of time to review.=20

Do you want me to resend all that pending stuff together in one series?
I have little experience with this multi-subdevice process.

Regards,
Andreas

--Sig_/L_RLDD1+TTq2HvsW_OIvA3r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5WoYoACgkQl4jFM1s/
ye+ZWBAAlmt7rg97sZQ3GPCFNa2uKfakvISbA8/O/UuPWm9/BLbEh0ZhKlrEX7l5
FjLu4nB1RBMhUvBrjykGfnPt/rasdrJ9DrzhFpbtMu/lrV1SdrowUjmKJfKDvCyz
CWt4RuITcNWF3FQNWTKaPhFa0lyAhOj7X4A8bseYRhMdkYmvQc3uoMuTgdLIuNMe
9g/t9ll8ztoBbdl0u6RhD36uhBylB+4AS6Axt9lwzGrr8mSs4tNKQlMi31yCNrmg
tQExAuXNgBtvDz8TwWF8lD2HRlivu/QDNv6bxbYZ92O5dDtK8l3LKiu5pB4iEWAQ
2v0yjmleaJ8NmhigSqqTyqctFgyvYuwGdYDJN3OphhS/8o7BC9MqOSzBGiqmeqCf
I0Z8tg+BaDMX5RFD8hGYKnmiUvKWZiokk2+yFsJb6Lh5PTS0WWVSdcA5/FNCy2Xw
ykae4GWg/k7BZZPGu6hGN07Bvs3dKPli/NK6inv763aCuUgMLR8quQ5tsz6U6itG
gx1YAvE22uWKXT2QVV414pxTQwxztdiAfRUvXpHH7Es/4y931WJ4C2enlOt2YQyi
/UAHYnyOAemRIwN1jo396G6O+SkjU0rNrOfU8XiOSktg+7QC2sVW3sMSTHonx6af
rBqbxj/+F374TXC384M2vhlihTq6lji9KuNtS3TPDTfF7eP5rBU=
=oLpK
-----END PGP SIGNATURE-----

--Sig_/L_RLDD1+TTq2HvsW_OIvA3r--
