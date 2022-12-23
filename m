Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C508D65526E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 16:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiLWPvA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 10:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiLWPu7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 10:50:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A6263C5;
        Fri, 23 Dec 2022 07:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C977AB820EA;
        Fri, 23 Dec 2022 15:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EACC433D2;
        Fri, 23 Dec 2022 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671810656;
        bh=kBnt6c+xPK/PYr9W28KzLKm+YufOtx3oqN0N6kNlx4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EQS6n0V6KZcY2WfsniCNI7qQ7yCasrtl0A6ex1YLUusNaefMHIzmtCSDX8B5ts7sY
         +9WSQFE1G08UfUqkoordnxhihHvuZo7RIsBBZaETujHjK2rT9zh0Km5MZbbv5HwDHd
         X9NCdT51bm6CRDPQxgMHGDautzRLAO7561rdez5L8R4YJ3nzdbW3K+vTbBB8GdXlLb
         M7PnKWXZ9kDc7jQHoC6yHJYT3IuEKHWJ5wG4ND7101wARBSzdmNK0o95a468Q2Ej5X
         HN6Ct4Rx1ng1sEokraYzQOrXmeRpaTSAEOkZPHSR359QGhW0Ut5qxS8HWLdxyVU2Ct
         puNzoPhejT8cg==
Date:   Fri, 23 Dec 2022 16:04:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Fabio Estevam <festevam@denx.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: max1238: Fix a typo in the
 description
Message-ID: <20221223160405.32ba9716@jic23-huawei>
In-Reply-To: <e7b95521-9a2d-7c0f-a379-b32d4aaf1031@linaro.org>
References: <20221216004015.2902966-1-festevam@denx.de>
        <e7b95521-9a2d-7c0f-a379-b32d4aaf1031@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Dec 2022 12:30:42 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/12/2022 01:40, Fabio Estevam wrote:
> > Fix a typo in the description, where "interface" is spelled incorrectly.
> > 
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> > index 50bcd72ac9d6..60d7b34e3286 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml  
> 
> While fixing such, fix also max1363 in the same patch. Or maybe even
> more files (but then usually split per maintainer).

Absolutely agree that it would be good to fix the other instances.
Still, I'm not going to not take the one fix in front of me today
whilst waiting on that ;)

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

