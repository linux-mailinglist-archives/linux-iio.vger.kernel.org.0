Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C625D7AD
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 13:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgIDLoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgIDLoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 07:44:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F7CC061244
        for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2020 04:44:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j11so1023811plk.9
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2020 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfWvXIaKWKHOpqe7GIBmTfpMEI57xnisgAGUQNrWcFg=;
        b=vUyNZfLmn0zpyeaW+Yv9I+VkPf0II7HRx/bjGzx/onxeMGn8fe0XqRKIHPzbIyavLs
         dibRne8WG2/75dxoKw0RASBZYnn14AxwgvFsW5D/le8e0Vki6nyrnbmKucOqumG0Xmnd
         dOYRCGg8FRmCRf8k4Xk/0+4ZYjUoZC81I2y33Np2nj4PiKJaGA4/cCKkpPdKx2oZg6vf
         KVwV0ssWPY9BdpPvFqJOT4y0t5e0q/+eKHm0ep9AgtDZTRUlOp+3lg2mWbLlLHGQk3hc
         5Pfa+dXW7Jslsz9DVD+5jucO7TOxpPwa29lmSoF8qgFao/RDdYgquVMUrnilJklKUGK+
         dBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfWvXIaKWKHOpqe7GIBmTfpMEI57xnisgAGUQNrWcFg=;
        b=dNKRFlE1mVwtJ6HKr8G6pWHC3dUNEVb8A2J9kcuiA2rHNezUDulWzvyTfqUTGjf0uB
         S6cC0QW1adizQmj/NSRvQV9rNahPf9lkOCUfPxAVUrZb4J9UD/4OWHjsUOS9cg0aL7Ce
         4CNE3AiD1FotSUkw8aF2vzbKh4J/pNOJK7OLP8rnkH7ZVMaePm3CIAxBb3FueEzINWO8
         sWPcw1RyN0bJ+/02QVIx5OOHDqU+j1TmAL16WpP/W1spZm3LIaiQGZd2PUC1BE/6EYoo
         zZdXaa/uMHYg6JjOw91BC9nadIo91NI8LKZ66caBrthVEy6SNRzQlpUbsqbwy3jBQHOp
         9+aw==
X-Gm-Message-State: AOAM531hLmakZTOv1MiESvs/7h13CR0ImMIbfXnv1h0DlEI5FW0raLB6
        dzSFPdUdrEAL5UejZDmC3aKwm5/e3lwpcZ+EJnQ=
X-Google-Smtp-Source: ABdhPJxBWev2tcJgU5xb59iAOtdnnqO7v0B/9x7lsPMy5FUCojdy7Beaq3iwXf0pGO/8NDrTOePrEl3UtGnTYhZ3Vyw=
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr8005992pjr.228.1599219846193;
 Fri, 04 Sep 2020 04:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
 <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
 <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com>
 <b1581dc61d584cffa2588f72b888ffa0@taipei09.ADVANTECH.CORP>
 <CAHp75Vfe525tpMuhH4Tr4U9gSMo3AzD=WWP30h-ZE6yEkdh4ZQ@mail.gmail.com>
 <705b481901d64d30830689f0aa541cb9@taipei09.ADVANTECH.CORP> <CAHp75Vd0RwDfwv3vHvcCbBhsvwSH0_f=L5aoJpU36xYeCBPd8A@mail.gmail.com>
In-Reply-To: <CAHp75Vd0RwDfwv3vHvcCbBhsvwSH0_f=L5aoJpU36xYeCBPd8A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Sep 2020 14:43:49 +0300
Message-ID: <CAHp75Vfkfi2MWUH_Ldy6xmmv7+iSyVBvAM0mz-tL3pRQXeBPXQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     "William.Sung" <William.Sung@advantech.com.tw>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     "Campion.Kang" <Campion.Kang@advantech.com.tw>,
        AceLan Kao <acelan.kao@canonical.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 4, 2020 at 2:38 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Sep 4, 2020 at 12:09 PM William.Sung
> <William.Sung@advantech.com.tw> wrote:

...

> > And the section of ADS5593 is what
> > we got, and we do a little modification such as i2c bus reference
> > and mode setting to fix our platform. After adding the part of ADS5593, we could successfully
> > probe up ad5593r with the driver in the current upstream source code.

And just to emphasize one more time, you may send us (meta-acpi, [3])
a PR against minnowboard-max the example how to enable ADS5593 on
Intel Baytrail machines that anybody else can use.

[3]: https://github.com/westeri/meta-acpi

-- 
With Best Regards,
Andy Shevchenko
