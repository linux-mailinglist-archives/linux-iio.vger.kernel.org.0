Return-Path: <linux-iio+bounces-24232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A88DB8208D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 23:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9BC2A4503
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFFD2FB989;
	Wed, 17 Sep 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iVGcRgZi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61429BDBC
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145964; cv=none; b=md6FjybXaxMUPuyI3NXUJuzRIt4tcppJRsfISeyTv/5EG/W3ozwuPo6+2cpjEnWfnW8/vOGeTMXsvG/aPC7OumMKlxzeMPTzwrc91+PlMzMd39dIh9lc86p36Dov5729AuS/1Ln+MW/wgeDqXExcmYsycwFdysJC/eQ+Ln6UCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145964; c=relaxed/simple;
	bh=rvVZfCvej11Tmgxa4T26G3D03EHWhz9RpA85nl5oAjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIoiupNq++ucRg9CLyDMbCQhBUavg00+0ovIYpV/fd5Hhdpf6aGQ5Z8qKN0O3XHi5IjJ58WSmkwKPH26sm7/eD1f9A8fM3dsee1SPlfLv8UZMZoepyuyQc8HkXdIKmoD0vsp06bpas8kGFVGSHAR1TLxpkoQpYScBuCvSh+qE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iVGcRgZi; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3318dd36a8fso292297fac.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758145962; x=1758750762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvVZfCvej11Tmgxa4T26G3D03EHWhz9RpA85nl5oAjY=;
        b=iVGcRgZiC9KJmxJVTWmP7xlqgSoHXIsr/KBZXWfjQEwL6eeysbwnoh5XQa1aYTY1NL
         p/bxKZ9ghkJp5mcf+FQ2zYYXN5g+DVc6tSf1YjOqgoOnOcGT1ZK930W8pGPTye1a+xVb
         qtmu9DVsiwcQfW5XkuAD14nBld8v/rcu7xAEkG2YllP2aaRTvXKgObweqFxj/LZfsUlr
         +uYtXK6jXBxHr3l54OHTqXg7ptSg8MrNbJUVFfzONiKI+lTD5w/csjUFOX2bt5sl+6j5
         nL5WVnFMecxDGcjrlpUZO2F6Y3h4sUNOfeOYlX6pS1Ap6UNiF53kHK5OxBx5wRDF0jSS
         1N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145962; x=1758750762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvVZfCvej11Tmgxa4T26G3D03EHWhz9RpA85nl5oAjY=;
        b=RfhSN8Fcl4nO/PuiipjFv8l9o43eOSxwHGUdUAgq2gmLAJMRaNbwrXj+uIPdK2JjOJ
         O86nqYPmlu+OfcZzV1oOJeQKeHgPj4p1jeujQ+ii7e6vQQrquSkS5PE8DFws999moHO+
         JlygjeSf/XmtAQckIovsA1W4yAb4B6ZiK3TTSzr+LXsdu0GHmqz5utwXjrWl559HiTXv
         18hIqF5cqpImVuHqi2NWFWKWQeM/+svRKOS8svzrrQD9dBtoN8z4UDbvbAcTdyql3ri4
         mERgMKMsluYGydAxbmVZhNgUaI6PHL1JKcgWTi4rkeyzW7npBWghIaOmAH1/f7Q2TQ2P
         3N0g==
X-Gm-Message-State: AOJu0YyRd3as7Qp4WPZw0PnAWJbhbiOR3JJfdI/YZI9sS+dc7chePU1a
	sP6j2aloBspXm/wO4gejKfOTs7rDkvWoC3uLUW7BJDw4TMq/F0zEbYQ7VZpk/d+X2No=
X-Gm-Gg: ASbGnctZGVLzsz11cJKO5QzIfII+StlNMu2daOtN2HvpQcivuMozFPbcMCb+/tifx+i
	S2mkDjGJoPmoy+YJBMEDjnPgdzvYGgZ+G3Nx502wS0tkHDdzzuJuPqTtINpn/MpLNLFyildE+XR
	d3THD0Njqj2D1TgjxLrTGQMfenITIb+8fkHy0uIz34Btz5rxy9WYfplJKVvOf7Fp45gMZN8tYsH
	gW1QduFdLOXf4w1XloC/sMy7y/hr1r30aI2Py2PwPWH0b+Qdytr8/7m0Vadh0buEYnrK/33Z25v
	bAxq1KSr3G5kFQBXOf9gidM/u1GNx36rEhbDCvQzDGqiPLQU3rKMmKKOsAsLMgtv/c4IipEeKc3
	g0CSHGJ/o4LWjbW9IGKj7lMtBQAM58EN/JiGfp/oO0rUPd9Nni2oYrS8CLvsXi4kQRYSvbng2FX
	qP+uy2kO7x/9WFw4A2JHBOraLSmICD
X-Google-Smtp-Source: AGHT+IF2yVk0baAEhZr/uPROvHUV5o8LKakO1HuMtz/G3fJKK6lhiBktyZtF+fMw6juaLsKSB2XHpg==
X-Received: by 2002:a05:6870:d0c9:b0:331:6f29:7e05 with SMTP id 586e51a60fabf-335baee23ecmr2015389fac.0.1758145962216;
        Wed, 17 Sep 2025 14:52:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2b4fbsm336812fac.21.2025.09.17.14.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 14:52:41 -0700 (PDT)
Message-ID: <1f8bace0-081d-4197-89f5-cb5aeee04752@baylibre.com>
Date: Wed, 17 Sep 2025 16:52:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: iio: adc: ad7124: remove __ad7124_set_channel()
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

For some reason I put drivers: in the subject, which should not be there.


