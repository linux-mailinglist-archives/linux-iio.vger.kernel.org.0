Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9201F0A21
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 07:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgFGFXM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 01:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgFGFXL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 01:23:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740FC08C5C2;
        Sat,  6 Jun 2020 22:23:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k8so2670487iol.13;
        Sat, 06 Jun 2020 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1rAhK2vpYhhSS7qNist3vUD6d7xH+k7+PemlonaN7I=;
        b=ANJJ44nm5qnTCUd/ugVEe9HWmiFSGppsCnYzSAhaas1xqc2lDJfFLDthbaTkeV1XsQ
         3v9kihCXiw1nq0dJIw67wno4lu1BMl6JQQj4WyjIUpPnVANy7bQVTiOpBe2nhGQAMcam
         0kVXWrTY5YbW7qEtGPCWigtuh/p6qalxlhXPYKfA0lSx+RUehWe8CmUYAitwCzm6w+Zl
         tTfibQn1f6cwmXRpFEDX/mS+eCVoypVPwITlktqtq1lZ8fGnP8rMwExPvNc8I9LZIkml
         I778/pJujQxmmKPXO8pyVFKHEEE7ST+n7GCEyyBHuLDZJAh5tT2vQywNHDIgM+jUuJVS
         ECoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1rAhK2vpYhhSS7qNist3vUD6d7xH+k7+PemlonaN7I=;
        b=p5vTmNW6LLYCmlKp+Uy0Y+rObLuFJ8wUfXzdpy1Cf5j2NwsWMe+c3hSK/9SGney6+v
         4G2cs5T5d1vYQN0p9PlPsiZeUtqPUklCbktDvJdLinbCeSuDYPgQNWorxHuOcmFVvy4z
         upVqxN2GVHQJxkPNOPY2DU7wyQVdbXgS4obE9tUGCXTtvNojj9ndds4tEhuYPLnzh1Xx
         fiFZ4qh+sFzKqJli1fFEwXl0Vb3zbKCZ6tNNkY+oTVSbVg28zmrUko9Tn1sU/aHqWXy5
         0z8HAeFnAMD+Gi3MnlAMpcWtecobtsp2IrdkfQ0NqkFpwmCECh/zPNQZNuPGobA/ICif
         pUMw==
X-Gm-Message-State: AOAM533QkuehgGVc+24T7CrSa4ZXXltBgCCu352/ZGVrHkw66xxenMBc
        NvlxP7bTkqUBE9gfVm6icjKxAya/GX9LS/SP5OSrrmP9
X-Google-Smtp-Source: ABdhPJy8iaoNU8DwquVEb1WhYWjNVUGdRlOmkCNoDTzXn4X+wVgf7IIb8ZeEFt4i9oGPQtZuoP3VfbFY10ACHOvISDo=
X-Received: by 2002:a05:6602:34f:: with SMTP id w15mr15737135iou.2.1591507389595;
 Sat, 06 Jun 2020 22:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200316125006.GA415@syed.domain.name> <20200318021802.GB45571@icarus>
In-Reply-To: <20200318021802.GB45571@icarus>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 7 Jun 2020 10:52:57 +0530
Message-ID: <CACG_h5qwXxA0EthdCjz3jNbW0Lgtdy7ycCvt8xCHLh8dog-Xqw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] counter: 104-quad-8: Add lock guards -
 differential encoder
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 7:48 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 06:20:06PM +0530, Syed Nayyar Waris wrote:
> > Add lock protection from race conditions to 104-quad-8 counter driver
> > for differential encoder status code changes. Mutex lock calls used for
> > protection.
> >
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > ---
> > Changes in v5:
> >  - Change spin lock calls to mutex lock calls.
> >  - Modify the title description.
>
> Looks like the Fixes tags were dropped in these last two patches. I
> suppose they aren't really necessary though since these features haven't
> yet made it out of the IIO tree, so no need to backport these fixes.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Adding the 'Fixes' tag:

Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential
Encoder Cable Status")

Regards
Syed Nayyar Waris
