Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2835F46A57A
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348357AbhLFTUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 14:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348370AbhLFTUE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 14:20:04 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B0C061746
        for <linux-iio@vger.kernel.org>; Mon,  6 Dec 2021 11:16:35 -0800 (PST)
Received: from [81.101.6.87] (port=52500 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1muJTR-0005YD-H5; Mon, 06 Dec 2021 19:16:30 +0000
Date:   Mon, 6 Dec 2021 19:21:40 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: exynos-adc: Use correct node name
Message-ID: <20211206192043.16f5c0d4@jic23-huawei>
In-Reply-To: <20211206145427.218436-1-thierry.reding@gmail.com>
References: <20211206145427.218436-1-thierry.reding@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  6 Dec 2021 15:54:27 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> According to the murata,ncp15wb473 DT bindings, the node name should be
> "thermistor", so use that in order to make the example validate.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
Already a patch on list for this.  Rob said he'd pick it up with
some other dt-fixes.

id: 20211125152154.162780-1-geert@linux-m68k.org


Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index c65921e66dc1..81c87295912c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -136,7 +136,7 @@ examples:
>          samsung,syscon-phandle = <&pmu_system_controller>;
>  
>          /* NTC thermistor is a hwmon device */
> -        ncp15wb473 {
> +        thermistor {
>              compatible = "murata,ncp15wb473";
>              pullup-uv = <1800000>;
>              pullup-ohm = <47000>;

