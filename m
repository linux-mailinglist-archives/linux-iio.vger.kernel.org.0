Return-Path: <linux-iio+bounces-12234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9369C8401
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 08:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3688EB24AB0
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 07:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20D41F4268;
	Thu, 14 Nov 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DXwl0XNa"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A5163;
	Thu, 14 Nov 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569599; cv=none; b=Yk2AYT/AzFIwnxq4dykfe0+Sv6GWxwTcxy7Qo2/09CneLEew/mQ3ww1do4SFhPIb3e+ztHdGTrcjKVSFmrgvk1tjou2zj1VISJ0hnTODxzDpvDutPuF9o9pzcgeeL44JbwB8YOXMJkR0mLCWV730kpYn9iI9+AXHK4kBVjmvUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569599; c=relaxed/simple;
	bh=npPyT+YltrKVLn/0Dw4S8aKcJ8zO5S1u5sEoa0M8tTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2XUHU4xwjBL2lDuNW19sRdEetGVwu7lAT/s1dDAz1SfoyiGsFEf3zo+Q9TDDQqW4cva/IuR17sBvAR0Mun/hm8SoUx6CIeOVZWkmkcVGWAhZc3iOBcw6JyDvfccK1a/Oky/N+vAzbMX8AYujKGIp7ZlpbjOf0g6RVKwAMBYv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=DXwl0XNa; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=58yhCk9CeeOPtBuuZ4BuhA5usyJw53gljXnMR7zTX5E=; b=DXwl0X
	Nam8vfdkULwBrBXX9frRP2xwGSp7mCUnltQ+HocsZ4z8OTCVokBW/PQ4TQPtZliGWixKVkd+Fl2Jy
	YVLzwFob2Kitu3KoFAjsKcISajO4wRKdb/HwcSfRCKcZPOomn/3R5VpOPA6AsihacschTIZIQ0iaW
	eLVFHX72lJZxhLDyhgWN41Bx23KnVt8t1HswX4aBZFefe6sfE3cizFpGRIefwz5HpVYNBsY84/fY0
	jZyxoNS/ejSlCJAaY6JuwomZzqfNVS8AIzQEs6mxBmxZrQBKLBpoymKLLoBHCB1elVlBjsZioLbsB
	ykMUPrAsqpDsX5ELjcGT8ZDFhfvQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBULr-000Pp3-Dx; Thu, 14 Nov 2024 08:33:15 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MBP.snzone.dk)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBULq-000EmP-2Q;
	Thu, 14 Nov 2024 08:33:14 +0100
Date: Thu, 14 Nov 2024 08:33:14 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8974cf'
Message-ID: <43rwi6vlwzw6p466yovjruuyx3yafheu26qkvd7xzk6mfrryju@fx2zykfot2bs>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
 <20241113-fxls-v1-2-5e48ff1b1fb8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113-fxls-v1-2-5e48ff1b1fb8@nxp.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

On Wed, Nov 13, 2024 at 12:54:40PM +0100, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> Add compatible string 'nxp,fxls8974cf' for the NXP FXLS8974CF accelerometer
> sensor.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index c375ef1bd083f..93985f670aa7b 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -15,6 +15,7 @@ description: |
>      https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8974CF.pdf
>  
>  properties:
>    compatible:
> @@ -24,6 +25,7 @@ properties:
>        - nxp,fxls8962af
>        - nxp,fxls8964af
>        - nxp,fxls8967af
> +      - nxp,fxls8974cf
>  
>    reg:
>      maxItems: 1
> 
> -- 
> 2.34.1
> 

