Return-Path: <linux-iio+bounces-1999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912EC83FA26
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 22:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49384281CAF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A331A82;
	Sun, 28 Jan 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FFyUdY/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642B4C3C3
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477286; cv=none; b=OgWy1MpZxunVJljqjVAmBKZ8Q9FVoQQy2xyXISlQtbcp0FEqox4yQP9s6TC5gBjk+1e2bnkTmR0SWJCqyPHacc/vLhjFGdZ02mWa0S6r80myHVqcnNvkVojYuhgzmVce+rTZFH9NsaChdJsB2Z+cKYuuADjsO2y/SDD7cWrL7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477286; c=relaxed/simple;
	bh=CgVdGz7EKTRkelJIVLWkTCcNdrYoc8AKZ/MaSuVBL7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJrWZbTjP/+lOOaz1lus3Pjgtl6Ha53Mutf912SySvXiPZG8A3hnHgNj8XDOBk4mFVzqWU/uiJ54BH9A9cazUW1xN2/kWYyERtuRiB8bBOczYcEXhfWBoMjrg5Dw4Csc0nNHQEVmVEIK5B2aLLlYZlI08uI0LQ3wyDMN/7lojKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FFyUdY/X; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf593af2ebso9488681fa.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 13:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706477282; x=1707082082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCQGrFxh/LvGLf8ohnPj0k6l4TPEiUjhbezQwirWFxI=;
        b=FFyUdY/Xy1G3RowoQ47ZOSuAPm0W9FwJiTYrqHHTUWFrOyGGDmOl1pmCK6t5xdnaCv
         eqp9EtcKsukJajiMmGqL/FQCHVAaEN81cXWUoJvaVVaqx518eMfU5b9kQmKYydL7EYJV
         NrFdqPsbAe4PGXlyXMu4dYuY5cQiFZLk5caZF4fgRJpSp4jGvp7WX7BQjcWaao+HXDCt
         r6ex/ILwzRJbGTaiM6GlNaIoz4tiiFncpf9NzI4dliDrleNweWeMKz0EC+D6JwTEo2Re
         MNTNLt7fwrflhjaoIUhIxyFM6FGtrezVeDr3yn5/IxbaqhbNky1/nSof3Q4vGv/kALHx
         4ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706477282; x=1707082082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCQGrFxh/LvGLf8ohnPj0k6l4TPEiUjhbezQwirWFxI=;
        b=UKaNwhn7fjUYNy8R2GFZm9oJ/kEpJftoGYNdGH7Vgq2P8/EuMYEUUgL8zI70q5tbeB
         GvJeupe3P+1uFtjUosqVntU8yqmDRZHGO74LJSe7Sl4GGjA0wvlgfh2slQwiUb/2FMSh
         8C4WuZlhei9PkUCatkeVB5jCK83f0A29IncMS2zzd9RdoleRCkfK0HIHCPDT2fXlIW+3
         DXWsX7pOv2iO1w/JZptRBTKgsbJwm/vih7kK1VQWqRPJFkE0XRyb14zYGjx0cjfKN91e
         a2qA9hQSKCYB8aenH0R3mudFWu4Ilrq0piqyS4e06sJoYPgaw3u2UD03/qvPpM5iVtfd
         JuSg==
X-Gm-Message-State: AOJu0YyBU0B1d/pZXgZ6PltsOlPQjLPVwVXekYRXCG2DoeTK1ZdUVLJQ
	3h1BVmmX8d1I5o3RzaoMN1TZ3fvpY3cdluzeroBwQMKnpiPtfBvX/rsoqu+TTnUvoheH+aOswUw
	F6tKiBROuWYOiffyuMNhfIE3ZHYeQmENpMkYTug==
X-Google-Smtp-Source: AGHT+IHMvCkcMt6M2oupNSDclHa2N891EI/vgdGNpp2uWlxC04jIs5KrrzcH3iSyyrRN8THUE5cftlFI90+3KX7fMPo=
X-Received: by 2002:a2e:3806:0:b0:2cf:73b:26ae with SMTP id
 f6-20020a2e3806000000b002cf073b26aemr1440776lja.22.1706477281672; Sun, 28 Jan
 2024 13:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
 <20240123-iio-backend-v7-9-1bff236b8693@analog.com> <20240127152049.22a8ce74@jic23-huawei>
In-Reply-To: <20240127152049.22a8ce74@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 28 Jan 2024 15:27:50 -0600
Message-ID: <CAMknhBF6QNUf2zX9sQ+09nt2ZapTShwv3-HbmehFgvHnMfNo5Q@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] iio: adc: adi-axi-adc: move to backend framework
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 9:21=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 23 Jan 2024 16:14:30 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> > From: Nuno Sa <nuno.sa@analog.com>
> >
> > Move to the IIO backend framework. Devices supported by adi-axi-adc now
> > register themselves as backend devices.
> >
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> I'm still not getting the %d vs %c change..
>
> Otherwise LGTM
>
> > -     if (cl->info->version > ver) {
> > +     if (*expected_ver > ver) {
> >               dev_err(&pdev->dev,
> > -                     "IP core version is too old. Expected %d.%.2d.%c,=
 Reported %d.%.2d.%c\n",
> > -                     ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
> > -                     ADI_AXI_PCORE_VER_MINOR(cl->info->version),
> > -                     ADI_AXI_PCORE_VER_PATCH(cl->info->version),
> > +                     "IP core version is too old. Expected %d.%.2d.%d,=
 Reported %d.%.2d.%c\n",
>
> If it's a valid change fine, but then I'd expect both %c to change.
> I'd also expect it to be in a separate patch with an explanation of why.

I was noticing this same pattern in other "AXI" drivers. I think the
reason for the %c is to match the version format in the devicetree
compatible string which looks like "1.00.a". So to fix this we should
probably keep %c and change the value line to
`ADI_AXI_PCORE_VER_PATCH(cl->info->version) + 'a'` to convert it to
the appropriate ascii value.

(But agree that this should be done in a separate patch/)

>
> > +                     ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> > +                     ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> > +                     ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> >                       ADI_AXI_PCORE_VER_MAJOR(ver),
> >                       ADI_AXI_PCORE_VER_MINOR(ver),
> >                       ADI_AXI_PCORE_VER_PATCH(ver));
> >               return -ENODEV;
> >       }
> >
> > -     indio_dev->info =3D &adi_axi_adc_info;
> > -     indio_dev->name =3D "adi-axi-adc";
> > -     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -     indio_dev->num_channels =3D conv->chip_info->num_channels;
> > -     indio_dev->channels =3D conv->chip_info->channels;
> > -
> > -     ret =3D adi_axi_adc_config_dma_buffer(&pdev->dev, indio_dev);
> > +     ret =3D devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generi=
c, st);
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D adi_axi_adc_setup_channels(&pdev->dev, st);
> > -     if (ret)
> > -             return ret;
> > -
> > -     ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> > -     if (ret)
> > -             return ret;
> > -
> > -     dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
> > +     dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%d) probed\n",
>
> This should also be in that separate patch fixing up this formatting.
>
> >                ADI_AXI_PCORE_VER_MAJOR(ver),
> >                ADI_AXI_PCORE_VER_MINOR(ver),
> >                ADI_AXI_PCORE_VER_PATCH(ver));
> > @@ -428,6 +229,8 @@ static int adi_axi_adc_probe(struct platform_device=
 *pdev)
> >       return 0;
> >  }
>
>

