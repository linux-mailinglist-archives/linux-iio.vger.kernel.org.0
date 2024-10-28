Return-Path: <linux-iio+bounces-11427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD99B2991
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781A91F25CC7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1651DD862;
	Mon, 28 Oct 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE8Lst3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84321DCB06;
	Mon, 28 Oct 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101381; cv=none; b=pZVCxXn8az5dlKQ1o7U4K+oj/UKlSZd1/a3ZUmuUL0LkhzHQRn9qQLq5Djctc9yStv+n5+rVLnRJ89lhxoh7J6q88kV/qniZdgeVQJqejqNGzrfYWLH7RMqN9MDdFwW48ys0HdgCRTlldgS9dLPy51uDjnT6KHmWwk7Foa8VMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101381; c=relaxed/simple;
	bh=1eDgzVcTXWc1NZbaVnSW+JVBR5kRN32nfImppOd7MVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOjl6HCvwzTYrq54k804ThYAgPWmostBLNDdrzi08rQm+stBZ6hFKSKyB5BdQLEUhuPHKotdoivptq6AhEL5zwKyDM9snLSF2cNFThWEXsXs0vPrJMHK283H20RITaUv3Swk68v9kSxBAw6t+TjnqEt3L7lDcQmec3rK7pMqIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE8Lst3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2128C4CEC3;
	Mon, 28 Oct 2024 07:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730101381;
	bh=1eDgzVcTXWc1NZbaVnSW+JVBR5kRN32nfImppOd7MVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vE8Lst3CufJY1jtdyKFMFFgihk9hVsAA4yAkx2+961RfDuZq4bVmp3Vl/cwc56kct
	 uAhqV8lLW0dyDPFhTl2mCM7MUbLltGFm0MbROZZIwBc1Q3CjmfcMWrDOpNvuMADNUb
	 Z/2U/kg9/I/peueNB8DYVUt+wF0EQAgqHJA2SILYrm9m9FxYiHNw2HU+Z9K2lGTGVK
	 BD4Vgs9KfHdhjFKA116FxLDqAo+bCQ40dOQ7Mx3C3KuHkSM0Nh/k5dP9hfcTgSA8WT
	 DN51Ha8Dgwq9oqgn8oPHWCXvOWI4sMVY7nQbUpX/rVq4fsoohcPMZekt1zA8slJZri
	 dG9oScX6d5X3g==
Date: Mon, 28 Oct 2024 08:42:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: ahaslam@baylibre.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: dac: ad5791: Add optional reset,
 clr and ldac gpios
Message-ID: <kq3lylhjgpozyp2ts35dntoflx4skx2znysjljmgbm7qz62vvf@42oyeum2un54>
References: <20241028071118.699951-1-ahaslam@baylibre.com>
 <20241028071118.699951-2-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028071118.699951-2-ahaslam@baylibre.com>

On Mon, Oct 28, 2024 at 08:11:13AM +0100, ahaslam@baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Depending on board layout, the ad57xx may need control of reset, clear,
> and ldac pins by the host driver. Add optional bindings for these gpios.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5791.yaml   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


