Return-Path: <linux-iio+bounces-19243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC02AAE197
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5369C17FA
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C1F28A700;
	Wed,  7 May 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xMOwG7NA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D589289346
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625791; cv=none; b=CdU/bHgSYMMsAciCx57AobklpLSqcN3X3KClMOhv6SdmI1ekJ788cdQfbNio4ki08GL5CDpfZ8iIMuRCnNVwaRJ9bfThEoeabtHv1RrtDOCcx3AUdE+621qH5rWkDbZUSAyfdba3zn8vMUXfgz6dboFqfpqbTxkzWWrDE5it2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625791; c=relaxed/simple;
	bh=w9dJJZAfLFUz4sepGZ4yAHD92WyyzbYRQNOBLcVmWcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8IkEQDpBgU83Lkzuq+4+/aPjvSNSpUqWkG5qYvq/vWpAN+TJHkF1jSoZHFrEfL88DE94h3HJdmICkgN7yuALVHv/Ssg3bmPqGrYNp7W3bzh+EVxrWBWmqF3JXBo5FNIBYWEdF3YVzf01sMNCxTgJm0Jg3oInMrViHkYCAg81xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xMOwG7NA; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-401c43671ecso528302b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746625787; x=1747230587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2E3azbVaCRVDrY4UnTVOScgZIlfU9ExUYdpv0XY9P0=;
        b=xMOwG7NAiSA4M9iwSSzzquNz/WWG7vxM4jBE+hXIPioIrtEFMqxV7FD9O57Pdc6SZO
         gOLxTBFvr/Ficn3HfyB+izDOblNKOtc64bzwzSjlqlXSXMZwe4+UsjZP8THsXj6x5gOs
         vwsyrdnV9IrD/S84OtsH49vuaUeBaEPb5TWiAE7IVVahjO99L/oqd1DYYiamucXtfKal
         enjJyHLZJ9OvnnWkpJE5bD0eg3Po120jv14zqsWw9zlkZfQsm6QCEcqPVxmFQJqY+AL6
         VHXrTkqCpGfsxiKXlHnWMrGUhRw8vv9tIhIuhzn8qO8s99MRV4V1179SvO0llEH1Wx18
         B/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625787; x=1747230587;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2E3azbVaCRVDrY4UnTVOScgZIlfU9ExUYdpv0XY9P0=;
        b=l0SlHkh0x/CLny2JmJ781aOhNBvKjorcGBOnH14vFhFQJcSzAV8dLbKnz+Y3iELlMg
         AJwKpFH6JmkKdjrS8IN8LoWJdpm9/HFUPjXJRKGQpMqsCtGtYViPS+vjTEGauzIknZ/3
         Rrr01IPH81NvdIgNGKhO/tCvQFUX+VdL8nQtZBIxLVJgW2beswEXZBiNb7HcfFNNKzO2
         6n5ehiQoqGcrN9XzTHY1aggiTXeC07crDuzE8kNSawB4eudmj0KgkVD6n9T4shCDpVDz
         iPUryP0kMHvOjfn+QCWXHtB/j7UNcsAliTAP34V3AYs5j9T/RX83XO1tpNPM3A6EYj2g
         zKxA==
X-Forwarded-Encrypted: i=1; AJvYcCUcRygVojTkRSmqx7CbZGbWmpBkDY+s1w2J19lu/XZRw749/x1BV0PppdXJF2fATLhanVi5SH1ldGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlJq7KO3auZkgzkrpjp8L9YX9d8yJhOWHO0z4BKOrGvOrBRZE
	zv477/6WgAuh7s3HldE3CUVWudeTF4ObjdeJ0+6siVgU7PjguBBx0inbYFXFH5M=
X-Gm-Gg: ASbGncvXELDS67dQa6w4YHiNHL/HXrGfm5QMYsBauXQ06vT0S64OjK3yhSRRr6Gurd+
	lBTMpNii4Fu/22f4iE7K7Te5HzVjFxDdOufAf2hsRBSKMCMBd9O95It+W2fZKEtVFobFW/CpL7h
	BZsNUjRI7MYByAAHUVESvFjEtMN7Fw1XNNc/jzUY1WAjcmAo8GWp+npXJPju3qzQD2Da9XGyijq
	sjp43c2851VajjZmkPxK9OwqosZe3XDR7STDdnLeqZT/dnKDySZjT+4JkROIOcLCpCDQ0vuoASk
	cqZUMORBaUkgy5RFmiIoa7fecqg4pGbfH57W4InK2ga3ZzF4hefk9izo0rrbgDlnPIjw82gCRRA
	YhBuh6LUL8+BDmNw=
X-Google-Smtp-Source: AGHT+IEkqfDH15pjFTL4cZA58InYNRqoavGNSUddgSHwMO1Pw7iWYqyvF5hpJ5MLza2jpw+neoIdHg==
X-Received: by 2002:a05:6808:178c:b0:3f6:ab0d:8db1 with SMTP id 5614622812f47-4036ea41ecamr2103982b6e.3.1746625787217;
        Wed, 07 May 2025 06:49:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3356:f6f6:bf76:a32? ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7fe84a8sm2683429eaf.36.2025.05.07.06.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:49:46 -0700 (PDT)
Message-ID: <fbf6c7ef-3680-40ec-8c90-121e6a635b8d@baylibre.com>
Date: Wed, 7 May 2025 08:49:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: admv1013: replace redundant ternary operator
 with just len
To: Colin Ian King <colin.i.king@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507134502.254736-1-colin.i.king@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250507134502.254736-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 8:45 AM, Colin Ian King wrote:
> The variable ret is being assigned a return value and non-zero error
> return paths are taken at all stages. At the end of the function ret
> is always zero, so the ternary operator checking for zero ret is
> redundant and can be replaced with just len instead.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


