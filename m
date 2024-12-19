Return-Path: <linux-iio+bounces-13641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A11F9F7CE5
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F6A1655B5
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72796225403;
	Thu, 19 Dec 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsGrpqSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27019224B07;
	Thu, 19 Dec 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617733; cv=none; b=bMNmigNAi/L4BiaTOU3CES3+zvKY6ZNTbOYz/dC/0e1vgYgaFzuDKnvCoBIKo9RESrVH/MGkfNUWyUBzOACbVrVJBnEpwCbOs2qv7Pgp+cvn3zWpR0N/MKxO4np//9SXUja/Lsb1ucIkee1kBh0a59p8uo1l1wVRqRrgAnA/1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617733; c=relaxed/simple;
	bh=Pkr8Nu+6XlPZdxp8aV4CDfu8m5E5wxZJIn4chqQFl/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp6uUyluip2PmGZAjcWdb1yLnfs3ViWJ54QpCpM7hFJ9i9M010jNIvH5jw8Aith0IJA0r7G/HIjhz7t9YZ0ZCnlTc9uSDR4UHjLr/jCZVfAH3AdTel2thNImC1gxR3MQ/q1TKc0aPwp0WEDB/MVYYWS/ccbHa+tDf+MmLVr89jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsGrpqSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C25C4CECE;
	Thu, 19 Dec 2024 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734617732;
	bh=Pkr8Nu+6XlPZdxp8aV4CDfu8m5E5wxZJIn4chqQFl/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BsGrpqSHz4XFCIWuXzD+kpzRVwrZU+iU04gdkKyQR1CMmEpvDd9xTevvzxS8qkki7
	 9RCyn7QGs7Z/G9txbQsxS/5xM+45VGYTUglCYNSMYpK+5s7g0ZDNuXmqIqhrnXOTsL
	 CVcnkpo6ECWC7F2s2plKP2qTZGSd1Kuk4XwZFCsYgaPkTx6YtqUT8k+As19BImeIua
	 FytfW0S8fwXCG1YgkPJThZqvxW0JGpPaIemmRD4e9/H6c9QItAvnfBShanLFADSu0c
	 x35dvvpkxMx10xPJ7B4oPQCn+N2QvdCXvdLEgDQ9fZv8hcgbwIQejW86sOLnGAdAMw
	 7vNrAUcEGFI3A==
Date: Thu, 19 Dec 2024 14:15:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ana-Maria Cusco
 <ana-maria.cusco@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [RFC PATCH 3/4] iio: adc: Add support for AD4170
Message-ID: <20241219141521.4617323a@jic23-huawei>
In-Reply-To: <6a3gofna73cl7i36qkrptyyjwbnlenb6qzqildeeuobxgwh6be@p4hmb64fqc75>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
	<827daa6ba0882cc7974a9a61831e53dbf1ed5a78.1734530280.git.marcelo.schmitt@analog.com>
	<6a3gofna73cl7i36qkrptyyjwbnlenb6qzqildeeuobxgwh6be@p4hmb64fqc75>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 10:25:42 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, Dec 18, 2024 at 11:37:59AM -0300, Marcelo Schmitt wrote:
> > +#include <asm/div64.h>
> > +#include <linux/unaligned.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include "ad4170.h"
> > +  
> 
> No bindings header included? No usage of binding defines (I did look for
> them in case you have some incorrect include via other header)? So not a
> binding...

It's in the local header in this patch.

> diff --git a/drivers/iio/adc/ad4170.h b/drivers/iio/adc/ad4170.h
> new file mode 100644
> index 000000000000..5b24788314b1
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.h
> @@ -0,0 +1,316 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AD4170 ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <dt-bindings/iio/adc/adi,ad4170.h>

Agreed on the lack of them being used as widely as they should be though!

> 
> Best regards,
> Krzysztof
> 


