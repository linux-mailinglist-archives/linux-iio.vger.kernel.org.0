Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7544F443
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 18:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhKMRDn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 12:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhKMRDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Nov 2021 12:03:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44FCC061766;
        Sat, 13 Nov 2021 09:00:49 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r12so51255953edt.6;
        Sat, 13 Nov 2021 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzr6hqPaqeFQsYV7ZmC/msLggXZwKuPMEdg+38M1W3U=;
        b=HCVrwhcKzj36Kep+LJ7VCw/d4SyxNKqMubYVFTcIETIDTSMRsCXp0HfKt/JfGyxE3/
         0yN/oMhLkv4hyeiLUuuXCqPn4no/dmoysIyrewBGm6yboHsb2AyFIW7iTnGraHdxjW4x
         Bc2G/2hUv253lxPyLcr4dgSIY2LHcGGnPejQoTPg9cXwsOsECxPssz41xQCMUOg56bEp
         lu6/cgDnS4EUmH6aVxbT6V7/1+RBrn/kvaEhJXJk0BKs8bJCmgmnTuy91DgUESPN4E+k
         NkY9WWBa7kNIZgaEb7pbBXKajck4xqRDpg5uxq9zYVl4ZmJcS5SLaCFKrFuaPjwnNiGz
         rPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzr6hqPaqeFQsYV7ZmC/msLggXZwKuPMEdg+38M1W3U=;
        b=UJM3UIDK6OYW03hPfGlyqIaJr6nbJ94Fseh23TQhnNp5tFyRufIPhzSKeJ+cupOoDM
         oHaxesZczfz5+UWGnRERKYzjEqzlovO7fkYEx8DfI1PBakwe7iRjGObAORZBD+VQ0Ar3
         w+vMyglGYQcvMmW17Pac38dHDwx+hsCQ3puNAUh/V9pT+rB1LqCoUqNmFhr33mDaKCD2
         SN7k4rp4P5e7ZrxdKh4b6PN5I20nwahaiMyFyWHjqKY/W2ARN7s7m+ax4XMBemif9Rcl
         oXDwfAXsJD3yGtye7PetASXIl5Epdz8bRwS3aOBBDZfqTgZETtsZpxnrh07g/TCtuNbi
         sxyg==
X-Gm-Message-State: AOAM530JXnDdM6BPV0yq2ornsD5hMP94fIRLuyupOpAHV35YmG+EZ487
        cm33vt3e2VB3T5+Q/ZocTmBVJsF0io3WmSpd7BW4sypwdlW8aw==
X-Google-Smtp-Source: ABdhPJz9X9wljGH4ATns3jR967PlUACOBc+Po+GtTxXhV6i801HqyIRhV2fpefEtxm79x5zFC2wC5Mou/lZzmkOMNSQ=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr31839238ejc.141.1636822848367;
 Sat, 13 Nov 2021 09:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
 <20211110111750.27263-4-alexandru.tachici@analog.com> <20211112171448.79b4e8cc@jic23-huawei>
In-Reply-To: <20211112171448.79b4e8cc@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Nov 2021 19:00:11 +0200
Message-ID: <CAHp75Vf8+HH8t-pqXtd3=FT5=9T4T2ke+ceQ-pyAyvmH2pN9zQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] iio: adc: ad_sigma_delta: Add sequencer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 12, 2021 at 7:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 10 Nov 2021 13:17:48 +0200
> <alexandru.tachici@analog.com> wrote:


> > +     kfree(sigma_delta->samples_buf);
>
> krealloc() preferred.   It might not be necessary to actually do an allocation after all
> if we happen to have one we can already use.

Looking at below, shouldn't it be krealloc_array()?

> > +     sigma_delta->samples_buf = kzalloc(slot * indio_dev->channels[0].scan_type.storagebits,
> > +                                        GFP_KERNEL);


-- 
With Best Regards,
Andy Shevchenko
