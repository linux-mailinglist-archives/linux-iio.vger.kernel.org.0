Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564AC19268F
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 12:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCYLC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 07:02:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46755 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgCYLC1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 07:02:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id s23so660409plq.13
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2020 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0h+k4qTA2XkAPaogbxDpTb5QjqsMBez9TDJObsEYEsc=;
        b=cQ4w3UoAs9bOSOvtq07xqwOtpSHcHnDqOQqGkOsc4601UGVTXPof55j+RYPOnu4a/G
         N8SEfuCpabxh6gJb1RGWIpgEat+tgFR02H5OB2Zf9baBpADx6jZZQAVK9eZolKbT2VjK
         zTqQMAzvqvwkyybd4bRbuvP4xjYwAbwdwa0m7cjrytFIilnWtGM+EeCUgwIs7nIv/pnY
         mCnXs3ve9N4l4F0ke7Nut7I4J3gfY7GliHWTNhcWf4MlGm31KJI3kXkLmsdef54b5pRd
         6wq9yHbq0BoTJXL6GNaJlYfYqCmOIG2cRfqKqikErgjE7IKfMEtclFxYw1rvtS9dQEXv
         7pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0h+k4qTA2XkAPaogbxDpTb5QjqsMBez9TDJObsEYEsc=;
        b=Oorf4w6aH5dJHqX2utL7Olon0knYcOzLl7BCBKI6ZSK5LIXyGE7ORE2uoIcLo3vV7C
         2d+8QhIBog65gf2Iq/0Ti3rEU/8FBM8DN9FoPZvJ5pS6nqe+w19lhL44ba5jwhe5siU8
         Sz26PJrRkixNBNW8+rKtU7eLlM7DMndczPDSHWftc9Qx+gI7nFCHOpHsmt7azciYJeJm
         Ms6EvFifwxHxvcv2hGeVn/ABGmp3FeV+/wTV8HJe+x2YkCr7B8CNh8s8jIoD3W9Qul2T
         OiPFeoaqF2hTDuWYRNFjdDz5ys2FW0ReAyiNZkXRDhNg5k3uU2tPCjeQclL/LTBw9r6w
         IyLw==
X-Gm-Message-State: ANhLgQ2EqHD5WzCbRNaM/LrKlKs4QwTD2p17DGBWbBWC5osTfzfMOTi0
        a4zenruDEmqC7AARkatYlGbq7IGpwQwcmvRUyFw=
X-Google-Smtp-Source: ADFU+vsSFPe4HGVXxgjuSQ9xJsPktOHtXLRKh2jN6n92dftV9ZxVITrJLj6YVZtogGQ9z/1Y5YfLJGdmvHbLpKjdPrE=
X-Received: by 2002:a17:90a:9408:: with SMTP id r8mr3145725pjo.1.1585134146204;
 Wed, 25 Mar 2020 04:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
 <20200324215226.1711659-2-jimmyassarsson@gmail.com> <9f984a4d-b8df-2459-c330-409277b14c3e@gmail.com>
In-Reply-To: <9f984a4d-b8df-2459-c330-409277b14c3e@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Mar 2020 13:02:14 +0200
Message-ID: <CAHp75VcoVpPvhGQR6D5riLN7DUr+n9FdC-qDwvTHZNF5fnYp7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Add sensor hub device LIS3MDL
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 24, 2020 at 11:59 PM Jimmy Assarsson
<jimmyassarsson@gmail.com> wrote:
> On 2020-03-24 22:52, Jimmy Assarsson wrote:

...

> > +             .wai = {
> > +                     .addr = 0x0f,
>
> In st_magn_core.c this is ST_SENSORS_DEFAULT_WAI_ADDRESS
> (from linux/iio/common/st_sensors.h). Is this OK, our should I change it?

I would rather use macro, Easier to grep what is being used with ST sensors.

>
> > +                     .val = 0x3d,
> > +             },


-- 
With Best Regards,
Andy Shevchenko
