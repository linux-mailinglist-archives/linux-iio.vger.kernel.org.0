Return-Path: <linux-iio+bounces-16651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98FA58BA1
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 06:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4689F169E24
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 05:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0511C5D53;
	Mon, 10 Mar 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5TZhWVl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB814F9E2
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741584086; cv=none; b=LXxlzMemVkrqh9B3O39TeorfatjAWT2mcpDjBRbMJThtv/15yOL+V1qlX4mUe2sd72IFELCGNeLfZNlKjzMZuqsBE9QsWqHi4UqKF7CtsH19GNpHdqp+u7cS/mMdjjRCaqysfZ1qz4haoYSmGNy/7giZZ9Woa/4Q9M7jkDviCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741584086; c=relaxed/simple;
	bh=HYjqS5yx6gJqg5Pn9NLklw7CuLRSdecwqG6AQ/7ReEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsHEQP9Ngpu4cuyaH4/Eo0IH6s31RXUhk9fkXFSNDk/s+Q2yIHL7fQ6QhDksGchgLal0p7fYrzn7FwclkYa4A938j0JPAKSdOEdEZCqgLKf62HMQ6i4ELErcKTjqzC+n6p7JopfjyGhFR4MeBMiUakpc01+RMKR/bi+kUT5r5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5TZhWVl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549a4a4400aso646623e87.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Mar 2025 22:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741584082; x=1742188882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xgm5NIKCXFz09LrGYANY4bLgNof6mzektrBqcKtmDy0=;
        b=Q5TZhWVlhvklg1Xp54RAkQnuWlgzzoKlrKsm1PjWyrUiU/rvrdv9kAR7uvsB0GWtiv
         Yv5nc3BXkW+h8TWYBBYVetJHna1zYgg3uc1Lh31K6Gfz3d5wjK0gactzIOfVXdAwNUew
         R2NOi2DsPLC5svCOkMpIlQipYjgNFcfEvbjU8ry5SUWsd7/umS2xwRsZzb6C4ZPCOxom
         U8+0uweKDDONrE1DSQSnI8suwxWxin2fBPtv1cyY2r85XyYfFvZ79B+rQVFuZg4IlJsY
         CXn9ds+SdalRZDfO7w/W/9i6+Y2sGYg80gPfypvAWtHl1KwBbe7fPIMmoQHSD3tiGJyX
         KNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741584082; x=1742188882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgm5NIKCXFz09LrGYANY4bLgNof6mzektrBqcKtmDy0=;
        b=kU2rh+n5cMWWHDtVxyDNr96m34/PNq1TLLOKJ87D9IkCaz+n1Wsyl4WCgk74ilbDGJ
         fyuoShvz33qs4a78pLSEE/+Nci3WtOe2jGokA+VbgYr5tQ3pDnwzY7IBoxhCgnoQykIf
         AZ71kOBJbv/C6Oh63O7M/gYQexFP2ukkjRVXycCwB1+ScRJOTFxddCkR04q3cyfrbN3K
         vBLHEfmnY1rDqO+Vo2jHT6pXu3XefPW0iVnPi/RNWGrzVHMipSR/xuhtlCE8ZV2XM2Cs
         x8ZWuCTkeN6PfMedrkkkGfteRUuu2ZxZb+yuQ1XlD5aYYMxa1fezc4AcKvoDp3YIZ500
         mEcg==
X-Forwarded-Encrypted: i=1; AJvYcCUB/RRpHMOYEJFmfSzSFuldYW6dColO8djBfofFWaQn5Ks6xeFoJ/fKkx1XcC7fkPjpBUAbtwSw2M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbheOdo0Yv8JbRAu+zNIUr5EB6ZJxcfNL8DUkXnZyIlvp9wtCv
	fzUbS8AhmRGD6bNCrmyYYG4jAahQCy8qLu6p/BhtaWL+x0KvITrd
X-Gm-Gg: ASbGnct3SIzuiPXw2NEPWQeTEWaWux4Asm01qpCtDc0MzAxROp7LFhriRpGckm0aW20
	ZLIjaOhETMpzRZTCmFnXFCPj8waYzn4LtVr3ISTvnGCiGfFjSjPfE9Llpo5NZNJaORoIHA1Oa8j
	QizRCOvEFKOLR41tFqI5ZSLuPJtW9O+9bAoJfCfAWkXSRLGnaB2o1KTADPFNctKrnHVPS1O9fko
	iqsnQtpeVOt9hGoqQCtkyZoKE8TYyYwlPo8WbngRpO/W7+UcCcReRukTGDKvrm5wKWnpOFH/Xih
	Yx8LwscgwFZZbB4LiD8LZT4lgcisR5fn8PpHNLHNFZCF6//ksgUr/ISLKlhhYYO4+gT+peqNa0w
	G0hANABHwMOgX/Pl2DKPakjTh4/8uEaZ2GkIZ
X-Google-Smtp-Source: AGHT+IGVi7hozAfpmMjOxwf/9akHkabj7D6wkRQvaTVfKJQ/f0grYtDe0YYKnF7o/CYoC24dkbgqew==
X-Received: by 2002:a05:6512:3da3:b0:549:5769:6ae3 with SMTP id 2adb3069b0e04-54990e29bdamr3681046e87.6.1741584081752;
        Sun, 09 Mar 2025 22:21:21 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58de8sm1332713e87.91.2025.03.09.22.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 22:21:21 -0700 (PDT)
Message-ID: <c5d8a2cb-560a-4e2d-805c-8a0d321c70bb@gmail.com>
Date: Mon, 10 Mar 2025 07:21:20 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] iio: light: rohm-bu27034: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-11-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250309170633.1347476-11-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/03/2025 19:06, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	--Matti

