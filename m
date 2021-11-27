Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529A14600A1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 18:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355804AbhK0Rp6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 12:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355799AbhK0Rn6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 12:43:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9CC06175E;
        Sat, 27 Nov 2021 09:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA7960EE7;
        Sat, 27 Nov 2021 17:38:46 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id D4CFAC5831A;
        Sat, 27 Nov 2021 17:38:42 +0000 (UTC)
Date:   Sat, 27 Nov 2021 17:43:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: exynos-adc: Fix node name in
 example
Message-ID: <20211127174343.1b9dcabe@jic23-huawei>
In-Reply-To: <3fec093a-df46-6096-3f66-891734a5f140@canonical.com>
References: <20211125152154.162780-1-geert@linux-m68k.org>
        <3fec093a-df46-6096-3f66-891734a5f140@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Nov 2021 16:26:16 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On 25/11/2021 16:21, Geert Uytterhoeven wrote:
> > "make dt_binding_check":
> > 
> >     Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: ncp15wb473: $nodename:0: 'ncp15wb473' does not match '^thermistor(.*)?$'
> > 	    From schema: Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >   
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
This doesn't particularly feel like we need to rush it in, so applied
to the togreg branch of iio.git which will go in next merge window.

Shout if I should pull it to a fixes branch.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof

