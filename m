Return-Path: <linux-iio+bounces-22253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A8B19BBA
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 08:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B8118937F0
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008922D4C0;
	Mon,  4 Aug 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/sVRBjF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735A6D1A7
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290386; cv=none; b=Kl2WiZ2zGBJpcpflReeih83UhYiSke8GSFB+7P1/uy/XxuWr70Qb72LWKP8TZOPzrkejwvGvPv2x7V7KMhMrZCRMQvRmRc5bWIrLPs0Y7YIAnCcr82wCyphJW3OEvOyziYWwx+xhyP7J0lv8TeIQ3do9r+UHDNlneLhQLDmZJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290386; c=relaxed/simple;
	bh=16FSOsjxWWjwmsYf2gdsvF1rHYm4Lq4wP/Pa+wmOiBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml59MMmilFykKTyvuaRR/HW1hesJfgHRmII3Q07lUMSYvpLESu10qYT4+36v0Hb6qiiqzOzqG2W6HjU4AczNTHNm8giZTqxPlJdwZi1RuLC0435wfWv1Lv9CA0iZngWDWkPqbs57+NwjtU/FfVq7oVUnsitjtBH+4vpU3pRxHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/sVRBjF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32e14ce168eso28488571fa.1
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754290382; x=1754895182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZ6Q3MpFJQUVjScopoXtBGrsLf+/r2RuD8g/J/cXWkE=;
        b=I/sVRBjFuSWf5/ixkyg80jts7jY79G67XH1D3YN5yjvFp1zN/ep7W78JVR8xRU0nIW
         L1B+mkAtMPpf8r60Smgo763Jtu4Aygs6CyU+EBjj1g9DRVSZMKdwyHGsdsc8+QWHkApo
         oQMa3y7u5EYzVtUA5dSGyfBzPfwDFa5INZ+4z0StYqJqEpYxRa6O3AqOlN1oQ7dLpC75
         WKsFr85g2/73ABP/zD92f6VYEFOj02oaBI0t6K7Z9wWj6EPx2r+QwuPcrGFeQaAeTxj8
         tqD7mPMB35pKbi/ND0IHg3edGAqhkk6aRjTE57EsJk9jBXGCKX/7EngdZcTT+BxyaxH3
         jvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754290382; x=1754895182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ6Q3MpFJQUVjScopoXtBGrsLf+/r2RuD8g/J/cXWkE=;
        b=Yuj4/0hb/ZsqwritHBvfRHsRYDMnky7eML9NEFfGzxefEIRJtFdSejp+5pS0sRjeMH
         mrcgKSKx+H3OZhXuhGFUR6j6KGW2X2OAn0llyzLpGWkkiaYujxPXH/8bk26eHQR+HtjV
         7ncjwyKkWN4juwXo3lzrihAr/ehwnk525vsDJLxBbVl3kfFSgSd7nPaM95ZYWevh884M
         UMlHrbqizpZzUbskjSdVr8BV3klpecWA9Nngv/4yggCNwHMeFF65saZN4mKR7d30/cMY
         QFIQazFYn5/jfc/3V7DJ197pfSWYDz/xY8WFvk7hWBY0ljH+ftSg1qjxTfLmDT15zsiG
         EuqA==
X-Forwarded-Encrypted: i=1; AJvYcCVj/nzXnvzHjM4Vs73w8JXFazvWxMv61Ln0Bcgsq5ocTDvt5F22CzN+d+vCY4j8/1355yLsEf5tGkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqIP99Zfol143h0UOfL34Ab0l42a24+Wce5hPfn2rtaxdpjxNS
	SG1aPLK/BZLYbMrOgyItqKWKee0aVb+r/oUBhp7joz0N7vQCchFKB09+
X-Gm-Gg: ASbGncuZNBTKbt8nMlTDRpgrT6LcqD1mDyDlJqdfyKgUUZEdFKnZr/HqvqRtDdUuqKS
	P67vjtHBw/17seSUAMJ5NcQHhvlhq7FvWq1ScI9w51ON4ZNZNp836OYXOgfsJChoqaOfsgdmqiI
	Lhh0zlhX5mcfMA3br3K5cgk+ZptFrvzfDWf8jRzplSVkFuMy/cBv8p2y7tJKQ0/W1YhPJ5Il7DV
	Ds70VSFO95PPNGYG8gwnqr+DBlLEkLzkxVFNMrEDS/fQg4PjUsDd5zfx1EKWyY/TYuJnT8LgZ30
	6fMWu+AVQnmAcWuvM+esgnOlsHreGX5mGbLeR1DEjY5yDqlUAe1BdQ+XIDzrsd/NOXZ990OjX+l
	tcygP1ZRtc3GLuu7ZmhnOZGPDa4+m9Ivwv99lwpz3Ue/TBCm04edqKb9++aPiPgW9Xg3avmx0hc
	QCXXw=
X-Google-Smtp-Source: AGHT+IGGPVMvaC8Ow5rgtVK7kj7auqDTwRnP7oTmM1QmSGsBIxdJMumn9kAf2xO2DIk2Yvc5RVS3VA==
X-Received: by 2002:a05:651c:418f:b0:32a:6e77:3e57 with SMTP id 38308e7fff4ca-332567bb362mr16906821fa.21.1754290382059;
        Sun, 03 Aug 2025 23:53:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272ff7sm15908871fa.7.2025.08.03.23.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 23:53:00 -0700 (PDT)
Message-ID: <3299b85c-82d2-465a-a4cf-38a06b710804@gmail.com>
Date: Mon, 4 Aug 2025 09:52:58 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] iio: light: vcnl4035: Use a structure to make
 buffer arrangement explicit.
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
 <20250802164436.515988-5-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-5-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using a structure to arrange the data to be passed to
> iio_push_to_buffers_with_timestamp() makes the placement and padding
> explicit, removing the need for comments to explain what is going on.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/light/vcnl4035.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 79ec41b60530..dca229e74725 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -103,7 +103,10 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct vcnl4035_data *data = iio_priv(indio_dev);
>   	/* Ensure naturally aligned timestamp */
> -	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
> +	struct {
> +		u16 chan;
> +		aligned_s64 ts;
> +	} scan;
>   	int val;
>   	int ret;
>   
> @@ -113,8 +116,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
>   			"Trigger consumer can't read from sensor.\n");
>   		goto fail_read;
>   	}
> -	*((u16 *)buffer) = val;
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +	scan.chan = val;
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
>   					iio_get_time_ns(indio_dev));
>   
>   fail_read:

I suppose I was too hasty commenting the previous patch :) Besides, I 
misread the buffer definition. I just thought there were room for the 
u16 and couple of s64s. Hence I suggested a packed struct...

Now, re-reading this and seeing your patch - this looks correct :)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

