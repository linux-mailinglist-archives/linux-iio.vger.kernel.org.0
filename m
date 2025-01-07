Return-Path: <linux-iio+bounces-13984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A1A04671
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1BB7A0480
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD51F238F;
	Tue,  7 Jan 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pAPW0Kcr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A918EAD
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267544; cv=none; b=ONde8eLd+R99ATALZp2CWuNthQo6dtmjx9rrJbmaOy7R4mvBSFfgYKQFUvHiQNNhwdxhw4VlbrHH7nKvV+n3TltmvyGj1XXDaYSzlBW5uyBsWtnvfH1NgziITlrvfB8B1wUzAJlFmiRVyAza1mK2zix47hJEU56gsAaqqyauGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267544; c=relaxed/simple;
	bh=B8h5B6uiXSfm/CmnKUoX2bfv6Eqh2By61pfjmS0tS88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhlPE0L4XiVkd2sCfWKg7K4auiUGF7FrZ1kJaXpPCv/QzF6aAizo0Xg4FPa774ZVVIIYhusIZ510tbCbuV0v2M4lDHEDpU+6Aczu6joFJNMXyj/Zl5vi+W9ExINIwILlRhL3NoyOwKOLxkNviKNeGXMv34nxLSa0DuAoZ1bX8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pAPW0Kcr; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ebbe804913so4583119b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736267537; x=1736872337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVYGMi1V1WNdCbRk1oSm1KSPedD/rj3URiEsw8+DEaM=;
        b=pAPW0KcrJTLmxDqwL/+hoq0r4zgoXeAhpaSrTTzTlMs48JYxkRzTScuvVQ48BZZ8H4
         wOwjigaevQwkFS3SlkAne2Wjhr9IzZ3vnL33IEPVN7fsBItwU/ZFmaF4aI1ZTwqk/1R0
         G2xemyhMWBThlf8Gp6QHD7Qg96T06eqYGZOq9eM/wyPH7d2xocVDFG00WslRH1oUUIaE
         J6Jz5DMngAWTSOKMUaFZtEbuoW73u0hgbM4GpKeWYiCyBAJFO54xSHtfvITwPgd4pWbL
         3KKJA+h5fu2T3Jn45zWFiaTqMRM3ia0QBj4o1FErsq1AsmJIvQUpnzjKT0yZUu1cksvq
         hsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267537; x=1736872337;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVYGMi1V1WNdCbRk1oSm1KSPedD/rj3URiEsw8+DEaM=;
        b=ikrnufdxnRnV2JsJzJ5INaTdYIax+LzzGQoky6ZrhGpB6YjPqJuA/pxZU9SCTNBCm7
         8a3Ay/7sz/C6/yLPRo+dba8L9LHk8tqnGP06r9L6qEaKrWJO1VsO5szE+KnUAB42Z6W+
         +5EsDlWvM0Z1TX2bAPeDFBVvWFI7Jh4i9qR2VJk2TrnT2m8+vRuN+pIhHPsuWcYMi0IB
         raQ0yDlg3Wi1p2b59H6zAntj6LcIgPyjMYZ6lI+E30lp+dkxmAhGq35y4sFUomFIm6nD
         HQVI3L/K8QbHohtlvR8nSRmcNW4k0K71oBDni3zT67/6ahVqHb94LjWbOmS4mdr+ffWY
         MA8g==
X-Forwarded-Encrypted: i=1; AJvYcCX71KXmDpPhNXW8SteQztotuYItfn+4IDexev9pUO69b7KXkxjKSqklGcvJRzSKLMyBj5fNjEDzN30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfz/O6JQNJcR2flC3VCzogHDy2/Gk1U5GkTe4eonOmZw4TvaGD
	3hGfWKhrUfWMI/lHtrUYFbLvTqS1Cd48T5f0yv2TuUgDa2AIRGgrhLqAd5ltF7A=
X-Gm-Gg: ASbGncuQ2WyWly8VtFvivwaEZ/a0XWlu8z1nb9MBmzX3SdxDz6MCcbUrD0N+nrBFamz
	XRbh6X4DnrwR2ww7aj19c2yxaXSs4LBwXwYyORh4b81U9T/1z06VC8Ly/vwRR79vAfqEoQCGWe3
	fbme3h6+gctvUvYbUjafRQvy9eGCuBQ2vixtCS6lWp2InljYBmVSHMQeU/kPho/Vxj0M85QFLEQ
	FDl8HRA7o67tntzyHRmzVgk+8t3MHhFoSGOw1gTZcCqitmdRTKWulcSz69cKEi77qixaaD9xx1b
	K48PPL9ns3aK38SL0w==
X-Google-Smtp-Source: AGHT+IHT+ALfZCpYtpg3FQKNA968pQqz+Bgcl5LXng5N6dImB9B44Oa2xILUYAPV8DpoM3ngu9L5Tg==
X-Received: by 2002:a05:6808:124b:b0:3eb:5362:8f68 with SMTP id 5614622812f47-3ed890df2a6mr28523971b6e.38.1736267537595;
        Tue, 07 Jan 2025 08:32:17 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece2693cb1sm10600640b6e.41.2025.01.07.08.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 08:32:16 -0800 (PST)
Message-ID: <8db7c0f5-449c-44ab-b92e-590dc697baf0@baylibre.com>
Date: Tue, 7 Jan 2025 10:32:14 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Re-add filter_type/filter_mode
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: cosmin.tanislav@analog.com, jic23@kernel.org, lars@metafoo.de,
 granquet@baylibre.com, u.kleine-koenig@baylibre.com,
 marcelo.schmitt1@gmail.com
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <cover.1736261047.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:11 AM, Marcelo Schmitt wrote:
> Better document sysfs ABI for ADC digital filter configuration.
> 
> Change log v1 -> v2
> - Split into 3 patches.
> - Re-added sysfs-bus-iio-adc-ad4130 to keep filter_mode separate from filter_type.

If ad7779 is the only driver with filter_type{,available} attributes while
ad4130 and admv8818 both have filter_mode{,available} attributes, shouldn't we
be deprecating filter_type and promoting filter_mode?

(Looks like I might have got that backwards in my previous reply. :-/)


