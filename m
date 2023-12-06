Return-Path: <linux-iio+bounces-694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B144B807C04
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 00:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C1CB21103
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7662D7AF;
	Wed,  6 Dec 2023 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="On4B+CtU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82307D71
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 15:03:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so536341fa.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 15:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701903836; x=1702508636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpugzumtfwbHDRyz7yZgjaomjK2XJvkU/GrRyGvcb3g=;
        b=On4B+CtUZ6ZV+/ESJyD5J9N7JCOun6EGml7/QKfHqVLX+GzoLpC5gRIXC6P6pR+Z7E
         yc2fYyd8+1zrAaCxH9Z/RoaHF1rksWt6R32uSU3ByHYo9xwB2vMjE+t57Ckj1LDkt9Pz
         9Vpqlu9w/rUTtPGIE6p5zkgIYWFnG+IQ7DBET+IHMNpazn2Dc+mV0c21CLkTkX21gu1q
         sPV7d+ZWvVk+uLgoJ1mFN6tJx6b9TVlVJkQ78QeZyi5s7zcCqQ0lWIFwl57wr37tLOrx
         eOXPuLSradEac69Op3fUMuAQ3CNkcniKfSwERjIXiUxkPogZxOL8dUD9ZtdJgE29iEkN
         v5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903836; x=1702508636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpugzumtfwbHDRyz7yZgjaomjK2XJvkU/GrRyGvcb3g=;
        b=f43bd0sdlr6YAJZGyscwepf2Dis5+6XuM57aYr2tSKa92kw+OkUgCfGhOQNHeq1jPi
         aNv7nzt1exlRUrHg1QiPdT/Y8aSdTQW+W2hDRyXtyzFSIGAUAeZ5oqUrecPWh3VpB6UF
         sr3j3TErhzCJ0YpmZK1g4V9dOoIckNpZSktxu6OxX1rutVQAdXbqjjT3vp61edwNEP//
         7qMuCpBElOyEbhmzMEDEV8CknSXiRJjAf7lVpM2dryuk4IJRLWfz+diTDufjQlKU66fW
         Ziiure+9sp2DFoajrJEM0pr1GVoB2iYiM5G7JRkH2UWP68naaVg/f3GDBhNwA+8eNu5l
         HICA==
X-Gm-Message-State: AOJu0Yy5RQtYgHgTQ+gcbcTEymQb9cQfmvTHiYxjmdeMpzIqEWHBMSdt
	+XROwl4cidZXTkq1/CBSMHZPC9uWz51OlOxYQYZbnQ==
X-Google-Smtp-Source: AGHT+IE3Ij5kDItRZ/wChBzv6mKit8o2hN9AWYbcRQnp/TNANLPg3hD7vDEaqA4kSpmX9I52Ejy4fGXkt+Yja9jcue4=
X-Received: by 2002:a2e:9043:0:b0:2c9:f781:3015 with SMTP id
 n3-20020a2e9043000000b002c9f7813015mr748967ljg.71.1701903835784; Wed, 06 Dec
 2023 15:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-5-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-5-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 17:03:45 -0600
Message-ID: <CAMknhBEOuaQir4i_aFUeRN4pznqjTwG=MC-VJ=+Oc4oEfUGJnA@mail.gmail.com>
Subject: Re: [PATCH 5/8] iio: adc: ad9467: use spi_get_device_match_data()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Make use of spi_get_device_match_data() to simplify things.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---


Reviewed-by: David Lechner <dlechner@baylibre.com>

