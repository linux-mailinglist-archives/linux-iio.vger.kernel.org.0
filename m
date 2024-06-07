Return-Path: <linux-iio+bounces-5984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B178FFF7E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2634B26D41
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D9A15D5A5;
	Fri,  7 Jun 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAxjVkVS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA215CD71;
	Fri,  7 Jun 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752556; cv=none; b=b8bOruE35eNjb9odvkY5x7e4oDa30BLNEtIaypAkqW1GTBF/7tBSWI0fAHBH48drjAG3Migy2tG8NWEORSrWKdRSfsZpJrzbMcEXmH2SP487vxykiC+eqA+ChFd8tIguOB5AG8yPWKnTb1fgmk278nFrzseGIPpRiHtguilpdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752556; c=relaxed/simple;
	bh=GzBUnyXxshdSHMjHSDJb3kJtesJIHt7JlG5v39BmorU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxAXF3ePBN7EeKVd7Wf0vjuo0t1Olk3j2HXI1ByjHF3T/fQ1pntkUfK4nqIBiAjWZ+1auU9twghW566aWySw7FTrQa2xAxYISYQjpaipQZPHbzt0aIgBy3jbDl/FjFZvZTqiILdbUJGPTPpxHfIYDX3U+MulW57ZpQj+dxhseQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAxjVkVS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a696cde86a4so212771966b.1;
        Fri, 07 Jun 2024 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717752552; x=1718357352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IS4pEps2gpU7ys25a7eyA6z8GstkkHa2k3SfObludr8=;
        b=VAxjVkVSRwS/AVDIxoqW/rznrF2R4sGi9yZ5yebB9UiSX3+orZMyXYmKpi6GjI/Kw/
         P++xro54M7GzOJNajIdeeBYovEeO97fQchw4yFt2BptOo711PO+j2tbHZvTj+Lre3RuL
         zaPoYFjGcVa4nyuDoNvZS+bfq+pnCHwQXE9asgapQmCSOBt3NpJG6uO1l0KKYb/rjXv/
         FOF6MJRwHg/7E95mfPTS6iFV8b7yOlvXYBz3+G1GXo4TmvKa2LIn7txOLMZjmXqLfomD
         cbJTx1L86FxUg5bNN367F97YtVHqIky+QfaJ6FmhL8pmuCPFRrksoFAL/LmDNJV2XBIK
         3vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752552; x=1718357352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IS4pEps2gpU7ys25a7eyA6z8GstkkHa2k3SfObludr8=;
        b=t/1SntzjzBqY7CMHzM5n1VuIKGcd3xGq4TkDLfDgZ0KP6CBhDP/x0rYADJnWM2bTI/
         ypKrDilpfAXF1F9GE8WxngNg/j7QsF+2zXhjpZY/WQ6Gbo1D2BqqZ01JifXbS1+s+bF9
         ylu69Vw8zZkkrudk5+cfRGgSFlT4AITmtqoxXEpJ396ea0B3Fk8/X4CnJFblUYM+7nUN
         Gx2HLeaSCgLNd/ut+Cv3StoBTgddE3iPB2QjZ0aBRC0+dmKuKiyJchiEXLXVlyrjE2xS
         Fifsld8OEY/YIVV0VE8ITrFXMN9VOdPirVTRn4vY0V5Dl6T2fO0gZgVKzIfIPLmkSg/T
         tzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlUxa+xiAhlCJX873eH+nf+a/TccGwoL0jYRj9T1zOnryU8L1R/1aWg4XUPRNJPiMLs+pSf5H9s+K0sW7j6+/Q+FePbcuzHvcVg1MiZHXJHrGHBb9Lbymt1kOAp91tbeUdS5o92BJZ5N9JOJ6nCG+2j6mcScKKBBKFmlAn8JBI7z3row==
X-Gm-Message-State: AOJu0YwsOLtyzcSm0G+oy4Apsam0JZS/wETaxR0ikGdOkYaxaEwYG89p
	ZyjfqRWTq3bLLOwGX0bhgKlA0QCrJLhfmXHD+aq9qTv4+ribZnKJ
X-Google-Smtp-Source: AGHT+IHef8MoND9G3BY/OBg6wkSpN7o41bWws8UupSscnsuC/EouPSMNKzGZ4G1lLjXMwhJf9f6lUg==
X-Received: by 2002:a17:906:31cb:b0:a6e:f3d7:4112 with SMTP id a640c23a62f3a-a6ef3f5df57mr19327066b.64.1717752552338;
        Fri, 07 Jun 2024 02:29:12 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80595e7bsm217755466b.23.2024.06.07.02.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:29:11 -0700 (PDT)
Message-ID: <c361a87c-f447-4a40-8972-ff2399795ee3@gmail.com>
Date: Fri, 7 Jun 2024 12:29:10 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] iio: adc: ad_sigma_delta: add disable_one callback
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
 <20240606-ad4111-v6-3-573981fb3e2e@analog.com>
 <be5c166e088e28e8c1e4a09da0ed71163fae727e.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <be5c166e088e28e8c1e4a09da0ed71163fae727e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 12:02, Nuno Sá wrote:
> On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Sigma delta ADCs with a sequencer need to disable the previously enabled
>> channel when reading using ad_sigma_delta_single_conversion(). This was
>> done manually in drivers for devices with sequencers.
>>
>> This patch implements handling of single channel disabling after a
>> single conversion.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
> 
> You could have this done in separate patches... Oh well, this is simple enough
> that I don't care much.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 

Separate patches would break driver functionality then fix it.
The drivers would not probe as disable_one() callback is missing.

This would have been alright?


