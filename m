Return-Path: <linux-iio+bounces-17519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B2A782A3
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3E83A6E21
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5220FABA;
	Tue,  1 Apr 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v7M+ScL0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A71A7253
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743534810; cv=none; b=Ri1wUMfbHjERnMoeKBYmX94dXGn8YDsc1inXA0Bqt1p8Nnbp+KEtX3XXypccU7U6dhrCkF9dTtcV+QwfbbeZHpb4nZHprrO9xsinc7A8/rwkJlokyOC+yC1uDNCYFsmMW3PqNz918H7WkmC9WB4K1WsOm/TPaSYu2j2s9rVAw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743534810; c=relaxed/simple;
	bh=RVAglS4/TFepcEDW3jXL56WH0OCsWttOjIUmxqO0RH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nm7OMxXKG7rp2apaka4wz98fczKXQScYGZcxQEa4TPSsIiKhM4RBpxIYbWiZdQOHOLYmo1BKi83xgbpWfzDiQ7xjCPDnG1YDUQ1610OSZgSQfGpS6KPVXop22Vsgxdra25Zd3CbA4CbI3R5PJhqFxg+cK23/pzFJRcCymkszwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v7M+ScL0; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c7332128eso1217792a34.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743534807; x=1744139607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eC1QHAefHqt1UzvseRFaUCloi/7TI79j+QqQ697I/qw=;
        b=v7M+ScL0df3TUBgepyEAk1D7k+AgqCnFx0GQqgQNl5WRk9loDmBzLL7Rc2y454a+0m
         aV1eUUiZyCAgjARgFnsFqzAi1cepPn1FbE7j6klu3+/xWzhCrhUM79LHkQp4Hz0lLrhy
         fEGCw68gUjM1vj0lqNk7Tib9si5J4XdV4MkpsBUjqEXxgWuJjjc+Re0OmnnSr0BbYhjr
         P1Q6vh/hff1w9RJW3eSMggDoI1XZTWgaslCNuShfSr1DnSsAa7x/WBJcDT64WfasJ4c7
         wdqaTu8ef/xikVpQdxVwa8Qzu5+ULu110X+u9kB0SMMsKl2VBF6p9Im+7ZNpzVwujUL7
         DThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743534807; x=1744139607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eC1QHAefHqt1UzvseRFaUCloi/7TI79j+QqQ697I/qw=;
        b=sHYSUUcj0zwQ31i8AnvFczjoV5xgJJZRbeoEVVE7YZO9PocPM0WYG699KNmNnJY9l4
         hvEwbTjRUuRPPSirItlCm0Y+VPlen06RB5RgItBIZm8k7Y7F51VpBbS6vMzOS/zKfZ2V
         MDk9Wc/sdHznTt746W5AIGhcoQCM4nTzaz4vZOrpnYkwlrIBmJLZUJrwUmHeoggAVLZZ
         gH7moAb7zFTr/zAX6yq3ZR5C/yyvYgTxRl15wmsbWgM7NqXNm4coFJUyhAQCGx9fz95J
         xy3GYu9JNpkyCpXX/Ki/zQHv0nRsoq5JrCQiyetSv2xpDi4uYBVwjMsliB/5bELFkwTE
         PZEA==
X-Forwarded-Encrypted: i=1; AJvYcCVowUZ9UmpMUE/17bWyhUqSHWNMC//llsfsHUt8b+Z63w6EFzFssNZ9s+WmYgOwC01tu+i8h9e13ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXETDfS3PVN1yGl4QaPNbBybqSrfF8CwVp5yoI8U3P7n4uP/mi
	zntb/VI3tixUYVF+CPLa1b19fqx62hVmIUJ+FGm5xJKjVWmIXjX1NWN7Hxikigw=
X-Gm-Gg: ASbGncsLrPVMDwzLXcwdIpEh+s8ScQh90pNbe9TBa+imox18fiyAorlt27V2kJPOvVW
	3mDmi+QNIOeGoavIPM/VX8/ZsLJKWd+VDIdwCJdOhhPV+kItbXHxGPdYfU10x5OqePoZofQNaT8
	qtiLqjyKylp3MtZ+hDjWJS1JakV7kqjPNWw7QRaMW0FzRHKlDBR3gs3mcIC+Gjd8IXIFFXiQtNe
	ahfG35GqWPCV9KhBLxkaSD71TJXnA++TW+29DRXq9mfVlQRUqtYF5bwotNpuHAGDbY/+HeJOvzD
	zQBFPqEQ6qRy2rP0MDV3hnix9iBxxa4KnWq2WixXvtCWBq0t58p3oeBhRyHcwZfJERBQNCelIdO
	N335efX4+kDrFTjf6
X-Google-Smtp-Source: AGHT+IH0Vr2S6OqTtV4GI13XvHaoKkhJCn1kOZsgh+uD2AOSlGA3Sv/UFZWiKdKcpqkqgZ/njYfx8w==
X-Received: by 2002:a05:6830:2808:b0:72a:f44b:13ed with SMTP id 46e09a7af769-72c637771c3mr8141852a34.2.1743534807275;
        Tue, 01 Apr 2025 12:13:27 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c5826741bsm1975222a34.45.2025.04.01.12.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 12:13:26 -0700 (PDT)
Message-ID: <795a7c97-4d11-4277-91ba-77a5641759de@baylibre.com>
Date: Tue, 1 Apr 2025 14:13:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] IIO: Sparse friendly claim of direct mode (the
 rest)
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>,
 Jyoti Bhayana <jbhayana@google.com>,
 Nishant Malpani <nish.malpani25@gmail.com>,
 Eugene Zaikonnikov <ez@norphonic.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Shen Jianping <Jianping.Shen@de.bosch.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Yasin Lee
 <yasin.lee.x@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250331121317.1694135-1-jic23@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 7:12 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Firstly, sorry for the huge patch set!
> 


Reviewed-by: David Lechner <dlechner@baylibre.com>

