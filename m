Return-Path: <linux-iio+bounces-7192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3937925385
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141811C23D9F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C91B61FF9;
	Wed,  3 Jul 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LbBNAW7R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71296C2F2
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987211; cv=none; b=ZIWKpzg/Zc+oJAft2BKACUIXApbkgDnw8JTu4aXU/D0fBicecnMUiqBB406ujmR0dDfWFQYk+MjXR57oLY/JtUg72FfQxGq0ypbSyxAYoXJdQlDVzwsliCj3ogXxgbIUMrwe0/KQ7sjVp6zSnIw8IQIUukRR8I1hGMwE1hoHouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987211; c=relaxed/simple;
	bh=TVhn/9aqzM8gK9S7x7lDaUKf5V6ug6GSOL7HoxXi2G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlTXrmrs8bPb92zjKtxWy2/hMs8qq6faCHSDvLVz/7zfh+8bclU6P4WoVL3q6XxLv/7Lw6vnX20CnkFaCNQDg/oZMr7KACcxcpxJ3X6G7CiuX9XoXw/k9P00FZciKeVTKDII8329Tm4SRK+ik8FhzCl4C0auCMelXGa8zHfXzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LbBNAW7R; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80fc4d1562cso200407241.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987207; x=1720592007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrh4omEoCsgnk9OB2fwqZ/ZZhUeolysIiLRrWxFuJG8=;
        b=LbBNAW7R+IUP1URLp9XHUnmfaYi3+scS7rr/VDepsRw/bPWyG1Bd5AV+nDMqcKoUGH
         GCYQq3M9qkim7jMZej5lebeBED7C/6kLTVErBhSfYGHbzq7ayD/3CTCrx8A1YAXKMyOa
         ew3VBKfdcSk7kgVXwFRRJcHc3m6SenAOkP03+1hgJtGt+K/M2k8T+kprzPaJmgOV4kQy
         dJZFMzT6IC/gy0iHNjM9Sh/lpjU3zROYHQf+hsQqFM39vbb0E9Bj5+K7M4ru+i3IKmXP
         i7wrZEfZUWgL8Sg5SC1sdEEO3crCcaSjg4VBH9tPoBXaxu3AmzhoYqHTY1iPnwY3RJS2
         j5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987207; x=1720592007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrh4omEoCsgnk9OB2fwqZ/ZZhUeolysIiLRrWxFuJG8=;
        b=hH3Vs8jvlGWmPm2vm5g74Nfp5cRBB8pj6+oTqp/XHOJosIh/i6uauZ3c/mq6yiHWhs
         OJaGqyP94gkJECvouX6VDpzJd+9uEOmzMbVjzbbgJ0mD+aWdP2aV8ohRxXoM4A5fd5Wm
         zsimxy2MwJSBm+o7JQLiRCufeCo8fONO012wdXVv7VTiIPercO32WoVnnXyJxQsmz+hU
         0jqBnOnFdMXkVyyQx0iAdj2nnoAORwTHJSNA8mVb2aWZS+3dx8EX9cJfMJbJmm7oMxEW
         iepl4N6TfVTsSielL9UdCXQY5l/VhN6ncc2yA14s/A2JbXRqK1zlq9WN3wTvWSrSTRmj
         3ehA==
X-Gm-Message-State: AOJu0YwG6jAGGRRcSOnaetP6Z9Sl2OgjM4zczA/hhyhbTsBRJx5oZgKl
	lxOadHMB95Rxe+eMT5Cxoh9IxT5kZVvWOjRq1RtSLqI5spLvk+qnfcoRGvOmC+l17/ZEudFSPlO
	xi71MsRpE827Zw0eStvkybZhAbOrYnaz5L2ZYvw==
X-Google-Smtp-Source: AGHT+IHA9tyTcp/bqG+kwwVde3E1Sqakwf3LRDVH/oAwKgHm7Oq/LYBV6T61+//W+6tik9hUgMSQECJ8b9CmdmFyxYk=
X-Received: by 2002:a05:6102:c90:b0:48d:b0a3:fe25 with SMTP id
 ada2fe7eead31-48faf03411cmr10952763137.1.1719987207363; Tue, 02 Jul 2024
 23:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-2-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-2-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:13:14 +0300
Message-ID: <CA+GgBR9ZLNJps0KCKD4Z767_NaUeKO-eiZPD0rpjfxS20LdDCA@mail.gmail.com>
Subject: Re: [PATCH 02/20] iio: core: make use of iio_get_masklength()
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

On Tue, Jul 2, 2024 at 7:02=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Use iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
>

Well, in `industrialio-core.c` it mostly helps to use the accessor in
order to make grepping easier.

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 2f185b3869495..e392a10aaf320 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1907,7 +1907,7 @@ static void iio_sanity_check_avail_scan_masks(struc=
t iio_dev *indio_dev)
>         int i;
>
>         av_masks =3D indio_dev->available_scan_masks;
> -       masklength =3D indio_dev->masklength;
> +       masklength =3D iio_get_masklength(indio_dev);
>         longs_per_mask =3D BITS_TO_LONGS(masklength);
>
>         /*
>
> --
> 2.45.2
>
>
>

