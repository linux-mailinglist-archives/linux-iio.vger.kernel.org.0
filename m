Return-Path: <linux-iio+bounces-12802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42439DBFA9
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 08:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2D164B72
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 07:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F897156F20;
	Fri, 29 Nov 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRiaA62H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A771386DA;
	Fri, 29 Nov 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864347; cv=none; b=I43po1ebkA02D9dKX0wHLSLQWXZpq+AAJOpfKBEHPbLsWkyqWqVaIVXk2d8WloF5VgLeBydUCIBEtAp57eaNB2DOA9MGclf3zIarEQLZn6EnDSPblPZ5RzynEqfzf0Bg9PKDs8OiGJt7jEfz5PRSLGchPDsi34++XpWyzeWuZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864347; c=relaxed/simple;
	bh=A/mw54NppyLJYHyhW9435IKQ05C8GNQUuJ18HrH/Gz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+y+BDZqwnhdyyyD5+GhkjZ+kZvR1JgE2nSF7gVVBshYDhyyryQMNl0VxGUkLsTO8hMLm8ZZH4HJuSJ4/FyfXFuBjiFx/2oFGUoF0Zes6HS2GOI1zlX9492AHbgpxSpWTQUhY++H8PWabqw9ZYERrhIKe8xVTxEzW6xt18n/8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRiaA62H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A97C4CECF;
	Fri, 29 Nov 2024 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732864345;
	bh=A/mw54NppyLJYHyhW9435IKQ05C8GNQUuJ18HrH/Gz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRiaA62Hv37Iy/ji3Fq76kErKJLEBR+W1tR4dodJ+pfcQTwdaxVey2cE6MJTJM76/
	 0pzvA9z+B5ds7w1jTXuFExi2dTUDJ/8Uc6nxsQhBaGOyNe/1MsyTreVYTgNb9k/3k+
	 KsGNawVCWCrJ38Okn64f3PpU8zoZ6dGecJHB9d4wBtg/bu6HIyLeSi5EEKhlzL8j+D
	 2zd4JfUuJ0lb7MfwH88042mbaj2tXwcKaksGAUyCpXtWogVcXk6nzoaStxdwNeLc9s
	 3qP51ccqFSVJjPIbl4U7rZuqo3W2EDtd7e2GPl+dR3HX2V12Alc0xfj+F6hd2k/SfF
	 5MXC6vLLAcGCw==
Date: Fri, 29 Nov 2024 08:12:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: bosch,bme680: Move from
 trivial-devices and add supplies
Message-ID: <wdtkd73brhfotps4crpbpgdvtzrc25xr3bq2au2d3uzrl5pwz2@7ssawm3gyyfo>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
 <20241128193246.24572-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128193246.24572-2-vassilisamir@gmail.com>

On Thu, Nov 28, 2024 at 08:32:44PM +0100, Vasileios Amoiridis wrote:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bme680@77 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

E.g. gas-sensor

Same in other places.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


