Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7EF2C3E49
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 11:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgKYKkm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 05:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgKYKkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 05:40:42 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E7C0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:40:40 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so2099368pgg.5
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xy54Dojebwga0mRevo3c7Egh+U9A/OXFrWD6f+Oalf4=;
        b=NGkplzai9OOQspuAiE3nq6KZSOm9PeS03chgFcU+y/2CSp6OCK/mbiiyWxdRVXlcUk
         tnE3lxIE89iAHE7ss3cydgg6fl/JW7t+qib1Zw050f0+/V2dYa+LP91fsOMhGA8ZoRUV
         6EIbb6YaqrIxY/HSgu3Q0q46c+KEcTa8/rcajYK0brGKCVrjmhqiU/0Pq7CK0wD9RAXG
         JBcqsDzH7MwUaobW1XhATcIIKL8x74335UvNmnvkP1/ewJCCincSSqyWB4aJ+RgG6STN
         yKT0CD59IBklJHiT05Jg6ExCgAYeJYZ7QbkJW90aOC6rh6MU+8C576VEGYOhqPGNt+2u
         tU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xy54Dojebwga0mRevo3c7Egh+U9A/OXFrWD6f+Oalf4=;
        b=atUry5y7LzpRNOpY8gKnwmkDV849kGaozWn3IOPwNre8C7zBADhgnnLPo3+fjhBM66
         NPZ7AupBDPCd4tSmH1P7ftzEnzunjD/oUBeze9OuMJB0s+C6NYmlm7N6L5hhq3Pfep0V
         WF4RuqTdbZeS1pM8HYLKSjvffSUMgbNGehQkawKUuhXjeunFvMOwJ4Mkqr75xMuYGzrk
         wiajcPwZ1uHIjAxl/FCVH230FkVkhU9psYLnCZ7xdgxOYbMTn58harCcCPON9DqBO2+d
         iKQGeouNsk/nIdKJ2seodzfluzYKFZ33QJJjzFDPwlGEh7ptrFSYstZHppRfCCR1w0Ny
         IkDw==
X-Gm-Message-State: AOAM530vgvehsBwHc+rH+djHc7rIhmpjH/seyV7SECDdOh+g3QIqohqw
        6tT6w7RWvGUenj/22SlUw7TM2Kr0ZQAJ+QmsNHI=
X-Google-Smtp-Source: ABdhPJzSaHrVQxRKlhd1rei2D8MXohH5k3bOhwk2Be2OwfbNLG1Uy1AcB97NQuq0cdPAMr7yZ13ZfKeeuD2KftvpuUU=
X-Received: by 2002:a63:1514:: with SMTP id v20mr2574031pgl.203.1606300840354;
 Wed, 25 Nov 2020 02:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20201125083618.10989-1-hdegoede@redhat.com>
In-Reply-To: <20201125083618.10989-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 12:41:29 +0200
Message-ID: <CAHp75Vfu+PC-QzzE0_guwLHTdBXes-7RxbaS85df_p4Z=qR2=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: accel: bmc150: Improve ACPI enumeration support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> This series improves support for ACPI enumeration of bmc150 accels
> described by an ACPI node with an ACPI hw-id of BOSC0200:
>
> 1. Add support for nodes which describe 2 acceleromers in a single node,

accelerometers

> fixing: https://bugzilla.kernel.org/show_bug.cgi?id=198671
>
> 2. Add support for reading the mount-matrix from the ACPI node.
>
> This is done in patches 2 - 3, patch 1 is a trivial cleanup which I noticed
> could be done while working on this.
>
> Patch 2 is based on an earlier patch for this from Jeremy Cline:
> https://lore.kernel.org/r/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com
>
> That patch was put on hold because normally ACPI nodes which describe
> multiple i2c-clients in a single node are handled by:
> drivers/platform/x86/i2c-multi-instantiate.c
>
> Which I tried to do at first, but as explained in the commit msg
> of the updated patch, that is not possible in this special case
> (because it would cause userspace breakage due to the modalias changing).

This is marked as patch 1?!
Usually --cover-letter produces a correct template...

-- 
With Best Regards,
Andy Shevchenko
