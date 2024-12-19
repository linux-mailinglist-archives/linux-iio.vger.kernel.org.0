Return-Path: <linux-iio+bounces-13629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EBF9F7867
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 10:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F179018868EF
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01D22331A;
	Thu, 19 Dec 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH8IwiBv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C6222D7C;
	Thu, 19 Dec 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600149; cv=none; b=DJbr5RkMzraS0z1gmLOxuM+azTRy0fdaP6dEFeoKsPz9mlho5EtOsmIhynlIa/Whx3Bjad3b+osVdB1IeNDkpd++6qNrePnXMBP/8kGp/BEGa3T9pPOX3lbjoc2RAQ4Joeh93ljf5Dr6a73WOlwFP7AVuUHS1hqpDsZ8kIn7Lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600149; c=relaxed/simple;
	bh=3tS10k4IOjDcPr10Ejz50H+xn32a4PmOVOdp4UJ9QXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTeGlMIHgnYzpINmLYQ1Q/VAXgOddHb3VkJS+3vhgPDf6La0JmQjjQsrf+THsB33HB2ZKMgFAwAgVLdCKWCUPlmPHbR6Y+1nGcdSHNiL8CZhVEaHuVVYJ6SGj3O+PtmYwJbZBxoa8BbEMuGeY5WRqCjlLQKt6oIxuNcWIPIaii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH8IwiBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC036C4CED0;
	Thu, 19 Dec 2024 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734600146;
	bh=3tS10k4IOjDcPr10Ejz50H+xn32a4PmOVOdp4UJ9QXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lH8IwiBvmcJDcJRHwy2rUgxFbXF7FJigBq3SVVKe0WrS06RZvPVPF6Qjko+W7/oS9
	 5jRNgZ4/m8f3rNArJhp+u48RLemmx1bK90+DclNG5C5xtbDdN6ZYWNUoXJ6nlm5kt1
	 lfNxZuSJI+DHemyh7/LzFtuFh9biPErAhi1NfNvYer9HaIf3s9nfW/bvwDbkd2+QNP
	 ll9q18btcMJq0n4vDR3fgr3g369Rgujmncgu3YmXBWl/W4oZn8kAvOnF/BctBLQEAp
	 qpOUre8+nSpHX9RL2uAqNPQVBpmUvzw31cCJEvOEfquwQOL9F46HlPFz1gYSoIOZhh
	 RUz7aeC6HJyhQ==
Date: Thu, 19 Dec 2024 10:22:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [RFC PATCH 1/4] include: dt-bindings: iio: adc: Add defines for
 AD4170
Message-ID: <ikq55kcfu2lmxzeeobu4zwf67xypyikadnpycw2m4d7o6gvmi2@tkepvcvzqzoh>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
 <973852b372f8ecf3a62dc7e5b26d75bfaab99a4d.1734530280.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <973852b372f8ecf3a62dc7e5b26d75bfaab99a4d.1734530280.git.marcelo.schmitt@analog.com>

On Wed, Dec 18, 2024 at 11:37:26AM -0300, Marcelo Schmitt wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> 
> Add defines to improve readability of AD4170 device tree nodes.

Binding headers define the ABI between driver and DTS. Improving
readability of DTS is not their purpose.

Explain why this is binding. Also, I don't get why this is separate from
device binding - see git log history how various IDs are being added.

> 
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  include/dt-bindings/iio/adc/adi,ad4170.h | 96 ++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/adi,ad4170.h
> 
> diff --git a/include/dt-bindings/iio/adc/adi,ad4170.h b/include/dt-bindings/iio/adc/adi,ad4170.h
> new file mode 100644
> index 000000000000..a508b37e9a46
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/adi,ad4170.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * AD4170 ADC
> + *
> + * Copyright 2024 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.

No, you cannot say something else than SPDX. Anyway, drop license
boilerplate text.

> + */
> +
> +#ifndef _DT_BINDINGS_IIO_ADC_AD4170_H_
> +#define _DT_BINDINGS_IIO_ADC_AD4170_H_
> +

Best regards,
Krzysztof


