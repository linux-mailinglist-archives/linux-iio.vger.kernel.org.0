Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6467225EDB4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIFMNZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 08:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgIFMMd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 08:12:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD39208B3;
        Sun,  6 Sep 2020 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599394347;
        bh=HFKdzPHzYBn8BaCn/wLBKbhxR+qq5E7Ro8VGTwHbrkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1cxI7NsvcMXbIaC+Y44U2oLEepR/q92T/PHchhs4pni1AYjN2px3n14K9NSuxR53P
         6+eJbM+wJ37JPhv0QtiRHSRJQOoD5DrGwBNWyBgmbm+/muTFG0L89vUegZcd/oyPcp
         Xu9oMXjhrULB0NrJsgkG4SpZUn5KjTpnRUDoBhuU=
Date:   Sun, 6 Sep 2020 13:12:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 18/20] dt-bindings:iio:adc:amlogic,meson-saradc yaml
 conversion
Message-ID: <20200906131221.22eae986@archlinux>
In-Reply-To: <CAFBinCD9BqANmYKSCaHf8U3r9RMtGCFCu4_afNo4T8WJnpMkUA@mail.gmail.com>
References: <20200905173004.216081-1-jic23@kernel.org>
        <20200905173004.216081-19-jic23@kernel.org>
        <CAFBinCD9BqANmYKSCaHf8U3r9RMtGCFCu4_afNo4T8WJnpMkUA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Sep 2020 12:00:02 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jonathan,
> 
> On Sat, Sep 5, 2020 at 7:32 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This binding is non trivial due to the range of different parts
> > supported having several subtle quirks.  
> thank you for working on this!
> 
> > I am far from sure I have these correct. For example:
> > 1) Can we have the clock adc_sel without adc_clk?  
> adc_sel and adc_clk only exist on GXBB and newer
> Meson8, Meson8b and Meson8m2 have these clocks built into the SAR ADC IP block

Ah. That makes sense.

> 
> > 2) I haven't restricted the amlogic,hhi-sysctrl to only
> >    be present on the relevant parts if nvmem stuff also is, but
> >    it would seem to be rather odd if it were otherwise.  
> yes, I think we can restrict this later
> 
> [...]
> > +        adc@9680 {
> > +            compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
> > +            #io-channel-cells = <1>;
> > +            reg = <0x0 0x9680 0x0 0x34>;
> > +            interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> > +            clocks = <&xtal>,
> > +                <&clkc CLKID_SAR_ADC>,
> > +                <&clkc CLKID_SAR_ADC_CLK>,
> > +                <&clkc CLKID_SAR_ADC_SEL>;
> > +            clock-names = "clkin", "core";  
> CLKID_SAR_ADC_CLK and CLKID_SAR_ADC_SEL should not be in this Meson8b example
> 
> I have attached a patch for this as well as for making the clock
> selection more restrictive (to catch errors like this). feel free to
> include it in your patch if you think that it improves things

Great thanks. I'll roll your patch into this for v2.

Thanks,

Jonathan

> 
> 
> Best regards,
> Martin

