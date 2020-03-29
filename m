Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642E6196D0B
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 13:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgC2LfC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 07:35:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgC2LfB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 07:35:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id s23so5515780plq.13;
        Sun, 29 Mar 2020 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3U2zGu5EljoEhInngF/MGy98drO8oW8eURU26m47lps=;
        b=TzvY4+lTJF2CwQProk5NFI9gwDe3ezuDrAgm0eiPalqwD0YZphnZjL1mhD1irNIfCu
         OQ+CXZHVbnkWSsfHL4LbXFzXDdZ9y3VQLtXa4V6NSW7ro/lmCpgvYxENt1PAx6ikmSeA
         vTpxzX7VItnu+O8XxhjWxh1aPf4laQZlAPtBnxPhpMXiTeBOyfY4TrUXiUdvX8JG9l2o
         pRCxJTM3Fd5THks2AAa3AyYv0GQfszgzQq4LCIRXqrHzF0aLYaPLG46CCJ99o74Q6Az1
         C2s+dQdE/Siltzp4E7pz3/ds8zZFNn79z6/fXy2EsUq1HjE9jwd/ItKyJcoF0gt5lfQ6
         bY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3U2zGu5EljoEhInngF/MGy98drO8oW8eURU26m47lps=;
        b=tNqdAoeBIeunsqYwN/6feaePyBA8r7c9TpAdYSwxTeZxWnlNt765EXiIHBNNz19EaI
         FJUEzTtChe2YOqUHDstzHIkCb/hQWpz7nRyjx441++bWJ18ZC0VTbiX8CU7K/w34xo2s
         0MgLGxaEY6AJQw04an+4JzkHs+zAZHGC460n8UErygWHPMVxUIGSDoOgUmHae4y/dAPx
         7ZRgfyjDWwhvtAdHldSLq8smO9nEe24WMJMPJBVrBhFlDYUBEfJP8vSUefAyqFrZU/IO
         1jbWqRGIg0Z7yLB5HTuzgyJALGcdYcptgh2sYQJ1e/tR/mhQY5sS6oJTS8OMyghHMVbf
         Go8w==
X-Gm-Message-State: ANhLgQ21x73j59tvArUJqTwvUvq7ly3ndI8aSpblI4H6jyzmVgJr8srP
        mW9MmoYARxrnabPhvhGxq5g=
X-Google-Smtp-Source: ADFU+vtPceFIaWh3aJr0XVdTwVl7niibGUIx3WXzqSISGf9LEkmeNM+MRNqbmWde7Ju8vSNiwXqfdQ==
X-Received: by 2002:a17:902:449:: with SMTP id 67mr7611883ple.339.1585481700644;
        Sun, 29 Mar 2020 04:35:00 -0700 (PDT)
Received: from SARKAR ([2401:4900:331f:aaac:2ce4:2642:30f:c482])
        by smtp.gmail.com with ESMTPSA id w127sm7909245pfb.70.2020.03.29.04.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 04:34:59 -0700 (PDT)
Message-ID: <5e8087e3.1c69fb81.13d97.448d@mx.google.com>
X-Google-Original-Message-ID: <20200329113451.GB8353@rohitsarkar5398@gmail.com>
Date:   Sun, 29 Mar 2020 17:04:51 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200329103818.2fce9529@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329103818.2fce9529@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 29, 2020 at 10:38:18AM +0100, Jonathan Cameron wrote:
> On Sat, 28 Mar 2020 12:04:53 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > The debugfs_create_file_unsafe method does not protect the fops given to
> > it from file removal. It must be used with DEFINE_DEBUGFS_ATTRIBUTE
> > which makes the fops aware of the file lifetime.
> > 
> > Further using DEFINE_DEBUGFS_ATTRIBUTE along with
> > debugfs_create_file_unsafe significantly reduces the overhead introduced by
> > debugfs_create_file which creates a lifetime managing proxy around each
> > fops handed in. Refer [1] for more on this.
> > 
> > Fixes the following warnings reported by coccinelle:
> > drivers/iio/imu//adis16460.c:126:0-23: WARNING: adis16460_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > drivers/iio/imu//adis16460.c:108:0-23: WARNING: adis16460_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > drivers/iio/imu//adis16460.c:90:0-23: WARNING: adis16460_serial_number_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > drivers/iio/imu//adis16400.c:278:0-23: WARNING: adis16400_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > drivers/iio/imu//adis16400.c:261:0-23: WARNING: adis16400_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > 
> > [1]: https://lists.gt.net/linux/kernel/2369498
> > 
> > Rohit Sarkar (2):
> >   iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of
> >     DEFINE_SIMPLE_ATTRIBUTE
> >   iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of
> >     DEFINE_SIMPLE_ATTRIBUTE
> > 
> >  drivers/iio/imu/adis16400.c | 4 ++--
> >  drivers/iio/imu/adis16460.c | 6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> Hi Rohit,
Hey, 
> You've opened a can of worms with this one.  There as a previous series
> posted doing exactly this change back in 2019 by Zhong Jiang (cc'd)
> 
> At the time I did a bit of looking into why this had been universally taken
> up cross tree and turned out there are some potential issues.
> 
> Alexandru added it to the list of things to test, but I guess it got
> buried under other work and is still outstanding.
> 
> https://lkml.org/lkml/2019/10/30/144
Acc. to the patch by Zhong this change kind of comes off as a cosmetic
change as in the commit message he mentions "it is more clear". 

But there is certainly more to it than that:
In the current scenario since we are using debugfs_create_file_unsafe
the file has no protection whatsoever against removal. 
> Has Greg KH raising the point that file reference counting is changed (as you
> mention) but that can cause subtle bugs.  It 'might' be fine but is
> definitely one that needs a tested-by from someone with the hardware.
Sure that makes sense. 
> Jonathan

Thanks,
Rohit
