Return-Path: <linux-iio+bounces-13630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545389F786A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10EE1615FF
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD672206B3;
	Thu, 19 Dec 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNo2++u6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F9149DF4;
	Thu, 19 Dec 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600346; cv=none; b=bLn1IiblQTjTgMnEo5KkshZMqclvTe5+WBlmoAB7DARbl8+aACgHhTbiB7sfHT/+CzT16MdM4ZzffUAb540LebvzzGv5UBRIAxONe3Hbb4eceKa8/DVTJEJ5g1V+GNZLvHsNQC5Uv34SupJcUsVF4tlTzDpwiGTf+VbqbS7GO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600346; c=relaxed/simple;
	bh=RiVs4vHHPFNKa9gxFhvBrQr/L++mlNtDRqRq7uDDW3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAwK3QBlM0VIwcvzTYRCZ9gMCl3gAAx/rfX+mdwSLB8f+x0QrPlkTuKOJYcTlV5qQoJSCZppzKlr8oNErqkqlROfwVLH5wmiIH9Br+Hs27aSBE2O/ZQVQFatMtvSLThS9gzDqkkr9Vj9Hz2jC8Qe2O+mTDsRkI0Y4YGjDMCYzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNo2++u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EFBC4CECE;
	Thu, 19 Dec 2024 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734600346;
	bh=RiVs4vHHPFNKa9gxFhvBrQr/L++mlNtDRqRq7uDDW3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNo2++u6NAPUtvUpfexcCVgDGV8uzgzOcmWdOGXXYBRmnvBFKbyIsQVt2to2HnmAb
	 GDLFCEPu57iqa8etOhR/8tVzFeF8HPpVWfze/gAmWfVlZWNpBqhxJ+qCz4ODE0TuE0
	 b/3cJimHGhzot5EuCjodCQmW/iTCSXY/84wUgrllCLee1o5lmxErbFOnzIPtGp0NCA
	 3GYFf8H81XvltFsHjlxM3zma97RczAksWuZSIHMXQX8u67cejf8QUCdu3mufr2bh/M
	 efK5ZYyI4h+lNNnpuSzycFxEpWlXdbn6E0Q7GGsYGANHSjUhIhBEDFvs1s+nR2MW/5
	 6prvtOjn4NOzA==
Date: Thu, 19 Dec 2024 10:25:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com, 
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [RFC PATCH 3/4] iio: adc: Add support for AD4170
Message-ID: <6a3gofna73cl7i36qkrptyyjwbnlenb6qzqildeeuobxgwh6be@p4hmb64fqc75>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
 <827daa6ba0882cc7974a9a61831e53dbf1ed5a78.1734530280.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <827daa6ba0882cc7974a9a61831e53dbf1ed5a78.1734530280.git.marcelo.schmitt@analog.com>

On Wed, Dec 18, 2024 at 11:37:59AM -0300, Marcelo Schmitt wrote:
> +#include <asm/div64.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include "ad4170.h"
> +

No bindings header included? No usage of binding defines (I did look for
them in case you have some incorrect include via other header)? So not a
binding...

Best regards,
Krzysztof


