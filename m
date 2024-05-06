Return-Path: <linux-iio+bounces-4833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42C8BCA18
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945D428114F
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53DF1420CC;
	Mon,  6 May 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhMVi4D/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6451D547;
	Mon,  6 May 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985751; cv=none; b=lakcDxM8EKk6xnLlIabUO7x8FkcNt0/pdSi/aEECOw1tRA/WNBse1IwLVlBKHOoULcANXKaGyldyUeRtqVNDrlcNZuTDV9yxduWi5fvMVogC5fqE73nBWrLY1OjTU+/97q8NMOK3Bfy4Z2tQEo0/Xq0WK4qLDYSQG3YvMtWPUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985751; c=relaxed/simple;
	bh=5BwyfntIK3lpoAl+NsPCM7E7RseaI28ODsfEelkHXFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EcWrdgfJOQ7xazinpOL/EXMFdBMswl9OHqGx2mjKHZ46O8Ed78R7PvEcurirhg2U2Hj9r8L3P3KwT80TocMhk4l4UuHGJobzUOr2eidPWmTPCwvFDpt8giXX9EEjh4d/c/THi87h/SmH+RAZQNQUTeIYyLSLAhgW+NVtIJW+FWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhMVi4D/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59cf8140d0so117029066b.3;
        Mon, 06 May 2024 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714985748; x=1715590548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wXrD55m3s5MvBqCwfZ7rBXZbb2rlAbVmpwur6DlLdaQ=;
        b=QhMVi4D/nobb+LG+FH1BdfQIXgAnoeausarOUNB+wee3KnptmxOPXpQT7nnh45OWH7
         RUyCi+ewbvTw0OyTfR5XKGese/ZdLNBri/QlfBOqJMuBETaNGcwmq3feJ6SXarFydkGF
         X+ziqKa9HzXq9KrYNof+iQW+spEQF4Sh9di6jhDajivoFO5xuCG8p5DozbScats7olQ5
         EMJ+fXmcxH0I8V7b9kSXFGjhvuF0lJQt33/+lqIHPi27AZYqoVc5VP1avWkujqy4O1Ty
         58yXRh+Squ+H4dF6ha8Unap/3CCNecoInXElfZQhuLMXDVekMfe6zKJY2/RJVmlvQArs
         xAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714985748; x=1715590548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXrD55m3s5MvBqCwfZ7rBXZbb2rlAbVmpwur6DlLdaQ=;
        b=Wtz0YFzgQVRvU1dv/V2YdJkjVV2PNjMbQC/bYh6Jduo0U+cfwt5DpvdZrfZU3imF/T
         EJZxjFToopPH7LVL+9gbdm8YIJM9IfYNMcIpoBDnNr0cgudvc+rN8UqqUHwf6r/ISel5
         UQLSD0v3sQ7v5Fg9VO5Kp8k3LHl67bRVWJHBLSL71zIOaggr59vuuQ7uZMU4xYAzoQ14
         uI4IOkzt0IUot0qiZzMfyyRt0eBwBk0hgHjC286i+QDhhjzNdZWEQO3lIVpC72hD0CO7
         UymFFgMtcM9eqkuDy1d2/w0bpJtccS0Y8et5tn7YHmqgfN8Kk8fUIYzaRcac/6aLGxA5
         NpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUgP+RO2LY9b4brgBqSq/mVpXDIswHDdtxinRw/M2vugyMFXepkPBiy6BSXoytmATxLbQE71TdQOOQB3fPCM1EBWkExZ5wa33dHO4t0A2HB/TQ6rZ5vkLKs10uTuxMkeClgOhehmjz39O37MIocRSYaftvGOoOPXlUv5FH8OjwuIhrDA==
X-Gm-Message-State: AOJu0YxIh/Dt4PGiHFGOhF6+oIAssEeLwVKtL1FTbB77OmDl5xXFkW2S
	Zq49SSQCv5JN5BE+/1MQe4GNZLzbx8BlTLc0bptOEhXKk7gjpX+W
X-Google-Smtp-Source: AGHT+IGcDCJFukxPe0iK9yuKiPeGVmJODZlRFBrKR1PwrDsZnyhRYNWFk22A1mJ3lxZ4YJzLDBci6g==
X-Received: by 2002:a17:906:6a1a:b0:a59:ce90:27ea with SMTP id qw26-20020a1709066a1a00b00a59ce9027eamr1460119ejc.24.1714985747846;
        Mon, 06 May 2024 01:55:47 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906841200b00a59a8a5dd15sm2756828ejx.206.2024.05.06.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 01:55:47 -0700 (PDT)
Message-ID: <a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com>
Subject: Re: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for
 resolution boost
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 May 2024 10:55:46 +0200
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
References: 
	<20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	 <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote:
> ad738x chips are able to use an additional 2 bits of resolution when
> using oversampling. The 14-bits chips can have up to 16 bits of
> resolution and the 16-bits chips can have up to 18 bits of resolution.
>=20
> In order to dynamically allow to enable/disable the resolution boost
> feature, we have to set iio realbits/storagebits to the maximum per chips=
.
> This means that for iio, data will always be on the higher resolution
> available, and to cope with that we adjust the iio scale and iio offset
> depending on the resolution boost status.
>=20
> The available scales can be displayed using the regular _scale_available
> attributes and can be set by writing the regular _scale attribute.
> The available scales depend on the oversampling status.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>=20
> ---
>=20
> In order to support the resolution boost (additional 2 bits of resolution=
)
> we need to set realbits/storagebits to the maximum value i.e :
> =C2=A0 - realbits =3D 16 + 2 =3D 18, and storagebits =3D 32 for 16-bits c=
hips
> =C2=A0 - realbits =3D 14 + 2 =3D 16, and storagebits =3D 16 for 14-bits c=
hips
>=20
> For 14-bits chips this does not have a major impact, but this
> has the drawback of forcing 16-bits chip users to always use 32-bits
> words in buffers even if they are not using oversampling and resolution
> boost. Is there a better way of implementing this? For example
> implementing dynamic scan_type?
>=20

Yeah, I don't think it's that bad in this case. But maybe dynamic scan type=
s is
something we may need at some point yes (or IOW that I would like to see su=
pported
:)). We do some ADCs (eg: ad4630) where we use questionably use FW properti=
es to set
a specific operating mode exactly because we have a different data layout (=
scan
elements) depending on the mode.
=20
> Another issue is the location of the timestamps. I understood the need
> for ts to be consistent between chips, but right now I do not have a
> better solution.. I was thinking of maybe adding the timestamps at the
> beginning? That would imply to change the iio_chan_spec struct and maybe
> add a iio_push_to_buffers_with_timestamp_first() wrapper function? Is
> that an option?
>=20
> Any suggestion would be very much appreciated.
> ---
> =C2=A0drivers/iio/adc/ad7380.c | 226 ++++++++++++++++++++++++++++++++++++=
++++-------
> =C2=A01 file changed, 194 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 7b021bb9cf87..e240098708e9 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -20,6 +20,7 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/units.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/slab.h>
> @@ -58,6 +59,8 @@
> =C2=A0#define AD7380_CONFIG1_CRC_R		BIT(4)
> =C2=A0#define AD7380_CONFIG1_ALERTEN		BIT(3)
> =C2=A0#define AD7380_CONFIG1_RES		BIT(2)
> +#define RESOLUTION_BOOST_DISABLE	0
> +#define RESOLUTION_BOOST_ENABLE		1

No ad7390 prefix?

> =C2=A0#define AD7380_CONFIG1_REFSEL		BIT(1)
> =C2=A0#define AD7380_CONFIG1_PMODE		BIT(0)
> =C2=A0
> @@ -86,6 +89,14 @@ struct ad7380_chip_info {
> =C2=A0	const struct ad7380_timing_specs *timing_specs;
> =C2=A0};
> =C2=A0
> +/*
> + * realbits/storagebits cannot be dynamically changed, so in order to
> + * support the resolution boost (additional 2=C2=A0 bits of resolution)
> + * we need to set realbits/storagebits to the maximum value i.e :
> + *=C2=A0=C2=A0 - realbits =3D 16 + 2 =3D 18, and storagebits =3D 32 for =
16-bits chips
> + *=C2=A0=C2=A0 - realbits =3D 14 + 2 =3D 16, and storagebits =3D 16 for =
14-bits chips
> + * We need to adjust the scale depending on resolution boost status
> + */
> =C2=A0#define AD7380_CHANNEL(index, bits, diff) {			\
> =C2=A0	.type =3D IIO_VOLTAGE,					\
> =C2=A0	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> @@ -93,6 +104,7 @@ struct ad7380_chip_info {
> =C2=A0	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> =C2=A0		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> =C2=A0	.info_mask_shared_by_type_available =3D			\
> +		BIT(IIO_CHAN_INFO_SCALE) |			\
> =C2=A0		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> =C2=A0	.indexed =3D 1,						\
> =C2=A0	.differential =3D (diff),					\
> @@ -101,8 +113,8 @@ struct ad7380_chip_info {
> =C2=A0	.scan_index =3D (index),					\
> =C2=A0	.scan_type =3D {						\
> =C2=A0		.sign =3D 's',					\
> -		.realbits =3D (bits),				\
> -		.storagebits =3D 16,				\
> +		.realbits =3D (bits) + 2,				\
> +		.storagebits =3D ((bits) + 2 > 16) ? 32 : 16,	\
> =C2=A0		.endianness =3D IIO_CPU,				\
> =C2=A0	},							\
> =C2=A0}
> @@ -259,6 +271,8 @@ struct ad7380_state {
> =C2=A0	struct spi_device *spi;
> =C2=A0	unsigned int oversampling_mode;
> =C2=A0	unsigned int oversampling_ratio;
> +	unsigned int scales[2][2];
> +	bool resolution_boost_enable;
> =C2=A0	struct regmap *regmap;
> =C2=A0	unsigned int vref_mv;
> =C2=A0	unsigned int vcm_mv[MAX_NUM_CHANNELS];
> @@ -270,7 +284,10 @@ struct ad7380_state {
> =C2=A0	 * As MAX_NUM_CHANNELS is 4 the layout of the structure is the sam=
e for
> all parts
> =C2=A0	 */
> =C2=A0	struct {
> -		u16 raw[MAX_NUM_CHANNELS];
> +		union {
> +			u16 u16[MAX_NUM_CHANNELS];
> +			u32 u32[MAX_NUM_CHANNELS];
> +		} raw;
> =C2=A0
> =C2=A0		s64 ts __aligned(8);
> =C2=A0	} scan_data __aligned(IIO_DMA_MINALIGN);
> @@ -359,23 +376,67 @@ static int ad7380_debugfs_reg_access(struct iio_dev
> *indio_dev, u32 reg,
> =C2=A0	unreachable();
> =C2=A0}
> =C2=A0
> +static int ad7380_prepare_spi_xfer(struct ad7380_state *st, struct spi_t=
ransfer
> *xfer)
> +{
> +	int bits_per_word;
> +
> +	memset(xfer, 0, sizeof(*xfer));
> +
> +	xfer->rx_buf =3D &st->scan_data.raw;
> +
> +	if (st->resolution_boost_enable =3D=3D RESOLUTION_BOOST_ENABLE)
> +		bits_per_word =3D st->chip_info->channels[0].scan_type.realbits;
> +	else
> +		bits_per_word =3D st->chip_info->channels[0].scan_type.realbits - 2;
> +
> +	xfer->bits_per_word =3D bits_per_word;
> +
> +	xfer->len =3D (st->chip_info->num_channels - 1) *
> BITS_TO_BYTES(bits_per_word);
> +
> +	return bits_per_word;

I think this may very well be something we can do once during buffer enable=
ment... I
would expect that enabling/disabling resolution boost during buffering not =
to be a
great idea.
=20
> +}
> +
> =C2=A0static irqreturn_t ad7380_trigger_handler(int irq, void *p)
> =C2=A0{
> =C2=A0	struct iio_poll_func *pf =3D p;
> =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> =C2=A0	struct ad7380_state *st =3D iio_priv(indio_dev);
> -	struct spi_transfer xfer =3D {
> -		.bits_per_word =3D st->chip_info->channels[0].scan_type.realbits,
> -		.len =3D (st->chip_info->num_channels - 1) *
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BITS_TO_BYTES(st->chip_info->chan=
nels-
> >scan_type.storagebits),
> -		.rx_buf =3D st->scan_data.raw,
> -	};
> -	int ret;
> +	struct spi_transfer xfer;
> +	int bits_per_word, realbits, i, ret;
> +
> +	realbits =3D st->chip_info->channels[0].scan_type.realbits;
> +	bits_per_word =3D ad7380_prepare_spi_xfer(st, &xfer);
> =C2=A0
> =C2=A0	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> =C2=A0
> +	/*
> +	 * If bits_per_word =3D=3D realbits (resolution boost enabled), we don'=
t
> +	 * need to manipulate the raw data, otherwise we may need to fix things
> +	 * up a bit to fit the scan_type specs
> +	 */
> +	if (bits_per_word < realbits) {
> +		if (realbits > 16 && bits_per_word <=3D 16) {
> +			/*
> +			 * Here realbits > 16 so storagebits is 32 and
> bits_per_word is <=3D 16
> +			 * so we need to sign extend u16 to u32 using reverse
> order to
> +			 * avoid writing over union data
> +			 */
> +			for (i =3D st->chip_info->num_channels - 2; i >=3D 0; i--)
> +				st->scan_data.raw.u32[i] =3D sign_extend32(st-
> >scan_data.raw.u16[i],
> +								=09
> bits_per_word - 1);
> +		} else if (bits_per_word < 16) {

Can't we have bits_per_word =3D 16 in case realbits <=3D 16?

- Nuno S=C3=A1


