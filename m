Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DBB171678
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 12:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgB0L4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 06:56:32 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:35364 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgB0L4b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Feb 2020 06:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hs+/+Dh4GQJI5ywUkkMPMrtyW5zokXX7/ak0kxRWiMw=; b=h5wF6WN9eECO+56oBJLDA7m5r
        2BmPipHiHuQxhnjdM8ONt3yFGPM8mIpMSF9eg/LQyLgCypmnhitz9olHW7WdocG+RNJ/5Qld6/mf0
        qf7iTLN9gpRf+S4BZF+R+gmvzitRJKKig6RhU9Ne7cb3qXnBADwG9mvLMqo7dZftAbhug=;
Received: from [2a02:790:ff:1019:e2ce:c3ff:fe93:fc31] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j7HmE-00024s-7e; Thu, 27 Feb 2020 12:56:27 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j7Hm9-000108-AU; Thu, 27 Feb 2020 12:56:21 +0100
Date:   Thu, 27 Feb 2020 12:56:14 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200227125544.510a10f7@kemnade.info>
In-Reply-To: <20200227094006.GV3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
        <20200223131638.12130-2-andreas@kemnade.info>
        <20200226154055.GQ3494@dell>
        <20200226174914.047667d5@kemnade.info>
        <20200226174640.GR3494@dell>
        <20200226190028.0de5c095@kemnade.info>
        <20200227094006.GV3494@dell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yc8PI1h7Z/61=XnB+ULCMgZ"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/yc8PI1h7Z/61=XnB+ULCMgZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2020 09:40:06 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Wed, 26 Feb 2020, Andreas Kemnade wrote:
>=20
> > On Wed, 26 Feb 2020 17:46:40 +0000
> > Lee Jones <lee.jones@linaro.org> wrote:
> >  =20
> > > On Wed, 26 Feb 2020, Andreas Kemnade wrote:
> > >  =20
> > > > On Wed, 26 Feb 2020 15:40:55 +0000
> > > > Lee Jones <lee.jones@linaro.org> wrote:
> > > >    =20
> > > > > On Sun, 23 Feb 2020, Andreas Kemnade wrote:
> > > > >    =20
> > > > > > This adds a subdevice for the ADC in the RC5T619
> > > > > >=20
> > > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > > ---
> > > > > > depends on:
> > > > > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kem=
nade.info/
> > > > > >=20
> > > > > > Changes in v3:
> > > > > > re-added it to the series because of
> > > > > > "Oh, it looks like there was a conflict.  Could you collect any=
 Acks
> > > > > > (including mine) rebase and resend please?"     =20
> > > > >=20
> > > > > Looks like there is still a conflict.  Sure, it's not a complicat=
ed
> > > > > fix, but that's beside the point.  What tree is this set based on?
> > > > >    =20
> > > > It must be applied on top of my rc5t619 rtc series here:
> > > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade=
.info/
> > > >=20
> > > > I expected it to make it into 5.6 and when I first sent the RTC ser=
ies
> > > >  (in October) I had no idea when I will continue with other stuff.
> > > >=20
> > > > That is why I sent this ADC series separately, also to give the IIO
> > > > maintainer plenty of time to review.    =20
> > >=20
> > > If a patch-set can or should be applied on its own, you should send it
> > > based on an upstream commit, or else things like this happen.
> > >  =20
> > It cannot without breaking bisectability. The RTC series adds IRQ suppo=
rt in
> > the PMIC which is used here. =20
>=20
> Then Kconfig should reflect that.
>=20
> Or, if that's not possible, then you should not break-up and submit
> sets which cannot be applied by themselves.  Either submit the whole
> set together, or submit them piece by piece, not submitting the next
> part until it's predecessor has been applied.
>=20
I will send you a complete series containing both RTC and ADC support.
Then you can decide wether you
1. apply the whole series (both things)
2. apply RTC for 5.7 and this series later
3. ignore them  (not my preferred choice ;-) ).

BTW: The way I did was based on the following note in=20
Documentation/process/submitting-patches.rst

"If one patch depends on another patch in order for a change to be
complete, that is OK.  Simply note **"this patch depends on patch X"**
in your patch description."


Regards,
Andreas

--Sig_/yc8PI1h7Z/61=XnB+ULCMgZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5Xrl4ACgkQl4jFM1s/
ye+f3A//WjqnfE2Ok7w+zmm/hu9FQonJQnp77QUGgDJxnG9IE2f0pdcQO+PZwLTF
bqP3/lyDiFhCUI425h2UHNm3YB2CxnNDUqcqzmvTKRQVqlNIgInBySfX8VGpLT/J
AKEV7bwkfpS7J9SxIEV+Gj0ljjkRktc7kFufkXjeMoGaVcflXk981CsfNFQJV5QQ
ZLx/DDrosKKOB7CzEo5brffI1o7dD64n3qTWlXgBaU56uO/DKQGwqAE1Vfa+V7Jb
l6IeBJ6cp03ywEHtXdGxSBkmrOxUx39fdWbCnCc+KY9LGzgXf72MSmKfMHJlADmc
DCg/ZQ0yfpAt+a8LlCTCuhmQ8w3XpapNrDItS8Y0oVp3hqwUt2ttDyKq1Hl4ytqV
hmf9fz1VAKHnccQ+87T/qYgVuu5HETorKeF9L+EJWYC7Y2yWB4vhPvg7nhOp57nI
VGV8Vbcz9pdHVWZVTPB+N0D2J1lFZeEKMCNf+GwrEinbLEru5Nq6iybyA1/yHLCA
FHnAa/sHZnelLqgvpKU09VOMm1T1J+A40TKAENigHCmgkv4TdA1SvgIk++2+qYEY
dZr/qGv3/9hMpqVBbguifvM1onF8KiyIIh5DpRhFoVLqfrdQ6VzeC8iP/M2rU+RZ
xi4zqSmPUfai4QpgIHlnwhs7nJJ8GpUZlwPbrFxKlOao3VNLGFo=
=EWRZ
-----END PGP SIGNATURE-----

--Sig_/yc8PI1h7Z/61=XnB+ULCMgZ--
