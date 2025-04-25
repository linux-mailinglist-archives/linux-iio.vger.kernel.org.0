Return-Path: <linux-iio+bounces-18659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79770A9CEF8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 18:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960144A64C7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4181A9B48;
	Fri, 25 Apr 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hj8WG93b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA251A23A0
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600130; cv=none; b=k4pu+uf79IFHPpcjqvxv8FrZd/EZl5GuKpF4ARXBaarwmWOvO1MEEvuyInKnsUddXFaSWBHGm1oWpqWRpJXgcjO3+WiscHHbmrw0DFGdiW1dsFByxaAE0JCCUByudkWq1P0ig8hV1ZheS0imT7FCfubdakw95f4QD+uzk4DJbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600130; c=relaxed/simple;
	bh=av0WARHpVC5dP0N7FA//JdQofs5lv1A3nuk6xbdoAkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuvJ0EqnVhK/VNB6oZSYgLk+RD7IARgg2e4lTMV0O6qShkTpEz8m2wGZQKBPFf4DxzHwZ6AWVAbeIKDAsr/2u8YabZtpfj3AZMPcJfSH7KqbX+PikxsBRbXePbQ+rN8XNndcs1Rk6tqB/Drq0q2uUFG3OhPRRoBkP8P1oBaDHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hj8WG93b; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c3b863b8eso1963945a34.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745600127; x=1746204927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AsKVQ5GJOuiLwxDelWM0lJ+dx6Hx5f6lCwnvVtcemM=;
        b=Hj8WG93b3qHcwDSLKuvld7cy6pyZxLIoSbjz+aIgu/+iRHN9m0/WPtrjnV+maQNrra
         z4CMGD2iNL9SEjV3mHO3mqJHPcQIK24uWFku5PaH3LZz2ECw5FKxOyxcI+E0Ml0h7BP3
         g2wkPdmYdeWbxKBXUYPo754pQWoGKRbv583KTQNSjDKU6ERoJ2ehEOeFyX032uyqoQ3v
         CaJCUfhteS6QHtBfKp0KLOpYB0K5GwNBRjg0BnnhseM4gwUh+1H4h+hdGcuHRrGxfH2L
         epG524E0oJvwfklVf4KdT+XBpdagtfDlypRzzF2MN2eKu0CadmuTpIowLqIVYIPjFiA1
         JZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745600127; x=1746204927;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AsKVQ5GJOuiLwxDelWM0lJ+dx6Hx5f6lCwnvVtcemM=;
        b=OWddIaqQcPI23But//IP8Jnz0XNi+5ZVrj6swJiyYW0UZIZucfAVT+YRKixC70hcxR
         2vGm1daGzj9jWiJzFd2KxUyW+uuoBRA/Uag6a06wa/ANeASzzGDJ6N/qDIvVxWRlyNVH
         QDLKpKSB2j6RQbSDVKYgXoAMOWzgF8vmj0LQl4llS9GieuvS0Nspijw7lOvtpNoUPBsZ
         NEbdIomY6vE+MwNLLwV9m5fewdaGh2Enl44GBB33b2Obdj14YqNYQ6naMAQ9xRMjL9F7
         mUkaCtZznlyLDdr/zQ8vKszLEh4KSxK0A2ZmE/8AZnOoRQ0cT96or6hJg7Cd7CJWf6JK
         2eXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx6v+Xu0XIaPQhPZ77Fq+MrJ4r/2k/DwM3e9uZcWyqbb7d6iAZpvyeKfltgPiA56rJD3l0d1iP0HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswjTPubIu/73iSyaUpMPxyG2CMAMjbL/pD3Yj+GwGep3emfCe
	RWyNR8QIoTjBejOd/iN8p5MBahd5U9Fqm89jr/pJbEzzc1MgdoNh1S0I+hzx/P8=
X-Gm-Gg: ASbGncvwxBvRXlEUBeosrbkIFVmGGD17oy0Xlmfwsngabj2WB3gs+klgh9m0XZlJXkJ
	TQQ3VnbK2kU7GtaATj4ILJBSrlpA3m7wsg9TkiCWwKpjENWkQAVgMtVsAT21GGsDvsO4IYHg9iM
	55SIYt3DfMBMekoGWq62brHDEKNFK++nzpJBoPs8ddNMYKz4CNeYnx+juTYXQdzhvJDc2WOj4KU
	8yLvfQfl0q+Uxpvm2+vUd7yIWFNpeEk5OKTEzcXcU9zyWIFQVOAx7sZ12qlNuLT9Dkc+OIWbKYf
	+cs8PrYZCIPZMmlZTTUnEU0GUzkn1rUa4/RufhRXukTTFMsTJAZDvwp6Pis9XMZxqeA/1geKmKL
	wPMvV8Mqv5I60
X-Google-Smtp-Source: AGHT+IGz68VTwwPVP1aa1JRNKA+aEBF5LbWPHc0ffGLvBRV20Rgekg0A3Ho2Riy2YIvZqaA+SUdHmw==
X-Received: by 2002:a05:6830:6616:b0:72b:9e6c:9be6 with SMTP id 46e09a7af769-7305c7bca29mr1990781a34.11.1745600127490;
        Fri, 25 Apr 2025 09:55:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96a3:e28:3f6:dbac? ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f2ac2besm742232a34.30.2025.04.25.09.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 09:55:27 -0700 (PDT)
Message-ID: <a06a5b07-8b99-495d-8e84-200923b277c7@baylibre.com>
Date: Fri, 25 Apr 2025 11:55:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Guillaume Ranquet <granquet@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
 <CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 4:03 PM, Andy Shevchenko wrote:
> On Tue, Apr 22, 2025 at 11:12 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Fix compiling the ad7173 driver when CONFIG_GPIOLIB is not set by
>> selecting GPIOLIB to be always enabled and remove the #if.
> 
> I'm not sure we need to select GPIOLIB. If you want it, depend on it.
> GPIOLIB is not a hidden symbol, so why "select"?
> 
Since this parts of the driver unrelated to GPIO provider/consumer rely on this
being enabled to function, select seems more appropriate.

