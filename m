Return-Path: <linux-iio+bounces-17547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E787A7915D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 16:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A83A4C46
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417B23BCE3;
	Wed,  2 Apr 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fCoMjRgY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDF6F30F
	for <linux-iio@vger.kernel.org>; Wed,  2 Apr 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604789; cv=none; b=PuSStFI6KB1t+HOKENvEIo8+AAXRkk8nmXRuyhj2HuyBAuiL1ObbBKKKl+nPrtOLmj5FD8DeWrin/jtHcMvzkXyx3vvZclrfaLQbBQP7+ArmtkG2c7i/AUbXUkNougo/qu8m2WCqYAQwtLkzxJAXaUOJvl+fYJI/DgRucjO9YGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604789; c=relaxed/simple;
	bh=an2KdMGCipmCOgRCCaG66zbXLj51zno2bj0u66QMdPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAb+ngMSCtvilLRlnIceo8gzpvKSgXIkEx0fRaQc9N0RPNHl8sFg2rA9GnLexapQBW3DdORrLAbbw5v+81LKpj/H2sj8IAaHrP7GQ1WYz1xbFjPMZIQ+2sJkoULHIJBrCUXZF0hPxRBbyl5YvIGDMJyQoC7B3dASUTF6T4sMX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fCoMjRgY; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c818343646so4282632fac.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Apr 2025 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743604786; x=1744209586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EoS+69ci33BaJ93JVqHmaX+qxJHmm+lVs7qiZGT250=;
        b=fCoMjRgYk2uNA9KHFLyPTi6OSp4vYKm4dvcMSE7TXSLtuGlLQ2KMRo7FJqeWUd0n7S
         9uMjb1YtaHDnZTOX3c8r0jkpedkuqMuWSF/68XaHLXZpKiUyQqFIEx7elBVGbs10O/Dj
         Lkbs2BDXte9EXQOsxrCh9K75Sl55/Y9KQpLKYJi4lq6Xl/OElebsVtKgICzz/17TICQl
         sKAiQtHcnY8P7nEQG1FbwJxGuIv5J0B0t+2fIeH0KWiG7AsuEqbW+QxTmT/gYRnHDFsy
         xrTEcOwI0SlsGHLMy1gl5m9A1Tx6NSr179JIdZSnSVaPKPO1DApryVnvdiJwsmReKgtx
         X5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743604786; x=1744209586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EoS+69ci33BaJ93JVqHmaX+qxJHmm+lVs7qiZGT250=;
        b=bE+OB8o90Dos4DeTNi2kWj6uPwXPwbz+dYa0t4oyTxnCEDar84vR6fPNV7vkkt1dzo
         n1ErBgg9AmmCiZl3zgvb00HuHrPmi8dCj9yIsqjqpiSnZvrpPbMUsqHX6rm3nMLFBeM3
         A+A53aQ2C0Isz67wbD9Yu8mB+haMK3GcOqpn0zM1Kykcqp/7U4UzyLxXO9Le0wUZgyGX
         7VaMWPOf9kiZIm7L+89dDEoOTGBoKiOKDd9npY3Sj7x8NS0++daNkF6U5m1SP0KNLcSb
         foC3XRCRK4zwwCHFPJPvTDCbUGw0Pf5XlzKV/13uYrg9JTamzT0Q0+tjb57CC31+JFfF
         3A3w==
X-Forwarded-Encrypted: i=1; AJvYcCVVR43l/ThKtY1ShbXaMoiOO6wJeww2nik2EWZSsr6Ada5U3uT5QC8GNxlOzTPco73cv3LqsDzCFxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60fAKYKW2qmLDCYv115TR+U7GRfXtqeRXBK4tXMnUHhGRjXOp
	s9VLZ20mZpmyA31ICxbPAjv6HTIZaXSIvl1PWBnN10w7V2t7jM3xwZOGnYpAFrE=
X-Gm-Gg: ASbGnctraZOzJn8T3i7yfl1qvBjWVAReApEA3Qm94kAiAp6QTr3XUVDIQEa/a2SHwR+
	AGOwtK4do6Gka65NMPx4CLkNnVIbVqB7x6dYaI4hMvoY2rrwuZkYDeipnNizYAIlIq1Xy9ZBRoJ
	zUwQqNoC7gF/dPjC7rMxZiWPlTTf2GZfHSbfgm3OSf7OJUQxmK7NoTITq9aU+m598cqqloKSlZx
	mZHH87HTyaGkd4zW3FDGB6YfDWQ0s8VvqnakxtXqKJ0TAEmh7Q53+d8hzENLfyoWkHVhFv8O2eR
	ZSiTNIbT6EgDcPe9YVYXFfp2h/arrz9L/TRD9TBxVBBr0xBfmhYRMmI/kh7lUd3kk8Bm7o11o8h
	am6FrqQ==
X-Google-Smtp-Source: AGHT+IE+TQS+xNEhqvoy35C1XBepZThD9x3tvi2hTYmUV7BCj5f7Twy+Lui8PnuV3OkYvF71xpDaDg==
X-Received: by 2002:a05:6871:8786:b0:29e:2d18:2718 with SMTP id 586e51a60fabf-2cbcf738fa0mr10881898fac.28.1743604786400;
        Wed, 02 Apr 2025 07:39:46 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a91391esm2771044fac.46.2025.04.02.07.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 07:39:44 -0700 (PDT)
Message-ID: <847307bf-c612-475e-84bd-31efcbd7239f@baylibre.com>
Date: Wed, 2 Apr 2025 09:39:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: ad7380: add AD7389-4
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
 <20250401-iio-ad7380-add-ad7389-4-v1-1-23d2568aa24f@baylibre.com>
 <20250402-winged-ambitious-sparrow-c988c6@krzk-bin>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250402-winged-ambitious-sparrow-c988c6@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 3:25 AM, Krzysztof Kozlowski wrote:
> On Tue, Apr 01, 2025 at 05:50:08PM -0500, David Lechner wrote:
>> Add compatible and quirks for AD7389-4. This is essentially the same as
>> AD7380-4 but instead of having no internal reference, it has no external
>> reference voltage supply.
> 
> So neither refio nor refin, but your schema says:
> 
>> +    then:
>> +      properties:
>> +        refio-supply: false
> 
> So what about refin, which is also external reference?

This is already handled by the existing if statement:

  - if:
      properties:
        compatible:
          enum:
            - adi,ad7380-4
            - adi,adaq4370-4
            - adi,adaq4380-4
            - adi,adaq4381-4
    then:
      properties:
        refio-supply: false
      required:
        - refin-supply
    else:
      properties:
        refin-supply: false


