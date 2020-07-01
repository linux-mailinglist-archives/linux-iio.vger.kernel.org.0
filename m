Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB821039D
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 08:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725272AbgGAGGL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 02:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgGAGGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jul 2020 02:06:08 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D2C03E979
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 23:06:08 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id p6so282225uaq.12
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlAVndFTQSyDLHMBObLaphwylvj91OJ+ZG/+4hBUq2U=;
        b=R8g/FGm1exwsXXqZdZONmVu9Gsg1coRo6Ha/j73IUWoR6p6F6htou6M6xm4DT3Y41z
         JhQvxzhXo0AiV7R/DLh51C7aujewYAT0/mxobXVwT13ZuOGbhWPUV4/1+k1WPBwDgisj
         r0r1AePr1ixOTfhkxyHEhC1LHuNFc+mqt+ZpO84W524n+p82CVnYy0KYLE+/IYc8pZvk
         AM0vMmgwAB/+9BL+7iZoQwMNT0bDXY41e3/uxmg78ECzrWLbkqggeL8Yi5j6Z4gyDu55
         5uke7CfqsWOVwVMViM3Dl9eo4ZSW/Ynxoyd3rtSfvnYrtKGCr/QoKlG5ylMmq+ScA/w8
         vMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlAVndFTQSyDLHMBObLaphwylvj91OJ+ZG/+4hBUq2U=;
        b=rgQnoGutefSp1mVjv+vBuZ5vQOLhyf7xU+FH+x0fNwZMCT6c26H3V/8hBXdrF0JmBE
         bEqolmsfSfUEDhOI2Gct/R3xfMV4iOZE7do03w3IET2nHip8VhJ+9oRiL2ejUFTOwNL7
         QiETZNbP2hOdacm6RBhmlrd1ZtqMhtn99cwiWMtlio1E6MimnSZKl1TUBmHYOaOO2QU4
         IzYlEfWwHesRRJMypiEJuwDwfFz6d4Rlo80YpLVtC2vgqpSQ1UI0/arVZQcp6GO/y5qW
         2/w6qSx9oCxvK/tzoMavFyrth23QzOmUD3IBtO7LYA2754ii1TIlaFfUQ/mRZw83ftUH
         o9xA==
X-Gm-Message-State: AOAM5317h6aKOefI4NWMh7u9LsTSpQokQPSc7BTLQQAi71ElDr7Vcln3
        GNOT6x27Q2Z4CF7x05WQvlQnmE+QGjs1CS884t4Aew==
X-Google-Smtp-Source: ABdhPJwlUYtAuuGOocORy/hw8rvM8jnxT5xv3HDRCgeYljriIwoh0+tU0DVYJ9VcvzZYWuAKIXYNWmuh4hBPO1RRgFE=
X-Received: by 2002:ab0:7056:: with SMTP id v22mr10319965ual.67.1593583567791;
 Tue, 30 Jun 2020 23:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
 <20200621193549.2070434-6-dmitry.baryshkov@linaro.org> <CAHLCerOqWWr3i32tRgGfep12YfDufw-WU80VWUsUNpDDZ13D-w@mail.gmail.com>
 <CAA8EJppAQgmS7VVCjVe8QST2RQU46mXO2jtUPFY30mH9sVu_rQ@mail.gmail.com>
In-Reply-To: <CAA8EJppAQgmS7VVCjVe8QST2RQU46mXO2jtUPFY30mH9sVu_rQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 1 Jul 2020 11:35:56 +0530
Message-ID: <CAHLCerM8KwUhpossD=vyhU4q22FnrZse_zhiS0ZobZM0J9X8PA@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: sm8250-dts: add thermal zones using
 pmic's adc-tm5
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 30, 2020 at 5:40 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Hi,
>
> On Tue, 30 Jun 2020 at 08:06, Amit Kucheria <amit.kucheria@verdurent.com> wrote:
> > On Mon, Jun 22, 2020 at 1:06 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > Port thermal zones definitions from msm-4.19 tree. Enable and add
> > > channel configuration to PMIC's ADC-TM definitions. Declare thermal
> > > zones and respective trip points.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 237 ++++++++++++++++++++++++
> > >  1 file changed, 237 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> >
> > IMO, this should be separated in the pmic dts file like we do for
> > other QC platforms since the PMICs tend to be used in multiple
> > platforms.
>
> Unlike other PMIC/tsens thermal zones, these definitions are quite
> specific to the board from my point of view.

How so? Can you describe what is different about this PMIC?

> > > index aa37eb112d85..78f0cf582a9a 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> > > @@ -24,6 +24,104 @@ chosen {
> > >                 stdout-path = "serial0:115200n8";
> > >         };
> > >
> > > +       thermal-zones {
> > > +               xo-therm {
> > > +                       polling-delay-passive = <0>;
> > > +                       polling-delay = <0>;
> > > +                       thermal-sensors = <&pm8150_adc_tm 0>;
> > > +                       trips {
> > > +                               active-config0 {
> > > +                                       temperature = <125000>;
> > > +                                       hysteresis = <1000>;
> > > +                                       type = "passive";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
