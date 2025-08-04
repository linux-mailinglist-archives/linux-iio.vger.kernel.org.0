Return-Path: <linux-iio+bounces-22252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19104B19BAB
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3573AAF26
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 06:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628422422D;
	Mon,  4 Aug 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa5uTZMs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A06EC2
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289590; cv=none; b=Wr0l/7VQJvz8J34X7288iWFaFucJI3WPKeSjydcgYpfUBKO0UiV3b5fST2GYDojv56UEMNexkngBgXkja0tIbNO8mDiO9fMr3vpx4xs1uFwfKxWzu7EGA+PRdwK1bqcw76Adg8+nN3Bs2Lv55NNTbOaOqlYvmSkUWKxfGKxANk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289590; c=relaxed/simple;
	bh=JIaQepj6eqIhQ8wrK47/txW0DU5YT3nRDjr/hiKmoEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZeK5ly+WnSsW9HdvP2Afo3A3PHJHzzRe0bPtRMJM8qYJyOUNbQZ6GJqLVW7RGKbiN60EQhq/QDvzgYw77ttFXBI1u2V4QvxjrF8c1xjP2eUVORENJ96eHQrqMskru32TySiDNPcjrc8H7KpP5LMy3jNDQqt5f5xFZ76QRhaYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa5uTZMs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b85d01b79so4141774e87.3
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754289587; x=1754894387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHa1szJqqrmjWgIx0wfF4Gh4zVf44VpP+Z6k1QcrlcA=;
        b=Wa5uTZMs9GoANIRGpLYB77nOe+RGRJA/keXbqOj+zIddksPMfHDiFx6Oq3WTjGkU9e
         rDNobhSlH3Zxi8GKTTjTIRsLaecHTovNd7zhI+lLJDtLW3PAo/bW8j8Lb6CFcXHwsoYf
         tttpfFuWe4si/vyDII0HnG34pevyw9QZ6xcQAzBp5h0wNHomuiaw/IJOZNZXRi+cxIf6
         b5LXvHzS4+hxTfAgcf+kTW/AC2LyeVWDPJ43MprS0+8CScDGBFbZtptK2/p4fdfGHXrI
         8GGXYiVscsXe2MsAxbH4twasIA6sG8/BxRpZ3uN73/W4pvwyBsGkT/L00RIm2OoWY5to
         Ualw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754289587; x=1754894387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHa1szJqqrmjWgIx0wfF4Gh4zVf44VpP+Z6k1QcrlcA=;
        b=h8rQmzAPoH5sMu7v1RMWYlgcyway0i7k7zkuRlYPP2rsZIEb/wK3+4bN+CCvRyfw0q
         622uzx99Fb8GOgtJ4JGYeWWU1A9bpKE2lgdWBcpgGCdiYiG+Wv5U8do1zIDORIOcTxRa
         QQOY7AN3fy5RFBxHZU1fEYuYrqa4cGo6lrUsSmCkqFdvrgDMkrUYgh6YPX+IrlGpGl6W
         oYp2usy/hPpQovj/TJDpfoN0tR/lZw8z5XKzH8zaC+ibXlQ5rk97Mv+KTa7sno0qys20
         7+PgiCrf6HV22pXxx0eq+vNAdUpYpeDnvFXujs3+gcGWENaezQrpvRF82nyeAZNQunuk
         0CVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVWkgr1DFOXp/kqTT6Bj/BGZy5iZlV964wI4YefjLkM6DRUhy/WUP1ZmcljkPV0b4YLdqihtYD7sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/XxUzV4BRbLFnfMi1P2NgFri8HflMP26uUEKO3U6kMK0O8CgH
	cljI9qyAnPlEgaEKOnG9JRDTo5yJObwzsjHqtoAJrPDGzDv0JN0lep/2
X-Gm-Gg: ASbGncvXpeVUkq7x435/jVrcS7TdUwgif/l6Zhs5FOoBQtOdqkHlluXEeEr35D3kTCo
	PfuzJ0l0Bkp7FiPGJbIM8mgNSa9XXukejr/fCaVVvYFvHmfi3+0ZAgBeppoc3KpGsmmNFvvhvIc
	q7nw8wedeuYidDhJ6rBKuDglWCS32tkV8clwhNs05TNhwqnCBTjHvYs4g7U0RpuhK9bVAUDYsKp
	vAcDta+HaTlCF+wtB5PM9r89CMOFWMVGDD9upV+JHk9zhmM3UhMxZDFxqCaFOz1TNz3xgdoqZ2v
	04Rch0GX8ZXUbhw2hO57qPn6A6OljDPyC1Hdb+B0ilcDw89gq14hBMjeTV8696SfQdO28SLakQd
	Wm9+G6PrdCDfTbwgNndyWJ55knwTC6NYKmqVhBHCFLo0s1lxQotiRCTf7JUzMVjNTKRom1ivZYl
	Nc2V0=
X-Google-Smtp-Source: AGHT+IG6JFbvhFMLvRnYhab1kXGpxMgbXd7NZCXdlXNXoqtys1kriSr9gXMepmkTodkMPcwiA+rrzA==
X-Received: by 2002:a05:6512:1110:b0:55b:5393:bb32 with SMTP id 2adb3069b0e04-55b97b80025mr1904005e87.33.1754289587200;
        Sun, 03 Aug 2025 23:39:47 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bfc6sm1535794e87.10.2025.08.03.23.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 23:39:45 -0700 (PDT)
Message-ID: <067024bd-b633-418d-b3de-55f4c5220a78@gmail.com>
Date: Mon, 4 Aug 2025 09:39:41 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] iio: light: as73211: Ensure buffer holes are zeroed
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
 <20250802164436.515988-2-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-2-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Given that the buffer is copied to a kfifo that ultimately user space
> can read, ensure we zero it.
> 
> Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Christian Eggers <Christian Eggers <ceggers@arri.de>
> ---
>   drivers/iio/light/as73211.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 68f60dc3c79d..32719f584c47 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -639,7 +639,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>   	struct {
>   		__le16 chan[4];
>   		aligned_s64 ts;
> -	} scan;
> +	} scan = { };
>   	int data_result, ret;
>   
>   	mutex_lock(&data->mutex);

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


