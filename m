Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4C92C7541
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbgK1VtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbgK1Skw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:40:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C74246AD;
        Sat, 28 Nov 2020 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606577826;
        bh=TMRrgzMorywJj2/Zw49Mmp/25hgyT+Mjxg62g2o5keA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LQerzBnpkbUTf7oc0NQVtnL+sau72gS0dLf/aq+V0V9bQF2t8TQ+8+eQQ6I+qebNW
         wDwzBX7sfPGzHxagdJN1UNVYxKniynNycuiGiz5QuKntgC5tiNDGVgpsVkQSFnJrz3
         ondhDMaDD20f0936EizzpCV7rS08zFBNxAPRAvr8=
Date:   Sat, 28 Nov 2020 15:37:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 6/9] ARM: dts: qcom-pma8084: Drop incorrect use of
 io-channel-ranges
Message-ID: <20201128153702.7d144f68@archlinux>
In-Reply-To: <20201115192951.1073632-7-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
        <20201115192951.1073632-7-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 19:29:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This property is used by io-channel consumers, not providers so should
> not present here.  Note dt_schema will now detect this error as there
> is a dependency between this property and io-channels.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
+CC Andy on an up to date email. Also added linux-arm-msm
which I should have cc'd in the first place.

I've taken the yaml fix related to this so just a question of
cleaning up this loose end in the dtsi

Thanks,

Jonathan

> ---
>  arch/arm/boot/dts/qcom-pma8084.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
> index ea1ca166165c..e921c5e93a5d 100644
> --- a/arch/arm/boot/dts/qcom-pma8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
> @@ -68,7 +68,6 @@ pma8084_vadc: vadc@3100 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			#io-channel-cells = <1>;
> -			io-channel-ranges;
>  
>  			die_temp {
>  				reg = <VADC_DIE_TEMP>;

