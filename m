Return-Path: <linux-iio+bounces-8545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29895585F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06B61C20F64
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D3DBA33;
	Sat, 17 Aug 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MWHO1EqS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8979E1
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905186; cv=none; b=PDXTtm7ha8nnCbPkSLbY54OGdKigLkceyn0gLA7eMuKWPr/COnIdpLgLx91Oooeo6rEOUcPgwuFyCL+zsplg4E80ZvzVYrBDan16QWxW8KO/5WHcGtzRWbB0S1Z5uV9bQuRaEp1x0XsRUKJXzb+//3uSTAC5qEqWsbuUXv+72og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905186; c=relaxed/simple;
	bh=C4poUl2wKeCf51qUHp+pzmr6kSXrA/riU68WL2PCBvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kb6rEp/CQQ0f7RtddJyTez5ca33QE6KQcUCdgaWvcHTtt34KvVz0vOxRl23BVs1lbSUC3MoyYQNQSkd7YMAanrK/mhaizKy66PZZCrzYvqzU6dky3JnwYEI8CyIaBRtx8iDdEJw7lDJ/530DPv5+IzBflMNGjTGSTf6blOqbM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MWHO1EqS; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-822fdea84c4so59874241.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723905182; x=1724509982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f8I9WhmapCi6fSJlsgN3NHudz8UCIRAhEFKdwk381g=;
        b=MWHO1EqSPLMa0gjKRY9spn8g9Bu9eg9vQookM7CcBxltSH2fhzx3gWgW6Y1OnAuK0h
         PAZkVmmvvFeMKSQksUHAyTAN8zJzl689NmUqT6f0etSMn/MtfuDOmO9BvUfbTfGd9LYW
         obbWBSv3C3/HeKRy3XvA1AExcU+mKXpd9o8NB1q9v201bfoffcuqdthEmW7f6d8wzm1Q
         WOC3tigENloe43o4hnlSrSwB10B63/tY/QF0QGZ0oPnsf5MpLCcvtY43vdD+EuQv19Br
         rH2OKaBorYubncjZOyC7rk41u4mGl6Sbz84zxcdi3qJtwCxTaruHftqMn9pono7fDNzA
         E0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723905182; x=1724509982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f8I9WhmapCi6fSJlsgN3NHudz8UCIRAhEFKdwk381g=;
        b=rUNczAdqYB411VtM2KVZhJcCMskRavOZPMM52iKc9Y2ITTzNusJNfv/BsDLJBWKL4x
         9XdiuesrlCyrL56pIl48q1+NwfmScXSd0pNHO/nj7a/G1kN4kjAToI7xpbuFuGGzZDvs
         pvm4oSkV3gfPzM2XKP771k4P0+C3wLkA0bhnKX5sKxayJj8Q2l9di1XyEZvgsNlo+QTF
         l5MQefQQvkL2MGu8i1RsZ8rPDm+WGT8TY/hVBgYVyAkCfo1gisRwfPTLcCQfDwdLJ8xZ
         CcyEDCIWdum0z998ic+FD+aSEKJrKEynXZB4/qbC06Io7eXmBWiFs9TYw+ick7GcRIjG
         8ASA==
X-Gm-Message-State: AOJu0Yy8JyzlkfoXt/cQk7GRAzlJbaEOCqFcZl9dffcVN4ZvAQXsgRos
	5sOEV04HNmaVo0m/CfOjMO/Dt21IiWe6Y6ji3ND18Q2UfqMe5MzZpgNlUZibJ8vKeuKIZOrSvcn
	BHBH7gqm+Mu+UuUojAUTgecwzvWq+y278Mh8GC4yAUjFjo0LVZk8=
X-Google-Smtp-Source: AGHT+IH1CcAu0+oQSLVCvod6ENKuThRGNhzp9I4Ruu7kGYuYhFS9l/UWlmOUACFHt1dEqWcwkjjoiM7kgDFXTRLzerM=
X-Received: by 2002:a05:6102:f11:b0:491:1e5b:8a0a with SMTP id
 ada2fe7eead31-4977bf58f35mr3179941137.4.1723905182011; Sat, 17 Aug 2024
 07:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817142257.14470-1-aardelean@baylibre.com>
In-Reply-To: <20240817142257.14470-1-aardelean@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Sat, 17 Aug 2024 17:32:51 +0300
Message-ID: <CA+GgBR-ymOVRbPgKcWDprduUwaBbDD_8aBc9A1qH-bz_FRe6Ew@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de, 
	gstols@baylibre.com, nuno.sa@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 5:23=E2=80=AFPM Alexandru Ardelean
<aardelean@baylibre.com> wrote:
>
> The ad7606_scan_direct() function returns 'int', which is fine for 16-bit
> samples.
> But when going to 18-bit samples, these need to be implemented as 32-bit
> (or int) type.
>
> In that case when getting samples (which can be negative), we'd get rando=
m
> error codes.
> So, the easiest thing is to, just move the 'val' pointer to
> 'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
> preparation for 18-bit ADCs (of the AD7606 family).
>
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---

Baaah.
Please disregard this patch.

It seems I picked it up from an older working branch by mistake.

I still need to learn to use this new b4 tool.

Apologies.

>  drivers/iio/adc/ad7606.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index dba1f28782e4..35b2862c3928 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -138,7 +138,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, vo=
id *p)
>         return IRQ_HANDLED;
>  }
>
> -static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch=
)
> +static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch=
,
> +                             int *val)
>  {
>         struct ad7606_state *st =3D iio_priv(indio_dev);
>         int ret;
> @@ -153,7 +154,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_d=
ev, unsigned int ch)
>
>         ret =3D ad7606_read_samples(st);
>         if (ret =3D=3D 0)
> -               ret =3D st->data[ch];
> +               ret =3D (short)st->data[ch];
>
>  error_ret:
>         gpiod_set_value(st->gpio_convst, 0);
> @@ -173,10 +174,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev=
,
>         switch (m) {
>         case IIO_CHAN_INFO_RAW:
>                 iio_device_claim_direct_scoped(return -EBUSY, indio_dev) =
{
> -                       ret =3D ad7606_scan_direct(indio_dev, chan->addre=
ss);
> +                       ret =3D ad7606_scan_direct(indio_dev, chan->addre=
ss, val);
>                         if (ret < 0)
>                                 return ret;
> -                       *val =3D (short) ret;
>                         return IIO_VAL_INT;
>                 }
>                 unreachable();
> --
> 2.46.0
>

