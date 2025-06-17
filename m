Return-Path: <linux-iio+bounces-20735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6326ADC339
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 09:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53486170F3E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 07:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543428D8C1;
	Tue, 17 Jun 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDti9rqi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D11DE3DB;
	Tue, 17 Jun 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145331; cv=none; b=tf4YFZbZNxUA6S2MET70Fm8i3lrdp4E3xfsJKlEdVKmzsqavB4Ky/pzfGp32dcezoixHglr0kIXBC/B8nFvipbg99gGbhPBEocb52m58qoP9JBNAvvxAv8IQcD5xJ7CPEyvBXH/Wxnvb2JuDqTb4T0jcRnY2Dyxe11L67FWctqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145331; c=relaxed/simple;
	bh=WleSK7DiNaf8vP981UBeBFyPAv8jK6ZQbY3TxmW5+p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4GxLa4mt3SCxdsqIow4EEwdTJOxWobnkRiqv7NkcneVITPpaQHNk4IWThxFDwGGINSwtcTULpqMgHeh9cc4dwhIMfMNqxwAL5JVhzSN2yfnFxG914QfATpd0S/ezUzkJhmorvozS2ixdEQH7M6w+pu6WyGPgB15yBT5exABPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDti9rqi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71101efedabso4051707b3.2;
        Tue, 17 Jun 2025 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750145329; x=1750750129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xab3MFDMuD9rHO6XXeyxnkfZ49gl+eLAkhtogCCcKWU=;
        b=KDti9rqiP4uyQncoH9zGvOTHx87D7BJg0k4cM9abNdhggIqf8z5clhJhD2NtJCozc9
         /fITfEfbyGNusW3cZdrqePG6WdBu6d7n6uukKU+2BFnHmAqjL8dGiP+DyJzJ/sdFKUfG
         4+I6lF3YJX6MbFWOpiuaHW0ScDt5PZmBjllg1OpVXBeA/jyjzfkaiXbX4IIiwvq1vu8T
         OdEXTRrvruxi5ZPRDh1IxpXzWSa4/S0xf0KRDojTeni4KhVYzTwGF+E7vkJy41OJJ8fk
         WcwNGh9GkU3vBpMWPXDM9ah3zIvElHLWndfUxyqE6B816gZ/tJhGOFAvwFTOfyuRgbaN
         mzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750145329; x=1750750129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xab3MFDMuD9rHO6XXeyxnkfZ49gl+eLAkhtogCCcKWU=;
        b=tRBZeFaWpgxpDfNINfeHaOFBzfHwzz+2zDYA6QUiZa9y7px+Fwi3GBp1auEr26XiDJ
         8TOcLkxe9tPsUy1XRECrTpWG7KYdCUHFvtbP7RV/gUI0Y4hkh1lwm6vaAZaK6Fm1vUfB
         In0YjvQpuszL4VHvF62iL5znTbxly9rZFq7Yul+zvGo6wDjH2dPHvPRzS1eafFcGfcR4
         WT6aBak9uaQ7Y7IfAPLImmCbYDWDr+qfOSdPOXDRl9fwrLvZ64EHGJdY9U2AvSlnCKOf
         HyztdJCC0LJKjPN5G2jv1tvmDhrCvqO5zfvzFJimYEkwLZFXJ87uTkepiclok+1DNM4u
         Bu7w==
X-Forwarded-Encrypted: i=1; AJvYcCUuS1toInJ8wcZ8teoc/I+Omdv8Ui6Nzn6sk+WoCgfjvRS+Nyf8zYQOr+WCnwm1J/zDnJWheIMMxpFboHEi@vger.kernel.org, AJvYcCXT++qxQz9YLkQKm1W3rsPG7BZ0KrXKCRnFdvaS5H9/nd1xJLmaXPWamZeZO1zLT9ehBDEXcovGxpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oKf7XY3F3sn0ew1p7NNSyOviBxMNWTlAP1JlC9BybXBxRImV
	IYFT9ho5grY5UBhTp/9Kqp42iF20Dxjur+nvmfl3EnhX/mJt5wP54+PmIH+WgcOnrLGlzVQbipv
	3jOzxcgxeXPfSEhYkDr1Hv9lddzjbtsrFng==
X-Gm-Gg: ASbGnctiDgTXdGsjsqgofcA5L3tcXv2Vp9ar0paLaTjAuJ2KIJzh2umlVE189AuSTvo
	vKCctu+XMpVjUR4UWG2P9W5PLfSe3zpZ1QJ6jtYYFt7xbBdC0HhBztkp4qET6q2m3HBa4hXBZRq
	rCO186k6m4XQmmU5jphbQEnHaaPCj9xVHASRmOjhNMQ6M=
X-Google-Smtp-Source: AGHT+IGpMhyOEegBx/eo0vWPFpt9dXBduAdEGyTBFzAjgzfeeUaOyDYeRvouBONeJMFkVKOQbaFN5AxY1HjrXxrg4Ww=
X-Received: by 2002:a05:690c:708d:b0:711:7256:54c2 with SMTP id
 00721157ae682-711a22b6512mr17431837b3.5.1750145328597; Tue, 17 Jun 2025
 00:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
 <20250605-bmi270-events-v2-3-8b2c07d0c213@gmail.com> <20250607170237.77601f20@jic23-huawei>
In-Reply-To: <20250607170237.77601f20@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 17 Jun 2025 09:28:12 +0200
X-Gm-Features: AX0GCFu_3Z0VdX6Y_khuLFJ0mPxUDRi7R5oeQu2dIEbVa0lgkgo2SMlU6dCX08k
Message-ID: <CAFXKEHa4gU-WAgCGWFvy0Tgei+VEPJ9BBL37dkjqr8YZzjOCSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: imu: bmi270: add support for motion events
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Sat, Jun 7, 2025 at 6:02=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 05 Jun 2025 19:05:03 -0300
> Gustavo Silva <gustavograzs@gmail.com> wrote:
>
> > Any-motion event can be enabled on a per-axis basis and triggers a
> > combined event when motion is detected on any axis.
> >
> > No-motion event is triggered if the rate of change on all axes falls
> > below a specified threshold for a configurable duration. A fake channel
> > is used to report this event.
> >
> > Threshold and duration can be configured from userspace.
> >
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> Hi Gustavo,
>
> A few minor comments inline.  +CC Lothar given they have been doing a lot=
 of
> work with similar events recently and might have time to take a look at t=
his
> and see if I'm missing anything wrt to consistency with our recent discus=
sions.
>

First of all, I feel honoured to be mentioned here, but I probably
cannot help a lot. Recently I ended up with some Analog Device
accelerometers on my table. Pure accelerometers, no IMUs as you have -
so already much simpler. Perhaps, as an example:

Among other events, I was fiddling around activity / inactivity
detection, like AC-coupling i.e. going by a provided threshold, or
DC-coupling i.e. going by the threshold plus some internal heuristics,
and further setting or unsetting a link-bit (related to auto-sleep, so
power save modes), so that activity / inactivity triggers are linked,
the sensor then will remain in a dedicated state "act" or "inact"
(until period of time). In such case a trigger then only comes once at
state transition, where before e.g. for activity it fired act events
as long as measurements were above magnitude of threshold.

For the driver implementation then I made mostly all separate IIO
events: AC-coupling (going by a provided threshold) became
IIO_EV_TYPE_MAG. DC-coupling (going by the threshold, plus some
internal heuristics) became IIO_EV_TYPE_MAG_ADAPTIVE. There was/is a
discussion about declaring the linked activity/inactivity actually as
IIO_EV_TYPE_MAG_REFERENCED. We left that as is. Since I was initially
a bit confused about further (exotic) types like IIO_EV_TYPE_ROC or
_CHANGE, probably I'm learning more from your IMU driver now.

I feel it probably won't help a lot, therefore rather the examply how
I used it. I'll keep on following and keep the bmi270 on my notes as
well. If I spot something, I'll let you know.

[I hope it's ok for the ML to give an answer in this way.]

Best,
L

[...]

