Return-Path: <linux-iio+bounces-24030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17624B5558B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90A117849D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F97D322DCB;
	Fri, 12 Sep 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tAjR29Eu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11C22A4D5
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698873; cv=none; b=HajEb/Z60aeMg5ciWwHo65ugda1hobOVzcKu9/3dYVt8gti6GIxEXral6WFYP6yWFpu6/+MOFRV92Y0D+SHoJik28B/t/7L0L/f7TWitsA3Geq7rHs8IDx8gwVthjd5I4KEZDao2Ldqxc8CXlVFtisnl7F4ON+oWodwPmpEXa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698873; c=relaxed/simple;
	bh=ebVMkI3NMLghY3II0wHlBBRcDRzhUEGXKBz6MIW4EmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBv8NJgU2Ihs5d806re/s0Pc9WvdX7KTp/TTSxEcdGPFubJ2V2Su6Ry65YRPmFWXbasiEHxRW4L08RjXnS4leMN4R6iKUtyaiZF2Uex2INt9ax6kABxG4H9lZ+tFEyCQXjnCM+w7FZu7hDZkToxrDNzChu/rpeSv3sVpsWAvwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tAjR29Eu; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61e783a1e00so1331608eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757698870; x=1758303670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMFngDg+ThTxH2TqhAB/OrQnknv0ugZMsORXJCad8C8=;
        b=tAjR29Eup60dWmdPXZTlLtnuXR51PmBwfneMTLfOeMuPdMQZ6t4DpJ+P59gLo3IOr0
         aFla4USTyJO2Oy1IYD2OK3Pxcdpi7+dE3Ce+svZhO47OyUUSzvnNH3FqRleqWmb/BlKf
         XVh9/WFd390bEl+B4aXzSwucvxFoY1kzloR1myNdgyY6foky7NsVCONoAjgkQFjLv0ug
         QYaEuySSreWaSirwuHkufF+0F9tp2rlLdghKYgyF5W3MHN/HRgVSL2dgsMmJIBdMxYRk
         fpVS8F14gckwGgT33Rwh4f/Vhm7TFNEqymCFQEeMnqC8jsWeXsOW1GutKeQ8XYZP39uT
         6w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757698870; x=1758303670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMFngDg+ThTxH2TqhAB/OrQnknv0ugZMsORXJCad8C8=;
        b=fe8v1AZ1F7CZmuJJRRLpzcG7Z1SRborfo7mUnA6BuFZGbKavOEtLwspm694RYwgFyf
         PRiRonKZvjPqxfI3hhHjbNp5acqaPNyW2qcKuuy/v4z+7ybENAGeEBTUW6YhOOOOx+1c
         Gl+9dMkn7J1+KLNlQgNiMPjRoOPdRf33B+ctsH9tmwJZRJS9YThz8QP1JmFE8t56+tnz
         QhtDQjZRuTd7FAybtZQlg9jtDBtHRrDWpIykO8x5XQg1b0CU4/W+bPDzN03QSZ+ingn9
         Z0FZyCEZNCeQjvGQV+tcJP5DAdUHeC0soU3xmHrDatnp9HGhZkAptcah363bzW/eq0sr
         rGZg==
X-Forwarded-Encrypted: i=1; AJvYcCV4166XyKblWI8e3+pOHdE7IHv/J0c4UdZH0YQxPIEuTz7LhJcU4yogZ6PBS1+/3SCEIv+0ODm/K6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Iud6huKbg+FVLxMF2WcBKgmF/RFGPsIvHkYjgbHidlpNp5Bd
	IeY4l/Lytwbsm1v3n5IgAwOQYjRfEx4rxWE4aEgBOvGR9ds6r1ekfCszlOW3iIAN12Q=
X-Gm-Gg: ASbGnctMQ7kP5H9j7mwSVamMSkBeucPNxGsk1zFIg4LjMK0YkD+vg/9k32i7sOabCLZ
	q3FwvmadAwv0p0BNzDebqdSbrc5JQiAkCvRmPuo4Nb8YO955hnROn3UrQT6Y8Tv2z3GFW8WHAYa
	/ZtxsaZWJMxnAlgAOZQL0IsJwXMfZh/96h4xEmpP4M/NT5xpxcJDYmQ2x6cubh+ybtfyCmiePrf
	p3xahHP+GRn493ZVC+PS1jEVOGiqhOEAU52uyvmfQ2JHGDosR0H8ODEmFmt56s/Gnp0WLS13otR
	cAScx8aZewQ2C7WI19WQZnA8upDRaMSlNmu5nL0+js0dxE/Qrq0ymedwkcrToOfK8vHRXf/OUZR
	6FRbtj/2FWvHET8LcJnohCrc4aAdvUUVqnBLwZ2S2wGzyF0mdI8v2tweNmVq1xeQypPVsz4QfEp
	I=
X-Google-Smtp-Source: AGHT+IF4uHwM0m4f1PF0IHcsQHJY8vH9pv/dJXciija6fJHfMxoFbxn0mU5WZrupa3mzpzPuWfE4wg==
X-Received: by 2002:a05:6808:2185:b0:438:1b50:fd7e with SMTP id 5614622812f47-43b8d934557mr2303922b6e.22.1757698870299;
        Fri, 12 Sep 2025 10:41:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1? ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82aa7b97sm869170b6e.24.2025.09.12.10.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 10:41:08 -0700 (PDT)
Message-ID: <6dee1849-45f0-47c8-b29e-8057dee44b6a@baylibre.com>
Date: Fri, 12 Sep 2025 12:41:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
 <CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
 <d5e53a9c-418c-4c33-bbf4-b7d49d523cf2@baylibre.com>
 <aMRVKZGPv4PwR8-o@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aMRVKZGPv4PwR8-o@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/12/25 12:15 PM, Andy Shevchenko wrote:
> On Fri, Sep 12, 2025 at 09:19:36AM -0500, David Lechner wrote:
>> On 9/11/25 11:39 PM, Andy Shevchenko wrote:
>>> On Fri, Sep 12, 2025 at 12:42 AM David Lechner <dlechner@baylibre.com> wrote:
>>>>
>>>> Use guard(mutex) in a couple of functions to allow direct returns. This
>>>> simplifies the code a bit and will make later changes easier.
>>>
>>> From this and the patch it's unclear if cleanup.h was already there or
>>> not. If not, this patch misses it, if yes, the commit message should
>>> be different.
>>
>> cleanup.h is already there. I'm not sure what would need to be different
>> in the commit message though.
> 
> I expect something like "finish converting the driver to use guard()()..."
> 

cleanup.h was previously included for __free(), so the guard() stuff
is all new.


