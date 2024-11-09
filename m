Return-Path: <linux-iio+bounces-12061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7F9C2BF0
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 11:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF55B22327
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41169153565;
	Sat,  9 Nov 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJs1L+sh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7C4EB38;
	Sat,  9 Nov 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731148678; cv=none; b=GGJF2G9ch2eKirCRKViSHBVkJ9rzSstwQE/87gd3+/nYpo9BKDNvlWi8+mncyxQYUxp2d2hlzHddXQTwHEt16yiDc3rwZZ9v+L4wC2GkBdqtV6MAQsvE/AuAo6D+dFm5UIFubP7zFguEoeJjH2vDdCC62eSw9Ep8SXbto5h8uEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731148678; c=relaxed/simple;
	bh=O8bmZTnkzt/k76wgmpN7lbyrRgnPKEQqG7lovjyj04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQCVX4TSaY8STKaJLavdmdnWLrxtZBGxcVxdlANA3epbSD3g93Th3j2jago2d5MsnqZh3hg9fA76nc/WMu41Bgrv8/prCX57ldQ/sgwWn2xCNMMHhktc6uQfJthU/kXcMbsVYkN7mM4b6A3O4w0u7j0Q33NP9qdqDGY9k3yyTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJs1L+sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA19C4CECE;
	Sat,  9 Nov 2024 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731148677;
	bh=O8bmZTnkzt/k76wgmpN7lbyrRgnPKEQqG7lovjyj04A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJs1L+shyI6Ycc7P7puwVKIizrQ8AKXI44qJmCsZdX25CZ8C6r4BJCX6HAlzHQNTT
	 3+e3EkPHdBk/O5KhXq2mJv0oDqcRDbYDIzwKLJZ+9aV7qwRxZqlzpm5dis/cvPkV4d
	 im2cDcY/4oTH8XslPvkd/Scw7dEM6ycAD5bWfr0a61wuCx/UZUcbLFLwfWAU2oaAPS
	 IS4gqarNrqaHjBrFondPbRXjyYWqnVh3Zo67BYrViV/1FY3WniF8UMp7ZB71pBdSxi
	 2Fbbc7u+THZx6tzcJcgkt2iD2rVS9yDtRtoYAaQhsGs2h3FoCRDjWokYtaiNuyMLig
	 mEJEXnhElHkBw==
Date: Sat, 9 Nov 2024 11:37:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085
 compatible string
Message-ID: <vd4xjzsdfdtfybz2njsinvfgbb4vrvcqenegfrl26bahypucxc@2ic3adferu2z>
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
 <20241108-p3t1085-v2-1-6a8990a59efd@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108-p3t1085-v2-1-6a8990a59efd@nxp.com>

On Fri, Nov 08, 2024 at 05:26:55PM -0500, Frank Li wrote:
> The register layout of P3T1085 is the same as ti,tmp108. Add compatible
> string nxp,p3t1085 for it. The difference of P3T1085 is support I3C.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


