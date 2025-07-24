Return-Path: <linux-iio+bounces-21985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FD3B10E52
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C271CE5B81
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9D2E92DF;
	Thu, 24 Jul 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz5IHKWM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0B255240;
	Thu, 24 Jul 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369690; cv=none; b=eisGk37LrfJ+M5EnhyrrqwkfEWV5ISOfQDkR6EESvqzZpQcZQ2ZE8E+/29R0x0AAZAASL/+JD2mUof4iPqcUjslA7kqZBztAF3CJe2vgfIyISyCiK7sv0GL8yXJxax80lZH5+Iwq5WYSKw8IBqTPfbKVOdM3eZHrvikDGrRTrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369690; c=relaxed/simple;
	bh=KCHH0eMuDliYL38Oq6svSPAp5b03jXyE7QuDM0e08R8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFA0owq1EVMx7cbAB5eMKP8Tj43AlPE1Q6sYUhAoM53Qhs2B2IJze9lanQGjoC7/dQrm0zMfgVumnfGrZi4AU6fYgB6/H6Kz1BE+t82UC72rAZu2jXAbnnHyrfeYMoOA8/YTed5AG5YOW5qyhUCWmucL7/M+PbA/LvNuo42NufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz5IHKWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABACC4CEED;
	Thu, 24 Jul 2025 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753369689;
	bh=KCHH0eMuDliYL38Oq6svSPAp5b03jXyE7QuDM0e08R8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cz5IHKWMrwsai9HgTjCfdOBZ2GwjDCkhK5KrhJF3ZHmtk/n+8Z8xgf4RaW/pVWrBE
	 dRtOrObo7KzfknEu54vbj6ajX9Nmp11ObfDEALXOQxwJBOK2XeT2D9SfR1XP3gAZ4Y
	 6Ux5YVAF6Nmndi1H/mXZRUUVJ5wvsAJH0hQGIQVLuxKTkafQqJl/wBnP3wfZrcH90v
	 PqyxnT9K69j7fA7KdCXVE6Ep+zAi/I5OJLZwdCsnVL158aM5CGg/QR/2oUzNUbbxS8
	 MzxCl7VBcKtEMM9am16/bgoxS7ytOuAIGO+nDTCS0uW0OiYaJ5qMrxcafz/+283LtP
	 to54MUrMKe7UQ==
Date: Thu, 24 Jul 2025 16:07:59 +0100
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
Message-ID: <20250724160759.44d67e88@jic23-huawei>
In-Reply-To: <AM8PR10MB4721FB1A78F25B204BE3A26ACD5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
	<20250706175328.7207d847@jic23-huawei>
	<AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250713144214.6ee02f59@jic23-huawei>
	<AM8PR10MB4721BAD5BD78B8FD0F5C9798CD57A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250717150440.5067862b@jic23-huawei>
	<AM8PR10MB4721FB1A78F25B204BE3A26ACD5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 09:46:47 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> Hi Jonathan,
> 
> we find out the reason why the timestamp is invalid in the iio buffer.
> 
> https://elixir.bootlin.com/linux/v6.15.1/source/drivers/iio/industrialio-buffer.c#L1093
> 
> In "iio_buffer_update_demux" to copy the timestamp, the address calculation is the root causes.
> 
> 1083  in_loc += length;
> ....
> 1093  in_loc = roundup(in_loc, length);
> 
> When finish to copy the channel data, in_loc is just incremented and used as address of timestamp. This is correct only when the channel direct before timestamp is enabled.
> 
> If there is a gap between the last enabled channel and timestamp, then iio core will copy the wrong data.
> 
> We have a fix to this issue,
> 
> 1093 in_loc = (indio_dev->scan_bytes / sizeof(int64_t) - 1) * length;

That looks correct, but I'm not seeing why the roundup above doesn't land us
in the same place.  I'm not that keen on handling the timestamp even more differently
to other channels.


If we imagine an active scan with
2-byte chanel we want, 2 2-byte channels we don't a 2-byte gap and an 8-byte timestamp
struct scan {
	u16 wanted;
	u16 notwanted[2];
	... gap...
	aligned_s64 timestamp;
	


Cutting down to the parts that change in_loc only.

	for_each_set_bit(out_ind, buffer->scan_mask, masklength) {
		in_ind = find_next_bit(indio_dev->active_scan_mask,
				       masklength, in_ind + 1);
		while (in_ind != out_ind) {
... length is the length of current channel
.. We never enter here in the example.
			/* Make sure we are aligned */
			in_loc = roundup(in_loc, length) + length;

			in_ind = find_next_bit(indio_dev->active_scan_mask,
					       masklength, in_ind + 1);
		}

... length is the length of the current channel.  Get here on first hit.

		in_loc = roundup(in_loc, length);

		in_loc += length;
.. in loc = 2
	}
	/* Relies on scan_timestamp being last */
	if (buffer->scan_timestamp) {

... length is 8 ...

		in_loc = roundup(in_loc, length);
.. I think in_lock = 8?
		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);

	}

Perhaps you can talk through the example that is failing?

> 
> just not sure, if there will be any side-effects with this fix.
> 
> Are you going to fix this finding, or shall we create a new patch for that?

Fine to send the proposed fix but first we need to step through why the
current code isn't working.


Thanks,

Jonathan

> 
> Best regards
> Jianping Shen
> 
> 
> >>  
> >> >>  
> >> >> >> +
> >> >> >> +static irqreturn_t smi330_trigger_handler(int irq, void *p) {
> >> >> >> +      struct iio_poll_func *pf = p;
> >> >> >> +      struct iio_dev *indio_dev = pf->indio_dev;
> >> >> >> +      struct smi330_data *data = iio_priv(indio_dev);
> >> >> >> +      int ret, chan;
> >> >> >> +      int i = 0;
> >> >> >> +
> >> >> >> +      ret = regmap_bulk_read(data->regmap,  
> >SMI330_ACCEL_X_REG, data-  
> >> >> >>buf,
> >> >> >> +                             ARRAY_SIZE(smi330_channels));
> >> >> >> +      if (ret)
> >> >> >> +              goto out;
> >> >> >> +
> >> >> >> +      if (*indio_dev->active_scan_mask != SMI330_ALL_CHAN_MSK)  
> >{  
> >> >> >> +              iio_for_each_active_channel(indio_dev, chan)
> >> >> >> +                      data->buf[i++] = data->buf[chan];  
> >> >> >
> >> >> >If I follow this correctly you are reading all the channels and
> >> >> >just copying out the ones you want.  Just let the IIO core do that
> >> >> >for you by setting iio_dev-  
> >> >> >>available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 }; and push the
> >> >> >>whole  
> >> >> >buffer every time.  
> >> >>
> >> >> For the most frequent use cases, we define available_scan_masks = {  
> >> >SMI330_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK,  
> >SMI330_GYRO_XYZ_MSK,  
> >> >0 }; and push the whole buffer every time.  
> >> >> From the user space we just enable 3 channels gyro_x, gyro_y, and gyro_z.  
> >> >Then we enable buffer and expect that only the gyro values and
> >> >timestamp in iio_buffer. Nevertheless, we have 3 accelerometer values
> >> >and the timestamp in iio_buffer.
> >> >  
> >> >> It seems that the iio core does not take care which channel is
> >> >> enabled,  just  
> >> >copy the first 3 values (acc x,y,z) into iio_buffer.  Our driver code
> >> >still needs to take care and just copy the enabled channel value to buffer.
> >> >
> >> >Look again at how it works.  If you provide ACC_XYZ_MSK, then your
> >> >driver has to handle it.
> >> >available_scan_masks is saying what your driver supports. The driver
> >> >can check active_scan_mask to find out what is enabled.  So right
> >> >option here is only { SMI330_ALL_CHAN_MSK, 0, }  In that case the
> >> >driver never needs to check as there is only one option.
> >> >
> >> >Then if any subset of channels is enabled the IIO core copy out just
> >> >the data that is relevant.
> >> >
> >> >  
> >> >>
> >> >> Another side effect after using available_scan_masks is that the  
> >> >active_scan_masks sometimes does not reflect current channel
> >> >activation status.  
> >> >>
> >> >> Is some step missing to properly use available_scan_masks ?  How
> >> >> can a user  
> >> >find out from user space which channel combination is defined in
> >> >available_scan_masks ?
> >> >
> >> >Why would userspace want to?  Userspace requested a subset of
> >> >channels and it gets that subset.  So it if asks for the channels
> >> >that make up SMI330_ACC_XYZ_MSK, if available_scan_mask == {
> >> >SMI330_ALL_CHAN_MSK,
> >> >0 } then the IIO core handling selects SMI330_ALL_CHAN_MSK (smallest
> >> >available mask that is superset of what we asked for) and sets
> >> >active_scan_mask to that.  The driver follows what active_scan_mask
> >> >specifies and passes all channel data via the iio_push_to_buffers*()
> >> >call. The demux in the IIO core than takes that 'scan' and repacks it
> >> >so that userspace receives just the data it asked for formatting
> >> >exactly as the driver would have done it if you had handled each channels  
> >separately in the driver.  
> >> >  
> >>
> >> Set available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 } and push the
> >> whole buffer. iio_push_to_buffers_with_timestamp (indio_dev, data->buf, pf-
> >>timestamp); We enable the accX, accY, and accZ from userspace. And expect 3  
> >acc values and the timestamp in iio buffer.  
> >>
> >> Raw iio buffer data:
> >> 00000000: 3c00 d6ff 7510 0000 6100 f3ff 0000 0000  <...u...a.......  
> >            ACCX ACCY ACCZ PAD_ TIMESTAMP__________
> >                               4093587712  
> >> 00000010: 3f00 d2ff 8910 0000 0300 f6ff 0000 0000  ?...............  
> >                               4143907584  
> >> 00000020: 4900 dcff 7a10 0000 caff 0100 0000 0000  I...z...........  
> >                               So this one looks bad.
> >  
> >> 00000030: 4c00 d9ff 7910 0000 2f00 f8ff 0000 0000  L...y.../.......  
> >                               4177473280
> >  
> >> 00000040: 4b00 d9ff 8410 0000 1f00 0800 0000 0000  K...............  
> >                               also bad.  
> >> 00000050: 4700 daff 7f10 0000 3b00 eeff 0000 0000  G.......;.......
> >> 00000060: 3f00 d8ff 8410 0000 0c00 0900 0000 0000  ?...............
> >> 00000070: 4600 d9ff 8010 0000 0e00 0800 0000 0000  F...............
> >> 00000080: 4700 d7ff 7d10 0000 3400 feff 0000 0000  G...}...4.......
> >> 00000090: 4b00 d4ff 8010 0000 3e00 1200 0000 0000  K.......>.......
> >> 000000a0: 4600 d6ff 8d10 0000 4300 0000 0000 0000  F.......C.......
> >> 000000b0: 4900 d6ff 7710 0000 2500 f0ff 0000 0000  I...w...%.......
> >>
> >> Converted value  
> >I guess this is different data as doesn't seem to line up with the above?
> >  
> >> 0.015625 -0.009277 1.024411 589929
> >> 0.015869 -0.009521 1.040769 4294901719
> >> 0.020508 -0.008301 1.025632 458712
> >> 0.018799 -0.006836 1.032956 851960
> >> 0.019287 -0.009521 1.033201 4294836275
> >> 0.015625 -0.010498 1.031003 4293328982
> >> 0.015137 -0.010498 1.031980 4293853176
> >> 0.015869 -0.009521 1.031492 4293722141
> >> 0.018555 -0.011475 1.033445 4294311886
> >>
> >> The 3 acc values is correct in buffer.  Nevertheless, invalid timestamp. The  
> >timestamp is actually the value of the gyroscope, which directly followed by acc
> >values.  
> >> If we enable the gyroX, gyroY, and gyroZ from userspace, then all the data is  
> >correct. Since the gyro values are the last 3 values and flowed by timestamp.
> >
> >Ok. That's odd and we should debug that.  This code is used in a lot of drivers
> >so if it is not working correctly we need to figure out why asap and fix it.
> >  
> 
> 
> 
> 
> >However, I'm not seeing what looks to be gyro data in bytes 8-15 etc It isn't the
> >stable sequence we'd expect for a timestamp though some specific values
> >might be plausible.
> >
> >Looking again at the code, the IIO_DECLARE_BUFFER_WITH_TS() is the wrong
> >size.  That should not include channel space for the timestamp. That should
> >make it too big though which shouldn't be a problem.
> >Also wrong type - should be using __le16 not s16 for the buffer elements given
> >your channel declarations.
> >
> >Please could you add a print to your code alongside the
> >iio_push_buffer_with_timestamp() to verify that the value in the pf-  
> >>timestamp is reasonable looking for a timestamp.  
> >
> >For reference this is the code that handles the timestamp entry creation in the
> >demux tables.
> >https://elixir.b/
> >ootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Fdrivers%2Fiio%2Findustrialio-
> >buffer.c%23L1086&data=05%7C02%7CJianping.Shen%40de.bosch.com%7Cf0
> >9eaf03f8e44dd1e6fe08ddc53ae596%7C0ae51e1907c84e4bbb6d648ee5841
> >0f4%7C0%7C0%7C638883578931715207%7CUnknown%7CTWFpbGZsb3d8
> >eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> >oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=s53tTw6o%2F2guA
> >iH3J9jBRd0%2Bj6UmcmgyhtBCuKK1HE0%3D&reserved=0
> >
> >Jonathan
> >
> >  
> >>
> >> Conclusion: Setting available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 },  
> >the iio core is able to correct handle the enabled channel data, but not the
> >timestamp.  
> >> The working solution for now is that our driver takes care and just copys the  
> >enabled channel value to buffer without using available_scan_masks.  
> >>  
> >> >So the aim is that userspace never knows anything about this.  Just
> >> >set what channels you want and get that data.
> >> >
> >> >Jonathan
> >> >
> >> >  
> >> >>  
> >> >> >
> >> >> >The handling the core code is reasonably sophisticated and will
> >> >> >use bulk copying where appropriate.
> >> >> >
> >> >> >If there is a strong reason to not use that, add a comment here so
> >> >> >we don't have anyone 'fix' this code in future.
> >> >> >  
> >> >> >> +      }
> >> >> >> +
> >> >> >> +      iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
> >> >> >> +pf->timestamp);
> >> >> >> +
> >> >> >> +out:
> >> >> >> +      iio_trigger_notify_done(indio_dev->trig);
> >> >> >> +
> >> >> >> +      return IRQ_HANDLED;
> >> >> >> +}  
> >> >>  
> >>  
> 
> 


