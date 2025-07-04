Return-Path: <linux-iio+bounces-21357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F68AF9785
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 18:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F335F1CA4125
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31E307AE4;
	Fri,  4 Jul 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="LGf1BJtk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F14309DC6
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644842; cv=none; b=jsUmGFljJPjAt+sZVRyZ1oRWmVsuNeqjreAXkgJTojhRwuUdFKV7jE8GJWDlUQxsgVcwdP5xKjpbggmOKMVIE738P3P2NLtm8wRQ2fYxHVdZRpNiKhgsPyqj/1cLn60TPLsvx7mxmPYu8CN5SsXdPjlhHs3atVJllhPMyFRazfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644842; c=relaxed/simple;
	bh=ycMEhz/Ymor31tiNW/7/5CKiWvgFdDIwLPBpH80D5o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdO53hFEXtrL5wndvmcVAi7CsyYuI6QXjn/gctx3K9AXHfvJmz7pHk6S7MN6mnb0lg5zTnvdkPrqOB4Hv1vXu/ZKq3kGHV27uo7h9yoFZNcBeJRhLbLQ+NjN41todPBkDGbPYM+/sJjOjMraqNf8fmq7aV3kfPBvDWUofXSkeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=LGf1BJtk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a818ed5b51so8163791cf.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Jul 2025 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1751644840; x=1752249640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck5pH4TCdFvbc+j4rr/UURqCRGDwQIto4Y+SJ0crfmI=;
        b=LGf1BJtk8nj5G2733cQR/5VYQgPKrI50a8cn5xDQqe4yo6CtINif5ioDTVbZSLGV9u
         nycQ1JtaHQECDQqZZ/ssmbEWriCRVvtdIZqZYLqoAYCiU4DTHq0aHG0YyVaqVYpDTigk
         dQG9gDjHRnq2CBzEEYoyYVRFAKhawmu3Lt8OcUiDLwfbgUMTCbIBcsinJ3rlL+7xSwnN
         a1B05UREz2biwxArLZ5D7xZERZdvK/lh9M0YYpTLSIOY6zBIqfI5YcwCwkBNCjHDvDbD
         0CKYGGoyEUP7MsKdp8SzuNdvZ9NEpdVL8pSLwV75oxir7UmjQrnTZMDoxJFscIwX4Nq/
         kkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751644840; x=1752249640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ck5pH4TCdFvbc+j4rr/UURqCRGDwQIto4Y+SJ0crfmI=;
        b=ZF1rq2vYcArTeLG6eoDS8eWSNpUNb3CCIYZy2zPYT6f+H34Y6a4wXoygpk0nVzELEl
         nPlIux05XpX+4bjrFVcVrLz9QDXYzbjEGliO09d45hf83H+uBkPDchac28OpkFrICWTl
         2HcLX95YSnWo3hC2fpHpSWrH0ctkUh+A2Dg8p87Hio42NPutcZJdoS+RcBnvkzG8Jyih
         t+gk0kA6lY6iW8OzUk0ilDNF3wfpiS7MCtv3tC5B0KtiF7cpN58vRyQxDJ/ZijA5Wrb1
         JtgjGWhMheEYaf8y2zlbqMHuK+DQdmlK9uksw01Fa4s6ToatWCPKjaTplom0NlOG67of
         r5yg==
X-Forwarded-Encrypted: i=1; AJvYcCXPuRMokVqKa32xdkRBXIe561h52apk0OeDPkgolPNNnNwSBCUbiQszcdvHPA/tGnR/hgVNmgNGD5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86OD8iNwq81+jMFDDMS+9HqdAmZE58utTYosVAUwv+QAPJmt9
	AD/lMTYoQpqfJzwLd5IiTvsDW9Qa4tQTX8xisxagwcWJxJfZL7r0eaq1u3vn4i9oVGeO00bY7yn
	qMBZC6W1+1SZUrrFjYtfcJMUJXvI1f3VEIWe+m3cs
X-Gm-Gg: ASbGncsVPHYFU84bzxizhQSLfBpQaXiAyAVsp84XBAqk00atowE6OSziiAiSnQbDpRv
	ykpwlH2Mq9FC9wXoUjDI5CW963Mq52P0iwLPPYVah3v+wCo1uO7p7Q39aFZasBksEJKPj98dt/O
	nz5oS0JRSh/7XXJ7dEnKsPd+3L2UVvZU/ci3qTVjBJL0UZ5Bwv6oxi4kuCYOUtQ4C6pYv8R2KVQ
	5naQ0FV3NicfmxX
X-Google-Smtp-Source: AGHT+IE/Ue+mLX7FnsWxENqyuQ0YBB6qs+VzIgDrYWL+iko7VKcfvXw8DWSoR2RhEh1WBsZm/t2iAUbF1v8iUCzXZ0c=
X-Received: by 2002:a05:622a:1996:b0:4a7:2f49:37d6 with SMTP id
 d75a77b69052e-4a998600242mr38616231cf.5.1751644839366; Fri, 04 Jul 2025
 09:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075428.3219924-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075428.3219924-1-sakari.ailus@linux.intel.com>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 4 Jul 2025 18:00:02 +0200
X-Gm-Features: Ac12FXydqto7Ti7oKXJu3NtVrCWodiVKgbT6j1TWMXlIlpDLxJ7OBdzg-fhb8Rw
Message-ID: <CAKv63utwwwQVMrAZAGy9rkk5fFPncQ=TzggZf6K0s-+GB-oi6g@mail.gmail.com>
Subject: Re: [PATCH 38/80] iio: temperature: Remove redundant
 pm_runtime_mark_last_busy() calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If that is the case then:
Acked-by: Crt Mori<cmo@melexis.com>



On Fri, 4 Jul 2025 at 09:54, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
>
> In brief, this patch depends on PM runtime patches adding marking the last
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>                 pm-runtime-6.17-rc1
>
>  drivers/iio/temperature/mlx90614.c | 1 -
>  drivers/iio/temperature/mlx90632.c | 1 -
>  drivers/iio/temperature/mlx90635.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 740018d4b3df..8a44a00bfd5e 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -225,7 +225,6 @@ static void mlx90614_power_put(struct mlx90614_data *data)
>         if (!data->wakeup_gpio)
>                 return;
>
> -       pm_runtime_mark_last_busy(&data->client->dev);
>         pm_runtime_put_autosuspend(&data->client->dev);
>  }
>  #else
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index ae4ea587e7f9..bf689f6143f3 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -1043,7 +1043,6 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>         }
>
>  mlx90632_read_raw_pm:
> -       pm_runtime_mark_last_busy(&data->client->dev);
>         pm_runtime_put_autosuspend(&data->client->dev);
>         return ret;
>  }
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index f7f88498ba0e..80d0eb7d2294 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -749,7 +749,6 @@ static int mlx90635_read_raw(struct iio_dev *indio_dev,
>         }
>
>  mlx90635_read_raw_pm:
> -       pm_runtime_mark_last_busy(&data->client->dev);
>         pm_runtime_put_autosuspend(&data->client->dev);
>         return ret;
>  }
> --
> 2.39.5
>

