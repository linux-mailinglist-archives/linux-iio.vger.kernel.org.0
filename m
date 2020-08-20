Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1895524BDA4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgHTNKL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgHTNJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 09:09:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B9DC061385;
        Thu, 20 Aug 2020 06:09:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h2so1027769plr.0;
        Thu, 20 Aug 2020 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rcpRkVJoKyVY/3B/RffNTzv0GP7F/59KL5DNPGHvfJo=;
        b=Kf51tNS8rKp5fAVzk8nTv6XAPFRnqZ12quyqy90P+iGzGjaHGiEmXk215a5rwrkSjP
         A9fpL2d/oKHqMZuzlceR1N+yUW37/wGUuyGI2rqGbYRU4IfIu5Y5Xr36e6nNOACeKDpE
         hfe6IgfeFgaMbOu9luA8b0ZnspPXVfd/jy/6pJSbyFsGc1+Ta5JD6ea2V5uans9mXq7m
         l6TwHmRnHyAJU+1xiDgPliP16TTvr+pXxZ8kr6J5VOUDEERoejv26SWpqR4NShZ/2zwd
         lepX0NPt7T5uK2lT7kOUp6EYB2b1xwt0bdWHRlJ/+qcEwRRLSwYtreuJh/ptx6IZcWPF
         VAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rcpRkVJoKyVY/3B/RffNTzv0GP7F/59KL5DNPGHvfJo=;
        b=XDR6QuSRZND/3w/D4H2bucl7ZHvbuNEiGyYGGjxY/NkQpwL9QdobTgu5JHX7+ouuSk
         WiuXVp04bWdYqVhseZxYsoNOqAZ4NGr7YmEi54+jjtAVddfOiUZU4Ef1/F4j99Gio4wK
         RZ50DV9tUfwoRiM1dZOMhJesoJke0dW3p01K4qqnPfDSFYK/dy2JeNMiLT3psJl3TLA5
         0icNCbmXmLRIXNz8f8oKEqIgISBuyp5piiEfusF/4nfXGyw/3X89BylJwkKRD0vq6J+t
         HMuIDG3xZ+g4oA8qFHhk8MQUlCDjqR+Bc/UalyRYks6TsLhmuovYdzJMdUGIBbJ5Fy8W
         9FSg==
X-Gm-Message-State: AOAM533JAHufeMrL2Lb8k/tai78dj+LmJYQ7kjqsUPkBbkXibhfjec5l
        2nH6R17amEu3iVgCBZLXw4bnwGgOH8JMtDEq3W0=
X-Google-Smtp-Source: ABdhPJyu0tldf5JCV8BFWNDw6/Y2eW0lJLDaQEyv+8zGx6tjmMIqt1bgmh6TEetWI13G8rBzfiKhrUCbyej3YoEdjxk=
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr2347505pjv.181.1597928994060;
 Thu, 20 Aug 2020 06:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <1597912282-31254-1-git-send-email-anand.ashok.dumbre@xilinx.com>
In-Reply-To: <1597912282-31254-1-git-send-email-anand.ashok.dumbre@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Aug 2020 16:09:37 +0300
Message-ID: <CAHp75VeHut83MwpN8VNycXetcH1W0uu0TNm7o5BHrqp-9BB_gQ@mail.gmail.com>
Subject: Re: [PATCH] iio: Fixed IIO_VAL_FRACTIONAL calcuation for negative values
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>, git <git@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 20, 2020 at 11:32 AM Anand Ashok Dumbre
<anand.ashok.dumbre@xilinx.com> wrote:

> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.

This is not the footer that allows you to do open source.

--=20
With Best Regards,
Andy Shevchenko
