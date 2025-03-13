Return-Path: <linux-iio+bounces-16763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D35A5EBD5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8E4189AC3E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 06:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9507B1FBC96;
	Thu, 13 Mar 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cItZmtyw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBF1E86E;
	Thu, 13 Mar 2025 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741848146; cv=none; b=hoi6+OcCkaQwbebUt8Y5+Ey1M6O1G6uGRLb3I2L7hiLgiHeQnP92/TavaHkzbShhJpJL+TAINQwoZiJiQuR9yoITW7t/s7Gxv/ZI153kRod0mKsrVAAwDEW6z8MVw5yiA/PxZiuqSgEgjWCGwZEiBx2orp8u2qUoi/MZqDYXJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741848146; c=relaxed/simple;
	bh=L1dW+WkJK2qErjeOxZivl2sTcN5KUbykHuN0wgmt3zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwDFQzhJQmegrCzJ+aeDjLpd/vyNOAIFTQqk2GOaYpdFklLRERB3/k/mDgwdiXEmzIZ9apfTXo90tGA01Fh2bZ4nkgpGx6wKG8K30mzZKHie9zVFnVnyBPXquFMcir1XhKl0ACq2afxhSXhlij6gVQOH6QY/c2YwaCimfP6/7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cItZmtyw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf251025aso5579761fa.1;
        Wed, 12 Mar 2025 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741848143; x=1742452943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Bb/WvokO3a+F9ijuFm3j+AhkORbeEOG67zAt8VEtuw=;
        b=cItZmtywcOMjr1LjgI2bBjVkOMmTmYPcAgkVeK0ohaqrTpaEMTsULRgC5UgqSd9nSq
         X0SeC1JmonU5nwZE5VG3Zb3Iegbm+CM7hUnRI6XTR4Nn3pMIac2/aoSYSaqws9/h/nkO
         lXgUSuCT3KQKt9W1/TwhOJSgqACh+LI2dv0nApjvulqPWkgqZauYvhI9/mslF3f0ZexL
         S3ogd90s8mWa0wXo0HqhmFN8IByvSrvOC1fQuiScTZflGVCiulL32UsPDKI9l5LEv0tr
         s6uq5pXzQaz2uiC9NWKTKhsLGsiuEA+FuRRIlh8nkz/hlt51fW2p9gawfUt4XQiqNhz6
         kXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741848143; x=1742452943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bb/WvokO3a+F9ijuFm3j+AhkORbeEOG67zAt8VEtuw=;
        b=IA9hoXYEXlMBCFzeT/67WpN9Ou06MDEm1wxwzN7NjL2u+9vOtplFSQgh78c0q0xiWx
         WwJnCya85YNEuWVNeH/CGSN1fSrcFNV7/GB+rE2ScY2qhaVsQRRH/TsLKkFFd29k2w+e
         ZaDVVCUwSWcIgGRXtmmeZQi1c40OTOF4Xnzh2vFOieDlzhdPRCvmNsd24jUTjzvw59Hs
         0t5wjbri05q8lHGdC2QkTuHbb1lQxwoMqn1Q32T0qqGyfXQrae+SGyEOPzJ5BNmrZSGb
         mxsjpANTovgZW6XIApegFKujiz3tAfCUN+zHt+1+eU1BteZwQfNfcxpF6skAqBxJZFOG
         c2SA==
X-Forwarded-Encrypted: i=1; AJvYcCW57c9b0St9kFc8oOiXVJr0Xbugz8m3LV2XfIA9hhRssgLQVtnQdlRuyhjLQvG09C+LdiVP6FjFFSHO@vger.kernel.org, AJvYcCWjdttCpvWCSUx3z0LlW8sdgpQ0Wtdm3tvtxT6IFdTOXfh9KTOqLhkVDf8KEygCXWj0dIgeDhtI04yMVw==@vger.kernel.org, AJvYcCX8kfNZ0/FAN4p1LuuYFTq2k0wkwcf59OhNDMuawmKpiujIeV40lu56A7NBpsCQpwCefV+b1+9n@vger.kernel.org, AJvYcCXSLm1SaqMtFgZ4APJA8L4PjHvm5SnsxzpEv8kG/AwfRQWmJyKP5+HM9OskrbIedVN8wNbLezt14mxl@vger.kernel.org, AJvYcCXSoVfNcZPw3xuW1QYEelAwb7QoZjc52ZSUUhlUK/5QrRlbdMbRrSSe78nAK3N3Am1bNEgu4ll47Q1z3Ey+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3K1799Z1VB7QgZc/HQUWGyrluTCd//YtbaLNE0XaBItq5qA2
	GSHqanxjJEGF320OyUS21e3e+wtK7sx5WOIEswL4jvUuSaIh/FxWSHiM0g==
X-Gm-Gg: ASbGncvPIxxbBScLMTQxcg7H3qI5TJApV4w12Rr22a58tyw1WNksc7xfjVNYp7+xLAL
	cGqJBD027mZxDBNm5Zkef2mJX/GZx/dKk8g1zbfoe6fbs7u4I8Eh6GxXPzebQhJwqzHmo4WJ4VS
	6/jnURsv+Kb+TlEueSgn8/50MAIwzmHcH8WYWo5YOSCq38f6Yf7Rqv8uNuFYCyUg8V6/J8Shhr3
	QXFHxGLH1/j7GeqhXDXV9K//Av19hOeuq0H7Q2kDcFtNDb+oVcgDImaowSrx1TH729c+B/qxt84
	Xwxv+4orRuof++3MTtxt0l+/ojvdw5q4bs/mQEtvpKbuygATPxOVE5twXKeNcCknSjudrKEGO7N
	AOLTOL6KkN86Qy043GzcI66SB2A==
X-Google-Smtp-Source: AGHT+IE+OmPAgLJI5hoG5MVo05FbMb3W5ebh03ZGiu8M6k6II9S3GFcUBywTrp6tUWknS9ZS93l0Uw==
X-Received: by 2002:a05:651c:221e:b0:30b:f469:47ef with SMTP id 38308e7fff4ca-30bf4694fa1mr94365151fa.23.1741848142350;
        Wed, 12 Mar 2025 23:42:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f100c39sm1094501fa.48.2025.03.12.23.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:42:21 -0700 (PDT)
Message-ID: <2cb99c3d-6ea5-4c47-9e6c-d1a3966ad7ff@gmail.com>
Date: Thu, 13 Mar 2025 08:42:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] property: Add functions to iterate named child
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1741610847.git.mazziesaccount@gmail.com>
 <ff924f640feeb87819d40557f12a04e607894682.1741610847.git.mazziesaccount@gmail.com>
 <Z872bHMRtSglB8pf@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z872bHMRtSglB8pf@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,

Thanks for the review.

On 10/03/2025 16:25, Andy Shevchenko wrote:
> On Mon, Mar 10, 2025 at 02:55:53PM +0200, Matti Vaittinen wrote:

...

>> +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
>> +		fwnode_for_each_child_node(fwnode, child)		\
> 
> One TAB too much.
> 
>> +			if (!fwnode_name_eq(child, name)) { } else
> 
> Ditto.
> 
> Note, I believe this won't get v6.15-rc1, so there will be for_each_if()
> available and these will become

I'll use for_each_if() if I'll have to rebase this to the v6.15-rc1.

> But see above the proposed additional patch that you may include in your next
> version.

Seems like you sent it as it's own series. I believe it's better that way.

Yours,
	-- Matti

