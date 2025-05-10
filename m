Return-Path: <linux-iio+bounces-19405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B167AB24F9
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B82F4A50F6
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79923505D;
	Sat, 10 May 2025 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkRTXQLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B571DAC81
	for <linux-iio@vger.kernel.org>; Sat, 10 May 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902294; cv=none; b=RgabLusvPIAXszlMPhTeiYt8vPLmEe5Npkt0hLLZrbMHQmn45bHL2Fwm0SA9GDfBNlzyHFDThPjQGOkO1sF+XHdM6GPF1fMDuA9fOvFxRUSdvYmS44uO7aqwRZnJnbMM6JEyJmi2ZJWfFzuPYgGV63VIHDtK7K3OdfV4aILz+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902294; c=relaxed/simple;
	bh=67T8NxaQfwURFlMkEOUL1t253v77PhEorguM82Vq72A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDIaY+iPu2RJYN3XTiB7iJ435KEj6DFPKepG7yLhpDau/1utaDYFBeL2A86DzpnGVqdlQJqkg+FHry4j7d0uJKwn22xef93925ycfErk+Xz3xWN/+4m3m+DBkzcmM8aH9DMPrhaZhz+D/QgQ4c+SsY3qsZ7lCF+FzukvZKHlxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkRTXQLJ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4c4e1f16833so1044232137.0
        for <linux-iio@vger.kernel.org>; Sat, 10 May 2025 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902292; x=1747507092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wv07qY3/JCsm61xkaVg3QtsQpY18pZXiicSgccO4xig=;
        b=NkRTXQLJhWiKBmFN1XUNVuhnl/f+pAlkqHqVdCDwVVbSuaEHGWlqgZ+qgNtSRAjOGW
         7dczYrXQCe98SZt/Ra4tOft4mBNiJNRGvCSgqiXVRN1kYx3NoqW2RnpMovXDAplgsLMi
         8pV2A1BDUXSv90pRH1rwlCBLPvLw8wr+e9e3gqJiQP5TlXzUgllr6jIbWg7JisTAQJwJ
         4yWnYz3y+TI0gKPBy3uLyeEgu3+0AMPghrqp2SHSbR1Ab/qCAqTG0yv8kqg7ouPVX5Kt
         zWn0S9agRp3oU+WKEl4bn0JcaLx3r61hD3FKBW1r5a5xL+mplfP8yfOHNEM+94o7/k/i
         g9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902292; x=1747507092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv07qY3/JCsm61xkaVg3QtsQpY18pZXiicSgccO4xig=;
        b=g9szbxvNYSeAgTkgcu3ykO3c+YtvVCLgE5Beg5Ctwpn6YwL4eop6VoceQngLXv+enB
         S0CxR/i8Sg0ohCrCV/scHTIQqY1XOIurbQM/J+IZE7IL2tIYtVeX1K8i86lFNERKglwb
         YuXfXiCdsfhdTAS6LpQZJ98QX6Qc4+wZ0Am6xLpU7OZ1WOPxyyZ4ssHwVmb2nMofzZqW
         rt7jR5B0kQwG1lcHcKW0YMoU85CvF0U/oD76DXsIakuAqacZKnZ0PKn/pzudN0NDGoKM
         pfsXt7NlBenjUzhsAUSXV7Owt7sNp0vJJxq+i8oK/yqQT4nA0uejOLbNHRZl1OybOg3Y
         sk3w==
X-Forwarded-Encrypted: i=1; AJvYcCV2o03CVbvSUTzN7lMl+E8cWSyq88Fd7SLGoIgI6hPNdCNV4yEO/B3YYesIAG5dcDJdd51rqlS9Ucs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRywVsDDavjDNsJ3Xvxn7hZa/3pBz7AD5zkMOhGDDgs2jKXn0
	DeVrlEfyoVtY9cpbneM75HzjLA4QEroQ/UT/Qa1HLpjeehHRPEXQ
X-Gm-Gg: ASbGncvSb7zYGr5BxevL40TalDz/dKSmzGzvcgqpUWEvoOxVrMN8QPZyEL2nHBO65kL
	5W5Ar+VEGbIJzhaM3jzDt3PGU5BRns8d67hRj2JuDX9CHCgWpVZ4Uua4UBDUyqiC8xRDe6kiUUB
	HFIvF/GWY5Mkl51LtsiRE3QovJbpKMNEVsEEbCMhWN/k/yWSxUVLEGBXH7kaXvRQxwne3DNLz6F
	uuJJy2+HQLpgOEZuuMEYSkw+hBVvhuwSUBQfRL77kLIoeFlnKPeh7lndCRmLw6WMDGplrNTMbrA
	CdR6E8ZKVqMzrZPZWTuFjYc1eKHSs2qP3jbION1u61gqzWB5jx21pmjit09D
X-Google-Smtp-Source: AGHT+IHR3FolTbHhofRA78qMSlUhMhQoCPCQdG0SkN44AhyMzzdUayBonBrQeYOeAd92eDFszzBVQQ==
X-Received: by 2002:a05:6102:fa8:b0:4ba:974c:891e with SMTP id ada2fe7eead31-4deed3cf7a4mr6097232137.17.1746902291800;
        Sat, 10 May 2025 11:38:11 -0700 (PDT)
Received: from localhost ([2804:30c:404b:a800:55e1:4221:1a82:c6cf])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-879f6297d64sm2837230241.30.2025.05.10.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:38:10 -0700 (PDT)
Date: Sat, 10 May 2025 15:39:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Isabella Caselli <bellacaselli20@gmail.com>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, rodrigo.michelassi@usp.br
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to use
 shared xfer logic
Message-ID: <aB-dZecEekMsAEWj@debian-BULLSEYE-live-builder-AMD64>
References: <20250507184539.54658-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507184539.54658-1-bellacaselli20@gmail.com>

Hi Isabella, Rodrigo,

This patch looks okay to me. Though, I think Jean-Baptiste made a valid point in
v1 about inv_mpu_i2c_master_xfer() not implying any specific slave slot
previously. I'd suggest to add a slv parameter to inv_mpu_i2c_master_xfer(), but
that wouldn't make much difference since inv_mpu_aux_read/write() are still
hardcoded for SLV 0.
Besides that, I have one minor comment that's probably not a reason for a v4 if
this is deemed to be good.

Regards,
Marcelo

On 05/07, Isabella Caselli wrote:
> Refactors inv_mpu_aux_read() and inv_mpu_aux_write() to extract the common
> I2C transfer sequence into inv_mpu_i2c_master_xfer(), which now handles
> starting and stopping the I2C master, waiting for completion, disabling
> SLV0, and checking for NACK errors.
> 
> This refactoring removes code duplication and improves maintainability.
> No functional changes are intended.
> 
> Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
> Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> ---
...
>  static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
>  {
> @@ -23,6 +25,7 @@ static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
>  	uint8_t d;
>  	unsigned int user_ctrl;
>  	int ret;
> +	unsigned int status;
I'd declare status above ret, or together with user_ctrl.
Just minor code style thing.

