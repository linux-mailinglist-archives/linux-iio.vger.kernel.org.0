Return-Path: <linux-iio+bounces-21842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE8AB0CAEF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 21:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868E21AA7ED3
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38F225403;
	Mon, 21 Jul 2025 19:21:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F44DDBC
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125666; cv=none; b=rr/ysLW4ij7IiN5NwHa7nzU4eD7S4RHrFMLhDDzcPgGJ83/TPsEQkSBrivtQ5oST8ca44d77UYHVxmW4YbhLxqyOA7Tpmfy1RZMoGBE3HnXhOnPBlx7i+n8qj+vS0Oos53pCO4jJvfYLBC6zt9XOLLbrFlB1J3puzCzO0k4JnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125666; c=relaxed/simple;
	bh=FuUxU7KA/YKC/6X74U9i3xvXMDeMXioXEmTB2nisevw=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=N3FZWlMZXhiuaJem86hU18qLc1wfH7R7eCZTdUpMHk6fjmwhfZNMQk/XIaKgDD5c0AK0/fe46Nbk6MajZPxYIwK7wd/jLiic3pbggI/5NgmXw1sJ0MwvSDYm85n/emD67L2T+ySehNM9hjUathI72J1nOrU98nd1DYAzjjLYcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1udvzN-0004sW-DN
	for linux-iio@vger.kernel.org; Mon, 21 Jul 2025 21:15:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Mon, 21 Jul 2025 21:15:47 +0200
Organization: Linux Private Site
Message-ID: <87o6tdwe1o.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20241017233022.238250-2-vassilisamir@gmail.com>
	<875xgfg0wz.fsf@Gerda.invalid>
	<c894cfda-a775-4598-ac3b-b3d35c6a84b3@baylibre.com>
	<87a55azgdr.fsf@Gerda.invalid> <875xfx8nx2.fsf@Gerda.invalid>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:P9NhDh5l2l+28Mp2KeNSOhcuqKg=

ASSI writes:
[…]

I've been running with this patch for two weeks now and even updated to
another kernel.  Unfortunately Tumbleweed does not provide the sysfs
trigger device, but I could enable a HRT trigger device via configfs.  I
did not get this to work however, for stzartes I have no diea if I need
to enable both the buffer and buffer0 provided via sysfs:

--8<---------------cut here---------------start------------->8---
/sys/bus/iio/devices/iio:device0/buffer:
data_available  direction  enable  length  watermark

/sys/bus/iio/devices/iio:device0/buffer0:
data_available  enable                  in_humidityrelative_index  in_pressure_en     in_pressure_type  in_temp_index  in_timestamp_en     in_timestamp_type  watermark
direction       in_humidityrelative_en  in_humidityrelative_type   in_pressure_index  in_temp_en        in_temp_type   in_timestamp_index  length
--8<---------------cut here---------------end--------------->8---

After setting up the trigger and enabling the channels in scan_elements
I ended up enabling both, which had the effect that the forced readings
via the processed endpoints stopped working for pressure and humidity
(which is probably because the channel config is left in that state
somehow), but no values were ever appearing at the /dev/iio0 endpoint
that got created.  I also didn't manage to disable the buffers again and
got an EBUSY instead.  I needed to remove the driver and re-insert it to
get out of this mode.  Anyway it seems I should not mix triggered and
forced operation anyway as it seems that triggered operation requires
the device to stay in normal mode.

I have one other idea to get back at the short(er) aquisition times I
had previously: since triggered and forced operation can't be mixed, it
would be possible to use the timestamp fields to record the last
aquisition, always aquire all channels and only actually force a new
measurement if some time has elapsed after that, like another full
measurement cycle time based on the current oversampling configuration.
THe other option would be to actually enable the sampling frequency
parameter that must be converted into a t_standby setting for the BMx280
devices, as hinted at in the header file, but not actually implemented
yet (or mis-use that field directly for the standby time).


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


