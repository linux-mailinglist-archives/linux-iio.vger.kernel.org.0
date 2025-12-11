Return-Path: <linux-iio+bounces-27026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5BBCB7199
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CD5D301EFEC
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ABD31A56C;
	Thu, 11 Dec 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJwriffR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE246313294;
	Thu, 11 Dec 2025 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765483062; cv=none; b=Jxw+b/jO465p29yZ/cnNLCb3k30wA8veDdR8kik9jUT41HdJO4JmBC2Svb2jcPcD9v9Es3C0oOXRWa2z7iMFH3faI8ZEJVR4PtbaCnfgwD9X736B2kBX4VAmfQgPPZys9L5RgN5FFTr+vk1qchB5u3iLpcCwN0YGVmQ31zulxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765483062; c=relaxed/simple;
	bh=Io33r65MkdLUI5ebj+eMtKFDPiobvPbUbAdbp66gtmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsT2cIs+ibn0aZoj3XueGsg2Jkpq3Y5ZRijYu/osJDNNFErMfbFDaMUiXf2XO7eoSskhVR2M384Y/6lzx0Tx6qWeMv89HIFOnTcYCOYQqI4mGVvaeFGejtoE0SgV2kYpGgip8w9ThYwr/LKbSI7KG2IyF4dp+uhfO4BtC/DqQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJwriffR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D7EC4CEF7;
	Thu, 11 Dec 2025 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765483061;
	bh=Io33r65MkdLUI5ebj+eMtKFDPiobvPbUbAdbp66gtmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJwriffR9MxTEwDY8BFqGcfGKTyA9NAJZYyNkQxepc3ukZDkbmlLiKZnUuUg5BdpK
	 +rDsFiU20ettgn8YFwTV59q0fKS8i7z9iiB6wl+9lzfRWDAY/Zuj4Y/Myg+zO3UmsY
	 HS/D5dGWLaGcK0X3un+3iTS7eoW1xKKfXGc9h3rIp/GFfx7Q9KASCQ/D4K+bwv5BiT
	 vvrB5Wstcdhi2i18vI+CBPhTlcSAulgmYvhh4QripX7dKRxdFeZpJJASdUAP+stp7E
	 cwsxoA3FUK02G6cbNXED9jumWAIa3H3gqGjX6KJhTwSD3zJwvuwBIbP9LeRKtv0Ecx
	 QUk3WGja0XMpA==
Date: Thu, 11 Dec 2025 13:57:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-hwmon@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC 10/16] dt-bindings: crypto: Document aspeed,ahbc
 property for Aspeed ACRY
Message-ID: <176548305816.1801207.6301308659120970227.robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-10-21b18b9ada77@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-dev-dt-warnings-all-v1-10-21b18b9ada77@codeconstruct.com.au>


On Thu, 11 Dec 2025 17:45:52 +0900, Andrew Jeffery wrote:
> The g6 DTSI already provides the property and the driver errors out if
> the AHB controller's syscon can't be located, so define the property and
> mark it as required.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!


