Return-Path: <linux-iio+bounces-6034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7AE900B6B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE71C21DCE
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8719AA61;
	Fri,  7 Jun 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2ngdEcA"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40B13793E
	for <linux-iio@vger.kernel.org>; Fri,  7 Jun 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782148; cv=none; b=UIMNeoe9mgPZzx9W9A6P7B61MDg03PzztqFAV7fotHmKPkNJx/H5fHcP6Uz9z3OLmRQ6AlqidaNGun45Dt1JXjJmEcx5RR4Uv/cH6JdRqZC1D808Rd6miUZ7hlAzPrjSXV7aOL3lUsyXkSGlC1W0JryHpOGyoRaOj5WzCt/WPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782148; c=relaxed/simple;
	bh=bynN+NIib0bsQeGI5MBVBUe5uLLp5OUgxGpwwLregvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liUN5WTUBstyC9EtBKV3cGwlInPVhNkDS9ZB1jekSl/AalC0VMKRep+1Xsn7VO0EpyaoJPUwSROsxBIzLeH/lluD4FsRNWJXHWzNdnSjt8YsUrB69bZyCBh91xODbZpwd89SNZMV2Quq9jPrxBq8gTcjnOJYSK/in4F62gM28tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2ngdEcA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jonathan.cameron@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717782143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JG4OCpshlDYBrblK4di3ak7i8MvX6N4evo+AfyS3qVs=;
	b=t2ngdEcATktXj3Beb0DzU1C5DaDFbWjVmCjwBUckRR0x7sE7ZgVJwmNYA4fGBjCWtrp6OC
	B0WF+0ENNWplZ7r1u20xojHOroKJj565uNQEMYcU45Y0xHHjqQSHPaJDtwsBjhArM3zZi1
	Do05WQ6ZeEu1UAWQs3xjmo/rjo0Gz8g=
X-Envelope-To: jic23@kernel.org
X-Envelope-To: conall.ogriofa@amd.com
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lars@metafoo.de
Message-ID: <f789d5b8-46d4-47ab-a74b-72daf72116a0@linux.dev>
Date: Fri, 7 Jun 2024 13:42:19 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 "O'Griofa, Conall" <conall.ogriofa@amd.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
 <20240314154824.37150a54@jic23-huawei>
 <a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
 <DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
 <3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
 <20240316133627.5d2bf585@jic23-huawei>
 <7ee83f15-88fc-4530-84b7-b8ee31663dbc@linux.dev>
 <20240318152446.00001345@Huawei.com>
 <7ddf8d4a-5b68-432d-93c1-ff270403cb60@linux.dev>
 <20240319134258.0000574d@Huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240319134258.0000574d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/19/24 09:42, Jonathan Cameron wrote:
> On Mon, 18 Mar 2024 11:28:49 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> On 3/18/24 11:24, Jonathan Cameron wrote:
>> > On Mon, 18 Mar 2024 11:18:43 -0400
>> > Sean Anderson <sean.anderson@linux.dev> wrote:
>> >   
>> >> On 3/16/24 09:36, Jonathan Cameron wrote:  
>> >> > On Fri, 15 Mar 2024 13:47:40 -0400
>> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
>> >> >     
>> >> >> Hi Conall,
>> >> >> 
>> >> >> On 3/15/24 09:18, O'Griofa, Conall wrote:    
>> >> >> > [AMD Official Use Only - General]
>> >> >> > 
>> >> >> > Hi,
>> >> >> > 
>> >> >> > I think there was a fix for this issue applied to the version that was running on 5.15 that didn't seem to make it into the upstream driver.
>> >> >> > Please see link for reference https://github.com/Xilinx/linux-xlnx/commit/608426961f16ab149b1b699f1c35f7ad244c0720
>> >> >> > 
>> >> >> > I think a similar fix to the above patch is may be beneficial?      
>> >> >> 
>> >> >> These patches look functionally identical to me.    
>> >> > 
>> >> > Because there are no channels with scan index between
>> >> > 22 * 2 + 16 (that patch) and 22 * 3 (your patch) that is
>> >> > the effect is indeed the same. But given the issues is the
>> >> > 64 limit on maximum scan index, 22 * 3 = 66 is an ugly value
>> >> > to compare with.
>> >> > 
>> >> > I'm still very against the use of scan_index for anything other
>> >> > than scan indices (which is why partly how this bug wasn't noticed
>> >> > in the first palce). So the check should be scan_index != -1
>> >> > and uses of those values elsewhere in the driver should be fixed
>> >> > (which looks simple to do from a quick glance at the code).    
>> >> 
>> >> OK, so how do the sysfs files get named then?  
>> > 
>> > Using channel and channel2 as appropriate (+ index and modified
>> > which change the meaning of channel2) - scan_index never had
>> > anything to do with sysfs file names - just the value in
>> > bufferX/in_xyz_scan_index  
>> 
>> I tried to prototype setting scan_index to -1, but when registering channels I saw
>> 
>> [    1.637049] iio iio:device0: tried to double register : in_voltage_raw
>> [    1.637245] xilinx-ams ffa50000.ams: Failed to register sysfs interfaces
>> [    1.637433] xilinx-ams: probe of ffa50000.ams failed with error -16
>> 
>> And AIUI .channel is filled in by ams_parse_firmware.
> 
> Is indexed set for the channel?  Check it at the point of calling
> devm_iio_device_register() as the code that builds the channels in this
> driver is complex, so maybe it's getting overwritten?
> 
> There might be a core bug somewhere, but there are other drivers using
> -1 scan index without hitting this problem so my first instinct is
> something is getting wrongly set in the driver.

Upon further review, I think scan_index should remain the same, and this
patch should be applied as-is.

address is the only driver-private data in all of iio_chan_spec.
Unfortunately, it is suggestively named "address" and not "priv" or
"driver_id" or something similar. So the original author of this driver
went "Ah, I should put the channel address offsets in this register."
Except, because this driver has three address spaces, this is not enough
to uniquely identify the channel. So he then stuck an actual unique
identifier in scan_index. Now, you may object to this since the driver
doesn't actually support scans, but that is the current situation.

So there is really nothing wrong with scan_index semantically in the
context of the driver. We should not convert one address space's
channels to use -1 scan_index, since it is used as a unique identifier
elsewhere in the channel.

Future patches could convert scan_index to address, and store the
address offsets in an array. So e.g. reading a channel would go from
e.g.

	if (chan->scan_index >= AMS_PS_SEQ_MAX)
		*val = readl(ams->pl_base + chan->address);
	else
		*val = readl(ams->ps_base + chan->address);

to

	if (chan->address >= AMS_PS_SEQ_MAX)
		*val = readl(ams->pl_base + ams_chan_addr[chan->address]);
	else
		*val = readl(ams->ps_base + ams_chan_addr[chan->address]);

which while strictly less perfmant due to another level of indirection
does conform to existing semantics for scan_index. But TBH I don't see
much point in this.

But the above change would be pretty significant and has a chance of
causing bugs of its own. So I would rather this bug fix be applied as-is
and the scan_index semantics be modified at some other time.

--Sean

>> 
>> --Sean
>> 
>> >> 
>> >> --Sean
>> >>   
>> >> >> 
>> >> >> --Sean
>> >> >>     
>> >> >> >> -----Original Message-----
>> >> >> >> From: Sean Anderson <sean.anderson@linux.dev>
>> >> >> >> Sent: Thursday, March 14, 2024 5:30 PM
>> >> >> >> To: Jonathan Cameron <jic23@kernel.org>
>> >> >> >> Cc: linux-iio@vger.kernel.org; O'Griofa, Conall <conall.ogriofa@amd.com>;
>> >> >> >> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Lars-Peter
>> >> >> >> Clausen <lars@metafoo.de>
>> >> >> >> Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
>> >> >> >> scan_mask
>> >> >> >>
>> >> >> >> Caution: This message originated from an External Source. Use proper caution
>> >> >> >> when opening attachments, clicking links, or responding.
>> >> >> >>
>> >> >> >>
>> >> >> >> On 3/14/24 11:48, Jonathan Cameron wrote:      
>> >> >> >> > On Mon, 11 Mar 2024 12:28:00 -0400
>> >> >> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
>> >> >> >> >      
>> >> >> >> >> ams_enable_channel_sequence constructs a "scan_mask" for all the PS
>> >> >> >> >> and PL channels. This works out fine, since scan_index for these
>> >> >> >> >> channels is less than 64. However, it also includes the
>> >> >> >> >> ams_ctrl_channels, where scan_index is greater than 64, triggering
>> >> >> >> >> undefined behavior. Since we don't need these channels anyway, just      
>> >> >> >> exclude them.      
>> >> >> >> >>
>> >> >> >> >> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
>> >> >> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>      
>> >> >> >> >
>> >> >> >> > Hi Sean,
>> >> >> >> >
>> >> >> >> > I'd ideally like to understand why we have channels with such large
>> >> >> >> > scan indexes.  Those values should only be used for buffered capture.
>> >> >> >> > It feels like they are being abused here.  Can we set them to -1
>> >> >> >> > instead and check based on that?
>> >> >> >> > For a channel, a scan index of -1 means it can't be captured via the
>> >> >> >> > buffered interfaces but only accessed via sysfs reads.
>> >> >> >> > I think that's what we have here?      
>> >> >> >>
>> >> >> >> From what I can tell, none of the channels support buffered reads. And we can't
>> >> >> >> naïvely convert the scan_index to -1, since that causes sysfs naming conflicts
>> >> >> >> (not to mention the compatibility break).
>> >> >> >>      
>> >> >> >> >
>> >> >> >> > I just feel like if we leave these as things stand, we will get bitten
>> >> >> >> > by similar bugs in the future.  At least with -1 it should be obvious why!      
>> >> >> >>
>> >> >> >> There are just as likely to be bugs confusing the PL/PS subdevices...
>> >> >> >>
>> >> >> >> FWIW I had no trouble identifying the channels involved with this bug.
>> >> >> >>
>> >> >> >> --Sean
>> >> >> >>      
>> >> >> >> > Jonathan
>> >> >> >> >
>> >> >> >> >      
>> >> >> >> >> ---
>> >> >> >> >>
>> >> >> >> >>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
>> >> >> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> >> >> >> >>
>> >> >> >> >> diff --git a/drivers/iio/adc/xilinx-ams.c
>> >> >> >> >> b/drivers/iio/adc/xilinx-ams.c index a55396c1f8b2..4de7ce598e4d
>> >> >> >> >> 100644
>> >> >> >> >> --- a/drivers/iio/adc/xilinx-ams.c
>> >> >> >> >> +++ b/drivers/iio/adc/xilinx-ams.c
>> >> >> >> >> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(struct
>> >> >> >> >> iio_dev *indio_dev)
>> >> >> >> >>
>> >> >> >> >>      /* Run calibration of PS & PL as part of the sequence */
>> >> >> >> >>      scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
>> >> >> >> >> -    for (i = 0; i < indio_dev->num_channels; i++)
>> >> >> >> >> -            scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
>> >> >> >> >> +    for (i = 0; i < indio_dev->num_channels; i++) {
>> >> >> >> >> +            const struct iio_chan_spec *chan =
>> >> >> >> >> + &indio_dev->channels[i];
>> >> >> >> >> +
>> >> >> >> >> +            if (chan->scan_index < AMS_CTRL_SEQ_BASE)
>> >> >> >> >> +                    scan_mask |= BIT_ULL(chan->scan_index);
>> >> >> >> >> +    }
>> >> >> >> >>
>> >> >> >> >>      if (ams->ps_base) {
>> >> >> >> >>              /* put sysmon in a soft reset to change the sequence */      
>> >> >> >> >      
>> >> >>     
>> >> >     
>> >> 
>> >>   
>> >   
>> 
> 

