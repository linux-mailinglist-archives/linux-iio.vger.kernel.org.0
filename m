Return-Path: <linux-iio+bounces-19227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5ADAAD7E1
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2233F7B426B
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18DA214A6F;
	Wed,  7 May 2025 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK45uTdw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17620C48D;
	Wed,  7 May 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602672; cv=none; b=GwaEyPXnI11tu++7SdLAQimoiWxh1YIjkzBWgI0M9uqBJmT7haxgewYWnD92CmfICVStk98NzKym2mGtUbplC7J36qTN2+eSW0GLrupKQZRUe76FCpzXP+BhonbzdXRcz1moAWQYrUnODgAk3PQ3wobqhg3jpkvRMtQ7qVB1FIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602672; c=relaxed/simple;
	bh=eL+3ZL1xhHCfwrllCnsVU7U/Mj3B44v54kzTtHbql9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fR13Uw+N4T7HnGMyDArxtr+v8U21MLTyzBe6IBIUyQzwrk8mhrat6atobPeFhiU398vn2ZIKKAXz8SOUYW1LjzfDfWH0hll2xDOrMu36JqPOYvxu66TZXDMIoetxQvVfIAirZd6eP1bayYyOuVaZZuV7dgBkFQTC+/kATmroSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK45uTdw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so4332945e9.1;
        Wed, 07 May 2025 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746602669; x=1747207469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XbGOM+5j9DljoawcsNITwWaLqQVpAIHR+pSXDo1606Q=;
        b=CK45uTdwl6NLOqo3SV8MYlwdDIz6fuEoUK++MPBTj4G5aQNbzfO+4pJF6A2MnIAD81
         DILIdxPEB3TuwGONWpSIrlIUuV1nIcjYu1eIQKgGcEZJ5Qa9ewigc/Y+pFA0z9kb6DYI
         wk0Y45vMtRJjyRD8WkuJKF5G9dUCZ2QoB0Lqi2TAQPZyNTopOyp7RaKtHipZeCtLPLR5
         zN2X23pokiQvgCkq1a/8mPQcAfRnqunFXQvkL+iXY2QD9BPAiZyDxTmM0UWKsrvuRl95
         VICLhbga6yQhzqy2s15gPXNqeote+xNqsT68d6O/LIYiFPj0T9BOB+LmULtD66oAo23S
         TuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602669; x=1747207469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbGOM+5j9DljoawcsNITwWaLqQVpAIHR+pSXDo1606Q=;
        b=gpea6y5MErMyKpjSyyVRF9j5m9IkES/dPmfXXnAXZ3BFgHFOn9JFKg48Gc5LiBfEoX
         UqLiFsGdkFRLHU5R4/ZR/7CufDFeyzmSiQ+BmW+nPxKPWSN3lCbNuUkkLsSAtuhD8SXI
         4KqRn2b+n5mshmYENFM+PRZHJs0XUPPJjWjTbYHp9WlsuZMht3/WC3GrIb3pfeGYOfgu
         hIGMB1f0qgU6Qct4HrMIrIZcCHuu6GmPo+PrXx59zKwmBn9yymIndjQiG6zePmfI23hx
         3msCJZXEEk4NEE8ga1Ci5PTPKoAnAqVx5kHBfVI+D5j2g8qWOYcEj947u6rByHy38cvJ
         DpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0CYBRJoPtJ/gYmvMT9V5uPbYoyH49FeRtFc0B2ipc7QyIEyQGeLv8SIDys39j99wY7UVBxC/B9I8=@vger.kernel.org, AJvYcCXrQvEGhGMJ8dzZjC5l4B18B6t6gscePIWgXqdRuc5cZl7TMfc5W43v2QwIzdxAku088X6TnQzXpSzJyI6G@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrOLyeUu4jJz9eEfyBPBE9ma2Z91zJFZkaTsDetHMMHB/tPRn
	UBtPzeh3S+CgZsHNR5NMbkg/IOFOkmBh1R+6MOkwHs1IgWPH80ox
X-Gm-Gg: ASbGnctnsVjale82Tl0it8ZcMvNSLiJHz/fkTE/8qO2jnowlfl3jPg2EzkcwUdRgRSH
	U/rwTmOXfDqy+XjbfeFACkfl9GgJM19IcGI0bU9Auuvu7RiDyx8dMWoNICLOOMB6o7uOjOD0Fsq
	c7FKl/N3uOif16v8/hUAer9un218qi/dniRG3pSxoroknx7M4Yew4xumrRa6tSuLfDjx8QWQDpM
	W+XRfq86bpCdQnmdwebEQg5GA4mWg1bbgehIooo8LznwNt1hFfnCDfyORTUrEbZmq+fawpuv2jM
	+NzmFfYu6VWffdn7bo1vT5r6qm3N0QeWk1YyI1lriCtKuMBGrUqTVmHW+ccO5hzsy18VnAsrxSu
	zmHMS68926WI0sys=
X-Google-Smtp-Source: AGHT+IHmtJRYo7J1NRPVLlws65MS91lxXsFbUL0vBq7K20lHdwXV2pWj4OoYN2xYkz2zzIKMVRp2/Q==
X-Received: by 2002:a05:600c:2e52:b0:43c:ec72:3daf with SMTP id 5b1f17b1804b1-441d3a78febmr17516365e9.14.1746602668754;
        Wed, 07 May 2025 00:24:28 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d433e9efsm21630205e9.3.2025.05.07.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:24:28 -0700 (PDT)
Message-ID: <4dad5856ae822e2f6dc5786846e4347668434863.camel@gmail.com>
Subject: Re: [PATCH] iio: bmp280: zero-init buffer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org, Dan Carpenter
 <dan.carpenter@linaro.org>
Date: Wed, 07 May 2025 07:24:52 +0100
In-Reply-To: <20250506-iio-pressure-bmp280-zero-init-buffer-v1-1-0935c31558ac@baylibre.com>
References: 
	<20250506-iio-pressure-bmp280-zero-init-buffer-v1-1-0935c31558ac@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-06 at 13:49 -0500, David Lechner wrote:
> Zero-initialize the buffer used with iio_push_to_buffers_with_ts(). The
> struct used for the buffer has holes in it, so we need to make sure that
> the holes are zeroed out rather than containing uninitialized data from
> the stack.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-iio/aBoBR5D1UMjsSUfZ@stanley.mounta=
in/
> Fixes: 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> The patch this fixes is currently in iio/togreg, so no need for stable
> backport, etc.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/pressure/bmp280-core.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-
> core.c
> index
> 5728cc18cced223284a2c41dc6dec6f47169c797..f37f20776c89173b0b2a8e28be0ef9a=
a30ceea53
> 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1237,6 +1237,9 @@ static irqreturn_t bme280_trigger_handler(int irq, =
void *p)
> =C2=A0	} buffer;
> =C2=A0	int ret;
> =C2=A0
> +	/* Don't leak uninitialized stack to userspace. */
> +	memset(&buffer, 0, sizeof(buffer));
> +
> =C2=A0	guard(mutex)(&data->lock);
> =C2=A0
> =C2=A0	/* Burst read data registers */
>=20
> ---
> base-commit: 7a175d9667b21b2495913ec7496a6c20aa7a4a89
> change-id: 20250506-iio-pressure-bmp280-zero-init-buffer-942dd4f48719
>=20
> Best regards,


