Return-Path: <linux-iio+bounces-17535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED218A78807
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B027F16E2DC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D4231A5F;
	Wed,  2 Apr 2025 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7eCWTdN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9E19049B;
	Wed,  2 Apr 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574764; cv=none; b=o4IyHnf4Uwf3bn5sJcwAZSnjL81Mu8Tk9Ddx4eVUhkqnMJyvqWtwFBJNsB/iXrcNKHrOO8CKfg9pW1UUBs2bxz7/fZC9jT8xNbKkWHbQcpccBk4kCgd6SlwRZPSyCIbtZ979pweKupCbtA4fxVMEu+MclFdL6N2+KyVOCXntoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574764; c=relaxed/simple;
	bh=/O+85BnaoGBCaBSzR4+1LSwUl9x3RD9LxBl8BVrlbxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3Bsww3ON6Fm12xxUt8m593lPwkSxNdFmk3xhyn7+OwJFPuCg+A3AV0MTKV8rsB6K8iRVauWkxRz2qSA0PjviOiGZSJMFeR5CFu+TYUMZvT6/kb2hm40StHi+hmdofoqcyVFqQ+vdV2palFPU6r5NDTQITsIaF0f28BM9Kw+m6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7eCWTdN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30c461a45f8so65223781fa.1;
        Tue, 01 Apr 2025 23:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574761; x=1744179561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfaFMRwGw5+O+DHOb7TQ0jQLanFmpXx2Thui+n/Fjs0=;
        b=G7eCWTdNL3XJd/t75GrA0QWIsU5Dohj7jiIKnPSrgVv4pHJw19eJ9bqA3fXxH/kTvU
         atg0nEqklHj4B5uh5CorTkpAEdYUXFxYIaOLxyuU96ALwSH4p61B1etGq1gRHquR6tx6
         1eqtD9FzgBe/bDiFZP+hudLbPy3xByju+IaMlQCDS6VR0nwDrlGHht7W2TO3xQXeuxWH
         OP+KveyThqoh5CgTkSKcGfdla9H/FRsCCZToBOemRYLHT4e6y2RBGuvyxSZsHdx5g1MP
         v96xpYWzx7WVdOuqlqkx5qzfX+IcqD8tg457L04aHinC66ZQK7Ts+YzsV1cpeyM3Z2OD
         SXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574761; x=1744179561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfaFMRwGw5+O+DHOb7TQ0jQLanFmpXx2Thui+n/Fjs0=;
        b=IWohgmALuLN0tw1NWTL7nu6vJsc62lPPuKMfaTGGzwZwfBEC45n5gGKSvVAmeK6j2i
         l8NmvUlCaVv0abRO4mcTiyJSYBpg4CjxNfipK/HxP+B+tXSh9OuR/e9uFK1A6+o10Vwm
         HTp0CsRDtXuALwdcuKIh71bbUVcZOPqBXGZIEzXVWiLhBaJy0xBn90TITURUfBnjNIyT
         /+L6pu+hWgocP0wAsdIQEvkg6Beq+Ocg/CMOukqK1DI0f4ThixpQlTcWHoJOPwKrMl7x
         Q0ZQKRjAv767R11eeXun3Zv53LjV9yHR0DDq+2BB0NkcouSq9vu/D19pLesDqWKjNtlO
         J2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrd/F85zGglcDBy6k1oXkCneqcS7w7kFRWKorkAYKkpqefS6Cn4/TreXEbvmWQXqUsWclsq0hSlSfK3Lwe@vger.kernel.org, AJvYcCVa3RW/rJXAHpnq7g602y1OR+mjsCtMtRTbfxu/sBW/f9a3ZEpa0wvoiszb1bP8fWZxcOYFQqfi+Bwk@vger.kernel.org, AJvYcCXJxHm8jj3snQPZpe+o/BiImQ90CEM6QOthnpHmHc9P+PJrOXB++h6sqvcQJ7ZJn6rYzV2OU3WE1ItY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lLmj/VeAtNDlRdKkuVFf+Z3SrTGgNPohvOidEic9JykpaYKg
	YYcGV1Gda3yi4y4iucgpQShz7iKs0EgGltDM/EPRXPC9pTtDw0fS
X-Gm-Gg: ASbGncvGfR5WMMird6pXBSFLw61UEcndvFysKK0z/oWdQaSOk2bR3M8qqk/Loqe6u/N
	IcISTvgKhy9AWUwhbBE3XGlCRHq/dtSzN9VoZxg+jmMsDMsWI8C2Oia/kne7/SCAEuYN7p70aiI
	rAjzUXqcJr19wEp1HOTPUv1wwER58BPmbErTJxVOyNTc9/cu5wB5mEF58ut/p1gbY6xa1Vrst1M
	p78o4whPJtu59eYtQ5v1WHyxrBywDhE96U+CAqjqVXX5fXQZdzlXhVmDSmmBt5fMza9274svlOu
	VTxFvn2VHKEj6Q8AE530jAe0CYmIv2TBXbN0vhe2LcZI7cklzlDlhg6yzQlY42rZkYry7q5lhcm
	ps0I0C0ODtnvddSEd/ss4C59AJw==
X-Google-Smtp-Source: AGHT+IH2jRtJVwdfBfrHFBkvllTlcpUzOIl2sQMaX3D8x5ocViiGU7bBonevsHoicIaUmxzE/WGuzw==
X-Received: by 2002:a2e:be1f:0:b0:309:bc3:3a71 with SMTP id 38308e7fff4ca-30de02f6d3cmr48376871fa.31.1743574760581;
        Tue, 01 Apr 2025 23:19:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2aa890fsm19614811fa.1.2025.04.01.23.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 23:19:20 -0700 (PDT)
Message-ID: <6acb2692-8946-4ab2-b433-4f68c080f6b9@gmail.com>
Date: Wed, 2 Apr 2025 09:19:19 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Support ROHM BD79104 ADC
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2025 09:07, Matti Vaittinen wrote:

> Finally, I didn't find maintainer information for this driver from the
> MAINTAINERS file. I would like to add myself as a reviewer for the
> driver, so I can stay on track of the changes to it. AFAIR, having
> R-entry without M-entry was not appreciated. Any suggestions how to
> handle this?

Jonathan, I suppose this, by default,  falls under the umbrella of your 
IIO maintainership. Are you Okay with it if I'll add a maintainer entry 
which sets you explicitly as a maintainer for this, and list myself as a 
reviewer?

I suppose I could also add myself as a maintainer for this, but I am 
unsure how well it would be received by the TI people ;)

> This series was based on the v6.14, but it should apply cleanly on
> iio/testing - please let me know if I should rebase.

Just realized I forgot to update this. The series is now based on 
543da6252b48 in the iio/testing. Nonetheless, I can still rebase if needed.

Yours,
	-- Matti

