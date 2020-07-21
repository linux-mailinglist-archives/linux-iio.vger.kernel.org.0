Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36030228886
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGUSro (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgGUSrn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:47:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E33C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:47:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so12355824pgb.6
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7I5bRoR7seiQ5cvsSIryDzGm4lk26OIDj32NDTBjzAQ=;
        b=ImH+lWHBlTYg/cCBoix7emdLvdcB+l6sPDQR+MZsTt/X4Afck4PNRbUS0jI4csSk9y
         skGQjZzpsOTo6Dwcv/d3y536ua/OZYG4Y6P0frmQOuDa7i9Ksr1yg+VhMRychYHxy0IZ
         KgqchUOTCNjoci72Q9y5M4xlGgI+hCzFtpx/FDnm/dzSn5jhwNEw3wqvLgrFPOJe9AOD
         L2MAZQhAGSA/HgcUBWCYffQTYJCzsFpamKJYS8HRJx16F1WTaTNa+8h4f+VY8/L1y7a1
         kM/x5hPpDA8BiPinMc53jq+/RXqu6XZ5bDMRruDFIyXTOdjHiPGlhwySINM5URbGiL0c
         05IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7I5bRoR7seiQ5cvsSIryDzGm4lk26OIDj32NDTBjzAQ=;
        b=ikJNxV5R73rg74ZIGMVnM3CDoCBZ/tkVFTPNwHzVkEO7yM+Tgrds1zdLnpf1EcZaGM
         YC9SDOQp6T3Hhx/8ddZJUgWeZHGi8F7RsclMgW0O1t9goxJEh7bdx1Z70lSbIFEsi1Nb
         j7cQDUD81zv+1dgMVZxYS2ZiasW2ZGaPjm126hlOMWhvYHwjlRkcj3jtw4B6U6eDRVmb
         92TCfuVgKTmNJ4fZBVTlQpSBVWz9EZDRT/1DDdUPG0tv37OXjen0NLo5GjjzGA6y3SF9
         tq20f2DxhUkBQW3lmbp/hCZaPSuEfYvSywpRevUDuVdkRbszy5+Iv7XB3DM3EToHkZ8u
         MxdA==
X-Gm-Message-State: AOAM530Zc/+V7ToynOFeurSLJUxii3QRb36PSZ1BHxBWP0w5LpReSIJ+
        HAggvk1Vz2e1Y4x+T8f23Ce5iOxb7CkvXgVX1hI=
X-Google-Smtp-Source: ABdhPJze6Kl44gDOe8oXqL2s8/VvAVeK9W66WvIU+KazoKndxHQtVFbJ45GJV9/pZyc1QfhebY9oocXeW2fmHob1jjs=
X-Received: by 2002:a62:8ccb:: with SMTP id m194mr25923098pfd.36.1595357263395;
 Tue, 21 Jul 2020 11:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
 <20200720070330.259954-4-matt.ranostay@konsulko.com> <CAHp75VcuwLoX5Xxb-BGPKE6BWnDJq=O5knV6u8wWXYsLHfGL9Q@mail.gmail.com>
In-Reply-To: <CAHp75VcuwLoX5Xxb-BGPKE6BWnDJq=O5knV6u8wWXYsLHfGL9Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:47:27 +0300
Message-ID: <CAHp75VfiGxv1q2uC6DC-ZXS-qq23rxRUkzTvdeux47qLwDtEow@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: chemical: atlas-ezo-sensor: add support for
 O2 sensor
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 9:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 20, 2020 at 10:05 AM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:

...

> memmove(buf + 1, buf, ptr - buf);

ptr - buf - 1 (off-by-one classic! But double check)

-- 
With Best Regards,
Andy Shevchenko
