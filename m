Return-Path: <linux-iio+bounces-17081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D9A68721
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 09:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26DA420EA4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B32517A2;
	Wed, 19 Mar 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxFxN7bN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C415A85A;
	Wed, 19 Mar 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373757; cv=none; b=F9HRJ7ESJMzfQrWiRQ8zA1X2vEQ5b5hkF4mmwj34LGJXHVhk0bLFBmWe+hfk7nPLVBrFJJZU3lLjVMK0AEgNP6xbjwGecIIAobHnQ1+l3FrEW2B1cyUne0ysB7wJPWvg3gONVlMtlncltfkOLuyexWGoCfrHKRSU/lyUAqS6X18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373757; c=relaxed/simple;
	bh=n1ARy2xtanaq2K8YW4bO0qXroV+vyKBme9kkKS/C0UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQmRzKgeGfuFhdQK39RxV/cFVJmSnFuF7hToetmiPjEz7z3BIKeMxYdYy1b2q1UcCpp30JLQstA7dusJXEpNZ9ez1glvoDh4PrWN3uHHuS4qoMwbrWa9H8lmV2UWGdJ1MraVZqcpgmq1elq0FJ/JG9DcJSroVwbOAGV916NLNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxFxN7bN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBADAC4CEE9;
	Wed, 19 Mar 2025 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373756;
	bh=n1ARy2xtanaq2K8YW4bO0qXroV+vyKBme9kkKS/C0UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxFxN7bNbyhZ2zPp3+uRIGnWQAfm4MLOe8hqUb5z5h9U9XOiToGB5O+sPajC2kXux
	 EeO0egUeqOwp1vu2w2l5+0CHJjxOP2H+PriuQ0Xg1gReczcmc62FM+UqMa/+hhsoBn
	 1xFyaoHZE2ee8yUej61RkBh4tGnjloUNNuHRubcnqQwH8Nw06WA8T/uB1eGcnUfaEd
	 6SjnVVz4U5fFwSNfPZ8sztPWuMUXVlPVxa66NJs47EEUySJgyL9NmQPZ6cLHqfC56o
	 0oGqqiWGMad7OLj29okG8CcgPqsKLGvTA6IeyI1FwvGhyxJBfyTNP6RpZ/ST5qbdlR
	 tnUI+VHUeWGtQ==
Date: Wed, 19 Mar 2025 09:42:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sergio Perez <sergio@pereznus.es>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
Message-ID: <20250319-elated-illegal-griffin-4ff0aa@krzk-bin>
References: <20250318194624.7626-1-sergio@pereznus.es>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318194624.7626-1-sergio@pereznus.es>

On Tue, Mar 18, 2025 at 08:45:54PM +0100, Sergio Perez wrote:

Your threading is completely broken.

Read my last message - I gave you clear instructions which you did not
follow. Why?

>  
> +  reset-gpios:
> +    description: GPIO connected to the sensor's reset line (active low)

"Active low reset line". No point to say that GPIO is a "GPIO connected
to the...", because it cannot be anything else.

> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -39,6 +43,7 @@ examples:
>        light-sensor@23 {
>          compatible = "rohm,bh1750";
>          reg = <0x23>;
> +        reset-gpios = <&gpio2 17 0>;

1. Include header and use proper defines
2. And then you will see that it is not active low, like you claim in
description...

>        };
>      };
>  
> -- 
> 2.43.0
> 

