Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1124BD06
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHTM5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgHTM4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 08:56:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CFC061385
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 05:56:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so999897plr.5
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=so7fWa196e38dBmL00t5f1f70Vde3Kj1zihC6kxVQt4=;
        b=Pql3FKSHsIb89XqUicWlz5xRspee9Y5hcCBcJyBWQykcpIof4kSKwXZVQnQpXMCXeC
         LvWZWGFxNCG24xHcw1tx6jDpvQfDQESReZe6qNHLpV9FpDLOtSnzwxLduGvAUAYKciWZ
         9tafpfdQpWy0B1ZM0mL8g8Oh1YmO8TmEEtjAXOQxilZ8TiIesOSQ/LKAFlsLhsbBEf8N
         L13oPvi/KB3shxAGdcIscQP2o9RVIFrnumeG1dy5cRwWAwx5tVYwoFJYeap2SIR/4lf9
         tI0pRYPSj9yorg39Zn0xByGJJQw6Ihnmaxpz040W+wtOtqPVh6eYqiayD2E+9gUlDu4N
         AD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=so7fWa196e38dBmL00t5f1f70Vde3Kj1zihC6kxVQt4=;
        b=A0nstiitP/3zUIjKOPjiCpD9H/on6rWLOABWF/9spIR44+nhEsHDWHpg6odlJV8t5D
         UkUFv4aPG/BPlXtzOIb4qqfBfuCJD0+ed1g9/YKE5wZ0jo77oyKPVDQuebsN7vbnx1Wz
         50hHv4BCbEBiPZlm5yWGrx6XDO5cVUSHdRDhFJIxSfimkThuTR8FWqzGMm1H9B4nlPXi
         02GBZH6RrC7hnOruKuwT6wOGAIH908jibf3c3PuqhhxFeHyNYLTw8IEpjIh2QmB48mk7
         EH+87QOtAH+rTVBgkPMqAXYA+M1vDPdvybODuOPEC2rqA0alGTG7Ju7wHbUmMTO9KhSI
         i6oA==
X-Gm-Message-State: AOAM5319pSoO2NTx/3wvL01wcvvQOcf+98Z6VgGTDR+xQth9k7/GlV+7
        HYBl3dwLjXlQ0x9d46a5/dUWLE8LOuYSTQUAsrFqXbKEzz93pw==
X-Google-Smtp-Source: ABdhPJxOCs/LFVqzPA/cCxZGEYMo4qFv8iAWrZhXygv3/V8T89N/l5E7lIsvaTk9w3BABzgan/M+q+0cGZ8O/tpT9gw=
X-Received: by 2002:a17:90b:509:: with SMTP id r9mr2483315pjz.228.1597928203415;
 Thu, 20 Aug 2020 05:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200811134846.3981475-1-daniel@0x0f.com> <20200811134846.3981475-3-daniel@0x0f.com>
 <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
 <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com>
 <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
 <CAFr9PXkNBunBhrfyrYn1nU=hSw9A2n_fVSSH6HMAtEQ7+MnBdw@mail.gmail.com>
In-Reply-To: <CAFr9PXkNBunBhrfyrYn1nU=hSw9A2n_fVSSH6HMAtEQ7+MnBdw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Aug 2020 15:56:27 +0300
Message-ID: <CAHp75VeAbbqVOTeCheZ5r+LhQ7O+AD=UyduQ3iCcx80EciZ8RQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and SC7A30E
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Mario TESI <mario.tesi@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 20, 2020 at 3:27 PM Daniel Palmer <daniel@0x0f.com> wrote:
> On Thu, 20 Aug 2020 at 03:19, Denis CIOCCA <denis.ciocca@st.com> wrote:
>
> > I strongly disagree that these parts will be supported by STMicroelectronics driver.
>
> The alternative seems to be write a totally new driver that does
> exactly the same thing, use a lot of people's time to get it ready to
> go into the kernel etc when we could come up with a way to allow the
> driver to accept a different WAI register value in a non-intrusive way
> that can go in the bin at a later date if it turns out supporting
> these chips is too much hassle.

Which is fine with me, I mean adding an ID is a common practice for
competing hardware clones.

> > We DO NOT want to find out one day that we need to modify our structure in order to support competition.
>
> I think Jonathan suggested adding me as a reviewer for these parts
> thus making me responsible for them.
> I'm fine with that. If it comes to the point where the driver changes
> so much that it's not possible to keep them working then you'd have my
> blessing to just remove support for them.

I encourage you to do this. I guess it's much better if we have
someone, than orphaned code in the kernel.

> That said I'm not going to force this on anyone.
> This patch was a spin-off of a personal project to try to make cheap
> Linux capable SoCs available to makers[0].

And again full support from me here.

It's a really very strange position of STMicro here. I as a maintainer
/ reviewer / supporter of a lot of hardware have a good example of
collaboration with contributors from other companies when they do
improve our drivers. And I have been doing the same for others, for
example Synopsys DesignWare SATA driver which had been found on PPC44x
platform.

> One of the devices I used
> to reverse engineer that hardware had one of these Silan parts, I
> noticed the registers looked exactly the same as ST parts supported in
> the kernel already and upon testing they worked so I thought it was
> worth throwing this out there. If you guys don't want to deal with it
> I'll just leave it in my tree.

> [0] - https://github.com/breadbee/breadbee

-- 
With Best Regards,
Andy Shevchenko
