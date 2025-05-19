Return-Path: <linux-iio+bounces-19697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7FABC26B
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30B83AF9F5
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FD2857D8;
	Mon, 19 May 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g2ZCtaCj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50243147
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668505; cv=none; b=A+7F7ddcEbwEt53+YK9Y3NwNXGY0YP7+zfZb7+KPfLvBZQg+JdsFjNgCCnH5mwXeA+CLrvNmXrZBSGsA33WNcChUi3Bf8IFJstWysrqQqwauYaf3etXGQwAGFhjjsKQ0QXTOUoW5w5CJk2/eL8EcpMp2kneWwpnw8J8o9vUwtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668505; c=relaxed/simple;
	bh=KHxgPGkHJc47h2T7vaf1QrsDbAkmsHgS+s5O8Uan+Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjmCa6Jc2Gq96hx6NkodD/gy9T1tHMCR/y9gOG+5mTiy2XpzW2VrcOfx4IahiB+9Ak8BaAytjSm9NP7k3SA3uktji27mLyPX+VHnKsF8pmJtrBsdou9XxZKI3coOKNdw6pC97L+VLBK+SBr1r10z/+ePv+epOFAaAXhSwIEGAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g2ZCtaCj; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3fcfc85f1f5so1320337b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747668502; x=1748273302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gunr5yrkLk/n2a5iSHnU+A4FlqS7JkXXxLbIjVojZgc=;
        b=g2ZCtaCjO82Af217o/dnZNkg8yDVj5g5HY/zI+6tqqzWKJDmuJ82bhYv5cFDQ0vvOn
         1OvMW/r68fFmwYhpUugfXNoDVqBIXEWKR64HoWSKb7XkNPyLW2Vy3MafTNodej5t6/S6
         yzKSFKM6ZoobR86Tqv9wMdSSUZQCauA2wp2iuaGynlAdsMTgyDGAtb7D90AcKvl5qxeS
         aFnlfRxMinlC349E4TsN4XcnrcDCyfJ5s6qIMCWeV8DZ6QBQJhnPHQMmaUGygpSAFgyi
         QXU3GXNPtNAk7u9g4jDzl+VyW9ktcziV+MJKK1cL5ruhOpjYDZ+RtFHwkMZBcnG1oVvS
         ZSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747668502; x=1748273302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gunr5yrkLk/n2a5iSHnU+A4FlqS7JkXXxLbIjVojZgc=;
        b=oeTjW+MsHcUJZRhBXVBOFePKzvzqFOQmjbOSlH1x6q1wpZw4ZWmlLKHvc8bSqovIuM
         vKugX93Qb2lDJQYRihqM6YvQSIegJEcZkeLTNDCG70TZ859tFbtb1UUkU2LQ2feG5f4Q
         ZqX1q4LbDpNx6aZtK2EXPNndU2ZNVwzuigEQBWro6nR1b3O1DCDRw6hTEZ7NOr7wifVq
         ZvxuSxaODcARusllYBw0Xem7LFZ5BKhYL7cLq7my1e3SVPWO5r/Uvt5X9aHuqJKemoqJ
         2/L+M0eGLlEPHy0akNn+60wTxmmbSwviRfu7ClCjDj5HACm2QqkjkFHuh1wLNpv01BUg
         zW0Q==
X-Gm-Message-State: AOJu0YzdyuJGrOYhveEx735GRFveWKU8ZnNBDJ0S1cocXICmp6DkGn5y
	31kewvBjh3fkwIk4hR+Y+r7P8xR+mYd6FR7GlvBeHYZ4js2ZOxNEH3aDuISpfrLu6pQ=
X-Gm-Gg: ASbGncuVp1NzjbYFrq5bjvDZmxX2xVK5o54f+16LPSAtCNjPZvU1IkViwbGJxVEcup0
	H7QZhk5HNqBnnsXH9q0dny1TIu8QpqsQEMQUaXJD3fxTqpjmJNL9F7kcyPw95hg2M3AGUUIiAWf
	qszQD4zQDWxpqPHeyGlf3M0q4TcQ8uPzx2s4ZI5Vm2UH/NqXbV05O8wj/DaZHEMtHERpRGU+wa2
	w5saY9TtVOc+lmZwXYnhcvrsgmtmzugzUeGrc0bMby2NnHSyq+7DEgP8P8+O7+ymRS7Er7AhRQf
	l7W7Jyc9eKKNGS9NpaM/5oFs1Pejt23uwcxj2b32M2/fJFjARCqreCKvA9Y2e1d+x0CUWIS6hUX
	x1d7weioBnf7VpKEooFs2JZWhqQ==
X-Google-Smtp-Source: AGHT+IENnuG/YXszL2204Pk9pF5KDxPDHR3fkgrZVRSzJWcNVc/KUH1Sh44zKC9K6d9mhWQi2kpzSg==
X-Received: by 2002:a05:6808:164a:b0:3f7:8f77:2a97 with SMTP id 5614622812f47-404da82c7a9mr7623243b6e.34.1747668502340;
        Mon, 19 May 2025 08:28:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404dc2d4954sm1265375b6e.48.2025.05.19.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:28:21 -0700 (PDT)
Message-ID: <f06d231d-297f-4c83-b457-b9eb242b9c93@baylibre.com>
Date: Mon, 19 May 2025 10:28:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/9] iio: Introduce new timestamp grabbing APIs
To: Gyeyoung Baek <gye976@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/25 9:25 AM, Gyeyoung Baek wrote:
> Support automatic timestamp grabbing by passing `true` to the `timestamp_enabled` parameter of `iio_triggered_buffer_setup_new()`.
> So consumer drivers don't need to set `iio_pollfunc_store_time()` as either the tophalf or bottomhalf manually.
> 
> For this, triggers must indicate whether they will call `poll()`, `poll_nested()`, or both before
> calling `iio_trigger_register()`. This is necessary because the consumer's handler does not know
> in advance which trigger will be attached.
> 
> Once `iio_trigger_attach_poll_func()` is called, a timestamp is grabbed in either the
> tophalf or bottomhalf based on the trigger's type (POLL or POLL_NESTED). If the trigger
> supports both (e.g., at91-sama5d2-adc.c), it is treated as POLL_NESTED since the consumer's
> tophalf is not invoked in poll_nested(), but the bottomhalf always is.
> 
> If the attached trigger supports timestamp grabbing itself, the consumer does not need to handle it.
> Instead, the consumer's `poll_func` pointer is passed to the trigger, which can then store the
> timestamp directly into consumer. Trigger drivers can pass timestamp values to consumers in a consistent
> interface using the new API `iio_trigger_store_time()`.

This is explaining what it does and how it works, but we really want to
know first _why_ we need this and why it is better that what we already
have or what sort of problem this is fixing that the current situation
can't handle.


