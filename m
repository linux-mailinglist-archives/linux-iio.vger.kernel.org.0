Return-Path: <linux-iio+bounces-13988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89143A04778
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CBF3A61E8
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D061F2C3F;
	Tue,  7 Jan 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ETJXkqOw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E561946B8
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269323; cv=none; b=THMI5rz+derKx6UNfWXCK9TWdHF/wZFm6KgxRWZUsVwmSM5Ghl6WRFzcUFdpwLPTAoZb079zsDWdKc9n3rs0A+kLNpb5itKoBqa//xjdgnzFOm9eVk3NYY0HmY/vAyaRvkRZlIh6xO0DOtwrFtl+tAY3tA5mr3t2kODY9YibjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269323; c=relaxed/simple;
	bh=SIh6qOKcdkudvuD1pgk+dzHncIoptzQ0cHWK0cu3YoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFImSf5VVijqX8GG0i4gonVVAEKXda/H5qmp+fdv0pzkxwXQQr2IRkY5Y1Mla8QDowX67nQvjOgoIAgILw3n+qPKdgp8esczKrLWw32IUyEEN27WBCHMT1U2B484QuD4IhZU5/MEgnpn4cxPTn89lzcQcNGBIP6Clg6QJYZHcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ETJXkqOw; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71ded02b779so8464279a34.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736269318; x=1736874118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2Xw5YGwLuLuQ5alI8ci2vm3J9f/nfoY4U9UPEK6bog=;
        b=ETJXkqOwRul5H/sNWwy4a3rQ12kR2UZXA51vX5/dqNuV6zMO+gbaG2c40WQr2LI5X0
         a3ITrTh7rz+BN6BK5BcTXtQSZGdiCKc27NrUQ8vJaXK/K7Yun8UITDl+uoPCg4SOxb0y
         CqqmzfayZi8MCa6PuavcYf/DW4Z9PZ44v/ChE6Mbj+few6bNE0rSNSqL+Wf0vR3SWOFN
         LXChLdDiYhrY8NaUZCMkNwPav/3EdC+URbBoBn2yLeI/H8KDwEOkwbRiOhSmqBuTrYJg
         CZ4jyrWLxG3RjQ7KtxSIVAfxmXBJFJhQJmdPMRDLzTgSwO7QfBwg8XiZVefoLb+nHIUz
         g3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269318; x=1736874118;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2Xw5YGwLuLuQ5alI8ci2vm3J9f/nfoY4U9UPEK6bog=;
        b=kjk1eWk0Rd1yiuijGiM79JVaQkVnWDD8U9/ukicKj2vgXSzCtEKtXBw3/kgnRvBGWP
         L3ygwpP1nicsX381Ak4hAQ7CG3x7zpphvK/R0MKf41Bu5wRx8wDqwYqWeQ6qgJyP/L6v
         uRyyxxMMgK+WEo9ptwWDkn8diHPJ5WknVtsHVO2cKA2i682nVTjFM2kddktfqDZGHoky
         +GPUgYRMhi8EGBMTDOQOeo1/5NuwnT5gA7dOylFZZVAvrwFS+3N7aoSmdAgw66HvUT94
         6o9BSxMqdr5qd3vzC8+IIfxgeqCOBdtT7DVp1E62U1Xm4gBkgdS50OuVUkEXGGwx+YsE
         JCcw==
X-Gm-Message-State: AOJu0YyW+h1RoFY1SllHAvPCoDyowE8gNZiFanh+HhE5M1phHOq8p0jd
	0o0VNZeoZO49LmKoXf85U4RlWF2KDS2WCymJa/T3bGA256mQ/zWpo/9eHYymQpk=
X-Gm-Gg: ASbGncuhDPCmOkm98UT2BqWmcvg85nFrKr+mhwp+skZlC0FUlMepBI6/wkzQxqZDmsf
	T6+K3/Auy0blxryWph6CZnYZcA9tefTfPjIS4zQouY14+YXHSr9J8znH6VjCr2djYu+QT2uwEYc
	/3wwG7d9j2DpXC0jI/ChgOkvzrOT6M62apXylTWrS3fzejSFiBiHQ5dpOwbecBF8OknfeZeSBoY
	yFAsi5Dx1i6b+OGgCIkmXpFUKWoVbJfObtD+3hpLpHrGkdq5FBapqYBaJAite8jRbh0lfORmvrh
	RPuxX1libNPMVbWb4g==
X-Google-Smtp-Source: AGHT+IFeif2Crw099fkoAT98xtAlA9RKnYOPliiLdjtMjx4XxPuCMEcDCL5u4GaHbz9K19tu7OmgEA==
X-Received: by 2002:a05:6830:6a8d:b0:71e:ae7:3530 with SMTP id 46e09a7af769-720ff869e90mr35880696a34.17.1736269316925;
        Tue, 07 Jan 2025 09:01:56 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc9764193sm10305027a34.13.2025.01.07.09.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:01:55 -0800 (PST)
Message-ID: <4273761d-0cdb-4ca6-b905-748854e35558@baylibre.com>
Date: Tue, 7 Jan 2025 11:01:54 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iio: adc: ad7380: do not store osr in private data
 structure
To: Julien Stephan <jstephan@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
 <20250107-ad7380-add-alert-support-v3-3-bce10afd656b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250107-ad7380-add-alert-support-v3-3-bce10afd656b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 2:48 AM, Julien Stephan wrote:
> Since regmap cache is now enabled, we don't need to store the
> oversampling ratio in the private data structure.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


