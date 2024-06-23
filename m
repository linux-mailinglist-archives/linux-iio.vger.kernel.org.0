Return-Path: <linux-iio+bounces-6738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236791395F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AC4281B0E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CEB762FF;
	Sun, 23 Jun 2024 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz9aPk6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B812F2D;
	Sun, 23 Jun 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719136994; cv=none; b=WChSa4UrnFQeDSDW3/4YBMqjxWeeOmHu2Q4RAi8Vgk/PiQbo1qRsI+872NeEIJzddnUAMbq7P8nUBP9YbsCnXqqMNYg2rNV4B61iQZzowjrBzd5qkUmZYXVkGMFu+EWlvs4OyoU1qF3OFtuFCViL2GuvmG7BW+HoHCpBwPWD6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719136994; c=relaxed/simple;
	bh=q+7srLl/eTREfrAbzwHp5A/J+Kb0zwgTKHO6Qr08PfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYwLpseJXwvKxHjJMAhNDiet0ZF3ndKehZfyJy5RLt+wMukiaPPAhSbPVQugFVEoH8y1q7b50aCsxcn4+jw+rT7L4DyxcLrDnm8z5dOdzNQpHaHHk9hSPd1O4QFZVtypScN2hPF/6HPn/AWm1G+KihDmWU8A0Oo8S4o/N8X3nb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz9aPk6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB73C2BD10;
	Sun, 23 Jun 2024 10:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719136993;
	bh=q+7srLl/eTREfrAbzwHp5A/J+Kb0zwgTKHO6Qr08PfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mz9aPk6ipn6nM1DitEolvYsQmwUZf2qwAOZh6GMGUMaXtFYWvmO+ahsoqiiEZypqz
	 sWPP2cGUuYWQnSMTJXaqyZIUhSG+sJHXTeLlGLjWIHmdfG704H+O/CViDoutAacWV0
	 ZJJ8u19kuM89ymMQO2ofDA3NTBERJNI1n9lDNeOFfVEDYEwoZW3KAu+0fHltYoRqju
	 FgWXmo4v7wJlZCiPVVkr3wbsjVgq4+pecZGcg+H7ill4k1KtszCBNatrqfAZE0e8/C
	 GZ+OfNeG1Qt8W2pVdumfUShnJyDlKgFDcYTsROHGaDHoB6SYA6SmZpPLFh4612pIMW
	 jgkeKbaBWLVWg==
Date: Sun, 23 Jun 2024 11:03:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, denis.ciocca@st.com,
 devicetree@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240623110305.5d961052@jic23-huawei>
In-Reply-To: <20240622123520.39253-2-kauschluss@disroot.org>
References: <20240622123520.39253-1-kauschluss@disroot.org>
	<20240622123520.39253-2-kauschluss@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 18:03:46 +0530
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> LIS2DS12 is an accelerometer by STMicroelectronics. It is identifiable by
> its WhoAmI value 0x43.
> 
> Its register interface is not compatible with existing parts. For example:
> 
> - The full-scale values are present in register 0x20, in bits 2 and 3
>   (mask 0x0c). Most other supported sensors have the register address set
>   to 0x21, 0x23, 0x24, or 0x25. There is one sensor setting though
>   (bearing WhoAmI 0x3b) which has it's address set to 0x20, but the mask is
>   set to 0x20, not 0x0c.
> 
> - The full-scale values 2G, 4G, 8G, and 16G correspond to the register
>   values 0x00, 0x02, 0x03, 0x01 respectively. None of the sensor settings
>   have the value 0x01 associated with 16G.
> 
> Add the compatible string without any fallback.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Given the only requested change was this description and everyone seemed
happy with it in previous thread, I'll pick this series up now.
Note that I can still add any tags that come in as it'll only be
pushed out as testing for the next few days.

Applied to the togreg branch of iio.git and pushed out as testing to
let 0-day have a first go at seeing what we missed.

I made one tweak in patch 1 description.  Datasheet is a tag
so no blank line between that and the main tags block as it
will break some automation.

> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> index fff7e3d83a02..71c1ee33a393 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -26,6 +26,7 @@ properties:
>            - st,lis2dw12
>            - st,lis2hh12
>            - st,lis2dh12-accel
> +          - st,lis2ds12
>            - st,lis302dl
>            - st,lis331dl-accel
>            - st,lis331dlh-accel


