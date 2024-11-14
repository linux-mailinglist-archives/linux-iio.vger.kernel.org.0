Return-Path: <linux-iio+bounces-12233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4D69C83FE
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B55B22FE3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 07:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38A1F26E6;
	Thu, 14 Nov 2024 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tJ0QSbK2"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FD163;
	Thu, 14 Nov 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569590; cv=none; b=uFv51Oig+Vdi1agjz8ufMs3SUevqo62NVODei7IO+FqhJbx8n6mjCI0LVi2EqjSJvaF8TWCJyQX2Br4gpLAWXjv8wJW6z7b+mMctd/JhPI5qA+EbW4mre/q4tfcD9BswlTmaYZaOJkUiPpddYjvej0Y9tjD5p3Hwpj7wyBNOBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569590; c=relaxed/simple;
	bh=oVcGAnBj/SA9unbnk4dxN2N2Nz5DsZRkXHQV++EftDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1DwTMvP6O0bg083aRjFB4eMk7Jo0O4moe9irM9G9Qpyiz48Apjo47pqLUZHo9FoT8xZIhG87qbxa7M2TpXceVUkmHuP3+d94aVMi2dn48Swxp8udhrhtCIOwf58Wann4QHm1D2VpDz8NSh23CPYxDwT1O0qe5FQxGx/bPsVseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tJ0QSbK2; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=21FH8OZq5JfDKSJSKc9+2NwDGDWnyEBAa4jCcHu2ARE=; b=tJ0QSb
	K2YCYLE05DPrsONrLogZS/mlgUX4gT4M+IAjGIXA0gxGYQYT80aQaFG4Z8X40lCbmGpPRbSqdEO99
	Rdr5fVTmvSOXpj5xO3s+Yvry0oWzzVKf2p2XxhZgJDGKEmqWSjQuimImK/kLK7IwG9LQ/1qo1HYUj
	lr9nhm2505BiKHyf/cUgQOz4+EOM582rPVzAAAZYVnAL/EeFK43NS0m36JYtQhyivuKuLmgi7sMVy
	It5A6ZbMm0SRlz05SHzXoHWo9KJkpSCa5ugVUiHOIACwTgcSajF5A3Vki9zLqnJcilqZ6Dt1XR+ZQ
	CPo454K5TgYhmL0LyrY9iQmUip7g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBULg-000Pn9-Q8; Thu, 14 Nov 2024 08:33:04 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MBP.snzone.dk)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBULg-000Dcz-0Z;
	Thu, 14 Nov 2024 08:33:04 +0100
Date: Thu, 14 Nov 2024 08:33:03 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8967af'
Message-ID: <mjbxcxlkj4ooxhlabggi65rnd22hhcpkxtnetolrf3chjxepq7@xo5e64enhvrp>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
 <20241113-fxls-v1-1-5e48ff1b1fb8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113-fxls-v1-1-5e48ff1b1fb8@nxp.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

On Wed, Nov 13, 2024 at 12:54:39PM +0100, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> Add compatible string 'nxp,fxls8967af' for the NXP FXLS8967AF accelerometer
> sensor.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index 783c7ddfcd90a..c375ef1bd083f 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -14,12 +14,16 @@ description: |
>    SPI and I2C interface.
>      https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
>  
>  properties:
>    compatible:
> +    description:
> +      These chips are compatible with each other, just have different IDs.
>      enum:
>        - nxp,fxls8962af
>        - nxp,fxls8964af
> +      - nxp,fxls8967af
>  
>    reg:
>      maxItems: 1
> 
> -- 
> 2.34.1
> 

