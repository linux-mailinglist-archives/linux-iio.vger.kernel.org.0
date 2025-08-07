Return-Path: <linux-iio+bounces-22371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23BB1D220
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2301AA0DEA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 05:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8E20E328;
	Thu,  7 Aug 2025 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/6uxm7y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1838B;
	Thu,  7 Aug 2025 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754545396; cv=none; b=kfbXH1PXG7BbxB7Gid0HQTIiK4BAl3a/Wnmy3wprM+rHNnxFuNNqgtD88UUL4kHLjPl7dmQ0EtbOhI3fs2qlIuvt9lFw3MohhUe7B1u8piKxlYjzzVIY1Glsa51DKx6C8j4dQV/vnrQFdJx/ip+jdKtggy6XawfHtQdHgZjO7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754545396; c=relaxed/simple;
	bh=UlIFwp6pyn/so+Jj30sRFDfVkWh4Vb7g8PwsE5WFBrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHuPU4xsvuOsS2MqU1GSVFsCQJBROdosE/6A9GHw0NRYsuh++n3wfr+c8ppQZ0xCwfzjkA3Nelt00SoVdBpeqzY+Eglb4gc923PAEaAVkZyTj3mwbnTLxkEHG5Ziz4au0TWEGGznZBGxB+HctXvJSEeMMzFVI+ylVXLphCxruO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/6uxm7y; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b81b58eb7so691464e87.2;
        Wed, 06 Aug 2025 22:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754545393; x=1755150193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4WSEa7M85WpUvj2Vgy/g0sOKXbPNGLq50lPzjlEYBA=;
        b=N/6uxm7yRsG5IvhX4OuACExTdqfTPPCncSyonKKy2Uu4HwBAkR0rNobSak2XQB5Lui
         QFE8CS5i2kMXK0IHeGHWvcHruRWT7IGwEbSI4GMt0C+pGqUiIi4B+t9roWonprSsut06
         tIRTzsNiw7NJndxofYB/OULkKtXBvyQFwlhsanEFSWCuiFmuUkg2Hd2YOntGsNWSnPT5
         MWL5L7hgs4zmDbpxE7117OF3FDe6n6GtqLDzY4JN/ujzoATMx2qY4j37FYcOLwTQgb1d
         zkW/nOqNy8EgZFHHP+nBWMxo+0p4R+h19ES1EcshVBIbmFmbLdrfGpjXyy8KtudipybW
         M2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754545393; x=1755150193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4WSEa7M85WpUvj2Vgy/g0sOKXbPNGLq50lPzjlEYBA=;
        b=I2vRghawKibvuGeBq9OUlASRPuwEJ7vcH++Q9PjTpBUlpsKxBQVyoHcbWuP/UrS6hb
         LwMuHo/P2PTSyBP1BAluriFUbFof6AojMKz9eBvikc4D1Xm2ppW0oFFCB/b/sAfLZN/P
         r5f7mFiv4Q85Ver8qI1sG29JHqjHgkP56PS8Sri0WsThWRYezp4kX12w8nKyneyTvvO6
         oFn0ahVDBj4qzkOSMQgYsnYtyy5wb3Tk7bBxWhao0GdICY0cRi4LciiJOTQASHrIu8nj
         B5TXIySJtHtTRXU5z88lwSpsE8ub2rR77hmnj8Hr/eYqPSFr2BeTyiLAkkNySlbn8329
         EiUA==
X-Forwarded-Encrypted: i=1; AJvYcCVIhU3TJsOjHhb2prGOfmbWA71drneRLqWMLW8+x8/eUwbKm9Vg8cae2YatuoXuJiFEhV2IU6R5PuhL@vger.kernel.org, AJvYcCWDNW4lfllw9sYV3HWl7/BSNNfzzpzug2KqePtkiGTniAsixRvEsBeUK5rV9e72gmWQ91kF0wiwdNtwgC8L@vger.kernel.org, AJvYcCWFhk9r71d25Lgi1vt4spGpPPMbPVTlUcIVX3/z600fx0fmEC1u8llEQh00+GViJQz5ptDjhpelaIVP@vger.kernel.org
X-Gm-Message-State: AOJu0YzErzTRS+Ms4rkoIIMgIEPwohvJRlxYi1Pz2Mj8ihWxd1plkIwU
	mGgCRNQZqt1wInd1nsz2qpBZG21QeH/8n3Iyk1DE7SJgVJrDnudfUkBa
X-Gm-Gg: ASbGncuE7bnNg19LQKI76tCzOKSsgSsGilHdNw5YWqIRvDLYmYh3CePed0aX+rqWghv
	VbRmSZ/wHPI0jg7/d/nQKDD2fq4J/+svLUZVBDqXCsg/HGc22EUkr55/QihQlrVNfSBz0k/xBvw
	2oXG2B5Tn3OIb5nHmmum2G5lw7s4x/Btmyw7Zy407AKf8ZUIIi5M3ThWMppq5nyJdEPs49jX9dP
	5f1+8XZhDJKGSuYFARpc/ULEe58C0r+/fQqoBoXTTACHPNWIqWdice0mR9zUUsQRR2iQUggjc1H
	pRLn2WaMqPh7Mf75AsLm/TtwGdBM7FnmD4e8WGqBFMqw1d2H71oAgf2Dj5/gop5fuI3TmMqYx++
	PQgjgB3Lnre23v9kRVBtGqPbpE+02sfWWY0lTCzs7zr9gdxDPSHg88hB/N6u8Xwk263pqA9VUwc
	bFFiM=
X-Google-Smtp-Source: AGHT+IF0owi3MR50yxkg4JikrsrhccAVHX4cPJPPzPX4uWb9DO4sE3rx4e1V2hydlzLk5+cp2MYSdQ==
X-Received: by 2002:a05:6512:e93:b0:55b:910e:dc10 with SMTP id 2adb3069b0e04-55caf5f3ce4mr1927106e87.36.1754545392750;
        Wed, 06 Aug 2025 22:43:12 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3327sm2492061e87.127.2025.08.06.22.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 22:43:12 -0700 (PDT)
Message-ID: <305bd41d-8281-4207-9ff2-5b749a105056@gmail.com>
Date: Thu, 7 Aug 2025 08:43:10 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iio: adc: ad7476: Simplify scale handling
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <645ac6fb917e12db6cdc0fc343487531f61c176a.1754463393.git.mazziesaccount@gmail.com>
 <aJO5NRESqxFfxi3s@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aJO5NRESqxFfxi3s@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 23:21, Andy Shevchenko wrote:
> On Wed, Aug 06, 2025 at 10:03:07AM +0300, Matti Vaittinen wrote:
>> The ad7476 driver supports variants with different amount of supply
>> regulators. On some variants there is only VCC, which is used as a
>> reference voltage. Others have separate VREF regulator, and some rely on
>> internal VREF. Some have both internal VREF and option to connect
>> external one.
>>
>> The ad7476 driver reads the regulator voltage only when the user asks to
>> get the scale. This means the driver needs to do some dancing while
>> picking the correct reference regulator (or internal reference), and
>> store it for the later use.
> 
>> According to the discussion:
>> https://lore.kernel.org/linux-iio/20250331122247.05c6b09d@jic23-huawei/
> 
> This may be made a Link tag
> 
> According to the discussion [1] ...
> ...
> Link: $URL #1

Thanks for the clear example. Will do.

Yours,
	-- Matti

