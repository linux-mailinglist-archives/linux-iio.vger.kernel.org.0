Return-Path: <linux-iio+bounces-15056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0BCA29D24
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 00:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946E818888DF
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 23:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFD3215F42;
	Wed,  5 Feb 2025 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2dGtLIr3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FF1519B4
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796725; cv=none; b=mxaKDtTuDThfNzuYokhvi54gm0AMA1nDRZfEVbTBC9ocLBOVi0d7gSfXwBulBYahbOfBzGWuf016/TsbYRFmQU2wJYUaXXazMowVSvpmthAdWSaiB0CS2pP5I5IetyCe13nAY4mHcelPb1zaYblArV5t0GcYi4bga9fw8nFQ1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796725; c=relaxed/simple;
	bh=DFPuS8nDF3sXhv0PNgDQpLqiZWJCMuHGmBbrB2FDm24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUj3bhPYIZ63NuFiCzhzZjLYnD130In9Kxw2clJmffFExIt/bp71bdIrte9F751dyHLHk59M+ShQhzDLNTYnpeRPKDlw2NFuYnLkQ1iCZ4SXj58JYk/3WP7dnArxZge3XM9jQYztm4h0UUGg9XsnvaE3ly/EXsMv5NXEgm6F2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2dGtLIr3; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2b21a0784so98070eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 15:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738796722; x=1739401522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DkZdhNJnSBxSkpZTkd+nshswhFICF4G7BFSlkeMlSvQ=;
        b=2dGtLIr3v/HN2zO+xjw69JTDBrVtNCWVTciS8yLLIBkoHuVrlGW7yFhrcAZs8Z4tDq
         H4bxWOstz2MzSlhd33YYtYU3/CyKaSHnvpgsZqse3w2F2SG+SMKgIU76mDjt1Ps2QI7q
         8seA1qtiy+ZUyZqhw8OK2z7wDfA6qY2O4ZdTC5qIMSgqxK3krN8D87ieXz0GREMaEUR4
         X04rKobsli+i/2LXFlbXRcAhFpWIsiJoopJIXw9KMsRd+7XAV+MFBZHc+G4gKOR2jALZ
         8aakuQiFbVhWHgQ3GxdY+Boxj8A+Hg+UHwURiS1K2cgUwzzkCLZpWvUX+CEQptiigKDY
         7ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738796722; x=1739401522;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkZdhNJnSBxSkpZTkd+nshswhFICF4G7BFSlkeMlSvQ=;
        b=SottZQdBeGByWUuWolyXg6ZJPHaQyBx4Rts0vDMtg6ehMGeRFmvFG2afuUddgUe8XJ
         r34CJRGALnGqyg2QYdEl9cunlu0tyV0nMZMGDF7eHSkj/BeYC+LOwvNBg0Q8DrJxsM7A
         0Jce/sJkFdg7Rmrw3JBoXWvNLXfdDK4YcI/gM97ApAuReDtcRhDsi3iv/X74+0RGFriR
         MKFF5I2OlMQaM/ngCX40nqbZFyMxJT9pLtlRcnVrJDlsaWHGyuAshnAU7eT8HYLzz4Pz
         7fkpCcBC5ciMVihPPnzXcjgG6pcZL46Q259fxPsxN+nCCKQzOmrVKUrsJem/sykMHJ9G
         2fHA==
X-Forwarded-Encrypted: i=1; AJvYcCX/AklylwjvGc25k+zscU8kcp/DFL6Rd4a88PQJZpsn8C/Eav0OWa0Ppn963hqt+ddvr6znHWDrDoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpuc6pxgU+jeYWniirqgzdEhOGCjick11oVTvhIKZZNpAAMWj
	jkonQVNd9pIAjdyBYWbbqFqw1lluSbHZShvMpC5VEDdTwIjAEAooHTBV+rtPURc=
X-Gm-Gg: ASbGncvdrvVRT5jBVv3rM931It+kiGlsLL/QeiV50xS6ZGa2iBkeJpsmV3WOEvkpDj6
	pukEoXBghQR4USOPioHouApCTMtntfvZh2HVqobo8w9dPDm9s/fGxOrPecqMO7l3HMnrgCs5rza
	WbOxA3EyALzeFpBXna+MpK0n1/UcDBg5FzNpCy4s2CLXJrv1CVON5xKRb0iraMvd0pQLtQVOYWP
	ml5pnntNTYIMfOMv38Gkw35HaNYryyddViikMwINz79ux26T4SlkTcagcfn2s3Q3m+ABxAqiScx
	5nq7EKa13jyQVxbY3swlOodA7+EVeWYKGT6Gto8Iwcd7D3Ohak1l
X-Google-Smtp-Source: AGHT+IHJHtUndAVv28oCwY29tstSdTS5ef4IojgPV9DYh4p8oA2JyzkdArgBdaSrE+xgyioOBF6hYg==
X-Received: by 2002:a05:6870:b149:b0:2b7:d3f1:dc72 with SMTP id 586e51a60fabf-2b805134aa2mr3278549fac.29.1738796722136;
        Wed, 05 Feb 2025 15:05:22 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b82581511dsm29322fac.0.2025.02.05.15.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 15:05:20 -0800 (PST)
Message-ID: <ec9602c7-b874-464d-986b-89523d919289@baylibre.com>
Date: Wed, 5 Feb 2025 17:05:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/27] iio: chemical: scd30: Use guard(mutex) to allow
 early returns
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250204200250.636721-1-jic23@kernel.org>
 <20250204200250.636721-3-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250204200250.636721-3-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 2:02 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Auto cleanup based release of the lock allows for simpler code flow in a
> few functions with large multiplexing style switch statements and no
> common operations following the switch.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  drivers/iio/chemical/scd30_core.c | 63 ++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index d613c54cb28d..7a864b52adf1 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/bits.h>
>  #include <linux/completion.h>
> +#include <linux/cleanup.h>

Alphabetical order?


