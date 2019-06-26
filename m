Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4881D5722C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZUEx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 16:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZUEx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 16:04:53 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E78421726;
        Wed, 26 Jun 2019 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561579492;
        bh=X/TJG4C67uj+QUKHwisoqZfc5Kvj94fNEcC3CN0WB94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l8Gsoh/SJBlaAxZJZN8+Aw1gi526kwtkbhRGPFAL/rPI9VcVGHSg0XyKNs0662pkE
         UVTvGUkCenYwtnIbZ7hEwwLm3hWhoBxY08KOUrW8ggIJx/pH+TzpvswxO2JPFlJaKw
         BL8S9x2dlOQcyuIPOj8O0YupH5/Xim22p9lVtOPU=
Received: by mail-qk1-f170.google.com with SMTP id c11so2755109qkk.8;
        Wed, 26 Jun 2019 13:04:52 -0700 (PDT)
X-Gm-Message-State: APjAAAUb+25L+upX1s4ads9MHz8e0O4eRgTD4EzHZuz4BE0qutU0mHOJ
        U0xA+D0clGrFV+dnoVxPlxo2oDv8ChCzUg3zgQ==
X-Google-Smtp-Source: APXvYqx9Wqp3U8SYJhFU7onUuLcS2mEmyi7gNYeK7pL8Fg15uhD2NucDRkOOFa4EDWtQPKvRvcevUInPbBwLEdWt56Y=
X-Received: by 2002:ae9:ebd1:: with SMTP id b200mr5743819qkg.152.1561579491498;
 Wed, 26 Jun 2019 13:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <1561389236-26464-1-git-send-email-stefan.popa@analog.com> <20190626204820.513fb866@archlinux>
In-Reply-To: <20190626204820.513fb866@archlinux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 14:04:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLmXi6Uy9W0tXX87tHuV99H05_+yc98mRUmX_JA0bG=4Q@mail.gmail.com>
Message-ID: <CAL_JsqLmXi6Uy9W0tXX87tHuV99H05_+yc98mRUmX_JA0bG=4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: frequency: adf4371: Add support for output stage mute
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 26, 2019 at 1:48 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 24 Jun 2019 18:13:56 +0300
> Stefan Popa <stefan.popa@analog.com> wrote:
>
> > Another feature of the ADF4371/ADF4372 is that the supply current to the
> > RF8P and RF8N output stage can shut down until the ADF4371 achieves lock
> > as measured by the digital lock detect circuitry. The mute to lock
> > detect bit (MUTE_LD) in REG25 enables this function.
> >
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Bit of fuzz on this due to me ignoring patch 1 for now.
>
> Rob probably missed the binding as it was buried inside a patch that wasn't
> clearly labelled and it is unlike him to review part of the bindings in
> a series.

I wrote my reply this morning, but then got distracted with why the
meta-schema didn't catch the problem of missing a type definition. Now
it will once I commit it and fix the other cases that we already have.

Rob
