Return-Path: <linux-iio+bounces-932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF45813737
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A23282BF3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6063DD8;
	Thu, 14 Dec 2023 17:05:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12311A;
	Thu, 14 Dec 2023 09:05:13 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6da4894a8d6so357112a34.2;
        Thu, 14 Dec 2023 09:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573513; x=1703178313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjpOEvjDtPRr5tRMf1iA1IY9pwxNPBZS+ClePeV2O+A=;
        b=gEC8NAXFylmuEK4BXZyI9zzGi9b/GWycXbiLW7AFts7HvZ0kfTKlccB/fKTmJLtiIN
         m37qYZL2kterHPZVgJXzy30jSAsGR4rPfo2Hp6JQnwPqNqNBMeyZsjuWgoX0JoD42FpI
         RzjrybJuqHLBt3edi9+NasYLTO3FuQr9zbbuRF6bq5oyFdqAEniIKIgbFnMY5LB880f9
         RhIN9RAVR8OGMRGiSH04gEWxvG0xKwOP8+AApCEiq0tQ8FFf3pFvZIHePkLqMIRFrTT4
         Gy36bs6CEYXO6sFvz2j9BlKSj2UuHuOYiJJN8WYNwZ6467IwR4+MckMjgAfUS7sc66/B
         cLNg==
X-Gm-Message-State: AOJu0YxnJEEXGOMFHHhdc/0K1tZBZf7sPrxlKm//iMV9U5T3irQD1P3B
	RCN7nWhV6LFQHuoVxMLD4Q==
X-Google-Smtp-Source: AGHT+IHlbLbF1802lAc/XPshRDBx0qPkuQWVDgWwSTXnWIutkEP2QZULW5QJgOoD2/NloDSEwsDBFA==
X-Received: by 2002:a05:6830:51:b0:6da:3090:26 with SMTP id d17-20020a056830005100b006da30900026mr3456623otp.59.1702573512953;
        Thu, 14 Dec 2023 09:05:12 -0800 (PST)
Received: from herring.priv ([2607:fb91:e6c7:a40:1c2d:b875:912d:c28])
        by smtp.gmail.com with ESMTPSA id l16-20020a9d7350000000b006d9d3d0e145sm3243925otk.10.2023.12.14.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:05:12 -0800 (PST)
Received: (nullmailer pid 494608 invoked by uid 1000);
	Thu, 14 Dec 2023 17:05:10 -0000
Date: Thu, 14 Dec 2023 11:05:10 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Message-ID: <20231214170510.GA492798-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
 <20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com>

On Wed, Dec 13, 2023 at 04:02:32PM +0100, Nuno Sa wrote:
> The ad9467 will make use of the new IIO backend framework which is a
> provider - consumer interface where IIO backends provide services to
> consumers. As such, and being this device a consumer,  add the new
> generic io-backend property to the bindings.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> index 7aa748d6b7a0..74e6827cbd47 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> @@ -44,6 +44,9 @@ properties:
>        Pin that controls the powerdown mode of the device.
>      maxItems: 1
>  
> +  io-backends:
> +    maxItems: 1
> +
>    reset-gpios:
>      description:
>        Reset pin for the device.
> @@ -54,6 +57,7 @@ required:
>    - reg
>    - clocks
>    - clock-names
> +  - io-backends

New required properties are an ABI break. Please justify this in the 
commit message.

Rob

