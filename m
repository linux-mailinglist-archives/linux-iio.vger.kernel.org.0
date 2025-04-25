Return-Path: <linux-iio+bounces-18615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63F2A9BD8C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 06:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB5B3B81D0
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 04:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EAD21638A;
	Fri, 25 Apr 2025 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz3ehBIL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750926AC3;
	Fri, 25 Apr 2025 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555143; cv=none; b=gHoSxLIR2LObvtWejoEZL5KxBIubpWra1QuWDhwz/rHAXY3wZF2oILomPplH2/ANXTS7O9/TY25HUTmQoqGcMcCg/Kna89/gZhqz8kNrnwJk084aQe/VZJP5ypGYAFRtlDvaIezQ9UqohBRyeTn8MDu2Spu053Bq8bI5y5cE/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555143; c=relaxed/simple;
	bh=Jy97R1wx5sVqOZMfPz4MOBXl5MZAKekgvv5SfHf0JuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSTsY30O8NyFwYuQ7E1blCkzCZ80AGHciXJx4L5B6MIFByXV76shuizYB7frKrby/5M+Km+JIxBBmEtkBWa+kTbR1R6EfH4u7txM9VpWtF8dMt84iHUpqZmnY1PcoS7yOnK8qfE7MyJUCJXjjBJYekgKjLJhetZ5nmA69a3w+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz3ehBIL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso2634241a12.0;
        Thu, 24 Apr 2025 21:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745555140; x=1746159940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqVVwg78KecTQrbOcLDXNtfkUV3HjJdry3VPAdxnn0I=;
        b=Gz3ehBILytLh8ZMPABkZPUHvTw2KrIW9LwsIDlVNZLcmKzMt6dosHRAuWF/iyoE5Po
         oMKjbCn+10BZ/oTFXzpBAq/uyobJyjXJOWeCzOcYBTrXazDhngGubXBE/KchLe8nqK8+
         gA4yMWPQLpz8oVbEVfHGZdKD+metfEjj+x+YybFZMhv9A5P23WIt3HM8mwfr78VCJVZK
         jGEW7p0t8oHt2BXBTOisfjoxLY6rfLWf6ZAmm2fqk4IHKT0nI8bjqi50yRdDE9iB05ex
         FGkq+UIMxzddPdsinvnqH8CPe1yeANGQlywtPfN89hcC1c4OCI8leq8CgURlg33+d0Mm
         rC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745555140; x=1746159940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqVVwg78KecTQrbOcLDXNtfkUV3HjJdry3VPAdxnn0I=;
        b=iA0bwOx6juEsfRNhwh+dQsyuzVZ3MhgEXJxK6Aa/mPnxNhD26gfbE/f0YIic5MfVV+
         lqfG89ml7ilgq+tAqfepAYs9BOPff8iJOo7n1+W1IAjYqgpFYOph/oRwnxjWVmglfBju
         65GnBz5CRGF7ir8X+Pvp5c/eWLVKKge8oeLxPzE//cYr+neYmWXyu+fNm1omFcbMzAHs
         r4OktEaKnL7v2gVBTR6K31sUKBi7FfXbpzcCJFRCJvX9+f6hjPtdkfInRuTNq+5mClJp
         nVUtHaYWQSssLhSjWBJP+EohF5ftRcAqN5zqoilDVLUxezX+cVtyxUCkFKy2FoqIrGzH
         HXzA==
X-Forwarded-Encrypted: i=1; AJvYcCU+m73z/eybAbiTMtvfsicvfxFGjHYxy4CL9JyEXnA+ohFq3TN2z9AxAeFcsekr4zsA/y6GJk0O8Dg=@vger.kernel.org, AJvYcCVfWMVZO8oPaQxo24dW3Q/d0vpB1fFeC3i/JiNd7LqYzHdnBD9W0XoWmRKTjKQwnj8YNv+R8DBZ3ZC4GDGa@vger.kernel.org
X-Gm-Message-State: AOJu0YxirGhhzdG/+4QLE3S3i92V3NyXFFCK+oyHrxaRn5CGlBOJP8Qd
	wV9WvLSLqCSkryslFolsSre8dyCcdKAV/DKD7F6j91mjxC3gMXKOF0FEMcgyl0G5lL4IOy4Gc55
	V2165LzlS+l15v8ThTdnPa9GQkUY=
X-Gm-Gg: ASbGncsnpTEqTIgUlG1107CLiYx6kj+4h1wZxistpSuNyoRpw2v4b7O7KP+ummJFfyi
	sgOk4Vsny/JNH/dpe2saH+3Hp4QxZtMvEZ6QPCZpnzIbQfc579Eg7Tpmt0aBmhoHYsV3L+TBeNb
	pGQTv8BW7M89/TVjV5CnCxxQ==
X-Google-Smtp-Source: AGHT+IGOPLy72Qv/dSaf9ns50zld51W6EJ9IwKuaHOcIQgrajno/4DsITdv3MS/cQZ9vZ+E1rFBMvrjgJQxlvIFCfds=
X-Received: by 2002:a17:907:86a7:b0:abf:733f:5c42 with SMTP id
 a640c23a62f3a-ace71048709mr71258066b.8.1745555139755; Thu, 24 Apr 2025
 21:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424223210.91317-1-gshahrouzi@gmail.com> <20250424223210.91317-3-gshahrouzi@gmail.com>
In-Reply-To: <20250424223210.91317-3-gshahrouzi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Apr 2025 07:25:03 +0300
X-Gm-Features: ATxdqUG-YZDqpAiQ7DWeVoXYapBbpZFIX7bs0mTobnkUl-qrm5OxRtRUZ77AiZI
Message-ID: <CAHp75VfnAkgP7sPs2E5i2hjcNib96mjyXz-w=jgFzF7F839yTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] staging: iio: frequency: ad9832: Refactor
 powerdown control
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, gregkh@linuxfoundation.org, 
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:34=E2=80=AFAM Gabriel Shahrouzi <gshahrouzi@gmail=
.com> wrote:
>
> Replace custom implementation with out_altvoltage_powerdown ABI. The
> attribute's logic is inverted (1 now enables powerdown) to match the
> standard.


> +static ssize_t ad9832_write_powerdown(struct iio_dev *indio_dev, uintptr=
_t private,
> +                                     const struct iio_chan_spec *chan,
> +                                     const char *buf, size_t len)
> +{
> +       struct ad9832_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +       bool val;
> +
> +       ret =3D kstrtobool(buf, &val);
> +       if (ret)
> +               return ret;
> +
> +       guard(mutex)(&st->lock);

> +       if (val)
> +               st->ctrl_src |=3D AD9832_SLEEP;
> +       else
> +               st->ctrl_src &=3D ~(AD9832_RESET | AD9832_SLEEP |
> +                                AD9832_CLR);

Why out of a sudden this went backwards in style and format (no
FIELD_PREP(), two lines, ...)?

> +
> +       st->data =3D cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SL=
EEPRESCLR) |
> +                                         st->ctrl_src);
> +       ret =3D spi_sync(st->spi, &st->msg);
> +
> +       return ret ? ret : len;
> +}

Use Elvis?

...

> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);

This should be done in a separate patch for all locking.

...

> -                       st->ctrl_src |=3D FIELD_PREP(AD9832_SLEEP, 1);

Btw, I do not see this in v6.15-tcX, is this part of Linux Next?

...


>         &iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
>         &iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
>         &iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> -       &iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,

>         NULL,

Also drop the trailing comma at some point.

...

> +static const struct iio_chan_spec_ext_info ad9832_ext_info[] =3D {
> +       {
> +               .name =3D "powerdown",
> +               .shared =3D IIO_SEPARATE,
> +               .write =3D ad9832_write_powerdown,
> +       },

> +       { },

Ditto.

> +};

--=20
With Best Regards,
Andy Shevchenko

