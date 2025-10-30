Return-Path: <linux-iio+bounces-25660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1AAC1F49D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 10:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2F794E8F36
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30904340A59;
	Thu, 30 Oct 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUpQQp2h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416E340A43
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816504; cv=none; b=WTBM5vrvGeFohHcDy8xzZypTJrLoROvUVVxNda7StjsiVJ2OJpV5BH9QH31L3HJ/zHrH4/truzhYhvN/6qSdRXCF6xAET6X1QI/m2oN/ik+9F+nPMzgm1sIrIFTzBwVD52hOqpKrMxVjvqpNPbyneXySLTXyBkZEBUwOTxo7EN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816504; c=relaxed/simple;
	bh=3KFae3mnHAdFgFch5WE6C2EMGzI5ArupRlzDKVWdUMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cU9DsTBNJ1bY0PQvCNvXdnYkwUaogL3V13TYl4l/K4a0ObsI7+/VOCofWBxLjRuDF0uMiGUGhsmPfgvEUW61p7nrTRlyvcF5kCv7zm+HqPJGxCBDmv6JyhP/83VIMMR6ZXBehsCXJvUxOw+cq03erOhGs9DQWhXyI6feW3sTjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUpQQp2h; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so8241695e9.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761816500; x=1762421300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3KFae3mnHAdFgFch5WE6C2EMGzI5ArupRlzDKVWdUMU=;
        b=kUpQQp2hixzbrRyl76dwIB85fUNBHwHtc5rZjDBeYHTmFgYWP+mHqXZC1m9/9y7x0K
         8HbUO7yWW0mnybxPfVdxRYOOuriki8kN2wKLqMhgR7hAj3oQxqIr0UWqYuZdaHWDeXBi
         Od/3B4UfB2WZmRhSBkcjWsefZxH6jg7YuAAEU4kwP3q3lsp2E90PJ8ZT2B6qDU0sRAkF
         UNSfCYWqjwBfkbZzud7ZDWKyAXuSGzmZEKC0nIOFHk0YBiDMyoF+8xNIsCqK8xZrgAOK
         YGlWGYH318kXq/ovFWAndE4FtDNWPj3b91quV0lOgvUIb4W7oWEjZoP8Xb/xPdepQy+E
         mmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816500; x=1762421300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KFae3mnHAdFgFch5WE6C2EMGzI5ArupRlzDKVWdUMU=;
        b=dfGrOcICgAvaJdN2waswwn57kz8gbdFLppE1NqvDeXQkQKHLwmimzYgg/bpl1EkaSk
         OObq1jRstCHKKg2E99MINkRdWs5ZjiHSZoPg79Vvo+Er0O99xsSm0P1Uy9UOu1CJf4ac
         1isc7c9G4yR6mbcI9pl2WAFssMpGqWy+4qGp+viaacQMDE2kHTnDaji7dOyjeVlBnf/Z
         jaJsmHrnNlNWyVqrN5nhebiOiAFJ/UxahHz0HjwRxPi8Moqlt5MOOjs2B8mFJWup+GO0
         VFn5MM4tpO5Thos04tYnn08sDtFZM1xEfQdvG519k65LHRIOTVvnAsjfBwFN5UZX9vD8
         vG8A==
X-Forwarded-Encrypted: i=1; AJvYcCVw4zRzBz13LWIub5MMXadKcvWUqV2k442i4ozbRjMeJERF2RHz02AXJuBBiE3GhwfZpVpeAKjaHXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdcbi+DMWhM/Tkwm85YMzk4OfhONqGWiB6EsgUBLsH10Hr67Fl
	KX80XiopJHo1ZJTCdunHWrLOUlBQoNdEdgCmw/dfoW9aCiCLQ/NphEbe
X-Gm-Gg: ASbGncv0N6KscQspou+dgSIfNX0gWHel7YMvlR9fz9M0TOptmi8Dnv146Jbbaaz3UDW
	wnPFdi9xfElmnO+e0rwPZI5bPQSjDbUQlK/bpvnmmh8vB4PJNhrL8WYvillOc+5XqE41HFy0tEt
	CrGZ/fDY96RjwtC8QzMDxfmF506KKkDoQgJ1kVJS1MMq+ldZFtAhzoR4CJmfiGzdkPMhBZEasjr
	kbg7j+jCSBBqz27rwlr5aIJH43jbE2SNW5tx5aSSpWMCHAh+BQFrjsmqTC63Co9cZAgl5xO1gOK
	vU/Gmsm0GqoUS7MibWdaIV1gaZxgbf3yWx8xrqTAEQCWDLC3OmUNFa7S4utof+5ssQMeFslDW1t
	7AY1UGQn4ztTXT3blYRPUeuH7VGd5a7qNhZCT3pfZ/B/LpX535PgAz8tm72WzUE0L12hnoMWqq1
	9zuKa680HwbREmO9wCyXs=
X-Google-Smtp-Source: AGHT+IFF7NXPdvCAbGKnhLasZSsumjveW6sgM14GbeDb/ZSePCiZlozXxupC6H8veSQgZ8O+6rzmTA==
X-Received: by 2002:a05:600c:348a:b0:475:dd89:ac7 with SMTP id 5b1f17b1804b1-47726701f1bmr19220215e9.1.1761816499994;
        Thu, 30 Oct 2025 02:28:19 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899991asm29042145e9.3.2025.10.30.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:28:19 -0700 (PDT)
Message-ID: <ca6760182b4662c96df6204bae903d8affa6a8e3.camel@gmail.com>
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, 	eblanc@baylibre.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net
Date: Thu, 30 Oct 2025 09:28:54 +0000
In-Reply-To: <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
	 <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
	 <20251027140423.61d96e88@jic23-huawei>
	 <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 15:11 -0300, Marcelo Schmitt wrote:
> On 10/27, Jonathan Cameron wrote:
> > On Mon, 20 Oct 2025 16:15:39 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >=20
> > > AD4030 and similar devices can read common-mode voltage together with
> > > ADC sample data. When enabled, common-mode voltage data is provided i=
n a
> > > separate IIO channel since it measures something other than the prima=
ry
> > > ADC input signal and requires separate scaling to convert to voltage
> > > units. The initial SPI offload support patch for AD4030 only provided
> > > differential channels. Now, extend the AD4030 driver to also provide
> > > common-mode IIO channels when setup with SPI offloading capability.
> > >=20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > New patch.
> > > I hope this works for ADCs with two channels. It's not clear if works=
 as
> > > expected with current HDL and single-channel ADCs (like ADAQ4216).
> > >=20
> > > The ad4630_fmc HDL project was designed for ADCs with two channels an=
d
> > > always streams two data channels to DMA (even when the ADC has only o=
ne
> > > physical channel). Though, if the ADC has only one physical channel, =
the
> > > data that would come from the second ADC channel comes in as noise an=
d
> > > would have to be discarded. Because of that, when using single-channe=
l
> > > ADCs, the ADC driver would need to use a special DMA buffer to filter=
 out
> > > half of the data that reaches DMA memory. With that, the ADC sample d=
ata
> > > could be delivered to user space without any noise being added to the=
 IIO
> > > buffer. I have implemented a prototype of such specialized buffer
> > > (industrialio-buffer-dmaengine-filtered), but it is awful and only wo=
rked
> > > with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree).=
 Usual
> > > differential channel data is also affected by the extra 0xFFFFFFFF da=
ta
> > > pushed to DMA. Though, for the differential channel, it's easier to s=
ee it
> > > shall work for two-channel ADCs (the sine wave appears "filled" in
> > > iio-oscilloscope).
> > >=20
> > > So, I sign this, but don't guarantee it to work.
> >=20
> > So what's the path to resolve this?=C2=A0 Waiting on HDL changes or not=
 support
> > those devices until we have a clean solution?
>=20
> Waiting for HDL to get updated I'd say.

Agree. We kind of control the IP here so why should we do awful tricks in
SW right :)? At the very least I would expect hdl to be capable to discard =
the
data in HW.

>=20
> >=20
> > Also, just to check, is this only an issue with the additional stuff th=
is
> > patch adds or do we have a problem with SPI offload in general (+ this
> > IP) and those single channel devices?
>=20
> IMO, one solution would be to update the HDL project for AD4630 and simil=
ar ADCs
> to not send data from channel 2 to DMA memory when single-channel ADCs ar=
e
> connected. Another possibility would be to intercept and filter out the e=
xtra
> data before pushing it to user space. My first attempt of doing that didn=
't
> work out with upstream kernel but I may revisit that.

I'm also confused. Is this also an issue with the current series without co=
mmon mode?

If I'm getting things right, one channel ADCs pretty much do not work right=
 now with
spi offload?

If the above is correct I would just not support it for 1 channel ADCs.

- Nuno S=C3=A1

