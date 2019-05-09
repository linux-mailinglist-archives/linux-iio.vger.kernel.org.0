Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3216C18522
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 08:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEIGLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 02:11:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37204 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIGLZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 02:11:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so1503079wma.2
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2019 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=10yNfjWlj6Q+p5zJZH8R6Odak87HYwUB4RGRx/vkup4=;
        b=laZZODAesL0bLuuZenPPuVdtnwFMncG9bBdMr8peQvRNZYuu4JSUJvE6CyZlFBi52q
         DBDT+TOFV/NzibULe+t2UcLsAgjWf6DQaKje+NvL4dt/ANOnJkLTca4Yjb65ZHbiYvfg
         kcMgNVMNH7gwzLb4yLACOGzO1VGg+r5KE46B+nCQxHeXltIAtQ/jUVL8NchSYENN8DqJ
         +O7aZUJv/YWOh78j1i3oigS3XNvw1cZTrrdn3JwzoTlul7CRPhlb9vLHnIJNKWkY7CYi
         aMJ3+87uhtvSVECffSlgUT+mn7mURg31oiDF43ZvtxFiCEyj2JDTRcc63eFBleB4ohZW
         4TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=10yNfjWlj6Q+p5zJZH8R6Odak87HYwUB4RGRx/vkup4=;
        b=f4O5nBVA7YcVfS4MRhUGAyY9ry6kXcnYZE+j1L5HPJOlCv1DfMzuENVtke7UPPHI9v
         HkD5HdzmBRMx0DXLK+Gs3PqFw183l90LW9TcazyWO/3BUqnW7ILOMSFz/NF34PSSc29n
         x+EKJCuh1zbbvEcZXNDNgoj577InMTtAkei5ioI0qNI4KEu81oTcnLt0r7Ki15m+c1BS
         8I9BMlPit9MoBeBS4dgbNzSoDXLqLPXlMJdg9/zJnzHwdyXxVU7/TLnGTdghMRgUEcjW
         tSMrRLRY0l3lTH4L3uYABqxGa9NCbCH2qpgdG7bwAn91Fmskdy2b+XnwK25GoNOzpEJ1
         1ihg==
X-Gm-Message-State: APjAAAWjswmhku00cu55RO4m9gyXgexMs8qG05FQXiDS0ldyvnkMupNP
        6zguL7dvE98Vd6Dysnw2Hs/WCQ==
X-Google-Smtp-Source: APXvYqw/E0mALvZqOxNaf2fa6zR5nT5NOytbPtk51OufaRcnN5C3ta1VLzkNXx/u8ButibYxSfElwA==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr475288wmh.7.1557382282720;
        Wed, 08 May 2019 23:11:22 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id u9sm997939wmd.14.2019.05.08.23.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 23:11:21 -0700 (PDT)
Date:   Thu, 9 May 2019 07:11:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benson Leung <bleung@google.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/30] Update cros_ec_commands.h
Message-ID: <20190509061119.GT31645@dell>
References: <20190503220233.64546-1-gwendal@chromium.org>
 <20190507094446.GD4529@dell>
 <20190508231954.GA41543@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508231954.GA41543@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 08 May 2019, Benson Leung wrote:

> Hi Gwendal, Hi Lee,
> 
> On Tue, May 07, 2019 at 10:44:46AM +0100, Lee Jones wrote:
> > On Fri, 03 May 2019, Gwendal Grignou wrote:
> > 
> > > The interface between CrosEC embedded controller and the host,
> > > described by cros_ec_commands.h, as diverged from what the embedded
> > > controller really support.
> > > 
> > > The source of thruth is at
> > > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> > > 
> > > That include file is converted to remove ACPI and Embedded only code.
> > > 
> > > From now on, cros_ec_commands.h will be automatically generated from
> > > the file above, do not modify directly.
> > > 
> > > Fell free to squash the commits below.
> > > 
> > > Changes in v2:
> > > - Move I2S changes at the end of the patchset, squashed with change in
> > >   sound/soc/codecs/cros_ec_codec.c to match new interface.
> > > - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > 
> > > Gwendal Grignou (30):
> > >   mfd: cros_ec: Update license term
> > >   mfd: cros_ec: Zero BUILD_ macro
> > >   mfd: cros_ec: set comments properly
> > >   mfd: cros_ec: add ec_align macros
> > >   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
> > >   mfd: cros_ec: use BIT macro
> > >   mfd: cros_ec: Update ACPI interface definition
> > >   mfd: cros_ec: move HDMI CEC API definition
> > >   mfd: cros_ec: Remove zero-size structs
> > >   mfd: cros_ec: Add Flash V2 commands API
> > >   mfd: cros_ec: Add PWM_SET_DUTY API
> > >   mfd: cros_ec: Add lightbar v2 API
> > >   mfd: cros_ec: Expand hash API
> > >   mfd: cros_ec: Add EC transport protocol v4
> > >   mfd: cros_ec: Complete MEMS sensor API
> > >   mfd: cros_ec: Fix event processing API
> > >   mfd: cros_ec: Add fingerprint API
> > >   mfd: cros_ec: Fix temperature API
> > >   mfd: cros_ec: Complete Power and USB PD API
> > >   mfd: cros_ec: Add API for keyboard testing
> > >   mfd: cros_ec: Add Hibernate API
> > >   mfd: cros_ec: Add Smart Battery Firmware update API
> > >   mfd: cros_ec: Add I2C passthru protection API
> > >   mfd: cros_ec: Add API for EC-EC communication
> > >   mfd: cros_ec: Add API for Touchpad support
> > >   mfd: cros_ec: Add API for Fingerprint support
> > >   mfd: cros_ec: Add API for rwsig
> > >   mfd: cros_ec: Add SKU ID and Secure storage API
> > >   mfd: cros_ec: Add Management API entry points
> > >   mfd: cros_ec: Update I2S API
> > > 
> > >  include/linux/mfd/cros_ec_commands.h | 3735 +++++++++++++++++++++-----
> > >  sound/soc/codecs/cros_ec_codec.c     |    8 +-
> > >  2 files changed, 2997 insertions(+), 746 deletions(-)
> > 
> > Again, it would be good to get 1 or 2 more Chromium Acks, given the
> > extent of the changes.
> 
> I've gone ahead and looked through all 30 of the changes here. It looks good to me.
> 
> Acked-By: Benson Leung <bleung@chromium.org>

Thanks for taking he time.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
