Return-Path: <linux-iio+bounces-2003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF283FFC0
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 09:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BE01C2085F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A352F6C;
	Mon, 29 Jan 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emXgRnWG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B5537EE
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515965; cv=none; b=TnjXeCUn3ISsej+Rw8JC5UWjdRLPDLTiwEDnARfuJoUaTjiMoGD8KTkMf1UyQiV9g4iVBiyStQi3GfWBjKxnt2NP4pBpWLHkt3q8TjZUtQiGl2RXM8J75vJE8Onxpw1zTGZmhzRgmZql8W9hchyZT/Zdf2RJ3E8vmPX3KbMIYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515965; c=relaxed/simple;
	bh=EZVuVCAnA28VOLQWf2d+roPcIgtTo0gz77MLV1+lYmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFtuB9EP0k0uR+5wSrlmRy9xGPecRO01nSVmDfJE0cMQfFQaoSG1W8xWuseydO6mwYy+dHR9hTUfsCLgh9L4mvzfZyiJzMOU4L3WRoie2VqYd8yFqtS6N4JcRIy7jAy+Ax5QTxTm3msfSd44ynkhP4ERQLMxLciA/fSjcqs2eDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emXgRnWG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3122b70439so317531966b.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 00:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706515962; x=1707120762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FIpRWLZbwN7yMksRpP0Iu+1IEycuf4fyMPnwvD0Q3Q=;
        b=emXgRnWGzHb50TyfrMqyB09aOZ45SHbYpYtz3XRAA/FLMtcSTD8/Je9xZ8wN+iI4Zl
         0143ebZYgjLD2nW0QAlS+oGklhZpywiHy7Cr2jNd/v3OkeLjoKaEZWyvj9EwHJWiAyTQ
         LPHSXP93UBewSxXQjKGCpllxvfOv67Z6TUPUkJ09EqcXS7U2f/EyWevmco9BtfZZAUKQ
         XwzWgRJsW2OEhGFlyPS0ZLpgjCSSIQIWDGNHQ+BEM5UqLtKMxgjgn0FO5NHwH1ZdXS4r
         b9KaaR43Q8Oko0VdIYUJxwGu3CNCPec6LHZEAlof/Fgj/kM3VUzDHRDnta3dtR265jps
         FwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706515962; x=1707120762;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FIpRWLZbwN7yMksRpP0Iu+1IEycuf4fyMPnwvD0Q3Q=;
        b=blk95e1L5vuyUzAnDt0RVy0sOTyPhjZ55+fF3Oj818GH+wTJk8N5JFrFlzTU9wdTHv
         mUk1xrXj8g/58Z6zh4zPcFP4UEbJnQEAYLHQgINcLkuE1Tk8ZFmYvekjHpq7LrFKVdjF
         y8tzqbBEu6J3P70vVYfNx7CMkLlIO3zTyuEdAu4wemwD/m4DD6uKPrEp9d+JsaypgeZM
         rPSMBaeU8DNkGlf1imhguvLaDpNdKH4ruPgKq29qwAM4gaXPGD8K6xlIkdRs5vX+HmSm
         pSA2O7MfEWvrHpMuJ0XmioSLKlCOwQtO5kBcJdj2aH1PvF5opS+Kpi6G32ayKp3Sn/sq
         4tQA==
X-Gm-Message-State: AOJu0YzF2vBnU9YtXAegybYid2rO3SGE+qYviasrNsuoIXIFNhMok1LU
	MKM2LMZ79GQORwDH+ikMhr/l40HkDQfupwQXPWoN0gV1th/lcn49tdjmpvKFLdU=
X-Google-Smtp-Source: AGHT+IGKSgiPa8t3xoZCmGJ55cxUF5z/uq32AEccHElHyv/cEtIApr4vhr/+rVz4egAd4i+ROKFfbg==
X-Received: by 2002:a17:906:6bce:b0:a30:f149:153 with SMTP id t14-20020a1709066bce00b00a30f1490153mr4238316ejs.22.1706515961761;
        Mon, 29 Jan 2024 00:12:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709060b4200b00a35ed4fd4cesm72328ejg.115.2024.01.29.00.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 00:12:41 -0800 (PST)
Message-ID: <51f4782f-09d8-448f-a693-e0c711bee18d@linaro.org>
Date: Mon, 29 Jan 2024 09:12:39 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
References: <cover.1706441008.git.lorenzo@kernel.org>
 <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2024 12:25, Lorenzo Bianconi wrote:
> Add device bindings for asm330lhhxg1 IMU sensor.
> Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> all the features currently supported by asm330lhhxg1.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index 28b667a9cb76..7ba3de66a2e1 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -49,6 +49,9 @@ properties:
>        - items:
>            - const: st,asm330lhb
>            - const: st,asm330lhh
> +      - items:
> +          - const: st,asm330lhhxg1
> +          - const: st,asm330lhhx

lhhx is compatible with st,lsm6dsr, so some explanation would be useful
why it is not included here.

Best regards,
Krzysztof


