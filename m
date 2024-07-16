Return-Path: <linux-iio+bounces-7631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA32932071
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 08:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B67E1F22260
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 06:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781251CAA2;
	Tue, 16 Jul 2024 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMUfw4Da"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96359182DB
	for <linux-iio@vger.kernel.org>; Tue, 16 Jul 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721111474; cv=none; b=LwsAsMaY7LS8wedftMfOuM7I5yKzoVlIpwOAPeCjdwyky1Tp9KWVByBFhfIkfpeQlzq7Sd/wVwb6TI/BBnUVetbZiwYhPxhPuacPIsb8becLgbbObF/i2nrCslqxjnSah/7kqJxV6YC178Dh1aLL4l7UNtSVDwvUQ2IGrZHn2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721111474; c=relaxed/simple;
	bh=8VezIcNuQFJ7Jvqgoi8kRV0zrSKKXW0iIxZzEbElfVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+j51aIkdKv6/FeyvT8LMtpYmVnveJEPLumYxInAhrv/Q0jc4D/Ix3dw6bO1S+zQjLdh1tQsP8zGEwCmZmD6NAiTSPV4U5OpkNiWuaMTsGI1nYEHFx0Nb+YzlTc5wJl2LPl3PXLE1W8M2uyr++/Tm9ZjDgzHYqRxtjA/jD1cHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KMUfw4Da; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so5670099a12.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721111471; x=1721716271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ib7WP4Tl50HBT9YQYeKlxRIrMlFPUpbOBY9W7STica4=;
        b=KMUfw4DadMGlZXtNyriHOX7vy4UFjX1c26XjidvFtb9D2k9TZ4xGMt+opxdQaR4GfO
         AJoShd0GpAPBbgUTN3TriiAmO12YEVsXcFGqQ2RpPhUlatNSJeu4XtRSntOv1RNp5WjX
         vnrTFy5R1sc7dfo52OWaxyTc96JPNMbGyiqBT+eRKV5uiMX9nsl5vEhTr/9J5GtMRgS7
         Qdr98aaFT8aAvwHkzUx1Gl/qzvD8zoO7eWQ5Ym52dD94w/cnIe72SQCVr07i5JmMZgpA
         KsXKKlr7G7oUEjOZSq58t6SSZrnCgd1wcHtt8yfawS+iTCvqmyDMWk1tKF0XY+H+BEQ+
         WDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721111471; x=1721716271;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ib7WP4Tl50HBT9YQYeKlxRIrMlFPUpbOBY9W7STica4=;
        b=kRrHwLITc1MSdNBFD1KtDDegjStslBH6Wa/KpwwMyjQVXczKwIi53lcJo6+eisgJPC
         4D7TMV+kS6xZUBv1Sx0cinchi6xK0ooa81bH9eXdNYO7X0T5/nkLD3QZ7q2TOQUxqB4W
         3V2BwbI6DYdEZAstGD73W3+r3GZeInLDiT9n1HNN0uw7iyY92blMtQdM3+EwB5+AWFmB
         i14/tB7OoHirShnMa6sBP6+z8z4/tSmk1FzcMYsx8RW/IrVNHyjRYVpQ7sj+zekEkXlS
         B49z/I6GRK1gzbYvlBosgkb6Uqecp45LU1z4Ui/By7MGCM/8roaV5W9ngov5Ckc+jCIY
         f5kA==
X-Forwarded-Encrypted: i=1; AJvYcCVA/jhxvXa8wfWLnPv7tcgwU33Gzv9zjj5zJZmAeseQmr12mZLATzdOos5WtLMEnye5D+57yejwAj6yqopinI3lkQtohLkIlWDf
X-Gm-Message-State: AOJu0Yw9MV2CqxalN4IYgkGQICAYuUZdJn1mtMhvdFZVkn0eCuuxPo/5
	eUzukKyZkU/O59kZ8k7NLtmjomYGd+txUnbC5XPP8ya0+DZd90vGMSFmc3e4nsg=
X-Google-Smtp-Source: AGHT+IHYHJo11tn9T9fAHB83wDVewhTAv6b8f703zQtbdOYeUqmBjOxrwbTLEwcJoYAJO+5Fvefdfg==
X-Received: by 2002:a05:6402:35cc:b0:58d:c542:2500 with SMTP id 4fb4d7f45d1cf-59eee64410emr705921a12.10.1721111470966;
        Mon, 15 Jul 2024 23:31:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76fc3sm4375774a12.9.2024.07.15.23.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 23:31:10 -0700 (PDT)
Message-ID: <04be66d2-de35-4190-ba9d-011b2b639f94@linaro.org>
Date: Tue, 16 Jul 2024 08:31:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iio: adc: ad7173: Add support for AD411x devices
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
 <20240607-ad4111-v7-9-97e3855900a0@analog.com>
 <e48b2dee-11d2-4dbc-868d-10870e3c07dd@linaro.org>
 <68a25946-247d-4351-b847-35605220b16f@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <68a25946-247d-4351-b847-35605220b16f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/07/2024 19:17, Ceclan, Dumitru wrote:
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Then please
>> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
>> Some warnings can be ignored, especially from --strict run, but the code
>> here looks like it needs a fix. Feel free to get in touch if the warning
>> is not clear.
>>
>> Best regards,
>> Krzysztof
>>
> 
> I do not get any warnings, only checks
> 
> If you meant the checks:
> - for the alignment check, i would only argue for struct_group(config_props that looks good
> - for unnecessary parentheses the compiler warning appears without the parentheses:
>       warning: suggest parentheses around comparison in operand of ‘!=’ [-Wparentheses]

Hm, in that case it looks like you documented some entirely different
bindings?

Best regards,
Krzysztof


