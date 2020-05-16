Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A021D62C7
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEPQ4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 12:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgEPQ4G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 12:56:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAF120657;
        Sat, 16 May 2020 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589648166;
        bh=QgeIVhy2kwQDHymvq3C/IVPWwd2iwLwZuiQrCx153ZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AvDFfPVKivFLE6SvFD6U5hNtG+s0g2nZ1WxG2/i04gxqUHBBxve9ig3A6xLSrZi9j
         6Di3xINfbFRhdxFnUc6yW3Vr/wzg/zGL3nDR7+ZrmKNrIkxQ8uriBYDhzoJrOxqWGR
         FcQtkm7ADVIgfGvYyOa1apBqJhTkgggLw9uD88kE=
Date:   Sat, 16 May 2020 17:56:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: chemical: add CO2 EZO module
 documentation
Message-ID: <20200516175602.12473d0f@archlinux>
In-Reply-To: <20200511023214.14704-2-matt.ranostay@konsulko.com>
References: <20200511023214.14704-1-matt.ranostay@konsulko.com>
        <20200511023214.14704-2-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 May 2020 05:32:13 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
This crossed with the RTD driver, so applied with fuzz to the togreg
branch of iio.git and pushed out as testing for the autobuilders to play
with it.  As ever if a DT maintainer wants to comment there is still
time to add tags (though in this case it is trivial enough I'd not waste
your time reading it!)

Jonathan

> ---
>  .../devicetree/bindings/iio/chemical/atlas,sensor.yaml      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> index edcd2904d50e..0d109e1b34ee 100644
> --- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> +++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> @@ -4,19 +4,20 @@
>  $id: http://devicetree.org/schemas/iio/chemical/atlas,sensor.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Atlas Scientific OEM sensors
> +title: Atlas Scientific OEM + EZO sensors
>  
>  maintainers:
>    - Matt Ranostay <matt.ranostay@konsulko.com>
>  
>  description: |
> -  Atlas Scientific OEM sensors connected via I2C
> +  Atlas Scientific OEM + EZO sensors connected via I2C
>  
>    Datasheets:
>      http://www.atlas-scientific.com/_files/_datasheets/_oem/DO_oem_datasheet.pdf
>      http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
>      http://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
>      http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
> +    http://www.atlas-scientific.com/_files/_datasheets/_probe/EZO_CO2_Datasheet.pdf
>  
>  properties:
>    compatible:
> @@ -25,6 +26,7 @@ properties:
>        - atlas,ec-sm
>        - atlas,orp-sm
>        - atlas,ph-sm
> +      - atlas,co2-ezo
>  
>    reg:
>       maxItems: 1

