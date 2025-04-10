Return-Path: <linux-iio+bounces-17902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212ACA83ED9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA916B24C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3372139CE;
	Thu, 10 Apr 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPT1AgmA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DC25E443;
	Thu, 10 Apr 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277548; cv=none; b=k+gZhEbqxjVUt+xglw5KcdlTfO6ibfqRzC2XGGoL79CJzIynrno88av4ryk3Atmg66VYPokuTxAlIbyB7MT/Wyh2BqqFWHqAt6usrPOHve/+f769R5iFX5fKyDmBOK4eVB/fGy5fw2+dOfS2ZDClrjTJrORCXzzHTqfSp0YMxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277548; c=relaxed/simple;
	bh=os4cguKVh1Oct6Ub0aHpfctYCPRy4BegCSUmmM+PPbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIpEScaMLppiOGmki+RtReq6LWKwdtxTjucIZkey6w4nA5z+T73S9VmRIzrgbJznB83OBaAwJHKRrUtoJqUoNKaoMiQfFBwHHPFE6onIGYHYzazqlcPEo2dygPAikBjObP3CSkPZeVUajsocKUCq2jkB6vy1D+GUHEBpdhffJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPT1AgmA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so4782305e9.2;
        Thu, 10 Apr 2025 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744277545; x=1744882345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3C5nE7Ftn1H9yK4P4EbcyIlbTUkDNNYHeRQLrqsrkI=;
        b=NPT1AgmAgiK7FSUPZGsdPpC+VTqbugho8xQQHVDQQFOEdxZuEIwGkrdzfwHK79YK3t
         Dv7AaaL4pDLozeX2vrPwvVBBi//Vynk+gwY/lap7zt8vZLyiZ745qX2Z07Tm3rL0j94p
         wzHJT4BfsPvqDJt91MHbQAoNPCE/Q4IEa4EeplwuWe4gCPFwJsEJpkyT2Om8Deh3nXmV
         4n4xnDawevRE21NtAw6wenuBl5FunR/zwTqzFbEBlOjlbZEx3j+P9mKifv/4lDAGZ53X
         U34cfn3Nnfm+QpUPqZb/AIPYEj5/0QhjXuLcs2dP1nR83q91+ddBjzxA1wrYkxH7jV5n
         MXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744277545; x=1744882345;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3C5nE7Ftn1H9yK4P4EbcyIlbTUkDNNYHeRQLrqsrkI=;
        b=mEg3NTMu3N2P5WCvd9KX03SrAg3IVQq3wLZXK3ZjLQ7JUB93Q9cwnj0NdCbiZSBX8R
         gEavLm9ZUXp+4V/djhedpAWQUXCImmu7nB/S7vcN/6DR8OfAS3G1ZCIZJWWjjZDKiFy1
         ibGeYYpNuFjEd/hhpvnNhRcYylp8VxEFHNOq94HW3eIUKhT9MgPuxyUBZIjgOyracjkX
         DUs42ABLfyvNPjYkPzFRBKsGb2yPQCLPWHANeAuU5mTNfGU3Us2qF5mRGkSWwIvS7BEg
         KdYlOVbtqvWx5r+piNzfHzwxm1avxwiCyXbpGgUHkUaC1LB9x9FF/d806cebUzEnojDN
         qYDg==
X-Forwarded-Encrypted: i=1; AJvYcCVcWHRfaRXaGc2Inis0qrdKKQZSCv7rlxjt3zTZtwNgZiMVq1VXlQDTjpiSYD+YIcm+skZVczC+2Ed3sp/o@vger.kernel.org, AJvYcCWr5pjP0D9FgjeNSjop3UYSx+YKDGwuCCuFQzanxv1oeLhDK9DyPqWyK4G4v0g0jEgSUgiBvUYZtyNA@vger.kernel.org, AJvYcCXztttabu9NyqTnctBvq6aXlxcpHQbjpKeG330CdVx0CoWEoyiwp6bMopP9oxu3xRWWyOn2LEdbz91T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6zowoqdPuAjQP8frmALodXsOVmle+X7p4jMPwxcdPMs9ghha
	IDAEym1bscEEVhQ9iYjnJahS+DV1WKfePvf3VuxSRY6bHO3EhacP
X-Gm-Gg: ASbGncvXoW0xojWCMYdg9ujlZFuGNCeZCvMCCGf/7d2xdvgKphyyiWa2Fzvto+qIn0a
	V8tErMaC78F9vkP90WX1N0Iio+dHrrYE3XwSDIzeTMT3Gh1P30XtXYTPem/p3E1/8h9Q5/5LrKW
	ZxnOXkKnRmIq8qaATn9fS258Ac/8qJhZaRWSdkrkWmy+xvceBSw3NX0EkzLfleUChb/eTB4RUr9
	/altX6rS7yLXQ1SYQjzONBCpzsykpH2MNatL2mDBjUYmpHKUqfWxdoRAh9fqWoCqbeVqrvdYY3e
	NPwLVfKN1JnO1n69m6nrRvLrGj9w+6lSevWKYh8Ihuppwt855C7PyO241hJBtzgzxDU8MbcoDfh
	Fdp/Rc13PiajfLUxztELJJig=
X-Google-Smtp-Source: AGHT+IH4c4MWf/sPxYpPiw+WwnaPJOb3FLxH0mhYi19QWJtVBS0UhVkSwWFP5SMVVouAu3MSaHmEZg==
X-Received: by 2002:a05:600c:384b:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43f2ff99e51mr12050605e9.20.1744277544448;
        Thu, 10 Apr 2025 02:32:24 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdfcesm4111485f8f.87.2025.04.10.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:32:24 -0700 (PDT)
Message-ID: <e260e47064955085cb18124e9d0f18af8ac04b00.camel@gmail.com>
Subject: Re: [PATCH v1 3/7] iio: adc: ad4170: Add support for buffered data
 capture
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
Date: Thu, 10 Apr 2025 10:32:24 +0100
In-Reply-To: <5f6d44ad4a4a5df088d91aa386229073f5364406.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	 <5f6d44ad4a4a5df088d91aa386229073f5364406.1744200264.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 09:25 -0300, Marcelo Schmitt wrote:
> Extend the AD4170 driver to allow buffered data capture in continuous rea=
d
> mode. In continuous read mode, the chip skips the instruction phase and
> outputs just ADC sample data, enabling faster sample rates to be reached.
> The internal channel sequencer always starts sampling from channel 0 and
> channel 0 must be enabled if more than one channel is selected for data
> capture. The scan mask validation callback checks the aforementioned
> condition is met.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad4170.c | 170 ++++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 169 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 0d24286ac2ab..5ffcdedf3e7f 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -10,10 +10,12 @@
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> +#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> =C2=A0#include <linux/iio/trigger.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/irq.h>
> =C2=A0#include <linux/kernel.h>
> @@ -323,6 +325,16 @@ struct ad4170_state {
> =C2=A0	int
> sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> =C2=A0	struct completion completion;
> =C2=A0	struct iio_trigger *trig;
> +
> +	struct spi_transfer xfer;
> +	struct spi_message msg;
> +	__be32 bounce_buffer[AD4170_MAX_CHANNELS];
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer
> buffers
> +	 * to live in their own cache lines.
> +	 */
> +	__be32 rx_buf __aligned(IIO_DMA_MINALIGN);
> +	u8 tx_buf[2];
> =C2=A0};
> =C2=A0
> =C2=A0static void ad4170_fill_sps_tbl(struct ad4170_state *st)
> @@ -882,6 +894,7 @@ static const struct iio_chan_spec ad4170_channel_temp=
late
> =3D {
> =C2=A0	.scan_type =3D {
> =C2=A0		.realbits =3D 24,
> =C2=A0		.storagebits =3D 32,
> +		.shift =3D 8,
> =C2=A0		.endianness =3D IIO_BE,
> =C2=A0	},
> =C2=A0};
> @@ -1480,11 +1493,29 @@ static int ad4170_write_raw_get_fmt(struct iio_de=
v
> *indio_dev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int ad4170_update_scan_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 const unsigned long *active_scan_mask)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	unsigned int chan_index;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +

Do we need this? In theory we should be fine since you do
iio_device_claim_direct() in ad4170_read_sample().

Otherwise I would expect the same locking rules in postenable() and
predisable().

> +	iio_for_each_active_channel(indio_dev, chan_index) {
> +		ret =3D ad4170_set_channel_enable(st, chan_index, true);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> =C2=A0static const struct iio_info ad4170_info =3D {
> =C2=A0	.read_raw =3D ad4170_read_raw,
> =C2=A0	.read_avail =3D ad4170_read_avail,
> =C2=A0	.write_raw =3D ad4170_write_raw,
> =C2=A0	.write_raw_get_fmt =3D ad4170_write_raw_get_fmt,
> +	.update_scan_mode =3D ad4170_update_scan_mode,
> =C2=A0	.debugfs_reg_access =3D ad4170_debugfs_reg_access,
> =C2=A0};
> =C2=A0
> @@ -1759,6 +1790,130 @@ static int ad4170_initial_config(struct iio_dev
> *indio_dev)
> =C2=A0				 AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK);
> =C2=A0}
> =C2=A0
> +static int ad4170_prepare_spi_message(struct ad4170_state *st)
> +{
> +	/*
> +	 * Continuous data register read is enabled on buffer postenable so
> +	 * no instruction phase is needed meaning we don't need to send the
> +	 * register address to read data. Transfer only needs the read
> buffer.
> +	 */
> +	st->xfer.rx_buf =3D &st->rx_buf;
> +	st->xfer.len =3D
> BITS_TO_BYTES(ad4170_channel_template.scan_type.realbits);
> +
> +	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
> +
> +	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->msg);
> +}
> +
> +static int ad4170_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_CONT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Enables continuous data register read.
> +	 * This enables continuous read of the ADC Data register. The ADC
> must
> +	 * be in a continuous conversion mode.
> +	 */
> +	return regmap_update_bits(st->regmap16, AD4170_ADC_CTRL_REG,
> +				=C2=A0 AD4170_ADC_CTRL_CONT_READ_MSK,
> +				=C2=A0 FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
> +					=C2=A0=C2=A0=C2=A0=C2=A0
> AD4170_ADC_CTRL_CONT_READ_ENABLE));
> +}
> +
> +static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret, i;
> +
> +	/*
> +	 * To exit continuous read, write 0xA5 to the ADC during the first 8
> +	 * SCLKs of the ADC data read.
> +	 */
> +	st->tx_buf[0] =3D AD4170_ADC_CTRL_CONT_READ_EXIT;
> +	st->tx_buf[1] =3D 0;
> +	ret =3D spi_write(st->spi, st->tx_buf, 2);
> +	if (ret)
> +		return ret;

Couldn't we still use regmap? Like=C2=A0
regmap_write(st->regmap8, AD4170_ADC_CTRL_CONT_READ_EXIT, 0)?

Likely fails on the register ranges and not sure it's any better... Still n=
ot a
fan of mixing "raw" bus read/writes and regmap().

> +
> +	ret =3D regmap_update_bits(st->regmap16, AD4170_ADC_CTRL_REG,
> +				 AD4170_ADC_CTRL_CONT_READ_MSK,
> +				 FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
> +					=C2=A0=C2=A0=C2=A0
> AD4170_ADC_CTRL_CONT_READ_DISABLE));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D=C2=A0 ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The ADC sequences through all the enabled channels (see datasheet
> +	 * page 95). That can lead to incorrect channel being read if a
> +	 * single-shot read (or buffered read with different
> active_scan_mask)
> +	 * is done after buffer disable. Disable all channels so only
> requested
> +	 * channels will be read.
> +	 */
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		ret =3D ad4170_set_channel_enable(st, i, false);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;
> +}
> +
> +static bool ad4170_validate_scan_mask(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask)
> +{
> +	unsigned int masklength =3D iio_get_masklength(indio_dev);
> +	unsigned long first, next;
> +
> +	/*
> +	 * The channel sequencer cycles through the enabled channels in
> +	 * sequential order, from channel 0 to channel 15, bypassing disabled
> +	 * channels. When more than one channel is enabled, channel 0 must
> +	 * always be enabled. See datasheet channel_en register description
> at
> +	 * page 95.
> +	 */
> +	first =3D find_next_bit(scan_mask, masklength, 0);
> +	next =3D find_next_bit(scan_mask, masklength, first + 1);
> +	if (next < masklength)
> +		return test_bit(0, scan_mask);

Hmm, maybe this is simpler?

	if (bitmap_weight(scan_mask, masklength) > 1)
		return test_bit(0, scan_mask);
=09
	return true;


- Nuno S=C3=A1

