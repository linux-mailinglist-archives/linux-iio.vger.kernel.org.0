Return-Path: <linux-iio+bounces-4856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 435618BD6F4
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 23:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC41B2200C
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295515B990;
	Mon,  6 May 2024 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OjEorXMa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9B15B969
	for <linux-iio@vger.kernel.org>; Mon,  6 May 2024 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031921; cv=none; b=WYqnGE97jkmpGS+6MHv7WqvMbEelwfVqhHk3Hp3AsneQfIwE1WxtidawRO/33b0EopecCUw66YQvk2SEPMmkaLjDFv9AFWnsabAdSiiYl3TluD/WxRt7pMGQg39godvcT8m5lmfn31CKfJOrkK+XrMZfUfq/0YLIhtaKQd5mQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031921; c=relaxed/simple;
	bh=9nKNP/JM0dWgI6v7o0YUrp4gM/DyjT1WXWmXfCzYL5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPy9ds3Ru9+UgNfh5iH8U+GlFCMgD4TPV9kMFdgyZStcGycbFoLchNVTYJ3NcBSqhgarWdv3nmD18MqAVD3iN9GKAd1rElZCcg5L3KkI7K+u7Pgc2pqiv4ScrSIMN/XSKKKBR2Yw1lZz9dw8lqaID1ww5CrtcJpvIvEr+vqWJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OjEorXMa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e1fa2ff499so38861591fa.0
        for <linux-iio@vger.kernel.org>; Mon, 06 May 2024 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715031917; x=1715636717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3WVWXkWLEwrmQS6sLqWdGbxzbgxAi62bz5w3Px6ThI=;
        b=OjEorXMaQZXFqYTDMcwG5FOAnXFZACt/Gj4FS1pngjgiWTUZs/O8IK6Ix+b7pvWa8m
         BUlE1jzn2fswEW3SYE4ynefLO5g3pLjTZSWC6af3CNsOP3G+dMfVIcoHfTMqcw23H1IX
         QqIizwMz5lZ9Jwo3KsXI3wkMibFY7MhZBuKDWNxcuS/6hOeB/RRPcNxBQUzzcUwjoHau
         7kgXj31F1osgMIkAXMF08MRbTxhop4yx5kA2Grje4WYT4sxIiG3ffuKNwnJTOmtXB+By
         hXYC1UpNMfNprcwPrHrT5en7mH3VxGm/w0rZ+ObH/UEiciFdFPYiiGWoJtiCWC0d0gAV
         K8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715031917; x=1715636717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3WVWXkWLEwrmQS6sLqWdGbxzbgxAi62bz5w3Px6ThI=;
        b=l5Bl7GhY8mDcwUd7pnjlv/B9wbtwOP8ajz1w/Hj9nNZd0nLe431i6JOwni0Zunk/yF
         s9/UQ8D7ya82I26mEVlkvzZs3bySg3WU38DRsk0yXJqbAW4BTCsh/IaLk1UTOzkAzYWN
         yIs40/ie7RtUpqAws197wcEBlLrlgyyY04siOLuy9kv1bSUMU7B0jC/uHqE66l6bk6be
         NytqeWwVyZ0W/Ikzj9Lg22imGR/BYROY6tdw9s931IBy9d+YqkOXCTGBynohpWyJH2tW
         cyvWwIJsm/JeUf4uDcXu7CCeixF61ohgIL5k8wfusJ5tIbqbQ6xuBgKUR1/HnFgWDnTs
         EZxg==
X-Forwarded-Encrypted: i=1; AJvYcCXr10jc0NvSH3Dti0Nf+XbD8lyOLR5DQMMI3wyCAK1pOjZhq1t3SNfsBJ0/FA1xS/lygSoS2+By76ZWUIfR0Pqlrev1ChgdJMxk
X-Gm-Message-State: AOJu0Yy19d4NocasL4TWmh+GMFulQHVO8vno2tG9q6/J/3f4vK27a8Vu
	9ASXe4hoGM4JkyzRKtPaN3LVuDA77R0zJFwvCwXkf20hbuAbbuSsEOkLm+9h+Irsza6GBhJ/m/z
	I8MYs2eqpZUIDxZca7SS+cSzn5R4GJw0hyHb/Yg==
X-Google-Smtp-Source: AGHT+IHsd5XtD0FymUqVhlLIsycfw7wyHM4Vf5doNVrCN/vA5jAhn0ZKKZMpPmFsSPQyM0wqdjgpjwEXJu54QhmYwo4=
X-Received: by 2002:a2e:7202:0:b0:2e1:a635:4efc with SMTP id
 n2-20020a2e7202000000b002e1a6354efcmr250821ljc.14.1715031917296; Mon, 06 May
 2024 14:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com> <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 6 May 2024 16:45:06 -0500
Message-ID: <CAMknhBEFdCMHt4-iDhNA2S3KpT=EYX53gDQjnQAu+Ph-gzO7GQ@mail.gmail.com>
Subject: Re: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for resolution boost
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 9:56=E2=80=AFAM Julien Stephan <jstephan@baylibre.co=
m> wrote:
>

...

>
> +static int ad7380_prepare_spi_xfer(struct ad7380_state *st, struct spi_t=
ransfer *xfer)
> +{
> +       int bits_per_word;
> +
> +       memset(xfer, 0, sizeof(*xfer));
> +
> +       xfer->rx_buf =3D &st->scan_data.raw;
> +
> +       if (st->resolution_boost_enable =3D=3D RESOLUTION_BOOST_ENABLE)
> +               bits_per_word =3D st->chip_info->channels[0].scan_type.re=
albits;
> +       else
> +               bits_per_word =3D st->chip_info->channels[0].scan_type.re=
albits - 2;
> +
> +       xfer->bits_per_word =3D bits_per_word;
> +
> +       xfer->len =3D (st->chip_info->num_channels - 1) * BITS_TO_BYTES(b=
its_per_word);

This needs to be based on storagebits, not realbits.

> +
> +       return bits_per_word;
> +}
> +

