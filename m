Return-Path: <linux-iio+bounces-18945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0406AA6269
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8394E1BC24AF
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A576221D3DD;
	Thu,  1 May 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N7mPn4l7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A921C9E0
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746121060; cv=none; b=dbt60CBiKJVA0ctA7tHZfcCEzsjt0KIYH3QYPVrgFUTURdN3i1rciipMnLmCQvR0qB5io9Dpa3A25to7mFAuAC75asQl+jOBvi/m9Y+vIxpDLTSjT0D5LH2LN7vNm1cOP0GsW+8n/kp3hU/DgM2DTel3mKJsfSaDlgCsMvaGk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746121060; c=relaxed/simple;
	bh=n7tCVA/I1yo/yeD9ArRPIlTYK7DJ9Nd3uEq/KLJZuL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePpbgBimFcDiziWOOiC7gMhZyXxjCddiDOZZRzqcXwPo9uRPhlSjaXdn5GhjUZe5TzlSvWpxXk1hQcRY4ZP4i374QmAyeGPIiO3S1kFFkCQV5R0v9gE94XCvnDxxJk8wjgQuTBRvSjGco5lXUWkJpikJ4myEYeVzqKKLbItLGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N7mPn4l7; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4034118aeb7so13324b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746121058; x=1746725858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWEnf44P8DmPGIbqKOpgVenjN4nZrTylxIuWPEPPN/w=;
        b=N7mPn4l7STX/UPle6TPdABRDCEfgJmCpTTKhpY78WZuotpiwfoee3HSbF+8wk3+KFc
         hNEr9H8XBnLLa9IqE20WgxdrrBXeb96ACL6oqjpMw/8WS4lYdv6LEdSAV6VK0i44/P1c
         mAYVkU3fwHZ9UhhGLfwS8xo/UcfJRMDeFa1tq2WHB3yT+mTLMOt34rA6igfHpAP4FwAC
         exA0CDbX3ehrrWd887v2fjPWYG7p4ndNz0eeE5naBwCC7agxiqD6t78UfmQWxZc67XsX
         klGvrDR8x0hXunQRw6EVHtrzI56TrYCSlepHPo2mFmclzhaCTJTv98F9sJwMicM6Z2li
         AtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746121058; x=1746725858;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWEnf44P8DmPGIbqKOpgVenjN4nZrTylxIuWPEPPN/w=;
        b=F2p3K4dqzcf0uCGwhEi2UkhY6HJyYmTEthHdtqe9PLNew0yo/M4R6jnk8va5RPzJSH
         ExaH0THCPlm3fUTYSEedMCSH8VGxOYc3f/wNCWzl/LY8C70jsZBEDM5HFRLe3sa+6+jG
         2tFP4UAir+gGA57Rr727SkWR9pIz8gUNhuxwMdt6GobeIFNlwfWqh03Wj6p+Miv4N6zt
         fEKLgV3Gbw1W/JAdrAbfNZOImilo4mTH3ylJ0aG3JBf2xdWfu2nxX/ekMVk8wC/bRB1l
         eK+mMTc+jdxAOiMUiZfpk3H6eRfB3CJ/6nEU1NlnfWMUbzxZC9A5+Fb4LXdYuGJcXuDJ
         5GLg==
X-Forwarded-Encrypted: i=1; AJvYcCVPa4VaCjFU4cYPwSHC9Jw3iGXVaFA1nuruZkAnNefPM5sK4zWVpVmtEJlxPrUJu42GcRpOUfSMt84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HFfs+k2tcPNUNAbYvlta4LgYoEWqa65zZc0oW2bSSHiyNnjH
	ib79FEdpCYw5A+qdqxoDNgCiDzoxhFcroeaDfm9b0I1AzAIm1MoygsZNsh0tuWU=
X-Gm-Gg: ASbGnct6bKjOunK2DwM4qJc0Xe+tiP2b7tJ4cFdTXcy05H6EtAnxHgwiGSlbW2hDkcb
	kZOSRa5dDiNdodnaIFv8sOeTzszKXBX1FGMs9+8NVQudwD0+SyHzo672ZrzvShn8NWA31X5G51X
	N+9cqk0srJWIbgLEUXzS5zX4t44lDqR+tyKqR9SrJD6BzKQHNhx46Lhio7jFhQR8Z3kHSEkDJjt
	Bt15qDxUOJy0kNL3xA9+atyrsDM3JsSe4HzSEahoYh0gVKAgGRUDSuGBdDDFdpjMas5Hh3C7Mt+
	oR6luB2fAL3jc0UR/BXP8ZuN8jYK5WHKiq9zZwolSqaQv94MWGsGmkKBFvOuYVQLwcWnN1K/eHe
	ibb4eRnYAoVWArIaA5bE/fsW1auAH
X-Google-Smtp-Source: AGHT+IGL20gyAz4SH3A+Gml/P6GxXPU0D/byhQ6Ec8A6G16T781jbJMjfC13eZXdeAWXzY911EFxnw==
X-Received: by 2002:a05:6808:1b9b:b0:3fe:aedb:19ea with SMTP id 5614622812f47-4034147912amr63106b6e.25.1746121057884;
        Thu, 01 May 2025 10:37:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7cab6cdsm194276eaf.6.2025.05.01.10.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 10:37:37 -0700 (PDT)
Message-ID: <213ae3d3-b6d1-4808-9af3-36a8cc1f1335@baylibre.com>
Date: Thu, 1 May 2025 12:37:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] iio: adc: Kconfig: add Kconfig entry for TI
 ADS1262 driver
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
 <20250501100043.325423-3-sayyad.abid16@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250501100043.325423-3-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 5:00 AM, Sayyad Abid wrote:
> Adds the Kconfig option `CONFIG_TI_ADS1262` under the IIO ADC menu.
> This allows users to select the TI ADS1262 driver for compilation
> during kernel configuration.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> ---
This can be in the same patch as the driver. Same with the makefile - it doesn't
need to be a separate patch.

