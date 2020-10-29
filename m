Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03229EE89
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgJ2Omh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJ2Omg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 10:42:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4997C0613D2;
        Thu, 29 Oct 2020 07:41:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so2527106pgg.1;
        Thu, 29 Oct 2020 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sbl4kUBqXsqoEC/wAePAyBYbjphx8xZlaqYJL8Bo1v0=;
        b=GiPGkx9HKJWYGxP8FaD9hGkzMOzViq8vKcruKxAaRT6eKOmm04HhATQTT1Y3WFwgtP
         fXBYBgJhLGgR+IK0z13fkdMCL20tjG7S4fXQ4NA07x/p376tIRLQLfKkV828J8dt2rtD
         +Rm/wRNTiofrHlHjxagggtgfaEWoz24ZtExICY5DGeikIM2fvj5Ixax9xz58+KmLVNFw
         viqRXzAsQ99Hg6S/tkTlgv6etnOXQVHotst+TZH7iYdU98+LGBhr53p5IhcsI1Y7ICKc
         Ka6a4m7fdRlx6PxtztzeSCMFa/Y6fGI33N38nZ+WglMq6g6KiLBRYuwGRkxI/IzBbGzw
         drzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sbl4kUBqXsqoEC/wAePAyBYbjphx8xZlaqYJL8Bo1v0=;
        b=Io0NFfJmp1TUkfW1+m2tilItdlvU4BuMB3DuQIiLCyKiUrQ5CuqYQu4vb60PDlOOM1
         uOCxtqYvwAMtVjUj/ugqHSxkGstjZ5I0e612HD30nEreLQgbFEAul7iL46bDKVwNoGNS
         bDM07aAx+somjdFSAgfDNQKa2vKHhxHNOYLSXHAQhUg6Cpn4+pkej8TkVa1l6NhG+YtY
         SN9KNp7UxanoKCj+duW/GH4wcYY0avmfZ0aJrwKkyLAmyTbIDqWG5WVvHaAeRawJThh+
         NfmSdyhYr17fZnYQEjFkcgxs1Mn+d08iZQomf3O+y8N03CNI/F7ERlix1gNdXZCIfYI6
         YDJQ==
X-Gm-Message-State: AOAM530mFOoieib+d69/Rpq4mVWL1hb25y0EXcdGjE3Qk8JiK7Kvze6K
        svk12bjUAk8nIFcV/whrdsOZ1/PhnFRIT+eL
X-Google-Smtp-Source: ABdhPJyVtiwqOyGUqEO3k6MSzVkyQhsQjj8E8fZ4j0ImpG2iwkRFugZhXMDcETjLodH7k/gNCLjj4A==
X-Received: by 2002:a65:4987:: with SMTP id r7mr4373678pgs.124.1603982502402;
        Thu, 29 Oct 2020 07:41:42 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id w19sm3345803pff.6.2020.10.29.07.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:41:41 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Thu, 29 Oct 2020 22:41:19 +0800
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201029144119.d4tcehdeapbjihu7@Rk>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
 <20201029074910.227859-5-coiby.xu@gmail.com>
 <CAHp75Vd6J_k_F8HceRbXAbi+cPq=YJBnY7rHyNU__uwnnkHvyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHp75Vd6J_k_F8HceRbXAbi+cPq=YJBnY7rHyNU__uwnnkHvyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 01:57:25PM +0200, Andy Shevchenko wrote:
>On Thu, Oct 29, 2020 at 11:05 AM Coiby Xu <coiby.xu@gmail.com> wrote:
>>
>> SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>
>Correct grammar and rethink about them.
>
>NAK for all of them.
>

I'll add __maybe_unused, do the compiling testing for each changed
driver and also correct the typo in v2. Thank you for the feedback!

>--
>With Best Regards,
>Andy Shevchenko

--
Best regards,
Coiby
