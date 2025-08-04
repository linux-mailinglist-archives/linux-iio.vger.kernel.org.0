Return-Path: <linux-iio+bounces-22260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2268B19D34
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94FD87A3C4C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B023D280;
	Mon,  4 Aug 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9X/2JZf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23F2356D2
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294501; cv=none; b=aF9tvBNzUMvaT6vTQKmi64OtGOUw9JHF9uCylJNyIbIhs2BevPYpUeg+ukq1cAU5g7QHC96yw0pkGUDuiHpp3+oFU9AaEkV7VW7U50ert548PBKl/rHi7XwMMar7VJOeD3dV84mEmGbvNxlcXUxr2MsbvEegIQUcaV987kaMYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294501; c=relaxed/simple;
	bh=GByb22ixbaBEUAw1zk7ZPruWDNSK9uHQ/Hf4FEcPWPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmiXf5OWWRrZXvwqKLC0z6HzCj6GxHTBbl83IzN66fvD1T66lg2L9coODrEn4XJsJ43clbx9LKJH4fAQLM/LWe+24FolsGl3d/cKmLEnwq0DmKUXofkWl8BPGNmbj+ApwikIGG+s7sl0/vJkU49CJw0skUnzTk0SKDUI44AjbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9X/2JZf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-555024588b1so3798193e87.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754294498; x=1754899298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOqOT4I1l6kaPuoZaZAPWg80LsXs2FOXfaQ8mMrgGdg=;
        b=V9X/2JZfxIrmsKIMekHABXwj1244U6rZI86oPXwJ7BDkiMR1QZLmw93S8NMact9y9H
         LO+gTKofPXDembVX8KIuqj2H/JVhf72TBvf/7Lz11UJobdA5Xw4q0WLFh5CjMm7eMYtk
         j2z43delripv57jd4LGEAq3jSm5GgmMPV1BmPbxseGjLS3bYS+TWEgNSP8aVGYd4g0tL
         QT+kpoeMPIw9lXQaMaMyVNlOl02VIYGDEKRty/3VyVWty7GgzGUsIgJg4GbkUm6r+XRG
         w1nQQ6pNRY9quEx3q2AVdW6E6aTRtriw31QaIMzicaZ8bvI0ycDd9epdMjPYFssxD6N/
         r6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754294498; x=1754899298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOqOT4I1l6kaPuoZaZAPWg80LsXs2FOXfaQ8mMrgGdg=;
        b=t/Aj3SM/yyzZlAcITtyBgmi7kpa1CE3lxM5/j0o1xF4FgSPFgZ9FvZH5tMye1l0uPm
         vBtV3q17Zx+FM3uJ88A5rQQEeWiiR+7XU1ds/nmd/a63Pzn+5+R/i6YXQ9Amrxm4vfty
         nOIWXLO0EJT/KsbONTHx49Un6H13I4ThTlJG2XthglJ0OnxJo6M7BFJx4XwkPYyS03iW
         3ptk4Lzfi5opS/xj5DPXrjyTSNB36buMjYO2FZieypFzE7y6JsDswYxl0y3OS0HR+0T6
         BBh85vnECs1sWy2JN/3OlVubuBIbGLF88Hy+e9uHHO8pE5y+1+jafQz+4sHpfFjAjvWT
         nKLg==
X-Forwarded-Encrypted: i=1; AJvYcCVgV0LnRw9AIYP+0UEDXC3nuhwFfMzyRfI0uFXp6qdwS5PVgX7QCtlpErfQ0VKJx3P1Rg9U/evIw9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvNXZJ5ayDdSgHFr+yfSRV1pDYEKGoZoolbZEsd9Z73eyOY6L
	EvNQmOFx/N6paOaET0ynwYecxnaIGEVkk46q1BQuclZNO2IbkyLwy0tg
X-Gm-Gg: ASbGncsNXIy6W4VJASH/uItJZtqu5VKf39qXcDjk7wg++RxQ4MEz4SwZ56NFUhmpgf0
	uwUmJ1/cbk3fTSeWtMn1boSePTE/esSzgDpYUuH5RPqiHWzDpIU9lu3n4fbX8hDCwOLv4f1QVwP
	BNxcco4U3PZTZlXBaZWLcDZ5fNEjaPJsQPU4dyykVMMx5I7LLFxG4nMHF8ILU7gBlSp4TsMt8WG
	dPEN1nbsQF3I1B6uh7Lyd6Iwbt75Wi9DSPdNz/Ug/bqW2Zp8mn9UatO/lY3rxnXoXdRldCW0zjx
	5Sn7IrUFbSqvrKI7d7fTiIG7NPwEI80QqcXDL542cBrCiue1tAb+gsWjJSEKimR5wRKC9JObNhm
	vLUp28QZmRQMdkhnVqnWrhROJgtEnLR/x6Cb4PotyRn8pX211wR7FaMk8KfVOEa/YkeiL60R8QW
	ito4Y=
X-Google-Smtp-Source: AGHT+IGqAPhTMdHppmp56R0CBXsH3lHIA32/J9NhQcJm2LgUFCQhfDAv0crVvPc63cwbuMrgvwUnwQ==
X-Received: by 2002:a05:6512:3a8c:b0:55b:74e1:f4ec with SMTP id 2adb3069b0e04-55b97ba4c13mr2341475e87.43.1754294497624;
        Mon, 04 Aug 2025 01:01:37 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c990f1sm1561910e87.82.2025.08.04.01.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:01:35 -0700 (PDT)
Message-ID: <ea683c49-d679-4c0c-a95b-849461d0a2c9@gmail.com>
Date: Mon, 4 Aug 2025 11:01:34 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] iio: light: Simple conversions to
 iio_push_to_buffers_with_ts()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost
 <astrid.rost@axis.com>, =?UTF-8?Q?M=C3=A5rten_Lindahl?=
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250802164436.515988-1-jic23@kernel.org>
 <20250802164436.515988-17-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-17-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new function allows for runtime checks on the provided source buffer
> being of sufficient size to accommodate the enabled channel data layout and
> the naturally aligned s64 timestamp (which is non obvious and a frequent
> source of bugs in the past).
> 
> This patch includes the remaining simple cases for light sensor drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> Cc: Mudit Sharma <muditsharma.info@gmail.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>   drivers/iio/light/bh1745.c         | 4 ++--
>   drivers/iio/light/hid-sensor-als.c | 5 +++--
>   drivers/iio/light/ltr501.c         | 4 ++--
>   drivers/iio/light/opt4060.c        | 2 +-
>   drivers/iio/light/rohm-bu27034.c   | 3 ++-
>   drivers/iio/light/rpr0521.c        | 4 ++--
>   drivers/iio/light/si1145.c         | 5 +++--
>   drivers/iio/light/vcnl4000.c       | 4 ++--
>   drivers/iio/light/veml6030.c       | 2 +-
>   9 files changed, 18 insertions(+), 15 deletions(-)

Yours,
	-- Matti

