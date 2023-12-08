Return-Path: <linux-iio+bounces-748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC2880A2EB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 13:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B89B20B5E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94971C283;
	Fri,  8 Dec 2023 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJu4LHTy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CE1984;
	Fri,  8 Dec 2023 04:16:35 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cb55001124so1316865b3a.0;
        Fri, 08 Dec 2023 04:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702037795; x=1702642595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxPT/S8UvIaB4XThcM9bwxOckRP8P08lnMU7Wq1JU1s=;
        b=bJu4LHTyTjAgbOSu6AbOoqt/UGB4Zj0ql6Km0EbPd48JgRIzyuvseKgApznLtOIYmR
         ouZw5iacfc8Xi17QlZUKp+YyLEopV4IhTOLdAg9kGlqReOPyhTuf4vUuJizLsgu9Pobx
         novQK4SwC40yDbC67xDebvPrTJQHmd205cNb+bAkGe8eU8/4+a7oBy2auAJ6D/Q/WtV2
         /bhFjcK7FMItXZjHXLVxsmLaPj67qn4QI0f9Kst+1v4p8N6cKtg4BuacsD77mEitmPAs
         5cLJofVEKhxY+eioVpt8ifiAoJBEcMXjCrScODZ/V7cSLtnmwT2k+LrYKhvaC1Hw+o4u
         A53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702037795; x=1702642595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxPT/S8UvIaB4XThcM9bwxOckRP8P08lnMU7Wq1JU1s=;
        b=LNLmySpI1QELOkyumEmIMwTJkrsISpnG4q6RJohE6+yF/GuQ5bbg7HnKH/S3lkZUFf
         laXuRoV5KShnnQI6AqjFCLvpUtwf60YX9PJH07SAB0yCUUp5X2ey5Rn8UPKlNTmOttU1
         sxmXhKIt2TYdv1ZawckIcsbEn14+qDUqZdaNCZWL99xaQ/Fm7jEdYSvvZWjp2Au2Zc/s
         DOqGo/7M5fr1EX4At6pG0RZw2xfC9nMBJ36PsQDPaHeNJ0JSO+os2yniQJ0LBs4y7qfc
         tOkCbeHEZJGPGFugAbJkCxt4TM3TeEq1VshF2RJB2Zh8E/cjJtc903X07kyU6t4e8fyc
         dhwQ==
X-Gm-Message-State: AOJu0YxAwzim4L10CtZePukZwsQp88DCrT59ad5qrlTzn2BAbV1YldKU
	XiNazXHSeSMGV/hMUgd/CZM=
X-Google-Smtp-Source: AGHT+IF1OJE1g7neMTQaW6dHc4thePiAEzkdPBcziZmF63057tODSSCfZ3ZzPnoGCi80yXf7qoP8fw==
X-Received: by 2002:a05:6a20:9390:b0:18b:9041:5729 with SMTP id x16-20020a056a20939000b0018b90415729mr19136pzh.17.1702037795190;
        Fri, 08 Dec 2023 04:16:35 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b0068fe9c7b199sm1437178pfb.105.2023.12.08.04.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:16:34 -0800 (PST)
Date: Fri, 8 Dec 2023 09:16:21 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] iio: adc: ad7091r: Populate device driver data
 field
Message-ID: <ZXMJFVc3vUKFz4gP@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <14973feb4c0f4ad01a0e5047407c93ce9b9e5463.1701971344.git.marcelo.schmitt1@gmail.com>
 <CAMknhBHCYicEL_xhumBQMUm=HBVb=7dLrYsK8Zj2o7RodvMarw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBHCYicEL_xhumBQMUm=HBVb=7dLrYsK8Zj2o7RodvMarw@mail.gmail.com>

On 12/07, David Lechner wrote:
> On Thu, Dec 7, 2023 at 12:38 PM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Set device driver data so it can be retrieved when handling alert
> > events, avoiding null pointer dereference.
> >

[...]

> 
> Instead of introducing a new relationship between iio_dev and st, why
> not pass iio_dev to devm_request_threaded_irq() instead of st and then
> use iio_priv() to get st in ad7091r_event_handler?
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 8e252cde735b..0e5d3d2e9c98 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -174,8 +174,8 @@ static const struct iio_info ad7091r_info = {
> 
>  static irqreturn_t ad7091r_event_handler(int irq, void *private)
>  {
> -    struct ad7091r_state *st = (struct ad7091r_state *) private;
> -    struct iio_dev *iio_dev = dev_get_drvdata(st->dev);
> +    struct iio_dev *iio_dev = private;
> +    struct ad7091r_state *st = iio_priv(iio_dev);
>      unsigned int i, read_val;
>      int ret;
>      s64 timestamp = iio_get_time_ns(iio_dev);
> @@ -234,7 +234,7 @@ int ad7091r_probe(struct device *dev, const char *name,
>      if (irq) {
>          ret = devm_request_threaded_irq(dev, irq, NULL,
>                  ad7091r_event_handler,
> -                IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
> +                IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
>          if (ret)
>              return ret;
>      }

Looks good, will do for v4.

Thanks

