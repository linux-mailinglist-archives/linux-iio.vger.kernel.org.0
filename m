Return-Path: <linux-iio+bounces-20109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB10ACA023
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 20:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1748C3B3C57
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55013225A5B;
	Sun,  1 Jun 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKLIvTOe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540017B421
	for <linux-iio@vger.kernel.org>; Sun,  1 Jun 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748804281; cv=none; b=YaCH2GtUF3JWZR/e0Av+KOqCxqb9pzYTkWktPmEKwlqjh+FYNQFMUb2eqToq2VGpxJmQ9opYfo907Ztc9b64ETxaFSiX1sba5VA5sP+ms07I9st+jwHCp9s5zcFy6BwPyTeUK++lbcOXWSojQ+c4OyhUGoRtje5IjEbglZ1r6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748804281; c=relaxed/simple;
	bh=WlXVIGx9rLaPRkoJrlRPd2DXzROo6InhcjNtGeBUy/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=NegVKtkqLY+yD3Fwi5IGiFJH9KJxMf8q8sT0dz8/zZNF13qeArPWVrgtrrF9UnCth9yBhRptjH+cGeZGps7IL9ogBs6kkcOXqCBBqbbSlfELlNdeHQNMkguOrdycwOp4loCzoA85de1OKaMqUuvRAD/7sPstJUd7+n5UTiLZFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKLIvTOe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d0a5ac00aaso46198685a.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Jun 2025 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748804278; x=1749409078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4mNPsdmD8GK7fcIrrHRdYoi1RkLu22ySBhcQOvvf8U=;
        b=SKLIvTOeND40wEqHkEsK8hWqDv14WNczCUMiDWONfCjum0UaaAmrC2979KpVbpM2n+
         WJfPhdu7+i1dgtucw+TdILAJ/ztXSo+Xd68JSgfe+2mi80DaWJXnL93nW8wNBL7xQ6vz
         XRnE3+6yRBXygIHFNKwQrF/9sIt1E7ebPLJa41NFlpcY+Gewhegz5kJ96XJHmOfZ+YZu
         60k6dr9XIvSTEjN0G1vnvXUjbmQPL/zO18AFLoCDU9wqzKO1hY/yyu5KKrRu54gpIScN
         UwT385yblxoZkc/JJt2GMFZEz4Slq0QxlyHbpwLyuNtzvJXlEyVO97DuLapEQGS6if26
         rVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748804278; x=1749409078;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4mNPsdmD8GK7fcIrrHRdYoi1RkLu22ySBhcQOvvf8U=;
        b=EIOVQtyRwDH1FlbOAMLPLzTGF5kjElmD10qsZzDf9Z1WMHzPOD0pBUjBNFVm3MDgiC
         NxFTOszzjyiyyNdivGtAw/cyGnypLTW7JEc8mmkGP4FFuZ9huXbuxsQHlWXi0em4VibX
         VL9IMD3pYToBIvI2k7yrVq3F9GHhmb7MU69G1LrF+0hZbJfdkZ9OZ09/OULj1uA7kbRS
         ZhrOr2U81JDAmJDtWS1l6NxDjHmtAWuZQlnKJm+WQtPEHNFarTMLPIKCpMHlZqZ25t+k
         J1nauvQlaQtbEtmrnaS8qWgyozxwdNOCr0fT7v98+Eig5iXXWboPlm8AzZ+rFZ/Wy1r+
         UmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyFuIHMXO07pFik2hEO1xf0SgUyF+xqNGGm2wxAR+DTKLQnYEQNIQ5A7xipPpvGMt0HDRjJaGj47A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DNCuCtK7hmcUJd4vzmfaTenhyKk/qstcq4B9NifLkb6il/B0
	ff9eAq2jp8L5sQhfcq1T82A4N8Fn2t6tpDf7sImQ11g61FmBm/n7yw+6qf3lfngW3E+beS63vmP
	uQn0g9+JuoM/41/eviD+CNmIa5Lzhvb8=
X-Gm-Gg: ASbGncvwft9zbXR951vDUUzDfh5qpBLfxfbXq/qN5TS/XC2Q4gkROkH1/Ix6OCkHNrb
	ZoYUjk5ZXdWKgO8TbVxhLiAeSLROMC3HMP6aZcPc4Ycn3hwK/GOlkENDX9ImFFdBLJcfDxV5Dnf
	LNWgAlvpXhQx5JcvTBGZuzvjO8gH35RnfvU34zNLVcfbexiRKnN0UPM4h4d2MQVYMb
X-Received: by 2002:a05:6214:ca7:b0:6fa:b980:19cf with SMTP id
 6a1803df08f44-6fad06f1ce3mt60348626d6.11.1748804277684; Sun, 01 Jun 2025
 11:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428034222.318898-1-gabrielgeraldinosouza@gmail.com> <20250505172442.4d555967@jic23-huawei>
In-Reply-To: <20250505172442.4d555967@jic23-huawei>
From: Gabriel Geraldino <gabrielgeraldinosouza@gmail.com>
Date: Sun, 1 Jun 2025 15:57:45 -0300
X-Gm-Features: AX0GCFvEV9XhDcI4K4ji2SaDbiD7tasSQGD4JbcVfXfjxfzZh_Sg4mAz0S3EaJQ
Message-ID: <CAOx+b6YS9Se7kfRFbqx5qZ-g8eQATg4ht=kH2XTvgmyOBBsLBw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: sc27xx: Refactor sc27xx_adc_scale_init to
 reduce duplication
Cc: Nicolas Borsari <nicborsari@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Apologies for the late reply, and thanks for your thoughtful feedback.
We understand your concerns, and we agree that in this case,
readability should take precedence.
We'll drop this idea and focus our efforts elsewhere.
Sorry for resending =E2=80=94 the previous email was rejected due to HTML f=
ormatting.

Best regards,
Gabriel & Nicolas


On Mon, May 5, 2025 at 1:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Mon, 28 Apr 2025 05:42:22 +0200
> Gabriel Geraldino <gabrielgeraldinosouza@gmail.com> wrote:
>
> > Simplify the sc27xx_adc_scale_init() function by refactoring scale rati=
o
> > initialization logic for SC2720, SC2730, and SC2731 PMICs. This removes
> > code duplication by using a data structure to represent channel/scale
> > mapping.
> >
> > This change improves readability and maintainability without changing
> > functional behavior.
> >
> > Signed-off-by: Gabriel Geraldino <gabrielgeraldinosouza@gmail.com>
> > Co-developed-by: Nicolas Borsari <nicborsari@usp.br>
> > Signed-off-by: Nicolas Borsari <nicborsari@usp.br>
> Hi Gabriel, Nicolas,
>
> A few comments inline, but overall I'm not sure the code reduction
> is sufficiently to cover the resulting loss of readability.
> Sometimes a switch is simply clear than a partial look up table.
>
> So nice idea, but I'm not seeing it as being a good move for this particu=
lar code.
> I'd be slightly interested to see the optimized output of the two approac=
hes, but
> this is far from a high performance path so we care a lot more about read=
ability here.
>
>
> Thanks,
>
> Jonathan
>
>
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 90 +++++++++++++-----------------------
> >  1 file changed, 32 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.=
c
> > index 2535c2c3e..a8312859d 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -407,78 +407,52 @@ static int sc2731_adc_get_ratio(int channel, int =
scale)
> >  /*
> >   * According to the datasheet set specific value on some channel.
> >   */
> > +struct adc_channel_scale {
> > +     int channel;
> > +     int scale;
> > +};
> > +
> > +static void sc27xx_adc_scale_init(struct sc27xx_adc_data *data,
> > +     const struct adc_channel_scale *table,
> > +     int table_len,
> > +     int default_scale)
>
> Style wise, I'd prefer these aligned after the (
> I don't think this will even go over 80 chars but if it did that would
> be fine if it doesn't go over by much.
>
> > +{
> > +     int j;
> > +
> > +     for (j =3D 0; j < sizeof(data->channel_scale); j++)
> > +             data->channel_scale[j] =3D default_scale;
> > +
> > +     for (j =3D 0; j < table_len; j++)
> > +             data->channel_scale[table[j].channel] =3D table[j].scale;
> > +}
> > +
> >  static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
> >  {
> > -     int i;
> > -
> > -     for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > -             switch (i) {
> > -             case 5:
> > -                     data->channel_scale[i] =3D 3;
> > -                     break;
> > -             case 7:
> > -             case 9:
> > -                     data->channel_scale[i] =3D 2;
> > -                     break;
> > -             case 13:
> > -                     data->channel_scale[i] =3D 1;
> > -                     break;
> > -             case 19:
> > -             case 30:
> > -             case 31:
> > -                     data->channel_scale[i] =3D 3;
> > -                     break;
> > -             default:
> > -                     data->channel_scale[i] =3D 0;
> > -                     break;
> > -             }
> > -     }
> > +     static const struct adc_channel_scale sc2720_table[] =3D {
> > +             {5, 3}, {7, 2}, {9, 2}, {13, 1}, {19, 3}, {30, 3}, {31, 3=
}
>
> Spaces after { and before }
>
> > +     };
> > +     sc27xx_adc_scale_init(data, sc2720_table, ARRAY_SIZE(sc2720_table=
), 0);
> >  }
> >
> >  static void sc2730_adc_scale_init(struct sc27xx_adc_data *data)
> >  {
> > -     int i;
> > -
> > -     for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > -             switch (i) {
> > -             case 5:
> > -             case 10:
> > -             case 19:
> > -             case 30:
> > -             case 31:
> > -                     data->channel_scale[i] =3D 3;
> > -                     break;
> > -             case 7:
> > -             case 9:
> > -                     data->channel_scale[i] =3D 2;
> > -                     break;
> > -             case 13:
> > -                     data->channel_scale[i] =3D 1;
> > -                     break;
> > -             default:
> > -                     data->channel_scale[i] =3D 0;
> > -                     break;
> > -             }
> > -     }
> > +     static const struct adc_channel_scale sc2730_table[] =3D {
> > +             {5, 3}, {10, 3}, {19, 3}, {30, 3}, {31, 3},
> > +             {7, 2}, {9, 2}, {13, 1}
> > +     };
> > +     sc27xx_adc_scale_init(data, sc2730_table, ARRAY_SIZE(sc2730_table=
), 0);
> >  }
> >
> >  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> >  {
> > -     int i;
> >       /*
> >        * In the current software design, SC2731 support 2 scales,
> >        * channels 5 uses big scale, others use smale.
> >        */
> > -     for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > -             switch (i) {
> > -             case 5:
> > -                     data->channel_scale[i] =3D 1;
> > -                     break;
> > -             default:
> > -                     data->channel_scale[i] =3D 0;
> > -                     break;
> > -             }
> > -     }
> > +     static const struct adc_channel_scale sc2731_table[] =3D {
> > +             {5, 1}
> > +     };
> > +     sc27xx_adc_scale_init(data, sc2731_table, ARRAY_SIZE(sc2731_table=
), 0);
> >  }
> >
> >  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>

