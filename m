Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434D73E59B8
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbhHJMQf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 08:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbhHJMQf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 08:16:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC9AC0613D3;
        Tue, 10 Aug 2021 05:16:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so20692922plr.12;
        Tue, 10 Aug 2021 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2SAom+K3xjq+elR9A4m6RnGt39/xLthbnTdTanpHn4=;
        b=MO4y78cwlP3HlTDYWsUl7zPYe6e3Y6MG4yHvEC2GfpNcCvN98gbxYivkNSCmv95blc
         NRfhMMej7c79A9+1Tsnj7Gs1Uweo1zemDFsFUVob5lAX84yE381jnRBRySTw2WCB94Gw
         i3vFUs1yUEl0Bcl8oa5b+8Zrod09eJnIo41FFtF3GUi36GK22ryvDeEXVKCplBQFpA+X
         SRWuhJTH0b6LIrR7GchlM/3tKQyxkPM/rDpZ1BcVHa0Tgq8XPwGm2sZtOd1dn6nhB4Fr
         Md2IF+FOQ+s3aqO/ZLb0j+h2OGpKWS133JGMvLorhP8zD6kQ+PejR7dL/ammFW/f9ZOX
         iurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2SAom+K3xjq+elR9A4m6RnGt39/xLthbnTdTanpHn4=;
        b=gea2woMrEdvJr4Im///ZcxiLfnHjUxly/WZ/RlFTQXbDgJnmro6mpmW70tE+IQpTdu
         ioeICDbFi6l8aT5f/+YcaYv0JHFdfwNZBN2tave3VaZesj4BZrszf80XE+/kEgztdS55
         nR0iIeTgnZM5OUZqY1dYt5XT+5AZlb+4NR5wcyqm255FL5KxJuDaW9b+QlkDhZ7hcUrH
         vKlcVrH9HlsGwWqR/GozAFFF3PlIDL/duV1+GgVcY2pM1g6NpcpEwAvoMSkgGY8nN7eq
         Mvn+tNMlHcIt1+s74uaLvRylHugliP55kZN7ujs8jtv74w5swNaiR+qklMPbxqoetji9
         FQYw==
X-Gm-Message-State: AOAM531FtRAIvVYgmbR8vzmHvRwaVs65rW8wfJ8nDQxamRN0oidvh2w3
        NtojJ6atlPoY4RmUsKLRAGgbcteN/a0eRaRqAe8=
X-Google-Smtp-Source: ABdhPJziQkMUi2pJ8MxSHmab5wsEcIv1K6XRsXT+/7zhdllwdZnOe5vGfcUG4Cf+MUVglMCiAuuIvloG6RkqDbJDi9M=
X-Received: by 2002:aa7:868c:0:b029:3bc:e2ca:4e2f with SMTP id
 d12-20020aa7868c0000b02903bce2ca4e2fmr29256171pfo.73.1628597772939; Tue, 10
 Aug 2021 05:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-4-liambeguin@gmail.com> <20210808173630.5c384a4b@jic23-huawei>
 <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
In-Reply-To: <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 15:15:36 +0300
Message-ID: <CAHp75Vc3o-RrHD_wt_CfJY3P8hoRhJkdiRRySFS_O_7VdtJTQA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        Michael.Hennerich@analog.com, charles-antoine.couret@essensium.com,
        Nuno.Sa@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 9, 2021 at 1:50 AM Liam Beguin <liambeguin@gmail.com> wrote:
> On Sun Aug 8, 2021 at 12:36 PM EDT, Jonathan Cameron wrote:
> > On Sat, 7 Aug 2021 21:56:57 -0400
>         ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
>         if (ret == -EINVAL && mode & AD7949_CFG_VAL_REF_EXTERNAL) {
>                 continue;

>         } else if (ret < 0) {

Side note, redundant 'else'

>                 dev_err(dev, "invalid voltage reference in %pfw\n", child);
>                 fwnode_handle_put(child);
>                 return ret;
>         }


-- 
With Best Regards,
Andy Shevchenko
