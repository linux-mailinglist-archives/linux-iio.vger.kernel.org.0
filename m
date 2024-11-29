Return-Path: <linux-iio+bounces-12803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD99DBFB6
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 08:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798DD163E7D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118E157A5A;
	Fri, 29 Nov 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWEiigeF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701445C14;
	Fri, 29 Nov 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864924; cv=none; b=SVtSC/a/cAtLGi5NWPl9OTrYh6UyuSjOwdqZtNix6q4Q3qK4puQ2nyZg7ZsBUZ4WLQoIGgws2JkW+cgemgP6+ORdgj3qyByzPXkq/ayg+PDNrcINgwtAjhIdP0b+tcE5z2tYNKj49hy8YQiAIwZia9FWNgrFvNWs5tSPJ3Jr9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864924; c=relaxed/simple;
	bh=76hZVwBZvCGmU0bPYDS8dzcF5kCAXdv6cO8VPDIcN00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq6CMBZZiah9xV3SyMIj6MbCL4QKo0GEUZf8Aj5JnhKrBBB7Wuh8y0ZoMDdMC7RblxX+swLLQYSXk6MYqsp8MItlYhKkmDR8eRHdo6uPtdsmJS+fiU96LoM8+KhCkm85HzzU2Pma64IQwUP0g9VnvXuPWaMEU71Aa8FEIbYCYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWEiigeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBA1C4CECF;
	Fri, 29 Nov 2024 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732864924;
	bh=76hZVwBZvCGmU0bPYDS8dzcF5kCAXdv6cO8VPDIcN00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWEiigeFTxu0bEsbdsVfB44S45WtyJNBYH9nlXgrZhR0oOgw3XQMnclki8Nn6Shti
	 Z0GO1MlaNjUOLxtvNwqBMs5ISXq4lkd3E8Sp/gMQwL6VyWYqX6kVlnvyC5KHZleW28
	 jA2c4cz/VC1te0P1WSSuzbJ4ObrLWX+65qTDRs+ctsArBziE7E4u54rojG+fbCV0wp
	 QsqJRQp2vc70DVqI69eog1tP7toZLniAfmSL4O7F7EV0Utur/wJNvpXTNeH+Q0CrO1
	 tN3AETZk8fOMXoGhvUvd5isnEPYDQIpNQPgTmldLSM8qzAZx9W5x6IzLH+1dz1QChL
	 A7zxwNj+XLQTA==
Date: Fri, 29 Nov 2024 08:22:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, ajarizzo@gmail.com, 
	ak@it-klinger.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI
 interface
Message-ID: <tqemkmoa5cewpfxkaltkxj4upgsonjm2br5pwmv7rdmz4gq4vc@2r522tx33gzh>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
 <20241128232450.313862-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128232450.313862-2-vassilisamir@gmail.com>

On Fri, Nov 29, 2024 at 12:24:48AM +0100, Vasileios Amoiridis wrote:
> @@ -73,6 +77,19 @@ allOf:
>      then:
>        properties:
>          interrupts: false
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:

You have just two variants in this "not-containts", so invert your
clause. Easier code.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


