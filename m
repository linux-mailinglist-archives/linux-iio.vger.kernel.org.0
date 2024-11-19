Return-Path: <linux-iio+bounces-12413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B589D2BF9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F2E1F245B1
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7061D1727;
	Tue, 19 Nov 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc67rj0v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3661CEAA6;
	Tue, 19 Nov 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035563; cv=none; b=YBnSTt1Es1HxunQlVmQDFen0ENKQXFb3zQFB7Q63stw3M0BuC1nlbDmFySiJD2Gt1bLNJMF1YGzDeqWR8E28lLgCjhO6Cd0coVVVC8k0tOydvPsR1dPMhBMt7/9An5c3x9aYgvszNQI/H8aQ9eE08L/F4kESicBfqO1rszWJ9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035563; c=relaxed/simple;
	bh=ZrZ7oXhDqYlbr9ayO+VZap9onESv9xBNkLB9RG6TA+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO5nPmrmM7PyFQP3nTsDK5Edr9x5weNDmReN0pHhqUaE03HrZqhPB1PG5H7WSZxx2H9bFTEHVu+ELCkRUedzKrlY4f+OQEOU3LSjwcFmJnm2XWXic3HanIQU1hbKXgEHsQ22x8ji8xxigJAwqjsFEmmSC8OER8h/OHAKTP4UUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc67rj0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947DAC4CECF;
	Tue, 19 Nov 2024 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732035562;
	bh=ZrZ7oXhDqYlbr9ayO+VZap9onESv9xBNkLB9RG6TA+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pc67rj0vZ6EiqMKOPOqDWXRJvqsgxa1E0CNs2ldTqYvQ59aoconRIwz790MOGBHNB
	 4aMzCXz3G9UinnG0afclfsIznGQdKib1JZw1u/t72vagyfA3u9OWHExlsj4tXC7AyB
	 BEpM0i7H8hXbQJuMprnnzQJhXrIXpDnAENHj/EHP19o1qjxQ6JCalLVGU8FnVYn/B3
	 HSKLaQFQkFpeEvF0HDerRwsYV8C+XGov3ynf0hsuwaQyVe9WdxPX4tu36JWQNWePsD
	 Z8Uvget7YfXmjmC8kb2ATtPp0YofVVtEixx9KtMGAW6quPVndVo1WupWcE51mp5k36
	 8I7lzrANSc/kA==
Date: Tue, 19 Nov 2024 10:59:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, Han Xu <han.xu@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>, imx@lists.linux.dev,
	Sean Nyekjaer <sean@geanix.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: accel: fxls8962af: add
 compatible string 'nxp,fxls8974cf'
Message-ID: <173203556027.1804813.15784012336062429559.robh@kernel.org>
References: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
 <20241115-fxls-v2-2-95f3df9228ed@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-fxls-v2-2-95f3df9228ed@nxp.com>


On Fri, 15 Nov 2024 15:23:58 -0500, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> Add 'nxp,fxls8974cf' compatible for the FXLS8974CF sensor, falling back to
> 'nxp,fxls8962af' as the only difference is the ID.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


