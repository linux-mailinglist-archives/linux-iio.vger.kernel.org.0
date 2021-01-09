Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6A2F0327
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbhAIT07 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 14:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbhAIT07 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 14:26:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CFF23A31;
        Sat,  9 Jan 2021 19:26:16 +0000 (UTC)
Date:   Sat, 9 Jan 2021 19:26:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: magnetometer: bmc150: Document
 regulator supplies
Message-ID: <20210109192613.602ffe88@archlinux>
In-Reply-To: <20210109152327.512538-1-stephan@gerhold.net>
References: <20210109152327.512538-1-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  9 Jan 2021 16:23:26 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> BMC150 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Document support for vdd/vddio-supply to implement this.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Thanks for the quick resend!

Series applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it and see if they can find anything we missed.

Jonathan
> ---
> Changes in v2: Picked up Reviewed-by:, split patch series from bmg160
> ---
>  .../bindings/iio/magnetometer/bosch,bmc150_magn.yaml           | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
> index cdef7aeba708..2867ab6bf9b0 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
> @@ -30,6 +30,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vdd-supply: true
> +  vddio-supply: true
> +
>    interrupts:
>      maxItems: 1
>  

