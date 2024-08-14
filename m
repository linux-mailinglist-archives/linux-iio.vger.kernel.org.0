Return-Path: <linux-iio+bounces-8482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060AA9525D7
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 00:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A01F2220F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E15814AD0C;
	Wed, 14 Aug 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1mxqjgF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DE14A609
	for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674956; cv=none; b=ESf9Hm0oJZN/U1IuGk/N5kObLmDccmKLRG1mQjOol3i8TurAyNXz2TsaW4zipuWNvjZ2nkTEdX+zfJyazcb3Px3VhaRwpoKBOUHzXC+Kg+j0fKoKHOnNLQHz2ILv7XfiE6Daw0TO2NuXLWmrwLgINdI7BNjfqJ188FclyteNopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674956; c=relaxed/simple;
	bh=lcE+mG8oioX/deiJU5iSTHkmg+nPcerAfcmQeWQY3Bg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OYvgQTQn7/7xH6iXCrQdHeTku1p6bquaU5lBTFpUZ5SeaVGPpCy9GomCGYqx9b9Xysw6f6n8wvMLcrr8yw/RsyV43EAW9PZ3asY7kEEY+dkbla+Ph7RXqdc7lrZP/yIi6/o1jBEkQJdZKOGI3m/Z0uxjqh6xF4vBLDiJMlYucLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1mxqjgF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690ad83d4d7so4250737b3.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 15:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723674953; x=1724279753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CP9zmZvkEzLf5p4C1wZ5Sz29Lvl3YrjSAdmC+rZSPDU=;
        b=i1mxqjgF6DnlUK6BCnQt4s0kcabJRUNGP870pa8YFzTA9RRY1A2fWknN7JWU7BSG0o
         yiGRSPr39gFklcoS4mAE/uwjDRCIpxvcicordD84w8PZLMcdb1d2b9eaSgOjud5ak5wX
         O0X5BhG+xMX+SAZnaG6wsE/ctqSHgWXPJLZpNBkhvewfXnuyEAeObD+Rs/07GoeqC9J1
         w9GA51tSAuOxqSA6Icik/gtvur50reoLYFDxySzZy5B+LQ2icmIg/saSS9YIi457Syu2
         Oyr8WIfmrfmQNKXDpiMJvc3jADYm2VifsIM0ZtUJrDr/hfpob5I/Pe1goODFHu0DLrU/
         DHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723674953; x=1724279753;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CP9zmZvkEzLf5p4C1wZ5Sz29Lvl3YrjSAdmC+rZSPDU=;
        b=rEV2NO6ikaFyV0qWnHuH1zgCk4iVZy6Nlg6sfCB294Jvu9oJUg67qTgEBpyeShZIVK
         ooguRy8svmoHnoiqjm/c/uO1pWorLB3IoQ/0iRjDsF7d8gLWEuXaN+RnMM5B3rrutaOe
         VqyFi38jB0+wv2zndqRf+rAb0ctKPWnOKJW04uI1lcpQJnGEnktACoe4cfVlyb28xTe+
         cKv4GJlaMdU4/xqgtui1XN2IAE1zyq4S6iaQItWvQHRnSLk/xaiyp0e7LRKF8xPzvxCe
         UHsdjDRKUETbIQn2/dLB+NKr6ED88HW6jLxM9iiD3LvH/jaiIg7pFbA//Ym+IX64gBBc
         LODg==
X-Gm-Message-State: AOJu0YwqUM2tsCyoTGyuJ2Mx53ddNKt4ducG1hNKzxwEqE9vAgYxSL6O
	ieELTpBSnbPhT0Zqm6qLdBtEKFEaX/IIxYY9Zu+0rLXAy4gila/nfmz1J1MtgZeZUli7yPxEJAI
	v+FRGRlb0W0UwSSFfrdX+UizeKqz/7QU3
X-Google-Smtp-Source: AGHT+IFoIxYDk92Ui3hh3LG4lafj1I84hxukPoQNg/5tl+KhhuRFhsIgCldY0773ZjsOTdfndTvTYF1mMc8/V1vLQRY=
X-Received: by 2002:a05:690c:6909:b0:6ad:7244:cf01 with SMTP id
 00721157ae682-6ad7244d03dmr35692967b3.45.1723674953452; Wed, 14 Aug 2024
 15:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 15 Aug 2024 00:35:17 +0200
Message-ID: <CAFXKEHYGHPjS1uh=+++SdYPg45H5VLnH6R6Y1Yb26kr9kOFsdQ@mail.gmail.com>
Subject: iio: accel: adxl345 - Questions on Implementation
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear IIO Community!

TL;DR: I have some general questions on implementing IIO. In
particular I'm playing with an accel driver. Feel free to answer.


Some months ago I was lucky to contribute to the adxl345 accelerometer
driver. The driver has already an (older) implementation in in the
kernel's input system with more feature support, but most parameters
hardcoded. In the meanwhile I continued and managed to implement
somehow the ADXL345 FIFO usage, single tap, double tap,
activity/inactivity, freefall, standby and low power modes, etc.
Basically most (almost all?) features available in the input driver,
but using the iio the features would be even configurable in sysfs.
Some points are still missing, though, such as adxl346 orientation
feature and for sure this is just my POC implementation which by far
would not match kernel quality at the current state.
I managed implementing / catching those events, with a kind of
my-understanding-of-IIO-implementation. I was not really able to find
much documentation. Most often I ended up reading through other
drivers and trying to understand how things were implemented there. My
frist approach then was to setup individual "_en" handles for every
feature in sysfs, and ignore most of the event/channel handling
(smile). When this worked I actually understood, that there is
"buffer". Then I got to understand a bit more of "events" and so on
already providing things. I was in the second or third implementation.
I tried to interpret the results coming on /dev/iio:device0 using od
and xxd. This did not work for gesture events like tap events. By
chance I found there is already a tool for that: iio_event_monitor.
But this stayed simply mute when I wanted to see my FIFO data coming
in which worked before. Ugh..

I don't want to break up a long discussion, but some feedback on the
following questions of mine would be really, really highly
appreciate!!

1.) First of all, would there be a general interest to integrate
additional code into the iio/adxl345 driver? If ok, I would love to
prepare patch series on a per feature basis up for discussion to learn
and to get it matching your high quality standards.

2.) I assume the key motivation of the IIO events/channel approach is
to abstract sensor specific functionality to a general IIO/accel
functionality provided by sysfs in Linux. Do I understand this
correctly? So, no matter of the implementation, if a feature is
provided, SW can use that w/o knowing the underlying hardware and
datasheet in specific.

3.) If the above is true, where can I find the documentation of the
sysfs handles (other than testing/ABI, the iio header files,
interpretation of types and enums,...)? Which handles are possible is
all around? How can I use it? And so on? Is there a way to list
supported features for an iio device?

4.) My approach was to read through codes and do some creative
interpretation of namings. I have nothing against reading sources, but
in some cases this can be quite confusing. Even from a user's
perspective, e.g. the fifo watermark. Currently I know "watermark" for
a FIFO can be configured (if "buffer0" has been armed before with some
length), where hwfifo_watermark can never be configured. Currently I
understand: hwfifo_watermark is read-only. It reads back what is
configured in the HW and prints what the hwfifo eventually holds as
watermark. Is this a halfway correct interpretation of the
FIFO/watermark mechanism?
On the other hand, with my FIFO enabled and configured, e.g. to
watermark of 30 entries (then it triggers an interrupt, which I catch
and I yield the data). I can see hex data arriving at
/dev/iio:device0, which is nice. But checking with 'iio_event_monitor
/dev/iio:device0' I see nothing. Do I understand this wrong? They
should come as raw, of course I also could see the values e.g. in
/sys/bus/iio/..../in_accel_x_raw  - but I guess this is rather for
debugging. Where /dev/iio:device0 should bring up the bulk of scanned
values (here x,y,z and in case several FIFO entries of them). Or,
could someone please explain?

5.) In particular I have questions on the implementation ways, let's
take "single tap" as another example - Which is the better approach?
  A) do regmap_write() directly from write_event_value() using mutex
protection everywhere (I hope my assumption about usage of mutexes is
correctly here) - i.e. no matter if the sensor is currently running or
not, there can b e configuration, or
  B) init a variable in the driver data "singletap_en", and only write
all regs at postenable() w/o mutex then, i.e. when I do
buffer0/enable? - i.e. configuration only when the sensor is not
running
If I take the approach B, I fear I'm implementing the behavior
differently to other accelerometers. In other words, I feel it would
be better to implement uniform accelerometer behavior, or to document
it somewhere. Here I'm unsure, if this is ok or not? Another argument
for B) was that I guess many of the sensors must be put into
off/standby for configuration and turned on again. This comes
implicitely when connecting it to buffer0/enable.

7.) So far I managed to implement the following
 - Configuration of TAP_THRESHOLD register via IIO_EV_INFO_VALUE in
write_event_value()
 - Configuration of DURation register via IIO_EV_INFO_RESET_TIMEOUT in
write_event_value()
 - Configuration of a single tap enable field via a handle in
write_event_config()
In the postenable() I configure the interrupt by the state of the
enable field. Then I configure a buffer (256 to buffer0/length; 1 to
buffer0/in_accel_x_en), evntually echo 1 into buffer0/enable. I'm
watching using the iio_event_monitor on the /dev/iio:device0. I can
see gesture events. Is this a valid approach? For double tap the
datasheet additionally describes a "window" parameter to be
configured. But events does not seem to offer something like that.
Even the above approach e.g. "IIO_EV_INFO_RESET_TIMEOUT" and the
resulting handle in sysfs sounds quite different than "duration", and
is IMHO here also not very intuitive (duration IMHO would be easier to
understand, but ok). So what to do with a "window"? I might discuss
that also later when I present the code, perhaps would be easier to
follow.

Thank you so much if you read +/- up until here. I was told it is ok
to send my questions to IIO mailing list. So, I hope it was ok, and
the questions are not too obvious.

Best regards,
Lothar

