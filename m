Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C53F497E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhHWLQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhHWLQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 07:16:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8212CC061575
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:15:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w68so15036969pfd.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ok5DgSqtH9Ya7+QbSxdIh5S0INOQ+co3g3LaTLJTOk8=;
        b=i3rck9BLjWzPY9RehRI0xXLKwSvcCU1Bzt8Ek4GyIeRa5ElPeT79f/jR2/zZYjXRKU
         0LgLig2V3ZjsCpur9ARZOGRAHjn60ZYrkQX6RJMVr1vqE7BqN2e+cfNs7PUTD0MxgJu9
         E8Zz2qBmwUgEVIub8V4r8h2NRwfkR1v9hWEABdABS4AwK0XB+9RgUmm5udwcOQlKkprB
         OrvEILDtCJGvcpMzUII+CkqhUEEo2E5GmTqHQq2g6wsr2VwGeVOeMed0d0EUZmkFOSX1
         6Xtl/0hl8DuzNi7ywJwEXci1kUTTpebjyZbFjzW5Oy6yKRWfzebFPf/R+8hfPoKbAspo
         lI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ok5DgSqtH9Ya7+QbSxdIh5S0INOQ+co3g3LaTLJTOk8=;
        b=XA1okzU9nEKuoRkDcRZpp8g78r5SFQ3cz1yyTaINL1XCjXiv+AwUpoBHMRwI9jJeSr
         Sdm70rrVWwQBjBp/BMyr4FMewivsvqAc6r7R/4R6msml/XS3YJeIemQiJkYmNueF8vih
         UKJ8Ub00tQqSEMLtro6rwpcpz7kifT40MOElEdZa5+Cv+uUUnJx0SmQL13JalwhTGB7X
         k/wCsAjnxxuBRDLJr6+MBBa4rO76f13Uv57JrVPHLYuNfTMAgYyg086Pv7WFKrhqe34s
         xh9oOa4r8z722tnYT0mL/ePwSZZPurV6WlGey5t8zk/X3LO3DyUPJgazxWkGNEU9udDy
         3/hg==
X-Gm-Message-State: AOAM532Lb+j7HFccxq3hn8SVjWkHkFGnq0bqpsnjxvS/n/7yqqSOoXpi
        1pXZbnA9Xa3mIsZkIagOeWWD4mHgNuuny0/eKjk=
X-Google-Smtp-Source: ABdhPJyuph7/pcmlEyYggOWcVG36OsY8Ymo8O0UA6U4qrLzNmwAORVRV8trS48rEyWZRWgJ+wKha2cdgRFxth3rYwrc=
X-Received: by 2002:a05:6a00:d41:b0:3e1:3316:2ef with SMTP id
 n1-20020a056a000d4100b003e1331602efmr33800410pfv.40.1629717338957; Mon, 23
 Aug 2021 04:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210820065535.6994-1-nuno.sa@analog.com>
In-Reply-To: <20210820065535.6994-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Aug 2021 14:14:59 +0300
Message-ID: <CAHp75VdDkXT=6d8HKAgeSH-h8O0ERvsNidwrbnyvGZHD0GjgAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 9:53 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Check if an optional reset gpio is present and if so, make sure to reset
> the device.

...

> +               usleep_range(1000, 1005);

The delta should be at least 20%, otherwise I'm not sure why such a
strict range?

--=20
With Best Regards,
Andy Shevchenko
