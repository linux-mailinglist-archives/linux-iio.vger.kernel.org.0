Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B796A580FF2
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jul 2022 11:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbiGZJbJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jul 2022 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbiGZJbF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2022 05:31:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5896248CE
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2022 02:31:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so378973wrr.10
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2022 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6DKLKhCuv0oTIK2mIKjow1hORCEme2MquQ5buN/wlGc=;
        b=vwxd0FJzG20ErAwFpJwytDA+XPSph7dO2hF3++04iGbvWolycV3nT1x50PhyF4yHVv
         t1GLnxbnwGZ+FzFIlfK797RF6mQyiWslVMWv1aGlCeqirOa69WQl16hKksjuQVfFBH02
         f5piNzeRWcNmB1Tskni+qHzA/ciJm1Nhz77bR7dqguiDaWeWbf4VGMiBpKBfhuOnl6Nu
         VHMCRnErCFSCik4l0zZGsC6NRnN7/mU95iBQp/fRhvvTk0HgHXm+PjCUenlLDLOJL3dZ
         iGRwb4BOjNyYMLApd/GQSMApO5uqSogxp5chUadtE3p2WwR/0f3m4A0tA6FeBBrLQJJw
         PyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DKLKhCuv0oTIK2mIKjow1hORCEme2MquQ5buN/wlGc=;
        b=gadNcB1Zcu8Cr0B2xN3/4gZoSOTsLP0lh8/HbDNj3ekcaXacF3MS4KOJozSmLKtHpK
         ipKvm5lhb6GydPkZ/xhTGmMxtyqVN3bI0KJps4XPvozbnKmhIkmOkvl1WzwKpFush2hI
         DCVYtzXlKmHUK4TdHRei6jTwhudM/31KPmFOpTqrryMSLb6vaeLLlzp1pXLPJ6vBHNKe
         B75GL5juweh0iA332DukoBWQmeMuGf1lxXn8vsc1c8o0PgYRLZ/LHk1reo/2vKm7FkPA
         M47NNYqfMRMvXnF7ZYxbDbrp8gzDI1RXM+nf97pHvq5N5pWscMndKgXSiVNo9idG1r1y
         RyvQ==
X-Gm-Message-State: AJIora8XNgtJ+LHKEaU0KcKb2BbtHilwWLpjQWbbmFpMKSj1Zq5hHM8z
        9tZri6V9zKpodDIEZ86FDNr87g==
X-Google-Smtp-Source: AGRyM1upJ6Koxcaxp7uEGgh1VKOfPB35WonHb+9rPNcP2pyI1+sRFKmJXTmiMFmK1V6L3XLfn6REKg==
X-Received: by 2002:adf:db8e:0:b0:21e:3fff:6bae with SMTP id u14-20020adfdb8e000000b0021e3fff6baemr9890443wri.184.1658827861173;
        Tue, 26 Jul 2022 02:31:01 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003a30fbde91dsm23407540wms.20.2022.07.26.02.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 02:31:00 -0700 (PDT)
Date:   Tue, 26 Jul 2022 10:30:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Subject: Re: [PATCH v6 13/13] video: backlight: mt6370: Add MediaTek MT6370
 support
Message-ID: <20220726093058.2fz2p2vg7xpfsnfe@maple.lan>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
 <20220722102407.2205-14-peterwu.pub@gmail.com>
 <20220725103128.xtaw2c4y5fobowg7@maple.lan>
 <CABtFH5LUKTZenTktq3v1JZ9xe-yJFsMvCZuwDhmxdT87k0O-zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtFH5LUKTZenTktq3v1JZ9xe-yJFsMvCZuwDhmxdT87k0O-zA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 26, 2022 at 10:20:02AM +0800, ChiaEn Wu wrote:
> On Mon, Jul 25, 2022 at 6:31 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Jul 22, 2022 at 06:24:07PM +0800, ChiaEn Wu wrote:
> > > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> > > index a003e02..846dbe7 100644
> > > --- a/drivers/video/backlight/Kconfig
> > > +++ b/drivers/video/backlight/Kconfig
> > > @@ -268,6 +268,18 @@ config BACKLIGHT_MAX8925
> > >         If you have a LCD backlight connected to the WLED output of MAX8925
> > >         WLED output, say Y here to enable this driver.
> > >
> > > +config BACKLIGHT_MT6370
> > > +     tristate "MediaTek MT6370 Backlight Driver"
> > > +     depends on MFD_MT6370
> > > +     help
> > > +       This enables support for Mediatek MT6370 Backlight driver.
> > > +       It's commonly used to drive the display WLED. There are 4 channels
> > > +       inside, and each channel supports up to 30mA of current capability
> > > +       with 2048 current steps in exponential or linear mapping curves.
> >
> > Does the MT6372 support more steps than this? In other words does it use
> > a fourteen bit scale or does it use an 11-bit scale at a different
> > register location?
>
> Hi Daniel,
>
> Thanks for your reply.
> Yes, MT6372 can support 16384 steps and uses a 14-bit scale register
> location. But the maximum current of each
> channel of MT6372 is the same as MT6370 and MT6371, both 30mA.
> The main reason why MT6372 is designed this way is that one of the
> customers asked for a more delicate
> adjustment of the backlight brightness. But other customers actually
> do not have such requirements.
> Therefore, we designed it this way for maximum compatibility in software.

I don't think that is an acceptable approach for the upstream kernel.

To be "compatible" with (broken) software this driver ends up reducing
the capability of the upstream kernel to the point it becomes unable to
meet requirements for delicate adjustment (requirements that were
sufficiently important to change the hardware design so you could meet
them).


> > > +
> > > +       This driver can also be built as a module. If so, the module
> > > +       will be called "mt6370-backlight".
> > > +
> > > [...]
> > > diff --git a/drivers/video/backlight/mt6370-backlight.c b/drivers/video/backlight/mt6370-backlight.c
> > > new file mode 100644
> > > index 0000000..ba00a8f
> > > --- /dev/null
> > > +++ b/drivers/video/backlight/mt6370-backlight.c
> > > [...]
> > > +static int mt6370_bl_update_status(struct backlight_device *bl_dev)
> > > +{
> > > +     struct mt6370_priv *priv = bl_get_data(bl_dev);
> > > +     int brightness = backlight_get_brightness(bl_dev);
> > > +     unsigned int enable_val;
> > > +     u8 brightness_val[2];
> > > +     int ret;
> > > +
> > > +     if (brightness) {
> > > +             brightness_val[0] = (brightness - 1) & MT6370_BL_DIM2_MASK;
> > > +             brightness_val[1] = (brightness - 1) >> fls(MT6370_BL_DIM2_MASK);
> > > +
> > > +             /*
> > > +              * To make MT6372 using 14 bits to control the brightness
> > > +              * backward compatible with 11 bits brightness control
> > > +              * (like MT6370 and MT6371 do), we left shift the value
> > > +              * and pad with 1 to remaining bits. Hence, the MT6372's
> > > +              * backlight brightness will be almost the same as MT6370's
> > > +              * and MT6371's.
> > > +              */
> > > +             if (priv->vid_type == MT6370_VID_6372) {
> > > +                     brightness_val[0] <<= MT6370_BL_DIM2_6372_SHIFT;
> > > +                     brightness_val[0] |= MT6370_BL_DUMMY_6372_MASK;
> > > +             }
> >
> > This somewhat depends on the answer to the first question above, but
> > what is the point of this shifting? If the range is 14-bit then the
> > driver should set max_brightness to 16384 and present the full range of
> > the MT6372 to the user.
>
> So should we make all 16384 steps of MT6372 available to users?

Yes.


> Does that mean the DTS needs to be modified as well?

Yes... the property to set initial brightness needs a 14-bit range.

It would also be a good idea to discuss with the DT maintainers whether
you should introduce a second compatible string (ending 6372) in order
to allow the DT validation checks to detect accidental use of MT6372
ranges on MT6370 hardware.


> Or, for the reasons, I have just explained (just one customer has this
> requirement), then we do not make any changes for compatibility
> reasons?

I'd be curious what the compatiblity reasons are. In other words what
software breaks?

Normally the userspace backlight code reads the max_brightness property
and configures things accordingly (and therefore if you the component
that breaks is something like an Android HAL then fix the HAL instead).


Daniel.
