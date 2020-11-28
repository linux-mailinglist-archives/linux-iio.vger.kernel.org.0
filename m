Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0AD2C756F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgK1VtV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731797AbgK1SCx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 13:02:53 -0500
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764FFC09B051;
        Sat, 28 Nov 2020 07:33:45 -0800 (PST)
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id E41D69E015C;
        Sat, 28 Nov 2020 15:33:41 +0000 (GMT)
Date:   Sat, 28 Nov 2020 15:33:40 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jishnu Prakash <jprakash@codeaurora.org>
Subject: Re: [PATCH 1/9] dt-bindings:iio:qcom-spmi-vadc drop incorrect
 io-channel-ranges from example
Message-ID: <20201128153340.62cef0f9@archlinux>
In-Reply-To: <20201115192951.1073632-2-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
        <20201115192951.1073632-2-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 19:29:43 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> io-channel-ranges is a property for io-channel consumers. Here
> it is in an example of a provider of channels so doesn't do anything
> useful.
> 
> Recent additions to dt-schema check this property is only provided
> alongside io-channels which is not true here and hence an error is
> reported.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reported-by: Rob Herring <robh@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Jishnu Prakash <jprakash@codeaurora.org>

I'm not usually keen on taking my own patches without review, but I don't want
to leave this obvious breakage in tree longer than necessary.

So I've applied this to the togreg branch of iio.git and pushed it out as
testing for the autobuilders to poke at it.

Note still time for last minute reviews as can rebase for next day or two.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index 7f4f827c57a7..95cc705b961b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -48,8 +48,6 @@ properties:
>      description:
>        End of conversion interrupt.
>  
> -  io-channel-ranges: true
> -
>  required:
>    - compatible
>    - reg
> @@ -249,7 +247,6 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>          #io-channel-cells = <1>;
> -        io-channel-ranges;
>  
>          /* Channel node */
>          adc-chan@39 {

