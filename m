Return-Path: <linux-iio+bounces-22256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678AB19BE3
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 09:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CEA18931DA
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5912248B0;
	Mon,  4 Aug 2025 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIhRYiYa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581313D3B3
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291087; cv=none; b=i9Wi8DIuQRZ2AMkwT/dyh3l9U2ixhs5XnXy3MmOKCvo1crKL1Z5gprocRA3wxtTs3Ee/pvPlDq/xQV8tzWon8fqHS2DJXE0SnyhsOjoujL/b/dd8xb1msvXufQ5ICMDAxE8Ky+LZ2SBL5xRcs99rbk31y3h/ZIc90nxOEi9yEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291087; c=relaxed/simple;
	bh=cm6bZ2dPRAXqLhGBfE2bMgTTXCHGN24TOIiCFUSZtwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdeAGl9PI44XoSQESmgFZ2J69u8ECJQ84lKsxdDNz5VTXnxXfaOWM7kz94sdgqc0AcQGaSpxMVIWllL9OOoSemYOlXnm/grfA0XMMZtg+GIZXkAG99EWQPAW8C+cbVX1lhGNVcxyfEqnZ9HmtwebWZdsAtIs4KuDDGsR3s0e85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIhRYiYa; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-33229f67729so33573381fa.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291083; x=1754895883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFKqQONYfMdt0FNGu4rUVXjva+W8LzWbQ6t1oIC2wbc=;
        b=lIhRYiYaN+qTpEuyuEGUomtvJ1ql1V2inUbFku/3yD6mGIMQkArKgM7XOTYNgS9GrH
         Hkv6jvuf22nt6txnR8iNgq2aGO9wKdFBsr/IC1daHvwk/Llp15M3CxkRdDIw7yJUJVwk
         sk3OQ5/+O3u6ti/sThM5mNdkrwarqVzETL6ZW7dHiooTCBQvggflRkGvXl4DEGKeQafV
         8m/olb7efzKvAYCKIIJk7OkD1oEMUE5a84FIWR3ZyadtnBi6ARyLhTgoEsYEh5YDJbzQ
         nBZE1LDqjS8Ju1ZSwUg7VMJcrV9Y+DS/e0Sxin9QWunYMK55uaNvpHImvOPy+oWf2iZI
         AsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291083; x=1754895883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFKqQONYfMdt0FNGu4rUVXjva+W8LzWbQ6t1oIC2wbc=;
        b=OfNTSNAHoFY/PLo8PDUUeLA9Ez3zwtdqfwyi3AOQqZ9729aGJ220L/IYGevb9WHaOd
         5j6WjXYMPcnoweVhpnQTNFiMMOhmBA4KpHXRd1iE0dX4l1TA229XzpWeWUEjf3Sf4u4Y
         BRhfFQpOcjBCBrW8QBOrO9b/XZvOCeUHf04JQtya1jSSIXczQ3FXGhunSKLJeDJM++/o
         FdkpaCbMvjbpC651B2zeQCSnc6KNga5mCfvevlMDJDjjI/N6HmnQYbtfEgpeaVqudTXc
         avBSB759VJgIrKjDHlKPDFm15TbgE4559h2FKseK3QbPUDA0OvU74Cu70GKH/E2naIsb
         cTHA==
X-Forwarded-Encrypted: i=1; AJvYcCWDVXWfqxVXiJmv4jNvdt3TJRq3xcjArAR0zEFdj/NjPQKea5bHpOnt3UM/qIXVFwkvbGEzt+p8zHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRZQ8CebI0OELuU9u9+KbCp3Xklty95L9w2gfY5lXvd5rgs2d
	U46DiMN3nyJw7YJAK4rlVLVIN+JonD0eevUkUerflUOdlsNuXGRr/Ezb
X-Gm-Gg: ASbGncsBTh9txuVTB9eTZXjlYFJ+WPPvqAM+aHETkh9NSYgPR+uynmbMgfrMPKYiFAg
	DodsRGtmyxWF+geUN1gbzlN/oR/HZmgrc30+IMqejEis3FCNdE27oA8sGJV2aVnZFf8Ih8gqGVp
	98Zxx2UBmGFABbQ8ylvWL110gnLUtjmDwsP7JmRayZxUTGrhiIUp5MUQcoJhUfNATCGSkPUijEZ
	gMe+4uoFEdM2WgrD7ohWRDbdB6HTQv6jkhAMRPAm9YxABM57o+Pu0PQ8gLtM7MbHI5M0CXt5+BG
	8fMnjIuSMQzTSRXMMJX5q61J3vaGUEeVjccCCZ/rQMCkLBdE1u4pfd6dqbwfZhQB70lH5AdCmBb
	qkQtFpt38kTRApCyFnu8OnAvJR4/D2DZNRoBom/N706XAlH40XKst7f6MFddWsT6oxPCvXRNvZv
	mp/AE=
X-Google-Smtp-Source: AGHT+IFSlXveaShlxfCCceK7Z47PL8hX3BGCHilI8R8U2t9TYd99g4+u+NfpqxHoe+Af/62IThh8TA==
X-Received: by 2002:a05:6512:3e14:b0:553:aa2d:1af5 with SMTP id 2adb3069b0e04-55b97abd645mr2210880e87.8.1754291083216;
        Mon, 04 Aug 2025 00:04:43 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898be9bsm1531941e87.12.2025.08.04.00.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:04:41 -0700 (PDT)
Message-ID: <2cf08478-ee73-45d0-b922-617349d33a7a@gmail.com>
Date: Mon, 4 Aug 2025 10:04:40 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] iio: light: adjd_s311: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost
 <astrid.rost@axis.com>, =?UTF-8?Q?M=C3=A5rten_Lindahl?=
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250802164436.515988-1-jic23@kernel.org>
 <20250802164436.515988-9-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-9-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/light/adjd_s311.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index cf96e3dd8bc6..edb3d9dc8bed 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -54,10 +54,6 @@
>   
>   struct adjd_s311_data {
>   	struct i2c_client *client;
> -	struct {
> -		s16 chans[4];
> -		aligned_s64 ts;
> -	} scan;
>   };
>   
>   enum adjd_s311_channel_idx {
> @@ -120,6 +116,10 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>   	struct adjd_s311_data *data = iio_priv(indio_dev);
>   	s64 time_ns = iio_get_time_ns(indio_dev);
>   	int i, j = 0;
> +	struct {
> +		s16 chans[4];
> +		aligned_s64 ts;
> +	} scan = { };
>   
>   	int ret = adjd_s311_req_data(indio_dev);
>   	if (ret < 0)
> @@ -131,10 +131,10 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>   		if (ret < 0)
>   			goto done;
>   
> -		data->scan.chans[j++] = ret & ADJD_S311_DATA_MASK;
> +		scan.chans[j++] = ret & ADJD_S311_DATA_MASK;
>   	}
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), time_ns);
>   
>   done:
>   	iio_trigger_notify_done(indio_dev->trig);

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


