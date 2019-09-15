Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB8B2FD5
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfIOMZA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 08:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfIOMZA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:25:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912882077C;
        Sun, 15 Sep 2019 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568550299;
        bh=Qmn0YOVP01iFmCMUHAKhcoFugQY4l23EPlhP77n/ctc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QiurHRezetO8qtwZ/9Y+nb/Kk6Va9/i4nzDeRf7T8dSgKuvuKoI8Uc7BiXiGlgCfM
         II87BBVkq/aPJdnlkeXccwE4uzl05MaX3DXkgwrO30UhGYDGUHMB9Q+imXDYb1i7ap
         t6nuEqJOUIfbPhAVFdrQLZGihusaGCrloFuthMzo=
Date:   Sun, 15 Sep 2019 13:24:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] dt-bindings: fix regulator names to not be constant.
Message-ID: <20190915132455.66fa344f@archlinux>
In-Reply-To: <20190908104007.6593-1-jic23@kernel.org>
References: <20190908104007.6593-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  8 Sep 2019 11:40:07 +0100
jic23@kernel.org wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This was corrected in the V4 patch, but I messed up and had applied
> the V3 patch.  Hence the need for this fix.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")

I've take the view this is a simple 'aligning' patch due to
my mess up so applied to the fixes-togreg branch so we get this
in after rc1.  If anyone wants to comment that's good though!

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 676ec42e1438..040af0bcc92e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -43,13 +43,11 @@ properties:
>  
>    dvdd-supply:
>      description: DVdd voltage supply
> -    items:
> -      - const: dvdd
> +    maxItems: 1
>  
>    avdd-supply:
>      description: AVdd voltage supply
> -    items:
> -      - const: avdd
> +    maxItems: 1
>  
>    adi,rejection-60-Hz-enable:
>      description: |

