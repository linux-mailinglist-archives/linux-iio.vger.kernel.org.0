Return-Path: <linux-iio+bounces-9232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF1A96EBDE
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 09:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6FE1F230C3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A114C5BE;
	Fri,  6 Sep 2024 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbpfNpRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC914BF8F;
	Fri,  6 Sep 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607356; cv=none; b=fPIh4qLeHt3BVriCd3Q66A6dlkflBFKOVgFcRldmRYn9+R0F3qmqE4PM2jU0IJBSm+6m7KVP5FNvItDhKfMLA8I7PApw0w0UdGdY32p7EQBNw07ii8bzdjhPAm3XNtdYzlhTyUGIMlDn4V6uN8/qx3/nq1MBM60brliO0WTQ7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607356; c=relaxed/simple;
	bh=B5zVNA/2sYlTsBZH+KhjreeyxvuoWCE3pricHYUZNOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBwx1DHDdT/prVK0qfg6H9E6O6JXx/YRjcmD0UkMIWkVd3+hD2Zj2aLCnNfIl3CK7bgzTYyjgoZa9ykbqaAc1EjPTLgf4RX1iQ7bK2/N6Ba34bNzyUblDiCWkrGTgbed0yBgijNPxEh5B7OZKwxXUBZ+hGg3a3b0qTQUyy/n3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbpfNpRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928ECC4CECA;
	Fri,  6 Sep 2024 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725607356;
	bh=B5zVNA/2sYlTsBZH+KhjreeyxvuoWCE3pricHYUZNOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbpfNpRH6m3r9Dud2K4yNh737u9tVSMCnE1kY3kNScpx5xsYX9g1mSZARvq3MPSXx
	 qyiT+m5aQ4u/91N/iM4UokpKmK+Q8ubPizwwbGJdMqKeH2Zq2itRGB1DQcek8gY7Jf
	 sKhUELTrAJpK07FAV7zJlnGcBundqmBm92LTakTu5T4hcRkGUSf7xd4wqv6AW7eOpa
	 AkXGx+HNxdnsUGMKzw4vX85ZqkDEIDTyNaNV20F4i1UbIxj55f3kc2UiT/cEHmKqwe
	 S/FvjyfcbLqO6yiG6PGZeke5XPfbBI+vUg96J4/YaM6HerR73KyqIu7686LpeoetYJ
	 fiIKtQRvthYUQ==
Date: Fri, 6 Sep 2024 09:22:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible
Message-ID: <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>

On Thu, Sep 05, 2024 at 05:17:35PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add a new compatible for the ad3552r variant of the generic DAC IP.
> 
> The ad3552r DAC IP variant is very similar to the generic DAC IP,
> register map is the same, but some register fields are specific to
> this IP, and also, a DDR QSPI bus has been included in the IP.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> index a55e9bfc66d7..c0cccb7a99a4 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> @@ -24,6 +24,7 @@ properties:
>    compatible:
>      enum:
>        - adi,axi-dac-9.1.b
> +      - adi,axi-dac-ad3552r

I am sorry, but what is the product here? It looks like either wrong
order or even completely redundant. What is ad3552r?

And why versions are mixed with real products but without any
compatibility. What does the version express in such case?

Best regards,
Krzysztof


