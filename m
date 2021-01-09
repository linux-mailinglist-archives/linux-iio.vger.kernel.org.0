Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB532F039B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 21:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAIUx7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 15:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbhAIUx6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2021 15:53:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A76C061786;
        Sat,  9 Jan 2021 12:53:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n3so6865746pjm.1;
        Sat, 09 Jan 2021 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHHS7ncbb1G/qj74N3nd5FbAAQidli17E6OlWL4NyBg=;
        b=L2uPzrfP8MK1tWlhSng1U3a+xzZhzguZ+CTpZuDSfy5XSVQ+HcMpizwwvf76spvpcR
         7tT1L46bDqAmdJ3fZLlAdHI2ghVYwBe+w0cwPLsZL5T6p7AuGsF3vz3N4kp/j/O1CZHD
         MF90aga2TNLD0MmrXymw16z9D5xkjxbLCB5eCGeMkcN82LwlIwzlbs96jqLXBsiUuY4P
         1FW295ZjrOosgTd4aNP+CXFcp0Occi3j+losAkUuXZUSucw3p/HPG7nDVn5ztMwnZY68
         sGUUYvCkS6c5eC6ZObolKZzZe6Ckk/7eQgLp4nP10j6ZsWcjP3Dy47N41TW2+fh2NTyi
         cvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHHS7ncbb1G/qj74N3nd5FbAAQidli17E6OlWL4NyBg=;
        b=LMyb7SMLI5wOxOENr674f+FkHobd+Zxhbw0AxHKVexlBQx9NDmlnsH5sYTWUgdoYRt
         Ot+67Dqb1qmEnqhYbTV3oc+gM2PQZ85dWMCB1pqVTNmtHDWtEK8t7Rn0NsN6MKPLKE4h
         KXmlJ9XoDOOyeSOOfyYB+pOo+KZjL3lkCuyL+jpdgI1ob1f4bYutXfxNH00WgyPz6X4y
         sjHdHO/7dUzSImS+jE5kze+s3xwsvCuya3YJ1w+uR3R8+BHsRCtC1kh4Yai2FlMltGqT
         vWDPvnBJ/tXaspVQc8kA/IwiQ/wTjWvU5WpuiwgMQj/bh06DVmRAQbfQN5q9lIeYJOD/
         N8ZA==
X-Gm-Message-State: AOAM533CwFVl8oSZC44Vtu3NRDM7EkE4VX4syUvhAw99dLQXsimZd4oP
        CHAiwZAkBA76JoSj2FZ8YfLqQlE2YMcdCCzpa04=
X-Google-Smtp-Source: ABdhPJxUwngyPRAd3gEzVGalqt4EGZo3FphktmGhwz6bY+Rj07jtf0pMhIQNKl/M7u4VYAU1G0ZuG52xVizBtThG98w=
X-Received: by 2002:a17:90a:1050:: with SMTP id y16mr10323488pjd.181.1610225598260;
 Sat, 09 Jan 2021 12:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20210107112049.10815-1-alexandru.ardelean@analog.com> <20210109192340.0e8e422b@archlinux>
In-Reply-To: <20210109192340.0e8e422b@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 Jan 2021 22:53:02 +0200
Message-ID: <CAHp75Vf8X5ho4ztfGhL-Bkp4m=GL+QMjxhYtuivvSjPLHAfrUA@mail.gmail.com>
Subject: Re: [PATCH v8] iio: Handle enumerated properties with gaps
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 9, 2021 at 9:23 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 7 Jan 2021 13:20:49 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Some enums might have gaps or reserved values in the middle of their value
> > range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> > meaning, but 2 is a reserved value and can not be used.
> >
> > Add support for such enums to the IIO enum helper functions. A reserved
> > values is marked by setting its entry in the items array to NULL rather
> > than the normal descriptive string value.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Applied to the togreg branch of iio.git and pushed out as testing for all
> the normal autobuilder related reasons.
>
> Note I can still rebase so if anyone wants to add tags or comment it's
> not yet too late!

Free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
