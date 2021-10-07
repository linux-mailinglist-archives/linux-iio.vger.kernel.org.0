Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2452425708
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhJGPvi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 11:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232870AbhJGPvi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 11:51:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8B9610E6;
        Thu,  7 Oct 2021 15:49:40 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:53:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v6 5/6] Documentation:devicetree:bindings:iio:dac: Fix
 val
Message-ID: <20211007165344.6a966a93@jic23-huawei>
In-Reply-To: <20211007080035.2531-6-mihail.chindris@analog.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
        <20211007080035.2531-6-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Oct 2021 08:00:36 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> A correct value for output-range-microvolts is -5 to 5 Volts
> not -5 to 5 milivolts
> 
> Fixes: e904cc899293f ("dt-bindings: iio: dac: AD5766 yaml documentation")
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Whilst it's only a trivial fix to an example it seems to me a worthwhile
thing to backport and avoid people using old trees seeing the wrong example

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> index d5c54813ce87..a8f7720d1e3e 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> @@ -54,7 +54,7 @@ examples:
>  
>            ad5766@0 {
>                compatible = "adi,ad5766";
> -              output-range-microvolts = <(-5000) 5000>;
> +              output-range-microvolts = <(-5000000) 5000000>;
>                reg = <0>;
>                spi-cpol;
>                spi-max-frequency = <1000000>;

