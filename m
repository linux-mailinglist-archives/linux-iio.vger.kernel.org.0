Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9EC68006
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfGNQMU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfGNQMU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:12:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9944E205F4;
        Sun, 14 Jul 2019 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563120738;
        bh=jQ0f569z2zUiXdImrPkJu/Fo2TGV+neywvRzlzhGgrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PSjJbnPIDw7/YQwyII6FXeqylpSOLkQsP48YfC+L+kwj2Y1lAZ/A4dVA8M6yp6T9s
         biqbxmYYYElipW9E91i3xFmwHFfLR/jM5h2ElZY4bse0b9ahjAyzTRyIDgyqIVXRv6
         q2ZfqviNOJiqwbuInLSgljaqEt5bOy6K1GpVdf4s=
Date:   Sun, 14 Jul 2019 17:11:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: stm32: add analog
 switches supply control
Message-ID: <20190714171141.12fc2d1d@archlinux>
In-Reply-To: <1562148496-26789-2-git-send-email-fabrice.gasnier@st.com>
References: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
        <1562148496-26789-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jul 2019 12:08:14 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On stm32h7 and stm32mp1, the ADC inputs are multiplexed with analog
> switches which have reduced performances when their supply is below 2.7V
> (vdda by default). Booster or vdd can be used, to get full ADC
> performances.
> 
> Add documentation for:
> - optional booster-supply that can be used on stm32h7 and stm32mp1.
> - optional vdd-supply that can be used on stm32mp1 to supply analog
>   circuitry, selected by syscfg.
> Mark these as optional, since this is a trade-off between analog
> performance and power consumption.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Seems fine to me. Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Rework since: "Add missing vdda-supply to STM32 ADC" series.
> - Add booster-supply regulator description
> - typo: input switches
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 93a0bd2..4c0da8c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -47,6 +47,12 @@ Required properties:
>  Optional properties:
>  - A pinctrl state named "default" for each ADC channel may be defined to set
>    inX ADC pins in mode of operation for analog input on external pin.
> +- booster-supply: Phandle to the embedded booster regulator that can be used
> +  to supply ADC analog input switches on stm32h7 and stm32mp1.
> +- vdd-supply: Phandle to the vdd input voltage. It can be used to supply ADC
> +  analog input switches on stm32mp1.
> +- st,syscfg: Phandle to system configuration controller. It can be used to
> +  control the analog circuitry on stm32mp1.
>  
>  Contents of a stm32 adc child node:
>  -----------------------------------

