Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAEB25A708
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIBHtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 03:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBHtY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 03:49:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10EC061244;
        Wed,  2 Sep 2020 00:49:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so2402861pfn.0;
        Wed, 02 Sep 2020 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5FAVlvq9QPyASEovxNqW/1ceIbYdLvcWL3H2moVIVQ=;
        b=QKIuRhGKYWiVXul6kJn4PE7MOpq1UYT2PAvwQ3iEe13mNwEneJ6F7v5JIjC+14kE2L
         L+h8QvH/DfzUAhJVifObYz3ZBrivrzNzcowZX8V1/DKuSgkN8uEg1BPjskohQLbeXQKq
         KYNUaw0y88urTe4NA+RP4iL/YbG9i3L1l9le+cdW9jLAyNFYYVsles5sKsu59rqZEYwg
         dsjwFcp+p1R3AAXZK4XnIAaFEsNu0qT5JxCLFEShcus88Nm83vryCyM9VOTDCAONR8H2
         IMCIJGZMsGyWyXDU6+W4RGaREThclDglxEUcxPfceBGljPO1EAlSZmiH7Rt+Sd2D0TMe
         nG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5FAVlvq9QPyASEovxNqW/1ceIbYdLvcWL3H2moVIVQ=;
        b=A1BncCNpE0ED3CIX3guCtbaSdy7ZHPIRQIvL/MZH/ZgAzXeG6kXe/VWiIfkcH+Xfop
         sTCHpic6+mdU2F9Fu6HzbTUzqLkN6TfCHwHQVZ5w/IGPfPpWHkVV2ThNCXoVxVnDe9RZ
         2srRIFzZFsuhA2OJP/TjLC8xFgQOBYrFGSXPSn5GRFSRd4rvZtnD3xghmftqrkb2TBIY
         SX1454iOtbZgaMRxu5CgJdLqxWkr9RuK22ZFpxhnsjZTlvZP7RQEVe9/cyQvmWLPLn3T
         /+Zh9HSOEwD0HhX83ssaldNokCAIeRXM4YYpzBZBLZ2W49GjwCJXi0mdjA2ASu8Fo9lx
         kIbA==
X-Gm-Message-State: AOAM530K2BISDA0T6ajz6V+uWMAwQpFhUZ/h1kiZPzZM7UaWMWCfbAZu
        5ItaHMMP6P/0v2CE5FJfMoV/vunUSmaHzS0J9l4=
X-Google-Smtp-Source: ABdhPJxxOrJQXVUy9FuLZZGcIseJhYCxgfhXfDKLEAOkMWfgmK9dUgFEu5x7irt8DuGCxwBxtdHH7xozqZehOA3RWok=
X-Received: by 2002:a62:fcc1:: with SMTP id e184mr2096353pfh.152.1599032961751;
 Wed, 02 Sep 2020 00:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200827201707.27075-1-krzk@kernel.org> <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
 <20200829155410.6d34a8b9@archlinux> <CAJKOXPd78m-3jMsFRa7ySREDdx+GMZ_YHMG3AcqCHTABLBwqVA@mail.gmail.com>
 <DM6PR03MB441122FDB3323690166C21A0F92F0@DM6PR03MB4411.namprd03.prod.outlook.com>
In-Reply-To: <DM6PR03MB441122FDB3323690166C21A0F92F0@DM6PR03MB4411.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 10:49:04 +0300
Message-ID: <CAHp75VeOQpR00AZhaw=Dy3sEArhSQAPHXb7mhJGB80uyrSZ3Qg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 2, 2020 at 8:56 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> [yes, I know, bad-email format, but I wanted this to come from my work email]
>
> Apologies also for the delay here. Things pile-up on my side and I defer things a bit.
>
> Talked to Michael Hennerich about this [since he's the more senior contact at Analog].
> We can replace the email from Beniamin Bia with Michael's.
> Or, we can remove the "Orphan" blocks and just have the catch-all "drivers/iio/*/ad*" cover this driver and others that were upstreamed by Beniamin.
>
> Either option is fine from us.

As a participant of activity to put MAINTAINERS in some order, I
prefer to have similar blocks be squashed.
If there will be a dedicated maintainer for a certain driver in the
future, we can always split into separate sections.

So, something like
ANALOG DEVICES ADC (I guess it makes sense to have some grouping still)
...
F: .../ad1234
F: .../ad2345

In one section (no need to have wildcards right now).

-- 
With Best Regards,
Andy Shevchenko
