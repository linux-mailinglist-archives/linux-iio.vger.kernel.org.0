Return-Path: <linux-iio+bounces-17475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A6DA767E4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772E21887DB0
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E052139C9;
	Mon, 31 Mar 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QdUINmuU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D021322E
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431497; cv=none; b=mPkmVNmzF/w97up1o1+oasL12YlNEmTnconnxygkh52VU37c83pnXz4adaXwHZ1TQd8hnwEVNklAP4W3Jz/n6SJYMWU0FLTDuDX64QVm3/ruj6wNExt8H5yMsvQd2w3g51tfMGyQwqFJm8JgQ75qlzLS5axaj1U5DJ8hy9RocCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431497; c=relaxed/simple;
	bh=z2LDdJdfNFEkJ/VQ0ieR6p5JsqEbGl0ntasJYEEDs70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhJ0N25lajLHNT85oBQWeeYRo7OGf6y1qEaMtZdCPjaMago3Mm0nr9YTbgk3HoM9yQ3AOCW/asKF+tiWccuH2G7CGc2XhIqGeJOEogKyPIVEjtziqJodAwjFJqPZOBONRn2Amrwd2NkHvwQmWD3121IjY6g3+m9inrRA7+uRgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QdUINmuU; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72bceb93f2fso3020654a34.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743431494; x=1744036294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ooIPgm7B5ljqGfakFo/aO/dI4rLdCrS6Ld8QeU8Gqo=;
        b=QdUINmuUQ15tEewfDEMPrJfmMuKoEFs59yUqFsefjy981IagMkW/uDfq572XDObHB3
         g4APVf5MDTP55pENg3yxrKLdT6z1Z8gx+o8dpcB/xeXzlluvU4+2KOHYVZkYDwReXlhz
         RuZHIjZReno8ydZrmRC7UdCAcouZyVAwhagX2vMMN2U9ZWVRlk6vRZZ5xbUGnMgSKFgR
         VCD2HFNaBxJL3N7LytxAugQy353vr+Imy6JFwmsbLCw9FLMLWVIoZVA9Xe6NAwpXZ3S8
         WYraDWNqvtBoDO11LFlx5or7BfyAM4KrlV84eWNh6/MpZ6DEFr/7fLrxm/Xjlv9NulIJ
         kb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431494; x=1744036294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ooIPgm7B5ljqGfakFo/aO/dI4rLdCrS6Ld8QeU8Gqo=;
        b=COPNWMBFR6RI7OQnjA6NFvQzolsi+vuCNOWlyJU/prgAVQw2de8vsJG9yq9sHJ/MJz
         a7kWJ/MDv2ePtn02CHC0S+9pktdXIue/WyhPCR8KOa0Tko9Gnn8yJ8AYPQZ4OKiN+VnX
         OeR8w8/i6BtGBj9OnxRF8d5B3UVAV62tHjbncE7jHXYAsbf6lojFmPVJI3xvTQccYiZu
         SH/wfrvGplvbnagFkcJjt/sYraiPyjvTlJckO05RYEtYw0UDprqaAvUimbUEMCx0ObMU
         ucMJFqMSb+ZZdhNmgFRRAuG0yrn3o2hHl9T3xc1je0X2LXfK0YFUuOUzC12ll8ovgN8v
         d65w==
X-Forwarded-Encrypted: i=1; AJvYcCXWGe9KnT/P+XfQdnDmRtNLrbzbxKNTO0wlqvHKhjiIxFwH8WB+akpHsfYkjxGhOQByr40dhEa117Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xJHf2fHDuiEigMtpPoIQdXDFew+2jE80RF+rJkPLwt7xeX6F
	o1DxpaNfNv1q5jSdIarsiVjKzScwuk4SwFbIC91S1/i+rDo9WTyhFpP7ByDUk9E=
X-Gm-Gg: ASbGncshYTU1kShVfkC7HFgtg57iKR7/m+i4RlG3r3wPtk8s5kIfMAxjY5OMlMpvvFg
	2Om/DdYNbwdkQxWcM1g1cTL49zYsYSPJt0UAjN7pVXfmB8A+1iGG5E8t8NH0yHIqXM9GmGnjlZY
	Eu4NDYYmM0GqqfNb8d/E4kApKlsrvvC5rDvs9riY0CqjbsYITXh3grEoSfIPXCKMjs18BeT54Dh
	8RmNfvBrBqb9OtYbKhqFD8yV0PVblcSvGzOrsV270UbJ1T663qJXnmPDGBDuRkyRSJ1brKO5BP0
	BE5bf7K1SMA52OTlBHBYGiHS+LRgIyQg+gTfVILTBKZMg6oUI+L2vYQyJq9KNZ0ZEclvKv6MSF4
	PhR2oKg==
X-Google-Smtp-Source: AGHT+IGW/+fhs+JLeUCKUEbud8JKD69SbkIPP1YOR665oYRJjAmA7DbUahvIs7miZiUAZsDnBA2g9A==
X-Received: by 2002:a05:6808:1688:b0:3f4:11b3:206b with SMTP id 5614622812f47-3ff05d37c31mr7936346b6e.17.1743431493881;
        Mon, 31 Mar 2025 07:31:33 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff052799b6sm1565815b6e.37.2025.03.31.07.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 07:31:32 -0700 (PDT)
Message-ID: <4ad0f22c-fdb9-47cb-b5a1-2802f47124d4@baylibre.com>
Date: Mon, 31 Mar 2025 09:31:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/37] iio: imu: st_lsm6dsx: Factor out parts of
 st_lsm6dsx_shub_write_raw() to allow direct returns
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>,
 Jyoti Bhayana <jbhayana@google.com>,
 Nishant Malpani <nish.malpani25@gmail.com>,
 Eugene Zaikonnikov <ez@norphonic.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Shen Jianping <Jianping.Shen@de.bosch.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Yasin Lee
 <yasin.lee.x@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-19-jic23@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250331121317.1694135-19-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 7:12 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> By factoring out all the code that occurs with direct mode claimed
> to a helper function, that helper function can directly return simplifying
> code flow.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 65 +++++++++++---------
>  1 file changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index c1b444520d2a..17a74f5adfc0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -614,53 +614,58 @@ st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
>  }
>  
>  static int
> -st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> -			  struct iio_chan_spec const *chan,
> -			  int val, int val2, long mask)
> +__st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	int err;
>  
> -	err = iio_device_claim_direct_mode(iio_dev);
> -	if (err)
> -		return err;
> -
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		struct st_lsm6dsx_hw *hw = sensor->hw;
> +		struct st_lsm6dsx_sensor *ref_sensor;
> +		u8 odr_val;
>  		u16 data;
> +		int odr;
>  
I would be tempted to rename `err` to `ret` so we don't have to introduce
a new `odr` variable.

