Return-Path: <linux-iio+bounces-3669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05993886504
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 03:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D3F1C220E0
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649A15D1;
	Fri, 22 Mar 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp2U6+oe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74C10FA;
	Fri, 22 Mar 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073384; cv=none; b=YC8GSmC92ra6b5xVSwGwnalyJjWEHt/1UNGXd5lC8bfGXsKVKJZqfLZdyQjTLt3rYsrSwoe1jEseL3ApxW4cMSRulfXvk/sFWWI6YKIFu8jHuuKlWZbQes5I2xD9cdHuTI+Wbl3awLkcMSup7eT9nMFAownkhvknV/3/N4TRVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073384; c=relaxed/simple;
	bh=M9+buGGHVmbN+4X6XpKSvLDFMQ8s19IDF8A0yS4tJUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mnvm5N4cAVTx3Arscoc2FdybWGNQAmsA4yMtiHaH8ANyilH5RAyMwnYwbF3PFpDyocmRe/8zSFl552f0CH7kPLrrfEZHhAZnB+lMCd6CxRJbh9g7NvcnHURYBPIgKMlTV1iECla+e4ml52HGZWTYfHi/4qUAZUpHzag9iwUP1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp2U6+oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66438C433F1;
	Fri, 22 Mar 2024 02:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073383;
	bh=M9+buGGHVmbN+4X6XpKSvLDFMQ8s19IDF8A0yS4tJUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tp2U6+oeUQLkvsxfCYuiGMcrs0zupHrf3kazneQj9/8dXWwVPTbQOYA3zv+Upxy9C
	 gWrWgT04vVfQoN06P0SXnwsKzCaMrhhXd73xQeuduZcCAfk1NjuFjWS7wV/p80sEkf
	 jST3+fPwcHTaSDl4dFXF/r2VwuyGaGv6YGohPpulGhkKXTKY72O7HrIU8xUy4jZoOL
	 Rw8pXQhydJGnC9Zi9HCbfeuI9RcnIeWbGQlpEJkE5tDK0k7aFoUVFf0NgrO9kderwW
	 1w24lQl9Z8OEw3twRZe5WEXxStah5Yq7vmRUxUZ6xs9uGUflCRIIZLfblahlzDRIEI
	 yqoxEdXN/2jDw==
Date: Thu, 21 Mar 2024 21:09:41 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matt Ranostay <matt@ranostay.sg>, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: health: maxim,max30102: add
 max30101
Message-ID: <171107337852.3410745.14506483547163918471.robh@kernel.org>
References: <20240321-max30101-v1-0-00b83e966824@gmail.com>
 <20240321-max30101-v1-1-00b83e966824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-max30101-v1-1-00b83e966824@gmail.com>


On Thu, 21 Mar 2024 19:33:48 +0100, Javier Carrasco wrote:
> The Maxim max30101 irs the replacement for the max30105, which is no
> longer recommended for future designs.
> 
> The max30101 does not require new properties, and it can be described
> with the existing ones for the max30105.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


