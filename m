Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9934CEB4
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhC2LSg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhC2LS3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:18:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3BC061574;
        Mon, 29 Mar 2021 04:18:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j25so9673187pfe.2;
        Mon, 29 Mar 2021 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjM6kqJWcLsboF0CflsMyyl3j3b/v1YKhrm9/OL/HjU=;
        b=ldBJwE/HqIUPhrTxrSSJEBWAd8qJr9zhY69pXN316hnkvpjBkXWHGlI8HJg+TAiGKV
         EVpjF6zZnvRM1j60NlmvH0VnB86dLKzElQb+cirriEElfJeoiQSMu0hINz2T+Fg8PRaK
         GoS8WvhnK3kNnQSoFs1HxvgkbIMgfvbxnSWTM8kO1S0edMYuIJYxyh1DutxmA1sQ8M1q
         MO6GLLW2D9pPLahnHgj/Yrm5VHoxFHb/+V8oVzTyOLE6PB0QaykZQLwwykhMdtIdTdJP
         xhvozAszwXfc1eCMa1ZWFD4O34NLlmRKMGLlGD915PTZuhNR9vDxn2KYLfBY77AuGduk
         0NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjM6kqJWcLsboF0CflsMyyl3j3b/v1YKhrm9/OL/HjU=;
        b=B01fiAnZKbRpcnwArBPPKedXVFURePpRjahw2MifaWMAM2dcJFjCEhR9CC/ei4m3hC
         wpNETBoDqWgZPSiXvbuXv+qBTql+7JBBCNfgp+/CHMhcTD+mANNo1CzSAGpdlINgFpgc
         1ywV26C4fEI6/5x1zX2gsRVtE6K4YBE+Ijbe1EX38umLp6Yz1LBsKsf8Jw9M0EjWNU9H
         f+wpUGRP0MmDMtH5lUrqm23bPcT/7zXDf+MUw9g7wpCOTRHFK7xkgxDsBsF9XZFFJJFz
         aiakkQk180oIeBgpXujwHdazQ9QmxgkdKFS6fi//n++nJ66jmnEm0ejPrKcCGlMONObN
         zRGA==
X-Gm-Message-State: AOAM532YiRfOX9xbY2GS6p02JY5GR7nkXFpbN9zwSDlbPHT4oNg4yaUf
        SCSJy9u3QAjbJP+WL7kQ7m06DtvMyUfIbEx2J7M=
X-Google-Smtp-Source: ABdhPJzsNkpwVlflfAYOG9eT+Z0IQauaEiOGqW3ToB14LhD9CWtZq3JdTcVIbg+7lIJgkhgNVA00zdRLmlRIl778hw0=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr24382446pfb.7.1617016708213; Mon, 29
 Mar 2021 04:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210328035159.47259-1-julianbraha@gmail.com> <CA+U=DsrbZN51cR6tbyNuwQ-zZnauOrmqetGa6T8+RtcC58mxFg@mail.gmail.com>
In-Reply-To: <CA+U=DsrbZN51cR6tbyNuwQ-zZnauOrmqetGa6T8+RtcC58mxFg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 14:18:12 +0300
Message-ID: <CAHp75VezbdesY=wf0T8+ogkST-E+w80dJ=a9f0h9Ch3cPQOi4Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: adc: fix unmet dependency on OF
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Julian Braha <julianbraha@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 29, 2021 at 9:43 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
> On Sun, Mar 28, 2021 at 7:08 AM Julian Braha <julianbraha@gmail.com> wrote:
> >
> > When AD9467 is enabled, and OF is disabled,
> > Kbuild gives the following warning:
> >
> > WARNING: unmet direct dependencies detected for ADI_AXI_ADC
> >  Depends on [n]: IIO [=y] && HAS_IOMEM [=y] && OF [=n]
> >  Selected by [y]:
> >  - AD9467 [=y] && IIO [=y] && SPI [=y]
> >
> > This is because AD9467 selects ADI_AXI_ADC
> > without selecting or depending on OF,
> > despite ADI_AXI_ADC depending on OF.

> Thanks for the patch.
> This should have been fixed a bit differently with patch:
> https://patchwork.kernel.org/project/linux-iio/patch/20210324182746.9337-1-aardelean@deviqon.com/
>
> Can you check if this fixes your setup?

I have to add for sake of the clarification that we are trying really
hard to make drivers agnostic to the device tree provider. In such a
case the same driver can work for all existing providers (ACPI, DT,
and board files with use of software nodes).

-- 
With Best Regards,
Andy Shevchenko
