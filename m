Return-Path: <linux-iio+bounces-17289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77FA73689
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5470B189E2FC
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420541A262A;
	Thu, 27 Mar 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wm0+CTRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC1323D
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092116; cv=none; b=JmN7tBpKWRwFU/cKxQdwS2YF0ZA5Zblu2wpk1BY39NzPN9ygsQChUVMWoafXiekV6KzOmjyqekHdSFrHAycKRX2VLy2btnoqqzgCKUHDzo5nC84nOMoK4/zHJvrJz3ALEVBeEr2cwjjW9ab95BWmByc0M9wSBT+5spAT8SDQ/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092116; c=relaxed/simple;
	bh=qWWCTQ68mq7j+CUwFi2K1aEUZ53AMjvsxRJpUc0PO8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G66SV1pHKVLpYvr4Wbp9CyNnPcu2AjVbAzQu+oS+I/7hYxQdGgVepx5aDVxto/GsrcR/21gLnRpTte4+FxLVNlKtsLaxqsx502RXXNBLq+Qaovi4GK9R6m4Eds1xjK3Ivm95sqFQ4XL6rli9+oq4Hj6Z5gaIG+D+f7YQ983Y+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wm0+CTRj; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72bd828f18dso474840a34.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743092113; x=1743696913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnEqDZEWlinHyAAguReDuv9plr3mmwmYbGy/mnA8rGU=;
        b=wm0+CTRjodY77i5hgLK8nMtFll1NDLVnJpX31fyi9QDKk52Z6MYN75egd3KYf0p2Sg
         HgawHQz1jBO74gdTCiF6RO1PsmcZz5jUC0W1ub04QFFqkxW3tV4e3exLSSyvDP0lDder
         TyHhKsQTtaCxWoecyI9AbGw90AysowdEuVfhEqTg+x9m5cF6Fx2czdifJMHASuZeBBcp
         LRkHt/IOo7CDKtS/pceyzVQ8SmNb6VoErOV2YrzuYTBgioi9Ssp5lNqdLjdexacFGmUk
         47wNT8oQgmJ2nOqbH/sgP9csbAaCpQjTmE2+hI8B6b2N9HGFNUhLzn3uBdAvc8pphMFz
         lm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092113; x=1743696913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEqDZEWlinHyAAguReDuv9plr3mmwmYbGy/mnA8rGU=;
        b=M1AwT8a/Gq8Ah1Sx9f7LKCEVl29q3dk7rNtSyZpWgC8UqBPWEnRMhE1EbkUnWnKE0L
         yd6dYetoYt/KRB+P8s/5npjihJ/qCt7UZUk9/eJiw+R0CqwrWBrGo9ctuuEmi6uCJ4sT
         zOrB9niiKfj4IXCFkrjqO46/eIhg29nDB6vWQZ2XSfi3O4ko4vYjsB9f2ycJgTH5OLI6
         ZyVODdQiw/LdvQ+Sd70KaKsz+R99CPQk7vYpKFO0milT7YBBpYPQUUI7NlbOsU29YIkm
         bz4L34aqYySzYALhoUl1eZAMVCRcNZLFaoxUxexru1YCfmAr6teE/enk4wgvTiL776D3
         JhlA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Rs89cFbnsHv8KcqH63PCIPFWsyb88NabUUZK24ddlAFmL+BTGo0RREj7WC6axmetN9wmXs9+xic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFfrVntQIMW/QGRLefiarH1NflKSy/0wAKNkDYS6Mu5CdqLIn
	S1SeiEaDqECshtUOrdjwJpScWuQDJfE2Sv706HzdpX5H9hPTzouyXG6beqJXwLY=
X-Gm-Gg: ASbGncuBtc5F0jM/pY0i4Hf8JKgjLMZOsMMJrPJh3sNxNaF2UHrneAgfOcAVyIjH6VX
	EOX4urtGi0yUkvxUv7yb3HTrLVuatI7L+gRx8e1Qwtp/Q/V/lVgtRj8KW0j7XMay3rHcSXuFLBW
	vkQU3YoViQocTp3SwWZMGPY89MCU6cPHQKzocolzJ9ZNpsPP1qc+sj1xjDAHz9OMqkhcFPONj8k
	Xmz4YMobmOjgD+9ERiB7WurhHXH3I72YiWGg2jbj3yCwPzp3HjA1jRQEnQrEj2lfex6eO1fEDt+
	DgUNUi3kUVFvdd0spnD9m+i/sWTPAzZWe1tP3uno3G+UNl0cSGYTLwWJt+qviHG2X8KPApXan6V
	gvSlEPQgayJ0ULwUD
X-Google-Smtp-Source: AGHT+IHiFiIz7UFhPR1z1zzLH+wMQcHJDifB2bdOLA/PHdSiNHWEb/VWM8B3r45fvBHqZCOtSMsSlw==
X-Received: by 2002:a05:6830:4187:b0:727:439c:d18b with SMTP id 46e09a7af769-72c4c97a4ccmr3152769a34.15.1743092113322;
        Thu, 27 Mar 2025 09:15:13 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c5828ae78sm33512a34.60.2025.03.27.09.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 09:15:12 -0700 (PDT)
Message-ID: <227eaefb-a1d8-488f-9fc3-6d00baa4a56a@baylibre.com>
Date: Thu, 27 Mar 2025 11:15:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Documentation: iio: ad4000: Describe offload
 support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
 <92b7db8eddce5b11476352405ed7695107ba7745.1742992305.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <92b7db8eddce5b11476352405ed7695107ba7745.1742992305.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 8:25 AM, Marcelo Schmitt wrote:
> When SPI offloading is supported, the IIO device provides different sysfs
> interfaces to allow using the adjusting the sample rate. Document SPI
> offload support for AD4000 and similar devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>



