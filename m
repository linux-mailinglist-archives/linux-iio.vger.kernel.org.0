Return-Path: <linux-iio+bounces-8825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB9960CC7
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FC1B2A16F
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD141C4601;
	Tue, 27 Aug 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KdPwuPQ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23C1A0721
	for <linux-iio@vger.kernel.org>; Tue, 27 Aug 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766799; cv=none; b=NjT8vnpJSpD9MmfsqMD11BT60eWUc7HBXDOysPB1+EuC9017HreVlrGBvaS/cnx+6IepFRfq1cXqAm8eSaF0dni1NV8HLQAxmac6MrD4F7lRYXpSeBShi/LHMRqGGUDyEhPrnj8PISAw1Hj0TW/CiG1LIGp1I1nBj+2JNfzIFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766799; c=relaxed/simple;
	bh=PFax44T6fM74boBnueJcjbfD/K/kTkRPd+jkXa9m59M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI0aLtWBErBDePkyGDp5xqS2ifGsLnjAMcriydk4oZoQ9jY1ZQQ9Cu1Pyo66aI6A5Qxu0UBcBLA1GUdhxlOVew9FW3Vl9Q8tg4THKeR04QK3+lCF9ETfo3m0ZQ+8oNK+DoqpCZC2eNjQU2WeaZnfk9QBATHVaw1M6I/8oamdRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KdPwuPQ0; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-498cffc6a9fso1994792137.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Aug 2024 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724766794; x=1725371594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVTaoV+2Xq/VVjcL1G4/iGUowY6MNqfok2/M24soPFg=;
        b=KdPwuPQ0LlyZj/MLQ6YrmxOJluadaCwgIC5VNivJzX4z5x91nKZMklm3OU5rM6coAF
         1KR8H0MSpeeDTm/L12xXd5bfZckwyWGDd1bL1VkCB2VXQn2jw2Zh5xrf9vnUHei/RecN
         muMcC1oSXrZ6qg1IjqBb+q6/V/62hBjifJeIr2efVm9RASCP6N874frk/pkwY9jggV9+
         MzQLxWv9KA2sQ3lpwK4NUqPPXpblnivjBCFLuBr0MypIHQhexXQq+uVcwsXqkyqbkgwh
         Iypd/AQ/dltJ/DbUvTVhnaQhint1qneJWIpknS2M7xl8rUd7BypJafr0/OfXOriVUX3N
         papw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766794; x=1725371594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVTaoV+2Xq/VVjcL1G4/iGUowY6MNqfok2/M24soPFg=;
        b=IoNDumBKOF5OBC+HLtH7YRZUxJJ0qkk+G0wItoffWWlINwUAKfVrtnMSCBFZnciMYG
         TM8GCD0jsu6Kihr4LNaGlQveFMdaLMdXyIhBmbipBIbnXTtFXfjDQ6Inl2LUTZv6n/AI
         QSkn1aYn1cgV46x/aRvaygVhfSdxPeC7ieWZwhd+J5lqarfeuoQDPjz4qjbjgkR7Ee7z
         77bW+7lHYqm5AyffkGm3Mh7napzUaveg+hjxBTkkNCJKuC1NEPQf1rjuS9XCx1xaa2/k
         7YBy+FaGifZDsEZxWY8S9LyvHcrDgtogNd7JQj4ddxwVWNpiX7xFfKEgUCeynPOCm/9q
         KPSQ==
X-Gm-Message-State: AOJu0YwbwDqOpW21x2dhCSTSKfKGkCOeDerBF7rpQTU2SAmkco2nipPo
	nfbaA5r1EbMj/DuIZ4s23S1Dim+Z+sn66WVhA36s03y+4BtVqIGi7Nfa7VevlO0W9J17+HeSWg5
	Ys5+sMMwH9VUuklP/btKVdFG0DqAK2ys3YOHYAA==
X-Google-Smtp-Source: AGHT+IF+Pz8ZkkTjcfE31T92X0qT5a1lo6b3HpcFFsFDHMEK8wQCZR4i09xlz9W2Nup/FkWY7F7j63iQ/Xwmt2m4xl4=
X-Received: by 2002:a05:6102:2911:b0:493:bb35:d8f9 with SMTP id
 ada2fe7eead31-498f4b3424cmr14061662137.5.1724766794411; Tue, 27 Aug 2024
 06:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819064721.91494-1-aardelean@baylibre.com>
 <20240819064721.91494-8-aardelean@baylibre.com> <20240823201913.5bded18f@jic23-huawei>
In-Reply-To: <20240823201913.5bded18f@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 27 Aug 2024 16:53:03 +0300
Message-ID: <CA+GgBR9v-FGYk-6fhC7cCcQKcQqoKac+oRcUvhU8qKG5T0GHvg@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: adc: ad7606: add support for AD7606C-{16,18} parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:19=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Mon, 19 Aug 2024 09:47:17 +0300
> Alexandru Ardelean <aardelean@baylibre.com> wrote:
>
> > The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
> > The main difference between AD7606C-16 & AD7606C-18 is the precision in
> > bits (16 vs 18).
> > Because of that, some scales need to be defined for the 18-bit variants=
, as
> > they need to be computed against 2**18 (vs 2**16 for the 16 bit-variant=
s).
> >
> > Because the AD7606C-16,18 also supports bipolar & differential channels=
,
> > for SW-mode, the default range of 10 V or =C2=B110V should be set at pr=
obe.
> > On reset, the default range (in the registers) is set to value 0x3 whic=
h
> > corresponds to '=C2=B110 V single-ended range', regardless of bipolar o=
r
> > differential configuration.
> >
> > Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.
> >
> > And the AD7606C-18 variant offers 18-bit precision. The unfortunate eff=
ect
> > of this 18-bit sample size, is that there is no simple/neat way to get =
the
> > samples into a 32-bit array without having to do a home-brewed bit-buff=
er.
> > The ADC must read all samples (from all 8 channels) in order to get the
> > N-th sample (this could be reworked to do up-to-N-th sample for scan-di=
rect).
> > There doesn't seem to be any quick-trick to be usable to pad the sample=
s
> > up to at least 24 bits.
> > Even the optional status-header is 8-bits, which would mean 26-bits of =
data
> > per sample.
> > That means that when using a simple SPI controller (which can usually r=
ead
> > 8 bit multiples) a simple bit-buffer trick is required.
> >
> > Datasheet links:
> >   https://www.analog.com/media/en/technical-documentation/data-sheets/a=
d7606c-16.pdf
> >   https://www.analog.com/media/en/technical-documentation/data-sheets/a=
d7606c-18.pdf
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
>
> A few minor things. If we can just start with 18 bit word spi controllers=
 only
> maybe that's worth doing to make things simpler.

Will go for 18 bit word SPI controllers-only for now.

>
> > +static int ad7606c_sw_mode_setup_channels(struct iio_dev *indio_dev,
> > +                                       ad7606c_chan_setup_cb_t chan_se=
tup_cb)
> > +{
> > +     unsigned int num_channels =3D indio_dev->num_channels - 1;
> > +     struct ad7606_state *st =3D iio_priv(indio_dev);
> > +     bool chan_configured[AD760X_MAX_CHANNELS];
> =3D {};
> and drop the memset.

ack

>
> > +     struct device *dev =3D st->dev;
> > +     int ret;
> > +     u32 ch;
> > +
> > +     /* We need to hook this first */
> > +     ret =3D st->bops->sw_mode_config(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     indio_dev->info =3D &ad7606c_info_sw_mode;
> > +
> > +     memset(chan_configured, 0, sizeof(chan_configured));
> > +
> > +     device_for_each_child_node_scoped(dev, child) {
> > +             bool bipolar, differential;
> > +
> > +             ret =3D fwnode_property_read_u32(child, "reg", &ch);
> > +             if (ret)
> > +                     continue;
> > +
> > +             if (ch >=3D num_channels) {
> > +                     dev_warn(st->dev,
> > +                              "Invalid channel number (ignoring): %d\n=
", ch);
> > +                     continue;
> > +             }
> > +
> > +             bipolar =3D fwnode_property_present(child, "bipolar");
> > +             differential =3D fwnode_property_present(child, "diff-cha=
nnel");
> > +
> > +             chan_setup_cb(st, ch, bipolar, differential);
> > +             chan_configured[ch] =3D true;
> > +     }
> > +
> > +     /* Apply default configuration to unconfigured (via DT) channels =
*/
> > +     for (ch =3D 0; ch < num_channels; ch++) {
> > +             struct ad7606_chan_scale *cs;
> > +             unsigned int *scale_avail_show;
> > +             int i;
> > +
> > +             if (!chan_configured[ch])
> > +                     chan_setup_cb(st, ch, false, false);
> > +
> > +             /* AD7606C supports different scales per channel */
> > +             cs =3D &st->chan_scales[ch];
> > +
> > +             scale_avail_show =3D devm_kcalloc(st->dev, cs->num_scales=
 * 2,
> > +                                             sizeof(*scale_avail_show)=
,
> > +                                             GFP_KERNEL);
>
> Maybe just make it big enough for worst case and stick it in st always?
> How big can it get?

So, that would be 16 channels x 8 bytes-per-scale x 5 =3D 640 bytes.
Not too bad.

>
>
>
> > +             if (!scale_avail_show)
> > +                     return -ENOMEM;
> > +
> > +             /* Generate a scale_avail list for showing to userspace *=
/
> > +             for (i =3D 0; i < cs->num_scales; i++) {
> > +                     scale_avail_show[i * 2] =3D 0;
> > +                     scale_avail_show[i * 2 + 1] =3D cs->scale_avail[i=
];
> > +             }
> > +
> > +             cs->scale_avail_show =3D scale_avail_show;
> > +     }
> > +
> > +     return 0;
> > +}
> >
>
> > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.=
c
> > index dd0075c97c24..73a7b0007bf8 100644
> > --- a/drivers/iio/adc/ad7606_spi.c
> > +++ b/drivers/iio/adc/ad7606_spi.c
> > @@ -45,6 +45,8 @@
>
> >
> > +static int ad7606_spi_read_block18to32(struct device *dev,
> > +                                    int count, void *buf)
> > +{
> > +     struct spi_device *spi =3D to_spi_device(dev);
> > +     u32 i, bit_buffer, buf_size, bit_buf_size;
> > +     u32 *data =3D buf;
> > +     u8 *bdata =3D buf;
> > +     int j, ret;
> > +
> > +     /**
> Not kernel doc.  /*
> > +      * With the 18 bit ADC variants (here) is that we can't assume th=
at all
> > +      * SPI controllers will pad 18-bit sequences into 32-bit arrays,
> > +      * so we need to do a bit of buffer magic here.
> > +      * Alternatively, we can have a variant of this function that wor=
ks
> > +      * for SPI controllers that can pad 18-bit samples into 32-bit ar=
rays.
> > +      */
> > +
> > +     /* Write 'count' bytes to the right, to not overwrite samples */
> > +     bdata +=3D count;
> > +
> > +     /* Read 24 bits only, as we'll only get samples of 18 bits each *=
/
> > +     buf_size =3D count * 3;
> > +     ret =3D spi_read(spi, bdata, buf_size);
> > +     if (ret < 0) {
> > +             dev_err(&spi->dev, "SPI read error\n");
> > +             return ret;
> > +     }
> > +
> > +     bit_buffer =3D 0;
> > +     bit_buf_size =3D 0;
> > +     for (j =3D 0, i =3D 0; i < buf_size; i++) {
> > +             u32 sample;
> > +
> > +             bit_buffer =3D (bit_buffer << 8) | bdata[i];
> > +             bit_buf_size +=3D 8;
> > +
> > +             if (bit_buf_size < 18)
> > +                     continue;
> > +
> > +             bit_buf_size -=3D 18;
> > +             sample =3D (bit_buffer >> bit_buf_size) & AD7606C_18_SAMP=
LE_MASK;
> > +             data[j++] =3D sign_extend32(sample, 17);
> > +
> > +             if (j =3D=3D count)
> > +                     break;
> > +     }
> > +
> > +     return 0;
> > +}
>

