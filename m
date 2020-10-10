Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058C628A35C
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 01:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbgJJW5J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731618AbgJJTyL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C3C2225F;
        Sat, 10 Oct 2020 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602336030;
        bh=QgLhXmokM8W4istLH9dx35w5EkY29SHBcFQqH4Hol5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ULYFH0WxvTRIg9+2PHbrk4GFWmIdErckXg+GgFkL4STOZ6zePKaPRBZ0XlkJm5cf+
         T4UCyACwbg66TcaBuClbV7WMH0bWSqkfod8f1vSzxbblQhvAz60F6oQz0ZXfDJ3jsP
         1bCjHVn4L/1U5QUSkhut2GXE+OPENZJaNnZzC+t0=
Date:   Sat, 10 Oct 2020 14:19:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: cros_ec: Use default frequencies when EC
 returns invalid information
Message-ID: <20201010141957.35656092@archlinux>
In-Reply-To: <5df1edd8-6ac9-29d0-199a-8ea620fbb329@collabora.com>
References: <20200630153730.3302889-1-gwendal@chromium.org>
        <c1a187a7-1610-65d6-3636-796cd15cba08@collabora.com>
        <20200704174437.11794ac9@archlinux>
        <20200926162021.46053cfa@archlinux>
        <5df1edd8-6ac9-29d0-199a-8ea620fbb329@collabora.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Oct 2020 18:52:16 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Jonathan,
> 
> Sorry for the late reply.
> 
> On 26/9/20 17:21, Jonathan Cameron wrote:
> > On Sat, 4 Jul 2020 17:44:37 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> >> On Tue, 30 Jun 2020 17:50:24 +0200
> >> Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> >>  
> >>> Hi Gwendal,
> >>>
> >>> On 30/6/20 17:37, Gwendal Grignou wrote:    
> >>>> Minimal and maximal frequencies supported by a sensor is queried.
> >>>> On some older machines, these frequencies are not returned properly and
> >>>> the EC returns 0 instead.
> >>>> When returned maximal frequency is 0, ignore the information and use
> >>>> default frequencies instead.
> >>>>
> >>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>      
> >>>
> >>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>    
> >>
> >> Fix or tidy up? I.e. does this want to go into stable?  
> > 
> > I've still not applied this one due to the above question.
> > 
> > If I don't hear reasonably soon I'll guess tidy up and queue
> > it up.
> >   
> 
> I think that should be a fix, although it might require some backport effort to
> apply the patch cleanly on older stable versions as there were some changes
> between the problem was introduced and the fix.
> 
> Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose cros_ec_sensors
> frequency range via iio sysfs")
Applied to the fixes-togreg branch of iio.git and marked for stable.
This won't go upstream until after the merge window though given timing.

Thanks,

Jonathan

> 
> Thanks,
>  Enric
> 
> > Thanks,
> > 
> > Jonathan
> >   
> >>
> >> Thanks,
> >>
> >> Jonathan
> >>  
> >>>     
> >>>> ---
> >>>> Changes since v1:
> >>>> - improve visibility by using new 100 character line length limit.
> >>>>
> >>>>  .../cros_ec_sensors/cros_ec_sensors_core.c       | 16 +++++++++++-----
> >>>>  1 file changed, 11 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >>>> index 36e3f20891f05..b30fd6b56773f 100644
> >>>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >>>> @@ -289,7 +289,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >>>>  	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> >>>>  	struct cros_ec_dev *ec = sensor_hub->ec;
> >>>>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> >>>> -	u32 ver_mask;
> >>>> +	u32 ver_mask, temp;
> >>>>  	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
> >>>>  	int ret, i;
> >>>>  
> >>>> @@ -345,10 +345,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >>>>  						 &frequencies[2],
> >>>>  						 &state->fifo_max_event_count);
> >>>>  		} else {
> >>>> -			frequencies[1] = state->resp->info_3.min_frequency;
> >>>> -			frequencies[2] = state->resp->info_3.max_frequency;
> >>>> -			state->fifo_max_event_count =
> >>>> -			    state->resp->info_3.fifo_max_event_count;
> >>>> +			if (state->resp->info_3.max_frequency == 0) {
> >>>> +				get_default_min_max_freq(state->resp->info.type,
> >>>> +							 &frequencies[1],
> >>>> +							 &frequencies[2],
> >>>> +							 &temp);
> >>>> +			} else {
> >>>> +				frequencies[1] = state->resp->info_3.min_frequency;
> >>>> +				frequencies[2] = state->resp->info_3.max_frequency;
> >>>> +			}
> >>>> +			state->fifo_max_event_count = state->resp->info_3.fifo_max_event_count;
> >>>>  		}
> >>>>  		for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
> >>>>  			state->frequencies[2 * i] = frequencies[i] / 1000;
> >>>>       
> >>  
> >   

