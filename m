Return-Path: <linux-iio+bounces-24922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB1BCE2B2
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25B6F4F5833
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65F265632;
	Fri, 10 Oct 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2X8FmCYb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259322652D
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118943; cv=none; b=LbRBm+lfBPjPezge1KuVldL0PUXza4T1qXnKbiPCmHcFflI/hq7BltZqv9Tlj5X4tXn9UrIZ7S2VT1SPrqkpXsRgvwUfz/K4OQImwb4xxsdVUiiHugv9e0K8iEOPIidjJkzduJxBxNNG2vnICa/kG/k4Pc+Z+ZjBdeZkZx7cTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118943; c=relaxed/simple;
	bh=wNIzmMRkLHrQdGJ9CI3n8s5+na28Lf4RqsVWycxkjMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q94X669NTlL+kPxl+n0OCvoVyKJKKAAH4ytvEhCztLovTuIzJp7NX5w+4GIVfAZnjz4+Rnlg7LYA+ewPwLdmBGOMe5QhgGcRNuMClidbLxf5+l2/OrU1jffnp82lmodcPS1zxTLzb3v3SA4UXHU8xXI2J2KWCV9nypYEOWWsZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2X8FmCYb; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c0e8367d4eso850121a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760118940; x=1760723740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaMtprRJaiBLmGg4i/xmoof6gnqLK2TnSEKb/a6bsk4=;
        b=2X8FmCYbCmsEgdEvV9AoAjXb9rV9Q658NP8FIpS3wl6JBzf0t45LSRtZ3E+IGBVR1c
         AoQ91MXTGGWJQyE7NrjZtEDdOFBxSUx5aWtuzVovhzo4ziuCT/mxE+G7mBRdn/DKqdUu
         9/InSeCO5zVi1ypsm2d+224lGG8cPEGg+ADeeCwWSi+oF9srAUkDg6snlTip2pYPlHXM
         WrQpCKinX6gLdvakHZWGst17awDi4QChgiW8elZ4TQMnFKGSz2WdR4UI095Rv44o+YzK
         KlCE2i6eJS/q96YbK6N4vu0YIs9CaZmzpBdg9B1DR9Iv7lCsjAhaABcNamq+Z5T2VD9d
         r4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118940; x=1760723740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaMtprRJaiBLmGg4i/xmoof6gnqLK2TnSEKb/a6bsk4=;
        b=AjpiDZvjHX7J7Re5uAeAg9UN41iBZQf9yhXLPQcCEa/bQOn1Vx6DI61i+FCUDpW4RS
         zTPBPMbaRCmGSfcYrJVegOTKNV/QBOB7YcX7uq2zG03tywa1/gryOq5kBOl+E7lby49x
         LGz3Rz0fG5AgM/tjPGae+xurR4PKXkNyjZ/fo6KAUmAWCW9rDh6zoRqQ1ZktwNSJffuS
         rdPs/DVoAGOzootQgD+EMqGDs7oKxALWEA1r6M8Vk9DUHN2OHzOpuRoqcS3s8/cDwFS6
         UMdKrRNWJnkyLdx7hBnJuktAgvkSF0wc7k4bTlciuEJ6B7BBjtScSLCdjHFylOECTglY
         9yUA==
X-Forwarded-Encrypted: i=1; AJvYcCXQtKdTZVuAV1oD5RNAfyzWvOYH9mXs3M+fjz5TbPjnQ8ZRYqTuX/xAKR1/AT/iBOspWGh4pJcE1Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvnnt6bnxbSaR1iG8A6vVozzjbszYTPbO+jcJgdxiC7H+9kiDm
	DxnLQ6DAXxNHaEolFOoP6nVBGNtI1D2tQtUu+4wqBrdjWQfVZ0tdFvPgXtS1bjRDIZg=
X-Gm-Gg: ASbGncucJvhNZmTg+Kv4zh8884MMmRk4dw14HMPwQYuYFGSnF0hVvjgUk574u6LHB9c
	8QMcvOtnWMLUtQYsfs+kD93VZ6vAu2S/xhhH0Y2kuM4Vat6x2vzXsWOn7LTGCuHlBVZir1pmqeD
	aWi9ncMG7cgvcQ34L2SOTbPksijwPErlgb8IC3BOyDwPxNKJ12yOFE2llaMbDbquubQBjYM0ZwE
	ln+Xm/RGPO84caW+k1PuezsgMmcK/QgUI1dItvZ8A9appNbnKeeqrcivI+SMCC8eNN35zPHoe4P
	IkWHDBwbXGNv7ezql/HWIfi1bhiDC7U/SXrZcWdK7KsY/iv9aODmnvCL+FFRWjooOUS0/gUCtwj
	ep+tfZ2d91mHVx2g5r79kXqXbpXM1WjSodJjIkAx7EN19Bw7l4AV5zMRS6CGw4zBGLyt5ZXGFJm
	tja7B1Max6GlltAkl34DC+/TpchA==
X-Google-Smtp-Source: AGHT+IEK9+fD2C2mpPvsDARXpusuog/ajtfLqTbuc/LGs1+ce/f70c+jW5JTLJ4ttYcpUKSMQljjjg==
X-Received: by 2002:a05:6830:700e:b0:7af:1367:4f85 with SMTP id 46e09a7af769-7c0df82d758mr5830865a34.36.1760118939948;
        Fri, 10 Oct 2025 10:55:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915eed4sm1027277a34.36.2025.10.10.10.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:55:38 -0700 (PDT)
Message-ID: <abc4209b-eebb-40c4-902c-b584028bb611@baylibre.com>
Date: Fri, 10 Oct 2025 12:55:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: health: max30100: Add pulse-width
 configuration via DT
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-3-raskar.shree97@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251008031737.7321-3-raskar.shree97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 10:17 PM, Shrikant Raskar wrote:

...

> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2015, 2018
>   * Author: Matt Ranostay <matt.ranostay@konsulko.com>
>   *
> - * TODO: enable pulse length controls via device tree properties
>   */
>  
>  #include <linux/module.h>
> @@ -54,6 +53,10 @@
>  #define MAX30100_REG_SPO2_CONFIG		0x07
>  #define MAX30100_REG_SPO2_CONFIG_100HZ		BIT(2)
>  #define MAX30100_REG_SPO2_CONFIG_HI_RES_EN	BIT(6)
> +#define MAX30100_REG_SPO2_CONFIG_PW_MASK	GENMASK(1, 0)> +#define MAX30100_REG_SPO2_CONFIG_200US		0x0
> +#define MAX30100_REG_SPO2_CONFIG_400US		0x1
> +#define MAX30100_REG_SPO2_CONFIG_800US		0x2
>  #define MAX30100_REG_SPO2_CONFIG_1600US		0x3

Would make more sense to put this new code before BIT(2) to preserve the
order of lowest to highest bits.


