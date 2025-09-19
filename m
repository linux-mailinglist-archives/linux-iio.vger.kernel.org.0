Return-Path: <linux-iio+bounces-24297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D650BB8A76A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CCA62342F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64931CA72;
	Fri, 19 Sep 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDhgMlHZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9F320CA8
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297520; cv=none; b=ukc+GJugUFi+rzj6kDUnj99+pOk3thX9WLVJ1HxyG8kSx8YlcblxVYjCT9f2CWksXrdUddVkre7uZ2ZwKc7EjxB0XpN8sMtayOCur/qmYNgwfTIqgaA6ciH2NW2H4QY76AKQHek4jFRKF9LIIBZyW69pnCippaYmEMzaz32kvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297520; c=relaxed/simple;
	bh=t3P2GEOcwivP3t6/urkttM5U23eccg5yH/vgb1kPN6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZMQs2udPxtSIrrLlrClVI9v/hlO9SeR45Ndythq59lWOv0gfthqJxSNky+i2t5ADtX/miqridSiTF8LaeQDzaU/wYq/GqisXj9tD5nemaNO5rFtj43wETxtwWCQoGrSU794DKWxat6vgBXVPGpg5Pb5AFd7hB5ID2eIFPgZNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDhgMlHZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dde353b47so12381575e9.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297517; x=1758902317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnqHCvU7rGwJGGO0ESYLZHhX3MxXPvdCUBjgSC9Fnxk=;
        b=WDhgMlHZ/7SIcNS/sdeAzbLsJdC9l9L2i1QStGYhztxbV8frEod+OeF6hbWIsLPjcn
         wNEU/rWo6fAtDwumz4JfIxza7Vk2a6cAV28/zdrh+93EXxPWnjTdKqAOW2MS0o5tDsbK
         3jEiWFZMAh0eoMhs5dL6w8CIBseTEtY3OPmSRTtQZYy8fC0aQ3Z5lJEQ+babT58AmCQ5
         /XKcd9I/iwotj+HzjmvBU+ToDTtvJ6Iii0aRoCnhCVsge33I3uCREXO1VcqXCKgIOCFU
         z+5gtlMO+PkQFWnjdSQBDZ9dXgLmW4rg/uafOmVsB700oQMA0RtCoHX6+mTdwA8mKRtK
         LVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297517; x=1758902317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnqHCvU7rGwJGGO0ESYLZHhX3MxXPvdCUBjgSC9Fnxk=;
        b=JG/d5v4nO9FE6afLVMZ3T6qaMhMNYQBxAWKuJ1gSge64/yQG8/hr1Cgrp5y5DUmOzR
         7q88XYsWSg3G9AHxWcp1UAqQX64Y382/x/2iRRatOKVpK3Tkvc3+12tRBtjLpyyjtT4s
         ApEOCAo5nPqCVhbxkMvuCpK+gq7VZ53VL4g1nAO392oK4bae8XH59fH0DskcBELmoMKD
         z464CYZJwmnibtr7oxbGKfzV/3pVT5+l1jCxdX9I51CFZdiFikFerA5/ggYDKaMAemTO
         nulwZt4iscq+Eb24OZd3GocjB6TpZowd3WGkf0fmuDOx2b1xrVJO+YhjGOUUxrqjPZzP
         1nZg==
X-Forwarded-Encrypted: i=1; AJvYcCWvYMQ/cKqecI+0FKlKWk8nW7emUaIrDJGlA6K7mIz+DxBy1du4a3KNiHYVUDMfeWDvjV5KCmuANow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxukEbcnVzqECRzFsT6GI43CY1XmK1vGvH6pg2B9Q/T5+5DyR+Q
	t2vbL0C+1R8/7SyTZXE0G+2wCgWzLA53bo/36ATRHMx1s7Y0Xnl1uKCcUuV1Gz7JiRk=
X-Gm-Gg: ASbGncvjS87KLftQbfrhHYAhTSg5dmtuzrDBgT7N5HHNitpFS3QIFsiLDfwa9AKW6E9
	i64es8gImAW3h+z+kjLAlE/hxQ6hz64iPRxLanSouUFnPLYJbmijpsWN/9T06nf3fZUFTubIdzR
	UxhaguH1CuvtYdeXcpR7WDY2b76W1bSjPGHelpHtErPnOaztLh0O0L9nbHG4R74PYJLuhPOuTFY
	OieFkYfDz15AX25T0wR9aCz6jXEiIUu4RrduWEUDVniHxNZEPP35XKzEQSNAngx/L9luf5f4Nfb
	/iobVe0gt/c4Pgwlg9PP2p0r43cnFlW+9eFtJl/UeK3vCLBzxmOZqTTXCHKt2W1cr9BzbMd57tv
	ChSh/tiV77PNEkEsKtVcRch8lQA0J2MgKY89OT4RNKT5Wk++jSa6FlXq0Sy+d1dMf6c2St7aYRq
	m45Q==
X-Google-Smtp-Source: AGHT+IGiHVqCid6jiNXmY7e2HfatNlHZD3vTyoXsmvvtSGKovpZ2+7Stv4IcOLATQICU8wnyJ6SpuQ==
X-Received: by 2002:a05:600c:1f90:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-467eed90607mr31739365e9.14.1758297516735;
        Fri, 19 Sep 2025 08:58:36 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f527d6cdsm106682695e9.12.2025.09.19.08.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:58:36 -0700 (PDT)
Message-ID: <54b7e9b7-e2d5-404d-9410-06b62a11d073@linaro.org>
Date: Fri, 19 Sep 2025 17:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1 RESEND] thermal: thermal-generic-adc: add temp
 sensor function
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250903162749.109910-1-clamor95@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250903162749.109910-1-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2025 18:27, Svyatoslav Ryhel wrote:
> To avoid duplicating sensor functionality and conversion tables, this
> design allows converting an ADC IIO channel's output directly into a
> temperature IIO channel. This is particularly useful for devices where
> hwmon isn't suitable or where temperature data must be accessible through
> IIO.
> 
> One such device is, for example, the MAX17040 fuel gauge.
> 
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

