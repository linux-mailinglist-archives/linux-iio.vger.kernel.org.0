Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF15EFAED
	for <lists+linux-iio@lfdr.de>; Thu, 29 Sep 2022 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiI2QeY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Sep 2022 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiI2QeW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2022 12:34:22 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F514FE1D;
        Thu, 29 Sep 2022 09:34:20 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so460919ooo.8;
        Thu, 29 Sep 2022 09:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5rvI6zJris9WFqgPcMFO1vyWPVx2pQEqvWLTgiQDBug=;
        b=jsgE8Dd/9TrWNXSk9BwLUNsRNa2tPBERIRSUtKscESEIRg63bEAzG7BE+9hh15WXv5
         JGxMsYpL/HiA2sQbvd3R3D6xE0Q0Q7QZ29enMYj/LbLvpq2YE9vClYswwf7mkHUzMOWU
         KSqmoBwn3KpAearT4fIUNjw6XpxsyTz8iZl/LuWDlqcwJ5wkEM+HsujJeAck96HDSU1v
         R4olQjXqESRqA/vkoF6z2BHMiHks6uYlqVjlK/32a5V0bpdr8haVwSKGLyit4yldqNUj
         G4ibgBuYN3Eafg1n7tlprex5fZwDsE/J1rTUrk/7paOqPwbr/8QYSOD0ec+5mJ83yjYe
         mxBg==
X-Gm-Message-State: ACrzQf2ePhrvQ3JsJVbrQBf9SNZXasCYHzBiSqLJTc0fUyi3u4UwGTLs
        0NFd/GSxdAaJkMxSeWhLG30fFd5Ckw==
X-Google-Smtp-Source: AMsMyM5KXxUTZyDWW95TLfzjp8EOX9a/ELVcuLxOk9WAuIIsUsTln+QjVv+BLGm7pY49xlVgTMYgyw==
X-Received: by 2002:a4a:5e47:0:b0:476:2f9e:b30e with SMTP id h68-20020a4a5e47000000b004762f9eb30emr1715477oob.46.1664469259889;
        Thu, 29 Sep 2022 09:34:19 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t14-20020a056870638e00b001313ec705f3sm38106oap.37.2022.09.29.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:34:19 -0700 (PDT)
Received: (nullmailer pid 2290249 invoked by uid 1000);
        Thu, 29 Sep 2022 16:34:18 -0000
Date:   Thu, 29 Sep 2022 11:34:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        ChiaEn Wu <peterwu.pub@gmail.com>, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 3/5] iio: adc: mt6370: Add MediaTek MT6370 support
Message-ID: <20220929163418.GA2270491-robh@kernel.org>
References: <cover.1663926551.git.chiaen_wu@richtek.com>
 <9bf36f09bc5f002f2b09b7cc26edccf109516465.1663926551.git.chiaen_wu@richtek.com>
 <20220924155525.5663bed8@jic23-huawei>
 <YzFY5FI0PrZqdAiZ@google.com>
 <CAL_JsqKKJGtacbzGqCupFniSGha610L1cay2V+AK8vehTA=F=g@mail.gmail.com>
 <YzQSnuwPjzJIgsYq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzQSnuwPjzJIgsYq@google.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 28, 2022 at 10:23:42AM +0100, Lee Jones wrote:
> On Mon, 26 Sep 2022, Rob Herring wrote:
> 
> > On Mon, Sep 26, 2022 at 2:46 AM Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Sat, 24 Sep 2022, Jonathan Cameron wrote:
> > >
> > > > On Fri, 23 Sep 2022 10:51:24 +0800
> > > > ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > > >
> > > > > From: ChiaEn Wu <chiaen_wu@richtek.com>
> > > > >
> > > > > MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> > > > > with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> > > > > driver, display bias voltage supply, one general purpose LDO, and the
> > > > > USB Type-C & PD controller complies with the latest USB Type-C and PD
> > > > > standards.
> > > > >
> > > > > Add support for the MT6370 ADC driver for system monitoring, including
> > > > > charger current, voltage, and temperature.
> > > > >
> > > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > > >
> > > > This will have to either wait for next cycle, or go through mfd because
> > > > of the dt-bindings include which is in the mfd tree.
> > > >
> > > > Please make those dependencies clear in new versions.
> > >
> > > If the bindings come together in -next, then subsequently in Mainline,
> > > it shouldn't really matter.
> > 
> > Except that the bindings haven't come together and at this point may
> > not for 6.1. linux-next has been warning for weeks because the child
> > device schemas haven't been applied. I've said it before, all the
> > schemas for MFD devices need to be applied together. Or at least the
> > MFD schema needs to get applied last.
> > 
> > Furthermore, subsequent versions of this don't get tested and we end
> > up with more warnings[1].
> > 
> > It's only your IIO tree that the DT
> > > tooling with complain about, right?
> > 
> > And the MFD tree...
> > 
> > Please apply the LED bindings (patches 1 and 2) so we can get the
> > existing warnings fixed and address any new warnings.
> 
> Who usually applies LED bindings?  Looks as though they're good to go.

Pavel. The issue would be I don't know if the driver side is ready and 
those usually go together. Other than my complaining here, how's he 
supposed to know that the bindings at least need to be applied?

Again, the process here is not working. I've said before, all the 
bindings for an MFD need to go via 1 tree. You obviously don't agree, so 
propose something. The current process of no coordination doesn't work.

Rob
