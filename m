Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE41C18ED55
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 00:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCVXod (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 19:44:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32972 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCVXod (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 19:44:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id j1so3871106pfe.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 16:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmMShW/GUFC3Yvu+SDL4Yk8LQjTS+uHX0dJqMxCZxrU=;
        b=ooZyW+b8UXk6/KQZudpn/oxms4PlSmTPhAkU0isqrQxv3Ku5BfSJPd/kLypCBOFsac
         o9WTHI+3wTSu6rq5+N2N+uXCoe/DZ6ploTBkCGqcCwvRZNmSeWVRkDIZRLwfZPcPq/6H
         0AQ0RKBME6Lux++k4dOoX75XwI9pGmzNFWwHZQXqwoWTyemBGudxU78gycU5pPMyPu9q
         ca9YptG9DS2EgqHVgNnFOkDzxAsQh6No1yscaVnPNI2PcsdDcyBTjChMTfDSm2O5nGB4
         7jsZq6/ICGm3F3RDaMd2eCZyd52dRQp+uRWA3syCPozFxpVdRj9S+4gLabe+8e2K1gze
         P4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmMShW/GUFC3Yvu+SDL4Yk8LQjTS+uHX0dJqMxCZxrU=;
        b=tNAbSE5sFRMk+S3aLwGPyxmpH7BLLUVtkJcXCgTJEUdZcs5by1vkU/EtjVAQSJh1PF
         Zt1STK9QrgVXkbjtvV7YHZnUvnYR3s603zwpjl2kSFPXimQx6khpTn6e8RiCEulv/xbh
         P5fZ3/3DnVZ+4tcA+dRGzRrmxqawwkjTkNklVpGIMt+Mjduvz/oQoHDZAfG4uNzrNv0+
         rSsikHsW8JeifCm2+eI8Cb5Qlw1C+3nKPYsSqJ2nw1JX8gBdk79x3xmYBS9tTgPDZ6up
         7jzBfiTbyPbAKrb1D3hGuxNT9QNJ9CU66YUVjWW7VeuhWXip8H+Cb9zMlo+MHeeFu6sR
         /VoQ==
X-Gm-Message-State: ANhLgQ2NU00ZIYnvM75+B0Y53etdmgQwr3TKQCil/x5kohpYRi3uJIQA
        MY6KLu/qtM4UP0JVGqt6UStGSMBA0/pvJdqJnmw=
X-Google-Smtp-Source: ADFU+vvJXAvMWPmRyoAxyKCBO3xcRa5a68t5X/yLhbwgz9AsGDfYEDkiEoS9v4NQPXIuHD2ogGsXbPjvszrBc/dbf9Y=
X-Received: by 2002:a63:5859:: with SMTP id i25mr18619637pgm.74.1584920671798;
 Sun, 22 Mar 2020 16:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584904896.git.mh12gx2825@gmail.com> <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
In-Reply-To: <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 01:44:20 +0200
Message-ID: <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] staging: iio: adc: ad7192: get_filter_freq code optimization
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 9:57 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>
> Current implementation of the function ad7192_get_available_filter_freq
> repeats calculation of output data rate a few times. We can simplify
> these steps by refactoring out the calculation of fADC. This would also
> addresses the checkpatch warning of line exceeding 80 character.

I'm not sure you did an equivalent changes. I believe in the original
code precision is better. Consider low clock frequencies when 10 bit
right shift may hide some bits of the division.

Care to write a python script to check the precision between old and new code?

...

> -       /* Formulas for filter at page 25 of the datasheet */
> -       fadc = DIV_ROUND_CLOSEST(st->fclk,
> -                                AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
> -       freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> +       fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode) * 1024);
>
> -       fadc = DIV_ROUND_CLOSEST(st->fclk,
> -                                AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
> -       freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> -
> -       fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
> -       freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
> -       freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
> +       /* Formulas for filter at page 25 of the datasheet */
> +       freq[0] = DIV_ROUND_CLOSEST(fadc * 240, AD7192_SINC4_FILTER);
> +       freq[1] = DIV_ROUND_CLOSEST(fadc * 240, AD7192_SINC3_FILTER);
> +       freq[2] = fadc * 230;
> +       freq[3] = fadc * 272;


-- 
With Best Regards,
Andy Shevchenko
