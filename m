Return-Path: <linux-iio+bounces-7205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E461D9253C2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D956281DDA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144912EBDB;
	Wed,  3 Jul 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r2WDc8Dr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCB381D9
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988662; cv=none; b=aa5E9uRBJX7KP0uKmxb0i0w1fgBWdecyh0w1L3ItROIrFX8qqhYv5RGSrsFZcJifspl401kb5E4yXQ85OQ1xjjJisxIIdhQZPxc1xMbQy4PB7aW196VxnxwS42uoZNLReYh5e9pi74VnfTACbby+/hNnk/U/0epOU7uba6s4e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988662; c=relaxed/simple;
	bh=BfK2sctA4fXWt5YF8HGcx+xtorjZmDBoYhjYgwAwrro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDr1AmxymlU9JOYWF9BOoOU+pf5kXvHs5EaDjws/7Hd9K/Fx1IpL8P1M8hP1Gj8jirGT2po/snMXXtuo/y6ia7lwTRIHjf1f5aXlprq46mjjTq3s8i3YBJPys1KUiNGkMIozNxWiOJBdKpRu/zJ2OjiGRY8zzMb4HPpQ9dpqyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r2WDc8Dr; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f2e0a2bf79so12178e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988659; x=1720593459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IjFZvsAsiC/WDBViow/MC9bkSbwquCEh+ciUVx1+JU=;
        b=r2WDc8DrVm2uC4WIkUKUNF8owy01qX8BfnJtjY/4/I2HZChIQvG7yM7/NRTccdSVIL
         G+zX3p7H9eAVxAbgoP13plXj+OmQ5fz4ozYS61QdGjy7pKQ0PhhkIuBUKbEkCpipY6QJ
         N7x6GAkfMQ8XeSW2Cz5/tqc8XMLrlQJb3myuTWLSYV7Q1PLKS+16ltv3Jb1N+v3TDJ33
         m0k210WVoWZb1lBZtfprP8+0lynrfN8eIpwfw7IYfADxW+tDlxPZKg8wAMcXAtinTwrg
         4RpZaWtE7ncCWPIYMC9kbOollSUT0KsFebAcotxAhLWQh7l8dCyqtGJRg84RWQhy8WHz
         twZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988659; x=1720593459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IjFZvsAsiC/WDBViow/MC9bkSbwquCEh+ciUVx1+JU=;
        b=Cc8OPSVmPv6raRbP9VcmsP0inYvOFPORazY0aWnAuUREzEoyjDl5URV7NA//Zo0bah
         HQGpEYk/AHfwnc6YTWn4+RBHqVZwMBA4JC4CCXfEgXPdfbQ+erjqJlFN1otVEt9eRyw4
         7BUnRAIR2Crtg4lhDsi7AolB2LSmgg2VverTgN4YL5wqAmoMEDMSmd4CqawXJK41OTqT
         R48X9S9ViyYXjaDGScw0kPObZMEZBJi7WVI1qmaPle0NWAEdB3QqqoBwbyX2FXJM/iR5
         H/On/IR5BqofJSbuSK7B0knfHTxbnSMDYyNGa4at57XojNpqqokd6cm/YiIyluhWFsqn
         ksmQ==
X-Gm-Message-State: AOJu0Yz/xLzRqjUT14roPwLQk3oSiy2kfy9JHH6py5iq6j+xgZaN4Dla
	HGdRAcY+N4qKqgKi+Aq9rrtOnZqY6EptTkdnFGqel5QXGj1dBn0blfxTPpFm+bhjvMkxbrn+trP
	tD1PRjT/Mo1q0kAUhs675wYjIL4jsIUaeVigZ9g==
X-Google-Smtp-Source: AGHT+IE9OriilIOAIOnvVh1+BI3Jr+CXeyRZR0cx7sw/8Ki2Nzc/UgN0Ds8lRHXMzmaV801nFcRN9n0rklzw1fG10fY=
X-Received: by 2002:a05:6122:3224:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4f2a56e4202mr10773231e0c.1.1719988658902; Tue, 02 Jul 2024
 23:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-8-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-8-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:37:26 +0300
Message-ID: <CA+GgBR-uazN8==3FHWo6Vb_Y3YEoMMnOLqJnfXtAsrS7Pc6B1g@mail.gmail.com>
Subject: Re: [PATCH 08/20] iio: accel: cros_ec_accel_legacy: make use of iio_get_masklength()
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
> Ue iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
>

I would have suggested maybe a "iio_for_each_active_channel()" here
instead, but after looking into the driver a bit more, it looks like
it's part of a broader rework.

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel=
/cros_ec_accel_legacy.c
> index 0f403342b1fc..f7e4dc02b34d 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -62,7 +62,7 @@ static int cros_ec_accel_legacy_read_cmd(struct iio_dev=
 *indio_dev,
>                 return ret;
>         }
>
> -       for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
> +       for_each_set_bit(i, &scan_mask, iio_get_masklength(indio_dev)) {
>                 *data =3D st->resp->dump.sensor[sensor_num].data[i] *
>                         st->sign[i];
>                 data++;
>
> --
> 2.45.2
>
>
>

