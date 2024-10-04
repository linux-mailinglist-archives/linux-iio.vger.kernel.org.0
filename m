Return-Path: <linux-iio+bounces-10108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3998FD60
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 08:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA72283999
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 06:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3617612F375;
	Fri,  4 Oct 2024 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0+U5XMa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42D12BF02;
	Fri,  4 Oct 2024 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728023568; cv=none; b=m+N6xqO54bErY4TTtsAxQeKtlxKXmLRTAOC81eVVqUFYMcf0Ac6ZUgFrJMYcu3uNQjYONct0gmuFKrFsWvzf3/QWMbaahKFosSnkGA1sJVu1dmdb0c2k3E+sDrINYrQ6uzlFGCmeqNShqIioPxpqCCSQEbzueOzM+dD8QPzfx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728023568; c=relaxed/simple;
	bh=zsrwiI1wB11X582UAxpW5TtN1oIXesMup+Gsjlys0W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvW4conWRlAMcTezcDkNoJBdS0ZN/kZ+saCkyz8nsO3cxYG07H5SZjzDHmSkMeYMKGxYtFy0f2BZQyNgBRlGDxl+D0C+iBM19xAuySVGPW+Nu37tHYHE2X6KizFOt9y6gZayiNhJ/Vw7UjUEdDC4xnBDAprNAqZ/CyklSClY9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0+U5XMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66659C4CEC6;
	Fri,  4 Oct 2024 06:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728023568;
	bh=zsrwiI1wB11X582UAxpW5TtN1oIXesMup+Gsjlys0W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0+U5XMaXCMGz/gMW/5FLHfrZuWojeoeigqTJoxWQ6cUJMcwEB78Yyfr2ivZ/6Q7D
	 U7532IfwRootOm2BYpvKLk1j7gas6XRIc6HDRpp37J5+R1UzS6+8QLStSvek82QeEV
	 UOybf1YaNrGDwv43xzznzWjTzfaUyn8Tr7xUfQEbcu5vU3oxv2rz7/oy7fgO76jxHM
	 pT/XMHkCchzEw7+SJVkkPtwpOWRZeKwk/etz3LRZluyKrakBrS8lMji2BU3+1j1H/G
	 XAJ2cBOXziIY5MmEaHGQ9/kL7/ROQAjeuyDDEAhwrelDpPclcCtZAmZh+jIyM+1PXt
	 EId8c8FCauTUQ==
Date: Fri, 4 Oct 2024 08:32:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mihail Chindris <mihail.chindris@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 04/11] dt-bindings: iio: dac: ad3552r: fix maximum spi
 speed
Message-ID: <7go4qwudlt7babgqden6bvvtujcwq5bunnv7bxpswktqhqunkn@ertqtu65uxov>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-4-ceb157487329@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-4-ceb157487329@baylibre.com>

On Thu, Oct 03, 2024 at 07:29:01PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix maximum SPI clock speed, as per datasheet (Rev. B, page 6).
> 
> Fixes: b0a96c5f599e ("dt-bindings: iio: dac: Add adi,ad3552r.yaml")
> Cc: stable@vger.kernel.org
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


