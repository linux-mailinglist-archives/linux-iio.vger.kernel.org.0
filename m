Return-Path: <linux-iio+bounces-22534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3946B1FBD7
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 21:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFB317376A
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC351EE019;
	Sun, 10 Aug 2025 19:01:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAC19DF9A
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852496; cv=none; b=TjvWcppuNF7Zrwqw4ecrx9aU+kg+HjeopzrWZltDpHVCPbiuklYHy5hrNhUQDfBS5+XZpQ3JkB4We3hJTpzKGbfO+9M64lefo/tpNEoubGVDw1uZH47eU5fj5wwWgZM5UIHjL6XO+Iz/4ADdajsBE33UX8RuqwKRj1W7GNpaHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852496; c=relaxed/simple;
	bh=YCJJAH3Sh78h82k/yvI6YnGqxTuo8mRiMEMnXlCEQGE=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=gwCY8QnKbe/HKHOMFzXlfFu8JIg8WhLQNh3vm8lAY37a2nyje5JF6tY3hEyYWuuF/uPGKI/ZB32snQ56PcG66dFfmlRknKbXAmzADmxLAbQ2E7PMtiRFvbMooM381pY/8pp7CxrhfMWFBoHAkWadyLgdM0wVgvW5Ez2tWOujpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ulBIQ-0003Su-85
	for linux-iio@vger.kernel.org; Sun, 10 Aug 2025 21:01:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings for BMx280
Date: Sun, 10 Aug 2025 21:01:24 +0200
Organization: Linux Private Site
Message-ID: <87bjonf1bv.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
	<20250810191338.12b568df@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:uNNTB0y3Qp48WcauGNSrvvn3wjI=

Jonathan Cameron writes:
> On Sun,  3 Aug 2025 16:08:00 +0200
> Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:
>
>> These devices were using a hardcoded IIR filter of length 4.  Enable
>> filter_low_pass_3db_frequency settings to control the filter length
>> settings of the device (as done already for the BMx380 and BMx580
>> devices, even though the 3dB corner has an inverse relation to the
>> filter length).  Remove an offset of 1 from the internal handling of
>> the available values.
>
> This confuses me.  Are we saying those other devices have a 3db frequency
> control that is not obeying the ABI? If so that sneaked in past me but
> please don't continue that (and we should fix that broken use of the ABI).

This is correct.  The attribute directly controls the tap length of the
filter and more taps means lower 3dB corner frequency.  Besides, it
isn't easy to even figure out what the corner frequency is, since it
depends both on further settings of the device (provided you want the
actual corner frequency and not one that's normalized to the sampling
frequency) and the internal IIR equation, although you could sort of
reverse engineer it from the step response graph in the datasheet since
it's unlikely to be something complex.  I've had a brief look, but there
doesn't appear to be a more appropriate attribute that could be used
within the IIO framework, like timeconstant / tau maybe?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


