Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5439F6DD
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhFHMhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFHMhl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 08:37:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E78BC061574
        for <linux-iio@vger.kernel.org>; Tue,  8 Jun 2021 05:35:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g6so15603833pfq.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Jun 2021 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EtSen5x9pYOvSCLuPlXvWs/V8hs2GAQuKNJwTnNHRe0=;
        b=jnGctsQSD2ll882C3rvRdrk9ZcBMqRBFH82PxAi60Fr8cIvux379jQyLL5VZLnLlRU
         IzQB8d0p9N8/LgZEirr3KJcfl1AnSH+/KpCThC+HMKJ+0cPnkEKVF6eDSa8Sx5Hhy4IQ
         VmFuBIqRJYu6hGUM34Kpxi2hOWe3sv3DFb31FCAqhdHaHDUyDkc4CEXaKVXbXxh0X81N
         v5Ysso+LRBwwsEkl37Kfiag2oOM1rW220lLAjQfEw1L2hPAFRMnNpJDXX4UYl7kSvRzj
         mJ+EITs4uTy/zPXhrH8bdYYkeFMU0R+1PqjH2BsVZGZ+OX251qxl6VsuQAsUcEuvBEt5
         Yy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EtSen5x9pYOvSCLuPlXvWs/V8hs2GAQuKNJwTnNHRe0=;
        b=SELXybsYJ9zm+1G2bjeS1PEFLONm3lwhP8sf51BLSeTlTsQ3vLGQ1x9J3lpcAv+IR1
         qpBJkS88kkVbhF7vsdC5iFWelXtB4qV2/qkxFlQmBM4L/vt0LNbRO3UJ3jw8eZljhgIa
         5qH6Wwobx8y8uEZ4Ry+dwd09p5j3EBMHMMFH2uVN3rEhnne9aVmIId6Chi0Czf+CAIci
         XBt57Zrt3TdJqiN8GIlyn2BV8x5KBJbdgh9rY5HWx2ORUo/xsqN1kH4Jg9fv7VyHJbLz
         liDce098wAk+n9+u0KtKADEjF2j6OYv5h71wnSKFXIw7LXmL/EdF2h/izVl4JVU9ZyIb
         IOnw==
X-Gm-Message-State: AOAM533SAk1nwiow2kT1WPg4mKDC/uqGKlbC+Y6+TFTqM6pGktvoDc4l
        6FuE18/JyBopuhCUXZiC/NtHSxlWceWAY92yCoMvp5+8UvmPgA==
X-Google-Smtp-Source: ABdhPJxpuIEgGXgd3YfKUFCEX68z4M5Nbb5w2S+zWBlCZFjDbwtqzrZKwr9chpuEgVoqS2KtmbGMFwWfMhJhftBCSZA=
X-Received: by 2002:a63:b507:: with SMTP id y7mr22576075pge.74.1623155748420;
 Tue, 08 Jun 2021 05:35:48 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Jun 2021 15:35:32 +0300
Message-ID: <CAHp75VfuoWi72b1wAYoJD_mF6+s-h7k7JCU3CFbEzuGtYBuCZA@mail.gmail.com>
Subject: atomic use is not atomic?
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Can anybody explain this code [1] in terms of atomicity?

  if (!atomic_read(&trig->use_count)) {
    atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
    ...
  }

AFAIU how atomics are supposed to work the above doesn't do anything
atomically. I.o.w. use_count may be simple int with the same effect.

What did I miss?

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-trigger.c#L166

-- 
With Best Regards,
Andy Shevchenko
