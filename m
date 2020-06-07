Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076C41F0978
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 05:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgFGD6y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 23:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgFGD6x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jun 2020 23:58:53 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D732C08C5C2;
        Sat,  6 Jun 2020 20:58:53 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e11so8474797ilr.4;
        Sat, 06 Jun 2020 20:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/cS6f9J812r4tB7KJdDZrfq1C/ybFEsRANYeNySp4k=;
        b=MeQZD4uZ6vTmE3PAchgTkj7gmhhxkP+W+zxoGusUUgTLlesbNdh4/X7eEp8TGdIVZ/
         b6kNFbVPfH2yf7VphObnxKbWCMGhRXHqET421pu8NcVhYkSYUN5E6i+t8/KE2La5XaLq
         0Al1/sqz/8FPrBxBPZrTxSm4YXb0YmkFEp0WE4kDyKIvaY7hoZHa+lTqTmhr0K4fe5R2
         zXr26adUiDnkUDh+kLLJklSI31mW937Ian6FnLkOitb8So2IpSjnqmD23ilCSpKOTuUk
         WxmFNPXPEmSM2Vp5FbTAuqWO1h1/Iv/xWaXkcwypq3FNucej/Jm1DDI8sUn2FsZjBzZu
         oM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/cS6f9J812r4tB7KJdDZrfq1C/ybFEsRANYeNySp4k=;
        b=bKLYp274+22mly58bhjJ/mZKwYZMA+QC8hdI221PzzfUJyA9ahsT+tZKX3WNQgXFXE
         pPj6sYFJ+WdAcmRBguL2yQFM95zbgU3k5RWcF/Sfi4N6x1KUhV6KQciYRGuOVQ5+lh2Z
         fYg5w5nNNpRRTtRDtOCu8w8pmpDS+1ZK72iQsh7TBFNTanrNJHPo8OgeH5v+qaj/w/T0
         1rgENZUrix7BH1nVImIF7y6ln+ITM0p1OX3oWoGbC7djDis61BWBbu/3W+hqA1G/xaN9
         83fqtJCPS3EZ0PGcXnWn2dO2M5MLtXNLoHeUAdq8r7aNbinuPSK6EB4XhkW58dnKq/UZ
         JNnA==
X-Gm-Message-State: AOAM5306BrwZ6yaTJVWVApdDJBdnHDpyKaPXqo4aqKLXVW3tYY/2kH9f
        zJ5hXLy72rRGXCTVIs+z6/c2vTy2+8Jv7quhFRA=
X-Google-Smtp-Source: ABdhPJzMi/3wPZFwa2oAlzgvtoQfZz316Ivh4jYLtc5QdAG+EJe0AfZMzK02CXZySv8brt+JFKAQps/8eFWcCfggxxg=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr16305228ili.40.1591502331972;
 Sat, 06 Jun 2020 20:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200316124929.GA389@syed.domain.name> <20200318020506.GA45571@icarus>
 <20200322175831.74e10aa7@archlinux> <CACG_h5qctM0S2buQHHNnJ_qVY6YY2wYruj9aTKH9RiJ=9_LfoQ@mail.gmail.com>
 <20200404150633.2421decd@archlinux>
In-Reply-To: <20200404150633.2421decd@archlinux>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 7 Jun 2020 09:28:40 +0530
Message-ID: <CACG_h5o=V_y33krqojmANnqG+Uf7FJmOVmkY-MGZ+zLJR+Q2YQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic interface
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 4, 2020 at 7:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 30 Mar 2020 23:54:32 +0530
> Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> > Hi Jonathan
> >
> > >Looks good.  I'm not sure right now which tree I'll take this through
> > >(depends on whether it looks like we'll get an rc8 and hence I can sneak
> > >it in for the coming merge window or not).
> > >
> > >So poke me if I seem to have forgotten to apply this in a week or so.
> >
> > Gentle Reminder.
> > Thanks !
> > Syed Nayyar Waris
>
> Thanks.  I've applied it to the fixes-togreg branch of iio.git which will go
> upstream after the merge window closes.
>
> Thanks,
>
> Jonathan
>

HI Jonathan,

I think only the patch [1/3] has been applied. Patches [2/3] and [3/3] have not.

The three patches were:
https://lore.kernel.org/patchwork/patch/1210135/
https://lore.kernel.org/patchwork/patch/1210136/
https://lore.kernel.org/patchwork/patch/1210137/

The last 2 patches need to be applied, I think.

Regards
Syed Nayyar Waris
