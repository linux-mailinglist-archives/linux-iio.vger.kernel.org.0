Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F4243A96
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 15:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMNML (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHMNMK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 09:12:10 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D3BC061757
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 06:12:10 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q14so5468808ilj.8
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kgbv9YB1y3fE/nDDgJaA6swPPpZ0EmrDwIVpE0CkUgg=;
        b=C3buRZWdsYcNqI4jadY6OAqYyUHidQT7+V3ZH/7k7Lf+6i36DQpzZi9G4QzmOjrTpB
         ZUFJvwCBcbSJDeyYvnUZzJCJH6QP+tTAwBrE/eKDB9VjsdZuR4481un4Slp5FxtF1QX/
         6OH5do1MRZZksHLsw/CqC+p4paKDcID004QWw9HYycLmaVASKYiLfZg+4Op8C/A4LlOH
         fBz49l+G1071dyRxJOhiL0SeUeB1csu7e+oRa9MTfe4r3RbwvDhRGO+TwJ29Xq3R41IQ
         A512gMgnm9fBvmLVadxdgZuYbAOoc9PcCeYmuvcaAa1QANLKlgdNsej9bKmnZ7ZHdASY
         JDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kgbv9YB1y3fE/nDDgJaA6swPPpZ0EmrDwIVpE0CkUgg=;
        b=GF0d1nmbrp/N6I2hCWA3RclXc5TedWMyE87q5CCfoKT2nVxl27167iQjHFVqS750Ac
         kEcI/ddOKs8QQT/uprU91IHwojw1PF78ZxWBN93i7Im/beFJG37jeSBsxaF9qhpye8VP
         5dPVlWKahyNPbiC6ufoe1VIUJk2NVEY1LoBitBZFc+GdRbcJhzOyzkH0PgU2eTO4KIrK
         PMjzthGNpbChyzrrf+WvFoDHRKPxQ9XY81ArQ1P/dAo8b571/JvfG4CVHg0/OjKumk7X
         EQJYY1IbbyjpnGVlbjUHdZMC3OpegNnCDsXuFkT5Ng9jiJuKquQeMDlxXx9Zn+cHO/ml
         hTRQ==
X-Gm-Message-State: AOAM531tR2GGXE6v9sAEZAFBYp8y8pkD9CXbEdGy/+XmrkXEttyXLKst
        zzDo8Mk14hlIfx3C30Kh9xYOy099rfHG4Yp0Fthxjw==
X-Google-Smtp-Source: ABdhPJxzCbr3874CCoMv3jd9cPHc5jl4QIrNWFGyuutdwUmixrM2MRv12IEFnN3FXc5OeOa60bZATyUIkxpFHSmtems=
X-Received: by 2002:a92:cf09:: with SMTP id c9mr4832246ilo.38.1597324329610;
 Thu, 13 Aug 2020 06:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-6-cmo@melexis.com>
 <CAHp75Vd0D_jq7S=ANLJ-JSTb6iD1vHVRs2cN25Y3sNWCC9L2Xw@mail.gmail.com>
In-Reply-To: <CAHp75Vd0D_jq7S=ANLJ-JSTb6iD1vHVRs2cN25Y3sNWCC9L2Xw@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Thu, 13 Aug 2020 15:11:32 +0200
Message-ID: <CAKv63uvrrc6Qfr2FjzgnNsHC0maZWT1Zpo=WQZvMmGgtYL6-tw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iio:temperature:mlx90632: Some stylefixing leftovers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Aug 2020 at 13:01, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
> >
> > There is some inconsistency and whitespace cleanup performed in this
> > patch. It was done on top of my other patches, but I can rebase to head
> > of the togreg branch if it would go in sooner.
>
> ...
>
> > -#define MLX90632_REF_12                12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> > -#define MLX90632_REF_3         12LL /**< ResCtrlRef value of Channel 3 */
> > -#define MLX90632_MAX_MEAS_NUM  31 /**< Maximum measurements in list */
> > -#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
>
>
> > +#define MLX90632_REF_12        12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
> > +#define MLX90632_REF_3         12LL /* ResCtrlRef value of Channel 3 */
> > +#define MLX90632_MAX_MEAS_NUM  31 /* Maximum measurements in list */
> > +#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
> >  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
>
> This was actually in doxy (perhaps kernel doc also understands this)
> format of description.
> Can you double check that the kernel doc is okay / not okay with it?
>
> If it is okay, perhaps it's better to convert others to that format
> rather than dropping it.
>
It is indeed from doxygen and looking at other drivers it should not
be OK. I checked the docs and it does not say in fact. Maybe Jonathan
knows, but he was already OK with these changes in v1.
> --
> With Best Regards,
> Andy Shevchenko
