Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E530248FF12
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 22:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiAPVZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 16:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiAPVZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 16:25:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65845C061574;
        Sun, 16 Jan 2022 13:25:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k15so57272190edk.13;
        Sun, 16 Jan 2022 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkHqHGWDMO2S8ErOMYU2TYQtBD+QqkroZ/Io7kj/iR4=;
        b=BrRDtjxRT60E15V2/0H4zOS3YU6bnNJC81ILKU/s1ZI7siQBj3ev/WBMpB4xYuVcRX
         2/AY4rX3RwN77jVRjT0u5FKf/RAiSX5VY9fxp2BVSwtjFDeVOChO9zOmmo2H/VQwSyW/
         vOwADbFk+8gNKq5No2mffBwSUYdpdce3mOE/1oxANNIU/TD5Jh9kgbaWYzFZFKYxrHly
         H9U2jjYzPsVFNUoqzYAYA2OU50WRJMfrWBJYE/Tq88bgHiTHC9gb1I6p+vnKoYsDf9Jp
         yNm7g9660wQfR34zXtNeWZBfEKDui1o3BbyhI+3Hlb0LGuWtl7Dz944v/w72DmfLy8cM
         o6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkHqHGWDMO2S8ErOMYU2TYQtBD+QqkroZ/Io7kj/iR4=;
        b=Dwh8jheXqeOEeHRL2qUdHwci8vteaV3WTH0vOpqvgc2ZXtlxA6B6vJTylil62QL3ls
         Oy3Ub58d3Uan1/Jv05wGzsr+96HVAkBih0zDm6BKXcXwJ/YPfCyMadJgTOJdKJl6dITp
         0kD5zk7pc78Y7wASRt5B2I25N+Bn8KM5A+ZXt7ziAsgr7ceAMtYbVjmKDQE7aOnmOU3C
         hv/LpF4KSPEJ8TbaVaiwc6ht3K5bIgW0l3mRMzmMkmBfoBfpEQTmU95DH9nqIyeVAJn6
         By54skWIdX1076XTLvlrypJ/HRtU1VbrDMfY5lvqp6fQnBdfe8qgTHcD3Hd2ACGLpRsU
         zZKw==
X-Gm-Message-State: AOAM530CDV0U3ZjGhlpGxO4d/pnrnjRG7fms0xEQq6PapRNrgoyTi6Fx
        ZPdeJowEeEvZyK5hSwniqg0kGC8pHeXOgnzjs5uKjTkKLfPTGw==
X-Google-Smtp-Source: ABdhPJw3izEHJeXRQXktWVVbIEMep10jJrLdsI2kPye/SIoyiHeQDSW1tOwc0xglXUGVQmeO1UFHTbDCLDdwSieiwSs=
X-Received: by 2002:a17:906:8693:: with SMTP id g19mr9445928ejx.579.1642368351891;
 Sun, 16 Jan 2022 13:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20220115092705.491-1-nuno.sa@analog.com> <20220116173429.698919f7@jic23-huawei>
In-Reply-To: <20220116173429.698919f7@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 16 Jan 2022 23:25:15 +0200
Message-ID: <CAHp75VczFs8QpsY7tuB-h4X=H54nyjABA4qDSmpQ+FRYAHZdrA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add support for LTC2688
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 16, 2022 at 7:28 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
>
>
> >   * Have a clock property per channel. Note that we this I moved to OF
> > since we now have to use 'devm_get_clk_from_child()' which is using
> > device_node. Note that I could use 'to_of_node()' but mixing of.h and
> > property.h does not feel like a good idea.
>
> Ah, that's unfortunate given the clk is only needed in certain modes...
>
> Andy/Rafael/Rob, any thoughts on how we should handle this?  Obviously
> ACPI and clocks is generally a no go, but in this particular case we
> aren't looking at a power management related use of clocks, but rather
> using the clk framework to provide a way to control one of our inputs
> used to generate the output dithered signal...  If the device just its
> own clock then we'd just control it directly with no problems, but it uses
> and external source.
>
> We don't know of anyone actually looking at this device in conjunction with
> ACPI so maybe just using dt specific calls for now rather than generic
> firmware properties is the best we can do.

The problem is the CCF is so OF-centric and maintainer(s) seems
skeptical about switching it to use fwnode APIs (they wanted, last
time I tried, to show how exactly it will be used, so here is your
chance!), but OTOH switching to fwnode API is a half made road,
because for ACPI we might need a glue layer which may be way too
tricky to be considered as a part of this series.

-- 
With Best Regards,
Andy Shevchenko
