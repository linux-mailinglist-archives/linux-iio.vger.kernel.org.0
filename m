Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B83276241
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWUjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUjS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:39:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F05820725;
        Wed, 23 Sep 2020 20:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600893557;
        bh=fpaxOO4caTyDzV0HwPDxBxcpxGFKceBEBc/YibQkKZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vqYgn6fuaoLsWsO+g/xHZ5gAd+kMytIOPfA2+8ushlm8ADxVWzvft4OD2t8+gisxa
         wSfznS4gMc4R3ovT8NnZbl5FImxW6wRVOTB3p0QT5kBWZmCw+zn14YXU+LUmgnVBRN
         3IGNs/SyvNWhO7jrWvqpPH3Ooi2Vfruou68RTFAM=
Date:   Wed, 23 Sep 2020 21:39:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: ad9467: add entry for for
 AD9434 ADC
Message-ID: <20200923213912.05dda5ef@archlinux>
In-Reply-To: <20200922132559.38456-4-alexandru.ardelean@analog.com>
References: <20200922132559.38456-1-alexandru.ardelean@analog.com>
        <20200922132559.38456-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 16:25:57 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Add entry for the AD9434 high-speed ADC which is supported by the 'ad9467'
> driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Probably want to tweak a few other bits of the binding.
It has some specific statements about the ad9467 as this is only
second device to be added.  Need to change to those to "ad9467 and similar"
or something like that + add description for this part.

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> index c4f57fa6aad1..0e8da8ee6975 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> @@ -19,6 +19,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,ad9434
>        - adi,ad9467
>  
>    reg:

