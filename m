Return-Path: <linux-iio+bounces-11411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D489B2055
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 21:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EEE281546
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB6D17DFE8;
	Sun, 27 Oct 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CszlurXO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDE15885E;
	Sun, 27 Oct 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060805; cv=none; b=EdehZiEhKicRe3ddpa9IHdxk5XK6xuy7Fou3uCuqE6DyHi827Mpo2pdg6c0TakFFcU7IBuFlwogQMQkNLIQmiBZllam4DFPVZEP6ZTCVk6bFgLlYPXSwieL0H9Zn9UppJ//nrNCn35vHC+vOdFTtk30VssvFL55KhoocOQEm3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060805; c=relaxed/simple;
	bh=fmET3DxbTI+s6LHfEIONpSc9VXeYTzuQ/HGG1C43jVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2gWMMz+Q7HQOUp9K499kRienlUfkY/ONWYtBg1N0YCacQPJjhHRyHGp75GsRt85TIrktLt7EDnyhDMQX7F3Dg+f4Kxx3xbKHG/+1t7S00HclO6l8HRDHkw9ToUGc9GPgkmqQD1E7CpcQts6e4KXaUcO0nQyJFHLLIPGd7FB6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CszlurXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7DFC4CEC3;
	Sun, 27 Oct 2024 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730060804;
	bh=fmET3DxbTI+s6LHfEIONpSc9VXeYTzuQ/HGG1C43jVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CszlurXOGTrkT/Apmjj3aitOpY8n9M64wH0fYfR2tR+QIDKid0ynOm1k/liu9Ofwy
	 qKrGKhUvTTz57vio1KGU4Ivh48ne3+kay+jV53r42iabxRFgXZ3F1PZCaC2GPH3AD3
	 32hgcDvvNLMBTcRzdJlEdh483ENdTPKTA7FWrC5K/4IJj//kpG7KuqAA1sxwF2BU1g
	 mlnnVr2m/PLHissKB9VZqTi1Dh5uXgfRHsKOiFYs+t7ejaDaPGwxHMoopS8LFMSwqn
	 2BaIPKBGdmGSx/YMTAF/MkOoP9MqL4G1i6EztCu4NY4N9h4rukhhgGGgC7v76NWbFL
	 CDLODwNjthIxA==
Date: Sun, 27 Oct 2024 21:26:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?utf-8?Q?M=C3=BCller?= <philm@manjaro.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: imu: bmi270: Add Bosch BMI260
Message-ID: <aovygvsb64kdcppjred6ptriwshpwi6xpxc7tqawxthpdv54v7@l637kn4cbzf2>
References: <20241027172029.160134-1-justin@justinweiss.com>
 <20241027172029.160134-4-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241027172029.160134-4-justin@justinweiss.com>

On Sun, Oct 27, 2024 at 10:20:24AM -0700, Justin Weiss wrote:
> The BMI260's register map, configuration, and capabilities are nearly
> identical to the BMI270, but the devices have different chip IDs and
> require different initialization firmware.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


