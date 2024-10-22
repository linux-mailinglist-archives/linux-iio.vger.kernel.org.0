Return-Path: <linux-iio+bounces-10956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A0F9AB860
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 23:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F601C23CEB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DE1CCEFC;
	Tue, 22 Oct 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2aLN3mJf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8B1CC164
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632022; cv=none; b=aCI13QW+DcSOtjXdTZdxfjk/+WH1MQdjayOl4kwysM7aVDrShaLdqiGO8G7XeXNPQtzQ4L6o9X1o5BCb56HfiRpp9MOLB6tBzeruraiARfx/mdWtOF15wzKsXY83qN6GjFEomH2CRnSSbx2cxRngYF3aPpIwUpXynR9l9JHP2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632022; c=relaxed/simple;
	bh=ZhxVS2REzAmANbrZ9nSRuAbyeGAVAMksIebOeLoogO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CIRr7XYxwmm3QlpbK30gtaw/Jw0oGD4kMrYJACZxopDWDmBQgIOw3LkEV+uZHBtA94HxOyHZHWKG1BZYrjp+Pr4YZmLKodd25Sh3TL9bSSsHv8QuieiqNTr658kbsD/6Oje9ZEL92TXtehycai5gpGdmnZpNEEjoKIedpVxH7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2aLN3mJf; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7181285c7c4so2842827a34.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729632018; x=1730236818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJnpg9g6r2pW20CfWdE7jCUk/9u5wbr1trHPxKu6nHY=;
        b=2aLN3mJfMZP6cW9G0tGJpdS8LkrApG+IN6Tjq3Qv97GEIsQB7Unx1zTQRQRrK9YOzL
         6XAbYP1Q7woKtcYedRC8apdAaFw6t7Rt4gZHD+V9k0NxcumGNhU95nhJ9kEq2w6TDblt
         ziLOJvzwlSAd76xBZ5qyysnM/o2aa172G9iiWQ+jqu1uN7XzQD32cIng/h45oOR8+X0l
         KEgYnmF039g2oXPvrz6xO4+I6EB8snF3UgX2aPMZgeb3xycrffnB7kgAU8XR4UAaOQyY
         E5HTrlsSKzlf6XaS2MMpxyZBmzmT+31U6fzgpdGwHlqOCrxudkWXvIkWn9WKVQA/ZasC
         010w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632018; x=1730236818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJnpg9g6r2pW20CfWdE7jCUk/9u5wbr1trHPxKu6nHY=;
        b=PDexFe5/JOFhP16Bm1qvYQse5Y6OY7EUYqq/747awW1boKHOT0/HEBE03byTEwOYxF
         zghgDVuY5t6ce3ZkVVK9hwPzOM2rdBKtdxwRwZnPBXkwfsqvJrOtfchJvTg6VX60YR48
         aPNuMDIKMl2khX24Jz1lMX6aDbC/rCVIzzRAap5d33h/qVrgl3hZasGS05YiilbaQ6am
         8H8m2EcPWYG+Gdqbhj9ecLhkWBE6Jj9PiMiLECfbhFthTWeq811dTpuW0gtdmg1j6COs
         u3+dd3DMa20+XdQCgDpsLnuE6iH4A3qqTPIOS0rm3IrYIRTmCpf3BLgtwql288/7tmn0
         4rpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdrKWG6JvDmKSzMWizm4UqbvJSB0r+EuapUdBOgkQ5lzcK9gbWXurm8dyW9lDR6QeFyCSf0/I138I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVCgOggVhIJQkxquFYhy4ffdleTJV3ZyYLW/9aIYt3b4s2e5K
	rifW6eFSJNJ92EFeuzy0+MyhpcU7tbOMOHORPWlBclESgDks2BcIZInQhSfRASc=
X-Google-Smtp-Source: AGHT+IFsMwsPsTvpCwDmnZIxOfs4K2TEZ8wjRPWKgUsV3+xu7SPPImS6MoMNi6W3AR8/WuPjLaRHCw==
X-Received: by 2002:a05:6830:91a:b0:718:109c:b733 with SMTP id 46e09a7af769-7184b4494fcmr574446a34.29.1729632018318;
        Tue, 22 Oct 2024 14:20:18 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ebb7afb9c9sm1491261eaf.46.2024.10.22.14.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 14:20:16 -0700 (PDT)
Message-ID: <aea7f92b-3d12-4ced-b1c8-90bcf1d992d3@baylibre.com>
Date: Tue, 22 Oct 2024 16:20:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, nuno.sa@analog.com,
 conor+dt@kernel.org, ukleinek@kernel.org, dragos.bogdan@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241018104210.51659-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 5:42 AM, Antoniu Miclaus wrote:
> Add backend support for obtaining the interface type used.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @indio_dev: IIO device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 8099759d7242..ad9fa0ada9b2 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -63,6 +63,14 @@ enum iio_backend_sample_trigger {
>  	IIO_BACKEND_SAMPLE_TRIGGER_MAX
>  };
>  
> +enum iio_backend_interface_type {
> +	IIO_BACKEND_INTERFACE_LVDS,
> +	IIO_BACKEND_INTERFACE_CMOS,

I think IIO_BACKEND_INTERFACE_LVDS and IIO_BACKEND_INTERFACE_CMOS should
be removed. They are ambiguous and overlap with the SERIAL_ versions.

> +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,
> +	IIO_BACKEND_INTERFACE_MAX
> +};
> +	 struct iio_chan_spec *chan);


