Return-Path: <linux-iio+bounces-12885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D498F9DF2AF
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85404162CA8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91919CCEA;
	Sat, 30 Nov 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwAHP4Kh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21B17BD3
	for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732992837; cv=none; b=dkV3e68JLkqpzGNMZLwLTfTDflOV/r5hspD1dvO16QKIHH/UkrYA/n2SeE3KDbwgZDARLZULs7kiErQCqKVMJCfYBIRCuoukU/cx75TtxSPhOQqOkPLG1ym5cc/AWO8giM6EZ9xmfi9PBn3Lz8DFB66/H5fTS4Z5S0OGazNMz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732992837; c=relaxed/simple;
	bh=C9gQr/qrEmegparfJO7/rTF8Ib0zznPAnvuLJanjTPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHfn77HNDaWcjeJQqZDEzbiMaC0v/DflvcIf6LhnUBQQAWkqWX8RdAVt+oYnkUghHy0GfXvZq2zfaCCEmhy6cvA/GKgxAAE2FTSB4oJ5jSPb+fJehihEU+mdfC2djAg6ORO0KaTYYKbxvVpaeBZXsEdw3ucb3w4Tbjd+VL92rSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwAHP4Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E58FC4CECC;
	Sat, 30 Nov 2024 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732992836;
	bh=C9gQr/qrEmegparfJO7/rTF8Ib0zznPAnvuLJanjTPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BwAHP4Kh859z9kA6ulWkyrslsXVpp9U5JB1O0bR57qeOmErF1oGSw0wXddUmGJi16
	 w7IOBP1o5XOhBp+CD1aU9RXTlxtNIXPJcQMn/6Gjk2IXzHL8MrhIv35EULmmwqxdfM
	 700yNJpptdV1faYdXpBMZSvB1+l1N5+7cd8eEtqMGWGumMbTPhyAogSTQe6fxxza67
	 lv38VNhCVjL+qbL8tTM2z+RFcsr4mLdeLJr1UuUw0RcuhYIvdSgjKScYxOReI/zxZj
	 3+dnWq5dHz6DHxev9I9i2wEJqfOG5PK7Rd7kPcQyzSdL2Rq+pUX9o8H8tW6QS1Hte1
	 VP9SiIDwh4Bkg==
Date: Sat, 30 Nov 2024 18:53:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v4 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
Message-ID: <20241130185348.5f9d0306@jic23-huawei>
In-Reply-To: <20241127145929.679408-20-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
	<20241127145929.679408-20-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2024 15:59:37 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> It can happen if a previous conversion was aborted the ADC pulls down
> the =CC=85R=CC=85D=CC=85Y line but the event wasn't handled before. In th=
at case enabling
> the irq might immediately fire (depending on the irq controller's
> capabilities) and even with a rdy-gpio isn't identified as an unrelated
> one.
>=20
> To cure that problem check for a pending event before the measurement is
> started and clear it if needed.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Hi Uwe,

I think there is a DMA buffer safety issue hiding in the new code. Other th=
an
that this looks good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 89 ++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index 9891346c2d73..164a4d0b571d 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -29,8 +29,11 @@
>  #define AD_SD_COMM_CHAN_MASK	0x3
> =20
>  #define AD_SD_REG_COMM		0x00
> +#define AD_SD_REG_STATUS	0x00
>  #define AD_SD_REG_DATA		0x03
> =20
> +#define AD_SD_REG_STATUS_RDY	0x80
> +
>  /**
>   * ad_sd_set_comm() - Set communications register
>   *
> @@ -222,6 +225,80 @@ static void ad_sd_enable_irq(struct ad_sigma_delta *=
sigma_delta)
>  	enable_irq(sigma_delta->irq_line);
>  }
> =20
> +/* Called with `sigma_delta->bus_locked =3D=3D true` only.  */

Trivial but bonus space before */

> +static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sig=
ma_delta)
> +{
> +	bool pending_event;
> +	unsigned int data_read_len =3D BITS_TO_BYTES(sigma_delta->info->num_res=
etclks);
> +	u8 data[9];

SPI requires DMA safe buffers.  Either play games to get one in iio_priv via
__aligned(IIO_DMA_MINALIGN) or just kzalloc() this here.
Probably do that after the !pending_event check though so we only allocate
when there is a need for it.


> +	struct spi_transfer t[] =3D {
> +		{
> +			.tx_buf =3D data,
> +			.len =3D 1,
> +		}, {
> +			.tx_buf =3D data + 1,
> +			.len =3D data_read_len,
> +		}
> +	};
> +	struct spi_message m;
> +
> +	/*
> +	 * read RDY pin (if possible) or status register to check if there is an

* Read RDY...

> +	 * old event.
> +	 */
> +	if (sigma_delta->rdy_gpiod) {
> +		pending_event =3D gpiod_get_value(sigma_delta->rdy_gpiod);
> +	} else {
> +		int ret;
> +		unsigned status_reg;
> +
> +		ret =3D ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
> +		if (ret)
> +			return ret;
> +
> +		pending_event =3D !(status_reg & AD_SD_REG_STATUS_RDY);
> +	}
> +
> +	if (!pending_event)
> +		return 0;
> +
> +	/*
> +	 * In general the size of the data register is unknown. It varies from
> +	 * device to device, might be one byte longer if CONTROL.DATA_STATUS is
> +	 * set and even varies on some devices depending on which input is
> +	 * selected. So send one byte to start reading the data register and
> +	 * then just clock for some bytes with DIN (aka MOSI) high to not
> +	 * confuse the register access state machine after the data register was
> +	 * completely read. Note however that the sequence length must be
> +	 * shorter than the reset procedure.
> +	 */
> +
> +	/* Oh, back out instead of overflowing data[] */
> +	if (data_read_len > sizeof(data) - 1)
> +		return -EINVAL;
> +
> +	spi_message_init(&m);
> +	if (sigma_delta->info->has_registers) {
> +		unsigned int data_reg =3D sigma_delta->info->data_reg ?: AD_SD_REG_DAT=
A;
> +
> +		data[0] =3D data_reg << sigma_delta->info->addr_shift;
> +		data[0] |=3D sigma_delta->info->read_mask;
> +		data[0] |=3D sigma_delta->comm;
> +		spi_message_add_tail(&t[0], &m);
> +	}
> +
> +	/*
> +	 * The first transferred byte is part of the real data register,
> +	 * so this doesn't need to be 0xff. In the remaining
> +	 * `data_read_len - 1` bytes are less than $num_resetclks ones.
> +	 */
> +	data[1] =3D 0x00;
> +	memset(data + 2, 0xff, data_read_len - 1);
> +	spi_message_add_tail(&t[1], &m);
> +
> +	return spi_sync_locked(sigma_delta->spi, &m);
> +}
> +
>  int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  	unsigned int mode, unsigned int channel)
>  {
> @@ -237,6 +314,10 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_del=
ta,
>  	sigma_delta->keep_cs_asserted =3D true;
>  	reinit_completion(&sigma_delta->completion);
> =20
> +	ret =3D ad_sigma_delta_clear_pending_event(sigma_delta);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D ad_sigma_delta_set_mode(sigma_delta, mode);
>  	if (ret < 0)
>  		goto out;
> @@ -310,6 +391,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev =
*indio_dev,
>  	sigma_delta->keep_cs_asserted =3D true;
>  	reinit_completion(&sigma_delta->completion);
> =20
> +	ret =3D ad_sigma_delta_clear_pending_event(sigma_delta);
> +	if (ret)
> +		return ret;
> +
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
> =20
>  	ad_sd_enable_irq(sigma_delta);
> @@ -406,6 +491,10 @@ static int ad_sd_buffer_postenable(struct iio_dev *i=
ndio_dev)
>  	sigma_delta->bus_locked =3D true;
>  	sigma_delta->keep_cs_asserted =3D true;
> =20
> +	ret =3D ad_sigma_delta_clear_pending_event(sigma_delta);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_CONTINUOUS);
>  	if (ret)
>  		goto err_unlock;


