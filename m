Return-Path: <linux-iio+bounces-22130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA0B1514A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44787542932
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905FC296156;
	Tue, 29 Jul 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o09Pmcwy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADE4409
	for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806445; cv=none; b=rK4uv9q2jU3WgEBT5/A7bKFBIbT8HDpz8QT4UYcQh9ot5y6jgmP/c/QzpBUIgobGO0S5Xfn/vxxzfTKBlt+VYA7j41gbp30WP8g17VJTC+OVJ+ydT8p4OzU1OJuhfi4u1dXm5vZU5YqsNCudhUQZM+A+xgaLoBGlHX/y8LXa32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806445; c=relaxed/simple;
	bh=+Ex+N/76JlJzNQ1mpQHpBbQAkZCWoPaGzNh2+ytXYUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIc/mwNuWbsN7/xoFFtXR+eMJ/vsfJEYM8+hJN4hxEIsiT37grDV/8ysux13tGk3K1yuda7ZXHdHWnvU3pxDblv4JRWNS5y/s+F6RJbOq9auJgLxX5KU7HPandxkcyn9FjG8clH+kJmVzvRRvJyAzyiY99MnnmUqwMCLc9dcinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o09Pmcwy; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-740ecfff873so3678707a34.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753806442; x=1754411242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBPGm5h/2s2YI6WQk+GinbBOPswke5n0aLNO4q5tQ8U=;
        b=o09PmcwyryeKTNKrt2BV1hW3YnW2Rrq98TrzuvX5yTAHRDve7OapQ+/IGUQC7uPWyX
         qWs+Aoqau0lMFCFxJMeF3DZSfjFodHNzoZxeOtOzYTAJpe0lHAoXgF3/BimgDQPd01hE
         +br1nw5lt8NkV6kBjnLpbe7ayRT1m5FJv5vjBLgjidBh58WYXq7PQTEbTNfepGxNGXq/
         uaoTuYtOe7Wm6LmZeVlsm4RHL8nTXDw6cRSaFGGDEGoXeS1fdnkR0sBqJ1LFjEG1C6ZS
         1dTudj6mEhFCbVp7Lr8Poed+U97E4SMc+awYBjlLqglQv456u35lXD9bFkEuFA2jUyP0
         GRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806442; x=1754411242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBPGm5h/2s2YI6WQk+GinbBOPswke5n0aLNO4q5tQ8U=;
        b=IogLl3OD5fs7UL1AKFXiPpQYpRsWMRvFI2VlYALlPUC9YnFdZ+nuxrLImVFwxXyWIo
         GBUYO/28lqozjXJShueS/EsCIXEKjTI8Ze/rp9C+mK+LlqpML/a96ZTik9zNafPoMBBN
         ExirvdtRW+xbJQTEs9zNjfhIWAaGSTEe4H+6OrmnqKJox38FxWK1I9rgxHaCNhwlc2Gt
         /csHRAodZDt4OKr8SHy7JJpdGcAiayqI6Eo5iK4onOajbvLptaVsJ1TUflvyqgjLI5mR
         rZaQ7j2IcUblozZY54puIc7Ok5L5MUQtkqOt01+tadjDtG3LaNFAHDbgfv2upOpKhRJt
         wDIg==
X-Forwarded-Encrypted: i=1; AJvYcCVrtH8lKtCx7Ln+3dx9VctAWSET3/z+lcUe5CxB9OcdRJ7tdyPIuFCfgu5ojAGP095VzG2NcKLzYOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXfMx3aHo9uAEWA24+HGeEKQebIgFvauFkiX+qOHARFSauQ65
	PQghhcN0Idrb1KiI88cJCyFHezXxaNn205XYqmsyhDqvrRZVOxcKRD4ANR2IZcAE1JVycHMLYkb
	MSckE
X-Gm-Gg: ASbGncv5dI2P7D6ZWubg3j7XYaMkIkD+Bhf5halzildW4r+jYpsxzl2qU+k9q0exPZP
	fn9G/cc98Mma8DFufEDVYnJRgaVO2CSVzKfRi+w4v6Ihnjxg9XDopMK8jfED+sMJxAcmaCcVanx
	MbjiQgvDzitSp6s5KglsRc4hwsi5DFQGwSZSKgBiZEOc5qc1LyL8JorlYgVIpppkn/44EIpGMsn
	z6cwCivU4ybSZO4vQB+myDjJoZZz6qr7Umtv17Z4Z46nvTP+MavXVZYbrnvhGfTk6BdhliXGt8E
	D0kj4UQkRXsNRYdc4z5nIVy9PBNeeCVtRM/LkXlsQAwCfPYoMPdPddckL2sw5UdAMtueqiTnkWe
	ZjzJaqF586WHiSmYq25HwNDiywrsUPYLAaoEivZloBYpUzPI5j6826CQcfzcUBxDcZ7XExGQZcs
	s=
X-Google-Smtp-Source: AGHT+IGlLMhKLgFHyvZ49DCZvMiA90TwWVIRz6iijC7YfuIMHUc0iUAcLMALFo80OHJGPrKXxcL7mg==
X-Received: by 2002:a05:6808:2018:b0:40c:7996:73e3 with SMTP id 5614622812f47-4319bc0965emr193324b6e.28.1753806442351;
        Tue, 29 Jul 2025 09:27:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54? ([2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-42c7ad75019sm1509734b6e.1.2025.07.29.09.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 09:27:20 -0700 (PDT)
Message-ID: <791e34a5-8670-48a2-9c26-782a7682f7cc@baylibre.com>
Date: Tue, 29 Jul 2025 11:27:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
To: Victor.Duicu@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 jic23@kernel.org, nuno.sa@analog.com, conor+dt@kernel.org, andy@kernel.org
Cc: Marius.Cristea@microchip.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20250613130207.8560-1-victor.duicu@microchip.com>
 <20250613130207.8560-2-victor.duicu@microchip.com>
 <d6c318bed4a2e61ffaac556ba1073e91c1307902.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d6c318bed4a2e61ffaac556ba1073e91c1307902.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 8:01 AM, Victor.Duicu@microchip.com wrote:
> Hi everyone,
> 
> I am writing this message to ask your opinions regarding the placement
> of temperature range property from the MCP998X/XD family in the
> devicetree.
> 
> The reason why I am bringing back this topic is due to a limitation of
> the chips. When the moving average filter is enabled, the old readings
> are kept and new readings are added to the average. This is a problem
> when changing the range of temperatures. The raw temperature values
> change based on the range so the mixed values will give erroneous
> results during averaging.
> 
> One possible workaround for this behavior is to set the temperature
> range before runtime, to not allow the user to change it.

It looks like it is just a an average of the last 8 samples at most.
So if there isn't a way to reset the chip memory that holds those 8
samples, we could just read 8 samples and throw away the values before
giving data to userspace any time we start sampling.

Even without changing the temperature range, we would still have old
values and possibly the same issue of stale data possibly influencing
the measurements any time we stop sampling and start again. So I'm not
seeing that this temperature range setting should be a special case.
It still sounds like something better suited to be set at runtime.

> 
> Initially, in the first patch, I have placed the property
> microchip,extended-temp-range in the devicetree.
> At that point I mistakenly did not include Conor, Krzysztof and Rob in
> the discussion and I would like to ask for comments.
> 

