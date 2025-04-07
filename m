Return-Path: <linux-iio+bounces-17752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F3A7DC3A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A208173856
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16B23A9B6;
	Mon,  7 Apr 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiF4mnuO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5E23AE8D
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025250; cv=none; b=dVftW9PL8ju4mj3GRkseBOu9xRJZSNxW3l7ec45grceTq5LaWyEn5yhfsmkQPQz74Sv8CJlTQFaj7u7T7QWRkz+SgpV9mX16tqdTlC8m6wTE49FWUlFFTvgCrhDPp8w4mQcaafWeMYNmLes5fkyvuRVYYRvc4ELjpDsCCZIxgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025250; c=relaxed/simple;
	bh=w2j+DBh89JY7DAfb1cJk/KEe4w71hY22xlraFf0sChA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0tPDm0I9uzSnbDBhwLXfskJmp3qppbRcvReWGrhThd8vb566n8oyukOxDgqKRIhTyPQQ36gOAuJPtoefPle8cAPjwJZPESV5q54n2gxeZ/YLomSaf5eLghHyroxWHgGpierOcPCAM3xb4QgUfYMbpKDG0RyiNzYFpVpdcWnpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiF4mnuO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5497590ffbbso9223e87.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025247; x=1744630047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQA2PdPaE3Zv0FK2dsD0vHDASJE1siZiTAvJCzeOkKA=;
        b=BiF4mnuONivNiTqM5DK71Osr3BCbxJ3emLL0DHgdAglhf43sxa8YuW+WVNO+MJGRmd
         6G//gehMlZSfsNQ/qLrAnFyYIlmOiuVQ96w8+gWfL/4ZY2jwco77hFCiD2olka0kB8TB
         Oi1Nc3fCMtv7XsN1n+TG1r/CaK31J+Is3jNNBjYOHDKqG0OTu4dCJFiBcJlQMSQ3F9G9
         /dg6GZNR00iRR33OP0MjaJu/PhCAFELHK9aJnR3nuFC3uaBOYYQhsosUVMIpAaTlZKIX
         nCRQr10EMNXefxwmSbvY04zQhBKO4mLydOr4Ixi8RHl3pSE3n4EZlSVH/R7s9QdGLuq7
         Bwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025247; x=1744630047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQA2PdPaE3Zv0FK2dsD0vHDASJE1siZiTAvJCzeOkKA=;
        b=JXwenMwt984Glu0wX0HBg+qXsqsHXoXEGjmt3O1acJsjSXGss9uf0iZgA0HOR8GJys
         B0FsyFPStPHXxZxGs+bU4r4VZfN/BoDJ21EAzlkM0DT7jfHEP4qA/7xOef0PxhUhyIbG
         RQtmFoBKmjlsJWzd3KgFntjqpUWA3Y+7LvvsEqJ50/7GdO4zY2IMJwRXMPXWV3k2hDor
         n7x+E9p8IJIb8Wo3e514mVALMQReKyDS04ytx+QQltCaAAg2wNnTWWCGVaRWyKWXyXiN
         SV4TmGJn7z2C+vexarx94jlFidjHW+TS292pJLdOKnHd8mC9IbLxqxTYHCANEl+zLXt5
         pQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCtDKTYW53JkSzWL/wgKK1neDHi0Ux0syB3QFb6kQ8wuWWBF35kb1DyGTtiEtLpAaD6iyQCm46J6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KkewlO2J3PqdTUGl+okLG8el1qvpAGYlL/wNvG1fCTq3a5xT
	Zx2jDQjD7zVTLAEbVluW6CepO33I+Iw9TGkIU/A2zSroWnJmg0BS
X-Gm-Gg: ASbGnct/7lvU3AZUSpN4Jg6ugnma+kEq9EIsuBduo/NcHXJ9m2nOKAp0+5Hh3mOBZTa
	wYHxlzFxs4rbeDojFyvOE8InM8OzTbsnjlzjBH2RdcBxlM7l1FtJaXwIAobDmy2Vumw72DHgR35
	kHstv0oA/IPrP+LyiWXPGGrMejcR0NBxAIp/hwaamc9t+YqJXR/PLJ/3b31OzjUYyh+ZSEgtq+p
	rq4YbgKEiQKL/6JOc02OSo9yudvokGMngyGe0UuZHIUqCwgTXQU2/jF6eknQteQAdp0i0G18OMs
	ucFa2t0HpUXlH0nUYRv/zn+b2LBOMe/46lxi/7X1Q4vExS964eQfE7B9SI15Ro1zWIzoAHl6Re8
	m874YAmbjv8aMJLQWmafGnK33gA==
X-Google-Smtp-Source: AGHT+IFzQrKfuX/kUMeRDrSxrMEko2sAeuR4rr0unXoF1A/2Gp4VaGYBKK50ES4gaJectUrhrjnA1A==
X-Received: by 2002:a2e:a9a2:0:b0:30c:2e21:9958 with SMTP id 38308e7fff4ca-30f0c03c909mr35370641fa.32.1744025246499;
        Mon, 07 Apr 2025 04:27:26 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314b6b7sm15415551fa.56.2025.04.07.04.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 04:27:26 -0700 (PDT)
Message-ID: <4a3bd5c8-262b-4486-97ae-c6ec688c4dc6@gmail.com>
Date: Mon, 7 Apr 2025 14:27:25 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] iio: pressure: Use iio_push_to_buffers_with_ts()
 to provide length for runtime checks.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-20-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250406172001.2167607-20-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2025 20:20, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new function allows us to perform debug checks in the helper to ensure
> that the overrun does not occur.  Use it in all the simple cases where
> either a static buffer or a structure is used in the drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

For the ROHM BM1390:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

Yours,
	-- Matti

