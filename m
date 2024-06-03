Return-Path: <linux-iio+bounces-5720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7056E8FA59D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 00:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A2F1F22C7E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245113CA80;
	Mon,  3 Jun 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8ChAG+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33D57333;
	Mon,  3 Jun 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454275; cv=none; b=ut+/Gg4JSxyUO53fEDX0Dh1hUj2atBGM9ZtIz/pYDkm9GpE56Etp1wvK4p+EqZ+rfWoFsEeCO28R50/S/Cw9IVRRjVf+rxnUFhRWciEo+0lli4qI/D5sYYjbc6+sReMOd6zme7owaDZYcTCGLx3vr50L95rocwVxltaSaOLrdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454275; c=relaxed/simple;
	bh=/Jxb3FPgZFk5te1ry//hQjjyUmwIPMo5IMR4MlgoH+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eo25Vfu4caNTY90UCic4wLtArRAkQf/Vb9gGgIuLxObKeBOHzjuEKkzhAgSN9hwuFrm78qAjKbgVPn3LLcFO1DPotOtRuaMUe8JSIltwkW6I3MRc62GjZKOG/ryLaD2bacJZgUHH5N9EuzPb+P8AKekEGalThxJngs4RGlzKqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8ChAG+1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a6985ab58so681706a12.2;
        Mon, 03 Jun 2024 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717454272; x=1718059072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gfk2FEcgji/HN8xdO69SKDutpnKI97Kc4V+JcwqicI=;
        b=G8ChAG+1pJKR2HebCxorafjm4eebkScCM8RDZX8cph4/mbLW9t4BMTyYpP25WICExI
         SmCiaGlTjYmVARxsQpO+J0WX+MoCc26zRCTdguWtHtOsHxlY+9c8pp5KPp4EoHyS94GD
         tcptLg0yz/UppMfP8Noi6zhHvFSDmZ1zqjpmJ3eftRgMcALloZZIXUv1aV7y0je6wIsU
         dq2Nhaad42QuHto1Rlm5kkZx/884SjoQMcfbPqIuc0dJdgfGLmypY2VBv+2eJKtZSblQ
         /qkAZ2I5l9aDx3vsr3kqWTw44kwdziPw7gTIZ4jxHAZMe3H9aSIoSzdLRg9TeVC929Ra
         q3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454272; x=1718059072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gfk2FEcgji/HN8xdO69SKDutpnKI97Kc4V+JcwqicI=;
        b=aiCMIgCNDGgsh7UkRNPCPy2tZWacdMcp5C6ZOkryFJzmiGAi7KvMMBgdaCLMnYpicn
         lfeN5HQ2rjpQwX7enXHfJyywSJFjidEAZ3IBzlZPPQmGsv8bUzw5FpL61cNRIKFY0Kyw
         xGBD0HfgEfMWF7wn4joV0JGmViMc7x4cGd0v2wodqjxz+mfdKT6FmGcLgpICJ/laT4h9
         LUTA/UEgTxpxr1Tca27VnDU2qHlbIYZ/bgRkYUw6PJ3YpvP7HW/DbdoMgbAgEmRJkn3o
         6va+KqC354pLYazUobB65P/RVT/NXhggdQWlTxfoak5mQDMoO8dawQAaGm2S7lHn6+oM
         x/tg==
X-Forwarded-Encrypted: i=1; AJvYcCUpO2nt69IE3Xt/rWpV00I1zUB9foVF2C6QJ8dClXhwcVxJMoiQudMM33kkQ9j1sn7fq7e9SEFewe64bUyoIkNtbb6YhtIzJS8BS2whhRba6ziKn5WG6L7aRKWY7Qoeg48BHDy1NQ==
X-Gm-Message-State: AOJu0YxU5hcmU4qAVL3prwczJ/Rv4SrHapcZ+NnJuFBVHhqRn4v+TFe9
	1c6PVk6eP/XAtOfMviWp5bHJS66D742HQCACudE1yJ3GWlpzYoaA8CaR9u9G
X-Google-Smtp-Source: AGHT+IGrhPTBCWPmtjXCoeb8rgfAdqRDcRNx4+bGWl5PgImBWYORJmtldMEzxNJoR2qoKCH6/vEboQ==
X-Received: by 2002:a50:a455:0:b0:578:649c:f7f0 with SMTP id 4fb4d7f45d1cf-57a361ad344mr9236984a12.0.1717454271740;
        Mon, 03 Jun 2024 15:37:51 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb8225sm5971629a12.24.2024.06.03.15.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:37:51 -0700 (PDT)
Message-ID: <a628db76-a48a-4492-a3cc-f93c0f67ad04@gmail.com>
Date: Tue, 4 Jun 2024 00:37:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
To: Mudit Sharma <muditsharma.info@gmail.com>, ivan.orlov0322@gmail.com,
 jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-3-muditsharma.info@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240603162122.165943-3-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2024 18:21, Mudit Sharma wrote:
> Add myself as maintainer for ROHM BH1745 colour sensor driver.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> ---
> v1->v2:
> - No changes
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..945873321fef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19407,6 +19407,13 @@ S:	Supported
>  F:	drivers/power/supply/bd99954-charger.c
>  F:	drivers/power/supply/bd99954-charger.h
>  
> +ROHM BH1745 COLOUR SENSOR
> +M:	Mudit Sharma <muditsharma.info@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
> +F:	drivers/iio/light/bh1745.c
> +
>  ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained

Hi Mudit,

is there any special reason to have a separate patch for this? The
addition to MAINTANERS for new drives is usually included in the patch
that provides the driver itself.

Best regards,
Javier Carrasco

