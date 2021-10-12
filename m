Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6339842AAB7
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 19:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhJLRar (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhJLRar (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 13:30:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B83C061570;
        Tue, 12 Oct 2021 10:28:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y12so2420582eda.4;
        Tue, 12 Oct 2021 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYV5uswBdPhLkzQCchLXy1vzDSrs7wbq+uP4fTIgJew=;
        b=EqiiBxf9HamAePfjyBIkSQxkgGGjmVmOOiUHx7Af964g/OmYXmEtvMqcdu7TmFHfnm
         SNMA2cwgQebfN/8LOqxFf4EwKL5q8vWO0mO+RI0iqHOpKUxe6D3TiNTzNKY7/bq+UIzM
         o6ykO2t18179Gfmk5eXRhicIeBSeYXJvyfZRK1dHbLbZCUoC2hFZvA5uhE4LvD3uVB8g
         NTeBDOOCprN2VsmEIhK1mjcDtyVTZ3TGeCqoU9jXMhshslPECIaIDL8lSaypDsgQPW0T
         /huc9Te52IDjRzd4EENstG+YzLkeINGlNUyl0nTp3FzqbuQzWQwoAnho+H8CdC7xka7R
         eIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYV5uswBdPhLkzQCchLXy1vzDSrs7wbq+uP4fTIgJew=;
        b=aqtObiwoDaYE8utncOUkWSJSo+hEoS2Y0tF1Dk94eqT06DyoHjjAT6Y01mKkOBIy31
         vKO6lH7eoyp5cBo2I4GIh2xQxzSaxe/VMFXYWTQ9q+7ITbn/LldgGOF1PuTVHvUyqvP1
         ex5AH4X2+iheVp/eU9yTSmOuKOvKJL7CTxVIEFU8+nwJxQ9ZiMLEmJS55Vde3CqI/Bt6
         F1RsCDAq1KR3WVgZhvLtEVXXQ9ctELvJSb8ORyzEUMrOZ0Ekx/za75sxAtIP53meysfn
         YjumRNMjMMwgr64F7c/wLUFa9hW3s/O4UnQEUgODE6Uvq6tjWKJdER7EIDH+WyEygOqt
         VoLg==
X-Gm-Message-State: AOAM531CIWXgQRQ4rvGTq5biLdq6fnQ30P6oZUHsaAFAfQz1bR5Otv77
        PzPNPQzSaJamw1O7oQ3kcla/4KKSmHFFYtaitGO/WhzO7t6nQ0Mj
X-Google-Smtp-Source: ABdhPJylsYNadtxJaenpcnUtTiNrM4FgodsUYbNb7BPGrQnMd7AAoOjjIUX49eIg+nwVBLusEB7wq5LbutUl63nydto=
X-Received: by 2002:a17:906:eb86:: with SMTP id mh6mr34830343ejb.141.1634059724156;
 Tue, 12 Oct 2021 10:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211011092028.2310144-1-yangyingliang@huawei.com>
In-Reply-To: <20211011092028.2310144-1-yangyingliang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Oct 2021 23:27:56 +0300
Message-ID: <CAHp75VdAbhmd1UeFmyN1qPYOh-GKWmdStAC7WRSn91=UpDQ+Tw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: fix double free in iio_device_unregister_sysfs()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, ars@metafoo.de,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 11, 2021 at 12:12 PM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> I got the double free report:
>
> BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390
>
> CPU: 0 PID: 359 Comm: xrun Tainted: G        W         5.15.0-rc3-00109-g4dfd49fafc4d-dirty #474 523b7f3c65c42247635e2ac04a95f61f9f36678d
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  dump_stack_lvl+0xe2/0x152
>  print_address_description.constprop.7+0x21/0x150
>  kasan_report_invalid_free+0x6f/0xa0
>  __kasan_slab_free+0x125/0x140
>  slab_free_freelist_hook+0x10d/0x240
>  kfree+0xce/0x390
>  iio_device_unregister_sysfs+0x108/0x13b [industrialio]
>  iio_dev_release+0x9e/0x10e [industrialio]
>  device_release+0xa5/0x240
>  kobject_put+0x1e5/0x540
>  put_device+0x20/0x30
>  devm_iio_device_release+0x21/0x30 [industrialio]
>  release_nodes+0xc3/0x3b0
>  devres_release_group+0x1da/0x2c0
>  i2c_device_probe+0x628/0xbb0
>  really_probe+0x285/0xc30

Please, reduce this noise to the ~4-5 important lines only!

-- 
With Best Regards,
Andy Shevchenko
