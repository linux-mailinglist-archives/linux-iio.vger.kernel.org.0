Return-Path: <linux-iio+bounces-13993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8CA048A7
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 18:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AED188780B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18C18D65F;
	Tue,  7 Jan 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lZ+qKcEg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612A18B494
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272431; cv=none; b=hy5uG8ZphLoHialRQ4bCTJMoRBjMKszkdSwSNJV8+7EsFSS3PjEu4WURugJ++OryrAYVL9/rE/e8TFrWm6StZ+iZnae2Nd6bdyXAjCHUp3HgdqkBNqDe/4wF69ZZPpd6FUDiFoS+vk6drvA75KG83I7kaTd6W/0tys/Lnl3ZLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272431; c=relaxed/simple;
	bh=u8nsA61EEEaA+VjazlacQE02Cdojo7AxBySM3vO83uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMznpHeferzfAzi+zDK7qRj8n6W6KuweaU+VJn2+MPb/EfunLm/6H+qfxL0997ryhwBd19CSx197Jpr6nfNhIUMRx+W36+iqgQYySbJD5OmUZMFBTixs1NZnb25JvRICz1u07tbO68nvAqt/bAoU5gPSAVnZfdeWilNw1vLMaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lZ+qKcEg; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a383315d96so8302217fac.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736272427; x=1736877227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1vcM6LSLehum7WvU7nPNuSYD9DiBJIRpD/D402kjpQ=;
        b=lZ+qKcEgGJhQ2L0O8NWWMD4S8EPrX+LQp0hBtw6fesKmj8lUQZkc0T6eU7/2S0RqIC
         42R1r/Yl+wkHNXuo1qQsFc2Mg+U4+W+Cx6FxjpNaq4QTDHHyLGxjRTCCbzhlOfIJedtk
         /Cc+UzdoEhP5sA0maIV/p/POjMbDy1jNd6WqUfw3U3anGhHlhmKmyyy5oHuXNpDhnatq
         kVcmSRheNS7T+zyANp/hIVtrF+kKmXS8JYp7ynZ7qLwytpWBrOckLMkJG5c32DBHHMFb
         Cuk1XrYWEdkuOzE3rdE0xBy5opXnwNjDFXC5n9iv+Dx6g9+yTRztjSZSBUdGNkBACpAu
         rThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736272427; x=1736877227;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1vcM6LSLehum7WvU7nPNuSYD9DiBJIRpD/D402kjpQ=;
        b=bs89NHK673ry8AtcJkK6BT0gzevQiQd9Q9p1fLPMuMn/rTjIihkUCkfJMEMvhAJgSy
         lGjPMyK074yfRw4/S64xjAG0xGSbylPy6tNofhdvbheITvrTN4z6bwm0OYn7ZtOlMoFq
         P4o4Vkwsj+P2kZqJQn46OrQIehz3yOTaCti+w8Kcq4NB+UpeiJfNkyT9LqeNBV4CQKAz
         buFbpg2JynIo3FY3xLLP3DNnfrfIbJ4SXEQIex9XcIuljonGiVG+svHD4s4IIYZ4RUtJ
         waosiX/x+G/Wup2fV2vgsSqQIkXUbNC4qgkzXOsfAJsIzR0fO/xremEcoO2O4NLlsWKw
         fSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfS521ABduKx6ow82l7ID11w9g0w3bA4dPjn16/3Pb2woYjKM4a9ieAm9xlvVHxby0rtrXJMogdNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ62AMB1KNDM0DEfj3nQgbDgjdsYT1FCYcySL5AauqdrHA/a+e
	UYeltUtkFzMYWiHJCecF2gyL7CJvR9uqRTcLEF+liudDkjy8jLUsmnjINUv7fPA=
X-Gm-Gg: ASbGnctHLVY1Iy+NCcKRGMN/aIuEpEHHPuLmv+6ROARlc8BJmNObMoecVT3mVwbS7Kp
	mK+LecKbipD/DGvIX3ADIZ0JkqcGXQsaaEwxaytZlV3TEB6ok3CvAvYf258OEd7uhONozE1dxHJ
	Cn920PTsP4g91+MBf09r2a8dFlfRzLcLaJhp9x/6ONYadA2pITnR8brvioigmDNPweafNjVvRfC
	9uUl16JiErDyptTiy4vl0idTOGdr14KX/XDJsKrXCjQKGgq7J8V5Td28qB8YkQICf9O79A8HAxL
	BWAo22cxGUmduSLzjA==
X-Google-Smtp-Source: AGHT+IHCsyDybfsK+AGfxaFPK5zXBU/gtB1zzrxqheDXeKQ0buppHcs0++kYVhsa/WNwDa35ZdcIgA==
X-Received: by 2002:a05:6871:2313:b0:2a3:8280:c23e with SMTP id 586e51a60fabf-2a7fb557d1cmr32089891fac.39.1736272427504;
        Tue, 07 Jan 2025 09:53:47 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74540f7sm12344505fac.11.2025.01.07.09.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:53:46 -0800 (PST)
Message-ID: <1684bc1a-c983-4baf-8b4d-0c6ff0f1640a@baylibre.com>
Date: Tue, 7 Jan 2025 11:53:44 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Documentation: ABI: IIO: Drop AD4130 specific
 filter_type_available options
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: cosmin.tanislav@analog.com, jic23@kernel.org, lars@metafoo.de,
 granquet@baylibre.com, u.kleine-koenig@baylibre.com,
 marcelo.schmitt1@gmail.com
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
 <5b86acb56fd2aa337223a6467c1caf2a06682fcd.1736261048.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <5b86acb56fd2aa337223a6467c1caf2a06682fcd.1736261048.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:13 AM, Marcelo Schmitt wrote:
> The only driver exporting filter_type_available attribute is ad7779 and it
> only supports sinc3 and sinc5 filters. Remove options that are not
> presented through filter_type_available attribute.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Maybe this is not worth it (or desirable?) since the options may come back in
> the future if new drivers happen to need them.

I would be tempted to add filter_type{,_available} attributes to the ad4130
driver that mirrors the existing filter_mode{,_available} attributes. We can't
remove filter_mode since that would break things, but having filter_type in
addition to that would mean than userspace tools could standardize on
filter_type and not have to make a special exception for the different naming
on ad4130.

Then we wouldn't need to delete the extra items here and we wouldn't have to
repeat the docs for sysfs-bus-iio-adc-ad4130. Those docs can just have the
deprecation paragraph and mention that it returns values identical to the
filter_type attributes for backwards compatibility.

