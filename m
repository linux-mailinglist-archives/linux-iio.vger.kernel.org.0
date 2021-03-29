Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C914634D395
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhC2PSk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhC2PSL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 11:18:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C205C061574;
        Mon, 29 Mar 2021 08:18:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v10so9586355pgs.12;
        Mon, 29 Mar 2021 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqPXhkpXTdCFzLWV4GPKySXSeb7rasymOcJ7ajv7Bu0=;
        b=TysHQQNoAQNs9f7+MF2hqKuQ7BKVI/aJf9o7jo1iAsVhc8vVXF4rSDfNOcVmkci4me
         CJhjzEDlVpSaP0BmZln5DqSqli3XZv+wTnpjam0GdEZ/zP0y8LdiM2oAWqzKQdTQBWk+
         y9YTvPFvO6DkmqwO7Cgwkn3RdS6I1CYxwrISfxuUC8nh4ER3G4oRM0FwoeMzgfhtJA9P
         f5e29zekR1ISPJYf3X2xGwaEMnNTycS2lp5LVCqoIarHILDLpzCgnna3BicDFCIwMPFq
         2onKLzw5WePYQI668e/2nEAyy5yDkZlGoVZtvaIycBOftY7VjIB/DrcaPm3vxkNOJWgp
         /j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqPXhkpXTdCFzLWV4GPKySXSeb7rasymOcJ7ajv7Bu0=;
        b=T5Hn+hVZAZ6BE2OUX++UojpLFWbgfRxcgSCW1plhlCjtjCbolTGjtDQA5ilwqUD2ls
         +crMRXr6GTAys2jLZYGAPnVB25V6JWqmPR0KT+97QzDuinANZjJr70B3NkWhqshDgUY4
         vem3FvBoVIiy/lA7LV22Hh9S2BBRsBHRtA/XaAqi4Tu3+Cfa4XZpHzVWUGCMhRVsjt+r
         35EgUKELb2BO2PbJZb/sckvLb007ybCNQIaZ8HhD04vJ9H0VhFo7oQZs/9mMnmP9qzDY
         u59/SxHu3+7BrWAM5ntVFGq7xeTBUrZfsvtOGx59tPP6tG7Hii2MSQnjDup45mYxoVvD
         oskA==
X-Gm-Message-State: AOAM533xnqhn/lJFJqNRfNq94BzsrvcylTNrqAQEbidBLdePu7ELDVn5
        w2UlmJaTRAkfEIqX501eRLs8JhrJ2P5xnrktVt4=
X-Google-Smtp-Source: ABdhPJxVFKmRSkUGhAZsamSXw9AKSj3J0tIoKsWGBzlUKNDUtg6d2bpMt3QbhJij5pV1KEsM5u5ylje4cS+6BSCtK+U=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr25235556pfb.7.1617031090625; Mon, 29
 Mar 2021 08:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn> <YGHux/3aL1pkHlNL@smile.fi.intel.com>
In-Reply-To: <YGHux/3aL1pkHlNL@smile.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 18:17:54 +0300
Message-ID: <CAHp75VePD-ak7mytvo5zETHQ+1UbsWvuWk3FE3pThQE26HA2-w@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Add support for ST magnetometer IIS2MDC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grygorii.tertychnyi@leica-geosystems.com,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 29, 2021 at 6:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 17, 2021 at 06:39:00AM +0000, LI Qingwu wrote:
> > Changes in V3:
>
> Jonathan, is this applied? I missed it...

I found the reply, sorry for a noise.

-- 
With Best Regards,
Andy Shevchenko
