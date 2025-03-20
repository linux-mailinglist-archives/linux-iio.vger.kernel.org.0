Return-Path: <linux-iio+bounces-17160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689EA6AF5B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 21:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7754E4652AE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15CD22A4E5;
	Thu, 20 Mar 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o2GWLK/0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046722A1E6
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503676; cv=none; b=fEhg4ETZBNklCqRko1begiXnLxfXzvkuhtq+at4NQeTVvh49Nh1qzYFDx0MWf8n1D1WdJCE2vdJ1vZPEkTPDXy1bgVBlPrf0hj73z9efUPZMiZX5/rrTsRUnPp5GGS69VrZHmVn3vH5JWSMfn05pLO1u9wItJpC/Kt8+W53taLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503676; c=relaxed/simple;
	bh=akoUxBA1ighux8JnAPCyxwHFsZb1eSOKkYyJaXVZOXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdC1a62wEJfgL4XNKOlqDYAAn7soPW1zOIfqnSaoF0vgGZk3p9S/4MoRBAPPMGl7vcWZpdbjD1M5L9hVPm6xC71WPOLwHfaQVNk2kirpAtcL4mF6xJYwq24A4mngHKwqoFez5PUj8/qyKeqJCzs8aqwaSoCC9dVBZIlVhV6z0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o2GWLK/0; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso791426fac.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503674; x=1743108474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoUUte5ljdke831I8NU54sFFz01ai2RoggYX+/lHrQo=;
        b=o2GWLK/0sLKSttky6n4Lb0jVfgW93gv7yebzrhiM46GyPTd971+MJaaBFJJNeo2Jd0
         EOfnfsWoRl1A0u82xZZyqhasrPKwbI6xa6K9qvDkOjrbbcKdEP96z2jV3+DA4oA2xFty
         MkbOohVAPkUFs7ydzuiAl11pwsW+q+4NvEQ9fDyKhkIAOqru7gr8AyYRMiuuNaBv4Dlc
         Vd8h2wiKo5Gfnn3BnOcxNu5UVNbN03vJkWKj5vcLYwe5PV7ayamcGpz75bq8te5cuN7R
         ZLcZU2w/E9pVBaDPwQAuRmezGmpUcuqyyZ1lNEtytLIlT33j/LZ0umgXNQQPONASRwz7
         Ycgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503674; x=1743108474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoUUte5ljdke831I8NU54sFFz01ai2RoggYX+/lHrQo=;
        b=ZV1eBk2Vs6HLLnf2hevj+lVsVx7LUYVysQyLA0KyytGsSRDxVu/5lw2SoHp2jWTUog
         XFijWwV4Xn+81zHQiqbHMUwkbLTggrj6Zm4TR8aVKXvNqXDFN+90rD9Wt/WDgOGdD6/v
         hQ176RtnMhz13NpKUj69OUKPFF8cio3ZawfH7cptTn2FQfKsqtjTR8YQvUeqb/iW4Qew
         HaJwWEGL82QkZL0ovePyOpgpzen0zDa1oeVVMXPQlQcDsRheigQd/58fTp9ud1NMETPK
         ew+TOfSgxWAt3pCHp4V1gn4nZPZia3MIIHgDgH2/zebvc0BVspcZjOkfCkStwotG0oaf
         JxDw==
X-Forwarded-Encrypted: i=1; AJvYcCX8uIscgLclvwqbjLODSAht3+lpJbxsltQhnYwkXYimoqcyMkyWmYFkL6Mb/5XtR2DLrCk7fqjLrx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8vL0GI/Mnsd5F8GtDqO1v9gSebffdPn5t5v0C/VJQuJfFmZG
	DOgeLg+SYJT7vU6Iw1b0EJmOUwDDcaiP0Gwu4LvTMY/IiBfj3tfCkHxk2ZYPstw=
X-Gm-Gg: ASbGnctIxoGlgfmPopWJnadMuKX5y/4faIcTEofNZE79pec1vPp5+QC6ZDQKdPl0wgs
	FyVhQmbRFDFcdIdtUoIR9OfVUa6mWn+WCDZ+3hN8zm44fAs2mo64I9ThmyFTX4LfepRrOAhNKfg
	le3rAjg6pzIYC1PMbN50tUIRpLrT02wLZm8ZnSwlMIx/QCK+ImGO3ghJS4/TtFzc3SgJT7iJ4Fc
	aXjmBO8JMMW/e/rWyqwILJzZT5G4H9Ufy+Bc2C9nZwQ+QmW49Pq/cEp7UUAVGKq7CJhXYVk0Tjt
	+VrT9ZY2RJvJoKznDidwOMTXYBVYxWRiq58+bK+e0LvqrvHqBR1M4kM7Uac3S3y1+tlSWUW9ozJ
	z+pIIaA==
X-Google-Smtp-Source: AGHT+IEThj26dBTP4Z2xXCcKfq3Tre3BUTf1MdLUxFhzND7kG9B2/mI5ooNOAggoJaMyQPPsgC+yqQ==
X-Received: by 2002:a05:6870:f70f:b0:2c1:4d78:57b8 with SMTP id 586e51a60fabf-2c78043942fmr646118fac.28.1742503673607;
        Thu, 20 Mar 2025 13:47:53 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f05ec85sm132955fac.32.2025.03.20.13.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:47:53 -0700 (PDT)
Message-ID: <1b544061-4b5c-4a69-98c3-265f9d1e32ec@baylibre.com>
Date: Thu, 20 Mar 2025 15:47:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] Documentation: iio: ad4000: Add new supported
 parts
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <4ad6c3d6dbfac9d5e9321a23a647cf333d7f96b6.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <4ad6c3d6dbfac9d5e9321a23a647cf333d7f96b6.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> Commit <c3948d090080> ("iio: adc: ad4000: Add support for PulSAR devices"),
> extended the ad4000 driver supports many single-channel PulSAR devices.
> 
> Update IIO ad4000 documentation with the extra list of supported devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


