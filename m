Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0055F034
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiF1VJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 17:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiF1VJX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 17:09:23 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184B35DF7;
        Tue, 28 Jun 2022 14:09:21 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id m13so14203934ioj.0;
        Tue, 28 Jun 2022 14:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U12Z4vhZw7H5Cr8clwAhRnGVpf0ZJMi2KclaKSIzIuc=;
        b=5o73RqOiloAOCShhv7TphrWsTibe8y2rQo3Hfw+db6SmIfXl9su9G2OkT/GSquzQlv
         d9tEq4iQz2/lZGPh1Go02mOpYdMQRKEffLtq8Tm3wSiEGuffnYJ1uYXDtYKlLu7mSQR+
         c96Pq4moyzVZEG38IBEwKbeJjXew9X53AwxvAMBtfZKVbAxWGVYnyhAzmNOOtEd8MoQU
         thHBypnTABgNBJtRoNIiGq1OGxgGD6sN3z7olT2f6w4+961RbSyRx1etaoIF9GrZO4Kp
         2eKhMkAYXkQ+I1JgKz6Xyi0ZVEbIrz7XVdfs0jeKtTogDPMKosyiEHrWugKA9k82SxtO
         64ZA==
X-Gm-Message-State: AJIora+K6O8orZNh3Ho8mDWCQvUjo5iyz048EqWS1rGjChUnOtVlKiBj
        2Coickl5DMFmS9wXj26A+Q==
X-Google-Smtp-Source: AGRyM1tliiRnnklDEBtVXq44emC7wKr5Y6AIwfUauYZGzq3A+BpA7GBnq2zEPsDhJFPDba9ZY+wvlA==
X-Received: by 2002:a05:6638:2113:b0:339:e689:6fb3 with SMTP id n19-20020a056638211300b00339e6896fb3mr25626jaj.169.1656450561190;
        Tue, 28 Jun 2022 14:09:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z7-20020a923207000000b002d1d3b1abbesm6156374ile.80.2022.06.28.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:09:20 -0700 (PDT)
Received: (nullmailer pid 980530 invoked by uid 1000);
        Tue, 28 Jun 2022 21:09:19 -0000
Date:   Tue, 28 Jun 2022 15:09:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx
 compatibles
Message-ID: <20220628210919.GB963202-robh@kernel.org>
References: <20220613123529.466528-1-alexander.stein@ew.tq-group.com>
 <20220617224448.GA2574775-robh@kernel.org>
 <20220618180129.699b8601@jic23-huawei>
 <12003373.O9o76ZdvQC@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12003373.O9o76ZdvQC@steina-w>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 20, 2022 at 10:12:44AM +0200, Alexander Stein wrote:
> Hello,
> 
> Am Samstag, 18. Juni 2022, 19:01:29 CEST schrieb Jonathan Cameron:
> > On Fri, 17 Jun 2022 16:44:48 -0600
> > 
> > Rob Herring <robh@kernel.org> wrote:
> > > On Mon, Jun 13, 2022 at 11:34:46AM -0600, Rob Herring wrote:
> > > > On Mon, 13 Jun 2022 14:35:29 +0200, Alexander Stein wrote:
> > > > > Both are already using the vf610 compatible.
> > > > > 
> > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > ---
> > > > > 
> > > > >  .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9
> > > > >  ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > Running 'make dtbs_check' with the schema in this patch gives the
> > > > following warnings. Consider if they are expected or the schema is
> > > > incorrect. These may not be new warnings.
> > > > 
> > > > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > > > This will change in the future.
> > > > 
> > > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > > > 
> > > > 
> > > > adc@2198000: 'num-channels' does not match any of the regexes:
> > > > 'pinctrl-[0-9]+'> 
> > > Looks like you need to add 'num-channels'?
> > 
> > or a lot of wrong dtbs :)
> > 
> > By which I mean ones providing a property that may or may not be actually
> > used by any drivers...
> 
> This got already fixed by Baruch's patch which is currently in Shawn's imx-
> fixes-5.19 branch at [1]

Great!

Reviewed-by: Rob Herring <robh@kernel.org>
