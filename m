Return-Path: <linux-iio+bounces-21355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB4AF96C2
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364FE5A082B
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AE2C325B;
	Fri,  4 Jul 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOzUIwOk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A042BF013;
	Fri,  4 Jul 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642762; cv=none; b=Q3zm3x0ubi+Y2Ox9FWuwIN5IymPdmZdzk9nuav/s6Ou0VvCoGCV6hJ1xAXONq34KKMUUoOIkQD5JbDG5W+iu0ki5ok4HKtUheNZcMUox+e295UspLHfuVsh79E89IigugdzXOTvkoXMAwuLnNo6rtwuMmIUgrKHMBp+sDlH+Auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642762; c=relaxed/simple;
	bh=hkrris0XIdMZwhPXqZ/D23EFgKNcyFvFnekDIAcLLls=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:
	 References:In-Reply-To; b=JhAlz13aMr7uGmATsCIcBYrCH5YDuXwRu+0ftQE76KSEXt6pa6PnhFtXWsaWsfLUwAIMh9FKuMos1nvHwtDYItrjNCRQ/aL4Ojr6SWdPqK8iaFnZmBcTrbzdXNnBxXeBmg7eEMq7aq59w22raLwpaXqGZmFbiF+T89Ql0OjWgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOzUIwOk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so5877015e9.3;
        Fri, 04 Jul 2025 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751642759; x=1752247559; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBgWCKbdVEBzjfEHgGPgXI3i0E/9SHqAjmNTx+sAHHY=;
        b=XOzUIwOkQeMcr71Ot3P3jbGNtDnpqRIp5HO9pQbnZK1oXvYDK9FoeO5r5vVaxM7W+U
         TcrmEUHpFk1dbYoQ+VtjcZWxFuiX8xdpvqRE4vZb2yeDxeNa+PsfqooRFH7cqMf1zxPe
         teqAVWsKuR1bELRlQxJuNoDEOU6mmHDue4mRe5SZ1Zn1MtC4MeuDhS8EDwYWLdpN8Ccb
         B1nTtu7WKVRz/VskNSH1ESZXUJzhkUydnL4HgBwyYCitCTNwmZgy9jlBX1TthKTOAjWD
         Vd1jfNdxepwLQh7bl5b8pN36m1gnXqfaoMj31DMxALWL+pdo6d/6lRA9LZJ6kzZoR71I
         ANHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751642759; x=1752247559;
        h=in-reply-to:references:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JBgWCKbdVEBzjfEHgGPgXI3i0E/9SHqAjmNTx+sAHHY=;
        b=vFoGhLULQqniVMB+QdX0iAghACcMs1sI/3jxyH1eEz0NDS43rk3Bv7QchE3QUSqms2
         muA/Qa6z3RRI/6V9cWRyBrU0C2VckFNafbozSFHEtTX3/+8D9jKMtavxuaRXtBtMGmOd
         1rRvs7Byf1b7eStkLe5XcMVil1HJj6sqLlegqCI+52gFBcSCrPH8C3Tx/xHUZWCSR3r4
         ecybxyVUHLvJXArQqs4P0dmLkroRlZdY0qTp5LTeFN9WK6w7fgJpTcjY0o5fMjs1vMc3
         kn/1YyIXOGJBEaHJv5ieW3nMRvpMWXRKUtQRKjqCjZn66VuLiaNYuJqQrUdA/FWX4Acb
         t3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWDYSD8Dx3qej3kFuau4Ru826cHaBEuXzT3yF1CWi8UBeVNrbCO7TpSc9sWdHmJEL7B48fhlT5EKAApYtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGStx7zqrmv4ey6OiKPbqm1lCDvi9LXcFRLKdiSJgRcTIgfowG
	onMyjDP45z0ZuVAujeS97pmtWFn0Scb2AhvWa/QqJ0dtbtlZEn/VEiyW
X-Gm-Gg: ASbGncsSUl/cZplv8YctAO4H8NY1VK7cwTKFJRMVsGyzhR686RjkCvlaSQXqVryqGla
	2OoTgpSIgzm3mhxtyeWZgB+RHlz1i6TdVVI5ld7rUNjXv+hbo1x/Owv6xWdF7Jdg8TM+xBp9Nrf
	Y3LEAq107TAnASSCk9aQ6XBVQ1tTwLr0HNK4S8yE1YqbcRTClGpRPL6Rd6sIJtrix/JDV9Dw494
	nim1KJ++KSiVP0YBDjIVWrdQqsCpCIAHyjKoxBwibakJqUTM2q1ZINqB4IjclGBnVKupKkVGbKk
	wnmUrseI9WjsPGOYIi5LjSXqHOUmVz7yldX9vVH07o69CFLuFug5h1aLHdLq9K2gXIQ52Veds36
	8DPP5Ahne1s16lw==
X-Google-Smtp-Source: AGHT+IFg9uvqa5LmAr6RLIhel5JMqvuWuppWw508GFdS/XFd61zn07luB9/xERilmez4oszfTjS0kw==
X-Received: by 2002:a05:600c:a316:b0:442:d9fb:d9f1 with SMTP id 5b1f17b1804b1-454b3b8a485mr22839885e9.4.1751642758465;
        Fri, 04 Jul 2025 08:25:58 -0700 (PDT)
Received: from localhost (a95-94-245-170.cpe.netcabo.pt. [95.94.245.170])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9969058sm59249505e9.3.2025.07.04.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 08:25:57 -0700 (PDT)
From: Rui Miguel Silva <rmfrfs@gmail.com>
X-Google-Original-From: "Rui Miguel Silva" <rui.silva@linaro.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 16:25:57 +0100
Message-Id: <DB3DJ9O7DEH9.377Y1IS7ZAVHV@linaro.com>
To: "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rui Miguel Silva" <rmfrfs@gmail.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Julien Stephan" <jstephan@baylibre.com>, "Hans
 de Goede" <hansg@kernel.org>, "Waqar Hameed" <waqar.hameed@axis.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 32/80] iio: gyro: Remove redundant
 pm_runtime_mark_last_busy() calls
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075422.3219401-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075422.3219401-1-sakari.ailus@linux.intel.com>

Hi Sakari,
Thanks for the patch
On Fri Jul 4, 2025 at 8:54 AM WEST, Sakari Ailus wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ail=
us@linux.intel.com>.
>
> In brief, this patch depends on PM runtime patches adding marking the las=
t
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 \
>                 pm-runtime-6.17-rc1
>
>  drivers/iio/gyro/bmg160_core.c     | 1 -
>  drivers/iio/gyro/fxas21002c_core.c | 2 --
>  drivers/iio/gyro/mpu3050-core.c    | 3 ---
>  drivers/iio/gyro/mpu3050-i2c.c     | 1 -
>  4 files changed, 7 deletions(-)
>
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_cor=
e.c
> index 781d3e96645f..4dbe3c0cc5eb 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -310,7 +310,6 @@ static int bmg160_set_power_state(struct bmg160_data =
*data, bool on)
>  	if (on)
>  		ret =3D pm_runtime_get_sync(dev);
>  	else {
> -		pm_runtime_mark_last_busy(dev);
>  		ret =3D pm_runtime_put_autosuspend(dev);
>  	}
> =20
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21=
002c_core.c
> index 754c8a564ba4..a88670207cec 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -373,8 +373,6 @@ static int  fxas21002c_pm_put(struct fxas21002c_data =
*data)
>  {
>  	struct device *dev =3D regmap_get_device(data->regmap);
> =20
> -	pm_runtime_mark_last_busy(dev);
> -
>  	return pm_runtime_put_autosuspend(dev);
>  }

LGTM,
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
   Rui

