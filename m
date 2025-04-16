Return-Path: <linux-iio+bounces-18179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C1A90C39
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E583B7A5517
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701B224AEE;
	Wed, 16 Apr 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nhYGLM6g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F121576A
	for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831466; cv=none; b=qRYurTomusOAeEoPmEmgyZCVM8q18T6PsefR+tw4AQCtvOai5+MT37/O48EsXSNH3M9AnEYhK74+kp2SEP1H8aPXLWLY2lvaNzSyaKkNO05tPLVzXhxVrE/T9d9we1ieYF188q8ACmGYd2raWm+NjgeE1oh5Eg7tjyRgsbZjowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831466; c=relaxed/simple;
	bh=L1QpL+dJg+mvC89uNW9F0Wau2KS/B5UiT7wTtGlO8ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjKw0JNHj8I5YLZrw6WYiFTXUzHzlKPCNydikYffnPRVUF0kUiQl8USPcpjaw5ygyK6fMg73PPax5WPui5xQHRKkfDf6ol8C9Am5dM9irYWmwGU5xdxzJrYB2OLSWjHm+GeNCeuQsh1Nl3ekBIdLDAAhtu0h8rNIkH9M87wxl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nhYGLM6g; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fe83c8cbdbso2187058b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744831463; x=1745436263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVWtjKl7iqOi18r6l4CQzpfIdcd44V0fOP6BaJjZNMU=;
        b=nhYGLM6gcJcCl+oQB7bN27zSlNCtr/ulhx77MXw+Cfl5JQuZr5qX+gprtsDvobHw1y
         KHbxm7Lt0zl0fVl6/iZ4WC5PmqZBKZmDCwKNR2SGsLqyJ37SqcqPFxwLx7+UlhvdFMhZ
         nRBF3f8SHdTnYtM0IGAjx8+qghmJ5LdJuOzKj9tZXs31rm4/WLE/RR3Lkejd0QdGBBu9
         vGw52Q4evc/RCUtq+7Fa3qvXSO1S7ajeEmLRWJwNAfjno8IHA4WvsMzwRxKaEtutSy2E
         C8pkWQssm0VoGUj5VntrM8QLtR788neZASlnYzwgQsB2YYzNaoL0lLriJd0dTzxP6/q4
         7jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744831463; x=1745436263;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVWtjKl7iqOi18r6l4CQzpfIdcd44V0fOP6BaJjZNMU=;
        b=ldLCDLXg6x0CAvRNHTGAPni5FDg7Byc1y3QHThx1/484wqypxraGe7ubd2SWViOdbP
         HWVFV8dtNUUPh9yIWlvHY58fgPB2z2YHZqQ+rfSx4XggO0f/aVzE9oWvVBNb5PxNp/7m
         ALvYYj7kTbmIUkKJFxYy+cpqnhNVMvy3lKMJnvtlACBpAiiuijiWJxV3PQmBYkIfr/+K
         TRq4YNe86CKqoMSFkCUC56pRHwabGPB0kmsRABz3ztRlojF++8N+Epc8jShut4KcbXL+
         GQGkf/RtNhyA09i7KH7uuLVTnX910JQnOnB1H27K+F9NQdFjVgMELaZMvXOEvY49apdj
         Ge5w==
X-Gm-Message-State: AOJu0YytmqF5H7ueGpoW28l9BD+Xw0ezk4WKoD80iS07FkidxqT3YmfU
	ZtByQN3Q2eVqhEpKbswnZwdefsqOYlwVGN7jDcLpxe/3FynzTyBCqhO8aIiIM1M=
X-Gm-Gg: ASbGncu/SWN6FG0ZeeYeAG3+x3WsfbnV7oSFpmiziDLNlmA9qF+2L430CwHY6IdrafU
	qrpMtg7U8BJJlC/LTKTJakhsMXeoVkoNTxq9A2CdcE9qnYQw9C+SgijP+st46ibHOAGx+5E7QAN
	crxcviqAWaLQ1Un4SWskdd03rHlROh1J7iTE70EzHYkmKblSvpwpprBXzhMU6Q71dezK4nsyYIF
	gin/1OVTy7ooA3v/JZGVEa2nY6uNb3M3tAxWQ7C+cdSfb9s+rJZbEy+gY23S+QErCVsC6BelXCB
	hYmzmH22wRKva82XdoaHhS9SJib3YtfHzTQP9Wn9ou+rEyFoRBDa8Z/i+t52IMEyf1JCqvtejkk
	nFJ8GSifnfHbyyAdWy5tk6tMPIVYh
X-Google-Smtp-Source: AGHT+IF0mpnDIyAnn6ZeAXKJmpAUqrHnVA/Xnwlkcpkjjq8eHzK67t5vDdKrA4mdat/Ij0oR7736Lw==
X-Received: by 2002:a05:6808:3094:b0:3f6:7cd2:8187 with SMTP id 5614622812f47-400b01e17e9mr2050247b6e.20.1744831463701;
        Wed, 16 Apr 2025 12:24:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3? ([2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-400763bab7bsm2809388b6e.45.2025.04.16.12.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 12:24:23 -0700 (PDT)
Message-ID: <dbc60881-39e9-45a6-b535-1672c5f8cb6b@baylibre.com>
Date: Wed, 16 Apr 2025 14:24:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Add driver for AD3530R and AD3531R DACs
To: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/12/25 12:57 AM, Kim Seer Paller wrote:
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/°C internal reference, which is disabled
> by default.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
I made a few comments on the driver, but still good enough for:

Reviewed-by: David Lechner <dlechner@baylibre.com>

