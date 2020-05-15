Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042BD1D4D02
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgEOLti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgEOLtf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 07:49:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0DC061A0C
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2020 04:49:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 202so1565897lfe.5
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2020 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWZJQisB640njiNbXdpel4cdg0AxhnskXdou47Rc1F4=;
        b=QQKy1yfKlgEVgZlxZnPSc4KobYi66fc37X5KZbTF709UgtKsHQ25iVQ9eGG7lceHe1
         +WSvipgrDudbGHKKMCHWyD8T0xl51RqwX11Hdj+avT7yhUOzlBLswGsVIHnI9/YCdr+1
         YhhcCmzMHLqe9+Eexqyiofuqtd0kCTc1kI9OZ6s1ss6V8PYkFSfmPFttGk9XKjYOPfOX
         B9fmecEHktSw/dsUZXOUYV+++WUjmjEEZF8oDmbn+Et3zf1bxOdSc7VFsetdcOOP/1ch
         BVps/p++Vr6PnYrFpc0uKvdfPNNFA2rnqOVc9C5xwPCo2ta1ZZm9TGpbNHzb8bIQmRMQ
         xIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWZJQisB640njiNbXdpel4cdg0AxhnskXdou47Rc1F4=;
        b=phA6twWgaYbcPj6W57RP3ca2VM6Zz6MOdrenBA5czRypG+fH1mxiVFbH7/IvcHY11T
         c+fFTZJB58jEDNIQmDZ+tkiJ61S8Cau6X0Q9l7JL/RHtM3ymzgiEY/1E7YSYSeihTIBU
         4SsRrK7W0DNCV+n3FMGN2c23/N+Fa7WJUPucDIUzKF2Zb9FRny++n3yERRWTgD9GetPX
         mXy0GR2y2DFsh8f4h2GaotXXkfEmsJE/f1nt78O5NCcc5PIxxxaMCtL4zOXh75b7C4E9
         N6/TXIoBcA+2uVSQ15hwJ5TN+JZgFlTq/Nf+Thncv8ZPMDaQujQNIy+3swvDIICyOq1S
         alhA==
X-Gm-Message-State: AOAM532xny12BTLqXeckmTHfRVkbmYPExAl1H7x6ur8dCFAgSv/GVW3b
        lPGG8MXzaS4KokhLP9SRQUTu/a3sBTo0Sn8e1AmPQ1NH
X-Google-Smtp-Source: ABdhPJzHseX/OaTVLiyuLxZCQZIEnSA0EuKj5TIZhiEbuayaYYcvsEL+IwgXAnQZHChm/0jP+VL1Q+/k5OjYy9RKlo0=
X-Received: by 2002:ac2:54a8:: with SMTP id w8mr1066569lfk.89.1589543372862;
 Fri, 15 May 2020 04:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200514204901.3199-1-xc-racer2@live.ca> <BN6PR04MB0660C7BA4CE07978AEC884E1A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CACRpkdbucZ68KODd3shecm0uEkFgTzh4XiN08JdCM_chYApoXA@mail.gmail.com>
In-Reply-To: <CACRpkdbucZ68KODd3shecm0uEkFgTzh4XiN08JdCM_chYApoXA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 May 2020 13:49:21 +0200
Message-ID: <CACRpkdaOZmHgbFckYifF7=_uMY3DcmoVOY_1WJXKP-6WvnZOug@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: accel: Add bma150/smb380 support to bma180
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 15, 2020 at 1:48 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, May 14, 2020 at 10:49 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
>
> > The bma150/smb380 are very similar to the bma023 but have a temperature
> > channel as well.
> >
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>
> The temperature channel can be added later, let's go ahead with this!

Oh I see you added it, missing things ... thanks Jonathan.

Yours,
Linus Walleij
