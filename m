Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEACC14D190
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 20:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgA2Tzl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jan 2020 14:55:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgA2Tzl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jan 2020 14:55:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37912071E;
        Wed, 29 Jan 2020 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580327740;
        bh=fwWGUU+gCrYf5nvq9LL1bXiyrYuy3gLMO1C6gOKMELw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NKAFWRMXC5sFkVi9wSEqhp4wSayQhd4uCHnel0IrA3KHEABvPqvWs2Ey8MtKgKCqa
         aLuwMBtpyNXQpdgFqhEB8MENWERbBoZYRvEVoYzSOV1I3SCpPXz2VV9FLKcFVsv7Zx
         AxVfYAHuqsnLp/AhkYSTeZryoQamIpGe5OMTbuWM=
Date:   Wed, 29 Jan 2020 19:55:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, robh+dt@kernel.org,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, olivier.moysan@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: adc: stm32-adc: convert bindings
 to json-schema
Message-ID: <20200129195534.63a20b21@archlinux>
In-Reply-To: <20200121231309.GA17359@bogus>
References: <1579095941-18648-1-git-send-email-fabrice.gasnier@st.com>
        <20200121231309.GA17359@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jan 2020 17:13:09 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 15 Jan 2020 14:45:41 +0100, Fabrice Gasnier wrote:
> > Convert the STM32 ADC binding to DT schema format using json-schema
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in V3:
> > - Fix minimum and maximum syntax for uint32-array properties as pointed
> >   out by Rob.
> > - update example to better show this syntax e.g. st,adc-channels = <0 1>;
> > 
> > Changes in V2:
> > - Take almost all of Rob suggestions (removed reg generic description,
> >   added minItems, maxItems, st,max-clk-rate-hz range, drop some pipes,
> >   simplify clock-names, remove unneeded allOfs)
> > - For now, keep all in one file despite there are lots of if/thens in the
> >   bindings
> > ---
> >  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -------
> >  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 458 +++++++++++++++++++++
> >  2 files changed, 458 insertions(+), 149 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
