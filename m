Return-Path: <linux-iio+bounces-7201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54592539E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A9D1C223AE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F41304B0;
	Wed,  3 Jul 2024 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3NIwztsn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940861FFB
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987976; cv=none; b=UgsHMAFOMwd7pmct38MxFrCOnKpasm8nQRp6ZqoLWDt0eliy2rc1FukE/BB3d+P/m241rNpjV1H4k6AvlFa0vjmThyVeH8iXaINejEI0ne7OIa/1hro3VOAi+uuTIdTO5M7JbHKR315JW5EHxw3AcriykPOlho0uASl2aFU6JUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987976; c=relaxed/simple;
	bh=+JUZDJwt7GmXY/xHCkVHzO3t0qk1bmMRJ0xUj29PKY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNQmvPwQK1CZcQv9eL1EFcmV3NYrxweAGxhAwLzbw0sxk9dEGpDGCMYQZCZldtgJscFukSvUfSHmKooVvppRezN8Z1PR8LmVhMyvkrIS8J1bkuvqYEewSM2CUI2vnpcBJZo9ODd6avG41DqUNrTjPVNpkRIE4T+vVzBDla+5qA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3NIwztsn; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48f428e0740so175691137.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987973; x=1720592773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSEt4ErQh+yCUcOjOlUjrmraXPGAWlNM6sPGDlobEU8=;
        b=3NIwztsnc/lP3yeIjfrvrbFQFUzgkJI564VegDMWh3GqZYbPFw/9Hw/2VxP2ezC2gU
         GBsMgv2rYCa/0LIhzU4LKJrKVnNY4uh01ZpKq5HdC49+dQNduZ1S7iQTfff2xM44zKH2
         e3l2jFETRZBnxa7XSbJ372WITzlI71kkhjC+eS9tPw2FeHhX2Qpg3ZIvMiSHiGGEcN8b
         C/blDStMXrQhJnZYQTnarVigtdKGIRVrayCUf1rLGcIzfibalucQEMVjPHA4pX034mzd
         9l0nd9kf1wDXRzFAl77KzyKI8yOZegAwIupmUH9xngA7KyYoNqsKLiqsOA+DwRAHkZRS
         1Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987973; x=1720592773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSEt4ErQh+yCUcOjOlUjrmraXPGAWlNM6sPGDlobEU8=;
        b=ZdbJhpxOgBrPjhTP18R0i4H40MfHt0kuzjoOjYXp0dZibiUjgDnrunh9JUHdc7LI/O
         uOfE9aJCTQgrXvknH/W3sLGNNo+Hm/Ji1mNMzInfI6G7AywZiuvGjVnehoqNhrTf8Bvn
         cUrLIPik7fByE8oTRPvNnX4R2M1dcyL2RPcSkmp38Y2Qna3FwPEOJVAMWe8AY5pLhyFk
         DuyxO79/RRvZL3VjdVMejxCJMBHkNQQhM0ju1FXYZyKllt6d4aqElHQPGwRQ2r5JNycs
         +Iu5rCkF/IW57Nu8agMhxkLXNw1xYZLXCQLS7BY49eE1AEst49rXWfRrhm+LjW8Uj/JR
         03wA==
X-Gm-Message-State: AOJu0YzFAQTmzC6bHUfHmJ2ijDhsUxWM3NCmvQ0Uh//jnEdFOgL1xvqc
	OsnKbZDDcajC65bu1V5gz4yDBqQBK3xnZWhNMTBo4dCUu1TB5W1l/yXHdFxJr2HqYn/NkOtFXad
	jScjXKpo1F2qLuOdiSev2K6d6AdQcDZ3mG5MU5Q==
X-Google-Smtp-Source: AGHT+IFigxZLH8FjIQ1Jvmk16KcKFcIpIFcKLlY1yHGB5gQmsCe1MwzxYPP5Yq1ftaRafP/l+O8BTo7ykPwhe+0VBFQ=
X-Received: by 2002:a05:6102:418e:b0:48f:df2c:6d5b with SMTP id
 ada2fe7eead31-48fdf2c7245mr724438137.2.1719987972800; Tue, 02 Jul 2024
 23:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-10-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-10-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:26:00 +0300
Message-ID: <CA+GgBR8T7hYoetJNJBt=PtGiUYkTc1x1fnOuMGv_z7a9nL=LnQ@mail.gmail.com>
Subject: Re: [PATCH 10/20] iio: accel: msa311: make use of iio_for_each_active_channel()
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
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there ar=
e
> no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/msa311.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index b8ddbfd98f112..8861010256f2e 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -900,8 +900,7 @@ static irqreturn_t msa311_buffer_thread(int irq, void=
 *p)
>
>         mutex_lock(&msa311->lock);
>
> -       for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                        indio_dev->masklength) {
> +       iio_for_each_active_channel(indio_dev, bit) {
>                 chan =3D &msa311_channels[bit];
>
>                 err =3D msa311_get_axis(msa311, chan, &axis);
>
> --
> 2.45.2
>
>
>

