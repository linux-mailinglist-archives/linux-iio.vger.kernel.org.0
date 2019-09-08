Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085A2ACC98
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfIHMPE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfIHMPE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:15:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB00218AC;
        Sun,  8 Sep 2019 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944903;
        bh=qAUjgP9vKSfXVc1oJY2dKfmG0k3QPENTcsCYoTSPmzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=we1yc5J6WXdFpqT1UIcCebXXIaCmnevQvh/YB/C6COfRt/aonvPNPlOR7A/GTu0M0
         GDZO223LrWjlCgsDsYXqHDV5yYHfI12w2Uh5O5jvwWvAem7OuUSc0wpA68GM50Kw9K
         MimgSXeqZQ4Hsty020c9gpE0AsuS02Dv5MD5tr4o=
Date:   Sun, 8 Sep 2019 13:14:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-binding: iio: Add optional label property
Message-ID: <20190908131455.51d1c7a6@archlinux>
In-Reply-To: <29f831da-d23a-bc9c-151a-885bd526a785@electromag.com.au>
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
        <1566876924-63608-2-git-send-email-preid@electromag.com.au>
        <a30b6dca-c598-135a-0559-1018dd5f5fde@xilinx.com>
        <20190829230207.GA22979@bogus>
        <b50bce2d-8819-67b1-c55c-8c2b8070a4ac@electromag.com.au>
        <CAL_JsqKb8cC=4HR7uVHmKt-zw32U_1u62hG4h-TnbPy=a+QZZg@mail.gmail.com>
        <29f831da-d23a-bc9c-151a-885bd526a785@electromag.com.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Aug 2019 18:19:53 +0800
Phil Reid <preid@electromag.com.au> wrote:

> On 30/08/2019 20:34, Rob Herring wrote:
> > On Thu, Aug 29, 2019 at 8:01 PM Phil Reid <preid@electromag.com.au> wrote:  
> >>
> >> On 30/08/2019 07:02, Rob Herring wrote:  
> >>> On Wed, Aug 28, 2019 at 08:09:19AM +0200, Michal Simek wrote:  
> >>>> On 27. 08. 19 5:35, Phil Reid wrote:  
> >>>>> This optional property defines a symbolic name for the device.
> >>>>>
> >>>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
> >>>>> ---
> >>>>>    Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
> >>>>>    1 file changed, 5 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>>>> index 68d6f8ce063b..ffeae5aad8b5 100644
> >>>>> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>>>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>>>> @@ -18,12 +18,17 @@ Required properties:
> >>>>>                 with a single IIO output and 1 for nodes with multiple
> >>>>>                 IIO outputs.
> >>>>>
> >>>>> +Optional properties:
> >>>>> +label:                A symbolic name for the device.
> >>>>> +
> >>>>> +
> >>>>>    Example for a simple configuration with no trigger:
> >>>>>
> >>>>>      adc: voltage-sensor@35 {
> >>>>>              compatible = "maxim,max1139";
> >>>>>              reg = <0x35>;
> >>>>>              #io-channel-cells = <1>;
> >>>>> +           label = "adc_voltage_sensor";
> >>>>>      };
> >>>>>
> >>>>>    Example for a configuration with trigger:
> >>>>>  
> >>>>
> >>>> Just for the record. This patch has been created based on initial
> >>>> discussion about label property. And Rob had not problem with using
> >>>> label in connection to ina226. https://lkml.org/lkml/2019/8/27/1213  
> >>>
> >>> I didn't, but based on the name here I'm less convinced. 'label' is
> >>> supposed to be for needing to distinguish between more than 1 of
> >>> something. A name like 'adc_voltage_sensor' doesn't really.
> >>>
> >>> Rob
> >>>
> >>>  
> >>
> >> That's the problem we're try to solve. Having multiple devices and try to
> >> determine which device is which.
> >> eg: Mutliple adc's.
> >> For example I have the same dac chip on multiple boards that do different
> >> things, it's difficult to id them.
> >>
> >> so label examples could be:
> >> label = "current_control_group1";
> >> label = "voltage_control_group1";
> >>
> >> Are you totally against this or is it a problem with me not being clear
> >> with the problem and the wording of the commit message or the example?  
> > 
> > It's just the example is less than ideal. But it's just an example, so:
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > Feel free to update the example if you respin.
> >   
> Thanks Rob,
> 
> I'll update the example if the series gets a respin.

Please do respin some more 'example' suited names :)

Thanks,

Jonathan

> 
> 
> 

