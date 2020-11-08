Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93602AAC01
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgKHPwU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 10:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKHPwU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:52:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2319920B1F;
        Sun,  8 Nov 2020 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604850739;
        bh=Uk7+qbF070biGWY7S0qa+YFj/roh4zH+JTWLkehmpK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W8WKSn+NGyF5bfG7mqPhjfAlBAWYztiwckdEqC6ZRtbOURJ4KZ/gmYqpyFPUXcV6f
         /JueawVO0JF3A3okuAQOcuVRFmJn44vY3jiGQtBBY5TkJhiY69jaI4It+uasoTI/+/
         p4oIAjpAWOZNMR3KM+BaZVLFwnZykeJwKsZwCSkA=
Date:   Sun, 8 Nov 2020 15:52:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9 01/15] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20201108155213.1c91e3b9@archlinux>
In-Reply-To: <20201104183230.GB3913864@bogus>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
        <20201102174950.1148498-2-dmitry.baryshkov@linaro.org>
        <20201104183230.GB3913864@bogus>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Nov 2020 12:32:30 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, 02 Nov 2020 20:49:36 +0300, Dmitry Baryshkov wrote:
> > Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> > close counterpart of VADC part of those PMICs.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>

Ah, this got picked up by the additions I made to dt-schema the other day.

So there are a few existing places where io-channel-ranges is miss provided
in dtsi files for io-channel providers (it's being ignored in most the places
it is specified!)

What it means is that the child nodes may use io-channel entries of their parent.
Hence it should only be specified on the consumer side.
Here we don't actually need it for the consumer either as the io-channels
entry is in the child node, not the parent.

I'm kind of assuming that I'll eventually do the immutable branch for this
series. If so I can clean this up whilst applying if everything else is fine
with v9.

Thanks,

Jonathan


> > ---
> >  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 154 ++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> >   
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: adc@3100: 'io-channels' is a dependency of 'io-channel-ranges'
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/iio/iio-consumer.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1392425
> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

