Return-Path: <linux-iio+bounces-14656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CEA20309
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 02:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17CD18870C3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 01:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872A38FB0;
	Tue, 28 Jan 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rM6CJkIL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71E1B7F4
	for <linux-iio@vger.kernel.org>; Tue, 28 Jan 2025 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738027968; cv=none; b=CPjtwfll4eGVx9t/fWP2FPsM7Y+pHjWauvWbAk1ZxD/nDXAzUOWG+85LQHkR3NhDHLxOnJ5R8MvCwMWILudDVrBRH1XJlraZsi0WKqXrzduj2o5jk0yVF7rfo82HIRDF3xw5jWCXGVb+t8NH39MShZbmkB5pZWzN+alM63BSEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738027968; c=relaxed/simple;
	bh=lpnYd8GVhkmesJCdwtwJ90i0qkJVHatvY1VVHkW5Yo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQCQZo/c3/AYlKDDhk+HQSJoo4gbu7tXMTVDsFsfJ5EpYV9pRK4VFGjEwJGfIrYQioHlu/5WUelytGoA5juYzj05a2qKlXrZ2pHbLE6Xk/a5FMv91dd1Ct1gbsFzSqafTSDBIVCcZd/QezcmeFghLG5jh+93v2W/7F7KuPpjPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rM6CJkIL; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e2a32297dso2872640a34.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 17:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738027966; x=1738632766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbO53/E/v3sT/UJVuYcpmb+fsW1h2IM7Y9VN72GDUo8=;
        b=rM6CJkILLzgEhQHcVQVyGkxxZCRLRdL0JOU98Qwu0kHcnTXBsojcJHPLKZIetelDLU
         Yb/nqeCUcUTOZg4kGbGlOGyo7R2ykQofjGlbVrpdRGMekNMJvdi/FkCC+P0dVfZWkv9I
         p1zFX5VZ5HSQehFxUlEUGcFXCLGkg2UhWwvNl2HttlLRGGF6jbXz1BLvudkWJQq9Uvgp
         YOhs5UCk3oAsOsQk5et1XFqlrMWizMM5Nq7ZQiroVy7fEfH9Y1+E982evIypV+Mxp1Fb
         rwK2gmHJCiPYXw9h2JnAGdzOOxDFx3Sv5EUeZxKivDjpMMZtmZQHWB1bVEu0karabEFJ
         u5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738027966; x=1738632766;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbO53/E/v3sT/UJVuYcpmb+fsW1h2IM7Y9VN72GDUo8=;
        b=ssn2dz55ZKw3d/QEapfnK3q4EvfhkRD5ARYqxVlvfvPAo1QOTU2go3Wl1+C+Bjgxbz
         M0hXTxjOtf9CTQW5luhF0w3Re+fx/+SfYGO4NWe6quZ9YugugDfMuz4eI/iSm/Hs1iVX
         e3VVWrp78wE7voPwPlSquhXe5Ud1v7yyaNcdw5PSYikXlix3RPGz/PCxXmcemrGFiJGE
         6nKBPjTWos1GeHqZKL4UabUV/6h+JbjqixJX/WQ7BmvxwLIX+qyQC0KznNE8l8V4k82O
         HN8mNSKbD1N1W1CdSLtxSd7qBYU2rOgZ3h7CaLrjYz6fV75qhNbq/mqMG3sghpn5n61U
         3xig==
X-Forwarded-Encrypted: i=1; AJvYcCWIG33pdqmiVRT9PQFrD6zJikBdwxCcaHbmt5ZCrXqxPGZfAZsgZ+01E2HAErsUfxx4XpeKHekbN0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18MDgfG91kPHE7JbPoYg9jPT99KEogoA9dL4byI1b/VhWyVHB
	NNvjjPYa8ymV8satis6n1kPrSv3HvU7iMM4QF1bDsgOweetL+IuutUqy1TQTBd8=
X-Gm-Gg: ASbGncvM/ovNjNYK65u0BwnVFOp2Xufb/y0y0/Cr1XJFSVP49y7GIP+2fuzlcXY2yJp
	JsXvm1beq/yiVDUiVfx3ISjD6BiwyOx8eqlj84FBFElp1GEVQnF/4q7AbQbAYQtozgF6s7K7zPr
	TlR6OeOxZmcDIdubBxVELBZcy/OE3zyvgU6sXVXxrFgjHQZzO049bqmIo40E9WucvzSNUqxP++S
	LRZ0TeL/qYQgKWKPWRS8YICAKAWjJI7rMuRoF3uipYozjk/clg31t9kQcqz9CgKW8x60zSQoNx/
	yi+uULRAFUsp1FlpehH1AjWVetLhB4t1E9oSRk5iBusg/9WSLDFo
X-Google-Smtp-Source: AGHT+IEY9cy5k786jJtuN21pZ/JGG1tZcIhLGrbik1aA0W/Oj5MPrOTVGqDbCv6skYcYjfTdC+aqKA==
X-Received: by 2002:a05:6830:d06:b0:71d:f7d8:225 with SMTP id 46e09a7af769-72648c9bf71mr1046206a34.12.1738027966061;
        Mon, 27 Jan 2025 17:32:46 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecda3a22sm2696494a34.8.2025.01.27.17.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 17:32:45 -0800 (PST)
Message-ID: <95e9fc42-db0a-45fd-9155-9c8721c849d7@baylibre.com>
Date: Mon, 27 Jan 2025 19:32:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] Documentation: ABI: add wideband filter type to
 sysfs-bus-iio
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <351b15550f8d8e7126ed8253f3a8028c708327f8.1737985435.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <351b15550f8d8e7126ed8253f3a8028c708327f8.1737985435.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 9:12 AM, Jonathan Santos wrote:
> The Wideband Low Ripple filter is used for AD7768-1 Driver.
> Document wideband filter option into filter_type_available
> attribute.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * Removed FIR mentions.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..9b879e7732cd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2291,6 +2291,8 @@ Description:
>  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
>  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
>  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> +		* "wideband" - filter with wideband low ripple passband
> +		  and sharp transition band.
>  
>  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
>  KernelVersion:	6.6

I'm a bit shy to make any more suggestions on this one since my previous
suggestions were clearly not the "right way". :-)

But, the key takeaway I got from the discussion on v1 is that this describes the
_shape_ of the filter. To me, "wideband" describes the size but not the shape.
Would rectangular be the correct shape?


