Return-Path: <linux-iio+bounces-8592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D871956B87
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 15:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EDB22581
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2EA16C438;
	Mon, 19 Aug 2024 13:09:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A94166F39;
	Mon, 19 Aug 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072989; cv=none; b=VN2pkGlH13EJnA9O7lbSt64wslk3q9kji8Kw5CRbQ7gx5WfcIlae5XhJgh2a3oE8ezCmZcTIg4+Wp5XMJYPGiqp659PBkiXjPuVsC2CbNeT7qdt4jmq6MAiqCPOch7Fos1st13wSMylSf0YSZ9i+c7S0baa+xWJEnZ1fw5A0kwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072989; c=relaxed/simple;
	bh=DOC54jYGZaWsMtc7059yc1yPA6AXPM92NKoC5lpbKNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMN6pfCv+0VNU/pydgg0ZTkp8xC5D/3kuvNxeC8BNTf4dGR71xY2Kc6EiaBR449Xppg6A34jb4xLLnhRvUEE+VXrBrL01G1Ip6USKXrNMAObtu+xvDO/BBt7uKSVu6gq4dFAHFzNy+xr7jwI3ogIZ0NSSmwmIWNHSBUfYe/iyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-429e29933aaso32496075e9.0;
        Mon, 19 Aug 2024 06:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072986; x=1724677786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB1MOx97YsHG48VJD/TdRi6Ad7SdIJCFhXTwmxEvExQ=;
        b=ZE3I6bEVLTPrf/1lqsXIlQR/uE2ycm74FN3ckuOJWCmHA57pxptzHVZ1oonueSgfq4
         Rqt95u+ZNwOoGtSj92RwxGWT0P0q3ExC23JIXATc8tOWpdJtIzqCQhvbLVVPPXe+U5uw
         SdXyTGbE6ju/dYISOsO4UKu9s2MvQprXnxDRzbnFQHlLKlutdSh02mjcu1rIOt1J5uVo
         tjBlKa+4JKmfy18RqRZzhKyfOEnNL7BeLZG+f7U7AKIxSNzw4DQ/Z7AfVGHK09OJYQ2t
         LKxMJL0yxvxMvN94xr8snjrIF5fgFPeihUfNB4jTWOhD3xnWIBjPeTBApdl1xmH7c990
         IXLw==
X-Forwarded-Encrypted: i=1; AJvYcCX8qpdi3V4Mok0YZ9lP4yHhCYSpfEYUyXbKSX7O7K1W3NQa5jYhxwSTbPzP3Z6Ho7LXgVDQlpoproYSjSRn6txPAjbzgE5eicyumwY5E06kjuOG3nF7fZWxijDoFa/VH+u5UHUZGGPI6A==
X-Gm-Message-State: AOJu0YxynpSMh2BAmgrPfwOLxZ9S3SlTXCN4O1wqMwhR1Bic+ZOqqth4
	wrYIbhSm170VwbmFWiFEEfnhUY0GFNQ+0odY/pE0pbclu2Q/MvciC5YJxA==
X-Google-Smtp-Source: AGHT+IGCwFU1j+9a/YAjtVzVdQG8YtaPaT8qwMXTkcwI9NZ08PPlpySeqHwUvujcyRLUEjAp0hyJlQ==
X-Received: by 2002:adf:e255:0:b0:371:9395:9c2d with SMTP id ffacd0b85a97d-371946a5ac4mr7472423f8f.55.1724072985949;
        Mon, 19 Aug 2024 06:09:45 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718983a974sm10559731f8f.13.2024.08.19.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:09:45 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:09:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH 6/7] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
Message-ID: <zuvwoy5wtdel7qgkz6wa6valwjwajpwoqnizyoooiawghrxvc3@cuoswu32h4fl>
References: <20240819064721.91494-1-aardelean@baylibre.com>
 <20240819064721.91494-7-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240819064721.91494-7-aardelean@baylibre.com>

On Mon, Aug 19, 2024 at 09:47:16AM +0300, Alexandru Ardelean wrote:
> The driver will support the AD7606C-16 and AD7606C-18.
> This change adds the compatible strings for these devices.
> 
> The AD7606C-16,18 channels also support these (individually configurable)
> types of channels:
>  - bipolar single-ended
>  - unipolar single-ended
>  - bipolar differential
> 
> This DT adds support for 'channel@X' nodes'

I don't understand this sentence, suggest to drop it.


> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  .../bindings/iio/adc/adi,ad7606.yaml          | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 69408cae3db9..f9e177de3f8c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -14,6 +14,8 @@ description: |
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7605-4.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
>  
>  properties:
> @@ -24,6 +26,8 @@ properties:
>        - adi,ad7606-6
>        - adi,ad7606-8  # Referred to as AD7606 (without -8) in the datasheet
>        - adi,ad7606b
> +      - adi,ad7606c-16
> +      - adi,ad7606c-18
>        - adi,ad7616
>  
>    reg:
> @@ -114,6 +118,30 @@ properties:
>        assumed that the pins are hardwired to VDD.
>      type: boolean
>  
> +patternProperties:
> +  "^channel@([0-9a-f])$":

[0-7]

> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        minimum: 0
> +        maximum: 7
> +
> +      diff-channel:
> +        description: Channel is bipolar differential.

There is diff-channels property, why do we need one more?

> +        type: boolean
> +
> +      bipolar:
> +        description: |
> +          Channel is bipolar single-ended. If 'diff-channel' is set, then
> +          the value of this property will be ignored.

Then provide here allOf:if:then which makes it false if diff-channel(s)
is present. And then drop entire property, because you duplicate what's
in adc.yaml.


> +        type: boolean

Blank line.

> +    required:
> +      - reg
> +
>  required:
>    - compatible
>    - reg
> @@ -170,6 +198,21 @@ allOf:
>          adi,conversion-start-gpios:
>            maxItems: 1
>  
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - adi,ad7606c-16
> +                - adi,ad7606c-18
> +    then:
> +      patternProperties:
> +        "^channel@([0-9a-f])$":
> +          properties:
> +            diff-channels: false
> +            bipolar: true

? Drop, no clue what you want to say here. But more important, you are
now adding channels to other variants. Split your commit between new
device and new properties for existing devices.


Best regards,
Krzysztof


