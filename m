Return-Path: <linux-iio+bounces-17684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BCA7CF0E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5330216F3FA
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AED1474A9;
	Sun,  6 Apr 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B7oUJ8wk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3FA29
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743958962; cv=none; b=TDdrwLMlGN+l37XkTY1X8zIhJLNt1aHToCqw8WwDcmYVUN1yO2vZNHq4mPMYAdVB7SYwMv4gQtKmD7GJXKWtXskZsYhzfqKJHbEL+BfmsRcLw0lNbbjYVUwkJ/V7W1+ZGMhMlwIoxQasz22Z7sk8Ecnv+Tud+y9plKULvHowg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743958962; c=relaxed/simple;
	bh=sVkkpLP7iZfpvlgUeGjvb9DimFUxKIpw3Id2bsFSlR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAIdHWDkaj3S94z7qe6Esce9EVQn9oVz0E/s6bqVePX4KZjusYc1/7Bmc6hZqchf8ixrclWAeiocu9EwJa7xAh9UAi6LouJ3WdKVbFS1PqFLnPLrOtV66EzY4gurnZF3LDE+/DToe/Q0utZKviiqq+8JpLgt51XyAcrpvp38NHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B7oUJ8wk; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c12b7af278so2647304fac.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Apr 2025 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743958959; x=1744563759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rw9Z5qtWBs4EXQgomj6GCqaEcI3IQFjUfANJX8Mm8lM=;
        b=B7oUJ8wkrh8tJqYbq/llM7fL3NwGlTkKnrEC0tjbPUnxeueZEjzUmqakQE8wF6Llzy
         3LHqmC8Qu2c9clL7mrV00D7SzQvNqt8mLFcuA0k/sWHwTn2Dz1AApyaaVI/s/W2hne+i
         vioUeQEgl23R+6Z7deAm0mu0DvvCdynb0n51dtN1jp4PfVkGkaG43CuaTFKYBXofdTQ/
         rD9IukBXaTyHuJpmihHKFNYmD8QeXxzxszPdf3tbdJEU0qH91OhEcwp1k7jsCJZsGT9A
         9qXYJGGlDolGTp4v7ZFqt1O5JWqq+PBUV/85tr/C1n81XoqOX/Q9k4/IsJ3NShjmFpOI
         xyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743958959; x=1744563759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw9Z5qtWBs4EXQgomj6GCqaEcI3IQFjUfANJX8Mm8lM=;
        b=Bp9n3O/LICDxnkJB4TIcUIsTI0pv4gKPif5FxxK+KiR4nvgGuj1/hSiwqMuJE2IXLF
         xq1rsJwzNP9YnHpqwePfI3DNUo3+3NZ6PsRB39Hh7UTVxdXeGH1vPj6OlJQzqlXXTdo2
         PkYCk6OaPGBEUUKejXd8XZHnxf14sz/vOoox8NYMRi4zenJh7xi3WfUlOGwVl+bqTRpV
         T7tQ3FsD5qXxH/DVusxTjh1rOrooAn1pZYkWhHeZC9rCUUqBJJj+B6JhSl4YFMQETraL
         AMSMS0cjUX9rNTb2aDdVOO3jeTR0qpBSly0oIWeozdUUzzrNW+OrhkPgt84Bsn9tIljk
         6Pzg==
X-Forwarded-Encrypted: i=1; AJvYcCXJLOfZ1ZXqYOeA0fqjqhARcmyapkAvq/SMca04ZLaf/wulsrkA/Qqbl43sFWaQ8fiWSqooE0ivT0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9NEgtkwTCZm7gwraKkzpxkTLJuG29Vfucmjwe+DYbDt4oEgs
	sGXEtojAfYDEnCH0MudA+r6pjdvQjM6Qlmd0fhWX2MWRXjdNq0mhqgrP0HqwzDk=
X-Gm-Gg: ASbGncvi9PBffNkDroEpjuJ9e9EFYv+yy6DV54r9cHY2sp1FXTRgXo50NAdkYuwMVEl
	xSLSorEscGlCE7LUM/nqfu/lcB7mq0mZervnEsHTns775XEedu3dAOLKvAdItVwDKLVDZ5tlZHc
	yjKorlT7Y71RvGP+daZpFM14UvIMx8s796MBGBoV96h+5PxDwfF5CyWPFlEThq0Y6cpMWGQzYK6
	q0BcKFN2l1hSQDF1F9rFUFsTI+nVHKmTbT7Ey+32RklQEUjxGyEopc72jEw0v+4W/neE0uh86hA
	dUCYwAPG7TiuV/mDGlLinW60PDSDdcXX3wnZqTk477C++xqfe4Ldn9DUNwNtWjCx20QFzwyG8gx
	oRq06kQ==
X-Google-Smtp-Source: AGHT+IGqhxoKWzaXcY2LPhg1usyAYv0//jZYOjiQ43dpVByFfgbP1Znkp78kS6pZ5ih8gDHAHodxEQ==
X-Received: by 2002:a05:6871:410d:b0:2b7:5726:c931 with SMTP id 586e51a60fabf-2cc9eec07f7mr5616775fac.5.1743958958982;
        Sun, 06 Apr 2025 10:02:38 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc8454c669sm1642631fac.3.2025.04.06.10.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 10:02:37 -0700 (PDT)
Message-ID: <2367372e-e620-4a43-8385-61e7f9257264@baylibre.com>
Date: Sun, 6 Apr 2025 12:02:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: IIO: Update reviewers for the subsystem
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250406153120.2129133-1-jic23@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250406153120.2129133-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/6/25 10:31 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Lars-Peter has not been active in IIO reviewing for some time. Without
> David, Nuno and Andy, along with many others who review IIO patches, I
> would not be able to keep up with the rate of change and would have
> become a bottleneck to development.
> 
> Hence update the MAINTAINERS entry to more accurately reflect reality.
> This is not intended to give the 3 of them any more work or to oblige
> them to review any particular series, so if there are any series waiting
> a long time continue to poke me via the list.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 559620786634..0762170e9740 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11518,7 +11518,9 @@ F:	drivers/iio/common/scmi_sensors/scmi_iio.c
>  
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
> -R:	Lars-Peter Clausen <lars@metafoo.de>
> +R:	David Lechner <dlechner@baylibre.com>
> +R:	Nuno Sá <nuno.sa@analog.com>
> +R:	Andy Shevchenko <andy@kernel.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Acked-by: David Lechner <dlechner@baylibre.com>


