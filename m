Return-Path: <linux-iio+bounces-14865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F5FA24F12
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D331639DA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135D1F428F;
	Sun,  2 Feb 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szytbsn5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DEC1FB3;
	Sun,  2 Feb 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516190; cv=none; b=Teja86/oWS38BwaxodpNnwMg0jV7Du5ZPb1kDi23mDayVWL6vPKwA84mHA6yHr/cw4Cw1O8wet2Jt3f488g0YHrHSNvpKin2EPPk8xDmuK7fnXGHh5qWNOyr/Y0pbY4qVbi9Iwwqa+qCr/5UGc7JQXxsXPiOTZZB/xCUZyE0/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516190; c=relaxed/simple;
	bh=df6BcYVR2vRlNLlHLxs5/iga5oJDC0yq9+DSnTI+kUs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Upaq3U9qiBHx7h6XVvcU0mTB64/R6dl78UdRZvaj/zvlBGMpiOrOtasD/lk4DG//MKnESjThIRjkjTfppLVJnxOlGJei1Vjmq6oxWR/upPGrsg0+cZBNN4bPYg1goA4czr+ia46d5z2e4CcpEXE/gbEgVLCh8H3eb8vvt6YdJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szytbsn5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385de9f789cso2760862f8f.2;
        Sun, 02 Feb 2025 09:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738516187; x=1739120987; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUfnIb7i9zp0poNHv6A+PgqlAHuBKpjMn6IWAlduoFM=;
        b=Szytbsn5aEc7KFEo9PClEdGv3DIx+0YklqHsiFVEB3RmwOsBMEzhLWE9xMFPMvn0Ud
         EcfNi13xJqLlilDNqujutaZcHPvysymwGkxBF6q3WMQhjyf9cqfskrPEHGdvR3SUa9Nb
         61LFpyjtyeQN+ZHvBeHa/pyhLb7/n5TX7JLAWEvjc7bjuHqKFxj+9j/WSR3ejXhyF5V+
         7XM7Yw1ImOVdnVG5ymkBR84gnCGhX8NLOLZKpNjFVzCwCsKy/2/oXu+oM8EIa+cbIy9E
         GLlmKaBdJ8UoeVrgizg/6RJEncoRVfdyl7FOwhtVuFPJDpxbgJRVzhWEPKLtEWSDQpI6
         G6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738516187; x=1739120987;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AUfnIb7i9zp0poNHv6A+PgqlAHuBKpjMn6IWAlduoFM=;
        b=MQim5qDXrCsZKtpEfETjMZaxn2hZjGBW/BYyIsoeJ+4bVKCRMajcyfhfIYtikZN6Sn
         u8EYu9YkdsEHLPEXVFPESeZPPVZEZ+bbWFvdHcXahuFDSejJx9XxJ1hU4nsHewqek52S
         LT07Uu+9cqOHxLQvb7Q2ij/shuDvSIHKjXDmiQGPJign3y+chbGpbyAQmv1XEUBAZ5La
         QhrkShwfAB1NmnU7dnVKNLjHLGDIUkcW7Q70PU9Ta/RsUY5UsDuwnD7exDi22ZhOX4e/
         ThzPj/wktzBS+De5ZSNbymSDjK7lMOYnBJWV9wZu7Z5r47uba7WiZ96ivgplVtTssJ0a
         pnWA==
X-Forwarded-Encrypted: i=1; AJvYcCVwR0/LfWNhAkdUqttjG4x2iot7UoDS2kMOdpMrvE5de9EfeHkilOzZT60LceSDmDQpuoJbFc2Bsusm5ueF@vger.kernel.org, AJvYcCXoG3ZtjzcgLxWd68dcNtTAQt+qFhWREvS99VETC6IcwaxAvGrlruUyw0yfctt7+N2ZkDGgPfhHGoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgCVMKOEd9A4eYfPvbFi4mGJi3ve+1HQs4eJk45xk4s+XASPn
	GR3jK6fu2j9GZFCUOtx7JQKSGkN4nO7IH/txLVabVKEgy3MJP099
X-Gm-Gg: ASbGncvOTS7ma9L93DGQscs+hCyGf48ptWqQ8yRXVD1Ed9FLf2YdClSNEoTLYARA5/c
	64cABC6nRI7OIaWDbrkfCZJ4I8s2IVYdoHLLGYoaOUnazCfB9Bq3lKsoWIzj0it0PPz0Vc+BmnU
	7Mn7JV3LPbim+7fj4asnM4/1/1pQvZHVditmDRAYeIMKrwcpjDcuROTUamVdfHYuBzs3MQADOwZ
	aEHCDCGh7/H1/bWRd8Wal2HZCOm01WtjThakOZX5R4yASRxLjtGCMBARXDV/bZuqYfhjBPRWeoW
	R0V3zuHYLIDH3GMZdrQW78l1kA==
X-Google-Smtp-Source: AGHT+IH+D526eus/CIM6agZGKLuQJGVo2Tifk/Ud4iNtFnIrNCK/PvF9vFjdTsmgQfFP3gDK8ZOlEw==
X-Received: by 2002:a5d:47ae:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38c5195cbe3mr15242738f8f.24.1738516186705;
        Sun, 02 Feb 2025 09:09:46 -0800 (PST)
Received: from localhost ([164.15.244.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc1317fsm163608295e9.8.2025.02.02.09.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 09:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Feb 2025 18:09:45 +0100
Message-Id: <D7I4JY638HIU.1OH0ECMRKC7K7@gmail.com>
Subject: Re: [PATCH] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>
To: "Karan Sanghavi" <karansanghvi98@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250202-outofboundsread1573409-v1-1-5e3dd97a24a6@gmail.com>
In-Reply-To: <20250202-outofboundsread1573409-v1-1-5e3dd97a24a6@gmail.com>

On Sun Feb 2, 2025 at 11:49 AM CET, Karan Sanghavi wrote:
> The array contains only 5 elements, but the index calculated by
> veml6075_read_int_time_index can range from 0 to 7,
> which could lead to out-of-bounds access. The check prevents this issue.
>
> Coverity Issue
> CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> elements at element index 7 (byte offset 31) using
> index int_index (which evaluates to 7)
>
> Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor d=
river")
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>  drivers/iio/light/veml6075.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index 05d4c0e9015d..a892330582f4 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -210,7 +210,7 @@ static int veml6075_read_int_time_ms(struct veml6075_=
data *data, int *val)
>
>  	guard(mutex)(&data->lock);
>  	int_index =3D veml6075_read_int_time_index(data);
> -	if (int_index < 0)
> +	if (int_index < 0 || int_index >=3D ARRAY_SIZE(veml6075_it_ms))
>  		return int_index;
>
>  	*val =3D veml6075_it_ms[int_index];
>
> ---
> base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
> change-id: 20250202-outofboundsread1573409-378997439be1
>
> Best regards,


Hi Karan,

Thanks for your patch. That could never happen because the device does
not support those values: it only delivers values between 0 and 4 for
that field because it does not support more integration times.

Even though the check does not do anything in reality, it does not hurt
either, and I would like to avoid future noise from coverity.

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

