Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B02BC6EF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 17:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgKVQTq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 11:19:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbgKVQTp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 11:19:45 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A624420781;
        Sun, 22 Nov 2020 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606061985;
        bh=I7DAoSVxbe5d/oBZUnILWIvrXbLNJ7O1BlXExpKNEP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UolgD4MtdDiXWjuh/o6cL+6lVT0C4go1dSislsKtoqDkW5Vn9p00Xlm6yCTHdoNMb
         h3asqYyriQDWGv24zdkVMPVMWqCK4pVCX3313cswxKTuoQ778tZkrlGHZFBmrlNqM0
         gC2KEKBWdkvQzDFGJnBVNdz1Hd+sbYsxOMcmxMpM=
Date:   Sun, 22 Nov 2020 16:19:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 0/2] Make cb a required parameter of buffer-cb
Message-ID: <20201122161941.4e7b8418@archlinux>
In-Reply-To: <20201121161457.957-1-nuno.sa@analog.com>
References: <20201121161457.957-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Nov 2020 17:14:55 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> When going through the code of the buffer-cb interface and all it's
> users, I realized that the stm32_adfsdm driver is calling
> `iio_channel_get_all_cb()` with NULL for the cb. After going a bit
> trough the stm drivers, it looks like this is actually intentional.
> However, it is clear that we have a clear/direct route here for a NULL
> pointer dereference. This change makes cb a required parameter of the
> API.
>=20
> The first patch makes the necessary changes to the stm32_adfsdm driver
> so that it does not break.

Looks good to me.  Will leave it a bit longer to let ASOC people
take a quick look at it. Give me a poke in a few weeks if it seems
like I might have lost it!

Thanks,

Jonathan

>=20
> Nuno S=C3=A1 (1):
>   iio: buffer: Return error if no callback is given
>=20
> Olivier Moysan (1):
>   ASoC: stm32: dfsdm: add stm32_adfsdm_dummy_cb() callback
>=20
>  drivers/iio/buffer/industrialio-buffer-cb.c |  5 +++++
>  sound/soc/stm/stm32_adfsdm.c                | 12 +++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20

