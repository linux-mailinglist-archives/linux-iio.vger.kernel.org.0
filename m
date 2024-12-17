Return-Path: <linux-iio+bounces-13567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A09F4504
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 08:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798397A2656
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B71C8FA8;
	Tue, 17 Dec 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQTMtHIn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A618DF62;
	Tue, 17 Dec 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420224; cv=none; b=S+nNvgS+TcXeW0+V30sJ/Ymqwl+g9NY1OiuXvAGqR3dxo0zQjY3fsbxAso/PK8s/EjQeDYT7mm8E6ccwjXf0P6FAQIRuaMGm9tdJOxiH/SyRbuhUsoZowa6NEqOkEHdz+9tMJOW3DTLw3v/xjBaOwajAMbaAXituF7UKSkdDSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420224; c=relaxed/simple;
	bh=dzw0Qz/CRN0PqPZK4GaTrVRJ3D3wdhp/qpqu6zM8BjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poGqXTC24r2Wjmhy4klC28PoxcxeyQdvmqMcfXMdX5/0bWgpjac6DrhGHuDUYIDmNg3tYIjm8ZV+crF3VS4ZqbUqYysLIzhA8riSWFIfBRkRA6YRK5RXTenzLRqXN7+bAmZDPUuNFxklCRkULLbz/qToDDFCHzHIPIlRy1Eb9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQTMtHIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C22C4CED3;
	Tue, 17 Dec 2024 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734420223;
	bh=dzw0Qz/CRN0PqPZK4GaTrVRJ3D3wdhp/qpqu6zM8BjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQTMtHInjjzJekW+YadyNvS4jQkGkqV7h2x+QkNNZEm4mGrVlPVf18N2MpQByzGUB
	 i/HLusx0LlTfXD3Mv838GyP3MDACR2kC5tX4/N4+NhDQ771OtrZeoh1JDzuw1GneZF
	 JBm16gGYH26tA677MV7ecMEXtZRLICeCxuIbhWL6s0Mq3jto6kSQoqu1Yjca8Cq9TL
	 Isw4vFpV+jPgLgOL5VJ0NMJf4OmwHyYpxO1HyHPZ18UzyEU/YyI9X/MUAhtJBIHsGC
	 SxQz5FITdd1Cb++qXTe5IapG3GlmSH43R3CcwhsB1Sf6Mubbm68FfzxToNen2xAMyN
	 iyaKWCqgVenZA==
Date: Tue, 17 Dec 2024 08:23:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Darius Berghe <darius.berghe@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, corbet@lwn.net, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: iio: adxl367: add support for adxl366
Message-ID: <lcwhomnejblm44f7jqcy3slrzu4vmcgyx6weocziqge2swkfia@qhqwam2uhqxl>
References: <20241213095201.1218145-1-darius.berghe@analog.com>
 <20241213095201.1218145-3-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213095201.1218145-3-darius.berghe@analog.com>

On Fri, Dec 13, 2024 at 11:52:01AM +0200, Darius Berghe wrote:
> Add support for adxl366 Micropower, 3-Axis, +-/2g, +/-4g, +/-8g
> Digital Output MEMS Accelerometer into the existing adxl367 iio
> subsystem driver.


Bindings are before users.

> 
> adxl366 supports all the features of adxl367 but has a few
> additional features for which support is added in this patch:

Where do you add these features in the binding? I cannot find them, so
maybe you reference something else.

>  - built-in step counting (pedometer)
>  - non-linearity compensation for Z axis

Are the devices compatible?

Best regards,
Krzysztof


