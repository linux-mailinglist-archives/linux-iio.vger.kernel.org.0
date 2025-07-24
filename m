Return-Path: <linux-iio+bounces-21981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBFAB10CA2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B3A1C81648
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E182E1743;
	Thu, 24 Jul 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="brv/znfL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2F2E173E
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365540; cv=none; b=I/Nrfo+fn3xBvqyu+OTG6PW6XQmiDsyzionfJsHstb+cCTJsEYeq/KmaHNDyRQoQVBHvGekZAqR8DmClRmq6ot2Hj4zladpxy77HJ7NM85vRtMDWuHmZeqUu9hI+zFJj/jJbA7bOZCHELC4jInk8G4RfWbiuW/mvUFc54rUzxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365540; c=relaxed/simple;
	bh=r8m0H60OOKOoeR/NbCqxjR9n2Mi89/uUoIKCUGbAQns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeVgvMVohKtaSg2xxbUprKQ+oT8ab2YvfjozbrRa3uSMBGrNQJ8OSboWIeNqGATbn/HsE9cR+GKFyadDuD4pnkNboHe9Mp6zCAbmlsayCErWx+EkMCeqiwIkZt8dkQuXXdvaqAhJCwcKTfSOUSmjCRtlqCiwYBijidFNMl2Rj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=brv/znfL; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6159fb8b2aaso502603eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753365537; x=1753970337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8lhkGM6eZ06qMIeQSqBFlLSi5hic1SbTRnA9SoJkZU=;
        b=brv/znfLEAvcxVOx0oOAtROISGPc64MFfkFM+k6Qbz+jD4QcouAvKKeFu86AksfoPO
         w4mXciJfpOdw2ANz0ciS5gtDLZzFbojkVRevcFmTcBxsAzG2mEPd4tYc2aKNYEaky2vg
         P8vES8e4YAkKc3gWEHewXQMqYajuDM1nekJ/UQf2pkklEyVyyIAytyga0yR6oBAMvEF4
         omNdfWoMZBPrFfbnLDSHyRJK6vxPa6e08NX9BQI/fQbCDO7TQMezJUYcfcRyXhptQI7y
         xFyVrGcrLRLb57XOt14pjJZtnNmPuQF0qUT1LaSbDDs6fmgS1LjZPkMPvQVdAL6WCWVZ
         C1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365537; x=1753970337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8lhkGM6eZ06qMIeQSqBFlLSi5hic1SbTRnA9SoJkZU=;
        b=gg9ct13rpZwXDYKuLhJkFNleCAaszTiYQ43BGwPFWNy4F+6K/GWlFVA/R6+jIVFgjM
         hcaDDfTlaTWAIDWviJvSsGlRDq2BvfFk9MXZeIvxpRhBdIx06txL8acjUaQtAfAakbWk
         HoFoyMcI9kz1bDXnUKwzfNguH+ssWCH6Hd4W+6DDMYsRaAFjXSIDpIX6xb1BpgKuPGEo
         RMlPNEg1u+bkcjiAkKsK9OihP7KCUCp4so2Jq9vadi0Nvuifo/b+CShooNP8ofpXC4v2
         NO4e7dO65AHoDrXXILma3rJBoQ603aQ/7Q0AHR59RQdFzSbZ1rN3Lyx5n1v1gplCUQoO
         VXgA==
X-Forwarded-Encrypted: i=1; AJvYcCUdExMRoCD9gLql/9sOh2SP8VEDprLhD78ZhfNBQchloHwRrT5m3j+nx5StcJLu8UdASKh2SGq8uiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKon6sZ7T6BE58B+tMFqNWDWDoDAb3aVVIthtSl09qty5wh0oO
	sWPjS6ITTMZ7Zj5e8MC2CD7B3GgskPDF4z+kU99zm751ZMq/wouyMVMcauanGpRPFpA=
X-Gm-Gg: ASbGncvWyzBlMvBSS+wZw78raFoNpZiij91YZtP2ZOYgJG2OMFJV7Q9G9dtzwVW/dgL
	VSrBlcz/ctKlHk5uLG2bF/hz1dLcRw+zN4ExDYhtSdsran3AsjhCaLvRlhabOpEuIHREiznFVNX
	brYD4zFpPA60caJHdmCw3mzAztqEVSf0JGbeZBHj6yMWrAMV4stot1tWaB0atmzQyHYULMMGC9f
	o3sV0Ad/EutVmRHu+FCtOQYsM+Tp7QfhLalaukJ4Q7ofN3+rOP5DHdvOIJKzW2BDeqmGs/vNhFz
	YavMhuZZ0rqgNyMyOiF5/WC1r+8OkjuHVYpAz49PrnFefSWKA/JHPsAulvy8PuzM2GBlSHzuBXu
	N22qvNYF1zRgOxJ5niE2E0YfeGdKWprdL1mK95hm1+BT4q0lzCrTwTmMFDj9g3lkdWVDAh/wYx4
	8=
X-Google-Smtp-Source: AGHT+IHZQzg7kaDuAlFKlh3XPZNFCAFVXmInWE92TfWbiWLHeoiep/6LdiR6Fg9xqiYfhuX5RRglmQ==
X-Received: by 2002:a05:6820:6ac1:b0:615:c215:6134 with SMTP id 006d021491bc7-61873284b83mr5671009eaf.4.1753365532107;
        Thu, 24 Jul 2025 06:58:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9829:e9f9:e475:a206? ([2600:8803:e7e4:1d00:9829:e9f9:e475:a206])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-618fb44265asm223960eaf.11.2025.07.24.06.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:58:50 -0700 (PDT)
Message-ID: <d292c93b-1ff6-43e5-9187-2ce851399bea@baylibre.com>
Date: Thu, 24 Jul 2025 08:58:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: add power and energy measurement modifiers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
 <20250711130241.159143-2-antoniu.miclaus@analog.com>
 <1ead013c-56ef-4f11-afb9-2b11e0de7eb2@baylibre.com>
 <20250724140940.2d9b4a1f@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250724140940.2d9b4a1f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 8:09 AM, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 14:23:14 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/11/25 8:02 AM, Antoniu Miclaus wrote:
>>> Add new IIO modifiers to support power and energy measurement devices:
>>>

...

> 
>>
>>>
>>> Signal quality modifiers:
>>> - IIO_MOD_RMS: Root Mean Square value  
>>
>> Suprised we don't have something like this already. altvoltageY isn't
>> clear about if the value is peak-to-peak or RMS.
> 
> Hohum.. My vague recollection is peak to peak, but oops we should
> have documented that better.  Someone want to audit existing drivers?
> 
>>

I did audit them (which is what lead to the Q/I modifier cleanup
in the ABI docs). Most drivers are just using the frequency and/or
phase components. The ads1210 uses peak-to-peak (I should know, I
wrote the driver :-p). The envelope-detector driver mentions high
and low when making an altvoltage_raw measurement so that sounds
like peak-to-peak as well. There are a couple of frequency drivers
that also have altvoltage_raw, but I didn't look as closely at
them.

