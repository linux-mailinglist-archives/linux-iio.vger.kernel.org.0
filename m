Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1824256BB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhJGPjW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 11:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhJGPjW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 11:39:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E48061139;
        Thu,  7 Oct 2021 15:37:26 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:41:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     lars@metafoo.de, robh+dt@kernel.org, stephan@gerhold.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Document liteon
 vendor prefix
Message-ID: <20211007164130.57304c72@jic23-huawei>
In-Reply-To: <20211006163058.145842-1-nikita@trvn.ru>
References: <20211006163058.145842-1-nikita@trvn.ru>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  6 Oct 2021 21:30:55 +0500
Nikita Travkin <nikita@trvn.ru> wrote:

> Add vendor prefix for LITE-ON Technology Corp.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Series looks good to me. I'll leave some time for dt binding review though
before picking it up.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 1d77f151555b..477a5cba16fe 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -659,6 +659,8 @@ patternProperties:
>      description: Linux-specific binding
>    "^linx,.*":
>      description: Linx Technologies
> +  "^liteon,.*":
> +    description: LITE-ON Technology Corp.
>    "^litex,.*":
>      description: LiteX SoC builder
>    "^lltc,.*":

