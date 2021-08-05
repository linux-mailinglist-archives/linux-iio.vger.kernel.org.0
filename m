Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680093E0CE8
	for <lists+linux-iio@lfdr.de>; Thu,  5 Aug 2021 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhHEDw3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 23:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhHEDw3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 23:52:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE9C061765;
        Wed,  4 Aug 2021 20:52:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mt6so6110733pjb.1;
        Wed, 04 Aug 2021 20:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5gUQv+6ZGYwbRVo8quLRq3FrOKVGV1InICtyXNkSRDY=;
        b=Jzq8iGhZOjT6wOIwM1rHD/R7uUocaLEIZMi9isredZdKzxy31Qd/Ql8MS5R4mVOElC
         D7zR5HIsUwUJcYVNFptXdHULBzkC+1nC0a3+5Zvv3HXECv+UMAPdtwBCs6+Hxu0WwbXV
         tnez8QBtnShYvaFjQkv3v1rGA27enUyxzhNLs+5nomOiK1JBoOvrSNCbIKoiVu0D98Rz
         QZKIU+vu8weUPRZdPvmXrp2IPZHpToFj8DZ+TPsU7jWW+WDIdt9kIZJjUtYngKJlehe2
         XjhUVGL9mZDxiab99BuMUyuSzcc5MFdbEQrcaJVsCIbR7iLCgqJ9rmmr56T22OSJpIaZ
         +Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5gUQv+6ZGYwbRVo8quLRq3FrOKVGV1InICtyXNkSRDY=;
        b=VP8E/Kc8gaZ8gfuZvv2u8UMQJnQJGmJreZvMU9sQCFi4pfQD1luZXFr9QaH+CbuCMs
         kvX02Lavxlx0gIM/cxGtLrUAHstvDSZYemRg6k0l3U5qcUFEJRZB/T1jrBNvay1NCDE8
         i6oxMhhaTDjMB4yvJpzTOmf0HljNsAKeHKbXV2pnx2872IvBHvcmMtamXnoeyLmHTP1R
         FdkSLGNmXXbvFqgMAwBKiO7ZjveYMdFKvWSBbiWiVpkj7qt45ITIoKeU6jsJnvPtzgoY
         edTihoZsgoI753qhh9IYmor86QT4DuJi7QeZnSfpyhx0XIhve9wO5RF7V0axuYitGmzZ
         w/PA==
X-Gm-Message-State: AOAM5322SUfeJyODSEsK5skTMQNEoxNn02T+GMpu0rs7STCfV4ASOEYV
        4POUvSwqwgUDJy5zDf86ozA=
X-Google-Smtp-Source: ABdhPJxZhRUORY8CXweNactuQiyBTGM30Z+2uWCq8PvkZv8wiaiIwM3+JG+xsoYwzKylDtWfzzvSkA==
X-Received: by 2002:a17:90a:d589:: with SMTP id v9mr9754433pju.61.1628135534473;
        Wed, 04 Aug 2021 20:52:14 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:969:ac00:72bc:4eae:e257:8107])
        by smtp.gmail.com with ESMTPSA id 26sm5354602pgx.72.2021.08.04.20.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 20:52:13 -0700 (PDT)
Date:   Thu, 5 Aug 2021 00:52:04 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <YQtgZMWv5nfMgP8/@marsc.168.1.7>
References: <20210614113507.897732-1-jic23@kernel.org>
 <YNIfkaRZtWIXPbAj@marsc.168.1.7>
 <20210623093741.00007d1d@Huawei.com>
 <20210711155051.713c1207@jic23-huawei>
 <YOyFE/yHrLQxKpkU@marsc.168.1.7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOyFE/yHrLQxKpkU@marsc.168.1.7>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[...]

> > 
> > Note there is loads of stuff that isn't implemented as it was developed alongside
> > this patch series to verify individual patches rather than with the intent of
> > actually emulating the device.
> > 
> OK, will be aware of that.
> 
> > It's hard coded to 2 a chain of 3 ad7280a devices because that seemed to hit most possible
> > corner cases.
> > 
> > The top commit has the launch string I'm using.  You'll need a filesystem, but
> > you can probably use one of the convenient ones debian posts as nocloud cloud
> > images. 
> > 
> > There is some info on that on people.kernel.org/jic23 as I wrote up how to test
> > CXL stuff on ARM recently and gave guidance on easy ways to get a filesystem.
> > http://cdimage.debian.org/cdimage/cloud/sid/daily/20210702-691/debian-sid-nocloud-arm64-daily-20210702-691.qcow2
> > will probably work and is more recent than the one linked from that blog post. 
> 
> I was using a debian imgage created from following the instructions on a
> tutorial pointed by the QEMU docs.
> https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-board/
> Anyhow, I'll chance to the nocloud one if see things don't get working.
> 
> > 
> > Give me a shout if you need more specific guidance than this very very rough guide!
> 
> Sure, let's see if I can get through it now. Otherwise ...

I've managed to get it running and see the emulated ad7280a working.
Still getting some trouble with the ad7150 emulation though.
I added a pull request with some comments about the ad7150 emulation on the
github repository. 
Overall I don't think it was so hacky, I just wonder if it could have been
done more cleanly by passing a custom dtb in the launching string. The hacks
at virt.c are mostly to add the busses, add the device nodes, and connect
device gpio to interrupt lines. We could do it all by editing a dt, right?
Anyhow, thanks a lot for sharing this stuff.

> 
> > 
> > I mentioned this thread in the diversion the rust on linux thread took into
> > use of QEMU to emulate devices which motivated me to stop being lazy and at least
> > post this hideous version.  Probably the most useful bit is how to get a working
> > spi device emulated on the arm virt machine as that is very handy for all manner
> > of testing.  One day someone might implement a large set of IIO device emulation
> > and bolt it into a CI...
> 
> Agree, it's hard to get IIO drivers runtime tested because we often don't
> have the required hardware to do it. I think emulation would help us with
> that or, at least, would give us a little bit more confidence in our
> changes than just relying on sharp eyes and compile/static tests.
> Puching that into a CI would also be rather nice.
> 
> > 
> > Jonathan
> > 
> > > 
> > > > 
> > > > Being able to see it running, I may feel more confident to provide a review
> > > > for this set :)  

Guess I've been too optimistic. The way things are going I may take a few
more weeks to have a closer look at all the patches. I'll try to make it
before the next merge window or give up otherwise. It's not reasonable to
ask you wait more since this set has been sitting on the list for so long.


[...]
