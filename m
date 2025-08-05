Return-Path: <linux-iio+bounces-22315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A4B1B88D
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53DF18A6CD8
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A6247287;
	Tue,  5 Aug 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="olh5lgbJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632391F9EC0
	for <linux-iio@vger.kernel.org>; Tue,  5 Aug 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411525; cv=none; b=CH79Z0Vgzdp6rfeetTGUAsdhdbOady0cxT6/NY6WQhZN/M0j/21nS48wuxlucGuznOZh3e9JFDJm3aidyekJe/ZV8wwY8Wc2diwnaTMSu0DhWmhC8s94/TpcPkuL4xiPcfO+v5goL1d4N7co2B/hswRvfW4bPsqAx2scw/TbwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411525; c=relaxed/simple;
	bh=BtAiTgvkkjlBfBvo6XtHgXIfvNar7zG5HMSPnNCDLis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUBMSNGlD6zWPJaUKM1XS+wu5TzuWoqFyMTNZ7BOQrF2ZGIBvlR71ehl39kei0tc+0SCbbkkzKJ8MaLQ9UKpn4EbtBVGwIYw9lk1q3wYU2vBREvTL86d4xlLn3MO8N4t99NUQmMMQakR6qkB6WxsCpGYbRonLUMiYi8qh8koWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=olh5lgbJ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-742f798bb20so942988a34.1
        for <linux-iio@vger.kernel.org>; Tue, 05 Aug 2025 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754411522; x=1755016322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uur0nAlqBULqZvR/jwBKMPpy4vyoMv3vayFy80V0+TM=;
        b=olh5lgbJz3G8eGxz3o1+JTfTxq8xc6A7F/ypesiL0QnKyk8KGlHZvIyF5mPt2BxtBb
         36b0C299hrljswibQaZ/8l244n7/XLt4uAA1OjHGrg08J3YWM7wanPwq0i//l2FxW1hU
         R+TYVrkjDCN65gny2zW76xDKuyTAI2+vDkxGFrCp8NDsAofGwECNnxofrCJLgBikzIAX
         oZFyorRgzmWBdzgtEEXF2RZiuV9ONMEh+mMltZObCgg5PqH8QJx7R98hGGOWKaJlcugb
         M4jHJOGCuvdjoBanNPDew715cUcntDzU6wkeTV1Gti0H3hPduRwo/PdQIuNSCul9I9cA
         PGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754411522; x=1755016322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uur0nAlqBULqZvR/jwBKMPpy4vyoMv3vayFy80V0+TM=;
        b=OrjwEi3w6Zx9G9euQ4Rjeg2sB6vHrYgpOFrYoMhfdoXhRCCvWUPml6yP0+rG6x4Jbq
         A+DE18b6JIbvvoe7/W8iGSLkbAWa1t0YoD1uLjRaKqe19wFDD5y/3VHU/7Qdw4xWgAEP
         L7rNPgGh9z5rnoAxmdHKzOyyPwz7MG1svS+bCgB1BMglVRn1gmhnGd0+EvopWhWkEmX5
         o8/9rR1q7h2+yVH451uqLBEa1vu5j1Ypdq0WtVSXrXiqCJdF2WhSpX2glEJfuh48VxLu
         Fz8sjx7xXttdY5p1BhoT5ZvThVO2tm8aZtYU2Od075QFGZpv0UJMSjgh3dV0UCd48kR9
         hL+A==
X-Forwarded-Encrypted: i=1; AJvYcCV+l62l6Xg6AzDD7nlLBOYDb1Y44EWIQYnpOhwDkRXLub1gkL9zE25d4B5/Gq70Zyjh2/Ldac2zfys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWW2dZmfi8rN9AV1Qz7NDo6Elf8cFhNzdFLQejPQNT15jforJA
	RWNzyTDHrSSmepjsAQ6pKOtXsv7bZr46zO5ZID3sgOmCVt1ym+0D6aGyzINfbJctOxI=
X-Gm-Gg: ASbGncth8IWJSAfrKa0RNUke+B//nSk8o4Ja9DuFvSn3mlrpZcjZgygX2bdE/wn8eCX
	Yz3YXUIP8uoRGt7PoNy4cKeD2YeXymKWi4EuWjeWGYXZW2hIwmzKZkt7/rZ+Kvv7cm+Zi5LlSoA
	ifspGOQwCjO2YvPPxWxQeBkrVrjkundTm8alI+9FAbud9/k6FEaNvLD7h+cvTZgHNIyDxgWFBuA
	huTVYwSjv1kZACvmWbHuClhZjv3ixK9I6qDJAC0fXYZ7rt7xkkVya91vi6WkONcG2FvipVh9TZn
	BpdakawHfzoCoYDW4a8ngViUvpK582a0nEHAeQhugZfigSF180LLqhBVR2ArPt4ZfxkLKBD1ePM
	ZHwuAjW0+bWqXfqJvt0iR6CU871sVWffv8cvVtT8uM1Rd/IVw3yMcyBR/vV40gvQg8Lwqd9uHEy
	Q=
X-Google-Smtp-Source: AGHT+IEnvk2d31UKd+tMc+mbVq2Ah+wE3Sz5iHZ3ZBziMqKMBF0tm8r034C7Lrlr2Q0zurnS1hQADw==
X-Received: by 2002:a05:6830:280b:b0:741:21b8:b24d with SMTP id 46e09a7af769-7419d0e6299mr9460158a34.5.1754411522370;
        Tue, 05 Aug 2025 09:32:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a? ([2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74186a0f8c1sm2849781a34.0.2025.08.05.09.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:32:01 -0700 (PDT)
Message-ID: <b0764ff2-1361-457e-b240-2d08c0916a1f@baylibre.com>
Date: Tue, 5 Aug 2025 11:32:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>
 <20250802124333.67f64863@jic23-huawei> <aJAmgX0876tu5Ss0@dixit>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJAmgX0876tu5Ss0@dixit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/25 10:18 PM, Dixit Parmar wrote:
>>> +static const struct iio_buffer_setup_ops tlv493d_setup_ops = { NULL };
>>
>> No need specify that NULL. Due to some odd quirks of compiler specific
>> handling and C spec evolution (none of which apply to the kernel because
>> we carefully choose build options) that is actually less likely to do what
>> you want than = { };
>>
> Originally it was { } in V1. Got review comment that it must have NULL
> if no ops is being passed, so I added (May be I would have asked and
> understand their point). Nevertheless will remove NULL.

We don't need tlv493d_setup_ops at all. The NULL comes later where
tlv493d_setup_ops was used:

ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
			iio_pollfunc_store_time,
			tlv493d_trigger_handler,
			NULL);

