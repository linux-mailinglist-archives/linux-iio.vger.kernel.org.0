Return-Path: <linux-iio+bounces-16653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641DCA58C1D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 07:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082D21887EAF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 06:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B11C3029;
	Mon, 10 Mar 2025 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="IfLuMKx1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A31A724C
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588536; cv=none; b=h5r9VWC4D29q8YFaBhZtMelddQR7+axDWhrgjvocUMwFqBmL0MqZBM+6lBDHUNu9Ktbxi9Tklj6pjt0EWhgwsMwSIDR6PWmQezEPRwp4dOAB/bv+U61rUD7dyJHUpNCnmmv7gtoW0KsJU+uiAOqSpM/8wKnUSdKQnM8JNvnBlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588536; c=relaxed/simple;
	bh=bIQwfdLshzTrg72Kb9LLJ+0ZGFmb2KLyvEDo06YuNlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQQlYUO7sBzLIZY9c+GVtLcq7L/vxnH+RLExToxKKYrIxRu1vkc1DqlBeYrDkZEKaMx41xjNoVnIkBCybaJdJKmSP5i3uxNWrRrNCsvZfYCt8OUcA5+EDg0kN6mZ53bO1s3BPcxM6xN9KyIirLIfC7fC+/WRjnGYUGilmkOACNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=IfLuMKx1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2235189adaeso62146045ad.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Mar 2025 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1741588534; x=1742193334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HF7sCj99eRzG9ml1RhlYaK1ar+j7RYIhrhxiKhpleY=;
        b=IfLuMKx1L63reGTDc7U/3qedaCP6h5hS2clk4TVggPC5/BejrNpWOx933wlXx80Aqf
         HOmzu7cABnb7polkSrpGLMXjU3jMQeiH7X28NJWXee8NdYA9EndE+bW1ie2tGNdGvW7W
         RTLn13DSNkEROswlJcnncYumsdRKOuQVTbHeZKI9T9snldB9mxASGr3cuJe7AXdguA+V
         YGVWEtavB4hItY8N24Hf66KkasuDL07mcGeb4lu7X7PO3l0JGczJkwCeI4OeKzJmEJAx
         tP0l1EZlalL7dmafyRgGBtOliokFlYD83UCU/SMzGXH1hZzdbHd/GCGAxEPz3RRK0p7q
         c/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741588534; x=1742193334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HF7sCj99eRzG9ml1RhlYaK1ar+j7RYIhrhxiKhpleY=;
        b=pJtWSsKFuIOvAEIY2IGZM8xEB2MGAYcU6+lvuivfN6k9jq3SWZmQJWyyDT/HslVReQ
         caEADvrPIDEVZTdWm4eLMXlFkE1h4CyDlDGFHpWxg6nTEtg6/c6fEZJjDevDreKXn2Au
         /rX7ugzRcc9yhU09/j/ALIc0+79AXs0iKsBPt5v2RocD/9D39hK/67cViNqG7moGpJ8j
         FaQiErnBoUI37StWbBpV8kARHTbiEd4DfwQMDFf55w0cFmEd/qjPnd71NwwUlU17MeBB
         0ZoP+TfujlQy+bikWYGFLjoI9kD0ngp1G76RgMGN6tCFbV1nwQARJYigHBGhdLfcDF1y
         H8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8AYXClDhpQ03TG9tbJPwMa1E4dInlGO+snHYK17pLsvq0rveG+uQf2vHDtA7R7J1GYM1w4lfc3Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4OlKeQRx0BEZnWfT7qTaUF/Rr+TqSdv/Rna70/w1GjU0f2tZ
	zu4HqXYzb0Ks6ZTwLusLDX1Ngg13X/50q3k4dHnMstZsEAJooJve64AGVyxFysgyfWaNn3wyXql
	/
X-Gm-Gg: ASbGncsMF9gYdwTWmU0C2CUC4SfKvTzrR23rkxLAbugUgPk0F6MRMaBIiHpswbanovC
	Km3vuXC6+Po82M7wHQJA8sYa5tR1tHGSvD+isZoYYkHy60+xnYgJzSXboj9u9nXc3+Eal1KlQR3
	3ZGW94uzo/QZ6TIIinNxe9CLvZht+DXVGawuXPfoD1hzqa9OGfG9tK3HdRX1XFgeQ4YT00Xn2KB
	1TCDzWYEftd/c92zE5eOtrc2qFYcoWhI5cGJl9ZP0rk3D2Tfq2KpwLNuVq9BG26Va6gzRLJ+Y8a
	zIiBZkSnKn8ligTspdfLy/BZd5AeqLtvQof7U5K6Lz2kn83AlfY87s8YWlHDaf49mT6m2gOt+lK
	JsuU0B49qkvIjTQS/8wItABowyHSEbZ8cVY0/
X-Google-Smtp-Source: AGHT+IFmwf3Brcn1RTjN1N9hnsmCbEIxKk93yJeBiTcRGqn7XilnRC6euWn4X610XM21AoRV9TlecA==
X-Received: by 2002:a17:902:d48a:b0:215:758c:52e8 with SMTP id d9443c01a7336-22462a488fcmr149371145ad.12.1741588533571;
        Sun, 09 Mar 2025 23:35:33 -0700 (PDT)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8a86sm69585135ad.240.2025.03.09.23.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 23:35:33 -0700 (PDT)
Message-ID: <5ecd4fc5-a35f-4a2a-87c9-4d0fcb14771e@tweaklogic.com>
Date: Mon, 10 Mar 2025 17:05:50 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] iio: light: apds9306: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-2-jic23@kernel.org>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20250309170633.1347476-2-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 03:36, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
>   drivers/iio/light/apds9306.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 69a0d609cffc..fca7e73a905c 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -831,11 +831,10 @@ static int apds9306_read_raw(struct iio_dev *indio_dev,
>   		 * Changing device parameters during adc operation, resets
>   		 * the ADC which has to avoided.
>   		 */
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>   		ret = apds9306_read_data(data, val, reg);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>   		if (ret)
>   			return ret;
>   
Thank you Jonathan.

