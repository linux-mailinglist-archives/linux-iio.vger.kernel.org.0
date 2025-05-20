Return-Path: <linux-iio+bounces-19727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FACABCF8A
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 08:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427C317B422
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 06:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37325D20A;
	Tue, 20 May 2025 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/EF+EBc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565125B676;
	Tue, 20 May 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723301; cv=none; b=cY8vtXJEDzNzu2CVKBVY5iBE22pALCWicwLjb3ijin5uRkqzKl2V2XP6UWILQ2SeacdXSLPUtlj67K3+y/cU6lEx0RQlYaZyEgCFy1hms8erUnrPZ9vcFT+nZHSoQsv1lFGbk2/ihRTNTxKThjNis9ktDU/0nugN2v7bv2+3vaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723301; c=relaxed/simple;
	bh=/+NmpADkpF28JD+36C3Yf9JbclVHgqFpN3rsbxacxKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTTugkVwPF4KaGGY/5hY6tpxeKSCszuqgHmS65gk4dCHnhN/bJP2UcAg91Z+psMmCqlAhHAVFm2myQ3P60fyQA6HMpkk3/BENICt6iL5efMGjTWZ0dOsU251Cs9wOUXq0iv73ULogmt05MSj3CEwDNnRmArM0ZgKlEj/Rqhb9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/EF+EBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17991C4CEE9;
	Tue, 20 May 2025 06:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747723300;
	bh=/+NmpADkpF28JD+36C3Yf9JbclVHgqFpN3rsbxacxKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/EF+EBc/zb4Z6w+u2Rf9Feuw/oLYntUWhq62CLbjKFajcvseQEQfJsvG5ZIQkyK4
	 MpFAHtYg12VMs3sJiWRL40ZPjsBEEgCvwllLw9Ow6GVfYdMHmtx5+iI1q758exi5fJ
	 7Xpz7qRR/wOMvUEL9XRVSAzugm1CpK2euYAdE8GxNc7M66yzk3MdSD/GvCqWFAB2fu
	 hx/t6b3LuNqUIGyihLwxZgKrQxh7nCejdT6JMVOkqCdar14ZRHUscfSht5HLp9Pn/y
	 kJHNfvEC66bTE1OGFRqml0lyIpOOCMI3odglaa7I3vT5L4K7jhB/xKOo6UboJaRNGX
	 g1GUYjVFY9b5A==
Date: Tue, 20 May 2025 08:41:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: iio: adc: add ad7405
Message-ID: <20250520-marvellous-taipan-of-agility-c8a7f6@kuoka>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
 <20250519140220.81489-5-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519140220.81489-5-pop.ioan-daniel@analog.com>

On Mon, May 19, 2025 at 05:02:12PM GMT, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> no changes in v4.

And v3, v2, v1?

What about tag? Can you start using b4, so such problems won't repeat
plus you will have appropriate cover letter with changelog and links?

Best regards,
Krzysztof


