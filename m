Return-Path: <linux-iio+bounces-23333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50440B39B83
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 13:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D948A7B25B9
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2AF30E825;
	Thu, 28 Aug 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9p30+YT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F230E0C3
	for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380446; cv=none; b=dcBlqW3wRkyFs0ilFgmij9SoA43nK/ToQZzPSrMoNhYnFgJr/GGaq/AL+0fVFhGqKtwJD+K8B4C1sJ7tu8X9+Xmz+PPzn/iqL6KFpSqnE+GNZT/jr0A86U2dFpSUpL2sL9oXLokUiqwoAZWYxpW7cDElaa19IgMYybVIS4rAJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380446; c=relaxed/simple;
	bh=PXA05d/MuF/D5apGw3S4Tk0j0ctdz1q49N+CLC3BVaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8GPlpV51yHViTNi0KGbFbLO7HAlYYClq1mfgxQ9+ABkR7oAhFynCK05rQBXe5qmk2DKEQu0CtxQqxsOtnD21xcZzP6WmSOULGTb5oxaKxY6ph2h5fKm3OHqlQwic1uwGQeOeP4mSeQk88BZDvI9JTme4TSoJDq0JBstGuKoRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9p30+YT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afeae37116aso8193766b.2
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756380442; x=1756985242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYxwOUn5RO9RcaFpFVSkar8NeVF+jaOYqJmxcaSOISg=;
        b=m9p30+YT9vzln0mzXpSc0QLJLwHd05q3dLGHPKslh19fkd4Bm2sYTIKZEX0TYczXwF
         OtVYgtxXgT3d9hSl/zU7p7tr0kclyj219bDTo3x6UUHxCPgCTWK0TziTL9fK5Ue5YiCq
         G4BhpzOCqA8YOUCpd5MM84emHd/7n9cRYJYznv0S5Tmy6P9RiML8spIgQryqESMzBwOe
         fqRI57Fw0iwEoS8BEbMLXWIR37xW6+4yWa5W4TQnV2BZRsTKSv7iq4xLatwiOK2GpUXq
         NXCMwK67WE8e/xNtZyGdgrHwKM0doeAqmHCoNIC1h0bWCJn+06dZtU4cj7EgHI2UzbvL
         xYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756380442; x=1756985242;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYxwOUn5RO9RcaFpFVSkar8NeVF+jaOYqJmxcaSOISg=;
        b=hM7T1c6IJ61kaqxNx7vxWNsW3w+cfeWp/hUR3Ro3yr5AhyKVtSN80EZzRsK7GU9nIQ
         7Wi5mjFlsduJMF84oJuF5fVUugV7C0PP0avNG9xOPC4UFpzd94LEkYp9WcwS6MrwcMG4
         /TODmizu7J6+RjnwlzDVqAhlHHt5waAZ9v7WuT6CWWeLbEiSlSWYcmbLpEag13OXeHOq
         Cdj49wMQDcmmNgUpuaK6qK7Kew0IYhWOXqvj2+emT18M5yjJdeQShd0ZwXW5feYFCw/n
         1ziZRhdBQ83Nq11o2qEzlFIP1DUqeKkgISb6Fz80tTBTnxeiOMvVjL1FQMPv/aq/eJh4
         B5QA==
X-Forwarded-Encrypted: i=1; AJvYcCWUfgQXK/vIweg6cH4tW8lyPUmxnTWCzhO1xFq/xyg4SXScF7QiTSBRhheBudGMHi81AdZOHiKyk+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykUCp3BZTPLx5U/PBgs+byxcETuNZ2fXyPZqixp6PdHD17TVC9
	ywgfYjVmW/4pM+jJYC3UHKgHz1tKd24KrOsUmru1GJvyj/6SKqGzAupt7usaXaTpV3E=
X-Gm-Gg: ASbGnct3iJqZEwGMVwexrJktQ9VfFYtnOAm6HvUKv4h5vVH5JBxT6EMzL4uBX5l3BkU
	JFuXHIqmbaDp3ktdBCoe7KbiUhbo2pE/Cr+Enz5GwJSf/m+mpK9N7z4RMl/8VPuc+pqkJDtKU91
	rKhVxES36afJ0DdlvoYX/HA7KmTeZSxbnEDKgK/i89TdxahYgTSBaGtA8DMhoalZa8Orfw+fv6A
	tMNrdRzeCVANNeIfEGPK9XNv3RxhZMKmZ5Tg4CZOYeTaYXdkuMLBhkzYm5StQxg+vsqq9tNgRFk
	cpA3OhOUlujqfb+313iID3E4a0s6BGdru/M3FZuTwO9QTS3MOhDRW+zfPqS3iZ6jPasZTq3oQGc
	pFe0bHri6f/9blmL8xVMijK5LEwZoT+/91Mr5bsJaGbI=
X-Google-Smtp-Source: AGHT+IFSeB43HKjtBSCloOCDpDpfschdv3+WCr9ykr5hqiFbaeWcfJhfAxNbXw49kQ6a8ZyAG8Wm5g==
X-Received: by 2002:a17:907:807:b0:afe:d028:ebf5 with SMTP id a640c23a62f3a-afed028fb7fmr219739366b.5.1756380442237;
        Thu, 28 Aug 2025 04:27:22 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8e77c6aasm749161966b.56.2025.08.28.04.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 04:27:21 -0700 (PDT)
Message-ID: <a92d691c-7cfb-4ec4-80c6-9be0363503f7@linaro.org>
Date: Thu, 28 Aug 2025 13:27:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add device tree binding for
 MAX22531 ADC
To: Abhinav Jain <jain.abhinav177@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 alexandru.ardelean@analog.com, jlc23@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Marcelo.Schmitt@analog.com, dumitru.ceclan@analog.com,
 Jonathan.Santos@analog.com, dragos.bogdan@analog.com
References: <cover.1756115378.git.jain.abhinav177@gmail.com>
 <ba7c09277c71cd8bc84736429a7fdc66914fd322.1756115378.git.jain.abhinav177@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <ba7c09277c71cd8bc84736429a7fdc66914fd322.1756115378.git.jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/08/2025 23:25, Abhinav Jain wrote:
> Add device tree documentation for MAX22530-MAX22532 family of ADCs.
> The MAX22530–MAX22532 are galvanically isolated, 4-channel, multiplexed,
> 12-bit, analog-to-digital converters (ADC) in the MAXSafe™ family product
> line. An integrated, isolated, DC-DC converter powers all fieldside
> circuitry, and this allows field-side diagnostics even when no input
> signal is present.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>


Please do not develop on old trees. You need to rebase your patchset and
test it on latest mainline kernel.

You CC-ed an address, which suggests you do not work on mainline kernel
or you do not use get_maintainers.pl/b4/patman. Please rebase and always
work on mainline or start using mentioned tools, so correct addresses
will be used.


Best regards,
Krzysztof

