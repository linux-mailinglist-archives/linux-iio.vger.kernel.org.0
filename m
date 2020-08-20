Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBC24BBDF
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 14:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgHTMe5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHTMep (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 08:34:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579EFC061385
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 05:34:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r4so981166pls.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6KKzntKer57Woo+cS0J9/stl1XTjOZPv/fm7k+f5Bg=;
        b=jk5hxMzpwbt+9MGZwkl65v56+gACxIlr0xuasdl0Iau4IjRaFi7MpceF1azHwdN9nP
         RKR5DqNXJekiTbbmbSBPjeR+HAzzO055RpBgXAujyw/UiYlKQWPDXxePmPKOBAuLtOVY
         9RQSk5Dz8wNqgKUnPSuuydEuEPeg9H5sKDvIXSaMBiAjSqX1Q8gCcbAENNYk626zo3jX
         p9qS1R+lfsuKW6rc/ACnDNPh6BACardfFi5b6BVh0K6V82J4VW0eEn1nDEVYD9CwgyRO
         h+6X3fNeflWKkeKaG7FxLGkMAY0m1Bi3eCKb5lIEHR5GG5YTbLPGP6qi+p2Lvf9biD1B
         4ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6KKzntKer57Woo+cS0J9/stl1XTjOZPv/fm7k+f5Bg=;
        b=GZC1ZZsdduIFFMTAW4zXku7Ls19DVwU9CY8/EAsiBAfLWAADdFPQj3wFm6TlPWtWeD
         7MjszbdIFVBCZ2LDKN/7Bf2UXiGSTlp8qO19Eas4sHQxj7U1sX33XqNeAqhWwlmqnPhp
         VJbRIYiMPuGIwV6yMMS9zjVrRWeDe/+REf/s0dD0T1Muy2tGgsggqFyWcjXUq3C8+jH9
         613TRsH08NIoYalKVaph9iQkc86xz3tdYTafQi8uwm1VL/JOmfMp+6oiAxWPSiZWidFe
         qdmra4eX83Xx+RhMpsmYDH23ixKYzVKIpXPpC3B2pGWnNprXnRtJjPHVSH2CIaZ7EoL2
         ZljA==
X-Gm-Message-State: AOAM530tHydkVDt4wMicf+/AQ0rHIQj0zP4Ew8tsFuKAB1Ka/Z82YYF2
        YEAJx6V56+sx3/+bcaVsJm9eDNMjMKnvJvtq3ZYh9eAc3B4Efg==
X-Google-Smtp-Source: ABdhPJzd6l4kLiCrfmaOMtP99j9Szud6AmqlaWRkAZAZCr17WOFCY31ozJoIPlD+PZ+EgFkRB/MJvVAq29DYB6njia0=
X-Received: by 2002:a17:902:b098:: with SMTP id p24mr2205061plr.255.1597926880014;
 Thu, 20 Aug 2020 05:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200811134846.3981475-1-daniel@0x0f.com> <20200811134846.3981475-3-daniel@0x0f.com>
 <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
 <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com> <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Aug 2020 15:34:23 +0300
Message-ID: <CAHp75VcWWAWt4Up3XOQ5j9f5x+vEiE+f1ySF9pcPpZJhRJpj9w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and SC7A30E
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Palmer <daniel@0x0f.com>, Mario TESI <mario.tesi@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 19, 2020 at 9:19 PM Denis CIOCCA <denis.ciocca@st.com> wrote:
>
> Hi Jonathan,
>
> I strongly disagree that these parts will be supported by STMicroelectronics driver.
> We DO NOT want to find out one day that we need to modify our structure in order to support competition. If they need to support this chip, please provide a new driver for that part leaving STMicroelectronics driver managing our parts.

I'm not sure I understand this passage.
Are you telling we have to have Amount_of_Vendors * cloned_component drivers?
This is NOT how Linux kernel works, really.
Look at the pca953x GPIO expander driver, for example. It has tons of
clones supported and no-one died.

> > On Sun, 16 Aug 2020 at 18:55, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > No SoB tag?! Hint: `git commit -a -s --amend` would fix this if you
> > > have properly configured Git.
> > >
> >
> > Sorry I wasn't aware it was needed for an RFC.
> >
> > > On top of that, can you add Datasheet: tag with links to the actual
> > > component datasheets?
> >
> > I will do that for the v1 of the patch series. All of the datasheets I've found so
> > far are mostly Chinese but the register tables are in English. I've collected
> > them together
> > here: http://linux-chenxing.org/silan/index.html


-- 
With Best Regards,
Andy Shevchenko
