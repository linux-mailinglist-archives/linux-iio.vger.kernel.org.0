Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D370CACCA5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfIHMXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfIHMXc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:23:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADF0214D9;
        Sun,  8 Sep 2019 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567945411;
        bh=FFTPH1hK521flPp+HMa0C8RHLbAzeRkBtWuGqrpCCds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=krovOf2JrLy1vbGCYbmK0DXP76Wo+0vDt6LFOvNDQ51gJPQj0Rx4MG00wTjlp9DNf
         +5TptjDvBSpXkT1T/raY0vigf4wDWSGEzV3LdEGQfueGHzSHzIAIKLbI+tum++4VRm
         f9rpQ+l/wA7+Akm39xOkPnvoN565FPfZyuvQUpoI=
Date:   Sun, 8 Sep 2019 13:23:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio/adc: Add a compatible string
 for JZ4770 SoC ADC
Message-ID: <20190908132324.787d1005@archlinux>
In-Reply-To: <5dd8172ff664fa1795a10ef40960ba54@artur-rojek.eu>
References: <20190727195940.14010-1-contact@artur-rojek.eu>
        <20190728094523.2a161231@archlinux>
        <5dd8172ff664fa1795a10ef40960ba54@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 03 Sep 2019 21:09:24 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Hi Jonathan,
> 
> Just reminding you of this patch set.
> 
> Artur

Hi Artur,

Thanks for the reminder.  As you'd no doubt concluded, I'd
dropped it down the back of the sofa.

Unfortunately it's now just missed my last pull for 5.4 (probably)
so I've queued it up for the 5.5 cycle.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> On 2019-07-28 10:45, Jonathan Cameron wrote:
> > On Sat, 27 Jul 2019 21:59:38 +0200
> > Artur Rojek <contact@artur-rojek.eu> wrote:
> >   
> >> Add a compatible string for the ADC controller present on
> >> Ingenic JZ4770 SoC.
> >> 
> >> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> >> Reviewed-by: Rob Herring <robh@kernel.org>  
> > 
> > Hi Artur,
> > 
> > I'll have to hold this series for a few weeks as the fix for the
> > clock rate divider isn't in my upstream for the togreg branch yet
> > (as I haven't sent a pull request since the merge window).
> > 
> > Give me a poke if I seem to have forgotten these in a few weeks
> > time.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >> 
> >> Changes:
> >> 
> >> v2: no change
> >> 
> >>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt 
> >> b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> >> index f01159f20d87..cd9048cf9dcf 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> >> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> >> @@ -5,6 +5,7 @@ Required properties:
> >>  - compatible: Should be one of:
> >>    * ingenic,jz4725b-adc
> >>    * ingenic,jz4740-adc
> >> +  * ingenic,jz4770-adc
> >>  - reg: ADC controller registers location and length.
> >>  - clocks: phandle to the SoC's ADC clock.
> >>  - clock-names: Must be set to "adc".  

