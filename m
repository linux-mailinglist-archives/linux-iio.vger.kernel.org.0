Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0111DFF36
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 15:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEXNyl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 09:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEXNyl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 09:54:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CBD20776;
        Sun, 24 May 2020 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590328480;
        bh=lNY5bwD2IWRGQ8GGVNTkDd032tPyr6wbfzXC+8He9gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UsLMt05sTxkz3a8fEenO5DfnsQhZGB2VyQzFbvaOSCozSuoVa+oWAJeOOWyMR/C1i
         ffZA1kaCJhQHgSs+mLnh4McG7eeKc+0t65sp+noywP+ACpAo+vaFQZJbox74kBbfds
         be6DSlTNCbw1nSjWlQldmzLi2UKuEoSmD/jeRYf4=
Date:   Sun, 24 May 2020 14:54:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <lorenzo.bianconi83@gmail.com>, <songqiang1304521@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: at91-sama5d2_adc: remove
 predisable/postenable hooks
Message-ID: <20200524145436.41aaeea2@archlinux>
In-Reply-To: <20200522104632.517470-2-alexandru.ardelean@analog.com>
References: <20200522104632.517470-1-alexandru.ardelean@analog.com>
        <20200522104632.517470-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 13:46:31 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This should be squashed into the first patch, but it's the more peculiar =
of
> the changes.
> I am not sure whether this is correct. The touchscreen channels shouldn't
> be enabled by the IIO framework. So, we may need a different way to handle
> those if needed.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hmm. Unfortunately I can't remember exactly what is going on here.

=46rom a quick look my suspicion is we can handle this using the same
'is it a triggered buffer' test as you now have in the core code.

The touchscreen path operates as a non triggered buffer (I think...)

I'm definitely looking for an ack and preferably a tested-by for this
one.  You are right - it's non obvious!

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sa=
ma5d2_adc.c
> index 9abbbdcc7420..f71071096392 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -937,14 +937,6 @@ static int at91_adc_buffer_preenable(struct iio_dev =
*indio_dev)
>  	return 0;
>  }
> =20
> -static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
> -{
> -	if (at91_adc_current_chan_is_touch(indio_dev))
> -		return 0;
> -
> -	return iio_triggered_buffer_postenable(indio_dev);
> -}
> -
>  static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct at91_adc_state *st =3D iio_priv(indio_dev);
> @@ -995,19 +987,9 @@ static int at91_adc_buffer_postdisable(struct iio_de=
v *indio_dev)
>  	return 0;
>  }
> =20
> -static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> -{
> -	if (at91_adc_current_chan_is_touch(indio_dev))
> -		return 0;
> -
> -	return iio_triggered_buffer_predisable(indio_dev);
> -}
> -
>  static const struct iio_buffer_setup_ops at91_buffer_setup_ops =3D {
>  	.preenable =3D &at91_adc_buffer_preenable,
>  	.postdisable =3D &at91_adc_buffer_postdisable,
> -	.postenable =3D &at91_adc_buffer_postenable,
> -	.predisable =3D &at91_adc_buffer_predisable,
>  };
> =20
>  static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *ind=
io,

