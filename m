Return-Path: <linux-iio+bounces-17603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB28A7A82D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 18:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FA2174E84
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14552512FB;
	Thu,  3 Apr 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qcI5+E/B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8517250C15
	for <linux-iio@vger.kernel.org>; Thu,  3 Apr 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698894; cv=none; b=EhMOHq3FMVWV3IWslt1w8mR3Npourh0mOVCuSRr7JieBmc0auFBFaopltl5Dbz/Uy6dyErgXmTxjr+aCOc7mUOntOvtDnmkJM6mue1NbKCZD3gTo5kZJaYbMui+KVGPXNIU/qI4VwE421g5KeZKAojQg67/j1wgIdF5a/fFro8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698894; c=relaxed/simple;
	bh=4wuv9Dt/9rj9cF2a6+xai4em1wNvUS1HPV5q6UbrWUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDugB5TiVZaCCU6PAiJVpZl04ueqfUc1MvF+4wVArkNTpi5NULtBW9T8G9XnntES+xOlYDr9g+HYY6wSuDJCfjwxAcMCojUPpAhUGPmFff95tqgKzYjMs8u3PrMnhV48I4I0io4sHXKKDTwnxcVZCaX7CJY2tY3KDgCSrktK9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qcI5+E/B; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c47631b4cso713343a34.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Apr 2025 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743698891; x=1744303691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSC+FUFy0d9lpIsypY5Nl8Mx6gi/Bcekgwf80nw84HU=;
        b=qcI5+E/BAMUqLNMLWOxjRN+MGmAaw/lfkN8AYIMxn9c52qcobC/3x8AiMyfeBpR353
         Ld2gtJnmGa/G9qvTeVl5TSw7ApYH3RnoFtC9uwxKd9QXy5QEXojXnzh6jQkq059ZaRub
         Ysrm+M0I7fmFRY1zFNV98+Z5cmhJCU+aM+0xQ5hpfu+OyMBZxm7SR/DWnyO1qQEKxv7Z
         VINdf5/gw0PmUbDPCwdwb/h3K3SiI+o3uKYFQm4A/mnAueisCrvCTiwvJD9MTOHmoUaj
         ITpfimb6PgHKSvuUFtzLIzuICpyQP6W/sL5i5JHC2qHIZCim6/e17TBTszKJIr/ou/S4
         dXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743698891; x=1744303691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSC+FUFy0d9lpIsypY5Nl8Mx6gi/Bcekgwf80nw84HU=;
        b=sjIV8xCk/lVm+bY9r5MNKRXVvqx0QcUdWpCMb+PSRAViQQlVXLbCxnCPGLD/34cO8p
         p9NROUOogJm1hHCC0OR0ZqjKz8S8hWk/nqm/5ob5K8nTDfCiGO3GRH6ePx2XcuHwqi5v
         KTWL4e5jrHj8TMPnoPkbpwLUryU4yWm28I0bMRCX8jqg516HHNqKTfWbnjrrj8ryDB3K
         TzUXgNv3RBdeQFOha7XvDk2G3adKAz79M5vtnqC40+VCMX7Tl4+PwIdosNspPxnJcajd
         LchLuyAEy4tp26Fn3OfCdWSO2k/cCAjN7omEL4aM9RchC69hGRaGTkQamDFOhUoFbEzr
         olvg==
X-Gm-Message-State: AOJu0Yxln1yABy8gG3wkFBAAZo1GyAiJvH2QOg/TGhhMlbPhzrzkrfHy
	tmnWcGgdidmgrHgpfHwSiiTMS9nZG1DShzwJf6Yj1eWvtvEOzhGFqdMjIN0MaWJkzgYcps6tBSC
	Kt2k=
X-Gm-Gg: ASbGncv0IDwmkntPQGOn7dBBypTWO3vYOAlK8SkJPiap1CExICG/8eSh6cbCPmMbhRm
	FpRp+Y3Hk55sTnC/SnLKLQcEJ9Jd2fDOUVgpNm9PfENZh3EPfE9JciMXHVYKy7HvY8yQqwGf5+M
	KcyAtmrMRNTkDYiFdbYHu25yhqAsVGkMnusJ7MdlC9OWzgSl5zHIvQqJGgHvX5hiQTFT1bdCUo4
	cYHBF9eDw99Sq6aqOXuZ6bM/soQx/IRTnTbY9hNFoANloKw2F0bB+zH+gXA7ZjnuvU8LI1vc0Br
	CDmNKClXmbAkSWafv7C2xzeDGncBfN3cscmkSo4Y4uZwDCGvvTbfuuoLYHgHEa/nhj8Mc0LiIcx
	B/ludJQ==
X-Google-Smtp-Source: AGHT+IHMO8mKj7XI4u0FpdUX8+XWGlKjBQ/8BZn9Gd3V/HfCKgUeXNkn3/hksONPqG77YFoErY/6nA==
X-Received: by 2002:a05:6830:4987:b0:72a:1d2a:4acf with SMTP id 46e09a7af769-72e3696f946mr147011a34.17.1743698890734;
        Thu, 03 Apr 2025 09:48:10 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e30511237sm281580a34.15.2025.04.03.09.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 09:48:10 -0700 (PDT)
Message-ID: <c146175f-6a21-4039-8c81-5933a9ef5ef6@baylibre.com>
Date: Thu, 3 Apr 2025 11:48:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: ad7606: add SPI offload support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 11:19 AM, Angelo Dureghello wrote:
> Add SPI offload support for the ad7606 ADC.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


