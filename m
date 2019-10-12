Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA7D4FA2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJLMVd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLMVd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:21:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6159B2089C;
        Sat, 12 Oct 2019 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570882892;
        bh=FGbaJCdPHGm6RBQgaucF1PPRf2WINmSrVuC3+xA31D8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0qQEBGntfuMROIzRjBdM6UooFaoG/LVKVSDldm2K+GolisoDi79r0LfM/W/N5luyN
         k3jDp3DDaEvTtnOkA+1Q7OPejOkaceCRoposK5dMfvgIwvwxTXvyXow/h3pcH/+Dhq
         49TSG89LEpI6SzydKpZWUpNOqJ168vpWyPfKVi7k=
Date:   Sat, 12 Oct 2019 13:21:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        martin@geanix.com, rjones@gateworks.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/13] iio: imu: st_lsm6dsx: always check enable_reg in
 st_lsm6dsx_event_setup
Message-ID: <20191012132128.54f466df@archlinux>
In-Reply-To: <6a689d5a-1b35-01fe-92c5-9ac271814ad0@geanix.com>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <837ea533a4094d6da572999e8f863687fa4cae1b.1570367532.git.lorenzo@kernel.org>
        <6a689d5a-1b35-01fe-92c5-9ac271814ad0@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 09:55:14 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 06/10/2019 15.22, Lorenzo Bianconi wrote:
> > Check if enable_reg of event_settings data structure is defined before
> > writing on it
> > 
> > Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> Tested-by: Sean Nyekjaer <sean@geanix.com>
Applied
> > ---
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 23 ++++++++++----------
> >   1 file changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 5df382b9d8f9..7e9e1ef81742 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1482,26 +1482,25 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
> >   
> >   static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
> >   {
> > +	const struct st_lsm6dsx_reg *reg;
> >   	int err;
> > -	u8 enable = 0;
> >   
> >   	if (!hw->settings->irq_config.irq1_func.addr)
> >   		return -ENOTSUPP;
> >   
> > -	enable = state ? hw->settings->event_settings.enable_reg.mask : 0;
> > -
> > -	err = regmap_update_bits(hw->regmap,
> > -				 hw->settings->event_settings.enable_reg.addr,
> > -				 hw->settings->event_settings.enable_reg.mask,
> > -				 enable);
> > -	if (err < 0)
> > -		return err;
> > -
> > -	enable = state ? hw->irq_routing->mask : 0;
> > +	reg = &hw->settings->event_settings.enable_reg;
> > +	if (reg->addr) {
> > +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > +					 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
> > +		if (err < 0)
> > +			return err;
> > +	}
> >   
> >   	/* Enable wakeup interrupt */
> >   	return regmap_update_bits(hw->regmap, hw->irq_routing->addr,
> > -				  hw->irq_routing->mask, enable);
> > +				  hw->irq_routing->mask,
> > +				  ST_LSM6DSX_SHIFT_VAL(state,
> > +					hw->irq_routing->mask));
> >   }
> >   
> >   static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> >   

