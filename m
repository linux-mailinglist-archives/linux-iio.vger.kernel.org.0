Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30A12A1B13
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 23:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgJaWsE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 18:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgJaWsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2020 18:48:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B2C0617A6;
        Sat, 31 Oct 2020 15:48:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i7so5858014pgh.6;
        Sat, 31 Oct 2020 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xQ4xsGDDibbe+i+6RvFTkO2wJW2NaeHMDLuyBg8zZeQ=;
        b=j4HW+c7sdTjHhTVlMcrDVKsQ8Sj375kqTb9T+0kjlPkLpsJjV6fkbSiUk0X10DpCeB
         cNAfVH4QahdUMHaWyq5UhZH0zWswIKdobI9Hohg66KYBJXCuD1e8ua6GZDUJTIip3vLH
         Qiur+TrCmhrmc//EumTSGTidluHj74u5J+80LbFqD19O3UmBqlgZh0K4XD36/sFjOEs+
         dxZWne53TN87B3BmZus+6b2s00CWViylp5DyWxO6EmC2ufZVCA8t7TxWeiBbgjRxn3Wn
         NFSiaSsCA4wOBLEyntUccwm3oXmQdMcoon369cHXxX/Lev88h0dC+EBjv2dvU6s763de
         DV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQ4xsGDDibbe+i+6RvFTkO2wJW2NaeHMDLuyBg8zZeQ=;
        b=hgZhcS6B/2uUwMQV7WYBhP9rrSEul+YnpZl7gsCDKcY4RliZ5rXfhFyj2L6d6Nos0r
         SzrP3uaNivjdfgiQxE3F9MeXaEcVxRYRRjdWP5ufQTN4NQVdn4P9GCGdV6Y1oGgNDOV1
         f0EJ4N8WZqj7v4Se/1Pw3zI+HVYQuFPJaUOHPjjo/5dScHrL0SmLJMok8sfrmHLCHs5Z
         76Osn7P93wknbw1EWf7f8fgOY5RJ3awRBlX+3dxez6OMtRARaZDzJmkn0u4oRleIc1Ap
         VBuG/RWLLIlzf/uwDIZXYnNU7LD3yyFz1Z+oVyt68U0CbBVSTEkrlUu86vXxWoAjUywE
         JvIw==
X-Gm-Message-State: AOAM530wH4AtZsUMmRSLITh2youBCNN2NhKNfsFbF9mbD1Uw1JO9tiZ4
        HDeN/PmIOoIxxy+efMzJ+tTW1RyxtsjNuw==
X-Google-Smtp-Source: ABdhPJx8zvT5t5qTPzHlzXXdCLmjsAmk0vS8llPQZplrNHKHNt/3cGRSut2Bmi/H+thxJ7QgwL44Xw==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr7532180pgs.259.1604184483898;
        Sat, 31 Oct 2020 15:48:03 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id gq24sm6107420pjb.30.2020.10.31.15.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 15:48:03 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Sun, 1 Nov 2020 06:47:35 +0800
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201031224735.atjih4opb6w57r6y@Rk>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
 <20201029144007.77d967b0@archlinux>
 <CAHp75Vc829u6XPPA+eE=_AFZSPF+yVqT7nUXxtzkwx7-xLLrCg@mail.gmail.com>
 <20201030143410.pbixjo2cllhd27zp@Rk>
 <20201031110511.515a2f0f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201031110511.515a2f0f@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 11:05:11AM +0000, Jonathan Cameron wrote:
>On Fri, 30 Oct 2020 22:34:10 +0800
>Coiby Xu <coiby.xu@gmail.com> wrote:
>
>> On Thu, Oct 29, 2020 at 07:06:40PM +0200, Andy Shevchenko wrote:
>> >On Thu, Oct 29, 2020 at 4:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>> >> On Thu, 29 Oct 2020 15:48:56 +0800
>> >> Coiby Xu <coiby.xu@gmail.com> wrote:
>> >
>> >> Please put a cover letter on your next series explaining the context.
>> >> In this particular case some of the replies you have gotten are
>> >> general at it is a lot easier to find these sorts of things via
>> >> replying to the cover letter.
>> >
>> >Looking at the number of duplicate messages I would suggest that one
>> >needs to go through documentation on how to use git format-patch and
>> >git send-email.
>> >
>>
>> Thank you for the suggestion! Actually it's a tree-wide change and it
>> seems the kernel community prefer individual patches or series for
>> subsystems having the same maintainer over a huge patch set so I wrote
>> some scripts to automate the process. That's why you see ~50 emails
>> with almost the same commit message. The only difference of these
>> commit messages is the name of PM macro.
>
>When doing a bit set like this, it's worth sending out a small subset
>first to shake out issue like those seen here.
>
>Once those get merged then send out out the reset.
>
Thank you for the suggestion! Actually I've held off another ~150
emails and these ~200 emails were only part of work. I thought it's
better to reach 4 or 5 subsystem to collect sufficient feedbacks
considering some subsystems may respond slow. But I didn't realize a
better way is to cut down the size of patch set sent to a subsystem.
>Thanks,
>
>Jonathan
>
>>
>> >--
>> >With Best Regards,
>> >Andy Shevchenko
>>
>> --
>> Best regards,
>> Coiby
>

--
Best regards,
Coiby
