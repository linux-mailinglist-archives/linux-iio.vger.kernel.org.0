Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892FB6C0B7
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbfGQR6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 13:58:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38541 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQR6r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2019 13:58:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so11216789pfn.5;
        Wed, 17 Jul 2019 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8HQuCB2v08Yln0bNuTQlxaR1maXNczeOW7YEb8C4Oo=;
        b=IECISgBdEA4C4UaoDjqifGX4QrCDXIyvu19ZuK92uB+VigMMRa/RGdrivlNwGZvOz9
         ULFMc3zcnfd98uDG2NprDiokeWSgflzsdH6y4inuXpBEKpdcVNPeI/vG7xpmlevngyVg
         t35m9NR3HAYgrYy9YuPWqfs+9roCQIsTBFDfoVYGBewrgnWFOFJshDDKePJcf7gDlQTT
         AsR7T9biGdj4FOXFV0TE5RHe2f64wtm0ykcXel5Ir1wtu3tq2rLClcVUgIEDtLjShgRL
         ih2KE/6mQqJI04cmjfVfHMV7KV1Efh1Hywo+vCbd2CNNoHt9Yn0ikaSUjIdj6YleYTXQ
         AvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8HQuCB2v08Yln0bNuTQlxaR1maXNczeOW7YEb8C4Oo=;
        b=EpQG3c4lnPsnDt5+tzpx6C0A8SLSLCntgMi8az1qWKi2uhJQGEtAxeNI916xOmOBK4
         wOGZD4qlzzdUJ5/Dr/8OPmo5R1aCoBydYYXstRSGqqDsg5L0fQRNYeIO6ll+D23BOP7P
         /lyN/1XUSqwnvhF9McTix/6pawo2s0akv/Hj67+Afa/QrkR5WXkeIb5TwBTQ/zQvDAy8
         L68gEE0UZ1rkmmIDM/+dekIBu7HvkWZ0lfQqiUfj7vyWOpPf4huDZzfjlyVUknO63JJw
         5IoUbRJR486QW9Hz3HFTZOHBuAraw4ZqUynkiRG+Pqlg9CuhjmjGYuGDii0jUU5xjZv5
         Pg9g==
X-Gm-Message-State: APjAAAXdBKZjqFAzXbew7bJkHGvhnhn1TOp+0K6J6FjiodYOdgDy3A6q
        5b7E3IIQwAgJ7bGmOt/9NrE=
X-Google-Smtp-Source: APXvYqzp+ZoGjZJreUYg6UNYO2kMKQanjpN0iWxUgqIqs33D1uMnM234u2gPPQkL7KWsoXw5vEZNsw==
X-Received: by 2002:a17:90a:b883:: with SMTP id o3mr45286080pjr.50.1563386326687;
        Wed, 17 Jul 2019 10:58:46 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.46.195.2])
        by smtp.gmail.com with ESMTPSA id x1sm21459532pjo.4.2019.07.17.10.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 10:58:44 -0700 (PDT)
Date:   Wed, 17 Jul 2019 23:28:37 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH 13/14] iio: trig-loop: SPDX headers GPL-v2
Message-ID: <20190717175837.GA31268@himanshu-Vostro-3559>
References: <20190622145516.3231-1-jic23@kernel.org>
 <20190622145516.3231-14-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622145516.3231-14-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 22, 2019 at 03:55:15PM +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Not exactly standard license text, but clear in intent and it's
> my copyright anyway.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/trigger/iio-trig-loop.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> index 9258d3cf149b..f0205a9e47d0 100644
> --- a/drivers/iio/trigger/iio-trig-loop.c
> +++ b/drivers/iio/trigger/iio-trig-loop.c
> @@ -1,8 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0

I think it should be:

	// SPDX-License-Identifier: GPL-2.0-only

https://spdx.org/licenses/
https://spdx.org/licenses/GPL-2.0-only.html

I don't know if `spdxcheck.py` points out about
such a mismatch.

Yes, documentation and sanity checkers needs to be updated.
https://lore.kernel.org/lkml/CAHk-=wipjStEwJj2_iWxBdVC4oV8rY5NjrRb1tmWLUa0VrS_Eg@mail.gmail.com/


>  /*
>   * Copyright 2016 Jonathan Cameron <jic23@kernel.org>
>   *
> - * Licensed under the GPL-2.
> - *
>   * Based on a mashup of the hrtimer trigger and continuous sampling proposal of
>   * Gregor Boirie <gregor.boirie@parrot.com>
>   *
> -- 
> 2.22.0
> 

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
