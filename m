Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94029185B78
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 10:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgCOJ26 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 05:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgCOJ26 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 05:28:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201A6206B1;
        Sun, 15 Mar 2020 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584264537;
        bh=a3TDzGbEzkSLeXinw82ULYy0g3/qKx/I5ol4xjHP/jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FfBA9KivPcq2i/xkl3X4fU7JAbz8h0yxx+oZqKHJQ5x7jhklsgxMuE/2WvFgDiDBF
         o7pdSPWOsANpZFUiHJvKEQwTSbzIyjb1W1C4fGD8h5sY3pHDt+HBI+v9WXsl+WrQ9x
         ZyIDeRFLkXWNBlDSNIV+zjywyMF69vj0Bi3mF12w=
Date:   Sun, 15 Mar 2020 09:28:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: input: Add docs for ADC driven
 joystick.
Message-ID: <20200315092852.2d2ecebb@archlinux>
In-Reply-To: <bb188a58f29dfedcf56bb420f07a6813@artur-rojek.eu>
References: <20200307211412.44148-1-contact@artur-rojek.eu>
        <20200307211412.44148-4-contact@artur-rojek.eu>
        <20200309203814.GA29255@bogus>
        <bb188a58f29dfedcf56bb420f07a6813@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 09 Mar 2020 22:41:00 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> Hi Rob,
> 
> On 2020-03-09 21:38, Rob Herring wrote:
> > On Sat,  7 Mar 2020 22:14:11 +0100, Artur Rojek wrote:  
> >> Add documentation for the adc-joystick driver, used to provide support
> >> for joysticks connected over ADC.
> >> 
> >> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> >> Tested-by: Paul Cercueil <paul@crapouillou.net>
> >> ---
> >> 
> >>  Changes:
> >> 
> >>  v2: - Add `reg` property to axis subnode in order to enumerate the 
> >> axes,
> >>      - rename `linux,abs-code` property to `linux,code`,
> >>      - drop `linux,` prefix from the remaining properties of axis 
> >> subnode
> >> 
> >>  v3: no change
> >> 
> >>  v4: - remove "bindings" from the unique identifier string,
> >>      - replace `|` with `>` for all description properties,
> >>      - specify the number of items for `io-channels`,
> >>      - correct the regex pattern of `axis` property,
> >>      - specify the value range of `reg` property for each axis,
> >>      - put `abs-range` properties under `allOf`
> >> 
> >>  .../bindings/input/adc-joystick.yaml          | 121 
> >> ++++++++++++++++++
> >>  1 file changed, 121 insertions(+)
> >>  create mode 100644 
> >> Documentation/devicetree/bindings/input/adc-joystick.yaml
> >>   
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:  
> Like with the previous versions of this patch set, the DTS example 
> requires that
> patch [2/5] is applied first. When that is done, the DT check does 
> succeed here.

Fair enough as far as I am concerned.   There were enough comments
from Rob in the previous version though that I'd definitely like
him to take another look before I pick this series up.

Thanks,

Jonathan

> 
> Regards,
> Artur
> > 
> > Error:
> > Documentation/devicetree/bindings/input/adc-joystick.example.dts:22.31-32
> > syntax error
> > FATAL ERROR: Unable to parse input tree
> > scripts/Makefile.lib:311: recipe for target
> > 'Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml'
> > failed
> > make[1]: ***
> > [Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml]
> > Error 1
> > Makefile:1262: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> > 
> > See https://patchwork.ozlabs.org/patch/1250951
> > Please check and re-submit.  

