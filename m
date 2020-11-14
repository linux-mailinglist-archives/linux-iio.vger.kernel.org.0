Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3582D2B2E75
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNQd0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgKNQd0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:33:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A92C206E3;
        Sat, 14 Nov 2020 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605371605;
        bh=8XZ+gwz4DDUX/ar17KfoV72sTkYPWkC2L5cvmGMMZys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BjsNGJrrXnLMYPhDcFCgTJi1xwxRWtN6Sg8EMkQj7IUKrEd2KdvZqu6qayoYtob7B
         smpxfdY9LNsxUJib6X9uu7jsdeymCkXT7lBKni7N/v/0HIcFLniKvvHBk3BqPM/yyX
         fY9uoJqNWgxmnm/ydpOoKk1W+PhRO4G5iiyKYUXU=
Date:   Sat, 14 Nov 2020 16:33:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Olivier Moysan <olivier.moysan@st.com>
Subject: Re: [RFC PATCH 0/1] Sanity check buffer callback
Message-ID: <20201114163321.53881139@archlinux>
In-Reply-To: <20201112151334.32167-1-nuno.sa@analog.com>
References: <20201112151334.32167-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Nov 2020 16:13:33 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> When going through the code of the buffer-cb interface and all it's
> users, I realized that the stm32_adfsdm driver is calling
> `iio_channel_get_all_cb()` with NULL for the cb. After going a bit
> trough the stm drivers, it looks like this is actually intentional.
> However, it is clear that we have a clear/direct route here for a NULL
> pointer dereference. I'm being lazy in this RFC and just doing a
> sanity check in the `iio_buffer_cb_store_to()` so that we don't have to
> change the stm driver... The point is just to bring this up and see if
> we want to do something about this.
>=20
> To be clear, the way I think this should go is just to return -EINVAL in
> `iio_channel_get_all_cb()` if a NULL ptr is passed. Whats the point of a
> buffer-cb if cb is NULL, right? This would naturally break the stm
> driver, but I guess we could just define a dummy handler there that
> would not be used (or could the HW consumer be an option here?)...
>=20
> Thoughts?

Good description thanks.  I think you are right and better option is
to return -EINVAL in iio_channel_get_all_cb() and add a dummy  handler to t=
he
stm driver.

cc Arnaud and Olivier to see if they are fine with the dummy handler.
(with appropriate comment on why it is there).

Jonathan


>=20
> Nuno S=C3=A1 (1):
>   iio: buffer: Sanity check buffer callback
>=20
>  drivers/iio/buffer/industrialio-buffer-cb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20

