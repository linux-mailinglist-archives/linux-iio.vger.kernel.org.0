Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12856196E32
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgC2Pj3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 11:39:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54584 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Pj3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 11:39:29 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so6417890pjb.4;
        Sun, 29 Mar 2020 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2NIPO1uXNI6V+CGOF1YpeSGSs8uWQCp3lFMeeoGtVOU=;
        b=bq/NmQ+3VpY+LIZfgPGg7bqJgUCpiWv2nlvRLraFRDp0G/jId3r0e5nlJdd7y2f8lT
         n4YV4rpYfXhlSp2OvQG0vZDXvGuFHKG50Blb5WvgIwJtnJtrYomLi000tEqKTS5NTxh7
         iCaA1RV9aCRMkHrpzxmFCq/gnb89o1XM19B7t4LM12AaXA0YU03hE6xoGQ+ObOmrqehH
         xUrZ3bvUWK126RIH4x4gQaII71XUUVqmoGG3KqcOEF8YGJEHre/D7uctYQqDdsjAK8c5
         GSadSnWHxZNWRed73rg0o68RifnoJouGdStwt3mQAetfOfeuLIp0lOcXiVRmjcesawtQ
         2HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2NIPO1uXNI6V+CGOF1YpeSGSs8uWQCp3lFMeeoGtVOU=;
        b=lgoGvCsCXerIKs2QedsIUChH2UpeKqrfA1W7a/iJRF5D9/oUKtfUtqp/gsf39348Hr
         1gN5aaRRxTXi+G5Dwmdq9WYNLPC6/KT+IDFyoBWCBa+vf03uFl9gD/Uyj7FchfDftnk2
         b4Ii4ooGDHnqNiTKbRMKPaS3WqrHCrrYXP+E686cUW0mSxBvW3USxOyUYg5rKAtVyEmL
         4MUc4xKipljSwWs28vxIXBb8XZD7nLKS+7TIR+PjWr37XqYqWJna6zZncOqcIAL2TNxs
         somNRrljZfq9DJOTGckzfbu//dcVtFT2zCvnqgZivUTxIGlHZgDUHWXtwKEq1Fbw1Avy
         fpaw==
X-Gm-Message-State: ANhLgQ3n1U+aMLjJ1wau3yIbB2IPdnlM5LxOlyYPrq2eayOhJUI44JGu
        jII+5cUSmLRvb9awkHz1jYI9lv43NtA=
X-Google-Smtp-Source: ADFU+vvMC36ePpi56zxpdaKeU+rtVK/cjJF8hOW4Ry7vx3OScvP0Wgc9IPRB5zSVKfMbtw95nQoKKQ==
X-Received: by 2002:a17:90a:c790:: with SMTP id gn16mr11056895pjb.146.1585496367465;
        Sun, 29 Mar 2020 08:39:27 -0700 (PDT)
Received: from SARKAR ([2401:4900:3314:137e:2ce4:2642:30f:c482])
        by smtp.gmail.com with ESMTPSA id x70sm2972453pfc.21.2020.03.29.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 08:39:26 -0700 (PDT)
Message-ID: <5e80c12e.1c69fb81.76f06.f47c@mx.google.com>
X-Google-Original-Message-ID: <20200329153915.GA32029@rohitsarkar5398@gmail.com>
Date:   Sun, 29 Mar 2020 21:09:15 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        dragos.bogdan@analog.com,
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
 <5e8087e3.1c69fb81.13d97.448d@mx.google.com>
 <8d861c54-75be-589a-9e71-cd30cbde84d3@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d861c54-75be-589a-9e71-cd30cbde84d3@metafoo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 29, 2020 at 03:46:17PM +0200, Lars-Peter Clausen wrote:
> On 3/29/20 1:34 PM, Rohit Sarkar wrote:
> > On Sun, Mar 29, 2020 at 10:38:18AM +0100, Jonathan Cameron wrote:
> > > On Sat, 28 Mar 2020 12:04:53 +0530
> > > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> > > 
> > > > The debugfs_create_file_unsafe method does not protect the fops given to
> > > > it from file removal. It must be used with DEFINE_DEBUGFS_ATTRIBUTE
> > > > which makes the fops aware of the file lifetime.
> > > > 
> > > > Further using DEFINE_DEBUGFS_ATTRIBUTE along with
> > > > debugfs_create_file_unsafe significantly reduces the overhead introduced by
> > > > debugfs_create_file which creates a lifetime managing proxy around each
> > > > fops handed in. Refer [1] for more on this.
> > > > 
> > > > Fixes the following warnings reported by coccinelle:
> > > > drivers/iio/imu//adis16460.c:126:0-23: WARNING: adis16460_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > drivers/iio/imu//adis16460.c:108:0-23: WARNING: adis16460_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > drivers/iio/imu//adis16460.c:90:0-23: WARNING: adis16460_serial_number_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > drivers/iio/imu//adis16400.c:278:0-23: WARNING: adis16400_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > drivers/iio/imu//adis16400.c:261:0-23: WARNING: adis16400_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > 
> > > > [1]: https://lists.gt.net/linux/kernel/2369498
> > > > 
> > > > Rohit Sarkar (2):
> > > >    iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of
> > > >      DEFINE_SIMPLE_ATTRIBUTE
> > > >    iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of
> > > >      DEFINE_SIMPLE_ATTRIBUTE
> > > > 
> > > >   drivers/iio/imu/adis16400.c | 4 ++--
> > > >   drivers/iio/imu/adis16460.c | 6 +++---
> > > >   2 files changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > Hi Rohit,
> > Hey,
> > > You've opened a can of worms with this one.  There as a previous series
> > > posted doing exactly this change back in 2019 by Zhong Jiang (cc'd)
> > > 
> > > At the time I did a bit of looking into why this had been universally taken
> > > up cross tree and turned out there are some potential issues.
> > > 
> > > Alexandru added it to the list of things to test, but I guess it got
> > > buried under other work and is still outstanding.
> > > 
> > > https://lkml.org/lkml/2019/10/30/144
> > Acc. to the patch by Zhong this change kind of comes off as a cosmetic
> > change as in the commit message he mentions "it is more clear".
> > 
> > But there is certainly more to it than that:
> > In the current scenario since we are using debugfs_create_file_unsafe
> > the file has no protection whatsoever against removal.
> 
> The drivers you are patching all use debugfs_create_file() as far as I can
> see.
Ah, You are right. I dont know why I assumed that
debugfs_create_file_unsafe was being used. Was probably sleepy when I
sent this out :/
> The way I understand it using DEFINE_DEBUGFS_ATTRIBUTE without switching to
> debugfs_create_file_unsafe() will not make a difference. There will only be
> more overhead since the files are protected twice.
That's right.
it should either be ...unsafe() with DEFINE_DEBUGFS_ATTRIBUTE or what it
is currently.

In the current scenario the file is protected against removal but there
is extra overhead because debugfs_create_file creates a lifetime
managing proxy AFAIK.

I can send a v2 changing the debugfs_create_file function to unsafe if
someone can test it out on h/w as Jonathan suggested.
> - Lars
> 
Thanks,
Rohit
