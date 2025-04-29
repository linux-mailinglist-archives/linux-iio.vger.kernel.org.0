Return-Path: <linux-iio+bounces-18879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF483AA3AE0
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E2B3AA3FF
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F621E1E04;
	Tue, 29 Apr 2025 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPVaLOKY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C47E9;
	Tue, 29 Apr 2025 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964076; cv=none; b=ndYy1BPXmmoBYl+yLkjXpDoa49P+jZvkIbqzzDtBl6B4kL6IFzZ/RnX3KseGS94UJjsHbijvR4V4UEyYUZFlBsAIJVwQBeXAkokw31MRnict3pkAMQgbcobjzm4OyK09/a+NYLq4e0zWQVhqQwbGVox+toKMdPQZNmLMksX73JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964076; c=relaxed/simple;
	bh=so2WUcTSbPml9ZduHPdr5ppMxEZn0laxGP0IZlkm364=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKAbmxYzvILee6JrMA3hybhnyCFy6duy4mEX6KWtoAZSoUdbQ1eKHCN2UbsUM/m+/1OB2t07vJhcY3NhM4T7Jnm3lccl5TcGhB64VrBUbqDocLD6yjGFLGjFxyteZFl9jLepxJk7Sz37o55slW05gS95sL97zdo0Ji1xk/CfcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPVaLOKY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac345bd8e13so950008566b.0;
        Tue, 29 Apr 2025 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745964073; x=1746568873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQazwp9WUvNXy/9ZWbeeym5SVzeOQHXpU41heEUQ1Ww=;
        b=YPVaLOKY7Dr0EtOACRmtcaX7kj+Npmf6PQzG293a8wJ1MmZkqCYvfqYnCPqtMjeDhD
         VaOCOz7qcDjw2KLAAzOlczKXbuI64H/0ZCdSD8qXuuz9GMRXyH6d1TnhFehcQoKEVvxl
         63vCrPrPtWvUlx0avAWdxB3zphzJtHsgPi+CsUJB6bQKaLk2GiM7RhrVLkVz8zsBvhuW
         F5frQEt7RhXZaucKmuwl8zaWABkBlSx49H2NE1vzw4EyXzwI3Uf5DhcNzh3Be14bqSBF
         JWQt25qzreJNyqNmPsfWW/o9NXMlIjsNWLA1K+WXP5bjZoTNJaw5BPAUOhGoHHnRxVvC
         M4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964073; x=1746568873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQazwp9WUvNXy/9ZWbeeym5SVzeOQHXpU41heEUQ1Ww=;
        b=q7ppEuKT+fr+oNtf05GytUCeR+dJWFSolvvdbWT2S5k7iYFD6Bgo1xt/hzSdag6H2W
         pOT9CPxaTNw1g/E5epecBGjvDvU94tZilVlDwfRdgmiKPN5D26rLC00QjseoyUlCcamk
         4h6FPPtd+q70chV3oVVXNr/V1NuIeH8UY0pJV9FV+rqSL/dlBhPpPKJcoWCLDxQEqQ2v
         oBmI53iRsG8xnrSLrqPxyNgOGhPN7a68AHgn+dcyMdrBZS7UOYSq7QW1oW/gRLhp3NdX
         kvdTN1uEmxNKYnJPrb//QLN2kFeo0DQDe0BRGWUj/RpfqXZS5oQ4RwkdSuTy9s9+Df64
         R7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVCGY4i2MEDVjaE5DWhU6eOqB1anMXLJO++FdXz2+ZgFTo5YKB1edjbAUWLHmjaFmVKcxhLPHuj35YK@vger.kernel.org, AJvYcCWH0mJeW7isizU5ddL2ANp8bwN5C7dbJdwk7mqtzs/CRNhRDXBkJEZZjlWPYObIlYRhxMiGXBaIp11MdR9/@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4gcBLTVFfupYJL9nT3U0lTDS0L8CII/jiPc7wPJ+aPwyfLGf
	IneG1l1KNKc7ObQGu06+8PzFWyi0QM/erJWyf7uYAq7z8CJP5/k3yZ7K1cVK0tNK3HyL+ixYuZi
	VvRNWdNhM2W5bQnCy0vQNt2wASek=
X-Gm-Gg: ASbGncv4df5q/gK3L6ja2K2uVrKjxXeREENYc491yrT9VjXnaLVTYXQe0RbB7iE6nKO
	DSVpmysTmOr6uC26kxPFSShvSVM4mF+xg/V8kdAV7Z57hM2tUi4b7NQFnfTH1ChtjTB/diSZbAu
	gtLdKFRSIbK/QFzcOrsGkfOA==
X-Google-Smtp-Source: AGHT+IEJv5YuET3FOvROh7mxVPAT0XW0YNAdhUXhA/RfLE8YK6WDQcNAMu1hvrRf31xYApYnG9kNJGpz1UVrmdGWzmE=
X-Received: by 2002:a17:907:3e8c:b0:aca:a3da:80b8 with SMTP id
 a640c23a62f3a-acedc7763a4mr85057366b.55.1745964072988; Tue, 29 Apr 2025
 15:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745841276.git.marcelo.schmitt@analog.com> <db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
In-Reply-To: <db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:00:36 +0300
X-Gm-Features: ATxdqUGE-rCNDXc8AWuQlT7f-J0zesni32t7ZpRaRi3RgltjEYUpWElbOaARGts
Message-ID: <CAHp75Vc9CMqkkrEjgGEYPnmkb1R=u+RUvD3FAZ+7bFqi5aDzdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] iio: adc: ad4170: Add support for buffered data capture
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:28=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Extend the AD4170 driver to allow buffered data capture in continuous rea=
d
> mode. In continuous read mode, the chip skips the instruction phase and
> outputs just ADC sample data, enabling faster sample rates to be reached.
> The internal channel sequencer always starts sampling from channel 0 and
> channel 0 must be enabled if more than one channel is selected for data
> capture. The scan mask validation callback checks the aforementioned

checks if the

> condition is met.

...

> +static int ad4170_prepare_spi_message(struct ad4170_state *st)
> +{
> +       /*
> +        * Continuous data register read is enabled on buffer postenable =
so
> +        * no instruction phase is needed meaning we don't need to send t=
he
> +        * register address to read data. Transfer only needs the read bu=
ffer.
> +        */
> +       st->xfer.rx_buf =3D &st->rx_buf;
> +       st->xfer.len =3D BITS_TO_BYTES(ad4170_channel_template.scan_type.=
realbits);

This will give, e.g., 3 for the realbits =3D=3D 24. Is this expected?

> +       spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
> +
> +       return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->msg=
);
> +}

...

> +static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       struct ad4170_state *st =3D iio_priv(indio_dev);
> +       int ret, i;

Why is 'i' signed?

> +       /*
> +        * Use a high register address (virtual register) to request a wr=
ite of
> +        * 0xA5 to the ADC during the first 8 SCLKs of the ADC data read =
cycle,
> +        * thus exiting continuous read.
> +        */
> +       ret =3D regmap_write(st->regmap, AD4170_ADC_CTRL_CONT_READ_EXIT_R=
EG, 0);

No error check.

> +       ret =3D regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +                                AD4170_ADC_CTRL_CONT_READ_MSK,
> +                                FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK=
,
> +                                           AD4170_ADC_CTRL_CONT_READ_DIS=
ABLE));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D  ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * The ADC sequences through all the enabled channels (see datash=
eet
> +        * page 95). That can lead to incorrect channel being read if a
> +        * single-shot read (or buffered read with different active_scan_=
mask)
> +        * is done after buffer disable. Disable all channels so only req=
uested
> +        * channels will be read.
> +        */
> +       for (i =3D 0; i < indio_dev->num_channels; i++) {
> +               ret =3D ad4170_set_channel_enable(st, i, false);
> +               if (ret)
> +                       return ret;
> +       }
> +       return ret;

Wouldn't return 0; suffice?

> +}

...

> +static bool ad4170_validate_scan_mask(struct iio_dev *indio_dev,
> +                                     const unsigned long *scan_mask)
> +{
> +       unsigned int masklength =3D iio_get_masklength(indio_dev);
> +
> +       /*
> +        * The channel sequencer cycles through the enabled channels in
> +        * sequential order, from channel 0 to channel 15, bypassing disa=
bled
> +        * channels. When more than one channel is enabled, channel 0 mus=
t
> +        * always be enabled. See datasheet channel_en register descripti=
on at
> +        * page 95.
> +        */
> +       if (bitmap_weight(scan_mask, masklength) > 1)

> +               return test_bit(0, scan_mask);

> +       return true;

Hmm... Is it possible to get weight =3D=3D 0 and true here?

> +}

...

> +static irqreturn_t ad4170_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf =3D p;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct ad4170_state *st =3D iio_priv(indio_dev);
> +       int i, ret;

Why is 'i' signed? (And even in the original case it's inconsistent to
the similar in another function)

> +       iio_for_each_active_channel(indio_dev, i) {
> +               ret =3D spi_sync(st->spi, &st->msg);
> +               if (ret)
> +                       goto err_out;
> +
> +               st->bounce_buffer[i] =3D get_unaligned_be32(st->rx_buf);
> +       }
> +
> +       iio_push_to_buffers(indio_dev, st->bounce_buffer);
> +err_out:
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +}

...

> +               return dev_err_probe(&st->spi->dev, ret,
> +                                    "Failed to register trigger\n");

One line?

--=20
With Best Regards,
Andy Shevchenko

