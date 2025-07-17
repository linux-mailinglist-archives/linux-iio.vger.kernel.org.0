Return-Path: <linux-iio+bounces-21759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1E6B09708
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 00:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2CE3B92CA
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207023C515;
	Thu, 17 Jul 2025 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xrG5ChQQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F32248B4
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792574; cv=none; b=qTr0yX8JHl/O8L573ctGOJKY9K2EO9jIH8p/pJ34s5oZiNsyNCCV3M9/k1ulH28mnThZnmOJcqI2C/Y1CVOnaeil0frmohfAcQGEMhgTJ5wE5RboKW8awEzNxNcAD0cyQWc2t3wO50Y6qg5U+IfBDKztIf5/3I/oWK1W2V7TCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792574; c=relaxed/simple;
	bh=XDLsgCqR5rMMhTJ2ZHC9T9KUKGgbxXXFWq028nihIsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ND5P9eJ80ZWYvfjCW/rd9AOTC1SUMmeO9Le5OtG+00C7LqnM5H174zjWb4ghLecROwzlXMQxPy2whDtKNCqHOO0n0o57gTcHBaRqhJlPWRtO34MR1fwR/nESIuY/MYsMttwm22oiACvqzjEewbK6YlKOdud87EUTvZ0O8hxDXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xrG5ChQQ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41eaf97416eso625624b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752792571; x=1753397371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKShhrgIbRW00JGya1WIC7YMrAAY4oSTlCo+yUKwCBQ=;
        b=xrG5ChQQhCuNQGsl5lJkodex51ilkIJrc7RpBPGDfYOB1FBLHMyN/oJRgAzp9lHLW4
         AYgwWdcMGhg3oyI5nIRCEuErJIzRMtHCRcqOz0T/WhNTuJDiT786i6otKc2Bk4lGrdMk
         PAwuG03I9Y/GHi+qNYvBz/3duQUNtF6nhKza0+ZWpmx/0TwqNqhT7YGuwduZ9smeSnYu
         hYKxByOiM7CQXXPTSzF3vv1Dd3UOFRRyuNh6m5Mlp4QqaW89WqCnvXkHj93zb8GYfr6O
         Z8gYxbvQSmhn2zIMIsD8eMEvtrvjC06wFIOwZ5YqdQTOnDLAz9+IsZXp2pCOrScwstBj
         hQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752792571; x=1753397371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKShhrgIbRW00JGya1WIC7YMrAAY4oSTlCo+yUKwCBQ=;
        b=iU+4rfWJb41zIx5EvWRjbdKFUiWdhN5PbdfDjOvggu34/jOFgoLIh/atbGYks4JB5p
         FXRfJ/Zqoyf0WKV3zmCz3CGBexTWiyr+J399OkRizFPGDYmmmpxsiiDIZY/5aUvMIqi9
         d2WYo4icW9BrePYV3/Pgnp/9IJUBE/QsqX87rsnyRxS1pvmUroviYIz0d5NYDScQN4xZ
         R5W9pIGBae7TcsVUGG86ztzEwLYqt0uhR1zT2anp8uD8TADRM+cKdXhHMhM0eO/tOnYt
         6ZO8Oq/Y21ag9IbyLWP/S5mA17vixm6BxT9vPbWTFd8He+DyozaMCV/Qji9CvizegCYV
         O18g==
X-Forwarded-Encrypted: i=1; AJvYcCW9IQC9PWaoC0bLDLWxlgsJ/ldHRgmTtQ2PU+MgqmgXtG4XDL03lw61vOY+xsAkiEEceQhuHVDajow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpYoncImv6twiPEn2rcy07/YuTqxKBLp/PW6g29/70wzWSx1x
	JTi1i6ylJ+scH2YKrerYUNhGFrN8hbOVbBM2J3NBO6FpXnQ18sK5LVH5WRrc32mtf5Q=
X-Gm-Gg: ASbGncvzZ+xSP83aGqyhpJINrW2Lggw3O1LxdkXB6Ka13Jqe506Qib41GvNBW5BCOq9
	wJh+YsLvpRXHLZi6IG1bBfYPvTp7DuoYX7ESCXCJDGra5Ti/fW+qEMatMfpdd8ocTwtq22DWMyx
	Hzj2xo6eSqHg1YYh3cRjpV3sKY6cyBZI+Hg9WTPPBBO00KrKd1CNjehNK8CxclG0k9dxPvu5BjR
	ADDnsEgwqJTykykl6EGygZ10pSBpPHmCI+mi3tOjxFIpNAiD3rvuWZIx+6y8b3X6NZuLfEDCyqy
	F6LM6nqWccchiqpGecJxLx+K4VOkpKyIVe/FBZcC7ksKpA5aDWTww/+F2CxbgX/PXp0nJupRfrQ
	e9JAeChV1yne3kgQA+DQJqUi6uS8sHONUGfCAR3CcnpfJLCehfKFdrLAKAUt6ReWMfhmqBrgt
X-Google-Smtp-Source: AGHT+IFn8VldGILt9QVnRC2e8VCRuk/cvLwVgRVrgNxGjoWGiWL+0N9XGLC53WFZJaK8sN6Pa3x2Mw==
X-Received: by 2002:a05:6808:4f22:b0:3f7:28ac:8068 with SMTP id 5614622812f47-41d034f2523mr6212172b6e.13.1752792570551;
        Thu, 17 Jul 2025 15:49:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b499:5ccf:3f5:ecec? ([2600:8803:e7e4:1d00:b499:5ccf:3f5:ecec])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd498c1d6sm8494b6e.28.2025.07.17.15.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 15:49:30 -0700 (PDT)
Message-ID: <772b61e4-eebf-46e5-b83c-76e947d33043@baylibre.com>
Date: Thu, 17 Jul 2025 17:49:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and
 avg sample before setting register
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 5:13 PM, Rodrigo Gobbi wrote:
> avg sample info is a bit field coded inside the following
> bits: 5,6,7 and 8 of a device status register.
> 
> channel num info the same, but over bits: 1, 2 and 3.
> 
> mask both values in order to avoid touching other register bits,
> since the first info (avg sample), came from dt.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


