Return-Path: <linux-iio+bounces-18763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D441FA9EA33
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 10:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C793A6D27
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007E241679;
	Mon, 28 Apr 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og/jU1JB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643523E220;
	Mon, 28 Apr 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827265; cv=none; b=SnLDpYV/1kEfoKGLAw3k/54i6ROf9TZjUMVdDR0lV+EcP89PcDOB6j+iXb5AWGrGv6LaLc6ShvP62zkV4QEBrOVIctJJMF5X0txz2TnvU5NNULXzc+R9jH2Iv/MZwvycUUtwdGwkql3UN4iv/7mOyRdpurkmugoQfv4r4ZCkKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827265; c=relaxed/simple;
	bh=hs3XiQKE9I3k1jwjSKabtV+PYcm9fkcxj+M+zOM+CkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy88+oHJSam4CYy9JmkEyFpOMJfM/guqRfjt64zVUTdzwJWUo3pEIR/aRn2C3b3n5h8JAToh9RQq7aFuYVf/H5Yqkkl5gW6yiJmOK8SRENYb6rc+v5iqT6mAZgri7so6KjirUPwclSlOSRiujxtLBzOTx2Bob7a7ZWJNHWQ31gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og/jU1JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2007FC4CEEC;
	Mon, 28 Apr 2025 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745827264;
	bh=hs3XiQKE9I3k1jwjSKabtV+PYcm9fkcxj+M+zOM+CkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Og/jU1JBaBVOJdCJDGpbwQXB4cNRmCRdioi6I8GFVWL61Wr2PfQbRNv7tQW4+Jjtu
	 l4O13JVZZ47fiWXIPD6rcUTnrwpb0PhAqAQnCY1+731eAcN5ao5zZFu+jcd5tiIZUM
	 vwOzjRuGLZqmi3GFDkDgLkPXZB3/FRCVDivRq4guIB9HciUfPwAB2YaiOMVxZOXuOk
	 iV175QXx6tF91JVcMkwDacqTFS0rIJsLd1zCuSQ3lhkCyRM6V4lnWXucN9DElAi9kn
	 Jvt7G61OsIln8pbapkIl2vWf52CTekqeEe45bcY8+hxNdrNvrwLnb7/HkmhZj2koCO
	 vidY5T8kg5Mbw==
Date: Mon, 28 Apr 2025 10:01:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>, 
	devicetree@vger.kernel.org, Lukas Rauber <lukas.rauber@janitza.de>
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: mcp3911: add reset-gpios
Message-ID: <20250428-overjoyed-rook-of-penetration-62cdea@kuoka>
References: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
 <20250423-mcp3911-fixes-v1-2-5bd0b68ec481@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423-mcp3911-fixes-v1-2-5bd0b68ec481@gmail.com>

On Wed, Apr 23, 2025 at 04:46:50PM GMT, Marcus Folkesson wrote:
> The MCP391X family provides an active low reset signal that is still not
> described in the bindings.
> 
> Add reset-gpios to the bindings and the example.
> 
> Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
> Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


