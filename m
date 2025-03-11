Return-Path: <linux-iio+bounces-16737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B896FA5CDEE
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E633A488A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 18:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20E263C9B;
	Tue, 11 Mar 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gPae2Q20"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4E156F3C
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717811; cv=none; b=ePtJvMEX+DCzzcN2DdCBBhtSXqJU1l1vW04/cIHUq+u2FW07q82rmSpWnPD2aYjujF7VZVIrCyYKtfQx52jyVRlk/7ouVvodjAdMOhgqBu3xRy35D7a1VnxNEnPyh10STq3VMzFPy89ifVT8Z0uXNVyza789t2lzlkoh/J9kZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717811; c=relaxed/simple;
	bh=Rsfs7gBLTsaonIFFdukwg2rXJ+LbIYSyoCv3NpwMtew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iar/ZjFLUHiNALYo+jDDejOduyPNxDixfk35uW/42LHNB/SuW1kIONJ8PcLoshqG/SmG0KzICCl2hVuvvmRp3HQJ3Vu20/YtBHRQpQUPW13J+NPFeem9er5Wo33sRd6kLxceu/P9Z91vbgigMwG1dyU4KUx58VX/cF5uWv6o4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gPae2Q20; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b8e2606a58so3039811fac.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741717807; x=1742322607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+eHm5686N2Cg7TbPXSmsUG2P4YhpcmZvgbKH0Fmbn8=;
        b=gPae2Q20cTJKTTlVnBLHXVLbOwhIBL/EOKvM9FlbXhbIytyVFEmbIG8XDn7GiWHMH1
         rcFJDXOK8/JqehuldTkNoxG7G49Kd4aR24jEnm3g8NgwoW4QzNByHob8Xyak82BvN7EM
         SbciZeL1WN+WoXsnpa13GVNFZESKYeuMYflzW9VHeQdJCj9g3hm1eV7te2/3dHKe8ClQ
         oFIPbOASXuZKPhyb9G2v7ivpkX2g0bishRXqWBwZJ62eKBthIlOsAMxL/iJGqTbqJFw3
         uDL1OfTbCMgaDdsWKAF9JQ4AYNPek02BdX89mHG6LqQu08tCcHJi+Ge9Qv0a/Pwy0F6o
         LH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717807; x=1742322607;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+eHm5686N2Cg7TbPXSmsUG2P4YhpcmZvgbKH0Fmbn8=;
        b=RG0zKAE1rDriASWohmnhSqFfzPKqia0+58OY6BmFfskxPa008+Q3fYRNwKWnHcD4TL
         CrPjtbqeVzDfABN7LzvJUkbr8ycTvf8fXLiP/xrLO/Kzc6MPLNvdzB2Hi9cpUIpAU7JE
         6c0l/Jr3g6cO3+o4ulAvK0Y+trS1lDjuT5lO3I+TLzbQE0d2/R7FlJXEmWMztoCxittD
         36MQyG1kMWjsFvOgdJqnLcpSxDBu31M9TVZITt0MX4oSGqQY4zZ4/oAFL5ksCix67LXL
         SpOm8VFh58kgY6MHnHMepiy5OXUrx5i2zlKtpKVdku11LTqm8LrQcpyNg4ig5jF0/R37
         6JDw==
X-Forwarded-Encrypted: i=1; AJvYcCVqeqBWVOFRKCPq121z9NCBm+zkbgRgU9CNC2sbmmTdGnFA/3BLW6oaVA5TWnWkmARtoMxRyhVvkcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmZvPE+jY7HNSnE1SI/CrV2csTSCuL+uoldHKa/dDCDpd1bnV
	kMbNrhhJSDy2f8d057/D5RFJMDrGjo767BAbPKNLOogLJ5FKvxCkoD0ukkcfhPU=
X-Gm-Gg: ASbGncu1XSeQi5ZT4+lSY18YNH5e2TjtzcBNuXLKQQB+wMbDXKoj0peKHPETuEQi++a
	kTWnGc8B333veQgSxtO6SWPtIaG4VzpriObP7f42Dz2NEZO9SaOvvrC1VteIBVx+bAIoGkLSoDg
	UXm+1sP8KogJXd8fV4uJngTpURUmcU007w5TILe8XthNU/2HHeRNftqatrtbv6mbchkGRPsPh+/
	lbfrOZfADG5lgApIhqG2nchoFZPy41zHZcnTKvhVKacO7loYlIMHUBrCeg2hN7Kx5rvnefrGWrt
	TLGmdmmOpfD/8LzpCf/7WzXtlBUmUKWJtt96IMp3KinkZX77r6vIceY1WOvSawLPPc64SX2RaqJ
	FLIhKwA==
X-Google-Smtp-Source: AGHT+IGjIZ0Y/xr0AbOftkLR6zL0Ei9LazTQ/mmO20RpG+AN94hzqN6prpu8QdcjlnoruXu84xWUuQ==
X-Received: by 2002:a05:6870:7020:b0:2b7:f58d:6dcf with SMTP id 586e51a60fabf-2c2e8771aabmr2601639fac.18.1741717807745;
        Tue, 11 Mar 2025 11:30:07 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c2d2702b63sm750927fac.15.2025.03.11.11.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:30:06 -0700 (PDT)
Message-ID: <6579eac8-45ec-420d-8e45-6d3759f2e7c0@baylibre.com>
Date: Tue, 11 Mar 2025 13:30:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] iio: accel: hid: Use iio_push_to_buffers_with_ts()
 to provide length for runtime checks.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
 <20250309182100.1351128-8-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309182100.1351128-8-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 1:20 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new function allows us to perform debug checks in the helper to ensure
> that the overrun does not occur. For this case, the length being provided
> is already passed into the caller function so reuse that.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


