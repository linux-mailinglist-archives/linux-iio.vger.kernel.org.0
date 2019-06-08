Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165C739D1C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFHLU3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfFHLU3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:20:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C7D9214AE;
        Sat,  8 Jun 2019 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559992828;
        bh=FXMideIF/i7BlqdYMx4NE3DjZcbXMBRlAq1d9sy/jAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H23J+hIpmBfyH9PXu0JdQJ0s5ae391wL0DDdQOJhfBk4Ya2ea5X0rrRM0uFiyw+6q
         TeKnTL1EVfjuiD/hIMS2J/I4+2j0zpXavDRvlXy4pB5v1T2hp6IFGgnyuPsHIk8lhc
         mL8npCdgsImvm2PQyz/7L4elNJPuRIsQ7TN6TBB0=
Date:   Sat, 8 Jun 2019 12:20:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MAINTAINERS: add entry for ad7780 adc driver
Message-ID: <20190608122000.46440386@archlinux>
In-Reply-To: <7ccb64ba4da8f24981009187e975d71372d62fbf.1558746978.git.renatogeh@gmail.com>
References: <cover.1558746978.git.renatogeh@gmail.com>
        <7ccb64ba4da8f24981009187e975d71372d62fbf.1558746978.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 May 2019 22:26:55 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch adds a MAINTAINERS entry for the AD7780 ADC driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
to be completely ignored by the autobuilders.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 54c8e14fae98..d12685c5b09a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -880,6 +880,15 @@ S:	Supported
>  F:	drivers/iio/adc/ad7768-1.c
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
>  
> +ANALOG DEVICES INC AD7780 DRIVER
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +M:	Renato Lui Geh <renatogeh@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/adc/ad7780.c
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org

