Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E127D30D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgI2PsT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 11:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2PsT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 11:48:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00729206D9;
        Tue, 29 Sep 2020 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601394498;
        bh=WW9lgDeN8iQFoq7lTXLFBgvRZng4yjecbQILCi4uOd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NIno9hhau8LsyYnfVKhWqYr7gfl/Yh8wBMCWreIxuqNk0Yj207B4DQ1tb3FFgcxMt
         qGz50qnVmVUWGEVAOStcyHD42XhDl8ci5cIwSZfyGfRFRw7/Ce2EOqDm3bBQaGy5fm
         KpFnzsWuDAUaiIG9H/jxJbf8i2Y1n9tRgrkbl1zs=
Date:   Tue, 29 Sep 2020 16:48:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/5] dt-bindings:iio:adc:adc.txt: Add documentation
 for channel label attribute
Message-ID: <20200929164813.2a9bfcf7@archlinux>
In-Reply-To: <20200928090959.88842-5-cristian.pop@analog.com>
References: <20200928090959.88842-1-cristian.pop@analog.com>
        <20200928090959.88842-5-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 12:09:59 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> Optional attribute for better identification of the channels.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

This one is on my list of binding files to convert fairly soon
so I'm fine with this going in whilst it's still in txt form.

The addition of reg here shows up a quirk of this binding.  We
originally introduced it to specify differential pairs, hence
the @ can refer to the first value of diff-channels instead
of reg.  Hopefully I'll remember to clarify that when doing the
yaml conversion.

The series looks good to me, but given timing it won't make the
merge window for the coming cycle.
+CC Rob and the dt list.

> ---
> Changes in v7:
>  - Add this extra commit
>  Documentation/devicetree/bindings/iio/adc/adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
> index 5bbaa330a250..4b37575bbddc 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
> @@ -5,18 +5,24 @@ Optional properties for child nodes:
>  - diff-channels : Differential channels muxed for this ADC. The first value
>  		specifies the positive input pin, the second value the negative
>  		input pin.
> +- reg: The channel number.
> +- label: Unique name to identify which channel this is.
>  
>  Example:
>  	adc@0 {
>  		compatible = "some,adc";
>  		...
>  		channel@0 {
> +			reg = <0>;
> +			label = "channel_0_name";
>  			bipolar;
>  			diff-channels = <0 1>;
>  			...
>  		};
>  
>  		channel@1 {
> +			reg = <1>;
> +			label = "channel_1_name";
>  			diff-channels = <2 3>;
>  			...
>  		};

