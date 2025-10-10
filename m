Return-Path: <linux-iio+bounces-24930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946ABCE6F8
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815C5546178
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C23019B4;
	Fri, 10 Oct 2025 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoOTehJ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0453019A1
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126149; cv=none; b=Ovo8QhhdiYHMndmXGVhDtYlNZcc6oBde+S+3XaHCtDr13OG+XL07Jh+kwS39McUhkF8LJFYSw26equBRiP3cXZj/AyF9X8IwcFXbXn8IUprR/8qvYf1jFbECMEMeQ55XrKdY8ZQ10/Z+Hcdlc+yT6ej/Il6sE0+/ud3O1NxgTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126149; c=relaxed/simple;
	bh=9PS7F/m4n1uAkBYWPryVi2hX01WNFFT8P5czGODVaI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8hkTRF623Szyax12iRGJrXpfC24QmvzBIYJ5/6dkj/0XM4Z7BZguxZ9TpQN6UXdZFPD7d7Rft0EZYpm080L5bsiwOxQzk6YjRV6ziJzne+Z4qawdS1ogLjNCZaxTrL4SuozuepP8PjWEOkGmcf+nvDI4tp3E6DjtZmUpYzOhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoOTehJ8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46b303f7469so15461755e9.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760126146; x=1760730946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WlPTxxGqUeSR2lZkjJtan7WE7z8YmM6/O314vANG+hE=;
        b=WoOTehJ8ZIkVn5KybLL1WjDwxXHekgqlHfszjSWVfabSv6MMLS1rkll9MqiUPO62bF
         YG+3c036NgWKmyj2Dh/1XJ+bMuTXoPEKAil+YyNqz9+xH6CLrKa+iSgYVtTKkuCdVRSG
         99iEMe61IxbDPdpm/6FoQpcMygsb6AF/PicxL501BSRH0oNAgmcfhHF9cq3whuG9s4WW
         KOUozpokXZlfF4QsWKgehZ/7JW/TnhKvL3uFcCYDsiOXC2wZD4z1HODQbSwHiuA4SqG7
         wzs+KDzRFKQA8dIwE6gy3JGtuHsDibXGtghO9Iaex8q+V5LKIoslO95B0vtKvMrtMYHa
         68uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126146; x=1760730946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlPTxxGqUeSR2lZkjJtan7WE7z8YmM6/O314vANG+hE=;
        b=MlbseFarSzPfDp+9y5IKs+q0X4klX4diHf1a9lCOlDcI/TYRO6LyL1XjFLO82WAS45
         W70UOvaQ07ID0oF0PL4UP3TAKNS+302gZMQFJOyQBCmKaKFleMwNiaalUHikA49rg89n
         djwKwGxda5K7PKBsKYnxrTVDZujl9WO5kglVbsiIm+75YgA6lR4bbeC5hY/vcR05AgBG
         iuFPQR55mWh8mU5hqlRXMJzhzKZWX9Qhc4gGZ9OXcn08iJIbY+k4HqYNezmRWz+K5t85
         +BI6k/ba3ArjkDM9fJ6uKO05Y4MyHbVKt0lBK8UEyFCemHBmi3vwjwbAGZKAyqFu4mr2
         PDrA==
X-Forwarded-Encrypted: i=1; AJvYcCWAf0U58vuRLYZqY/i7smc21AOUvCJp+AN+PsxHZNQ68qwYjWCTvlD/g6oMB9a/TF1nMbD/ZI01ALg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL29pFaxfZodXfNQY/w+YXBotDBubNfKvZ6rS3TDluf+03a6ll
	J3gtwLPEvoEdrquHPtRJ0iZuh2a+cPeK/ym7rK//iFU9fGo/bj4UAXRK
X-Gm-Gg: ASbGncsUklDazKz+gkSmBD5S/IZxZOg9D5S1i6z0YVruj+3hOE331ddo1vXPBJ4K+uE
	HCl5P0ScHP8o4NDbu2ZboLADjZTlbnizGcjeRpQLDfgmarbfSe7PJYMQnCXNk1ExzUiHQms380z
	7NsUu4mdZfx2oYIJtGFlvufvobXyH8kYijnlvnLI5CNJbRsJNxvYLCXfXKevT+JHPs6ojHaX0fR
	3G3SkGigxnDtU4facVracLbG+NiY372WI5NCjCNKA4dkIkEzX7u3fF+WQ+GOIS0MYtRgo9dHYQt
	a3CvFGhfoFbCMwuHeJdpb+bZhJrMdetJj4VPQyNkD3Cwm1kul43AAs+Pm9RMLaW2cNABG2bLZ0r
	sF+kTQ9+M0vHx23B3f5jcX8xy/Rdwpa0kDu7/SMmxhuVnfuXeDm95fD0CXtCFFw3iWV7ogzJdYX
	ZJUJ1s+qYb99YDOLYg1QDLN9oK
X-Google-Smtp-Source: AGHT+IHaWYI9QvKReNHkAaSbov4hjc2gUESetJC4TFK/yM1c7gn97K56ZqGizY/MOi2ZOYx+SBgt6w==
X-Received: by 2002:a05:600c:529a:b0:46e:3e25:1626 with SMTP id 5b1f17b1804b1-46fa9aefe15mr92408175e9.19.1760126145632;
        Fri, 10 Oct 2025 12:55:45 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489af92sm70551775e9.17.2025.10.10.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:55:45 -0700 (PDT)
Message-ID: <3e91c2a282499f862ed7d27842d5bc2ee461ebf8.camel@gmail.com>
Subject: Re: [PATCH] iio:common:ssp_sensors: Fix an error handling path
 ssp_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kyungmin Park
	 <kyungmin.park@samsung.com>, Karol Wrona <k.wrona@samsung.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Fri, 10 Oct 2025 19:56:41 +0100
In-Reply-To: <6fdd39e3763a6e0e700982ac6ed63a5748a4ce67.1760122717.git.christophe.jaillet@wanadoo.fr>
References: 
	<6fdd39e3763a6e0e700982ac6ed63a5748a4ce67.1760122717.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 20:58 +0200, Christophe JAILLET wrote:
> If an error occurs after a successful mfd_add_devices() call, it should b=
e
> undone by a corresponding mfd_remove_devices() call, as already done in t=
he
> remove function.
>=20
> Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/common/ssp_sensors/ssp_dev.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c
> b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 1e167dc673ca..da09c9f3ceb6 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -503,7 +503,7 @@ static int ssp_probe(struct spi_device *spi)
> =C2=A0	ret =3D spi_setup(spi);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(&spi->dev, "Failed to setup spi\n");
> -		return ret;
> +		goto err_setup_spi;
> =C2=A0	}
> =C2=A0
> =C2=A0	data->fw_dl_state =3D SSP_FW_DL_STATE_NONE;
> @@ -568,6 +568,8 @@ static int ssp_probe(struct spi_device *spi)
> =C2=A0err_setup_irq:
> =C2=A0	mutex_destroy(&data->pending_lock);
> =C2=A0	mutex_destroy(&data->comm_lock);
> +err_setup_spi:
> +	mfd_remove_devices(&spi->dev);
> =C2=A0
> =C2=A0	dev_err(&spi->dev, "Probe failed!\n");
> =C2=A0

