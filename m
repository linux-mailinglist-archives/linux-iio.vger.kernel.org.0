Return-Path: <linux-iio+bounces-22254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E0B19BD2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 08:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A4618984FE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E65154BF5;
	Mon,  4 Aug 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsUmGiEG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A822A7F1
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290673; cv=none; b=Li1ff9DybImgluPtO7RZw0578ejZAthIR0g2+cHk6R5LC296AJAt6BiL41koP8NB7KiRg0KQT8Pnm1LsdboCKixWX0jeDNi1aUoSwRbfum3LnpeJpmooYn5E5CcPwBHiynxwTAxI2sgrD4KczP4RevdP1sGwkL8GoNHfcHTmyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290673; c=relaxed/simple;
	bh=W0QmWFP65Lg11nw+mdgZzYNeH+rewmh9qfkk3S0MhVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwRk9rzfL7Mism6AABf+QxaLzW1xu6V/eX0rXBc0ZL29vN1mVGaAuFNadedRl+G6owWBpyTY9MXZ4jGRl76XKakWI4YnI150SBgYygAdbTKIEn6xptWUMv0T/EfZfQadNrt0BieNQyjMVtMvkSzBNkrmi/g8DfC7kJcfywURC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsUmGiEG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b9a3e69d3so2037761e87.0
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754290670; x=1754895470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kra33BD0Hc8OPPyaCY/fbqFlcXtBNE+FCE+aJERRnKM=;
        b=nsUmGiEGlgvsJlSajmXe9kxCUzGFWbD21LL36HMwMkO4hMYTjzMmBNx3GHEDXAsRn7
         bWYFPcV91MoQJvNli4Vu8IxF5seEJUJFUaeJfoDu6Sp9TWraXqatzkRv3dzUBbzgnSYu
         GggM+hK890iMon54D330WECbnXFQyjZQcKcWUc5sTFKrouaK4m9eVJ9xndawBYcddySa
         T5DBTKh3hCuVBXCiGBg0R5KUYBGt8rFap9PDNcUWPlDtSuqpwoB4LnDrtjOAi3FtA0f5
         vOhUbIkwCdkvzHinSk8cYbKzDzA/nwk00icAeYoS7gbDhPR7fszp7+vkyABoBAkECRbL
         BSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754290670; x=1754895470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kra33BD0Hc8OPPyaCY/fbqFlcXtBNE+FCE+aJERRnKM=;
        b=iXI1fTP1iWAws876HAy64cDvLrbMRH+n2qlGL3rlmoa6xvJOy+WrYvL5jKXdtG7696
         DM7ke6LQgagVEB691Gb1wXGc98H11GeXJuyQqL+UWaOuBHGhurQ5gO6qr5XM+EHOZAJn
         6iPoKlX0MIT6HHAQIEwooIHvvj+hpZUgerjulbrf3AAFSOPzKtI4ZK/6uOvnYKg1X1n8
         NTXa+I2qyqdkhvMofc8Lo1mmBiY4Cj0P1mV1ysp8FVhib7yD2qGMRu1UGOFJ4rARON8A
         a/x84SyL/TpC4fFpGtagRoVytcrbj0bf1yTjv3TVFHxwmsaCV4V6dx+2J0/9LBx1Ygo8
         JT+A==
X-Forwarded-Encrypted: i=1; AJvYcCWibI4szAPWr5S/hAZe1jW+ZZGA72biClq0jHQpqjGxAQH0iI4UwlfrTVwHc/0IjOPwCcGM8JIiJUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0hU8sxjKk8Nmz3vRQMySQ2b44iRcYn468scm2CfPi+q4+KZ6
	iXu6/yuqCLckXqVB+JSNk29k/QN1tXctRFqtAUSdRVK3dGuhFhahJK9R
X-Gm-Gg: ASbGnctut0iIItpyeTdYh3XQN0IEqbi0L5EEsR+4ezEa4GrsUmq3Bjl+ay5BuVpk95i
	WOzdjl2kD/BLUEv6M28cTXuaa5HmyfYE5pUG6NPnGs4DbhSx0zw+QieTV8YpuYRU1Yg5DVe8+d8
	W7JjA5LRHuzF19u+N89ufMKVZT9PdpC3uazrTgCqc5t1T5nuAWNVm0OnTMyH6x7T0tA1oyO7w3I
	LJj9+VZjoQeaTY2JKExWTbS4JFrzqSm4QwnXc32G/DnGNyDTzpxlmANfEbpGjkyaLquxXaheoxU
	/qiSKG4uwGSDIHxxQVUPdDIwwRJeoEZiocKl/5P7hmKOUKzRBh6ahNS/DpahDKSRpsKGfTEnfKt
	cXmJtBnqGaYyuOhdaguQr43+oKCJRESyKKhLu+LsMi7ITK8OY9JseSqk+MlNz3m46epBifHpaEx
	0xNgU=
X-Google-Smtp-Source: AGHT+IHJqezOMkgAxbx7a6wMR2J/Ieu01Ajq7wxFPw282ihXpsaWkyEXXf8RPmr6zlf8wnWA09tBGA==
X-Received: by 2002:a05:6512:10d5:b0:55b:5c62:c7d2 with SMTP id 2adb3069b0e04-55b97b7422cmr1937939e87.39.1754290669555;
        Sun, 03 Aug 2025 23:57:49 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3214sm1566680e87.126.2025.08.03.23.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 23:57:47 -0700 (PDT)
Message-ID: <5388ed7a-4555-4932-9f31-d7d25e5d8474@gmail.com>
Date: Mon, 4 Aug 2025 09:57:46 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] iio: light: vcnl4035: Use
 iio_push_to_buffers_with_ts() to allow runtime source buffer size check.
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
 <20250802164436.515988-6-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-6-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As the sizing of the source data has to include space for an aligned
> timestamp it is a common source of bugs.  Using this new function that
> takes the size of the provided buffer enables runtime checks for
> possible bugs.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/light/vcnl4035.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index dca229e74725..2ebc1e9496f3 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -117,8 +117,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
>   		goto fail_read;
>   	}
>   	scan.chan = val;
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> -					iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				    iio_get_time_ns(indio_dev));
>   
>   fail_read:
>   	iio_trigger_notify_done(indio_dev->trig);

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

(Although, seeing there is 3 patches touching the same spot, I might 
squash the patch 04/16 with the 03/16. I would leave this one as a 
standalone so the fix can be backported without this new API, if needed).

Yours,
	-- Matti

