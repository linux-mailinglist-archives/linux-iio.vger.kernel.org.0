Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC05A2258F7
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGTHvj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGTHvi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 03:51:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F5C0619D2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:51:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so16831286wrp.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DTBiRsioux2G2GFyLL36oFwoaGVhX+Bg3Ygmco4aUxI=;
        b=i6aU3HJPmVzs/w1H4lQfqi3iUiXPLcNwb6d8zzvChyw05sv+cuvDRIoiNIADPQ0J7M
         sw/7/EsEvbSR8oP3TGJoA8LYmnBgeEUFEG9f8E2RJbE5gnZzhVU1gwQIDWIYbvDfLOo5
         1a1tg5Vx6CwRww91q+cHe35XR5kkyJZzapOWEHKcK9yfX7sHpv1MgNz3CMAAkSX/d/m1
         N0LD5xFgFpNtX/CWVUbGgExauWodJxT2FH/HQ65HAgJrtBmp0mjzSiAPmHVdMyhaxqoF
         V7OSiy0qYPBvxkWWatAMiV4EOSspiWoirwP+MhhoBPeKUm6EOy6EkwwQPkDVuLGA1+J6
         CnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DTBiRsioux2G2GFyLL36oFwoaGVhX+Bg3Ygmco4aUxI=;
        b=nfcFpyrQnqkZdzFAOcr+TYTBljCul8vyOA3zvHpMDqgK2BLWhRWI6owVNDT2IhVboh
         Q/y8jyBmJzuX8UW/lLUjizmKuSosIGUlu0pb7AJOUqQW2IDjgq/fgt47Kn4jOmifvPjN
         CJ7UwCDwUtvd9vKT2A+Gh49gEN09m7AeymBhIktbvsy8jgCALB9LwiLqUBvdxe6qr+5u
         fj21PzVBrdPXiXpNdlHflhPCqAiRnTfZWTaf2u+Ovnv7PoZALk3WiK/QrcdJcKT0shTO
         F1CKFeb3vQ+aj3e8yEJHG3dtZhKmYfy9CCjB79GSPEYeK+6s3ZKX/hwf5UFCN9aESMbJ
         0WpQ==
X-Gm-Message-State: AOAM531iGY2RNTVRO9urpKy5NzXWhHiySf/R7T6KcTuKW85f3bt0H42f
        3YXf2Vn0606qh+AVbe/1QOcccA==
X-Google-Smtp-Source: ABdhPJzupsQDL07RrKQVFuEH7Pa5C2ZgAVE9nE3jjj1hAVYYqvCOhBT29xj1L6njY9ZZif0aIWQWFw==
X-Received: by 2002:a5d:4241:: with SMTP id s1mr8747843wrr.411.1595231496419;
        Mon, 20 Jul 2020 00:51:36 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id 65sm32603821wmd.20.2020.07.20.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:51:35 -0700 (PDT)
Date:   Mon, 20 Jul 2020 08:51:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/30] First batch of W=1 fixes for IIO
Message-ID: <20200720075134.GM3165313@dell>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
 <20200718154204.280fcb83@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200718154204.280fcb83@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jul 2020, Jonathan Cameron wrote:

> On Thu, 16 Jul 2020 14:58:58 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> Thanks for these.
> 
> One general comment is I'd have appreciated a spot of grouping to bring
> a particular group of identical problems together in the series.
> Example being the @lock(:) ones in this set.

There are a few reasons for me not doing this.  Firstly, some of the
files experiencing 'lock:' issues had other problems which needed to
be dealt with anyway.  I also do not know what other issues exist
before I start drafting patches - until now I have been going through
the list of issues, file-by-file, from top (first complained about) to
bottom.  I have no mechanism (or desire) to pre-read 100's of lines of
warnings to see which ones could be easily grouped.  I also wanted to
keep changes encapsulated into 1 patch per file, for bisectability and
revertability proposes.

I'm certainly not disagreeing or arguing with you, just explaining
that it is something that I've thought about.

> It doesn't matter that much though. I'm just being fussy :)
> 
> Jonathan
> 
> > 
> > Lee Jones (30):
> >   iio: adc: ad_sigma_delta: Remove unused variable 'ret'
> >   iio: accel: bma220_spi: Do not define 'struct acpi_device_id' when
> >     !CONFIG_ACPI
> >   iio: common: ms_sensors: ms_sensors_i2c: Fix misspelling of parameter
> >     'client'
> >   iio: adc: ad7298: Demote obvious misuse of kerneldoc to standard
> >     comment blocks
> >   iio: chemical: sgp30: Add description for sgp_read_cmd()'s
> >     'duration_us'
> >   iio: adc: ad7923: Demote obvious misuse of kerneldoc to standard
> >     comment blocks
> >   iio: dac: ad5360: Fix kerneldoc attribute formatting for 'lock'
> >   iio: dac: ad5380: Fix kerneldoc attribute formatting for 'lock'
> >   iio: dummy: iio_simple_dummy: Demote unworthy kerneldocs and correct
> >     misspelling
> >   iio: dummy: iio_simple_dummy: Add newline after function-end
> >   iio: dac: ad5421: Fix kerneldoc attribute formatting for 'lock'
> >   iio: gyro: adis16080: Fix formatting issue and compiler attribute
> >     ordering
> >   iio: dummy: iio_simple_dummy_events: Demote file header and supply
> >     descriptions for val2 params
> >   iio: dac: ad5064: Value returned by ad5064_vref_name may not be 'const
> >     * const'
> >   iio: dummy: iio_dummy_evgen: Demote file header and supply description
> >     for 'irq_sim_domain'
> >   iio: adc: ad7887: Demote seemingly unintentional kerneldoc header
> >   iio: adc: ad7949: Fix misspelling issue and compiler attribute
> >     ordering
> >   iio: dummy: iio_simple_dummy_buffer: Demote file header and correct
> >     misspelling
> >   iio: dac: ad5064: Fix a few kerneldoc misdemeanours
> >   iio: dac: ad5446: Complete 'struct ad5446_state' doc and demote
> >     unworthy kerneldocs
> >   iio: dac: ad5449: Fix kerneldoc attribute formatting for 'lock'
> >   iio: dac: ad5755: Fix kerneldoc attribute formatting for 'lock'
> >   iio: dac: ad5758: Move and fix-up kerneldoc header and demote unworthy
> >     kerneldoc
> >   iio: dac: ad5761: Fix kerneldoc attribute formatting for 'lock'
> >   iio: dac: ad5764: Fix misdocumenting and formatting error
> >   iio: dac: ad5791: Complete 'struct ad5791_chip_info' documentation
> >   iio: light: cm32181: Fix formatting and docrot issues in
> >     cm32181_acpi_get_cpm()
> >   iio: magnetometer: mmc35240: Fix function header formatting
> >   iio: imu: kmx61: Fix formatting in kerneldoc function headers
> >   iio: dac: ad7303: Complete 'struct ad7303_state' doc and reorder
> >     compiler attribute
> > 
> >  drivers/iio/accel/bma220_spi.c                 |  2 ++
> >  drivers/iio/adc/ad7298.c                       |  8 ++++----
> >  drivers/iio/adc/ad7887.c                       |  2 +-
> >  drivers/iio/adc/ad7923.c                       |  8 ++++----
> >  drivers/iio/adc/ad7949.c                       |  4 ++--
> >  drivers/iio/adc/ad_sigma_delta.c               |  7 ++-----
> >  drivers/iio/chemical/sgp30.c                   |  1 +
> >  drivers/iio/common/ms_sensors/ms_sensors_i2c.c |  2 +-
> >  drivers/iio/dac/ad5064.c                       | 10 +++++-----
> >  drivers/iio/dac/ad5360.c                       |  2 +-
> >  drivers/iio/dac/ad5380.c                       |  2 +-
> >  drivers/iio/dac/ad5421.c                       |  2 +-
> >  drivers/iio/dac/ad5446.c                       | 11 +++++++----
> >  drivers/iio/dac/ad5449.c                       |  2 +-
> >  drivers/iio/dac/ad5755.c                       |  2 +-
> >  drivers/iio/dac/ad5758.c                       | 18 +++++++++---------
> >  drivers/iio/dac/ad5761.c                       |  2 +-
> >  drivers/iio/dac/ad5764.c                       |  5 ++---
> >  drivers/iio/dac/ad5791.c                       | 10 ++++------
> >  drivers/iio/dac/ad7303.c                       |  5 ++++-
> >  drivers/iio/dummy/iio_dummy_evgen.c            |  4 +++-
> >  drivers/iio/dummy/iio_simple_dummy.c           |  7 ++++---
> >  drivers/iio/dummy/iio_simple_dummy_buffer.c    |  4 ++--
> >  drivers/iio/dummy/iio_simple_dummy_events.c    |  4 +++-
> >  drivers/iio/gyro/adis16080.c                   |  4 ++--
> >  drivers/iio/imu/kmx61.c                        | 14 +++++++-------
> >  drivers/iio/light/cm32181.c                    |  8 ++++----
> >  drivers/iio/magnetometer/mmc35240.c            |  4 ++--
> >  28 files changed, 81 insertions(+), 73 deletions(-)
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
