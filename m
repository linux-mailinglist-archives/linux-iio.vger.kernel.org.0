Return-Path: <linux-iio+bounces-1512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F39828B94
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 18:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490681C210CC
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF43B79C;
	Tue,  9 Jan 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FyN5zZvd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A638DF8
	for <linux-iio@vger.kernel.org>; Tue,  9 Jan 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccae380df2so35467701fa.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jan 2024 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704823018; x=1705427818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir7X5a3V1krP85f23EP+v6GSCmGNRbcVfuSwLprNqFc=;
        b=FyN5zZvdKpSf7UjdCJeCu9pkEZIgpZqa5cVJnwiVbyR0KmIIMpR2psn+m9rdw3gvsA
         4jlZkdeEowXysPrcXobo4rhxD7X1hgvffG6cGoYX7WF3wJVVNl30B1OsnundZmfoGsDC
         AF9z7djC8TiZaSuOX+MfRkoj4DxSrnMttOUIKJ8XSUFAa6zfzZDLuxieBjyLHAnDlQGX
         aa06QMFHHD2WeV2c+ym5wuQZK9W/IMmgMdKk6C5+8hcJsFJ9bDFd4LAYMS0/og5HsUIq
         R6Ri7kL5ThyrCzoCnVcA32f/+DDttyaZ/4+6SiAvcscyMo24W6emR6x4Q7zxOn/rNr5i
         pyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823018; x=1705427818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir7X5a3V1krP85f23EP+v6GSCmGNRbcVfuSwLprNqFc=;
        b=qRfIpbk7OsGdYYng/Tqo1Br7aNcAJ8x9zmgjsP+dNcZrwfW+udP+wi2YheuxZOfUTR
         pP+bEQ8iKXVk47N0nmzU+yq0XsUyvb0hVTsx+U8uBrGaSt9TyJwl5SiCa5T1NheQdxOu
         VCvpCMMedS+UL7bVp/9MGFrL+6eM+BZs51owyc2V4f56ZThA6qwErsW2rd6NMqFaV1ca
         LO8w5iAI9Xa9vkkDD2QoypQN4d/dgb04mzoHaFEwRtfzpPR2lSWe/GAldvc/Pibyg5hZ
         fCf4m/r8Xj9+BJ4ag4f4C8fy9WatMtUAdjFb5xrB9PeSe7pFmNgxHDTwLokVM8fDvsbK
         ShBg==
X-Gm-Message-State: AOJu0Yz0uyYnaOhO55nzViEompkJD9iVxcIGjtJq1roDzLCV+TBDy7Tp
	aJLwjXEDVF6WrLD9WlinzFyC18v0dMJnEFo9f+O+rAhzDf3uZZuC/HwELoxe
X-Google-Smtp-Source: AGHT+IH7ZZOoIpO/4InB8njqMgI4oRwNszPhjfX/Amw/XzbuLsQRFWEL0mT/kboiYAYqlHaJltlT9lnTIfzuRBGiRYw=
X-Received: by 2002:a2e:8ed7:0:b0:2cc:e9e1:e6a6 with SMTP id
 e23-20020a2e8ed7000000b002cce9e1e6a6mr2700972ljl.92.1704823018085; Tue, 09
 Jan 2024 09:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-dmaengine_use_device-v1-1-1cbdb7fe9f29@analog.com>
In-Reply-To: <20240109-dmaengine_use_device-v1-1-1cbdb7fe9f29@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 9 Jan 2024 11:56:47 -0600
Message-ID: <CAMknhBFUeAvtXorP+H_1Yqj4nJyqrPoqnAae5FOBvLCZ9SNVBQ@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer-dmaengine: make use of the 'struct device *' argument
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:47=E2=80=AFAM Nuno Sa <nuno.sa@analog.com> wrote:
>
> Respect the @dev argument in devm_iio_dmaengine_buffer_setup() and bind t=
he
> IIO DMA buffer lifetime to that device.
>
> For the only user of this function, the IIO parent device is the
> struct device being passed to the API so no real fix in here (just
> consistency with other IIO APIs).
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index 5f85ba38e6f6..45fe7d0d42ee 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -279,8 +279,7 @@ int devm_iio_dmaengine_buffer_setup(struct device *de=
v,
>  {
>         struct iio_buffer *buffer;
>
> -       buffer =3D devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
> -                                                channel);
> +       buffer =3D devm_iio_dmaengine_buffer_alloc(dev, channel);
>         if (IS_ERR(buffer))
>                 return PTR_ERR(buffer);
>
>
> ---
> base-commit: 3f4525f924e21d4f532517b17a20ffa5df7c0db7
> change-id: 20240109-dmaengine_use_device-853f196ec78f
> --
>
> Thanks!
> - Nuno S=C3=A1
>
>

I noticed this too but didn't get around to fixing it yet. ;-)

Reviewed-by: David Lechner <dlechner@baylibre.com>

