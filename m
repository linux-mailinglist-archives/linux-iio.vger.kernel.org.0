Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48065670CC3
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 00:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjAQXIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 18:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjAQXHq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 18:07:46 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127AE44BC8;
        Tue, 17 Jan 2023 14:42:56 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DF99E3F428;
        Tue, 17 Jan 2023 23:42:53 +0100 (CET)
Date:   Tue, 17 Jan 2023 23:42:51 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        openbmc@lists.ozlabs.org, linux-imx@nxp.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-msm@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v3 12/15] iio: adc: qcom-spmi-adc5: convert to device
 properties
Message-ID: <20230117224251.wzxexdlfe5ydzjw5@SoMainline.org>
References: <20220715122903.332535-1-nuno.sa@analog.com>
 <20220715122903.332535-13-nuno.sa@analog.com>
 <20220806192048.0ca41cc5@jic23-huawei>
 <20230116204452.il4gase2szipeexz@SoMainline.org>
 <CAHp75VdX9sFgn9STyzwcDCK1KYbU00ejFNcEP3FVnLk5J=Pktg@mail.gmail.com>
 <CAHp75VdTftm1BE21rH1HVHiwUye-0Dvc66uCK2LE2qF4_zA6hg@mail.gmail.com>
 <CAHp75VdyCA7mQdm--kg=hUbmQqX4-jfFMHgLxref5mNSM1vnMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdyCA7mQdm--kg=hUbmQqX4-jfFMHgLxref5mNSM1vnMA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2023-01-17 11:40:42, Andy Shevchenko wrote:
<snip>
> > > > This CC just surfaced in my inbox while searching for our current
> > > > discussion around missing labels in qcom-spmi-vadc - and on the side a
> > > > userspace @xx label name ABI break (in qcom-spmi-adc5) caused by this
> > > > patch's fwnode_get_name change - we could've caught it if I had not
> > > > accidentally marked it as read and/or forgot about it.  My apologies.
> > >
> > > Does the following addition to the top of the
> > > adc5_get_fw_channel_data() fix the issue?
> > >
> > > +       name = devm_kasprintf(adc->dev, GFP_KERNEL, "%pfwP", fwnode);
> > > +       if (!name)
> > > +               return -ENOMEM;
> >
> > Okay, it probably the same, so it might need additional code to
> >
> > + name[strchrnul(name, '@') - name] = '\0';
> 
> I have just sent a formal patch, please test on top of non-working kernel.

I would've preferred to fix this in the same way as qcom-spmi-vadc by
implementing read_label instead and basing it on the DT label or driver
string literals instead [1], but dropping extend_name (hence changing
sysfs filenames once again) would be considered an ABI break.

I've instead gone for a similar change that also ignores the node name
in favour of falling back to the driver string literal (if no "label"
property is available) while retaining extend_label [3] and the -
however ugly they are - sysfs filenames, but that'll likely get rejected
as strictly being an ABI break as well, not in the least because DT
needs to be patched up [3] for it to work out.

I'll at least test your patch when getting back to one of these devices.

- Marijn

[1]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-6-marijn.suijten@somainline.org/
[2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
[3]: https://lore.kernel.org/linux-arm-msm/20221209215308.1781047-1-marijn.suijten@somainline.org/
