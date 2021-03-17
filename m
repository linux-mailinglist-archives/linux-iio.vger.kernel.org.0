Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3533EB2D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 09:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhCQIQn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 04:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhCQIQN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 04:16:13 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB1C06174A;
        Wed, 17 Mar 2021 01:16:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n132so40055736iod.0;
        Wed, 17 Mar 2021 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiXh5OFsnN34IitZz1rkVk6moqaTbWiaMgRZ+6LYhf8=;
        b=gAPnk0yECXq3HyzTLDsOs+NhCxSyJmPDWkC64+ApYo1YnCgqDmc83K+vgu7pHY3qza
         zwv9V3CO62rt/vydmtLxHcnMvllRWgSPWNNb8W/vopxVHx1giz7MroScEX+NVf52UA3w
         DwA98pQuO7pUYMJkj5uc5VXCau/Vm8tE1IgznDB+hqEjUEVbLoJrPjt84z1l328YXyjY
         TWBu96tcOE+w4Gjh7ft6UaYocNI5kFp0ZvKkedAoudwqbZ9V154YFd8WJQTQAECL3iHj
         DY7niU9Cqwm1J4U7tlqTXjfh4xGov3tgOcj2rVKXiQNIL2zf9FzgYMwcfpwPbIXrKNle
         1X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiXh5OFsnN34IitZz1rkVk6moqaTbWiaMgRZ+6LYhf8=;
        b=R2B4FSClhEaSCip9xgPd23mqFGZoag64eMgXbY7PANw0YTvoR6VI4jp0OsdmHZtPTC
         VSCYrEBx9P2vrZh5AwFPMcjYh/6rsb7L+tASWBLxZuLsI3CYs6hHo6uR+hxEE8P7/9Qg
         7cBtrKTLi/6NpYkdnOBw0eBlR5uZVFBK3A9sQrEqfUCiD+z29QwurAzsieSc8e7hiESw
         rO5ifMH6N/5JP2J5afTRJbiqo9hZkmnQ3/REgDuvZQaR5vsFsxWW+FgxWMfk6cYQSGYg
         5YJb7IFEJegk+5Jf8HYMkQSzC0GEYYaWVSFIGRNG2ysBoGEcCNC33wJzlWtRDfJ4YhUH
         vlcA==
X-Gm-Message-State: AOAM531271Z83FpVlNc7Ndc69lj7ZRCyXVUsZxjIAmLOkD+0nsaCaTJa
        cUpr2qNAslX3wije1/0UFvbXUYxN7hX++RXITB4=
X-Google-Smtp-Source: ABdhPJxdslQWxWHgCfvHpEkB6dz2eb3BbcFgd8hsk2MYpirqFTEXFB8/VV6tyn8gX5McHuvBjPaLLyZSzVtBP8xwcPw=
X-Received: by 2002:a05:6602:2e82:: with SMTP id m2mr5967050iow.70.1615968973050;
 Wed, 17 Mar 2021 01:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210316155001.699efbb4@canb.auug.org.au> <d3c9bca8-3709-3613-c4cd-6da2aa96c2b9@infradead.org>
In-Reply-To: <d3c9bca8-3709-3613-c4cd-6da2aa96c2b9@infradead.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 17 Mar 2021 10:16:01 +0200
Message-ID: <CA+U=DspHhL=Of2axKW6FiF3oG8S7FEP4QBLEZHc5VQ4LzmvqNQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 16 (AD9467 & ADI_AXI_ADC)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 16, 2021 at 11:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/15/21 9:50 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > News: there will be no linux-next release on Friday this week.
> >
> > Warning: Some of the branches in linux-next are still based on v5.12-rc1,
> > so please be careful if you are trying to bisect a bug.
> >
> > News: if your -next included tree is based on Linus' tree tag
> > v5.12-rc1{,-dontuse} (or somewhere between v5.11 and that tag), please
> > consider rebasing it onto v5.12-rc2. Also, please check any branches
> > merged into your branch.
> >
> > Changes since 20210315:
>
>
> on i386 or x86_64:
>
> WARNING: unmet direct dependencies detected for ADI_AXI_ADC
>   Depends on [n]: IIO [=y] && HAS_IOMEM [=y] && OF [=n]
>   Selected by [y]:
>   - AD9467 [=y] && IIO [=y] && SPI [=y]
>
>
> AD9467 should not select ADI_AXI_ADC when OF is not enabled,
> so possibly AD9467 should depend on OF.

Hmm, this becomes a bit complicated.
We got here because we needed to add a depends on HAS_IOMEM for the
ADI_AXI_ADC (due to the s390 arch).
Maybe a better fix would be for AD9467 to depend on ADI_AXI_ADC.
The AD9467 driver can't function without the ADI_AXI_ADC driver.

It is a little early to move this to a "high-speed ADC" subgroup.

>
>
> Full randconfig file is attached.
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
