Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DB043DEF6
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhJ1KhK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhJ1KhJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:37:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A49C061570;
        Thu, 28 Oct 2021 03:34:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r4so22303843edi.5;
        Thu, 28 Oct 2021 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOFAI7az15FPXlVlQuuD34/N4ZaQCZlv+n47YXbGXF8=;
        b=Y3W+T8bfRNOIU6NgRYnA9FmUTVqLs9/YUyR5jN0ZgLn5M/31OMRwYtUeMAzxVtAlYW
         VB2kKc2YlYfaMFrC/iIYIry/f1xXQvZEQhJKv1ANGvArVaIVQgdQJwDkLkJow3MvlzUS
         AAIvy059CVu8bajxZOWPAhalOTwC3LD21zrXXpiK9lhEy4s3KCFga9mKhBpQ02iv5NNu
         BF5IiczBm0QH6w/dkxUbSZr0X9ZmMlLE+yjbmuq/KISSyUaArzlOrqdewF5+1J2Z7zjz
         9E5xB5ZAdmToSjPRsoh7EBzA++Xqxv5MWyrc7Y+ZJ+lroTMbFtZt8Fs0PzHgr5mMvxar
         qRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOFAI7az15FPXlVlQuuD34/N4ZaQCZlv+n47YXbGXF8=;
        b=kDh8nFGIK0uHf03aGVwXMBChF1pA9uT5gCGBG5fsUwO7pOkD32AWqvHCvR7ZZG9ySz
         B8kIWSHwmBLXVfjH6eUJmJ04oWZSnyvqBnN1NTtHoVwgqyAWfOeOkijrvmzanVAdwPp+
         pnq2MxpiOvfs/RdWHzKDklcIGPKPqCM/hq4azHKy5nmdmMnmA63N+AM/M1jpdGzpXTng
         /A6qkBqcQB0R45FJXDP4kqQeHd4nGmH0MUO1MgvxktsNdknLr7+tueOqLpvyCfOcaQd0
         sKXCntGVuacL2j+ZOkZDaJWNKpVLM9Baa2OlzRumfmDxkiqRmHbGibvlNN9D494WJh1B
         ibIQ==
X-Gm-Message-State: AOAM533s4OwLOPEv8E50ii05xSAwffrJ3/l3UfdBK75BAJKwOViRiaSG
        sUxwnKbsc0feXLGyqjrBXo++hYBCIqmvvXhWsUQ=
X-Google-Smtp-Source: ABdhPJwml79nxOr6QPEEuE7IruscFbDcT8wkU9Lsak4PoikZCrcUIVW90djourXhLU6h/dgU6xmqoScTSODD+kispXo=
X-Received: by 2002:aa7:da05:: with SMTP id r5mr4972956eds.238.1635417281047;
 Thu, 28 Oct 2021 03:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-4-andrea.merello@gmail.com>
In-Reply-To: <20211028101840.24632-4-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Oct 2021 13:33:48 +0300
Message-ID: <CAHp75Ve2kWB0x0eqP6sRDntinftBn0BOu+5z2BhARaFAMkEeCQ@mail.gmail.com>
Subject: Re: [v2 03/10] iio: document euler angles modifiers
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 28, 2021 at 1:18 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> This patch introduces ABI documentation for new modifiers used for
> reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).

As per previous patch.

-- 
With Best Regards,
Andy Shevchenko
