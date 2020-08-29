Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C943E256875
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgH2O6a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 10:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2O6a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 10:58:30 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB48E20791;
        Sat, 29 Aug 2020 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598713110;
        bh=c0kH1mCkin6PKzxzOGkPMYdlHMTyS8+zEbWgSAhV7MA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GgBD6YzjxULoQJnUtXFt7VfdIJRhe5Rd0Tt08OJQOX6cb2ViCdIsWieiBWFfxLp7Z
         W965S6TkGiT7GL3a4c7/VPJoH3zgqNE7QMv+oBem+Tsl701+WBCt1wanClTa4LSMBy
         Now+DMobFin8+h8+QiaFz3A8p0dmEtUGlt+ACdqw=
Received: by mail-ed1-f50.google.com with SMTP id ba12so1686824edb.2;
        Sat, 29 Aug 2020 07:58:29 -0700 (PDT)
X-Gm-Message-State: AOAM531/X7gUg48e1uBzoluGH7Br3Sd0GhoWrq09KmBgQkkONayjntlo
        MjMUXL8ct48fM9hNqxswFQbSo8f5TxfFikeL6hg=
X-Google-Smtp-Source: ABdhPJxM3CQK1OUYoZ5xYcqstuCBrGAvaHwGlRhHKRx3pZp07S6h8XeiruczSbp5HTZyR8vx10Hdf/0noh1hFptm3rw=
X-Received: by 2002:a50:ab1d:: with SMTP id s29mr3881143edc.246.1598713108547;
 Sat, 29 Aug 2020 07:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200827201707.27075-1-krzk@kernel.org> <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
 <20200829155410.6d34a8b9@archlinux>
In-Reply-To: <20200829155410.6d34a8b9@archlinux>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 29 Aug 2020 16:58:17 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd78m-3jMsFRa7ySREDdx+GMZ_YHMG3AcqCHTABLBwqVA@mail.gmail.com>
Message-ID: <CAJKOXPd78m-3jMsFRa7ySREDdx+GMZ_YHMG3AcqCHTABLBwqVA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Aug 2020 at 16:54, Jonathan Cameron <jic23@kernel.org> wrote:

(...)

> > >  ANALOG DEVICES INC AD7091R5 DRIVER
> > > -M:     Beniamin Bia <beniamin.bia@analog.com>
> > >  L:     linux-iio@vger.kernel.org
> > > -S:     Supported
> > > +S:     Orphan
>
> Given it should be covered by the catch all for Analog devices IIO drivers,
> either we should confirm if it should move to someone else at Analog, or
> if we should just drop specifically listing this one.
> Listing it as Orphan when they are good at supporting their drivers
> may give the wrong impression.
>
> +CC Alex to make sure people at Analog notice :)

Sure, good point. I wanted to start the discussion so the interested
people might appear.

Best regards,
Krzysztof
