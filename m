Return-Path: <linux-iio+bounces-22993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9346EB2C7E4
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E58188DF39
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983428315D;
	Tue, 19 Aug 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C3IY0kyg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC3283145
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615582; cv=none; b=TnvL97BuZ8YtALAS4s4VwWDenId2yDLRfpHTpntyKorRl+Stua2pemDhfK626laz3dRv9nyLpxGn1a49Srafx99KieLZnEbPuEclep3MsxBK4+EMxGBwktaJCf6qMGlfXBWSyWC2KjphOtPM8TvcgrYh6xifyeRNZD1fG8uWGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615582; c=relaxed/simple;
	bh=d7jxtf9e1EGzMjhH6BSfIgbgxdC/PzALkRfgWo5SNc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQo7ScCnZkkPcv+wvJOVkaeoG56jtpdba2VxEhn/z6feT97N1Ht1csWejUlP8oK9iK0OLovkNaKXMWrAtAg9NpAHY7xsep2nMxtlkxJZu0VXKYXZSrOXWqU8rBo2R4N3Lh9mTi//ps7pxmEOMorx34kQ+9Wd4XlYyiokV+v2CMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C3IY0kyg; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381e0a227so3725932a34.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615579; x=1756220379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvNKHCMq87Lhik1CO9XVRBMkudY59YNjicvk+oSCQdM=;
        b=C3IY0kygTmPiYitlHhEN/eWtOEuvEw2dV667ZYB+4inoO8P0uziij4mC7gPzth5RbR
         sr0nb2M+KqII5quCQrwCl/1kfXQDjTo66iO7AipjmrkJVLvWl+fij6q/kaCPmtEpLpM1
         u99E/6zpzckgLmd9mrrzfSVMhk2n6FeP2NmSj2c71laq9Qm7+S/34WccV7Gkr89KazKe
         Ga+ggS4vqX4iFIlPSWkzCW0s2ywUsBpWDhmiPeuOXtZYysDNK+VNQaJE3YJyYeHVWLHt
         GhqDm28HY9InCZQG9mvONIM/eXT31h4vkrkSDtpCTipzIclJm3BJ7AF6Xdcqbp3nzySL
         AU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615579; x=1756220379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvNKHCMq87Lhik1CO9XVRBMkudY59YNjicvk+oSCQdM=;
        b=cx1NtclWufS3VB9Y4KkgwDFqCEQG7mJ2yH1E72ttJSGa7RoVYDDf7/3C602N2A47Tz
         TJCY9eQwCLzA4cWj/uQnGK+wOKjhxuN9yshiz244sZAF0OGwXNa/plbHDD7UyUIPNCcp
         7UiuwynI0UT6W/AUxQpGJI2brwyp+KwS9hkdBvEQR4odikRIbfYitKMSK9qH1UndnlUN
         kptWPYYybOQcx1C63vDm3FN2pnn6EtyFdqFmHNea+aVxfhkQ+5lQtTsKTwTwBJUwJCfp
         31WYHnp0BXeoZjNQfbSwqKY40mNzlt+zCcnAHxYkkuWlV6rpDOeBYrEbgyFzmGPf++v5
         KFcg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJKzzt/UvufUfneBWswNS8qoF20FEKo4sf7/VER0MkWJT5ZOZ+CGgbTNSVmzF9SCjz0ber64SX+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/MXZpC/M8i2aynvgsLYf7gPYIhpzqs9i+cRzjOZ+2stoYRNA
	ctXbhssM8fmpArQ1gw07ToAxmQQm11t2zLIcEL/ddQt0Hq3BxumH/o/7hIoRp5sMyc8=
X-Gm-Gg: ASbGnctwO4dOpX25WuNKpJAJor22Yk495BL39QoWpxCrmHfAb7bo48no87C/u/SoFDM
	eIORjnGfKb/6RVpF/7yx+DWIn22XuKpohnYmQG1K9I2wRQXwFKdw/nv6DvEP2zZXzOkuJORxxbz
	7lF1W8HCRG0rqdrA3wVq1No3sD1Qe0hh1brwKULWZr9VktE0eOaCthKKu3tN6S+fkYX5xX9ep+H
	N4FbLYo5q8bNXKJeliZbKpEAv0FKl2MblKGDdGfyWicXleGZ2oTs+ucK+4GUhDHpwG48EY9OCEg
	JaDL9i7D41/TkF6zNW2NWGwrxRLR17USAroeGTn77GIX5cQY9OkS7Kuo/u+70zHPShDBcPW2Gdi
	QHxIkIPYIRn2IalB0rNq8sUangmv0Ih7Vjf1wbW8mLD6ABaN7viqelrJhwm+DQcgZVIQBuNlc8/
	i51oMZdk+DSw==
X-Google-Smtp-Source: AGHT+IFj6OqONCnGFZeBqqA3MXFu/6jtm4veak4tKzjTr5uZXlRCK7+1zKp+nlIvK4DTZHIlgmgPJw==
X-Received: by 2002:a05:6830:6683:b0:741:bac7:cb12 with SMTP id 46e09a7af769-744e0b06d11mr1936727a34.25.1755615579555;
        Tue, 19 Aug 2025 07:59:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-743919da438sm2422196a34.5.2025.08.19.07.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:59:39 -0700 (PDT)
Message-ID: <d8982536-a1ca-403c-9ddf-511bbfe7faa4@baylibre.com>
Date: Tue, 19 Aug 2025 09:59:38 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iio: mcp9600: Add support for thermocouple-type
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-6-bcollins@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818183214.380847-6-bcollins@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:32 PM, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> dt-bindings documentation for this driver claims to support
> thermocouple-type, but the driver does not actually make use of
> the property.
> 
> Implement usage of the property to configure the chip for the
> selected thermocouple-type.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

