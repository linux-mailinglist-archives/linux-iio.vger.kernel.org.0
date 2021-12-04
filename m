Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057394685F0
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 16:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbhLDPdf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 10:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbhLDPdd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 10:33:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA156C061751;
        Sat,  4 Dec 2021 07:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC50B80CFD;
        Sat,  4 Dec 2021 15:30:06 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 3381AC341C0;
        Sat,  4 Dec 2021 15:30:01 +0000 (UTC)
Date:   Sat, 4 Dec 2021 15:35:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: exynos-adc: Fix node name in
 example
Message-ID: <20211204153511.77a357a7@jic23-huawei>
In-Reply-To: <Yaf8IkypvCTHi3xO@robh.at.kernel.org>
References: <20211125152154.162780-1-geert@linux-m68k.org>
        <3fec093a-df46-6096-3f66-891734a5f140@canonical.com>
        <20211127174343.1b9dcabe@jic23-huawei>
        <CAMuHMdVWZEai-EYvoWc5eToSqK9N8KsXi6u0Ej6fQzQE77aNoA@mail.gmail.com>
        <Yaf8IkypvCTHi3xO@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 Dec 2021 16:50:10 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Nov 29, 2021 at 09:22:35AM +0100, Geert Uytterhoeven wrote:
> > Hi Jonathan,
> > 
> > On Sat, Nov 27, 2021 at 6:38 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Thu, 25 Nov 2021 16:26:16 +0100
> > > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:  
> > > > On 25/11/2021 16:21, Geert Uytterhoeven wrote:  
> > > > > "make dt_binding_check":
> > > > >
> > > > >     Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: ncp15wb473: $nodename:0: 'ncp15wb473' does not match '^thermistor(.*)?$'
> > > > >         From schema: Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >  
> > > >
> > > >
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > >  
> > > This doesn't particularly feel like we need to rush it in, so applied
> > > to the togreg branch of iio.git which will go in next merge window.
> > >
> > > Shout if I should pull it to a fixes branch.  
> > 
> > Thank you, that's fine. We're still far from the point where we can start
> > enforcing "no errors" in "make dt_binding_check dtbs_check".  
> 
> No errors/warnings is the rule for dt_binding_check, but not dtbs_check.
> 
> Jonathan, Can you drop this and I'll apply with some other fixes I have 
> for 5.16.
> 
> Rob

Done, it's all yours.  Feel free to add

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

if you haven't already pushed it out.

THanks,

Jonathan

