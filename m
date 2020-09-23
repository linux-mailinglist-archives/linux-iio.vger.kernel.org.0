Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131B8276249
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIWUk4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWUk4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:40:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D3220725;
        Wed, 23 Sep 2020 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600893655;
        bh=VZAi8IZ8tUNnevhhgcOA3kUhkB2bZJm7KUUnPVHxCG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R1ZD2ekd+ulmuCc1RxaBdjE7lR96ZzTqfIDFuwUpfpjRP/RknBCz14jld0/CspheB
         FAljCkOOu0x8RNRSRwdLHh+f+UoYqVTlUQHcA9Zda32c5uZucLi2+5VUtM0/Gd159L
         8l0n/rM6M+G8vRHS2tUXGnigqGFKab/knHj1XSIg=
Date:   Wed, 23 Sep 2020 21:40:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: iio: ad9467: add entry for for
 AD9265 ADC
Message-ID: <20200923214050.5840b880@archlinux>
In-Reply-To: <20200922132559.38456-6-alexandru.ardelean@analog.com>
References: <20200922132559.38456-1-alexandru.ardelean@analog.com>
        <20200922132559.38456-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 16:25:59 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Add entry for the AD9265 high-speed ADC which is supported by the 'ad9467'
> driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hi Alex,

Will probably be some extra stuff to add for this one to the description
part of the binding.

Feel free to roll this one and patch 3 together if you want to.

The code changes all look fine to me in the other patches.

Thanks,

Jonathan


> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> index 0e8da8ee6975..8b8c432c64da 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> @@ -19,6 +19,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,ad9265
>        - adi,ad9434
>        - adi,ad9467
>  

