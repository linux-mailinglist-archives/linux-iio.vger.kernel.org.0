Return-Path: <linux-iio+bounces-7199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83DF92539B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613FA1F2402D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F11304B0;
	Wed,  3 Jul 2024 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ggnvmxVo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024385934
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987922; cv=none; b=GplKeog0laIo2RDXR6a5H6qPP4U9r+pEJUwAMLOKU+pc5oU/aq7KFsiilwlT1zA2tnoVFTXcMkAp7YEk+2QsuTkoPgeUlwxvfhQRe4fYQUl60f5tYfQ3Jukou4JRiTSYWzELoiDU5clhhtSF+on1tuvtoTmqTmcW27Tc/P1SlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987922; c=relaxed/simple;
	bh=SrLTe6LNmI2Qy4X/PzXDMolrYFHBCUpGkJfFvmvRLIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pu+GnRC3q0GzR6v6MWtqst+4wFBKGV6HEI5yaq3QHEwyMHG1R53ZVzlHWRdwWVbNTKllNgCjs+GRqeQe/cgh2SDHjRXrbSCmIRP79CCGa/w8BJuC6Vaxm72N6PfyNWVBTZB+jgMccyiRN1oopB/+mBf/piB+pG6Skh5/gY0YxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ggnvmxVo; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4ef5857899eso119966e0c.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987919; x=1720592719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvgJF+jSfrrN97GOeIPVuJO7l3DhQ7LOCIyaWiYq2PU=;
        b=ggnvmxVor2cB92+wqiA+H8QEkhVXiHQVQfNkjtmG9U8SCenLwx8cKujJyvg+F2xt48
         OOcQG9xLnYnLZwBV7wiFgDphUujAf6lQXgGutEoiMa9lypUN2QUEc5K58dAYtqv1GMCP
         Gqeye/aAbP0Ww8LaAAtxZCIKUMo0+FznzQVSSvF0kqMmqSA/lFFqjLSfnw3CSAEIeBYb
         UY+so6slLLL2kzCW1/wrCvtOyV6lgtfoAgqiOmbNzDNor6jZZzYkatQS7j10quAYOLFn
         gz7BIKRJF5Y+Nkw5wu8k9gW6rv9z6lirnVbTYQLfmRE9i0sPyfjm5Y5HReEzwHqSdpqd
         gBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987919; x=1720592719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvgJF+jSfrrN97GOeIPVuJO7l3DhQ7LOCIyaWiYq2PU=;
        b=mmU7W0jO16Vm7WldvPpP4QUNW9g+JKZNdn1KEOMenRzVme5PgDayXp6L/o8u+2uUNW
         OzRIwMgrGOy0ebWo8zt8Fs3HdIovMnL0F/leiKq9/zUx8Hm6CKaAWhvqaLiiLb5zjnIZ
         H7n0k563FyE5yIC548mswtzfoyf5zZMAnTY5w8wfo6yCsAXFuEcsRd8YKqypVmSEITCM
         1+Q9GLmyMvCH/2IidCuwOKihNTrpZukeUIjG6o1jTkUtiwQbQc/jCiqjB+1omYY5IM++
         vIShTdTUAw+8ylxse7w33w09fiitw3nTPv46eR2fTnZP9l4T46r5hIQimwyx/MCRZnC1
         vcow==
X-Gm-Message-State: AOJu0YyqWYD35HIIk02lA7kcMaHW6zk28W69Gy8FOX+2wPE5XjdDe/X7
	2uLga4TUeJMSBDtmHffSKfANgMa3G7PKo3nzJ/eYemZbeOgBHjBGoIxswHGfOcz5FATZlTJfwJ+
	Bz25J2KI/nfS/Qkr6sCgGQOLjWyHaHcPKEA6lCA==
X-Google-Smtp-Source: AGHT+IHYNLQvtj5+CJIO/cfA6L9JD/1DgDPWhTVKUxMwnEjcfHfpgCjYxSNosU5sdlNMpwJkZNpkosw7ioo+idsbx+M=
X-Received: by 2002:a05:6122:698:b0:4f2:e302:4577 with SMTP id
 71dfb90a1353d-4f2e30248e1mr451020e0c.1.1719987919481; Tue, 02 Jul 2024
 23:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-18-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-18-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:25:06 +0300
Message-ID: <CA+GgBR-Xo97D7vvgYGJckHDXwPfqdTeDDysgdFNUe9+myH+8Jw@mail.gmail.com>
Subject: Re: [PATCH 18/20] iio: adc: at91_adc: make use of iio_for_each_active_channel()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:03=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there ar=
e
> no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/at91_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index eb501e3c86a5..af4b0224076f 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -268,9 +268,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, =
void *p)
>         struct iio_chan_spec const *chan;
>         int i, j =3D 0;
>
> -       for (i =3D 0; i < idev->masklength; i++) {
> -               if (!test_bit(i, idev->active_scan_mask))
> -                       continue;
> +       iio_for_each_active_channel(idev, i) {
>                 chan =3D idev->channels + i;
>                 st->buffer[j] =3D at91_adc_readl(st, AT91_ADC_CHAN(st, ch=
an->channel));
>                 j++;
>
> --
> 2.45.2
>
>
>

