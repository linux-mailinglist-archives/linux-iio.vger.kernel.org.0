Return-Path: <linux-iio+bounces-5744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5388FB09F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8442F282272
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0463814532F;
	Tue,  4 Jun 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyBW3uB9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A118144D2E;
	Tue,  4 Jun 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498545; cv=none; b=iho8uNE7lq151a7S4CCj/UEcp9BbTcTdWo29H4Rxg9rut+WzfQ+XuNbXoVF8JWUNQd/SmYlV/wV2a3PQz5ePAYBhQlU7kvaD1XRexCp9tweqJb3ipnU0RP3dQXeDfERLasib7EviKBlt86uZ+w3SREgJ5Ok2G+tyGiJQPGhjft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498545; c=relaxed/simple;
	bh=+qlsn2D0Bl9bAT/zCHb1kX2iWwIp82kUn+lzQwccsqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK2CP7J54jwkxmwx0FedgJVz9Pz1+PUe7fuyrTGJF568BQ8Ne+1wseYh0p/mls3JaSrPhm62U3tEXy5IQinqbJMuOP/o+QyvI7Rt4dD36Go3n9oKan5GnFZPUWmEpKySiY4VGx2c76Ax56+KNff/f5ffNXRwnVphNyZ9K1uslUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyBW3uB9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a85cc2d96so457742a12.2;
        Tue, 04 Jun 2024 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717498542; x=1718103342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDj6XyLMkdypUs5XebPk9O6Y/tAg4OP0rl7m8sDWpro=;
        b=WyBW3uB9G4oeSv/fUK4tP/WdFdoXUnj9zlnLu154/k7HfFWdVJJX1zo5h3JQfcbeec
         n+AgfiWL4KCvqtapKYLp7jfr+tpdsinH8TSNjcx7apuNU3kyC/xHs6ubvOeJunzRGel+
         nuw8+Q0O4kEwdm/47+X7Agg1ImEyHEgYQDHwXLSxsVCJFqcY9xogRqfNwVhWG0u0SpMN
         DYQiQs1Bhu+2IrbyJGLpcOXQRmOfICPu7bSpBJdUP0ihSqFsBSKBMk9Vd1qzjFO7OvzQ
         JKKlrNm7WMqcRwM7hiWSjaC81Qq/GBv3hW7Exptsotk+Y6D/HYfwQnwK9vRqTeFbo40c
         Ka4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717498542; x=1718103342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDj6XyLMkdypUs5XebPk9O6Y/tAg4OP0rl7m8sDWpro=;
        b=BBdRo4tBoVPNA8TehchHXyzq5h6Lj2Pw4GH+WUAeeSX+aSuGI/q5/+PRPynMY61xPF
         8sTN0R4k8wNDovG2c11doYNFRH3gFinU+OyDie+yQYFYpEJ7/W/IGlGyuGc4w/Q8JPJv
         pQFYdO/DctM/FKX2xCAEUDPG/rkGEctfKBDgJZkYgSXxhg2S4RxCE2LgtLatePhTPIXW
         9VSzqtR7omib2AOKVDsGnGIwdgpEIu1yl4OslKKFM60YgUy5Z8PaCRS++jwCZ0nbzOn/
         HIAfkVgyeNjp3xh7n3pkkZ3XmPSK7mJPe+zOT1/vPdj57pcS1eGlEXLnoklcgGH8OOeK
         Yu0w==
X-Forwarded-Encrypted: i=1; AJvYcCUeN4jZIVM0cM1Hywq8kegPrqxs5CMDwiiBln8M+FL1uwF3yTVBO8rC7qWaYrRMAFW9GKCHuROkEk1ooNVD0754B+FGZ+U+AMbxycpXRSE8q8OGkZkOoZnDmQB7VrRs1rngDp9WJ97xGE5AOhvvH4gd4ZaH2+WtLZ3bF5zZMQn8FzLWXg==
X-Gm-Message-State: AOJu0YxPxpgBpUUOTVhQi02DgusyJp0ksbvymiTzsATGhpuzWlXHQwgm
	Ew6O1zHMilmIubIR7KG2vOnN0pvjDXfyh6O0nXoe9pNK/KY8WV9LBOXO9x1OEnLGdIrgpAslTeI
	9sRmDfq3nqNNzDUyCICRaALZsxhc=
X-Google-Smtp-Source: AGHT+IFmZt6Y9UJZxMqsQKH1greIZFtT4Z7hrqbjSEJ/dY7Mmt/YlBYihOWjiM0e7kzDgcBKFTWWMMLnuGmhwMU9t2Q=
X-Received: by 2002:a17:906:6acd:b0:a65:26dc:3c25 with SMTP id
 a640c23a62f3a-a6821b71ea0mr796196266b.54.1717498542174; Tue, 04 Jun 2024
 03:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
 <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
 <20240602111141.0058f39e@jic23-huawei> <60e55919-2a8c-4d83-89a1-6e4ae156d34d@collabora.com>
In-Reply-To: <60e55919-2a8c-4d83-89a1-6e4ae156d34d@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 13:55:05 +0300
Message-ID: <CAHp75Vf5a8VVyOXQRt9P1QnM6GHZ3rLuvnBF63H_83QBHOTJ9w@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	marius.cristea@microchip.com, marcelo.schmitt@analog.com, fr0st61te@gmail.com, 
	mitrutzceclan@gmail.com, mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 12:42=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 02/06/24 12:11, Jonathan Cameron ha scritto:
> > On Thu, 30 May 2024 11:34:08 +0200
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wr=
ote:

...

> > What are IMP channels?
>
> Honestly? Well, it's called like that. I don't have any clear description=
 of that
> and not even datasheets are unrolling the meaning of "IMP". So.. I don't =
know.
>
> What I know is what I wrote in the driver, and this is:
> * IMP has IBAT and VBAT ADCs
> * It needs different handling from the other ADCs, as shown.
>
> ...and nothing else :-(

I could speculate with confidence that this means IMPedance (since it's ADC=
).

From MTK6329  datasheet:
"The hardware also includes necessary modes to allow for simultaneous
current and voltage measurement
which can be utilized to estimate the battery impedance."
And googling in vendor trees also suggests the same.

--=20
With Best Regards,
Andy Shevchenko

