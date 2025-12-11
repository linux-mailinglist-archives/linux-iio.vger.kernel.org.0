Return-Path: <linux-iio+bounces-27024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DA6CB69D5
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 18:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290DF301B826
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E83128B4;
	Thu, 11 Dec 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEraNML5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A823EAA1;
	Thu, 11 Dec 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472616; cv=none; b=e09/haPR5igCX17qCkLQx5j/QtcdD5DxrTvTZmjjeOX0x5APsoc4noh8eGP3X5bgSCf/733l+vktX+zw8ATxxDxuMmrkeYka23Jwfgg/id0r7e+mlpa4SY0bn83YsNVCU4VDjcS7aZVHZD4efJ1+O+hGj2NkIYRHrZe4QEsmYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472616; c=relaxed/simple;
	bh=68tWRmyf6VMzwULZOQ9jRTGMGeauu+h01vr63fws4Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo2FbNinQbBCyoTP4oCRp8/plAbB9IeQgH3QS9cf7RkQyuErIQX/bGDcFdwrU319C5lr8r7l1Fh472p1XIZW+2gJWXod5LeYLUYQ8YxEr1X6R+Q7Fdo0uF5KaZ6Qt7J332gaZedPHhI76zh8GPnBgUPBydXkhZLD+ygWIZsjdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEraNML5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA11C4CEF7;
	Thu, 11 Dec 2025 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765472616;
	bh=68tWRmyf6VMzwULZOQ9jRTGMGeauu+h01vr63fws4Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEraNML5j0inR9DRN3T0yMvKx/qUMlxrX6pt2w1kQXcFJ+dgklkcBrCl7lJfcXoP/
	 KQvm2lFNs2jtSb6TCrIUIbE81U47bZzYY17kRquywMWpeEUQeEnhNQZVCrEc7wfZ+D
	 H4u4TN6uPjrBANyvOvTwPDse6CRUlkGacZ8M3ygNWdw/A4SdFSB/5BKX8YYUbJBN3T
	 rwiLbiIoIAcOYnHMyqsVbuypBi8MrNEPQ0aVeLtEiufHBhNCknAN3HJbuv+icg8U3u
	 vvwIggyYfHT3kFAPIzeqq4hj8GV97HM7LEoMSSfBMtzHmmBgLEZhbqJJg90EOtm3VG
	 wM0ep5vPPxi4A==
Date: Thu, 11 Dec 2025 11:03:33 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
	Linus Walleij <linusw@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	openbmc@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to
 sdhci-common.yaml
Message-ID: <20251211170333.GA1557987-robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
 <176546866607.1487115.6798113196659439308.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176546866607.1487115.6798113196659439308.robh@kernel.org>

On Thu, Dec 11, 2025 at 09:57:47AM -0600, Rob Herring (Arm) wrote:
> 
> On Thu, 11 Dec 2025 17:45:48 +0900, Andrew Jeffery wrote:
> > Enable use of common SDHCI-related properties such as sdhci-caps-mask as
> > found in the AST2600 EVB DTS.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> >  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.example.dtb: fan-controller@1e786000 (aspeed,ast2500-pwm-tacho): #cooling-cells: 2 was expected
> 	from schema $id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml

Not sure what happened here. This is a real error, but on the wrong 
patch. The already applied change here looks fine.

We need to determine 1 cooling cell makes any sense or not, and allow 
for 1 in thermal-cooling-devices.yaml if it does.

Rob

