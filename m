Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1123149A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 23:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgG1V3A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgG1V27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 17:28:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD4C0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:28:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so704580pje.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=kPGoT8s13omTFNLCI8y7UaQObCEr5Pzu6OocwkPR56Y=;
        b=V5MukAfmPZeP4aIDTIhSue8ndeaeyGkhpdAHPu2hyKKHhOzb1iz8DoClfumxbPXtlV
         N93kujMyBKOCP/idEO/LXjf4GNbna4zE7cgBq52Jv35fyyxO7u7YAofQNnubN9m7mW+A
         oaA9D09fzYr3DaRrgaHZdqjAF6ClKK4d6Pxqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=kPGoT8s13omTFNLCI8y7UaQObCEr5Pzu6OocwkPR56Y=;
        b=MlLpL1u1/W9xdB2C2WrkynMLZFMALluvFdCKJGFopwmqGy25wSmsFN+R+HLn+asHWo
         cehYU9gS4f1s0GCbWsMj3P2KLeNgqL/S2S/s6ICnppCP447C6YqxDNTt+CXBSKICXY/j
         Qj4rYHJi5Gn6oYq8jpLBA0CQ5xsOwmIR6QQ5dq4H/98XNF69NfRyfu0eP+juEbxEE4Mn
         o5LyYou4SY+71dJoR+m44A3rBJ2hzW1AkzVOHLAQ0onOy2gCZr+4cZ9YTu0k+KxeiFpT
         BTe/qcAETFdFJX5kWFhZSeln+pUWSQY6y7jprcFivdl/z7aHCMURjSyMGiOML0qkJFnm
         EMQQ==
X-Gm-Message-State: AOAM530dE/q8+xuJFF4Zqfm1v0A7CtLc4RzpcBGevDiBu1iZzplCUch4
        rxfck2LQNClnAfZqjIux00nFrA==
X-Google-Smtp-Source: ABdhPJy0cOg/GfVtiku/hOfqRfko3DsvECjRR2zpYmFdCae290d7JSv7mlpJxoudN1Jln3ld6Y2Nww==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr25193175pls.87.1595971738617;
        Tue, 28 Jul 2020 14:28:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id t1sm18950308pgq.66.2020.07.28.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 14:28:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.4.I33c50453845a8167969130d514af86e573b6ef31@changeid> <CAHp75VcRBCmRdGh5WVGDY28AzNhBufkoNkrEZ7uEFCW2MsJ=qg@mail.gmail.com> <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
Subject: Re: [PATCH 04/15] iio: sx9310: Remove acpi and of table macros
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:28:56 -0700
Message-ID: <159597173651.1360974.12339018912922779958@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 13:47:15)
> On Tue, Jul 28, 2020 at 12:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 6:16 PM Daniel Campello <campello@chromium.org>=
 wrote:
> > >
> > > Avoids unused warnings due to acpi/of table macros.
> > >
> >
> > At the same time I would check if mod_devicetable.h is included.
> I did the following and no error showed up:
> #ifndef LINUX_MOD_DEVICETABLE_H
> #error Missing include
> #endif

That's fine, but it's usually better to avoid implicit include
dependencies so that order of includes doesn't matter and so that if the
headers change outside of this driver this driver doesn't have to be
fixed to include something it needs like mod_devicetable.h
