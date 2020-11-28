Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733B32C7517
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgK1Vt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732535AbgK1TBy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:01:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A0B02466D;
        Sat, 28 Nov 2020 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606569957;
        bh=wlRpR5k7tSed5+Y/LjhaD1wUPthFRlO6ecBs7oG5hHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qyXpF6SpgPF8iY8EUePUJsiv1JNSdeUpCyxkFYYJaSNq+1jgC97oDUbtarg61kpV9
         pn9uaMgHeCKBgaBuW3oMi2acFODI2OPwuTtLsDYatF0Mfi2sIhHkyXvvI09HamRxO0
         85mMqV3o+xmJNp46PoYgcIwQ6zLmj61RUOz0I1pU=
Date:   Sat, 28 Nov 2020 13:25:51 +0000
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
Message-ID: <20201128132551.4006f293@archlinux>
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

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to do their magic.

Thanks,

Jonathan
