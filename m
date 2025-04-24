Return-Path: <linux-iio+bounces-18600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B97A9AF92
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7783C1B62941
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38318C91F;
	Thu, 24 Apr 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RzxPb0XM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDF4315A
	for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502222; cv=none; b=ABSceyLOF9lnggDxfVsBfScK26sN2wMs24pltlY4j20E2bJKhkIl5KkjLeqPrmrLD1G15JYKLJrdzacVgSnwQ7Qw/XQpfiPBJSCptz4CJKyAVhfNfPPFkYL35JG5Pl3bjGo0g2yG15lRZj2QpT8zmJ5Ztig3rLthVvSqvhiy+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502222; c=relaxed/simple;
	bh=b5Ti4BCgUElx5Q7TsHyzuLCU8awSnXi4SG9jOsa4diM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZQCzfjeXpaZYEUwI5oahv2B4eWI7F+rDaUKDiDkqxCSiPK9hAI30PAgiSTxFQ0H/+y6lboO1Jc93NA5lUG1fUsP0uNZE26U3HyTFRFBk/3h/92ZS+c0vTi/KMZv5yCnmolbiJeLaB0otsNARKCtt+KF17P4QyZdenIKJQox+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RzxPb0XM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c13802133so273227a34.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2025 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745502219; x=1746107019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySZRnYP9tmklFRTY4e/KiEeWxMervJlsgBohTm5W2qI=;
        b=RzxPb0XMZcfjR2M6WbxumQPie9o8536ZrFA/+OS1PqAwRU+7P7T/ge5W63gCMQaQRQ
         B/SXGm1ozA1FQs1QmCKFRnBv2eqoCn3yAxfM8bb6HatwoedAOrtgfZ97uu0ZDc8d/ryD
         cLbWQDIfgaaBgeTcOtWOSxd82T0k6tv+Kddoq0jtBWuL8bXxMP1LJ2M0n+MScrgr5f3C
         Mt6WO7rPAokuhnrzqysCWbXMxOiJecQsRfCwnJuVdf69Pis5dMv9gRgszKR2koPUI7Jk
         MRUPsqD6QqHHuqj7THpkObXGcc4bkk8GEviQnckzv2NpNpw3YfBPn6OOecF3yWsjMfJV
         SH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502219; x=1746107019;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySZRnYP9tmklFRTY4e/KiEeWxMervJlsgBohTm5W2qI=;
        b=SG47Ks8bs/fXJnwVJHkINFC7jFklHqTvj+hiSii2i+Mc97DJEXQT6+9c6LYMY6Qt2S
         bAoJtqYGpSab/8Y2qqg2LJh5r15QERZnKyMec5kde3B0byX02pfqlimdwi3QNSTOu2Ln
         /Th0co3TX3kqjP3tS4icNVPAXIXDyOV0UzlKoNumINa1MRwkORYoKdaIlmWZ+/ID7QMz
         FSLKfu8TChX0Y8ACocHFtJHXR/cEmj+6k6k5n24EGhTQcEZiqYRzK+QUlM7OUCS+eGOj
         uwpQyTscklIahCEJFx+u9CEzUrwPCCQeJVQxieRrn6HTb4BBcijVtbCSnLDk4Y/1C/U1
         XOrA==
X-Forwarded-Encrypted: i=1; AJvYcCWP2BTGBSfUbRwux1Q1w124evimGOhUk9am8hUDcvnHAwpwfMKfuGB35lBTk1XOLyHzeyP/lwrk76Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpV1uypSoQFqiquYkxUq/S6gHzjy+IyaCp4EHH4sVF/AUsxTy
	39WNi3RbcYx8tcBIXMXnCykVNK97Z9xon8eXlHCztSFzV1q5t1v8RyZhuuQBHs0=
X-Gm-Gg: ASbGncscJgz7XA8rCBNPbvxDg0D4+0jl2+V9ks/+f+CfeCEBBGef6735uDgyhpoxGZh
	yiie4FzhqDwEXhC7cBabdIBfZDfxbwrruNlbts26EfJR9lTxZPRd7PHPapnV96FxiA7nkYe7rAc
	MM82XVe7G4FkiN4jV3CBC4zA25BovscZEyDctu0OJdeyjx/lUrt63mmiuRoU//D/7opwV907fEu
	2IOouwWvIgTP3aUEVghRrCekhCdqHgaE1WafceQgCbVhr0sIqcyVSqHzPXMOiudRp9glpfiKFQR
	HWGzwCg2pOyzpq3M4hML2jojNDHTR1VYIq6ZV5zoXGyLiyGLJTJVk6c5BOEXOHo7CLq/+ZGtT4Y
	pADummui2KLsZ8crX8g==
X-Google-Smtp-Source: AGHT+IHdImH/qJ9ieJ6L6o0QojQPrcgl+jDOiFGkRIR3z+FL0j4ZR7iI6e7AEhDyvUGSay24UAM1Rg==
X-Received: by 2002:a05:6830:4389:b0:72b:8297:e988 with SMTP id 46e09a7af769-7304dbd15cfmr2075735a34.25.1745502218845;
        Thu, 24 Apr 2025 06:43:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:68de:6c1f:6d0d:b32d? ([2600:8803:e7e4:1d00:68de:6c1f:6d0d:b32d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f37e123sm235519a34.47.2025.04.24.06.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 06:43:38 -0700 (PDT)
Message-ID: <3a6d1f46-2f6c-47af-ab6d-10afb22c440e@baylibre.com>
Date: Thu, 24 Apr 2025 08:43:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: PAC1934: fix typo in documentation link
To: Marius Cristea <marius.cristea@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matteo Martelli <matteomartelli3@gmail.com>
References: <20250424-pac1934-doc_link-v1-1-9832445cb270@microchip.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250424-pac1934-doc_link-v1-1-9832445cb270@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 3:06 AM, Marius Cristea wrote:
> Fix a typo,(PAC1934 -> PAC193X), into the link from an application note
> related to the ACPI device definition.
> 
> Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
> Reported-by: Matteo Martelli <matteomartelli3@gmail.com>
> Closes: https://patch.msgid.link/172794015844.2520.11909797050797595912@njaxe.localdomain
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


