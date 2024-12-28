Return-Path: <linux-iio+bounces-13825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F09FD9D7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB551883EE3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81D13D279;
	Sat, 28 Dec 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVDzfHvU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A578F52;
	Sat, 28 Dec 2024 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735380844; cv=none; b=EidofqvD0gz4aJ3eBSf9pPYtfmQks5DbIumE5cHDvsiWbxXEnq59wtn8U4K3h8nmVoB+BU0lHwyUNMNXL58OO7UXMn/h26iC8TARatD99ZLJU6hmjkMWzdkfNYkWlM5iYfRBBD9HH+zkbiex2u+SXcaa4dXXyz2cOy8a/U9PmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735380844; c=relaxed/simple;
	bh=V425l5cE4e2eveyjEdyjyNN5SRe5r58TxGFHNQ3d5Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK5XomisA7s5ROMcQlCEGZkDiXyslDVNdBiXGKndIywKBVZW9m3oGsqS7s+VKDzRzKvRL3gpWmUsH3VqLPmVG8oEJhJylz4rtE8R2PDGKGRWVl1dTs7iF/BP/mgW/jYR2BImCJxX2qUPKi+AjbPFxv3ruT6pz6AH1PTzaXND00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVDzfHvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3EAC4CECD;
	Sat, 28 Dec 2024 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735380844;
	bh=V425l5cE4e2eveyjEdyjyNN5SRe5r58TxGFHNQ3d5Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVDzfHvUg9GX2TTv5RYFEGSPaZcIu41LzzdzkYQ2Ii/Lb7hoKhLKpSp828QVNZr2f
	 8b1NAJ2aM6cHXrIg36cPcdnmIC7wQW3063SeCpnO77gPqWwaaZaVtqwIOeuDrhy1KS
	 fXTWy8FiTtgMK9eU1emhu0u/Qhdw47RIY2KFlyD27o27V9Et/CMAusT7RAjtWzoImj
	 26UbHmj7gEIaIa7++tnTFJQOC/67X7qiF2CN5H+zvElj604k8+4GRRw2rgUj4g2t8y
	 DDZnXbjSuXZ4aanqNPtwneU0uDVXuM4k4HshslfSL/fLWpFY6Lk/w4CSSrDd8fGigo
	 qgVTlQkOk1rAw==
Date: Sat, 28 Dec 2024 11:14:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: jic23@kernel.org, krzk+dt@kernel.org, 
	andriy.shevchenko@linux.intel.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Gedenryd <emil.gedenryd@axis.com>, Andreas Dannenberg <dannenberg@ti.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Message-ID: <qgottqtq5lvp6fifi37xzq7supalvm7leue755yjatyun6k5um@pju4v3kqoizq>
References: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>

On Fri, Dec 27, 2024 at 06:41:32PM +0530, Hardevsinh Palaniya wrote:
> Add Support for OPT3004 Digital ambient light sensor (ALS) with
> increased angular IR rejection.
> 
> The OPT3004 sensor shares the same functionality and scale range as
> the OPT3001. The compatible string is added with fallback support to
> ensure compatibility.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt3004
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
> 
> v2 -> v3:
> 
> - Reverse the order of compatible string
> 
> v1 -> v2:                                                                       
>                                                                                 
> - Use fallback mechanism for the OPT3004.                                       
> - Drop 2/2 patch from the patch series[1] as per feedback.                      
>                                                                                 
> Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io/T/#t


And where is any user of this, the DTS? We don't take bindings just
because there is such device out there.

I looked and nothing:
https://lore.kernel.org/all/?q=ti%2Copt3004

Best regards,
Krzysztof


