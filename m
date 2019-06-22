Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3672E4F4C5
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFVJgn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVJgn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:36:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B922075E;
        Sat, 22 Jun 2019 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561196202;
        bh=eXC8Xq9kLci/NGLyBfxyNU889cVJ+lqdS50qW2RhjsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nTQtIPcxBLV3ybuRfTtxjC4XTFwE+Gh5YXhMygJKNNLNrDDnXeSN/jK5izqRCx2vr
         jNJ64iiYnqA5fQgqr1JI8vIUTzByd5MCkAgG4+d1HUviunMy32fSgcgXJPQTxc+N3r
         zD4Sntl1TNsAd4Nk+HYZTt/wBbugEDDOCfQOr5nI=
Date:   Sat, 22 Jun 2019 10:36:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: stm32: add missing vdda
 supply
Message-ID: <20190622103636.63148958@archlinux>
In-Reply-To: <1560947398-11592-2-git-send-email-fabrice.gasnier@st.com>
References: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
        <1560947398-11592-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jun 2019 14:29:54 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add missing vdda-supply, analog power supply, to STM32 ADC. It's required
> to properly supply the ADC.
> 
> Fixes: 841fcea454fe ("Documentation: dt-bindings: Document STM32 ADC DT
> bindings")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore completely.

thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 8346bcb..93a0bd2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -38,6 +38,7 @@ Required properties:
>      It's required on stm32h7.
>  - clock-names: Must be "adc" and/or "bus" depending on part used.
>  - interrupt-controller: Identifies the controller node as interrupt-parent
> +- vdda-supply: Phandle to the vdda input analog voltage.
>  - vref-supply: Phandle to the vref input analog reference voltage.
>  - #interrupt-cells = <1>;
>  - #address-cells = <1>;

