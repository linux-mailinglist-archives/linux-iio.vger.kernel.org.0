Return-Path: <linux-iio+bounces-15055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A77A29D1E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 00:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7725168B15
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 23:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF7021C19D;
	Wed,  5 Feb 2025 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XOvtpNe6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CA215176
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796618; cv=none; b=rwzReNdOIkBUzXXV3mWNIkYLNi1iIQ8565gHPDQkC1sTpnPQUz9+FoCYFQdgF+hAOBMURrx3Jw/RNDJRDUdfKin4IUY9Ia+jYIg0l+3J6/7dVG5ZcI1etJAhUNRmpW/8d/HQ+fw5sZUEwR673rPfl93KsSfkQeRjx3j0MygQC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796618; c=relaxed/simple;
	bh=bmOLY9rwzkKSfuBX4wMXIFwIrF1xJJmG26Zg4AY9Ja4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NV0KTPVu/8lZVS148YaqpBZd6/nBN1CqbBmWdzdvmCMu25ukH3Sb/8iHeIlA3UUpnhowZo0HYchClc8aoYbICltIJ61P7bUbcewTtKchctps35CkBgc1/5HXrBy+FcKYYh78D0BBe9GhAK4Kzm7zeHnRVA5xvtZPZ94cHJqK+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XOvtpNe6; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71deb3745easo105449a34.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738796613; x=1739401413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0sTF8oT2AHH9fETBpxxeaKjbNxv6wkmH5FzpdWVr1U=;
        b=XOvtpNe6vTEsOM/MLC5ri0ZIXacPIzdOTc3fLZbKi0fSH66hJokw7HlQBdgE39Pfwo
         a8az9UWb4w/C4+4xax5eGZj8RArh1MnccdEx8WSkck+mfJLtAfDTKRRvPJLWam5ONddm
         91blYOGC5ejZ7zsxcLdTHTBTJSoDQKAgQkTQEuVWdauf1YRJCJ6oT4nNQGlzwPNYrTRm
         R8CRQBhr24kCPx93fqVMR0U3swIajjmey6lZTZja1k4SttjNkl9lrf6rpBhgrMWlfvmV
         rtwpp5TsoMyNPSl+gpJpe7ZsXVZNPrRpyHmjVFSAX2cmhj9mTq0O0vZk/rxzSjtU99dr
         YRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738796613; x=1739401413;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0sTF8oT2AHH9fETBpxxeaKjbNxv6wkmH5FzpdWVr1U=;
        b=D50ItoI0m6mdNizANHPyBPmE/dm8x8PsUeAKVxBVmSwKpa752Nc/h5XusY+QzS7tVy
         uueebSnkxavj3pF1eicKNcnz8Rzz2vtje206Vgl19mc9oaKiA87POmpvdL2PgwmNZXOR
         I+qUs0SlWrd0H9n1DZMbVaT22i63lekDAKPF1KGHIUTiSV2Iq9jABZzDFS7jIK4uC5UY
         qh5OrHg1mcIpHwioo9FpF00quQXFMyxfpDjD6crO/WX3DHMRgt4glpEeuUgoFUR2DGdc
         XARuVeF6SF+lQAOG1jGbIkNNxQ0OWqeu6GZXO07935UF+JnkedGv+3VW4rNTuCdL7eMB
         gvQA==
X-Forwarded-Encrypted: i=1; AJvYcCWRwlMNknb0x8m/5n7pLiuBWlJ6FZIaMDUxQ7ec5VemHZoueUKYxtwUKtvyiF3LAGmuLp+UJOLwxws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCJeK3On1U16Xj08M9uQV3G8jwu+tmX0Qizgwhjq2XnewcWBh
	qf0YmJOtO0qnSdaXF1VpMBSYN7UcfSuxjEokiC0TyYC8AZSMJ3EIE82nlsT2X4k=
X-Gm-Gg: ASbGncv9omYL0w5oQiufV8hekVUVPKhzvw/v5QV73swvNMxJJtrd6HB+sSN5wA21HAH
	3TXSiKy97K6brAOHwuupYpS90WsKyq0Q1LD+e772ILi6ylNNBnLpjWLuryFXsK6gt/8YVmk2vof
	dx0VJH4GwhX7uJxnfadoGsYZwqpZYWIfSJfhrek6kPunz8ds4OkkX2JRTBYd3HJwCE9d/VAkXke
	Ibic+ACcHLkhu8A4EqVNxHCplaMTsMZb+7LyzNw+2xrWJzCakBDMzc01UjZznk7i+jE5CTFsum4
	Tfe8Z2y5r8Z+Rvc2C3xihkCCRb+q5B3k+anuDV+iAuSX5Tfx5i2H
X-Google-Smtp-Source: AGHT+IFEnIgdORKwnSwNdneGUgVgcpefnpTtasOMmRSuVqupAgyNXTR5jXoS46Y/Asc63mx+w8eYLw==
X-Received: by 2002:a05:6830:6002:b0:718:8dc:a5e with SMTP id 46e09a7af769-726a41870e9mr3603615a34.9.1738796613402;
        Wed, 05 Feb 2025 15:03:33 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104c2e7asm3965937eaf.12.2025.02.05.15.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 15:03:31 -0800 (PST)
Message-ID: <2070fa99-0be4-48ee-ab44-2b1875223f0f@baylibre.com>
Date: Wed, 5 Feb 2025 17:03:30 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] iio: core: Rework claim and release of direct mode
 to work with sparse.
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
 <20250204200250.636721-2-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250204200250.636721-2-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 2:02 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

...

> ---
>  include/linux/iio/iio.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 56161e02f002..fe33835b19cf 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h

Maybe should #include <linux/compiler_types.h> for the __acquire/__release
macros?


