Return-Path: <linux-iio+bounces-18447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5FCA951E6
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F03AA10D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC2265CC4;
	Mon, 21 Apr 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc8/fYzP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E006258CEA;
	Mon, 21 Apr 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243289; cv=none; b=EfrCx6T2cVhPPfnM/Q5raBA7fl8A/Og8ZvTcqe5Zw/HDJu9hMCf7/3MQKkZ5Vh/NC4sTqpT8KG9DEW769q0BeEd9Azyc1TS8DOusr9tSxGplaJH9DItbyCC/urO9PVYjoQDPO9GcOWpvaRFi4NZPNZFGrFwEjiictGCMaTYLjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243289; c=relaxed/simple;
	bh=yLRrdLJmFkDMf9bgg6ZBLTFp0d4Ye3UdvGHqhA722R0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+hE8bzY+Rw5HzB4KzlgIuw9FeTDf8YYij39TTnTtEAfggqNi42Qr69WZfQapWv6+ewruFKWg/uARic7Kyih7rAkafsXvcEJTfWERVUthKFYW1cXYgDQUzzGOmDxKX5GdBR6joCpMvf/rInnURyotA1wDdsr8PG7QHH6cJHvXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc8/fYzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C48C4CEEA;
	Mon, 21 Apr 2025 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243288;
	bh=yLRrdLJmFkDMf9bgg6ZBLTFp0d4Ye3UdvGHqhA722R0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oc8/fYzPQYMmFl6u1wj716S7AB/dwDwPc4D9zPZyTLdUn6apDL9R3IdlBx+13Ez3l
	 4aVD/RF9N+PySyj8Rsm5il07iGMCWxWeitoXNd+EznFdV1i371V5lw4cZsiiDo4CMR
	 8NtwgfmxdkaF0vdbD34mnPF8Lcmw2z3h6b846SaoOrgwbQoiLu+PZTaZIBlbv05UTM
	 h0z/JDCLhjkFPPCdZaiEiQo34+q6qI3fiDokxufrW/nPinrJAJvAlgLsBOjraf8TlQ
	 lc9aPY65VEDUeHcAuDxVTxMqFzjG6YoxfROU/YKI0t9JJ3plvXsCfiJ7CtQWSs7cI1
	 hfOMBqutQh/kQ==
Date: Mon, 21 Apr 2025 14:48:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250421144800.0db0a84e@jic23-huawei>
In-Reply-To: <20250421-togreg-v5-3-94341574240f@analog.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
	<20250421-togreg-v5-3-94341574240f@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 12:24:54 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disabl=
ed
> by default.
>=20
> Support for monitoring internal die temperature, output voltages, and
> current of a selected channel via the MUXOUT pin using an external ADC
> is currently not implemented.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Hi.

Just one thing from a final pre merge look through.

The initialization of powerdown mode works but only because the NORMAL
mode =3D=3D 0.  That should be setting it explicitly for each set of 4 chan=
nels
as needed.

I don't really mind how you solve that.  There are lots of options
to build up the 4 fields in each of those registers.

Jonathan

> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..05bd191e5225bd267f42ba36b=
bd42a18e6f22291
> --- /dev/null
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -0,0 +1,503 @@

> +
> +static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	unsigned int mask, val, reg;
> +	bool powerdown;
> +
> +	ret =3D kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	mask =3D GENMASK(chan->address + 1, chan->address);

I think maybe we need a macro to get the mask from the channel number?
Using address for this seems overkill given how simple that maths is.
Ideally that macro could perhaps be used in the code below to avoid
all the defines I suggested.


> +	reg =3D chan->channel < AD3531R_MAX_CHANNELS ?
> +	      AD3530R_OUTPUT_OPERATING_MODE_0 :
> +	      AD3530R_OUTPUT_OPERATING_MODE_1;
> +	val =3D (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
> +	       << chan->address;
> +


> +static int ad3530r_setup(struct ad3530r_state *st, int vref,
> +			 bool has_external_vref)
> +{

> +
> +	if (has_external_vref)
> +		st->vref_mv =3D range_multiplier * vref / 1000;
> +
> +	/* Set operating mode to normal operation. */
> +	ret =3D regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0,
> +			   AD3530R_NORMAL_OPERATION);
Is this actually doing that?  I think the register is lots of 2 bit
fields and this is only setting it for the first channel?

This works because that value is 0.  Logically however we should set it
to
	(AD3530R_NORMAL_OPERATION << 6) |
	(AD3530R_NORMAL_OPERATION << 4) |
	(AD3530R_NORMAL_OPERATION << 2) |
	(AD3530R_NORMAL_OPERATION << 0)

Or possibly better as

	FIELD_PREP(AD3530R_OP_MODE_0_CHAN0_MSK, AD3530R_NORMAL_OPERATION) |
	FIELD_PREP(AD3530R_OP_MODE_0_CHAN1_MSK, AD3530R_NORMAL_OPERATION) |

etc

Names are a bit long, so maybe consider shortening some of the defines.

> +	if (ret)
> +		return ret;
> +
> +	if (st->chip_info->num_channels > AD3531R_MAX_CHANNELS) {

If we have it explicit that we have multiple fields this will become more o=
bvious.
However I'd use the number 4 here rather than the number of channels the AD=
3531R happens
to have.


> +		ret =3D regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
> +				   AD3530R_NORMAL_OPERATION);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < st->chip_info->num_channels; i++)
> +		st->chan[i].powerdown_mode =3D AD3530R_POWERDOWN_32K;
> +
> +	st->ldac_gpio =3D devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->ldac_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> +				     "Failed to get ldac GPIO\n");
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config ad3530r_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.max_register =3D AD3530R_MAX_REG_ADDR,
> +};

