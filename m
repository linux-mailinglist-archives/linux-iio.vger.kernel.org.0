Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186561B398D
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 10:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgDVICR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgDVICQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 04:02:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41202C03C1A6;
        Wed, 22 Apr 2020 01:02:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t63so1175044wmt.3;
        Wed, 22 Apr 2020 01:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=276h72KTtylrnULr9OGp8Ofnvi/+2QUze7tpHtVgUYc=;
        b=NRyeQPoUxhqd6VJaDmPOxUvzPKFp5UVW+KAXnh0USrkJDLUSI5z0xUCrR19/VNs66q
         ha/QKAWGlTTRrOikeQBb5UwzTTqvcURrzdkEL3jciUpeEATZ2jTPA7CfZWoC5U7GENiL
         3aCRzlXmFoVsfv7DSo9chTp1x/C7HK6V/z17Uek3vbB2/cTvDVcFo2OU2LKh2SQ2TSiO
         KEkSIYTUyW14UckA1ONlpt+rUTExOjiKyHi5oEw0lTeyAzRsSUb2Qf5FXilEGAQmeyLu
         /nZk/zSsPg+20W+WseUIl8zuUTfjwsbitxeBmd3V23Ih67ThPj486UKKKeiOpvDOENRg
         a9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=276h72KTtylrnULr9OGp8Ofnvi/+2QUze7tpHtVgUYc=;
        b=pugg+379XImwfirT65jYpM07X3uDgEFV9qTr5oDdMHLCFi7g88nUXhwVH7TgDWHbtN
         kO/Zu6qFEVvFxpTXOz5EZowmqAKVnk7j6F16n/T0iRWUm4eG6ugm9XwEOmhriJtsnHak
         cRHhC/DHD6G/qsORebhz7gqBEUWlSV94sNvxfsDWtUWUes7h/pti2H9sWRkAl+XRXp60
         rYbmDcG8U2lxk1NyL/Ks8cO70f2BcyWtgY4Kz1hbB6NRZ2WvUsJbiMzGmWGCu7pTXxa/
         kErsIGgSRbODZ0S/ZuHq2JXqLilvBb4ssPKLOcf5LRQdousqm+nqmgjCqTJXnvJBnyTM
         eG4g==
X-Gm-Message-State: AGi0PuaBXtFG0Me6Es5pEeoF3onpA0Cns8zfU4OiTzs8fcBCb6lz6Wbp
        Gt1WcBCSPsJ8IREx6V6eQ0NR5dhu+fM=
X-Google-Smtp-Source: APiQypLUIvMLQElpQ0YeDX4LXgi+d6EVLy+A09/FAG1IA0q7WkePThaGskKab/Prr5WYqQs9OXVMnA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr8830283wmc.76.1587542534579;
        Wed, 22 Apr 2020 01:02:14 -0700 (PDT)
Received: from meru ([2a01:cb18:832e:5f00:1d35:d245:4470:8434])
        by smtp.gmail.com with ESMTPSA id t16sm8175157wrb.8.2020.04.22.01.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:02:13 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] iio: vcnl4000: Add event support for VCNL4010/20.
References: <20200421075532.19192-1-m.othacehe@gmail.com>
        <20200421075532.19192-3-m.othacehe@gmail.com>
        <CAHp75Veqp=tb0Z9h2cey5DE_KpNBp3Jdmh2gLzSoo-N5CsGpvw@mail.gmail.com>
Date:   Wed, 22 Apr 2020 10:02:11 +0200
In-Reply-To: <CAHp75Veqp=tb0Z9h2cey5DE_KpNBp3Jdmh2gLzSoo-N5CsGpvw@mail.gmail.com>
        (Andy Shevchenko's message of "Tue, 21 Apr 2020 14:24:30 +0300")
Message-ID: <87y2qoosn0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hello Andy,

>> +               ret = devm_request_threaded_irq(&client->dev, client->irq,
>> +                                               NULL, vcnl4010_irq_thread,
>> +                                               IRQF_TRIGGER_FALLING |
>
>> +                                               IRQF_ONESHOT,
>
> Isn't it by default when threaded IRQ is asked with NULL for hw handler?

No, and it fails with this error message if IRQF_ONESHOT is not set:

pr_err("Threaded irq requested with handler=NULL and !ONESHOT for %s (irq %d)\n",

Thanks,

Mathieu
