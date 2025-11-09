Return-Path: <linux-iio+bounces-26059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84DC43E84
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 14:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631893A9B6A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420B2F6933;
	Sun,  9 Nov 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJy4cR4J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E22E9EAD;
	Sun,  9 Nov 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762694813; cv=none; b=qWIVziIQ8DzFPZiH4Xh1SywGIyFOgYBVgUWoxwbzlFbzdZy8tC76odV6tOnlXd9UHf9XsmwIgaT0F6myXghQOAGMhb2C8LTbdmkuTKZRtIbB9z7K+JErQgljGF1P6HkitHZGpg7nBbvturyjY22CTwMNcju0tx1NZnpAXLYACow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762694813; c=relaxed/simple;
	bh=IUda8zNNMXVp7xJWxMaUMifTHdBiFeF3ML87rFUp4Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/P5rJtP4BmCvqof/qtte+5Vw2k3AOoeLRLANbLccQg/w0cDFjZ5srK/8oByikkvQ4TbFHCjLc+atSYealxw382BKV6ip0PloPDnzzuPWs52UApSxtvtu/NRDuw6oQdu2Bo8XQRk2FPJx2fMFiT6iV12lOvPnLeWcYx/KMFgdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJy4cR4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F429C19421;
	Sun,  9 Nov 2025 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762694813;
	bh=IUda8zNNMXVp7xJWxMaUMifTHdBiFeF3ML87rFUp4Ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sJy4cR4JcarB+ST0D41mdlj4zqYHkqcMMhq2W7xJMtuY3eSRPhFRzw6G876T/cJzk
	 FvE7+uE+C+yR/PBJOvJAF7YaidZaX1MHfKZqYaEUGwby5ZR/0PNUjtIHMxKMA1wJaD
	 G6vQJPvEgFV3pP2nGeoiJICSgUcnaYNPeYhayuEUGiXUHOiyRbByp27EOHzvCObOiS
	 sbOrc8MpFMN4Rv0WoZmMEJYJnLDzAr4/7eLRKqD77ZpOu/w8ZLB+m5KTiKZ/wu/B88
	 sPjKulUqLgA6gpYrPVR029HEnodYw0eg2R8yXdj2afdszfeOHLwHPOWvNvPgVAgd/0
	 wvOsCuRP9CFBA==
Date: Sun, 9 Nov 2025 13:26:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Pei Xiao <xiaopei01@kylinos.cn>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3] iio: adc: at91-sama5d2_adc: Fix potential
 use-after-free in sama5d2_adc driver
Message-ID: <20251109132646.308c7126@jic23-huawei>
In-Reply-To: <cbd2f040-9377-4862-ae52-aac35adb1b9d@linaro.org>
References: <90dec520a9537af2feab9d56b22d99878fba9e2a.1761705396.git.xiaopei01@kylinos.cn>
	<20251102115458.4d37556a@jic23-huawei>
	<cbd2f040-9377-4862-ae52-aac35adb1b9d@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 16:24:07 +0200
Eugen Hristev <eugen.hristev@linaro.org> wrote:

> On 11/2/25 13:54, Jonathan Cameron wrote:
> > On Wed, 29 Oct 2025 10:40:16 +0800
> > Pei Xiao <xiaopei01@kylinos.cn> wrote:
> >   
> >> at91_adc_interrupt can call at91_adc_touch_data_handler function
> >> to start the work by schedule_work(&st->touch_st.workq).
> >>
> >> If we remove the module which will call at91_adc_remove to
> >> make cleanup, it will free indio_dev through iio_device_unregister but
> >> quite a bit later. While the work mentioned above will be used. The
> >> sequence of operations that may lead to a UAF bug is as follows:
> >>
> >> CPU0                                      CPU1
> >>
> >>                                      | at91_adc_workq_handler
> >> at91_adc_remove                      |
> >> iio_device_unregister(indio_dev)     |
> >> //free indio_dev a bit later         |
> >>                                      | iio_push_to_buffers(indio_dev)
> >>                                      | //use indio_dev
> >>
> >> Fix it by ensuring that the work is canceled before proceeding with
> >> the cleanup in at91_adc_remove.
> >>
> >> Fixes: 3ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")  
> > This ID doesn't exist in my history  it should be
> > 23ec2774f1cc
> > 
> > I'll fix that up whilst applying.  Ideally I'd like Eugen to take a look
> > but I'm fairly confident so I'll queue this up on the fixes-togreg branch
> > of iio.git and mark it for stable.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > 
> >   
> >> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> >> ---
> >> changlog in v3: move cancel_work_sync after iio_device_unregister
> >> changlog in v2: use correct Fix id
> >> ---
> >>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >> index b4c36e6a7490..aa4ba3f5a506 100644
> >> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >> @@ -2481,6 +2481,7 @@ static void at91_adc_remove(struct platform_device *pdev)
> >>  	struct at91_adc_state *st = iio_priv(indio_dev);
> >>  
> >>  	iio_device_unregister(indio_dev);
> >> +	cancel_work_sync(&st->touch_st.workq);  
> 
> Hi Jonathan,
> 
> Can we push to buffers *after* device was unregistered with
> iio_device_unregister() ? Is that right ? Both Pei and I considered it's
> not.
I started answering this confidently with 'sure that's fine' then got
less confident as I tried to show that :(

iio_buffer_deactivate_all() should have removed all the buffers from
the list that iio_push_to_buffers() walks to find out what buffers are
registered.  So it should end up as a noop after iio_device_unregister()

That call is made from iio_disable_all_buffers() in iio_device_unregister()

It's worth checking there are no races if we end up with work whilst
the unregister is ongoing. That I'm rather doubtful about having looked
at this code for first time for a long while. The removal is under the
info_exist_lock but the walk of the buffers in iio_push_to_buffers isn't.

My first instinct is we should have a specific lock to protect the buffer
list against concurrent accesses but that is messy.  We might be able to
use the existence lock for that. (info_exist_lock) + a check on
indio_dev->info (for consistency with the meaning of that lock rather than
anything else as the buffers are actually removed just before that is set null).

Before posing a patch though I'd like a few more eyes on this.

Completely untested potential fix:
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f1448ae1b843..ab76fc25c3b5 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2382,6 +2382,10 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
        int ret;
        struct iio_buffer *buf;
 
+       guard(mutex)(&iio_dev_opaque->info_exist_lock);
+       if (!indio_dev->info)
+               return -ENODEV;
+
        list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {
                ret = iio_push_to_buffer(buf, data);
                if (ret < 0)



Thanks,

Jonathan



> 
> Eugen
> 
> 
> 
> >>  
> >>  	at91_adc_dma_disable(st);
> >>    
> >   
> 
> 


