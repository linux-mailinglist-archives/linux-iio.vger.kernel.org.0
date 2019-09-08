Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E50ACCA7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfIHMYW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfIHMYW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:24:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2894214D9;
        Sun,  8 Sep 2019 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567945461;
        bh=R8J4W+d0ox1DjstG6dr536g3NCaJQrjNtB6CXU66ThQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jZX9PB7lzQAIYJH+OiWTiFpmqXpN9clk6/YD+H9df4LOuBx+U/n988UO+ZhkLpKWw
         5CXsh2JEYZYg2h9E0H9/berXpjjswpT1fhCkFZeGs1m4KwtL8OQQPxswdV0tRboTkh
         cBI0kCmBO8c4SFsAVaSNvNvuF7WtRuZc2dxcoXbg=
Date:   Sun, 8 Sep 2019 13:24:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio/adc: Add AUX2 channel idx for
 JZ4770 SoC ADC
Message-ID: <20190908132414.2200a980@archlinux>
In-Reply-To: <20190727195940.14010-2-contact@artur-rojek.eu>
References: <20190727195940.14010-1-contact@artur-rojek.eu>
        <20190727195940.14010-2-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Jul 2019 21:59:39 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Introduce support for AUX2 channel found in ADC hardware present on
> Ingenic JZ4770 SoC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to mostly ignore it.

Thanks,

Jonathan

> ---
> 
> Changes:
> 
> v2: no change
> 
>  include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
> index 82706b2706ac..42f871ab3272 100644
> --- a/include/dt-bindings/iio/adc/ingenic,adc.h
> +++ b/include/dt-bindings/iio/adc/ingenic,adc.h
> @@ -6,5 +6,6 @@
>  /* ADC channel idx. */
>  #define INGENIC_ADC_AUX		0
>  #define INGENIC_ADC_BATTERY	1
> +#define INGENIC_ADC_AUX2	2
>  
>  #endif

