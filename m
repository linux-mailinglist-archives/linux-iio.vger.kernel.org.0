Return-Path: <linux-iio+bounces-27027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A93FACB71A5
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 20:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BF42301D60B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A731AABB;
	Thu, 11 Dec 2025 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATJJ9+uk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9431A57C;
	Thu, 11 Dec 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765483081; cv=none; b=DPg+5KLqwNX/DoGHN6AUMyYeyOdHOIvhP6kKYritfdPZaHLdgRxSgd+CU9Y/xEZ5+/WSXE+CvCrspp3yWOAfEsjHVh0uKm4cBqWLD3Mxt4fbiEsopTn+Du4iXGGg0bvypgKcBwWW8O+t56qWc1c55B5JN/DoAYoQnEmtnIVMyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765483081; c=relaxed/simple;
	bh=3/wJayDctxhp5vTQT4wNVc8YtzAiKTCUMkMHSROR2NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYx74P0DudtqxbMzjOKzxyV97XN+czQGf299lrfUkZhF+si+eCCK6JqaqRs/fJn+SscONXF/8YCy/VkouKjJ2jF3EHKEZXcWs8o08iH8xxxdmFag4Ewsj+hFdNl3SryemCKettDKfzmssL2TpuXJZwBFKjDvVx258qFl4IrvgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATJJ9+uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A12DC4CEF7;
	Thu, 11 Dec 2025 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765483080;
	bh=3/wJayDctxhp5vTQT4wNVc8YtzAiKTCUMkMHSROR2NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATJJ9+ukH0IzvEXvHTv6Bh/v+OnGQoKbctRpgp2vE2zMixw/67hkREvUItUMDl1Bi
	 Ax4mAc4VKjE3f8920syuzKruVfyJQh1CdFvGLdQPohTQD/u4HK4KOeVHSBlOg6g7pg
	 BpWKTfhsRW/WnJ1y3ztBDdx4NoJ+oZQSQrWLOG/BjJ/33uexE+QQYMDU48ryMEPKCZ
	 uQ+3GZvJjVBrUjMDhS9ucXX5lhF4d1RdytB5w8TqLegOatCfksxC4uf9NFkE9cvQoD
	 gQ3QPmkY96buSBIuUQdQd+YpWx6c4TjNhqzzomPQyE9PlSYDk4AIw0/bEixNX9sVW8
	 6WH/8wPsNXDzg==
Date: Thu, 11 Dec 2025 13:57:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linusw@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-crypto@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH RFC 14/16] dt-bindings: iio: adc: Allow interrupts
 property for AST2600
Message-ID: <176548307744.1801669.10354753289483698774.robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-14-21b18b9ada77@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-dev-dt-warnings-all-v1-14-21b18b9ada77@codeconstruct.com.au>


On Thu, 11 Dec 2025 17:45:56 +0900, Andrew Jeffery wrote:
> The device has interrupts allocated according to the datasheet, and
> the devicetree already defines the interrupt property. Address existing
> warnings by allowing the property.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


