Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F263634CE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhDRLUE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDRLUE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 07:20:04 -0400
X-Greylist: delayed 251 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Apr 2021 04:19:36 PDT
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E6C06174A;
        Sun, 18 Apr 2021 04:19:36 -0700 (PDT)
Received: from [81.101.6.87] (port=47136 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1lY5OW-0003OH-Ei; Sun, 18 Apr 2021 12:15:17 +0100
Date:   Sun, 18 Apr 2021 12:15:43 +0100
From:   Jonathan <jic23@jic23.retrosnub.co.uk>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Return error for
 hid_set_field() failure
Message-ID: <20210418121519.69588c2b@jic23-huawei>
In-Reply-To: <20210418121244.7e26914b@jic23-huawei>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
        <20210418121244.7e26914b@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Apr 2021 12:12:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 15 Apr 2021 11:52:31 -0700
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > In the function sensor_hub_set_feature(), return error when hid_set_field()
> > fails.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>  
> Series applied to the to greg branch of iio.git.  Note these won't make the
> coming merge window, so will turn up in next sometime after rc1.
And dropped again. Not enough caffeine today. Not in IIO obviously so instead:

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
for both patches.

> 
> thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/hid/hid-sensor-hub.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> > index 3dd7d3246737..f9983145d4e7 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -210,16 +210,21 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> >  	buffer_size = buffer_size / sizeof(__s32);
> >  	if (buffer_size) {
> >  		for (i = 0; i < buffer_size; ++i) {
> > -			hid_set_field(report->field[field_index], i,
> > -				      (__force __s32)cpu_to_le32(*buf32));
> > +			ret = hid_set_field(report->field[field_index], i,
> > +					    (__force __s32)cpu_to_le32(*buf32));
> > +			if (ret)
> > +				goto done_proc;
> > +
> >  			++buf32;
> >  		}
> >  	}
> >  	if (remaining_bytes) {
> >  		value = 0;
> >  		memcpy(&value, (u8 *)buf32, remaining_bytes);
> > -		hid_set_field(report->field[field_index], i,
> > -			      (__force __s32)cpu_to_le32(value));
> > +		ret = hid_set_field(report->field[field_index], i,
> > +				    (__force __s32)cpu_to_le32(value));
> > +		if (ret)
> > +			goto done_proc;
> >  	}
> >  	hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
> >  	hid_hw_wait(hsdev->hdev);  
> 

