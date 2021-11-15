Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CC4502EA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 11:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhKOLAB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 06:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbhKOK7z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 05:59:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B74C061766;
        Mon, 15 Nov 2021 02:56:58 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g14so69944074edz.2;
        Mon, 15 Nov 2021 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDYBzQSzEJ8qNHR4ZSCbrzrerx288GE5+SdenhrJtwo=;
        b=koHNRjUBM+K4JXhK8o7/c8mTysgJ8WMoNdETiqEKxq6knvNIIJFghL7hKWxvZoxaEn
         au2adRjaG63ikjqIP2vvf3Sc3boJ26C/d73Ddt69PSE33rqgBDNP7W5F3RtxFBqO+ML3
         ymqEvEcmLdyKOsjOKazH/DKzZLTbbXzChCLSUZztA/KqBCjm/4hkpB+5LMnw38N8dG3I
         RXphJypdRYHTxOApQA/A3qOkN2/mLZhi5Yg5qo2APlw7p+ow8TQSGX3PV0Kp3NQL0W7H
         BtqSZcNYqNtuVtw9qJFeZYENOL2w6iugDvQ9Qb5dvqcsRzqJoM/5VpC6pHng2wCck5rq
         NcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDYBzQSzEJ8qNHR4ZSCbrzrerx288GE5+SdenhrJtwo=;
        b=zp2Vv69k9BbTVMbf6QL5FWvJOH1rSACfAhcu+FSptti9meOpQVap4defPF12WDiZQj
         cZN4FVZ9qfZbGcnCgYuBCx3BtKjjpatqJWGsbJpl2x3jmtEprZf8iE7ZmGlSMTpiT100
         TG+Wghgdm7u/FvhkPKCiO0PpneWCdclpHrNlpxzV47C+0YmH+5lNk2s+B0lvdrZvoWwd
         hemOHwG4vw9y4r4RPL9K0qDuAUPvkScJlPG4ADzSGLuVwyoFWwM5KiTEmHsMBZJpsBZ1
         zHGt85X5dDGzW6hAnuccIOIS0nMXYS0Ct6v94FnpU/I+e7pcbbzk481BqkBUB0rHf++a
         y8Ow==
X-Gm-Message-State: AOAM531S4jfH8OmtgNSyBm9lnkC424A72bo6V3pZwpE5eA86l4F6xq7E
        AihyZq6BIbsaNv6aVVYyNEmyAL++BUbR2ym8CgA=
X-Google-Smtp-Source: ABdhPJye3W7NqMYwzh6/CcsriTOOKf5zQ3aL0EV7sB3dI0P+7ju9iw3c1FhF90DDWaDggEuTF4LWYqFgNq+UURsdJxU=
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr25044783edz.107.1636973817335;
 Mon, 15 Nov 2021 02:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20211115004218.13034-1-rdunlap@infradead.org>
In-Reply-To: <20211115004218.13034-1-rdunlap@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 12:56:14 +0200
Message-ID: <CAHp75Vegc9bskv6DccJCBe1aYjB3mmqQHRbtD0vvYf_oxKi3eg@mail.gmail.com>
Subject: Re: [PATCH v4] mips: bcm63xx: add support for clk_get_parent()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 2:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:

Just couple of side notes on the same topic (dropped people from Cc,
just MLs are left):

> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

> Cc: Jonathan Cameron <jic23@kernel.org>

> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

1/ `git format-patch`/`git send-email` will create the Cc list from
all known tags, hence no need to repeat people in Cc.
2/ Consider to use --cc and --to to avoid burden on the git history
(sometimes people want to see it on mobile devices).

For myself I wrote the script [1] to give me some smartness. Maybe you
can find some ideas inside its implementation.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh


-- 
With Best Regards,
Andy Shevchenko
