Return-Path: <linux-iio+bounces-21748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9EB08ECD
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573863A930F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8F1DE4E1;
	Thu, 17 Jul 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM/IWJ0U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA11F30CC;
	Thu, 17 Jul 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761089; cv=none; b=ekTzw43zUOllbsoIf07vOGlspBjjinw2CnNTfa9VtEfQBSCBZVU+XrkJp4IGfZSsDNypbFfkw3boSAxIUslk7iZgr0dhIbs0EQtwkiWMdOZPKZQl3UxhtloLLEDaGe+GnLzDt+Ro+I356QapOkGuVoMHdWNionbL5wz5PO3Ndi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761089; c=relaxed/simple;
	bh=msVQs06zIuZ5XvXpWG4z3A3jyJ/1JOfRCn79it95Tkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWVWpsBy99cssIKMruQBH7D8zYeyiQZ5gdV4XlQbanDtxwcijGoEEbjhrnDwg4S4FjR5GaRsJXLubqUhZ9bdzST2L2QVtjnMAz6Vg/e0vGlwZBEgn/mjPfUAZAPrRhZX0DqBVe90h65UXKIj7A9x5bFVvr4uI0Cn4v3Su3PQSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM/IWJ0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E95EC4CEE3;
	Thu, 17 Jul 2025 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752761088;
	bh=msVQs06zIuZ5XvXpWG4z3A3jyJ/1JOfRCn79it95Tkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oM/IWJ0UKqE1E4occ3WvDL82SEYWAqeaX1u6489spxPFDnspN+snFbBKz6WRToX+B
	 jVqWBLUlgx50YgKcfu03WSHS84pbRc0n/f934iQ0ulxii6HXNFtLOB/xYMbKSRm4ks
	 SZ8EP5Pr1R9btJ+LjoOSP8U75UQEEbuQfFt4gTyBXLg8q5VzbgiCe7g2j4uolxlGGL
	 +NIw+DD7bzib+/3WmmRwPdupbkOspBNTKuStfyVNvL97QAAoFyvNj0dIdlca6DcNZf
	 Og1H2+L3maFhGps4EFGVkBr7O/iLOUbnO+45Vnuf1zr1O9YdB1JWJnOZSM9senVzeN
	 3aw54WCCnfOTw==
Date: Thu, 17 Jul 2025 15:04:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
 <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
 <marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
 <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
 <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v3 2/2] iio: imu: smi330: Add driver
Message-ID: <20250717150440.5067862b@jic23-huawei>
In-Reply-To: <AM8PR10MB4721BAD5BD78B8FD0F5C9798CD57A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
	<20250706175328.7207d847@jic23-huawei>
	<AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250713144214.6ee02f59@jic23-huawei>
	<AM8PR10MB4721BAD5BD78B8FD0F5C9798CD57A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 18:35:48 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> Hi Jonathan,
> 
> as you suggested we just set available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 }; and push the whole buffer every time.
> We enable a subset (3 channels) from user space. This time the channel data is correct in iio buffer, nevertheless invalid timestamp.
> See test result inline
> 
> Best Regards
> Jianping
> 
> >>  
> >> >> +
> >> >> +static irqreturn_t smi330_trigger_handler(int irq, void *p) {
> >> >> +	struct iio_poll_func *pf = p;
> >> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> >> +	struct smi330_data *data = iio_priv(indio_dev);
> >> >> +	int ret, chan;
> >> >> +	int i = 0;
> >> >> +
> >> >> +	ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG, data-
> >> >>buf,
> >> >> +			       ARRAY_SIZE(smi330_channels));
> >> >> +	if (ret)
> >> >> +		goto out;
> >> >> +
> >> >> +	if (*indio_dev->active_scan_mask != SMI330_ALL_CHAN_MSK) {
> >> >> +		iio_for_each_active_channel(indio_dev, chan)
> >> >> +			data->buf[i++] = data->buf[chan];  
> >> >
> >> >If I follow this correctly you are reading all the channels and just
> >> >copying out the ones you want.  Just let the IIO core do that for you
> >> >by setting iio_dev-  
> >> >>available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 }; and push the
> >> >>whole  
> >> >buffer every time.  
> >>
> >> For the most frequent use cases, we define available_scan_masks = {  
> >SMI330_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK, SMI330_GYRO_XYZ_MSK,
> >0 }; and push the whole buffer every time.  
> >> From the user space we just enable 3 channels gyro_x, gyro_y, and gyro_z.  
> >Then we enable buffer and expect that only the gyro values and timestamp in
> >iio_buffer. Nevertheless, we have 3 accelerometer values and the timestamp in
> >iio_buffer.
> >  
> >> It seems that the iio core does not take care which channel is enabled,  just  
> >copy the first 3 values (acc x,y,z) into iio_buffer.  Our driver code still needs to
> >take care and just copy the enabled channel value to buffer.
> >
> >Look again at how it works.  If you provide ACC_XYZ_MSK, then your driver has
> >to handle it.
> >available_scan_masks is saying what your driver supports. The driver can check
> >active_scan_mask to find out what is enabled.  So right option here is only {
> >SMI330_ALL_CHAN_MSK, 0, }  In that case the driver never needs to check as
> >there is only one option.
> >
> >Then if any subset of channels is enabled the IIO core copy out just the data
> >that is relevant.
> >
> >  
> >>
> >> Another side effect after using available_scan_masks is that the  
> >active_scan_masks sometimes does not reflect current channel activation
> >status.  
> >>
> >> Is some step missing to properly use available_scan_masks ?  How can a user  
> >find out from user space which channel combination is defined in
> >available_scan_masks ?
> >
> >Why would userspace want to?  Userspace requested a subset of channels and
> >it gets that subset.  So it if asks for the channels that make up
> >SMI330_ACC_XYZ_MSK, if available_scan_mask == { SMI330_ALL_CHAN_MSK,
> >0 } then the IIO core handling selects SMI330_ALL_CHAN_MSK (smallest
> >available mask that is superset of what we asked for) and sets
> >active_scan_mask to that.  The driver follows what active_scan_mask specifies
> >and passes all channel data via the iio_push_to_buffers*() call. The demux in
> >the IIO core than takes that 'scan' and repacks it so that userspace receives just
> >the data it asked for formatting exactly as the driver would have done it if you
> >had handled each channels separately in the driver.
> >  
> 
> Set available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 } and push the whole buffer. iio_push_to_buffers_with_timestamp (indio_dev, data->buf, pf->timestamp);
> We enable the accX, accY, and accZ from userspace. And expect 3 acc values and the timestamp in iio buffer.
> 
> Raw iio buffer data:
> 00000000: 3c00 d6ff 7510 0000 6100 f3ff 0000 0000  <...u...a.......
            ACCX ACCY ACCZ PAD_ TIMESTAMP__________
				4093587712
> 00000010: 3f00 d2ff 8910 0000 0300 f6ff 0000 0000  ?...............
				4143907584
> 00000020: 4900 dcff 7a10 0000 caff 0100 0000 0000  I...z...........
				So this one looks bad.

> 00000030: 4c00 d9ff 7910 0000 2f00 f8ff 0000 0000  L...y.../.......
				4177473280

> 00000040: 4b00 d9ff 8410 0000 1f00 0800 0000 0000  K...............
				also bad.
> 00000050: 4700 daff 7f10 0000 3b00 eeff 0000 0000  G.......;.......
> 00000060: 3f00 d8ff 8410 0000 0c00 0900 0000 0000  ?...............
> 00000070: 4600 d9ff 8010 0000 0e00 0800 0000 0000  F...............
> 00000080: 4700 d7ff 7d10 0000 3400 feff 0000 0000  G...}...4.......
> 00000090: 4b00 d4ff 8010 0000 3e00 1200 0000 0000  K.......>.......
> 000000a0: 4600 d6ff 8d10 0000 4300 0000 0000 0000  F.......C.......
> 000000b0: 4900 d6ff 7710 0000 2500 f0ff 0000 0000  I...w...%.......
> 
> Converted value
I guess this is different data as doesn't seem to line up with the above?

> 0.015625 -0.009277 1.024411 589929
> 0.015869 -0.009521 1.040769 4294901719
> 0.020508 -0.008301 1.025632 458712
> 0.018799 -0.006836 1.032956 851960
> 0.019287 -0.009521 1.033201 4294836275
> 0.015625 -0.010498 1.031003 4293328982
> 0.015137 -0.010498 1.031980 4293853176
> 0.015869 -0.009521 1.031492 4293722141
> 0.018555 -0.011475 1.033445 4294311886
> 
> The 3 acc values is correct in buffer.  Nevertheless, invalid timestamp. The timestamp is actually the value of the gyroscope, which directly followed by acc values.
> If we enable the gyroX, gyroY, and gyroZ from userspace, then all the data is correct. Since the gyro values are the last 3 values and flowed by timestamp.

Ok. That's odd and we should debug that.  This code is used in a
lot of drivers so if it is not working correctly we need to figure
out why asap and fix it.

However, I'm not seeing what looks to be gyro data in bytes 8-15 etc
It isn't the stable sequence we'd expect for a timestamp though
some specific values might be plausible.

Looking again at the code, the IIO_DECLARE_BUFFER_WITH_TS()
is the wrong size.  That should not include channel space for
the timestamp. That should make it too big though which shouldn't be a problem.
Also wrong type - should be using __le16 not s16 for the buffer elements
given your channel declarations.

Please could you add a print to your code alongside the iio_push_buffer_with_timestamp()
to verify that the value in the pf->timestamp is reasonable looking for
a timestamp.

For reference this is the code that handles the timestamp entry creation
in the demux tables.
https://elixir.bootlin.com/linux/v6.15.1/source/drivers/iio/industrialio-buffer.c#L1086

Jonathan


> 
> Conclusion: Setting available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 }, the iio core is able to correct handle the enabled channel data, but not the timestamp.
> The working solution for now is that our driver takes care and just copys the enabled channel value to buffer without using available_scan_masks.
> 
> >So the aim is that userspace never knows anything about this.  Just set what
> >channels you want and get that data.
> >
> >Jonathan
> >
> >  
> >>  
> >> >
> >> >The handling the core code is reasonably sophisticated and will use
> >> >bulk copying where appropriate.
> >> >
> >> >If there is a strong reason to not use that, add a comment here so we
> >> >don't have anyone 'fix' this code in future.
> >> >  
> >> >> +	}
> >> >> +
> >> >> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
> >> >> +pf->timestamp);
> >> >> +
> >> >> +out:
> >> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> >> +
> >> >> +	return IRQ_HANDLED;
> >> >> +}  
> >>  
> 


