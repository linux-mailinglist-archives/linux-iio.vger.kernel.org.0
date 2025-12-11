Return-Path: <linux-iio+bounces-27025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F47CCB7147
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 20:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6A2C30028B7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFCE3271EA;
	Thu, 11 Dec 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Doq9lqp+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF230BF59;
	Thu, 11 Dec 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482992; cv=none; b=Hrwx3i3gH80XKzzhdggBPabQexsA7os6N3IL2FiM+wUGPL9GYQyNUN7DcJz4WsHAyP4olHWEBA7kOM80FKw0VM0nmJEXG1b7pTpGh2kqRSYHHsleTPAjI2pDi9qKrpSbU+04EP9AxEfRiUSCtE3adT5eO5XeJj6r6vSvpvRQboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482992; c=relaxed/simple;
	bh=HMv7vikpdiyc0tr0TYhhhGH6GWe2x1iyzq1EumBTr7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmvjvjCIL4sns/lN8yrKz0Qk5zP4/35YZrhFwI5q1KPBUUdR0WTfw4PaZibcHDqdWhwRXXg3nesYBKSwyZl9TGixZyMfBVUuo5CQJsNRZWhcVlCSEyueSBFrLPInCUW0eZjcXErBXP2Pq2nhnxSzLfDDG3TLV5nZqYO9HBxEX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Doq9lqp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C135C4CEF7;
	Thu, 11 Dec 2025 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765482991;
	bh=HMv7vikpdiyc0tr0TYhhhGH6GWe2x1iyzq1EumBTr7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Doq9lqp+j2BkKC59X5d5xNwaCtkHdKMBqSJU7xd3VUKEqtGRMStY3+hLyCm4cx0PY
	 GLAbUgXK69XtkVMGraP+oCePaYTvpho4LQX16dgzQU1+DO00Nz7RcTjFKFBOuONG85
	 2hR0JZ7ywSzoUAA/FuiUFFdJ3ShigaABCVM40fAqO/QyaSay5gu4EU85LRfFAaa+hX
	 faR5MhuXj9/QnQr/LosBEaKF3bQds37XndtjoLJknc2/MmhaxM4oGTuWXoag+2mIEd
	 Ph46y5A3pEv34txN9cZWx3UGV9trTMC1k0Uzd3PUSZMn/6Svnsr7Ewt9n0lTSQKP1N
	 Bh8xxGiRogr9g==
Date: Thu, 11 Dec 2025 13:56:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	Joel Stanley <joel@jms.id.au>, Linus Walleij <linusw@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-hwmon@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 09/16] dt-bindings: bus: aspeed: Require syscon for
 AST2600 AHB controller
Message-ID: <176548298699.1799665.1259025609428986424.robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-9-21b18b9ada77@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-dev-dt-warnings-all-v1-9-21b18b9ada77@codeconstruct.com.au>


On Thu, 11 Dec 2025 17:45:51 +0900, Andrew Jeffery wrote:
> The AST2600's ACRY (eliptic curve and RSA crypto engine) requires access
> to configuration exposed by the AHB controller. The devicetree already
> describes the AHB controller node as a syscon, so require this in the
> binding to satisfy the ACRY relationship.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Applied, thanks!


