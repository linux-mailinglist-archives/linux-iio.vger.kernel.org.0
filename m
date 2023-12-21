Return-Path: <linux-iio+bounces-1215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24C81C12C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 23:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BA7B24687
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EAF78E67;
	Thu, 21 Dec 2023 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCtl+zEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3D539E0;
	Thu, 21 Dec 2023 22:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09A4C433C7;
	Thu, 21 Dec 2023 22:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703198857;
	bh=ZnT30Xm750zuxWYXIlL4Si1wKqdQT+pNceHzWwfb/bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCtl+zEKWetIumim/WOpYMAZEtBrjJFzEvxCL8zBJBvRYZxGqV9nDIQ+NchcHrA4C
	 ODLMEgkgXQsxNA4+7RRPJ8LCxEUbG3c3+MLA3+bc+EOnXo7XtU8p/xo0PJ+MsEXoY5
	 MPC/8tA7Y65mpxIdmS9shSwBeYo0TQnLut4cRfjLaCAsHef9VtEZu/XygzG+W4u8YQ
	 g2syjGhFv4LLpahfGMzLOJNSGqDZWKnMmTocyIA5Uc45C4i8PsvKyDqfUq061VNyRV
	 SuZdAx58Gc5Ht/GUJedn63tqams11r4HKXCz3HXZWGI4GVIU5B17C0TaYLMBfuXCyA
	 Zxs50+HfHTq4A==
Received: (nullmailer pid 228589 invoked by uid 1000);
	Thu, 21 Dec 2023 22:47:36 -0000
Date: Thu, 21 Dec 2023 16:47:36 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-iio@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>, Michael Hennerich <Michael.Hennerich@analog.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 4/8] of: property: add device link support for
 io-backends
Message-ID: <170319885547.228536.6827576544257263571.robh@kernel.org>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
 <20231220-iio-backend-v4-4-998e9148b692@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-iio-backend-v4-4-998e9148b692@analog.com>


On Wed, 20 Dec 2023 16:34:07 +0100, Nuno Sa wrote:
> From: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> Add support for creating device links out of more DT properties.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


