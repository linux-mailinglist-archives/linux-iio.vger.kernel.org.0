Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E13F416C
	for <lists+linux-iio@lfdr.de>; Sun, 22 Aug 2021 22:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhHVUNR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Aug 2021 16:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHVUNR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Aug 2021 16:13:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395FC061575
        for <linux-iio@vger.kernel.org>; Sun, 22 Aug 2021 13:12:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w68so13526320pfd.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Aug 2021 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmBEBv020jBWFiTOT9/n1uBfUElbcFVO5rXGs1TEzGo=;
        b=TqwBUxNpEIGFaK9U4i5oCV86CeVdd753cAPK5VBvkjksvgrqafEyz3AVCapVudcNDP
         6Xz9mZt3P6dJeDS72XmsLC3F3PLE+Kz9G5JfTVDjjvmUzNs3HcPerWLKF766JT/BbQvq
         k1wXiBcsrK120alIXvlVDZbRwKVXJZiyHSvMIrzeDWFbchhZus09AIDgM/VkJ8NGZD/2
         CkL29QB6Y8V5tJhHAyye3J2ttQ/H1OJsc7AP/cstRkk2CeHKDJf8LcFzIha6WRDuP9kl
         oN4WJeq1ydAEUQeim8oNzdGblENiwA8pquaStq77BVzNPW42AFsV/RWywd90dLyaXbt8
         GYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmBEBv020jBWFiTOT9/n1uBfUElbcFVO5rXGs1TEzGo=;
        b=NrvkslY+6buSyJbuyAgZIISD0sHJsmodgGabdKIvyVUZ76jxTYuW/kAbLq+mvSgL/v
         Eoq4muJJ7RuEkBgU3CzWqlw8dWyl1diBdaxaCOL0zv7PphGDOObKEasqrWQsQup8ufMC
         PO96GCkVoANWOws1veIRlUD07FdRSQ6HJ445PlBcnqx+3C+fFj7lNjqvArgAOjefTBOv
         ViFw1X8NfjscBESngxkA2mXjbSfO/rTaG/Brv9zv1/GpeTJlcZv0RSGWnYFWBxN/FlZI
         kcLSHBSMMS/ybs0FQoTOAn2gRpNP1Pa/iGGxsD8z1aFagGD66yMLdld4XkZcnV3s90KT
         DFig==
X-Gm-Message-State: AOAM532PpPpGt2CtQpHHeXVgLeVj1Zy/7sAn03Z7gUa0YYg1RxmjJjE0
        YCB0Q6XcGXCL4Mr7tppxDgEO96NNCp2NP/UKqQI=
X-Google-Smtp-Source: ABdhPJxCnwdqX30A6NpSEgVM/7aD8TfiYPK9RloKnzBsbHMn/ThJweg6+gx5f7IwfzmbZLDEc9k55C6Ies8tSABO26I=
X-Received: by 2002:a62:6384:0:b0:3eb:13e7:18c with SMTP id
 x126-20020a626384000000b003eb13e7018cmr7720648pfb.73.1629663155482; Sun, 22
 Aug 2021 13:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210822184927.94673-1-jacopo@jmondi.org>
In-Reply-To: <20210822184927.94673-1-jacopo@jmondi.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Aug 2021 23:11:59 +0300
Message-ID: <CAHp75VcM8Z58_EdzZKxy8r=BojYsfgSM+F6fSuDgwTbg1zvXVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: chemical: Add Senseair Sunrise CO2 sensor
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 22, 2021 at 9:49 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> The driver supports continuous reads of temperature and CO2 concentration
> through two dedicated IIO channels. It also supports calibration and error
> inspection through the concentration channel ext_info.
>
> Minor changes in v3

Not sure, I have found bigger issues. See my comments in patch 2.
So, since it's obvious you haven't tested the patch and we are at rc7
I think you can take a few weeks of time to have a look and carefully
address all comments and to test.

-- 
With Best Regards,
Andy Shevchenko
