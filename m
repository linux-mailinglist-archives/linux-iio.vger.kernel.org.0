Return-Path: <linux-iio+bounces-6188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED4904E33
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 10:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7931F281E6
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E67167D98;
	Wed, 12 Jun 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="RXtpudb5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFA16C86D
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181260; cv=none; b=te5mSDIqNsNupodS3oSKbJHfkFDaIlLH7Nt2fbZBou6R8qLtjqP0VqmwUmUINyMK94K62vPl3yxyNKQAH3EPMzyU6pLVORUGVAL62Z+TFGAxRM7mOF8+0UudB18Wz4z+SrX7kNBm1O6+WPW2rB4nOkHp53c/YQ6JQ6NEzzTLB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181260; c=relaxed/simple;
	bh=GRlEpNQ1vOAfspdoLRmjbH1WiL/9+2xtBIbJoKzaPig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWlGlRYqR/CKtx/rqBwiNkd9zaPWIFsTckmpLMjXQnvOPlRJLWYCx/qZOptKqEvpKMoDcsHji0zAATTXmvQ2PUMoHbY++UCu7xz8GovMMTQjz6gtkeiDvMX/ykKilRfylVupNr7X33IU7xd80eS56x7JZhY1YHHpJfmpPhan6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=RXtpudb5; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bb36de2171so421526eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 01:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1718181258; x=1718786058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRlEpNQ1vOAfspdoLRmjbH1WiL/9+2xtBIbJoKzaPig=;
        b=RXtpudb5gcux6vLZNizkC1Gi0nVRGEOvoDc844hMyv3Q++DWuwEnhSH8BbSE52Sz75
         Toz9zvItgfCkXXy30UuJGo/+t0lTs856wbTi+0d0YuoQtnO6+JL9zPF8hTUIGHulpuG7
         j9XO1cFnaFTCkSzETrlEGvRuEtBHJi8s+tTjAmvwpqP/oqOvYrXN2/gTauCcuq6Jd2QA
         Y5y3fUFikO9ii/vR/8cZwvoWf3God26upWWTcsmfya2moEWHmneKBp35Jxp18QazRueE
         or8KRbvnKoLdTtQ9KLxMb+C0wvRsXz2HjBtlTnLNvT5I7vQl20DOsy5kACXuv84mE5vE
         cZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181258; x=1718786058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRlEpNQ1vOAfspdoLRmjbH1WiL/9+2xtBIbJoKzaPig=;
        b=OcZG3K6rlBmu9HXUTi6PGE5Uy8O3joOAk5jXtmgHq+7gQ0WlQCAZ+8aF27d1BTxib7
         bkgJk6JMZYZQnnJfCwiMSG7+97S7aviKJCSke/y5bPM2OakfmWYvnfqEepS8YRB//Q8R
         avUCfD/zzLrtRoq3XSuH23WFoTMQbXZ7+y82fW9znoRpy4EIlt2oo70OQF6/sRB2mdhq
         ZTqIZ8Yj3roLADs6BYWra+2z329sUg/DJzIn+mc9b80fI1Vq/cOpWRGrJtkz/yA25fgr
         xC67hFgdaPE++wk9r1GKj9o5L5W4fL5zkOuz/suNfiRntVmg5HkspXUmpyKN68IN1VF0
         WPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlcE7aUGDvPxO48a2zzdPVVFVkqraGVHaKrASnhNuGiMeveZXclpCu5wEJmUMCFr9R+2iJLL/gZjngTl3O/e+j1AUKNlqPE/si
X-Gm-Message-State: AOJu0YyeP3wnmfJxv4xX+KQXOSbUrOI/JVMUQs1NVb35jVC0R4hJuyLO
	v92h6kzKKN8NYhshdUk5TbB7DhZFM7MQQAUhZPmaWFBf4wrt1o9uI24XCDjW++GtPoLFGH7Pr4e
	4eQ5WoMkhed2C3R8wUywoTRqHXPVu58sJ+U+d
X-Google-Smtp-Source: AGHT+IF2c1FL0fqOMuwGFXItue1Pz8K0VY5CQ9QXgEnYWVlMd7GYFa+wcDzIz9YylVcb2zSif5XgvNLrC8xGpqwxyEQ=
X-Received: by 2002:a05:6870:b625:b0:250:7973:8092 with SMTP id
 586e51a60fabf-25514ef5f86mr1113389fac.56.1718181257361; Wed, 12 Jun 2024
 01:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611165214.4091591-1-tgamblin@baylibre.com>
In-Reply-To: <20240611165214.4091591-1-tgamblin@baylibre.com>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 12 Jun 2024 10:33:40 +0200
Message-ID: <CAKv63usQDFuz9s06GNTq=3fzYm-OVPAxgxwxTNEw6zw2rYxyig@mail.gmail.com>
Subject: Re: [RESEND][PATCH] iio: simplify with regmap_set_bits(), regmap_clear_bits()
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Rokosov <ddrokosov@sberdevices.ru>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Saravanan Sekar <sravanhome@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For mlx90632 part
Acked-by: Crt Mori <cmo@melexis.com>

Thanks for the update.

On Tue, 11 Jun 2024 at 18:52, Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
> Simplify the way regmap is accessed in iio drivers.
>
> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
>
> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> CC list got suppressed on first submission, so resending. Sorry about
> that.
>

