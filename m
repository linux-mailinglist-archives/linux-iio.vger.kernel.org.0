Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A768B058
	for <lists+linux-iio@lfdr.de>; Sun,  5 Feb 2023 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBEOqs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 09:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBEOqr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 09:46:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA70272E;
        Sun,  5 Feb 2023 06:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC26B80B51;
        Sun,  5 Feb 2023 14:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D236C433D2;
        Sun,  5 Feb 2023 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675608404;
        bh=vo3o5YwT8lCGg5NNtZivowyFykaDvBjLf7Wtg2bRhqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ugmpw7ryEZq1FkTtqAdbhccngsu7BjVdQ8y65CfYD5iYXajl2LWFsAITKEEdOaQc2
         19ZbMlMGXRDkfYrryUzjExi0Q1oAG7BXY2DcR3vj9iBemwsqaZycOJQWu2hje0AKEa
         iVGjlBT2V63Suz+jjiXX5NDKPFFpelWCokw2lJA5hADHMALLEhnE6FzQqgyUQNJZGH
         AinYOqNFSy2V2SBqtrLIeFZfSyC+sMbFVzog6OBebfIqDlsiAOLr9woUhf+jUpuJZ0
         kDMaaRoB02nVaqlOg7BN02/f9Z7dFYEL1oo9Sj4vpTdZJoKa0V1/8bntI8ZvQYfkbE
         g4tHA5/TQe44A==
Date:   Sun, 5 Feb 2023 15:00:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc:
 Miscellaneous improvements
Message-ID: <20230205150044.6e5dfb09@jic23-huawei>
In-Reply-To: <CAMuHMdVTkPZm+66PumNa_LgV6DYR2HgH9k6Nbi9RcRPHGRDOVw@mail.gmail.com>
References: <7b7a13680fa24282c3407e12b5943a66a2ed9068.1666611184.git.geert+renesas@glider.be>
        <3c0895a3-2da6-3bd1-c786-01cf5eaa2452@linaro.org>
        <20221029135102.5bb9d786@jic23-huawei>
        <CAMuHMdVTkPZm+66PumNa_LgV6DYR2HgH9k6Nbi9RcRPHGRDOVw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Tue, 31 Jan 2023 11:13:04 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Jonathan,
> 
> On Sat, Oct 29, 2022 at 2:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 24 Oct 2022 08:23:43 -0400
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:  
> > > On 24/10/2022 07:34, Geert Uytterhoeven wrote:  
> > > > Set limits on the number of power-domains and resets, and make them
> > > > required.
> > > >
> > > > Simplify the example, and update it to match reality:
> > > >   - Convert from obsolete MSTP to CPG/MSSR bindings,
> > > >   - Examples should use #{address,size}-cells = <1>,
> > > >   - Add missing resets property,
> > > >   - Drop soc container and pinctrl properties, which are not needed in
> > > >     examples.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> > >
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> > Applied,  
> 
> Looks like this fell through the cracks, as I cannot see it applied?
> Do you want me to resend?
> Thanks!
Sorry about that.  Now applied.  Not sure what happened there.

Jonathan

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

