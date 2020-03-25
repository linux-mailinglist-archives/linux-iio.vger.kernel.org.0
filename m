Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D4319313A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 20:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYThv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 15:37:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38098 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCYThv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 15:37:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so899982pfo.5
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2020 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rddCUKG87r7Bq6dWzJnqpFjeuq8ftyaCXi979E4AXfU=;
        b=fN+i13xi9ph8eBAPsQjTaGuoLjpOq672ojPRl4NnTLVE8i/SaZloifztd4K3hf/rdG
         7g7Cs8AMBFgaZ69BN2fLV3cFBFIMLF1hG9zhNg/XwfzyJXVh1wpYzjxeHPd3t0sBxu1J
         7TBaV25h1/Vf4BPdPRUCGZB+Mn/JQJVDCLDeZNdMmrgW0rwOrOPVTlKnxeiuFbbjOfqf
         +kRtzfpjYGwWhuhGazOWge/K8dKJhSIcwQGx9MyvchFQGbAzp6wyeSoOzRWKmYURVWoV
         eMuggTjLqJWp/Wbe64Gmg99e5lB81/gY5gMRqURH7iFlnoy48e6xKtAGjt7z2mhDnCH/
         tuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rddCUKG87r7Bq6dWzJnqpFjeuq8ftyaCXi979E4AXfU=;
        b=NKG9U6EoerEjt3DJ9oE1+CTsa6F10337/BRweWZkDQXPxgyXKMgbNkgsk8GteqJ9/d
         alkKPAGiyRReyMwtNa5ZOkAklwwbDWjLY+te1iikLUowRAylv6BumYGBUuLkdHDmIOOd
         ai5dfjvew+zjSV/jldSCckH4ea4eKs1NOenJE85P4rjLXJOYHfmPyOJEnmyYrLBq16NK
         7QgNVe2/OwFYn3EU6kRdS666PiBVCW5EkUUJjdXmG+vYyWDH4ARzc9cd8GwLGPavK6dJ
         M3fhmrMYwNbzhTtIC06FZyLDKH81UY/XMqrbBRJaGoTni76RB0un7rLxKFVDNBBTa0Ix
         X8XQ==
X-Gm-Message-State: ANhLgQ0akjUMKlMxffZAunBuU122bnDPr1AP+HUbHp0YJkngDKVadDFj
        /hLijTGXyrRgQCWvOf2Li294r1/9Oz4jRs/h4y8=
X-Google-Smtp-Source: ADFU+vv9Yx9Tl+FL3Qit/jlTuPyByDsZcUlV5ICqrDfUAMF4CrwD6OPPKgVJTKmhUG0S8uNwpePUasvUr6wWyY+9ZEA=
X-Received: by 2002:a63:5859:: with SMTP id i25mr4519803pgm.74.1585165069778;
 Wed, 25 Mar 2020 12:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584904896.git.mh12gx2825@gmail.com> <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
 <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com>
 <20200323014935.48048405@elisabeth> <CAHp75VfF+oDWsOF+_=U6YBeP60XLF=SLYzExa=5WjLSgoMUw9A@mail.gmail.com>
 <20200323131531.1d6c8f93@elisabeth> <20200323175223.GC22110@deeUbuntu>
 <4385dc0509f035bbd14d85b81527997f7a2538e8.camel@analog.com> <20200325173815.GA28246@deeUbuntu>
In-Reply-To: <20200325173815.GA28246@deeUbuntu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Mar 2020 21:37:42 +0200
Message-ID: <CAHp75VcLj8YLg=iBejQj+UGmhK2nTm1TxETASxt4qDhGOnN0WA@mail.gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
To:     DEEPAK VARMA <mh12gx2825@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 25, 2020 at 7:38 PM DEEPAK VARMA <mh12gx2825@gmail.com> wrote:
> On Tue, Mar 24, 2020 at 08:06:34AM +0000, Ardelean, Alexandru wrote:

> I further reviewed current and proposed implementation of the
> get_filter_freq() function[Thank you Stefano for your time]. We realised that I
> was wrong in swapping DIV_ROUND_CLOSEST calls with mixing
> multiplication in it. It is indeed incorrect to mix multiplication if we
> want to reorder the calls. Comparison of the results from current and
> proposed implementation proved it. In short, the patch I sent is wrong.
> My apologies for any trouble.


No problem, that's what community is for!
And everybody has been learning always something new.

> We have further improved the test program with a revised implementation
> [attached with this email] and found that this revision appears to
> provide more accurate results [I think].
>
> May I please request you to review the attached test program, verify the
> results and share your feedback.

Do you have GH account? I would highly recommend to use its Gist
facility for such small (one file) type of programs. It allows you to
update them and see versioning. Dunno if possible to comment, but
anyway more advantages.
Thank you!

-- 
With Best Regards,
Andy Shevchenko
