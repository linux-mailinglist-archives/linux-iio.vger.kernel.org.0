Return-Path: <linux-iio+bounces-8367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15394D214
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C541C21411
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05236196C6C;
	Fri,  9 Aug 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4wv1fZw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF418E749;
	Fri,  9 Aug 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213444; cv=none; b=P8XRm+7NIJ15IlYbmMOdz2Ht3b7gJuTRm77Mo9AIcB512SawpgTVS2zRa07Qsuik0YtFTs7Vr66/OVSjQKAjujA/O0mHip42nnxR40OhCz8IgTOXtsGtFXNzANC9wnbc+tYVUhZZKoPH08fNcOc624E9X8mkbxSG31tpZJdwo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213444; c=relaxed/simple;
	bh=5gUwq91ATttiyIx/uKVwOYe7G/RxJzzFTf3pPEeo+sE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HImmSnsTT5/EhyrB+rDr7V19qDgOSeRKLhNoHmUA07fawUeBqsQrTxxI+OgZzRhWEeJAiP/sKouK105NE7pzfL+gk9DFtQ/T/BNt/cwfWrKaWfXiKUolF9Rh5udI+4NASmCxRP39+EmE8tokCHdBZdEh63C+qEpp9hSGpZ+y0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4wv1fZw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso14378135e9.1;
        Fri, 09 Aug 2024 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723213441; x=1723818241; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4/gs9u47DP8cQrqdlouSOUqjeqH+R2TIC2bViLmRcTc=;
        b=I4wv1fZwJuiRrnzb/AspLY1ojcC8q62X/dTSb3QwSchNoOvliqdQDin0AL1oxMMbWD
         qWXAHoU04NWJgv9ESyormDf8RTRgQQH+Z1V5ig+3dGrCTsxiaAZxPa3mticY+1VZEcIQ
         rgAgtGM5sCYaKeOkjehQKGIr+PWm9xGi5hmuNKMSRIsq8Ju2Xk+l2adhbP9ZQNo3Vi+L
         tUXw5i0kkex5dNKw9YVfA2HrZxmAJg9cbcmtISYBRUSF95jIuE6Wf3s/VywA3U7Ib6kk
         Ye636KuLka2XKNyy3Cu9OTzls67xIRvTJXVGUimbM+Dbx/rM7v5Ohjpz2mZMqkaEixYQ
         zwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213441; x=1723818241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/gs9u47DP8cQrqdlouSOUqjeqH+R2TIC2bViLmRcTc=;
        b=iOiviW03AmRqNcfKgVDD0XMwmW5FNsgwvD0m2jr8pvFP9Y2TM8EGKZlhkbYzFYjloI
         SvrMnHzAvGhZ0V7YLRQ8MJyxtcMgFC0A1O8qC3pmNYQDU76cVCp0+E2NC5V5ox4WSzj5
         Ko17s3QWYp22+b1swV0PpWNe0A8igupvmTrN5nmT+o4KeLmHBz4CKiNUhtQwvs0mpmbO
         RXekIcBl47cPLBLUsKCSuoIcpBL9K1V+Z5rjHG1OxWGhZK51pwFOfxG1i+n5VF3BdwfJ
         V5v//kYd9gmIQuLltmoH1mW1RFy+kvyN4LNWSSDGgFfI8zfDEz5Fvd6Ia7zdF/pVMsg5
         aiVg==
X-Forwarded-Encrypted: i=1; AJvYcCVROGMj6jMzmqFrGKQs5j8QH3Owtb7G6livYE3TRavcxsDWVnbWP5mVd3S0nC6hio/VN5fhTEt+PLK31syZchOMUVoE3ZD4SudJpbwoRXnGSsVaqLrGa5tyNfQyMKI21PbTDeOXpfRBscP0+k1N7PY19K5TZcUlU+aHx9yyjbyTbqOQ
X-Gm-Message-State: AOJu0Ywms7+Dnh/A2VAXN6b8Jf6cc8JnzITgUeZNlMVPFag4XlNrngeG
	r4uGjZBsHV0KdKXANCrC7SdI67bTteA74EnKO5e/8RJcgUIPX+sX
X-Google-Smtp-Source: AGHT+IGOJX0c6Nlhlkbs5OFc67iI7fWE3SO6nvfRWjJNZXO4pxljwRKUP2i+UFyp/XOW1IeZiEvK1A==
X-Received: by 2002:a5d:6c6e:0:b0:368:3b21:6643 with SMTP id ffacd0b85a97d-36d616e8ef2mr1569518f8f.48.1723213441045;
        Fri, 09 Aug 2024 07:24:01 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059713adsm130964315e9.11.2024.08.09.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:24:00 -0700 (PDT)
Message-ID: <8bb01a8946aaa5855b5ac15d79c0292a668eee59.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Fri, 09 Aug 2024 16:24:00 +0200
In-Reply-To: <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
References: 
	<20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
	 <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 15:02 -0500, David Lechner wrote:
> This implements buffered reads for the ad4695 driver using the typical
> triggered buffer implementation, including adding a soft timestamp
> channel.
>=20
> The chip has 4 different modes for doing conversions. The driver is
> using the advanced sequencer mode since that is the only mode that
> allows individual configuration of all aspects each channel (e.g.
> bipolar config currently and oversampling to be added in the future).
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Hi David,

Just two nit comments...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4695.c | 233 ++++++++++++++++++++++++++++++++++++=
++++++++++-
> =C2=A01 file changed, 230 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 007ecb951bc3..a3bd5be36134 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c

...

>=20
> =C2=A0
> +static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4695_state *st =3D iio_priv(indio_dev);
> +	struct spi_transfer *xfer;
> +	u8 temp_chan_bit =3D st->chip_info->num_voltage_inputs;
> +	bool temp_chan_en =3D false;
> +	u32 reg, mask, val, bit, num_xfer, num_slots;
> +	int ret;
> +
> +	/*
> +	 * We are using the advanced sequencer since it is the only way to read
> +	 * multiple channels that allows individual configuration of each
> +	 * voltage input channel. Slot 0 in the advanced sequencer is used to
> +	 * account for the gap between trigger polls - we don't read data from
> +	 * this slot. Each enabled voltage channel is assigned a slot starting
> +	 * with slot 1.
> +	 */
> +	num_slots =3D 1;
> +
> +	memset(st->buf_read_xfer, 0, sizeof(st->buf_read_xfer));
> +
> +	/* First xfer is only to trigger conversion of slot 1, so no rx. */
> +	xfer =3D &st->buf_read_xfer[0];
> +	xfer->cs_change =3D 1;
> +	xfer->delay.value =3D AD4695_T_CNVL_NS;
> +	xfer->delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +	xfer->cs_change_delay.value =3D AD4695_T_CONVERT_NS;
> +	xfer->cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +	num_xfer =3D 1;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		xfer =3D &st->buf_read_xfer[num_xfer];
> +		xfer->bits_per_word =3D 16;
> +		xfer->rx_buf =3D &st->buf[(num_xfer - 1) * 2];
> +		xfer->len =3D 2;
> +		xfer->cs_change =3D 1;
> +		xfer->cs_change_delay.value =3D AD4695_T_CONVERT_NS;
> +		xfer->cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +		if (bit =3D=3D temp_chan_bit) {
> +			temp_chan_en =3D true;
> +		} else {
> +			reg =3D AD4695_REG_AS_SLOT(num_slots);
> +			val =3D FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit);
> +
> +			ret =3D regmap_write(st->regmap, reg, val);
> +			if (ret)
> +				return ret;
> +
> +			num_slots++;
> +		}
> +
> +		num_xfer++;
> +	}
> +
> +	/*
> +	 * Don't keep CS asserted after last xfer. Also triggers conversion of
> +	 * slot 0.
> +	 */
> +	xfer->cs_change =3D 0;
> +
> +	/**
> +	 * The advanced sequencer requires that at least 2 slots are enabled.
> +	 * Since slot 0 is always used for other purposes, we need only 1
> +	 * enabled voltage channel to meet this requirement. This error will
> +	 * only happen if only the temperature channel is enabled.
> +	 */
> +	if (num_slots < 2) {
> +		dev_err_ratelimited(&indio_dev->dev,
> +			"Buffered read requires at least 1 voltage channel
> enabled\n");

This one is intriguing... Why the ratelimited variant? Normally you'd use t=
hat in IRQ
routines where the log could be flooded.
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Temperature channel isn't included in the sequence, but rather
> +	 * controlled by setting a bit in the TEMP_CTRL register.
> +	 */
> +
> +	reg =3D AD4695_REG_TEMP_CTRL;
> +	mask =3D AD4695_REG_TEMP_CTRL_TEMP_EN;
> +	val =3D FIELD_PREP(mask, temp_chan_en ? 1 : 0);
> +
> +	ret =3D regmap_update_bits(st->regmap, reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	spi_message_init_with_transfers(&st->buf_read_msg, st->buf_read_xfer,
> +					num_xfer);
> +
> +	ret =3D spi_optimize_message(st->spi, &st->buf_read_msg);
> +	if (ret)
> +		return ret;
> +
> +	/* This triggers conversion of slot 0. */
> +	ret =3D ad4695_enter_advanced_sequencer_mode(st, num_slots);
> +	if (ret) {
> +		spi_unoptimize_message(&st->buf_read_msg);
> +		return ret;
> +	}

Could save one line with (unless ad4695_enter_advanced_sequencer_mode() doe=
s not
return 0 on success)

ret =3D ad4695_enter_advanced_sequencer_mode(st, num_slots);
if (ret)
	spi_unoptimize_message(&st->buf_read_msg);

return ret;

- Nuno S=C3=A1


