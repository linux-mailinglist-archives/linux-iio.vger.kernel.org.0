Return-Path: <linux-iio+bounces-21090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C5AECA0F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 21:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E99179747
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407024728A;
	Sat, 28 Jun 2025 19:35:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85F1C8626
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751139314; cv=none; b=cMBz9DYASinghx/2lEHOgYKidE5+gC8bW0RWNcbPK6hNg4WoYTaeAPEwWROo720BelrWjsCrxV0+AGemvERK1ilDapxJYJAkzwcREwhTxjWmJquLtH0hxHFi1KO4IypfkW9KB1zgAQXXqsWjEVcFJc1hkurofZO3kprLDRPh9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751139314; c=relaxed/simple;
	bh=YrJECCAUcfunmcTIEOixAMo+n7jI+zKxUE0DejEcomo=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=g6bWQxqThvcm51QY2o6/OjzyUhz4NFGl6k34QxICZhR2kG9Qqick+Ogpjm4tZjOvsHXd++X2FRZLBaSp1bZ9udZ6P568OWEqUCe5hG3KnzoNR+gQXikvulc13RdGgqs4BQ/SvmbaHKnmySTN7ePSY3pFeLQGT9hhkLzj4Mxbkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1uVbKH-0002ow-Ty
	for linux-iio@vger.kernel.org; Sat, 28 Jun 2025 21:35:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Sat, 28 Jun 2025 20:45:48 +0200
Organization: Linux Private Site
Message-ID: <875xgfg0wz.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20241017233022.238250-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:GuoS7f7jcTTotadtBKjs4he9WfU=

Vasileios Amoiridis writes:
> The idea is that the sensor is by default in sleep mode, wakes up in
> forced mode when a oneshot capture is requested, or in normal mode
> when the buffer is enabled. The difference lays in the fact that in
> forced mode, the sensor does only one conversion and goes back to sleep
> while in normal mode, the sensor does continuous measurements with the
> frequency that was set in the ODR registers.
>
> The bmpX_chip_config() functions which are responsible for applying
> the requested configuration to the sensor, are modified accordingly
> in order to set the sensor by default in sleep mode.

Since this change went into 6.13, I've been unable to update the kernel
since it breaks usermode quite badly for me.  I am using sysfs to read a
BME280 sensor every second (oversampling is set to 1, so there should be
no trouble at all to read at that rate) and most of the time the
measurement doesn't complete and I get back an error message instead of
the expected reading.  The journal is full of these:

Jun 28 08:19:16 Otto kernel: bmp280 1-0076: Measurement cycle didn't complete.
Jun 28 08:19:16 Otto kernel: bmp280 1-0076: Measurement cycle didn't complete.
Jun 28 08:19:16 Otto kernel: bmp280 1-0076: Measurement cycle didn't complete.

The exact same thing happens if I stop the process that's reading the
sensor every second and do a manual read at much longer intervals, so
it's indeed not the read rate, but rather that the driver apparently
doesn't wait long enough for the measurement to complete.  There is an
indication that the wait time is just slightly too short as I have a
somewhat higher success rate at reading every second when the load is
higher.  Addtionally the read time for all three values from the sensor
went from ~7ms to ~28ms with much stronger tailing to longer read times
than before.  This sensor is in daisy-chain with a DS3231M RTC and hangs
off the DDC of the unsused VGA port provided by an Intel IGP.

I've not found a way to switch the operations mode via sysfs and/or
enable the ring buffer, which may or may not solve the problem depending
on which mode is used when the trigger arrives.  That's mainly because I
couldn't find a complete example of how to use this facility and I've
likely done some of the steps in the wrong order or missed one.  I've
enabled the scan elements, but trying to enable the buffer tells me
"write error: Invalid argument".  For starters, the system I'm on
(openSUSE Tumbleweed) doesn't seem to have IIO trigger support enabled
via either configfs or sysfs.  But in any case I think oneshot capturing
from userland should still work, I just haven't found out how.

So is there some description of how to get the sysfs functionality as
before and/or switch the operations mode to avoid this failure?  The
easiest would be if the BME280_MEAS_OFFSET value was configurable, but
it's a #DEFINE at the moment.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


