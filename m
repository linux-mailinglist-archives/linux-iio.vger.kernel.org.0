Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC131B8702
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDYO1S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 10:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgDYO1S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 10:27:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52EEF206B9;
        Sat, 25 Apr 2020 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587824838;
        bh=RTdvF1eYXWColX5KDaL53aWyOTQf+iEt4motO1/Fd2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VpPN1rtVkuWSanfDGSHyQEAh0HfquK+uEpXtBiOKiGpC0VSIhL8GT1U6CFEXg9M4M
         vmQ6n5r6n6CZrQ5+EePZ8p+dXR2QFvdv2K9TEjMOkWzqYf3i42lshtRnMtt4QAnnvK
         ysw2AsJvo1nYtDulhB1iB2QmIOzgbmgTKA18iV8k=
Date:   Sat, 25 Apr 2020 15:27:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: chemical: add Atlas Scientific
 RTD-SM sensor docs
Message-ID: <20200425152714.771667b5@archlinux>
In-Reply-To: <20200425072520.27776-2-matt.ranostay@konsulko.com>
References: <20200425072520.27776-1-matt.ranostay@konsulko.com>
        <20200425072520.27776-2-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 10:25:19 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> index edcd2904d50e..0e510a52920d 100644
> --- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> +++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> @@ -17,6 +17,7 @@ description: |
>      http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
>      http://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
>      http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
> +    http://www.atlas-scientific.com/_files/_datasheets/_oem/RTD_oem_datasheet.pdf
>  
>  properties:
>    compatible:
> @@ -25,6 +26,7 @@ properties:
>        - atlas,ec-sm
>        - atlas,orp-sm
>        - atlas,ph-sm
> +      - atlas,rtd-sm
>  
>    reg:
>       maxItems: 1

