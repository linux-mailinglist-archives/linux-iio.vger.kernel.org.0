Return-Path: <linux-iio+bounces-27052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F32CB911C
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404143064792
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51331ED63;
	Fri, 12 Dec 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNpBb7ZG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE556317711;
	Fri, 12 Dec 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551995; cv=none; b=GnkUrA7lJS4ubdmSqTRKixbuF1dWjE96P3oS3lsXepHeHx7Tpf7WQfL9/rd/F3gcQLjerxvlRWEwSUXgYCOXZ35FEL3H2MH9g1t4HkwuOKG/EXYROvvkjJSQ41DESPHTuj8Hn5qVMZ4wVjY1p+BFydsPDKOBEhhVL5Z6Gz4qoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551995; c=relaxed/simple;
	bh=i6MeqSZJJ3hHFz2r4+e4b3P7T9WrW1v1WkoNCvc0ZZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU/4OtiGJUaK9erzQhnxsTTqpImo8kYeDRU7j6ghrNmF7Svl0/pOVpf5R1vE4om2BWy0bxIWPz+T2cBNZpLHQ365C6HA0go7sdqxXgE01YEl2wsn5xHvBS2tw01uSuRyBHWHFVy4nCOyYv/lVTph7HYLGkhGxdjFu2VsuQR6eYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNpBb7ZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12611C4CEF1;
	Fri, 12 Dec 2025 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765551994;
	bh=i6MeqSZJJ3hHFz2r4+e4b3P7T9WrW1v1WkoNCvc0ZZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNpBb7ZGqIVlmaf47k6ev2T4JjXdjAO+tcbKShFJsIO55k3KtGbE03/P7Svf3km2w
	 N7HxOvFwRaYla6WM589pL2VAM0U9dkquInkkqDc4rd5cwldPZhGPVk6YjPrL5BfTkw
	 OMrXAPXy/3HJ9MxzbyS7SeN2BzR/tFLC1uSU6dV72zAX6zZq+182FPtOI7Ulu6JyaQ
	 v6Hl59jMGME7mGMvO7nAvG2EoQDbMGCC+PLsGJXMz0B6b2YoQJQQDJMgWrF++vtmBy
	 mh3LZTJwv+O+R+frS4ZeyU+/czISRuySQ/llWCRnjLNvM+tqiSK517M7+UjOikTVk1
	 r8da6U0nOJsZg==
Date: Fri, 12 Dec 2025 09:06:31 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC 00/16] Eliminate warnings for AST2500 and AST2600 EVB
 devicetrees
Message-ID: <20251212150631.GA3997751-robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>

On Thu, Dec 11, 2025 at 05:45:42PM +0900, Andrew Jeffery wrote:
> Hi all,
> 
> This series removes the remaining warnings produced by `make
> CHECK_DTBS=y ...` for the AST2500 and AST2600 EVBs and their related
> DTSIs. The tidy-up has the usual benefit of making it clear to
> contributors that any warnings are likely their own to fix before their
> patches will be considered for merging.
> 
> I've framed it as an RFC with all patches contained in the one series
> so the goal is clear, we can see what's needed to reach it, and we can
> decide whether and how it should be split or merged going forward.
> 
> As it stands there's little in the way of code change, except to
> pinctrl (though also not much there). As such I've included the
> binding maintainers and subsystem lists as recipients but not yet Cc'ed
> subsystem maintainers directly because there are quite a few and I hope
> to avoid mostly uninteresting patches being a source of irritation.
> 
> The patches fall into several groups:
> 
> Patch 1:
>   Rob's conversion of the PWM/tach binding to DT schema with fixes
>   applied for the license and typos identified by Krzysztof.
> 
> Patches 2-5:
>   Fixes for the warnings related to the LPC and pinctrl nodes, touching
>   relevant drivers and the devicetrees.
> 
>   I expect that if this approach is acceptable that we'll need to split
>   application of the patches across successive release cycles, with the
>   driver changes going in first.
> 
> Patches 6-8:
>   Fix MMC/SDHCI warnings, touching the relevant binding and devicetrees
> 
> Patches 9-10:
>   Clarify the relationships between the ACRY and AHB controller
> 
> Patches 11-16:
>   The remaining pieces that eliminate the warnings

Don't you see warnings for at25:

     89 (atmel,at25): 'size' is a required property
     89 (atmel,at25): 'pagesize' is a required property
     89 (atmel,at25): 'address-width' is a required property

These are due to using the deprecated (since 2012) at25,byte-len, 
at25,addr-mode, and at25,page-size properties. I think it has been long 
enough you can just replace them with the new ones.

Rob

