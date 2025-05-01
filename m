Return-Path: <linux-iio+bounces-18952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E2AA6775
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 01:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0317A4C4D49
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 23:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818C26B2B1;
	Thu,  1 May 2025 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R9XONA6C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A5269806
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142245; cv=none; b=qMjI7KSJ5SzD1ZiiH22eXMqRDsnpf3rPlhhWVEIqvqTfysoukYpbI3XkcJ/2JpDcPE1ZXtQKQ42ngw9CgYPmlHKkEMoOn6BjjXUksY/srYpn4iTfQcYiZpX0oVHhHJkRmQbxtN8P9mgjGtNn/mYv4Qlgl1mOoaCnORGo+/QU5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142245; c=relaxed/simple;
	bh=jTns9oIgif3VO77ABK+VfD8XlPhogUFLl51PFlle0ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiEhIsr6pWa3Y3he6p6k2ge/3CO6uWDAiYYlt33+2KYVPpkkClewdubovqUdov32pNGXNV9bz0ePex4legfzOv7DpWiaLk31CEXa/xASpwnpOSBuVnUf0BaNB30j5UzC6FpgOsAEeKBaP16a6Uy3FSweiNIPXMFkG9pEklcOe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R9XONA6C; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c09f8369cso460792a34.3
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746142242; x=1746747042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KoA2UkN8oISoIkKyQZHvDSAzDe460fqLh62H4z/B99c=;
        b=R9XONA6CrGiyjO7ObhkDw67P6qD5PNtu+7Pr4pLQodewg7N72z0tr03KNLgqy2cEaF
         w+WsCEl3ghFpV+dLOhEIU1bNjwHUUuTehuBEC+XkbGyZ72x4itvMBy+WHz2tAEruFHdp
         nrK/7EyNKzNXbr/Y7XN3+VC6yl5CEW/MTn9czBe8ZboJlUcFnfGMWw0hN3c1OSBsN1cn
         2KpFsXSpNmIQyHdsFyJfjGrT1duIta1sPZRSdubwMyw9egcOqA2sxl2dmxpcX15YMk2c
         qJzT9Cc0qCiwSFd4edzCfzSAcPP/Fv+D7wDaBmWUVdlTfTruhZ/6Om4tVhyz1DYgoVc0
         CiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142242; x=1746747042;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoA2UkN8oISoIkKyQZHvDSAzDe460fqLh62H4z/B99c=;
        b=iWrBI4rhUIdOatNmN4taGJOMpxIzXcnhAn1pBcxS0iGh8D9BfUoRZOgkVgNWB7i0CY
         3OK1LYQQ6Cs694Ou7qgnVjqY0NsAMii5LTyq7dS+KQwtOsYMWLXXO7qO46tDH+qupthi
         GUZ046PqorPRkMFNyFmsjiZc+cDR782s7a6Rhim+8WxP0Ll8V+SYRIPoVPTTjnzc/tgu
         IpJ8b0xA4XMJqnMJg0B/+pwIpY/bssaqs0BuUj+wKRHDvrQO+g8ISEkNACGZXgkPCCn2
         Mg4JdwTIIC4ke4EbDUb+7daS70ONwzMf7Mnm+wCIhV8oMdeHvkZEfTh3q2H22FrsjmJ9
         RH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFy/tmT84gi5DQFTIXauDs12htIX2QvRYX4KY2ruqJrSu5tGmdrJcqxvZXsybpqU+nT5TnB5vE65A=@vger.kernel.org
X-Gm-Message-State: AOJu0YznuOUmJuyIADAgQg8VE0yA3EgZgmtcx8mGdV8P6x1YjKUU5299
	+Cz6xpLoKalKgG7TBFnzWj8Kd8D2IhWrgHsjSj/uYoUwvsY6l7jVmjuaqcQEhCs=
X-Gm-Gg: ASbGnctdNexc1r1RKpTMPFDs4CO96mpZqXww2YC9uSbPO0wQnoKOnl70Ujh5e3nzFkO
	ZdDrQPh6ED6aLxdhU9fbJ9MSd2n2l59Ffi/BaMSVCYVKd1mcYF4Z55nswaWBxL130F20G43hvWQ
	WxXOe30+WtS7J9zwiYe5zxQkiGsfLP9YY0e2+H9+rZSw1tkRFX4fxLpNrxhoVX9aoT4ocD5kZEh
	awz9jeQjxGvaqh1qmdbkg0Nc/2440+YY71PCu/8fzR58EX3hliYZLMmkejap0SZCS047ap2dovp
	sRlUTmtuwjGOp8NybdpQYiqOg+QfVWGc7IaIqGiZI3veFPMiFIV249+Ey+g6066Cv5xPnSTZX/i
	K46xuTLSCa9W++U3UZg==
X-Google-Smtp-Source: AGHT+IHQutzKltF40eIlfzs0UsiBrITbt6d9rQunGgbvkTDcSJntFVMQ2ABf1f0PkqpxkIpQy9UQIg==
X-Received: by 2002:a05:6830:64c9:b0:727:4576:36f9 with SMTP id 46e09a7af769-731da0dad83mr582244a34.3.1746142241804;
        Thu, 01 May 2025 16:30:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d350a04csm300686a34.68.2025.05.01.16.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 16:30:41 -0700 (PDT)
Message-ID: <a355a23e-03d4-4f1e-977f-adab632c7c5c@baylibre.com>
Date: Thu, 1 May 2025 18:30:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: sensor-hub: Fix typo and improve documentation
 for sensor_hub_remove_callback()
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, jic23@kernel.org,
 srinivas.pandruvada@linux.intel.com, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
 <20250501231931.1865276-1-chelsyratnawat2001@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250501231931.1865276-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 6:19 PM, Chelsy Ratnawat wrote:
> Changes in v2:
>  - Improved the kernel-doc comment for sensor_hub_remove_callback().
>  - Changed "Gyro" to "gyro".
>  - Changed "usage ID" to "usage_id" for consistency with kernel-doc
>    style.
>  - Updated the comment to state that only one callback can be removed
>    per (usage_id, hsdev) pair.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---

Normally people put the changes here below the --- rather than putting it in
the commit message.

Patch part looks good though.

Reviewed-by: David Lechner <dlechner@baylibre.com>


