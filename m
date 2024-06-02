Return-Path: <linux-iio+bounces-5610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDF28D74F7
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DDC281C64
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE12868D;
	Sun,  2 Jun 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSK8IaSm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDE17BD9
	for <linux-iio@vger.kernel.org>; Sun,  2 Jun 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717327865; cv=none; b=FHxNwtMst7/Y5Svwnym5ZO/T/7hG4Wau6NYeXZlbiqI2OIZgvPr2AGkd3ypiSeKebVs7I3Y7BBdac6OeOS4+eOHK+QiP5lEno/rodt/9NVxVDhhvn6xs+Q3bp7eGHLb9DdpkTkBK3lt+f8YbdrjRwytim8vTlZJvmcRDLzb/U3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717327865; c=relaxed/simple;
	bh=OHtCv7LlHuBCHRY73CYZFWxCLYmxDyAbhIiwUnm3dTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQu2lkpyBJAJ8moVfP0iWtHWMlUFzRyL+ORzmKaR79P62hoCYbNY0kyTKNrXNlEgMeDiiWZdfYbmcBBPgl5jATFG/Qc5jDHL9fCMYTqKtNVWu9l7F4aPciQgpNLgxLqixv0o/gmRCKUCyA31y5llQfPCUZxmXVbjXwuP9RDpaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSK8IaSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF85C2BBFC;
	Sun,  2 Jun 2024 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717327864;
	bh=OHtCv7LlHuBCHRY73CYZFWxCLYmxDyAbhIiwUnm3dTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qSK8IaSmpyBn020FefvO7kxfQLSTqLfQEWtkv9Cf4yUM+tlBEjCc+IaE3sH4sY3Ve
	 Ff4Bo9wDd5P19j8f4dH6iSh81lwb09q7UDeIR+BbWiYglfty16lYwkDoPacKfEIJGR
	 dlR/fvL6F2dNBqAkL/pt5aF9dGnY9GyP2H7gtSCThwe5C5vRCYm5Inv1MtS5QiocEi
	 1o7kDvPr3NEY7aNNzCOpJHR6q/7ZDZoGccivPgUTYunh3T0dTHQ+FDZt9zF8r7kywf
	 vzu5jVFKHPFiPf+1aPNyFo9Lr/VRc8ohSzg+Cm17p1E1y5rD/hU0QUoQnOzFvrPhcU
	 5av1veGXd4y3g==
Date: Sun, 2 Jun 2024 12:30:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bruna Bispo <blbispo1@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ams-iaq-core: clean up codestyle warning
Message-ID: <20240602123053.5e679d86@jic23-huawei>
In-Reply-To: <20240528143816.13409-1-blbispo1@gmail.com>
References: <20240528143816.13409-1-blbispo1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 11:38:16 -0300
Bruna Bispo <blbispo1@gmail.com> wrote:

> This fixes a checkpatch warning by changing the struct attribute from __attribute__((__packed__)) to __packed.
> 
> Signed-off-by: Bruna Bispo <blbispo1@gmail.com>
Applied
> ---
>  drivers/iio/chemical/ams-iaq-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
> index 164facac5..197a205ea 100644
> --- a/drivers/iio/chemical/ams-iaq-core.c
> +++ b/drivers/iio/chemical/ams-iaq-core.c
> @@ -24,7 +24,7 @@ struct ams_iaqcore_reading {
>  	u8 status;
>  	__be32 resistance;
>  	__be16 voc_ppb;
> -} __attribute__((__packed__));
> +} __packed;
>  
>  struct ams_iaqcore_data {
>  	struct i2c_client *client;


