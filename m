Return-Path: <linux-iio+bounces-21701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DEB066F6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41354566296
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4B272E43;
	Tue, 15 Jul 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMP2qZQX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3991F0E24;
	Tue, 15 Jul 2025 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608093; cv=none; b=uHTr1rYEZeau/xXkcnroutMxvqxZ2D9CwDQXW6Fz4S4UqP7LBa+3DFIXAeKDYTaU9TatuWdw1q8wAX14Ve27Wch3FYvONT6VxjW5u7ag92CEzgIsSdcH3FOc5/QgBET3m9s7HKQuV7eLrqktEmztP+zS2f8pJ6Pk4p7UZi+sg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608093; c=relaxed/simple;
	bh=jjkROt0LH1Z/hYRmG9v4up0cgNfT1dWPuop6yQH5JIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXua8x3SFCavGR/uoT2cM/40Yj5AAg/ofN/l8vjdpA6gOM4qTinb+PSTUcGMgE3BZQ5pLf4SjcWbnPX/oJlB3r6PBFeJKMhupnHwvZpI73+IZTKE2bvuh4ezAaSYJ745t3zY+CaS9foGRyUnsED7BsQGkMcXxUDLMxviv+bgIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMP2qZQX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167afeso53937965ad.3;
        Tue, 15 Jul 2025 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752608090; x=1753212890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A4GGI2suqlkYlgn45OMdLM5bAPgqoR6k6kWUI2m6guU=;
        b=JMP2qZQXKfIWIdmE9QcS53BRqVcyjtax7eRawiX7aoqMngX6rnz0VI+ojO6IJnwsMP
         2o0XrQTaxzKTl7Eql3RR4olVQaI/4u8hCx+qvn3p6vYFL0WxaHRwGSH6Alui6uRdHTH6
         1DobVcSDNvpMoTXZrEAwN6yV5h9Dw1hK2UabzG+4sz2rnkR84Ow/NnVRQEmEkHkOtbLw
         L3vmu4ZkZBoluadBsGocvQj4LTVj5TLKNZ6ArWf1+vM5ETmdG4S0PFV7tBaK69WKdQR4
         iv4TmWVzstRUf8OwdT/pNB3cYeNEqRe/4C5V8uwa0ngzqpC3Pv/VwTEeWnQ0/ErN8XTr
         fqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752608090; x=1753212890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4GGI2suqlkYlgn45OMdLM5bAPgqoR6k6kWUI2m6guU=;
        b=F/oOP6ts5uai6zL0Lmhmgaf6NYcETMBQZVwwvTsxcywn1whIie9F8jvZj6mCUBKznQ
         C+yM/mr9/rkcuzVmJGorsoSSqRuV7kkLWksOgX5SRWs3M7PdiSOR2TBJjZWs/Mik04dK
         ZR5chzpo0L6pExyXlKXY4bMMzPt3oIGhmTlApWD4Oej2XQV4plIq+Getwta2S1mhFJac
         2wgNV/RtgXoth3RfwJ32S9zXEcVVIREO2V/+U2E9OV7ebk4oespfdAWtZmHw/+ar1Jua
         0ExdVhAlp4rl28Y4XRuWLyqG758rm8VXYLLw+jmsz3/OsV3d5Hp/kwHZwM+tpXOUKQHC
         kRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvOvBlIXLq3dVUlTfxSSFB4cgkqnakMdTyIk0lKv6TpSNohzty9QyNirHpKRspCfmYdYj7lMl6gS6o@vger.kernel.org, AJvYcCVwkShHxPEsRsxIeVAEjH8kIa+tI4yz2hDcWntOiUIwAFsTCjOpVC4Rj2VLXB89vZW6/Kxm5JhC3GKjc2nF@vger.kernel.org, AJvYcCXmSGNpnGwVr9s7PgMX8WOWjRqoUNiXBDfWwnREHpejtiMs5mRZwp/STWgvGeVNh1u7RuqJ3wikqeN68Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnW7nrQd12CKuGh5eM7Hs+yODOkT65ytSOi2rMAJHvrNCzlQ0o
	NhGrvfEgJfSDNToEG/ZxkZiGHFCV4AdtfSb0oIFpo9gaBNpz26Y1gJak
X-Gm-Gg: ASbGncuxuDc6j2zY9Y3wsyjKX8PFwbaqHrRnup6kxRcumUNB2qMpJ+spMYG5FJRSWLV
	JnTFOBra05bbVUj/FiLAUtoGhJwb/v0pqnlsScHJiGvDnaZz8pxlxs/+pLHI17zI5bWbKd38Cbh
	ioZepiwSpGC6HsqXo5jumiVf09QXqS6F1a9Pd5JD0LsGQ8jQlVs6V1a/7fCUfXWXoRh9e0Ykisq
	RSDlLzwAp5LZTsxZU0BRZ1hY85NbO6xyePfEll8+YRBYuadZgzCxebC5VuH7l5Mm57WUhJlPMbb
	Uvjt3Rc1aYQbX6pbO5IcBMMShN334nuyRBxhyoM2ZzpqDGblnD5TIv0fI5riCpgcnojj/2aOvZ2
	lmFBZn/JzVtcecMev/z32s/kP4OvqXB4DRMV/NbkXM9OXZR6LDMl9T6EO/7oYEh7Ej6y3ifs=
X-Google-Smtp-Source: AGHT+IFQgy8FH/TsQQrcf9yV4IIdz2x5elDJboAhmwvBVkgq7eCJD2+uuKIjM/YEoUW+Ao4xfikV/g==
X-Received: by 2002:a17:902:e78b:b0:235:f3df:bc1f with SMTP id d9443c01a7336-23e24fa62bcmr2656375ad.36.1752608090267;
        Tue, 15 Jul 2025 12:34:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43637f2sm115198105ad.241.2025.07.15.12.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 12:34:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <759e8070-de3e-41fd-8e81-05e22c32209e@roeck-us.net>
Date: Tue, 15 Jul 2025 12:34:48 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
To: Sean Anderson <sean.anderson@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250715012023.2050178-8-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 18:20, Sean Anderson wrote:
> Add alarm support based on IIO threshold events. The alarm is cleared on
> read, but will be set again if the condition is still present. This is
> detected by disabling and re-enabling the event. The same trick is done
> when creating the attribute to detect already-triggered events.
> 
> The alarms are updated by an event listener. To keep the notifier call
> chain short, we create one listener per iio device, shared across all
> hwmon devices.
> 
> To avoid dynamic creation of alarms, alarms for all possible events are
> allocated at creation. Lookup is done by a linear scan, as I expect
> events to occur rarely. If performance becomes an issue, a binary search
> could be done instead (or some kind of hash lookup).
> 

I am very concerned about this. The context suggests that the iio events
are just that - events without specific association to hardware or system
limits. Hardware monitoring limits are system specific limits, which are not
supposed to change at runtime. A high voltage or temperature warning is
just that - it is not supposed to trigger a change in the event limit.
If anything, it is supposed to trigger some action to bring the observed
value back to normal.

For this series to move forward, there needs to be some guarantee that
the limits are used and usable only as intended, and can not be used for
random thresholds. The idea of "if a temperature alarm is triggered, do
something and change the threshold temperature" is not an acceptable use
for hardware monitoring alarms.

Guenter


