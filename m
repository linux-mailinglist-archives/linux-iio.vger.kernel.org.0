Return-Path: <linux-iio+bounces-6395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4653690B3FD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF3028D3CA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB815EFDC;
	Mon, 17 Jun 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTkKl7Go"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ECB15EFB4;
	Mon, 17 Jun 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635349; cv=none; b=je8qgWvhTJMoCkbByTX+faTvnbfK3jK+4j542i6zcGh6BWe+gih6nPuGt7Ep0fcl6QeXjceQ3J4NU3fQNUbeMFm8FavfdhVS9NKm43YsGBTrUyvv8L+ig5qclohKtVfinx5URB3LQVvXnXgObRsNq0YQdhyDmW+02bhQBH4YTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635349; c=relaxed/simple;
	bh=E2YQNX6Tuz8HfUHpOihGxh9fyCb+mnp+I4qgACuBpKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fup+BB14RM6fq+v1Xn+ASJp346Nh9D5m8G8cYlqALdoxjf0OYm5B6H6BkRhe1TCxh/nqvkbL15kOQMvUJV9KlQpTHR4piqEoXPJ5rmvjRDAgsDitULVSVlBmzRHAKT+HZSSZpUCASZRhFqXtXvde/vM4TeXGes7WWnltSpB+gcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTkKl7Go; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cce3bc8c6so2410138a12.3;
        Mon, 17 Jun 2024 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718635346; x=1719240146; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2YQNX6Tuz8HfUHpOihGxh9fyCb+mnp+I4qgACuBpKE=;
        b=fTkKl7Go+98ESLVA+cWR/43Utnpy63+1wqWUZTjs8nQuY/6RO/2dhf78J+R0YLj24Q
         0u2mDZLuBBOjPJvOCwy7WaseAaHrxqR+DIkfqbAFuu5ue9yQwznuo/9/T2RI3VR7gBD7
         /tR9/d/yua4JC76k521xKY1GJp9XqMcWHwiMlwmMzrFEeEuW59xX/lsdKNqNU6yUeWLr
         /dKk+uFdB3VMhbc7B23TuauMw4Z4FJi+VzdYMQ1gpU0/m7C8KVpc2O8vqCgfR6Gj4+6e
         ypaWb/jdEF6JkugGrYH58haLkyr5KUxOJq/gKNWXA8z6HMAiIoscMlhjt6tTk6Tt1lLi
         BAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635346; x=1719240146;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2YQNX6Tuz8HfUHpOihGxh9fyCb+mnp+I4qgACuBpKE=;
        b=SreACyD+L0cFlxcaB81kY2+NjcyayBs6gHNh9jyDeAS/40oJRpSdSmPtjeUk5DaUav
         gkATSOFAQZm2Hg5dImcZ+XBpk6p7WVbYz9Xpf/zPAic5wFABtO2+3a1CAArOdCZS7r8t
         dHCBeAZtbBcOLHvtaWVNjLUvstUS8h/4a09M/W5/KB+igTQeH6jERVTUVLe+jrO/yxSI
         C5dAb7MzVx664NdJG5h8KBuZxOkr3xg2Dax/FqUM/G8zdnQ/D8NRkF0vI8Ds+tP63iL1
         tGkqXNIzZJWHRmBHCOtDSyXYCmAUgtQViTbqEDBGo7yTMHQKV7pFwOUexb69BK7TtN0T
         p8uw==
X-Forwarded-Encrypted: i=1; AJvYcCXSSfzEpSfy4BRJfhiC/SKDa7RnI8FhDwdnJbGRzGGpeJz5hbTQt+l2SdxG/na3vKmK33SxrMOdAHJ3x0vLjNBd58JdmuY136Tp4c+psdskdbJruz5LviGdJXkgmdCnupxBvHCCi4e3/JiMtQ==
X-Gm-Message-State: AOJu0YyCP4MfHnEPorB6DzKZni3VvEEom/os0ORJRAhzKGKZooGbDbQK
	6RDhELVMY+PBD9wF5v9l3iPwWt203xVlykp4OJMAdPR5RlKWGe4W
X-Google-Smtp-Source: AGHT+IGkzpQ7qdmk73JHhNvar3yzbeO/0JuLTETghlv9ovmWg6RAvgWc3MKokHO04h0aGO4cAJzoZA==
X-Received: by 2002:a50:8753:0:b0:578:6378:bc4 with SMTP id 4fb4d7f45d1cf-57cbd69d997mr5941494a12.10.1718635346075;
        Mon, 17 Jun 2024 07:42:26 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743890dsm6514525a12.83.2024.06.17.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:42:25 -0700 (PDT)
Message-ID: <a818344871a1dd2bf139732a7de9016ece456288.camel@gmail.com>
Subject: Re: [PATCH v3 04/41] iio: adc: ad4130: make use of
 regmap_clear_bits()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Lars-Peter Clausen <lars@metafoo.de>, Dmitry Rokosov
 <ddrokosov@sberdevices.ru>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>,  Chen-Yu Tsai <wens@csie.org>, Hans de Goede
 <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>,  Scott Branden
 <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Saravanan Sekar
 <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Linus Walleij <linus.walleij@linaro.org>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Crt Mori
 <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Date: Mon, 17 Jun 2024 16:42:24 +0200
In-Reply-To: <20240617-review-v3-4-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
	 <20240617-review-v3-4-88d1338c4cca@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 09:49 -0400, Trevor Gamblin wrote:
> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>=20
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



