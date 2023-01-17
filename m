Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7E66DA32
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbjAQJoV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 04:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjAQJlw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 04:41:52 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B286AB;
        Tue, 17 Jan 2023 01:41:19 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id i28so2138963qkl.6;
        Tue, 17 Jan 2023 01:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdQxBMQOMwqD8VUok85rROkSgj2htMeyYzI/9JQJnaY=;
        b=HdpUBrzVC+fRm5us0I5pcSVClglYaFUfiEm/cGmO0HRwQ+aYU0HVym6Sa1QAveTfcy
         HVrNoblnZL7c17Uzkx9cWtDUNfb/se9p1L8E0LImXSu+eOf5/sphsIlfsbxsZUBcSG3A
         epLckHWQLqK9BHTP8K/H2nWLrxRMmIziEGtmrfzMCzTlKxaNHqt+yQ5uevBzAlX/9/dD
         eraOfE2nSwKxtnVs7ghhKhl4PJs4QjHGI2ViGL60UKvVQ0h5+wkTdiujQa4bIuASu3/g
         mGE/ZB8GT3isx1sHuKZF2MZCBZI+i9AXRO9tTxFkQbgjJOCiiAphcf9gB63ctNnSGHL5
         ktCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdQxBMQOMwqD8VUok85rROkSgj2htMeyYzI/9JQJnaY=;
        b=Bm98z8W6Pwj+StervzCzzbAsf86KJ/AzQY3L9XKBybh85SV+IJdnfGCBH1MW0UZaKg
         d38WcsuJ1bQmw3y6/dFRnQDMu4+zthBQaonm5xNCnaF5eebZbE9ZVL7rppalwPuMlaw+
         aEO5YFz/AMba35L2fwSaoY+JUJZCxnLa6LMTIIceMjMUWECEJDESiHBVRhKXR7Go4YFj
         bbX3FfU/2yAVCbUt4Tb/tO0+rxQogHkQKF2KvskA2MBrS3T8mPDICzn6vIwnDjY0vecB
         sTtiROIrm7CJYJmqOlV/EyJU8xKumj3lPRMC6BrYCQZ3zoW3cX51pXgjBAJbPC+E2mG1
         QyYA==
X-Gm-Message-State: AFqh2kpidLFMhQX4WmNPI7/7JcgeEIi5Pp4Hob6qiXC8JFRW7dNSxsA5
        1pt34W6RwGt6tQXm5JWYEouZ7Dejf8HHg14pN1Q=
X-Google-Smtp-Source: AMrXdXvUweQfxPG9XW/trbF8uyUaDAKToxBAJ8l2RD/emKWwnVOskao8jQNpBm7SRN0AryYBpZ/goUm0u7jIv/pAfEY=
X-Received: by 2002:a05:620a:36f4:b0:702:34dc:25a8 with SMTP id
 cz52-20020a05620a36f400b0070234dc25a8mr95984qkb.748.1673948478628; Tue, 17
 Jan 2023 01:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20220715122903.332535-1-nuno.sa@analog.com> <20220715122903.332535-13-nuno.sa@analog.com>
 <20220806192048.0ca41cc5@jic23-huawei> <20230116204452.il4gase2szipeexz@SoMainline.org>
 <CAHp75VdX9sFgn9STyzwcDCK1KYbU00ejFNcEP3FVnLk5J=Pktg@mail.gmail.com> <CAHp75VdTftm1BE21rH1HVHiwUye-0Dvc66uCK2LE2qF4_zA6hg@mail.gmail.com>
In-Reply-To: <CAHp75VdTftm1BE21rH1HVHiwUye-0Dvc66uCK2LE2qF4_zA6hg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Jan 2023 11:40:42 +0200
Message-ID: <CAHp75VdyCA7mQdm--kg=hUbmQqX4-jfFMHgLxref5mNSM1vnMA@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] iio: adc: qcom-spmi-adc5: convert to device properties
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 17, 2023 at 11:06 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jan 17, 2023 at 10:53 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Jan 16, 2023 at 10:44 PM Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > On 2022-08-06 19:20:48, Jonathan Cameron wrote:
> > > > On Fri, 15 Jul 2022 14:29:00 +0200
> > > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > > >
> > > > > Make the conversion to firmware agnostic device properties. As pa=
rt of
> > > > > the conversion the IIO inkern interface 'of_xlate()' is also conv=
erted to
> > > > > 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and h=
ence OF
> > > > > dependencies from IIO.
> > > > >
> > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > +CC Marijin who happend to post a patch for this driver that I just=
 accepted
> > > > and hence probably has hardware access.  Any chance of a test for t=
his series?
> > > >
> > > > If not, no problem as this is fairly mechanical and we have testing=
 on some of
> > > > the other drivers using the new code.
> > > >
> > > > I'll probably queue this up in the meantime but it won't end up ups=
tream
> > > > for a few weeks yet.
> > >
> > > Jonathan,
> > >
> > > This CC just surfaced in my inbox while searching for our current
> > > discussion around missing labels in qcom-spmi-vadc - and on the side =
a
> > > userspace @xx label name ABI break (in qcom-spmi-adc5) caused by this
> > > patch's fwnode_get_name change - we could've caught it if I had not
> > > accidentally marked it as read and/or forgot about it.  My apologies.
> >
> > Does the following addition to the top of the
> > adc5_get_fw_channel_data() fix the issue?
> >
> > +       name =3D devm_kasprintf(adc->dev, GFP_KERNEL, "%pfwP", fwnode);
> > +       if (!name)
> > +               return -ENOMEM;
>
> Okay, it probably the same, so it might need additional code to
>
> + name[strchrnul(name, '@') - name] =3D '\0';

I have just sent a formal patch, please test on top of non-working kernel.


--
With Best Regards,
Andy Shevchenko
