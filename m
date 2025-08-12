Return-Path: <linux-iio+bounces-22635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81399B2390C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF467A8F2E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C432EBBA7;
	Tue, 12 Aug 2025 19:34:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC2280324
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027292; cv=none; b=UZT5YHw43TCznTR1CKChLtH4vEOA4LG+nqNoqsSdn9xzt0kojrCrLCUypD8YA2lT5aSOvZKuy2Ry/7AwNgrZBwmdFiUq82RVw9HEh6s5S/0gV4dxQTImNRKOXM/3TWBKKvvopmVeEE0KgDHnLuntljppIDhDPf04Dc3mgDYJ7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027292; c=relaxed/simple;
	bh=C3QFOllIC6MGU4irbacZAhWM7p6JG4QjVOZgBJzwGUg=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=sWLHr8nOBBnIYAWlA1cNCb/f6inLLKWoFegZBAxj6+QRvIuHIR6cddj2RFcHBrpcsxIraelksJ+8MBYEZbcdgivrihJ00lvM5uwddgNZsvOqAnaGcmqEidJvKSUl9/fhT+KnLinUrUOP2np9mfOz3eVnF46UltMbB5j7/8CH9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ululc-0008Nl-U2
	for linux-iio@vger.kernel.org; Tue, 12 Aug 2025 21:34:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings for BMx280
Date: Tue, 12 Aug 2025 21:34:35 +0200
Organization: Linux Private Site
Message-ID: <87pld0nxkk.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
	<20250810191338.12b568df@jic23-huawei> <87bjonf1bv.fsf@Gerda.invalid>
	<20250811211423.3e52a67a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:T9K56iYqubII0TF94/bpyHIH8ys=

Jonathan Cameron writes:
> We stuck to 3DB point for these because all most anything else is annoyingly
> filter type dependent with no real consistency of meaning.  At least 3dB is
> something you can establish if you have a reasonable amount of info about the
> filter (or a plot!)

If you look at my .sig you might glean I probably know the odd thing or
two about filters… and 3dB frequency is just as meaningless without
knowing the filter type even before one enters into whether or not there
is peaking and resonance.

> Obviously they are almost always effected by sampling frequency so that maths
> can be rather non trivial.
>
> Vs a completely misleading tap length control, an approx 3dB eyeballed
> off a plot is an improvement. 

Donning my hat as a user: I beg to differ.  I know this device has 8
different settings for the tap length of some otherwise unspecified
filter (you can deduce that it must be a a recursive shift and
accumulate type thing) and more taps mean larger timeconstant / somewhat
better smoothing.  I really just want to chose among these eight
settings and not calculate a 3dB frequency that isn't in the datasheet
(and maybe even a different one depending on the four other three-bit
choices I have w.r.t. device settings).

I imagine the reason this particular device uses this attribute is
purely due to the fact that it was already available and corresponds
roughly to what the control does.

> Adding more filter parameters is likely to end up with a very complex
> userspace, so if we have any way to get an approx 3dB point, stick to
> that.

Filter settings: 0, 2, 4, 8, 16 (see datasheet, that's 2**i below)

That's the simplest I can think of, really.  Per the datasheet, the
actual filter is:

  y(t) = ( (y(t-1) << i) - y(t-1) + x(t) ) >> i
       = 2**-i * x(t) (2**i-1)*2**-i * y(t-1) )

The canonical recursive single-pole LP has two coefficients, which
should be 1-d and d (d because it's the sample decay).

   2**-i + (2**i-1)*2**-i = 2**-1 * ( 1 + 2**i - 1 ) = 1

so check that.  The time constant (rise time to 63%) is then

  tau = -1/ln(d)

Oddly enough the data sheet gives time to >75%, but that is just a
scaling factor of ln(0.25) on the tau.  The nomalized corner frequency then is:

  fc/fs = -ln(d)/(2pi)

So lets check that:

|---+--------+--------+--------+--------+-----------+----------|
| i |    1-d |      d |    tau |  t>75% | datasheet |    fc/fs |
|---+--------+--------+--------+--------+-----------+----------|
| 0 |      1 |      0 |    --- |    --- |         1 |        1 |
| 1 |    0.5 |    0.5 |  1.443 |  2.000 |     1.443 | 0.110318 |
| 2 |   0.25 |   0.75 |  3.476 |  4.819 |     3.476 | 0.045786 |
| 3 |  0.125 |  0.875 |  7.489 | 10.382 |     7.489 | 0.021252 |
| 4 | 0.0625 | 0.9375 | 15.495 | 21.481 |    15.495 | 0.010272 |
|---+--------+--------+--------+--------+-----------+----------|

> Been way to long since I last did any digital filter stuff, but poking google
> ai thing with "IIR filter y_t = (a -1)/a * y_(t-1) + x_t/a"
> came back with 3dB in digital angular frequency as
>
> w_c = arccos ((2a^2 - 2a - 1) / (2a(a - 1)) 
> Which might be right.

Given that it says w_c and said angular frequency, I'd wager a guess
that there's a factor 2pi that needs to go.  Yep, close enough
numerically.  Next time I'm bored I will whip out the trigonometric
identities table in Bronstein/Semendjajew and see why that arccos
espression is the same as -ln(d).

I'd still rather specify the filter as integers than having to enter
those floating-point numbers to get the device set up.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


