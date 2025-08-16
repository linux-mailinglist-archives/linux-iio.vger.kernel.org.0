Return-Path: <linux-iio+bounces-22849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113F7B28FA7
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BB717491F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05802FDC33;
	Sat, 16 Aug 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EI+c/A57"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658A211460
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363389; cv=none; b=a8jr1FzrdpW0lyDrtGHBTe4UdDgHEH48M6+d+tAWDhTUHUA+vpyHViZBPs+4FlaAjhnh0GjYwfOt7dzq60Q8YEQu8mq64VAibxuaGELSbr86uwkEvTSlIe7wDMwEh0ouJKVO9cpbYmX6xY+1sxdXxfrNLShYeF8pfT/DL3bh7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363389; c=relaxed/simple;
	bh=woclP5+jEBRau2wQUGhcWNrJqopsedVvlkWQeccJ4uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XOqpRP2jPD9+q/zGmjIo8/vEF34p6GvpBGU87rFVrWR0ihCkMn4vU7Qie43tEZc9WyIIcEdVFkMBIo6JZX3pfcj3mfthoYsWmH+CU2e9CVfzPnHeRBjiFOInEVQ+dNSJ7xEpQ+0XkAvl/iHPoqnhcArh+DIjtZg+FR3S8TfaRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EI+c/A57; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-435de81b368so1349142b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755363386; x=1755968186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbRjZf6ZRf2jst0Yfan9jOOyyn6yhDJByZN4z1KAmss=;
        b=EI+c/A57kEDHsOpVRpH+GTuod8FRe7y0k7USltKWAwuQloU6Bq/Ynd+kVNzCummFbX
         CYBIwNtj/Ff1tB66PTfpMnIqxcdr0VPLRDyaepAQp4OsvWNQ6S1HA1lR/iajHJ/5A1aE
         g1XNZjYL+q5ugZQuK239u/B4oAH8lkBTWTPj6HY380zv9+DrB/0CppN+MT5osJG6qs1K
         hej04tU2g8R6BB6Upm0VHw+G8P/C8r/9ANjJqTuW4w98kuycxGa+Brk//jUIxzU1aEp9
         zgh0rSSX0WkcreiLprzPcPHr/3F0RJ2RjoE2RWNW1g3tr0bPf8Eu/zvcwY73j2Y1aaej
         zZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755363386; x=1755968186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbRjZf6ZRf2jst0Yfan9jOOyyn6yhDJByZN4z1KAmss=;
        b=Tigj7+PiaGV7pghjt3OKONSK9uF+iY6d3lxM9E83K/WaxLv5+9pRGTdEjsydEBuHIX
         wKl6WfwlhhVgY2DPt9GeYAqsPRpg4N6N3Gy73X8m9OvQM/rZCQ2uRuZaHhCNKI1Yqf4G
         CJS9W2taOQ8hPD184LoLeUbVlwoNn7WUx0iykbeRJgiVyIHIac9cxXgDuyCV3IFjBd36
         5jD1eM+F5gnfY0SnsDaSKPFkloodxmC/jyhpqwo7o6gFnHK465YJg1nYTP6J01ruwaOW
         ewncIgxsdXpcDAevP1ounxgSd6k5NuQ1PaMZTH40D6RVrQUbUnpq2V6SE4OTsgkip8mY
         Mt/w==
X-Forwarded-Encrypted: i=1; AJvYcCVhj7JhlhxeWZphmEJQNcR+glkpJMOHKz29yCJQrIFHkzNWBvvaeYd+DsENtjDylKtmg2NrHtBfx9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87mQpAFRX9DE3v7N/wRlPEH6rORBGz5BcbHtU4mskiuRiyByN
	5xx/tmOiEj3rCuidyr9H71k5rukeVBI4oc7mRPFmW7r7w10uDNfneIcTO85MStmu254/iS2sFgV
	4PhUz
X-Gm-Gg: ASbGncuZDMQU7Vj9mcQ+clOndK5LitD5he+xUd1ny4Zwqnj6bcf6vJip297iO7cwEeq
	aFlzbJRE7EhNB3gkhd7h7oCISOf+kSVdKvN9ZKmQIO90yTrC/u5AAHo+lWu0w1jiksYOoPmYpKc
	MyX5f0MqtzhWUI4jyX7cHNISJxd138zMSDnunZGSBYTXNYLbUIxaDUyND+XedjvZJqi8m7JAvhx
	n/3xz3zfBLPZMtTTxLTKZs7Sw7cPAuGhZ0WzkxypE2PbfdriNIJYaGLEZrRbY/YLn5G+BqwNxLl
	3rOYl/aZ1uqvqabFAW+E+Z6U+4OVY1XRDD6ntUnPn2xr5QxispQZiutD3xyt62u5Qu1xkh0CIXP
	Z421jnk2uXFi81D7dvz+oiH1FXdEW8/MVM8yY4fyvXb0as4uR1OvfumTGPlGw+Zia4rC8XRXc
X-Google-Smtp-Source: AGHT+IE+uLxK9MUTBgNY5LCQoebQIqITz8zvrHvCJ8AkNytTsjr9Sa0XKikZwV3Jg9G284HPN76+vA==
X-Received: by 2002:a05:6808:50d8:b0:435:f353:a648 with SMTP id 5614622812f47-435f353acb8mr1895881b6e.2.1755363386222;
        Sat, 16 Aug 2025 09:56:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203bd13sm932593a34.24.2025.08.16.09.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 09:56:25 -0700 (PDT)
Message-ID: <f089d2fe-562f-46bf-aef2-f19302d3196e@baylibre.com>
Date: Sat, 16 Aug 2025 11:56:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: imu: use min() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250816120510.355835-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250816120510.355835-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/25 7:05 AM, Qianfeng Rong wrote:
> Use min() to reduce code in inv_icm42600_buffer_update_fifo_period()
> and inv_icm42600_buffer_update_watermark(), and improve readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


