Return-Path: <linux-iio+bounces-12057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E969C2875
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 00:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8915B1C21F4A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 23:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ECD1F7548;
	Fri,  8 Nov 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rja7OR7d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907241F427F;
	Fri,  8 Nov 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110178; cv=none; b=g+dyJkgNhZ+B5NS0YYq3cLEJ0u2v4FaVTukufZT7fqG0v6gb0MVwGlOcP/rD57N8RxNUAEPyKOopMgLUa2V+qWOctAG2dr4qVNuc6vAsebJtzrDi4xeRCQvHZd4hM8pIxiplhCQvmyB7PPxj2qtNKmtPM/rsI8zwBUPi8zdsM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110178; c=relaxed/simple;
	bh=jidXx8xjMfUUKMzb1OMMVrlp9v9xArbausR3H7CwDD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fto5PRO17DzIO1/vpbiVuLEgCmY1vk/HJ5YMxxPEsbCsclbVOvWHvQKiQCXIVI7K9tO/IK072obKuDn8A1/BIuR92Du8J5SRE6rU9mHTVEBiqHgPRdZKyzOJlrZbGjy5XeCu3GOIdke7Lfxh2ozHruBjkEdsHx7SWISOOMXGWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rja7OR7d; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so2037830a91.1;
        Fri, 08 Nov 2024 15:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731110176; x=1731714976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko5ntTtP2w+Sz2PCh54+SIltSsYjcVHYUqvHuhsGxIM=;
        b=Rja7OR7dVShz4g5fXLzvuws+YpU6IgB41DWU+E2YAuIbYhCojc2Brz3/beyKPMx/sq
         nNq3ZYZV/4nM4yE5Y6KVPX7ex68l54nIx9VK7bi3kj1hE2yEtpcgotWhj3rFLX1WgMfZ
         NgKbEoO1Zz8hmJtNYazdG5nJ5qpUnhW27umefnbr3Ay94yWy2MBwk+PW1RK7PFNHRArw
         Uda5V07B4zpRKAZUiwBlyJ6yFUtNJjepAxBiuUhJd4HrAgO9MkMCrCoTgSpkLC62Qxmo
         K/5BAM80Pk8ROjerYkuBWBlo4VxCZ5DtAvZZNQv9Om4Hgz+IsR8FHFH7/1ZVyWEU7QgC
         W/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731110176; x=1731714976;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko5ntTtP2w+Sz2PCh54+SIltSsYjcVHYUqvHuhsGxIM=;
        b=IyOrrkSNb0jyJwe2ME4VbgMidw46yH58iXlNqjGcPiASPDZw4B3UDSvmC9ohv1TqZY
         XFcf8I9PGX8KT87YAhOHy2ONdPLukjWfbSCHdghdHgt2VSD0DDx/CNHeT1Vp1Wq0BeUM
         uBUiyrl+UKZQ8ravnSATtDeQ6RslfnI3ZAh34cSq1VZKl90gZYLfLhbtN47nvZXYTeYR
         adN8uwQViFrNFyt6RQ+bTpZOX+gTEmMFipX3yJPwbK0BwpXMGbDJmT+Xz4e1HdfdnlEN
         dq3RF7Hg0+0PS6RJ2yX7nzgvjXM6KkL5/G2RXHgt2Ah3fNTLRzsMuesp2tPdqsdranSc
         SjnA==
X-Forwarded-Encrypted: i=1; AJvYcCU35zboMz2+XJAOwdi3oThPkxjC8EMDTE0rjjCpg533i6DcUxRKsUEa9XgFtF6Ot12rwL7xFR8WiFq2spM5@vger.kernel.org, AJvYcCVwl2bWTAygiRnF7AtUGeAQmHzaM744JZD8n/1GAEw0EUMKPd5hkF39leQOR8S6nwlXXwbMSMw1epwU@vger.kernel.org, AJvYcCWNtvZogeqhVoeE9UC4372CMxjJtphjVfgqRk6CshoNPIJf3Qw3wdE4rLVg+rPCkaHIBI4AGa/BAgrPmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDl6NboqVyHw8vaKNOkCYDWf0hLgWTBwc1lI6U0B0pUKSNFqN
	1CB+6V4iBO2KM3KQi7s8V5tArQjlc1lJsDxzGVJZmKXZaKzbVybZ
X-Google-Smtp-Source: AGHT+IHEarQoWl4dFgmCs28SBfigzcnSWnoyL4xgpkZl9Jj3lgLAj0yFFM0e/MUEUbjsP+pQ2Qtcog==
X-Received: by 2002:a17:90b:1f8b:b0:2e5:5ff9:bee1 with SMTP id 98e67ed59e1d1-2e9b177bd4fmr6176123a91.29.1731110175789;
        Fri, 08 Nov 2024 15:56:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59f1dsm36081805ad.182.2024.11.08.15.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 15:56:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <94871adf-c2d7-496b-bf05-c3a773f9c919@roeck-us.net>
Date: Fri, 8 Nov 2024 15:56:13 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iio: temperature: Add support for P3T1085
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-hwmon@vger.kernel.org
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 14:26, Frank Li wrote:
> Add basic function support for P3T1085 temperature sensor.
> - reuse tmp108 driver
> - Update imx93-9x9-qsb.dts
> 

Subject 'iio' is now misleading.

Thanks,
Guenter

> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Jonathan Cameron <jic23@kernel.org>
> To: Lars-Peter Clausen <lars@metafoo.de>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Jean Delvare <jdelvare@suse.com>
> To: Guenter Roeck <linux@roeck-us.net>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Changes in v2:
> - Amost rewrite and reuse existed TMP108 driver
> - Link to v1: https://lore.kernel.org/r/20241107-p3t1085-v1-0-9a76cb85673f@nxp.com
> 
> ---
> Frank Li (4):
>        dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
>        hwmon: tmp108: Add help function tmp108_common_probe()
>        hwmon: tmp108: Add support for I3C device
>        arm64: dts: imx93-9x9-qsb: add temp-sensor nxp,p3t1085
> 
>   .../devicetree/bindings/hwmon/ti,tmp108.yaml       |  8 ++-
>   arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |  5 ++
>   drivers/hwmon/tmp108.c                             | 71 ++++++++++++++++------
>   3 files changed, 64 insertions(+), 20 deletions(-)
> ---
> base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
> change-id: 20241107-p3t1085-fbd8726cbc0e
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 


