Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9E19E692
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDDRGr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 13:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDDRGr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 13:06:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66E7206C3;
        Sat,  4 Apr 2020 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586020006;
        bh=WOEyQRd0nC5hSOFNQSBKxCMgUWLokojrd9HpbTDIvak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NVyYQYNc4BHfzNhPZspeIoc5rsx/CXcewTUjrEVpDSBbmetGX29ayPlfE8qRW/npj
         ZjYCgXTN81ootAORcpDh6pIkBVoI3VEL16t5LWDzB0rJRfJv+fzQzSGpRZLgmuqFmd
         vd90t9QOcCDYVNYN2A1spmEopOd13xO7yzC6U2Ns=
Date:   Sat, 4 Apr 2020 18:06:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mario.tesi@st.com" <mario.tesi@st.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: flush hw FIFO before resetting
 the device
Message-ID: <20200404180642.6e2014c6@archlinux>
In-Reply-To: <CAJ0CqmVmMe-YN-gYeS54cc_So1u-ARSQQkB_a+w6N2AZSeCGXg@mail.gmail.com>
References: <e9beff6b3a32ddf0de20821e50cf3ed562e36b48.1584122527.git.lorenzo@kernel.org>
        <CH2PR12MB4216CB1A1882DBE10CAAC967AEF60@CH2PR12MB4216.namprd12.prod.outlook.com>
        <CAJ0CqmVmMe-YN-gYeS54cc_So1u-ARSQQkB_a+w6N2AZSeCGXg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 Apr 2020 18:29:25 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> >
> > Hi Lorenzo,
> >
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Fri, Mar 13, 2020 at 18:06:00
> >  
> > > flush hw FIFO before device reset in order to avoid possible races
> > > on interrupt line 1. If the first interrupt line is asserted during
> > > hw reset the device will work in I3C-only mode (if it is supported)
> > >  
> 
> Hi Jonathan,
> 
> any news about this patch? Maybe I am wrong but I am not able to find
> it in your tree.
> Thanks in advance.

I'm running a bit behind on catching up with fixes after it became obvious
they wouldn't make the merge window.

Applied to the fixes-togreg branch of iio.git and marked for stable.

> 
> Regards,
> Lorenzo
> 
> 
> > > Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
> > > Fixes: 43901008fde0 ("iio: imu: st_lsm6dsx: add support to LSM6DSR")
> > > Reported-by: Mario Tesi <mario.tesi@st.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > This is a new version of: "iio: imu: st_lsm6dsx: disable I3C support during
> > > device reset"
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_11425389_&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=d7oUzE4fWeY3JqYqqd-uW_v1SJkij_sOpXRvpm3-Thg&s=BEgROrIZoG9oGrwQEENFz0DP88VioXUhpeZP2Y168XI&e=
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 +++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 84d219ae6aee..4426524b59f2 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -2036,11 +2036,21 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
> > >       return 0;
> > >  }
> > >
> > > -static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > > +static int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
> > >  {
> > >       const struct st_lsm6dsx_reg *reg;
> > >       int err;
> > >
> > > +     /*
> > > +      * flush hw FIFO before device reset in order to avoid
> > > +      * possible races on interrupt line 1. If the first interrupt
> > > +      * line is asserted during hw reset the device will work in
> > > +      * I3C-only mode (if it is supported)
> > > +      */
> > > +     err = st_lsm6dsx_flush_fifo(hw);
> > > +     if (err < 0 && err != -ENOTSUPP)
> > > +             return err;
> > > +
> > >       /* device sw reset */
> > >       reg = &hw->settings->reset;
> > >       err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > @@ -2059,6 +2069,18 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > >
> > >       msleep(50);
> > >
> > > +     return 0;
> > > +}
> > > +
> > > +static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > > +{
> > > +     const struct st_lsm6dsx_reg *reg;
> > > +     int err;
> > > +
> > > +     err = st_lsm6dsx_reset_device(hw);
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > >       /* enable Block Data Update */
> > >       reg = &hw->settings->bdu;
> > >       err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > --
> > > 2.24.1  
> >
> > I tested the patch and the I3C interface is working fine in this version.
> >
> > Reviewed-by: Vitor Soares <vitor.soares@synopsys.com>
> > Tested-by: Vitor Soares <vitor.soares@synopsys.com>
> >

> > Best regards,
> > Vitor
> > Soares
> >
> >  
> 

