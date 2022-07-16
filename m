Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB84F576F47
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiGPOmx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGPOmw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 10:42:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A59518E2F;
        Sat, 16 Jul 2022 07:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22516114E;
        Sat, 16 Jul 2022 14:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBBDC34114;
        Sat, 16 Jul 2022 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657982571;
        bh=eOxY2iaOr7ftCDgaaxan6wDaK+DSMrvqJd7xNzTcB9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pc1VC70iFl8HAD97A0rKOSnpfLss1Amxh+DJUNbbNta6vJniHEJaBfxbou05jU5yf
         9i0xREjE5p+9ZxO9vX975RwTMLzAVTij7Jbsnyt8EPFNTpFcriWtS85SsQuReUWnnQ
         ugWZs3pLqtFObDAkDAbuX2Xw9lg9fVOxpAOJo3n3ZukziRz/yHtWRBDxkNz+EIp+Nb
         7UaEIFOgIYgtAP8Y/ycUeWA/Asbm433DGzFTaLr7PKDZgfO5O7gSZBBrN7ujMKbwD6
         TOnc7/3eGfAuNo3E4psMIWUBEtnPRsKo8eDq6JVjpeOynqbcETFT53cVVKIkOsshQ2
         I/7AGASZuJFBg==
Date:   Sat, 16 Jul 2022 15:52:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-imx@nxp.com, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles
Message-ID: <20220716155243.4b1c8ba9@jic23-huawei>
In-Reply-To: <8090017.T7Z3S40VBb@steina-w>
References: <20220613123529.466528-1-alexander.stein@ew.tq-group.com>
        <12003373.O9o76ZdvQC@steina-w>
        <20220628210919.GB963202-robh@kernel.org>
        <8090017.T7Z3S40VBb@steina-w>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jul 2022 09:56:45 +0200
Alexander Stein <alexander.stein@ew.tq-group.com> wrote:

> Am Dienstag, 28. Juni 2022, 23:09:19 CEST schrieb Rob Herring:
> > On Mon, Jun 20, 2022 at 10:12:44AM +0200, Alexander Stein wrote:  
> > > Hello,
> > > 
> > > Am Samstag, 18. Juni 2022, 19:01:29 CEST schrieb Jonathan Cameron:  
> > > > On Fri, 17 Jun 2022 16:44:48 -0600
> > > > 
> > > > Rob Herring <robh@kernel.org> wrote:  
> > > > > On Mon, Jun 13, 2022 at 11:34:46AM -0600, Rob Herring wrote:  
> > > > > > On Mon, 13 Jun 2022 14:35:29 +0200, Alexander Stein wrote:  
> > > > > > > Both are already using the vf610 compatible.
> > > > > > > 
> > > > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > > > ---
> > > > > > > 
> > > > > > >  .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9
> > > > > > >  ++++++++-
> > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)  
> > > > > > 
> > > > > > Running 'make dtbs_check' with the schema in this patch gives the
> > > > > > following warnings. Consider if they are expected or the schema is
> > > > > > incorrect. These may not be new warnings.
> > > > > > 
> > > > > > Note that it is not yet a requirement to have 0 warnings for
> > > > > > dtbs_check.
> > > > > > This will change in the future.
> > > > > > 
> > > > > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > > > > > 
> > > > > > 
> > > > > > adc@2198000: 'num-channels' does not match any of the regexes:
> > > > > > 'pinctrl-[0-9]+'>  
> > > > > 
> > > > > Looks like you need to add 'num-channels'?  
> > > > 
> > > > or a lot of wrong dtbs :)
> > > > 
> > > > By which I mean ones providing a property that may or may not be
> > > > actually
> > > > used by any drivers...  
> > > 
> > > This got already fixed by Baruch's patch which is currently in Shawn's
> > > imx-
> > > fixes-5.19 branch at [1]  
> > 
> > Great!
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>  
> 
> Did this got missed? Or is it applied somwhere I' not aware of?
Missed it.  Thanks for pointing it out!

Applied to the togreg branch of iio.git and pushed out initially as testing
for 0-day to poke at it.  Note this may well not make this cycle now unfortunately
given the timing.

Thanks,

Jonathan

> 
> Best regards,
> Alexander
> 
> 
> 

