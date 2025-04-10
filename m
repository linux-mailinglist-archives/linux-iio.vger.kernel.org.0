Return-Path: <linux-iio+bounces-17904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E55E5A83F14
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24F17AA99A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A9267385;
	Thu, 10 Apr 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlgPEVPI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C525E81E;
	Thu, 10 Apr 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278019; cv=none; b=YpQoNE3HfgtKGzYyMuWCNIayc3R+eC7SZ64tHU+WTk1sdZkQljztKKF3R/H5MQqzVJZdxiFdl5cHVarNSwfTS3KVwvSEbTad3FnaX/tzXC0lAewlxYQWY5JXcfakJjQQpfgaQoBbIBNoqwIaKkIwGn4Ma3SCvk5UVrWFsgHQRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278019; c=relaxed/simple;
	bh=CbYtk44myoD5BZVO0UzRr8Ax21je9fKshpjG1nkT0jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+g9aTx3VLrwkc5lvu8uGt94/OpnbSjz24oTIv33GOcIpOPbrzli+OpjBS+4JAll2h6YeYzFgrwOphWxNbO3UqS8GtVN/0rLbtaO4VeVRyE5dRklBe6s1DObeQn9n8E7br6+qDb/c/pvCKoEsrLX0kBkF1dzRcYUx1QL+3NHfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlgPEVPI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39bf44be22fso291794f8f.0;
        Thu, 10 Apr 2025 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278015; x=1744882815; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ZzHK+u3IhtNYeAtrRxJUvgO65HY7/Y2Xaxu6J22s48=;
        b=PlgPEVPIkIBCvlejBEMPh2ZNQ3JkORWQnA9prX6FrdrMxujJ9IH31SldUdbZJ1X8iq
         cXq4NIYRFzQuaP7+7ifkEVGoAoipk9s5P5uQn570TMpbCymHL5iEFVl6rrjnClk49QGi
         LFZ6jhhipjnk8CwO61SvvgfidWIsUxJVWaiWJL1tAox0iSs5GGilfQef4ZHgACWsL6lj
         mpwRr3i7+I6HAIDJtr3ItEDsbW0uNRQ4FGELBkDK1lR2lybdnSYuCVYsKM/myKCYP5FL
         a03dtRK91idJ/t4nJRkcPCJZN08lKn2qX1OhBrjzgsQoW9gyMsrUuqeTyGCzJPBHEYtp
         2ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278015; x=1744882815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZzHK+u3IhtNYeAtrRxJUvgO65HY7/Y2Xaxu6J22s48=;
        b=Cf4cdNIjnNgUR05mou0NPDx9LZK6jEgAWF0tYC2bcOB57QOLYtd2nQZtvpshXJWUdl
         dgdUADcAaZ2f+wZJmFmnIYlGPYKjsTMrKX6b/LYqV8cNBigiLqAFT0DgWwp7jDi5CBJq
         0Yv3j7jD2IISEclm3hnQo3GUiZBdSgx1ZXV0t4kuWy2SWId+mAbhSGUIy/tNq2h0TqcM
         yxfcCrBa0+0ZgPbOG4XQXTeYfiuqdnbj/8lhpPnplWVz1/gFqt8f62EXDyQMJuUxuSnR
         Z4qYYCMze1RsZfHiB5Knx9CeLgCfKHDC8+QqlQsry0dQFT3JQT94046bL46GiaNKwlms
         HkTg==
X-Forwarded-Encrypted: i=1; AJvYcCWI9m8tG1R/vLT1E5iWsvA0et0B0ZD68LXbLtwn48Lt5jUap68vZpQKC1rbbJFgfbv15xIEa0r+7muc@vger.kernel.org, AJvYcCX26Cz6Alcsx0OZqhstxkxkKsFCLGWCPsFut1Zswr0i6jq3nqatL21A1ryYOKZQ5uxiOHWPDGO5U5NB@vger.kernel.org, AJvYcCX5IzhMUjlK/P3pHoOJzgrWefbcjSuVVANrqTKhXOXqcMo8Wg+++dFn8Lz3b85x3WXEeeoSv9SGOoanvBjL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0M5EdKVzcr1T1P+PPzyRWz8Y6pyCfMtKd1yi/vPsvRYFosuUq
	4BpGlRHD5z3gfQ4duolRUV5LYvEERb/P2juM5vTjQIPpCnKKbnQL
X-Gm-Gg: ASbGncvwK+YTpOPTpZY6pTZR2/FwTIY+xB0B5pDm2ExYntJuew+7RQMYqk1/JWjEs0R
	PVEZLDF92JBBuSMdJhhtL0142YAPFG7XlQMyVhJFca3afxzE1PyZ7+u+CxweMpq9Qs5YEMFgvWM
	f7qQAxCkZ/p+qrUmdAXEgwAYKBEFn7fvuCH8czf0NTRrMylNtdgGQQ5beqE9KavZlKzyuAIqkZ8
	ng92TXkm5XQw846zzpZ8EwSXJNFsaLD2M+4DDS3VhiriLJZ4F+6jzD/Fak6LwL9GI/o96z2uofi
	ppAEUkug4GO9AR/kA3RG0b1BJb43I7S7hiFrwfcW5TuoHbrEef+xNNE3sXMzgH3vCE/LSQOmH3f
	HH7lNwgdVDzuH
X-Google-Smtp-Source: AGHT+IHo+l30usT0vi5GeqmBPEKKMjK/tSE3z/8K18JGQBbnkLhIaa5/jdg4FvLoCv/QnMnDJltr1g==
X-Received: by 2002:a05:6000:4021:b0:39a:ca0c:fc90 with SMTP id ffacd0b85a97d-39d8f469697mr1840680f8f.14.1744278015282;
        Thu, 10 Apr 2025 02:40:15 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8224sm44508825e9.22.2025.04.10.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:40:14 -0700 (PDT)
Message-ID: <4ef3b2464691d65a295d0f5669e27f8a5382ea06.camel@gmail.com>
Subject: Re: [PATCH v1 4/7] iio: adc: ad4170: Add clock provider support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
Date: Thu, 10 Apr 2025 10:40:16 +0100
In-Reply-To: <65b71e307d37b8e3e26937a1e67398b2af0af399.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	 <65b71e307d37b8e3e26937a1e67398b2af0af399.1744200264.git.marcelo.schmitt@analog.com>
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
> The AD4170 chip can use an externally supplied clock at the XTAL2 pin, or
> an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
> the AD4170 can provide it's 16 MHz internal clock at the XTAL2 pin. Exten=
d
> the AD4170 driver so it effectively uses the provided external clock, if
> any, or supplies it's own clock as a clock provider.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Just one minor note, with it:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4170.c | 135 ++++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 134 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 5ffcdedf3e7f..97cf4465038f 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -7,6 +7,8 @@
> =C2=A0
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> @@ -62,6 +64,7 @@
> =C2=A0#define AD4170_DATA_16B_STATUS_REG			0x1A
> =C2=A0#define AD4170_DATA_24B_REG				0x1E
> =C2=A0#define AD4170_PIN_MUXING_REG				0x69
> +#define AD4170_CLOCK_CTRL_REG				0x6B
> =C2=A0#define AD4170_ADC_CTRL_REG				0x71
> =C2=A0#define AD4170_CHAN_EN_REG				0x79
> =C2=A0#define AD4170_CHAN_SETUP_REG(x)			(0x81 + 4 * (x))
> @@ -89,6 +92,9 @@
> =C2=A0#define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
> =C2=A0#define AD4170_PIN_MUXING_SYNC_CTRL_MSK			GENMASK(3, 2)
> =C2=A0
> +/* AD4170_CLOCK_CTRL_REG */
> +#define AD4170_CLOCK_CTRL_CLOCKSEL_MSK			GENMASK(1, 0)
> +
> =C2=A0/* AD4170_ADC_CTRL_REG */
> =C2=A0#define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
> =C2=A0#define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
> @@ -121,6 +127,12 @@
> =C2=A0
> =C2=A0/* AD4170 register constants */
> =C2=A0
> +/* AD4170_CLOCK_CTRL_REG constants */
> +#define AD4170_CLOCK_CTRL_CLOCKSEL_INT			0x0
> +#define AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT		0x1
> +#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT			0x2
> +#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT_XTAL		0x3
> +
> =C2=A0/* AD4170_CHAN_MAP_REG constants */
> =C2=A0#define AD4170_CHAN_MAP_AIN0			0
> =C2=A0#define AD4170_CHAN_MAP_AIN1			1
> @@ -238,6 +250,10 @@ enum ad4170_regulator {
> =C2=A0	AD4170_MAX_SUP
> =C2=A0};
> =C2=A0
> +static const char *const ad4170_clk_sel[] =3D {
> +	"ext-clk", "xtal"
> +};
> +
> =C2=A0enum ad4170_int_pin_sel {
> =C2=A0	AD4170_INT_PIN_SDO,
> =C2=A0	AD4170_INT_PIN_DIG_AUX1,
> @@ -320,6 +336,9 @@ struct ad4170_state {
> =C2=A0	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
> =C2=A0	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
> =C2=A0	u32 mclk_hz;
> +	unsigned int clock_ctrl;
> +	struct clk *ext_clk;
> +	struct clk_hw int_clk_hw;
> =C2=A0	int pins_fn[AD4170_NUM_ANALOG_PINS];
> =C2=A0	u32 int_pin_sel;
> =C2=A0	int
> sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> @@ -1693,13 +1712,127 @@ static int ad4170_parse_channels(struct iio_dev
> *indio_dev)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static struct ad4170_state *clk_hw_to_ad4170(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ad4170_state, int_clk_hw);
> +}
> +
> +static unsigned long ad4170_sel_clk(struct ad4170_state *st,
> +				=C2=A0=C2=A0=C2=A0 unsigned int clk_sel)
> +{
> +	st->clock_ctrl &=3D ~AD4170_CLOCK_CTRL_CLOCKSEL_MSK;
> +	st->clock_ctrl |=3D FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
> clk_sel);
> +	return regmap_write(st->regmap16, AD4170_CLOCK_CTRL_REG, st-
> >clock_ctrl);
> +}
> +
> +static unsigned long ad4170_clk_recalc_rate(struct clk_hw *hw,
> +					=C2=A0=C2=A0=C2=A0 unsigned long parent_rate)
> +{
> +	return AD4170_INT_CLOCK_16MHZ;
> +}
> +
> +static int ad4170_clk_output_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad4170_state *st =3D clk_hw_to_ad4170(hw);
> +	u32 clk_sel;
> +
> +	clk_sel =3D FIELD_GET(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, st->clock_ctrl);
> +	return clk_sel =3D=3D AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT;
> +}
> +
> +static int ad4170_clk_output_prepare(struct clk_hw *hw)
> +{
> +	struct ad4170_state *st =3D clk_hw_to_ad4170(hw);
> +
> +	return ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);
> +}
> +
> +static void ad4170_clk_output_unprepare(struct clk_hw *hw)
> +{
> +	struct ad4170_state *st =3D clk_hw_to_ad4170(hw);
> +
> +	ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT);
> +}
> +
> +static const struct clk_ops ad4170_int_clk_ops =3D {
> +	.recalc_rate =3D ad4170_clk_recalc_rate,
> +	.is_enabled =3D ad4170_clk_output_is_enabled,
> +	.prepare =3D ad4170_clk_output_prepare,
> +	.unprepare =3D ad4170_clk_output_unprepare,
> +};
> +
> +static int ad4170_register_clk_provider(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D indio_dev->dev.parent;
> +	struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> +	struct clk_init_data init =3D {};
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +		return 0;
> +
> +	init.name =3D fwnode_get_name(fwnode);

Maybe allow for clock-output-names? See:

https://elixir.bootlin.com/linux/v6.13.7/source/drivers/iio/frequency/adf43=
50.c#L467

- Nuno S=C3=A1


