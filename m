Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF43716AF
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhECOgW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhECOgV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 10:36:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985ACC06174A;
        Mon,  3 May 2021 07:35:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t2-20020a17090a0242b0290155433387beso9876443pje.1;
        Mon, 03 May 2021 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdmklq/ZSIFVVj1esS5ZvjW9WOYyjru1icxhM6YhJUQ=;
        b=D/+37SgSnff2GFO0SI78/vxfjcKS9VrzFdeP+eKBRDTCfIsHN8NiZugzLm59njStF3
         o7gKXa+61nV4BbGpx5Meajnh3FvHIUVWV+QSo0x/GdqhM1Mof2r/Nwpsgu0sDH9D/7OV
         fO20/f5mJm3MB8rrvFtl949vduU/vhwyNE3codK0jXbIGUhN689bzfN/WWhmM9DhJbxm
         GkuJwPAhsceok2B+XrAnQhNTZ0Fc6sYViZnzLEox4Hy/+fFShK1Hrj1AZhg6/2KvRgDD
         ITO0mPlSbeWOu9av2ShwnDsIA/FxCkUHlweBueUwOKb8h1pFgtPE0YjvNckooMjpYhIT
         kGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdmklq/ZSIFVVj1esS5ZvjW9WOYyjru1icxhM6YhJUQ=;
        b=fdmumY40oyQ48gl9zGGhkC1C9Rbgm1dpBajLfPam/bgps7V4Om6Nu+rJu6YuANeo7Q
         HZjpotrESNd1rZ9FIsciJlutEDMGLFVIJgQDjTA8aURd8ZznD1zooELEYYIIDdRdAUln
         c6Wb2B1nIq/c34O+M+KfhLGiNAFgxgWmrK/Caa7pGIWiDbFey59ysOpOvQC6IKmw382r
         cmW69lXMV9S5x65T5BNfWr6qtxabfzkYFZJCLqaFFXwT2rkT8LA6uZjksXmArY9oosh+
         fWcyDGyIkQ43Dm3B5QM8DS91a6pRJLtCoGuGa66UAafs8uPnIPwvSfrM4uf0Twh1JfOj
         DuIA==
X-Gm-Message-State: AOAM5336f1DIACelHxuULNdGjooUmceaA+05HkDfib3JncILZLAv85p9
        OfRcevY4vwFvfObH5G4tXvMVqVrwuOl8apaQuhs=
X-Google-Smtp-Source: ABdhPJwP1T5Qy3VBGmTDytROOjJKtQ0O9u1NmnNDpPcX6HYWuZcdBJAov6MNKZCaAf5F6qIOwDtWm5VxZstU0bj2H+I=
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr12496726pjj.19.1620052528147;
 Mon, 03 May 2021 07:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210428150815.136150-1-paul@crapouillou.net> <CY4PR03MB3112198E9789BF3D95959E6F99409@CY4PR03MB3112.namprd03.prod.outlook.com>
 <CY4PR03MB311245DA10E715A44DDC10C099409@CY4PR03MB3112.namprd03.prod.outlook.com>
 <20210503120615.64b396bd@jic23-huawei> <CACRpkdaA5dgG3f8fEqkSny_uUYC_1nFu3=GAPtwS=aoy7qYsJg@mail.gmail.com>
In-Reply-To: <CACRpkdaA5dgG3f8fEqkSny_uUYC_1nFu3=GAPtwS=aoy7qYsJg@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 3 May 2021 17:35:17 +0300
Message-ID: <CA+U=DsqUmzcpDrzBi7smucLt6X+qRMXxV18D5+0KNXqGzeCGXw@mail.gmail.com>
Subject: Re: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 3, 2021 at 5:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, May 3, 2021 at 1:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> > So, I did a bit of detective work on this one.  Seems this change in error
> > code was actually introduced as a side effect of Alex's recent rework of
> > the IOCTLs.  Prior to that we returned -ENODEV for this case and now
> > we do indeed return EINVAL.
> >
> > So we may need to figure out how to fix that, or decide that such is life
> > and modify this code to give the right error message as done in this patch...
> >
> > Linus / Alex, thoughts?  It's always been a bit messy because we also
> > return -ENODEV in the path where the ioctl hits a driver that is going away
> > so it hasn't uniquely identified a lack of support for a long time, even
> > if that is by far the most likely reason for this return code.
>
> Normally this would be ABI if any existing userspace can break because
> of the wrong error code being returned. Linus (the other one) has
> clearly stated that the ABI is a contract that cannot be broken.
>
> So I would just try to fix the errorpath to go back to returning -ENODEV.

Same from my side.
I was just looking through the code now.

Will send a patch.
Sorry for the breakage.

>
> Yours,
> Linus Walleij
