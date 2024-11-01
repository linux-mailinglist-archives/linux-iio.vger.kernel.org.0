Return-Path: <linux-iio+bounces-11812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32309B9847
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF26B20C46
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E37737B;
	Fri,  1 Nov 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J+YA+Pix"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C31CEE83
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488652; cv=none; b=SkPkIYgRgLKIdBap5xm2TbDd91PrtrZ+tSAXi9yQJtxJXhpfQndxxlcThPb5P1wC36LBapXgrtcdQRPlLqfkqWMSPBMWP7ic6k5Bj3ly4iPgwL+khIn5wzA/TOYIi3Gcn1XdHpaOB1nnPhIo+Vi8Ipjvf3Pge85JGtfILXRC48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488652; c=relaxed/simple;
	bh=o2R50UDnjLNhxbKIccKFZcW7BfLpfitiT8jylsK5MRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TBBVJdFLrHweUJPJUX0JgEfUBonuiq2cOVHdiXwmhZuzAt1sCns+5kf0UXbtsrdEISZ/KIJlrjGhe96wrElXwwwo9F54yd2fpYTGjForIdJ1CrrrooKUnM/Jgod29BQJI/iQlmpt827tMjMbmCO4eeyKtbOnajcAxpZ8Puq58Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J+YA+Pix; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2884e6ed0daso1008144fac.0
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730488649; x=1731093449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lG1xyYIDy+NadFUDAMAXUBdzTNgBK3y9dmr85eKtBik=;
        b=J+YA+PixiJ9XBNrMACQBl3fmIA8ZgzXtH37q4xi6UEiUJqKHws3CSZS6MSRjBYwD1B
         opvu8rasfJ/B3cjo8COXgMpjOaaqMivY3NzhZXcwuP1A9MHcrrDnVO8mvh/XPCCC8Q00
         pzteghD4rZc68J5xuduX0uXOZKvnMx4VmuIL8NSxjLpDXyhNFvo3yZ6VInT8vO2C+3JO
         S8Y2jFNJ2rBoCcQL1S2q7z5PfWso5KmMraONn1ihlGRYK7GYRXjj0P66uCDDEKpFrUGu
         MdFaIiEnHn+LS2W44qixkgmfqkeKX2EkP6Nj7bg3J9bpjYv/OZwWOkYiR7oopFbY3Y9a
         dLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488649; x=1731093449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG1xyYIDy+NadFUDAMAXUBdzTNgBK3y9dmr85eKtBik=;
        b=bmwrwS1/6SG2QP/ZhMGPwBcuIDIUPxn2JHhJfQC92THW6jnhkquCuqO/pa6hEtpRDt
         +I1Voln4ffNctXdBHS0cW+BcCK7SI2WUV2geTHkbouFaMczn79wd+b7OzkgsAnM3vTs6
         fkaVjQGPUTuAio064l9jVVWG2KieSqOKxOCWIU80JluePWvm07O9XD6r5GuLFqSyjUbO
         9hzH4CgozHROlUxVwLWesCvODd8R7NQt586op5n+YBM1jY+ik4o+4vj0qBN9oR//s/Hm
         lHn7FFkWUoOx3lc8wcGPXXqm+rVa1OgJZfijjedLAuX8S2hEkgczGlSbYwlirrw9nMqZ
         UaDg==
X-Forwarded-Encrypted: i=1; AJvYcCWdmgXBHQJcxt7x/m/l8QfPdUbwzpbqrrb4kxBHPy9w2HGzWRVrkNMX3GuITmkGDZhy4EqL1ikq2xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vsDfuGvJCo9fX2+9Px6BwDlHmaYJNj2vyfHWePwVNd2xnbqM
	+nNsReN19AfrosHofgi4a2TWO6of2mf8maQFHJwkzd4EM8JldiVlRLCYkopaNL8=
X-Google-Smtp-Source: AGHT+IEOa+2fm/lTuefUxKi2PihQWSdi/i5GWKsBYila35cTgKcc9EAR2Tsl4pAafZZmRryhmKIgYw==
X-Received: by 2002:a05:6870:390a:b0:270:7a7:eaa5 with SMTP id 586e51a60fabf-29051af0d75mr22829984fac.10.1730488649452;
        Fri, 01 Nov 2024 12:17:29 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189ccdc696sm842144a34.81.2024.11.01.12.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:17:28 -0700 (PDT)
Message-ID: <0944871a-88b1-401c-96f7-0b0f7164eb30@baylibre.com>
Date: Fri, 1 Nov 2024 14:17:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241101112358.22996-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 6:23 AM, Antoniu Miclaus wrote:
> Add backend support for obtaining the interface type used.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


