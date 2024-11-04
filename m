Return-Path: <linux-iio+bounces-11879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A99BAE14
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF9A1C21134
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CBB18C330;
	Mon,  4 Nov 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TwkDpXXG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57597132111
	for <linux-iio@vger.kernel.org>; Mon,  4 Nov 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709048; cv=none; b=HOKmh0OE9wSV8zrbsJUirk45KtE7UN9amwjZ5ojbepoydUNylsPTuIUfWMqZ4JQuaPCRb4K4axoRxP0RFJ/Bp8N9Id0HLywT8HBXSdVwFFmewz+pYJB4sW2DvW3m3JQSY/iFCwD3MBGw4AOpr9w6H5vM77qS+JzSUFYqXVBG8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709048; c=relaxed/simple;
	bh=5VkJOu+g5b0qKiJ1jIlwSX5lX2+9tMD4oEX3nkRSlOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdWMgDPibAaocMlf5Ctp/v4p861B6NQ99/SsGgjmVv6jsIw5mshyEt5uMnI0MsN7Dz4dVia1DlWqdHxUFJT5nNceu8IGAkIJVUTPn/DY0UOUGqEWJTaCMaYfnaxuL6ic7++tzuw3unY6VzcJF6hpsjMsrz8B9TnJr5zj8RqnvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TwkDpXXG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314f38d274so48283635e9.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Nov 2024 00:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730709044; x=1731313844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QGb6/0TsMbjRxg1vp5PNXgU38SBTpwljeMmmAjykPk=;
        b=TwkDpXXGoOqJEt2O0sXuXl+/xTKmFcyjJ+YtjXH3dVO9AdT+gnoD/KrdCM0B6ihWXW
         S23CNdLqaKDfJ+SxQOEOOv7h7VCh6qevuiQuLcg909kOhsb9ZYDfseh3aqm1vbmpeBRg
         J9LN16v7ShJQhvEOiGmX6Ywd9cf53A4b9W4oMdywVq1k82+qR1F5lhoa7JP8vnK5Q+yC
         pAHO5byFbE527TS75/cu2hVvb9XGYacBIja4ootgps65m/e70Qxlj+6mVl58Xp6bfXsq
         ORafEloXj89Sct/oprxLWPHPbXVTxTbDVq1KeX4MjKmi95RMsc9l/Mtr6+3rlyUZre50
         1KJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709044; x=1731313844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QGb6/0TsMbjRxg1vp5PNXgU38SBTpwljeMmmAjykPk=;
        b=I3U3VFWva4x29BRMtlIHD9+yINOwvCkATUAzNz29ZKfg6nLB+jN8FS1ZxUtnfyUXTj
         akYMVzALLv5quyruRVpbXBVPnnkQti6osUGvx52/Cle7V+BQn4OclJtzh7vWxCQjdgP5
         BIrCLqH88dBxl5JRox+MBebK+NExNwc853gAbAeeROhIB0n7pz8D7j59erXVh5bsGLTs
         vMYyGRWq5PESHm/8bC2Cz+kdEDgSha7t/zCwOR0uQYLomlvpH5O4XAb0V7IOqMvYrfim
         O0sz3HwU2G3nwNMUlNY9+xEKULxas9vPPf0z9hiiXUUu2q8/zIwew0R52+GlFw67uixA
         Gptg==
X-Gm-Message-State: AOJu0YzW9OQsV6fucckGZbyQHUjrYFOYGd1DcDVhuRJq/3Th+sS0W6Wf
	tEh114MJvbi25SX7oH19HKgiEurIRtUCBps++txVXmWLVaOGtZ+78u/QEFbnr5Q=
X-Google-Smtp-Source: AGHT+IFVV5wGFTKKBwe9YF3sHy2XdahxtRxXMb+KfShZQJ9smORqFjeuuKbIuJHbFCl9WsNYnco+Xw==
X-Received: by 2002:a05:600c:3c83:b0:431:24c3:dbaa with SMTP id 5b1f17b1804b1-43283242aefmr123723985e9.2.1730709043788;
        Mon, 04 Nov 2024 00:30:43 -0800 (PST)
Received: from [192.168.1.94] (56.31.102.84.rev.sfr.net. [84.102.31.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e9145sm175101275e9.1.2024.11.04.00.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 00:30:43 -0800 (PST)
Message-ID: <f91f55a1-850c-4368-86ef-9fce7cc4ccf1@baylibre.com>
Date: Mon, 4 Nov 2024 09:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ti-ecap-capture: Add check for clk_enable()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, vigneshr@ti.com,
 wbg@kernel.org, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241103213910.31976-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20241103213910.31976-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/24 22:39, Jiasheng Jiang wrote:
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
>
> Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>   drivers/counter/ti-ecap-capture.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
> index 675447315caf..30a269fa5da0 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -574,8 +574,11 @@ static int ecap_cnt_resume(struct device *dev)
>   {
>   	struct counter_device *counter_dev = dev_get_drvdata(dev);
>   	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
> +	int ret;
>   
> -	clk_enable(ecap_dev->clk);
> +	ret = clk_enable(ecap_dev->clk);
> +	if (ret)
> +		return ret;
>   
>   	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
>   

Reviewed-by: Julien Panis <jpanis@baylibre.com>


