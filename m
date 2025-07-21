Return-Path: <linux-iio+bounces-21827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9AB0C5D8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EFF3B5E5F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B932D9ED3;
	Mon, 21 Jul 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z5K6lEMl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54692DA77F
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106966; cv=none; b=ef4d/yfUrPBjZjvz1pYUgZ1ADmLg2VtR1HAXf9iULT9NSWWi8KGJQ94H0o+RTkdWnFAb35Br0/2W1I9l0UoPWivCPTjmLF/7OsZjk6IcXv9h4tmAKjL0cvgkRTRw7fFGQmBPH1BzwuOHXaR7Q5KFwiJbkEDBQJjm+dZxgCMKwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106966; c=relaxed/simple;
	bh=++Ox7gKvHdwky39WdQJFmk0HB160GJNorAa3/n8tZP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKIAddIY8QK+AZOSCg28OUg9ubk3GiuVyjbKtydjc+NtNcTOZgvQm04nj22ErpUsjD98r9Xv6MQa5Fyen+rgzDtsDDseWdRp5dXVQQ6L76wKqpa1m8CXwmBYFLyaed7UO9vVn+C4xLR1o+gh3NHMyaBsxh/wXYQ5Pv6MtXeiBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z5K6lEMl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73e82d2ec52so429586a34.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753106964; x=1753711764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LnLWJUsAr+JAkpxUkcXadAzf96B3tnYqEVcIVAbTvg=;
        b=z5K6lEMl8JmkEUT/7Ok1G0iQxZb6TAGi9hc3Gt48hT/ZgTT3YKcTBUai8YkopcbpvF
         mxwi6k1EJkqez7O7uD4BgGZ7bNeUo3YQOtlDZryCx1vrQgytASP0vndrc4qV+EzSgYVa
         q85iw736SXmkEWipZjlY8XWTfXrmuGuCOpxPP+WXzKV/gm2Z1ebR6O8cr4VwacvuBUHR
         HozkpzdGWoDNtbon+i2/X23UkBHg4DyGoWViVKDFhDjmsK82gsrHWVa+WCK9xAG7J+my
         xwz+Kn1/h20pFzhx08zQ77QjYGLqFopn4maqP15AGb+y+zHxZmskqM/RbJdyWSlx9YZv
         51TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106964; x=1753711764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LnLWJUsAr+JAkpxUkcXadAzf96B3tnYqEVcIVAbTvg=;
        b=fVZ4u2DmoGhC3KHUnaeoNDnTRKPGQcbVyN/eUhyWA5Aybz0zRYwshQaAad0Gek5cqb
         zg1tC+SnMN7vz0gFox5OFBEbQnZD1NwpI12XgBzNd4k5eNz9HEz6Pw3jvOo19UXiUh+c
         sPqSQByXgBkgalPkEpA0/uob5is5bfHA5r/ZsqeU7wdLic2kUxLIc6iQv3yIZ+7E69Pl
         M6ONWGrriWA4j9nxMv98LTw99RGb3UMZABl3vVG99aK0O3RBdko/Fz3nV2yP7fAHRwh1
         oil3C7WblFf+LZw4eG4MKNG/XVOlQybJIwbzrG7khAa4DKUwBr70KrBn0AWW+Tejvw1H
         j77A==
X-Forwarded-Encrypted: i=1; AJvYcCXIC4/QKx1xttfIEzeIVPUTVn+ik6BN2JLtEx9xyhYfwx4zBs6L++vA9/8H3ibtFMNKoIy/ZflLkRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZ9bb8sxxSlkNg6LdxWF/j8iuYDP0WSNYumMA9a5XCUkuI5M6
	IfqQ0atIMzQzSmJGrI30gMBF/0L49rYIlm/VfUid+iF3XfuRgw4SNfK48ERQdfRpu+s=
X-Gm-Gg: ASbGncs1h4j/eDaOdhilYL1ISSN0+k5CU6/mRH808HmqVQDqeKbFg9gSySmsqjilDAs
	7fyz0nr7dcAg2rkM1JF/ePRTeiT4jLPY8WiMs3q128bvXqiUCsXX8+SztChxV5qkc/TI/LKtqEI
	tnAYdcrvgIuC39kQjIGEF4VffL+5sLWX2rPmygUUH9+fGOYT73rRenVeeruCguM3wV8fvozGd4g
	QXtT9PQ9KqUeH/+B8EiR+jU//zXqLvSPZkXfLUC9KkhbbYZx7iPT+Lk2rjHwuEfEfu+J9aaL5Nn
	WXofI8+hld3zmOskipG4xpiKorhpje4x0FbNbJj1EhU446kdoxsbkd8NRuhsxGRPnlwv0ZwsYn1
	ubDlhOdvjpTYoIlwk4FxlTPeZzvPoy2kmBHXyrpaeOarkAB6yBxR6yt00YSmcHLLOJeZRp0WxuQ
	M=
X-Google-Smtp-Source: AGHT+IEYJ69qw8hWrbyhfCDdoYCGwahdtxo+pfFxwMph5mSmiJShT9DMVnokAtIY6hWFVoiT1iMVrw==
X-Received: by 2002:a05:6830:3e8b:b0:735:af51:5ea5 with SMTP id 46e09a7af769-73e665b9181mr11113510a34.22.1753106963677;
        Mon, 21 Jul 2025 07:09:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83bf667fsm2820418a34.65.2025.07.21.07.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:09:23 -0700 (PDT)
Message-ID: <35eba285-2c49-49ac-9da2-29636e257196@baylibre.com>
Date: Mon, 21 Jul 2025 09:09:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
References: <CADU64hCr7mshqfBRE2Wp8zf4BHBdJoLLH=VJt2MrHeR+zHOV4w@mail.gmail.com>
 <20250720182627.39384-1-sanjaysuthar661996@gmail.com>
 <84ad0f66-311e-4560-870d-851852c6f902@baylibre.com>
 <9574826f-3023-4fe1-9346-eacd70990d73@kernel.org>
 <CADU64hDZeyaCpHXBmSG1rtHjpxmjejT7asK9oGBUMF55eYeh4w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CADU64hDZeyaCpHXBmSG1rtHjpxmjejT7asK9oGBUMF55eYeh4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 5:15 AM, Sanjay Suthar wrote:
> On Mon, Jul 21, 2025 at 12:22 PM Krzysztof Kozlowski <krzk@kernel.org <mailto:krzk@kernel.org>> wrote:
>>
>> On 20/07/2025 21:30, David Lechner wrote:
>> >>    - Ricardo Ribalda Delgado <ricardo@ribalda.com <mailto:ricardo@ribalda.com>>
>> >> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> index 0cd78d71768c..5c91716d1f21 100644
>> >> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> @@ -149,7 +149,7 @@ properties:
>> >>        - description:
>> >>            The first register range should be the one of the DWMAC controller
>> >>        - description:
>> >> -          The second range is is for the Amlogic specific configuration
>> >> +          The second range is for the Amlogic specific configuration
>> >>            (for example the PRG_ETHERNET register range on Meson8b and newer)
>> >>
>> >>    interrupts:
>> >
>> > I would be tempted to split this into two patches. It's a bit odd to have
>>
>>
>> No, it's a churn to split this into more than one patch.
>>
> 
> Thanks for the reply. Since there are suggestions on patch split as it is touching different subsystems, still not clear if I should split the patch or single patch is fine. I would appreciate if you can guide on the next steps to be taken
> 
> Best Regards,
> Sanjay Suthar

Krzysztof is one of the devicetree maintainers and I am not, so you
should do what Krzysztof says - leave it as one patch. :-)

