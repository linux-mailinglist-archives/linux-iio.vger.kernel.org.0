Return-Path: <linux-iio+bounces-6396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84890B400
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A74F28D7BE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2415F335;
	Mon, 17 Jun 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igN2bocS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1015EFB4;
	Mon, 17 Jun 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635394; cv=none; b=OC2GX0bFrac3Vk2YkPFL94u/9WXub5/VrBGZfxek9WK6W+jDWFEHkGx0Qe0ACext3rCJdkfdNyb9Yi/UdBCsI1G648XFNHw7YcvY9UB9n87sbXS1ylZWzNummGxNdmEE2YljloZuCBn7C6yv6LbLXmjS7K2tgabe+KeqfWvH29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635394; c=relaxed/simple;
	bh=ZBRYz0XGpXpv2eraO3GUW2itTwP+yglswHfa4pbL/RI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PF6zHVMKo2PJ75To+BsXFhVBQ/rWup9CahFyO8nMQmCAHW+efLbKPPKKXNrmgrKCoHjvAeOIw7eC2h7YNGfgHWO76+1qAU9QNYHdUwwgxqLK5EKk+z7wyOSK15FswZtH5KII/2DFAnFfQDBc7xu6k+mZHvgwTU+IXfACAvfpb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igN2bocS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c7ec8f1fcso5195571a12.0;
        Mon, 17 Jun 2024 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718635391; x=1719240191; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBRYz0XGpXpv2eraO3GUW2itTwP+yglswHfa4pbL/RI=;
        b=igN2bocSBRRfIr7hIapYMqD3Irl0IAfgBU2AiDMcwTkmRUrpSfKKF0lWcV7KaQ/cFG
         wybYpCrAqxGW8FBXAlPjMNEPLRhSG+SvaPTBBCesbctTenomeUU55dQXJW8x5rBcdsxp
         jbvs/xfGr/xU0YWQGlS0I3yYXthe576c/dVKWQQ5ASX6iVCJ++8sLG7E6olqGeUIztqu
         mzRyI8RwT515z59UCDiGoLNFx6KGX2iI9eIDDSRK6N2wtQOR/Ca0nkyPqFGS/YaM64UC
         VxWEiUjtGHNsbU4lXUv0hjlpEBmLarVDlrgKxIiGX0dN/5w3jkmdMf9YUtrr0ZnKO0AT
         fvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635391; x=1719240191;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBRYz0XGpXpv2eraO3GUW2itTwP+yglswHfa4pbL/RI=;
        b=AHcH5V5cRNuCm8zGYeO4OCMoVjvuMHFqsSChDXRqc8gJo91O9/Hiv0hl2bg4V73v0s
         tndakByKwjd2CoO6nglXyqZQtJf6qFsfL6ADjC+W4iUEhLmoWsqkXaDMaPaswj5/l4G7
         OFNUCjATV48hFi5Pz9WVpdI5j1fObKBzYM4TyydPkKRkJQO84jrhEXGH+ofww1z0NLcP
         uKINMNMj9kQAjNTxF/tl5BjS3R/mRUh2hZHHNFncjREYa35DzEUnYlaqbvIns03HjeM8
         e1YOEJbFMOO/4NhJuOweYSF1RGeryyaHaohPfDT3s1JmfBaQzMGwRFrMNUbg6Z27sB83
         LNnA==
X-Forwarded-Encrypted: i=1; AJvYcCUPKmIcGnWrFG5xCkf0kx6GtFwo+2a3WY346uj2MKWUxkIiuHJQ+xGXZ8zuE8x9/ryIyMa3gGzBDANO0cv4Do3EnxFLIWQ+sSOhwWBsv8vN7e6QmTm1VHWo1cfeRoYDd3A1A1Pmgj5R//UbPw==
X-Gm-Message-State: AOJu0Yw+WxQcsgEYfoxEXGymxxTcOndwfLdhFhQ+FSKFzVkHy36fBZP3
	rA/yLMN55p7Xkm7U5TfhX6XyRsXRDZPjZWHMhT2kx6cNbIvBIaiD
X-Google-Smtp-Source: AGHT+IFZCLJUyzlf8fNXs1wSr7SW5vQG+3gjx8K9mMt6pzU9bVkMHLl1SBxe9dWS51TWvl5kQfUcKQ==
X-Received: by 2002:a17:907:970b:b0:a59:b590:5d71 with SMTP id a640c23a62f3a-a6f60bc9ac8mr839107966b.0.1718635391235;
        Mon, 17 Jun 2024 07:43:11 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f427a5sm514062766b.180.2024.06.17.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:43:11 -0700 (PDT)
Message-ID: <63cd8d0e250a77c1201945ebe13e19ab0fb59ce9.camel@gmail.com>
Subject: Re: [PATCH v3 19/41] iio: dac: ltc2688: make use of
 regmap_set_bits()
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
Date: Mon, 17 Jun 2024 16:43:09 +0200
In-Reply-To: <20240617-review-v3-19-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
	 <20240617-review-v3-19-88d1338c4cca@baylibre.com>
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
> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
>=20
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


