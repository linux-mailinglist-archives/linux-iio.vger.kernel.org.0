Return-Path: <linux-iio+bounces-3292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1B86F68F
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84FCB20F21
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D8768E4;
	Sun,  3 Mar 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEjDuqvC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E6B654
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709490352; cv=none; b=Aritsk5NhgRzyZ4GWeihbMKqY/0/buHqcaduCvtJnEnpo8sXxPPn4lFjqcE02FE4GuQWQGcqKEX19GU+yCbbAw64UramZp12KthF4o4QeZNMdyPJAdyJS4LHInhoHi2MUqlhCA9mVRn90dLBZBaXks1wnTR/K5ZuN3tYIWm6/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709490352; c=relaxed/simple;
	bh=SgaWS0Y5ddNVtswo0NLIpeELEBTwXRN2zGCTMlq6Vh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILP3TmWjGOQU1fE9tabNYfEFb5ju5k9Fd8T/bO98oYbY2vldJJuIQ7WwVDffXmFuVQowcfY9gWy6X0wZfnOh4OLFtnFBAP+IZNZoeo8yzdRAs2e2K1UUzGj/hPFM4xyBxd4LD2gmablG9KSgiF936Dn2rHfLjdo+JY7GBRIpbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEjDuqvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76F9C433C7;
	Sun,  3 Mar 2024 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709490352;
	bh=SgaWS0Y5ddNVtswo0NLIpeELEBTwXRN2zGCTMlq6Vh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEjDuqvCGoQ/pmICf/8Ghgj4TOxaz3ht8wvxeqnAJondeMQbRFv/GqG8mpyhJBG1V
	 FNVRrtHdFnQuyVENXg5qsEQtB3jLnezOpfBCl2Nr64JGjHYnsFRu8GqnyQ0DnPTPP7
	 8ChPwamhAkt7u+NrqZ66PWxVcfkIMFwMIjmNy948hxRjKaiS/Z6qEvS2/b5qzMwXsw
	 dORfg9TFOXoILYXRWY7+FS3H1gLNRAFJV2mn86WV49HArwyT6hlVId/WJtuSAwHRLD
	 AYnZ4uQA0UUge1XbFXHhUh1mdvKfrw31iBNdV39IK26gagK9u7JPVIsKNcufDr6auQ
	 GI8ylCIzZHmgA==
Date: Sun, 3 Mar 2024 18:25:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Paul Cercueil
 <paul@crapouillou.net>, Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH RFC 0/8] iio: dac: support IIO backends on the output
 direction
Message-ID: <20240303182538.36cb2318@jic23-huawei>
In-Reply-To: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 15:10:49 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi all,
>=20
My first comment here isn't don't worry too much about getting it
perfectly correct from the start.  Until you have half a dozen or more
drivers using this stuff you won't have seen enough to
get generalizations right.  As this stuff is all in kernel and not
exposed to userspace, that isn't a problem.  We can evolve and
improve this as we go along.  Userspace ABI design is much worse
as you are stuck with your errors for ever (so never finalize that until
you have a good number of drivers to try it with!)

> This RFC is mainly because I'm not getting extremely happy with the
> direction of the API in the series. So I think it's better to have the
> discussion now so the actual series will look better. Also note that patch
> 2 to 5 are brought from Paul's series to bring output buffer support to
> DMA buffers [1].
>=20
> So, the main API I'm speaking about is:
>  - iio_backend_read_phase()
>  - iio_backend_write_phase()
>  - iio_backend_read_scale()
>  - iio_backend_write_scale()
>  - iio_backend_read_frequency()
>  - iio_backend_write_frequency()
>=20
> All the above is basically ABI/attributes that belong and are supported
> by the AXI_DAC IP core. The main things I dislike are:
>  * The sample_freq and tone_id in iio_backend_read|write_frequency().
>    The API (like the others) should resemble the IIO read|write_raw()
>    API and even though multiple tone waves is not something unusual, it
>    would be better to keep it local to the core. The sample_freq is not
>    that bad as we can eliminate it by having a new op for setting the
>    sample_frquency.

One of the gaps in the IIO core has always been handling multiples of the
same attribute of a channel.  Sounds like this is one of those.
We never really came up with a good solution for it there so I'm not
surprised it's causing you pain as well.

I'm not certain what tone ID actually is though. Some mode in which the
FPGA is generating a fixed tone, or modulating between several rather
than streaming from the DMA buffer?  Or something entirely different?
(I had a google and found an ADI AXI core where it seems this is a DDS
 feature, so fsk modulation?)


I know a little on highspeed ADCs, my DAC knowledge is much more limited
so you may need to provide more background or some reference links.

>  * Code duplication. Any DAC using the AXI_DAC  backend will have to defi=
ne
>    that extended_info.

Can't it stub it out cleanly?

>=20
> One idea that I had was to allow to get IIO channels from the backend
> but I then quickly started to dislike it because it would open a lot of
> complexity. I mean, if we allow backends to define whatever they
> want, that might quickly get nasty.
>=20
> I guess the above comes from (maybe naive) this idea that we should be
> capable to replace a backend and the IIO frontend should still work
> without any change to the code. But given how the backends are tightly
> coupled to the frontend (at least on ADI usecases) I think that
> changing the backend is a very unlikely usecase. And if it happens it
> definitely means different HW and userspace ABI so devicetree might make
> sense (maybe even a new compatible).

It's a dream we should strive for, but until we actually have multiple
backend implementations for a given front end it's going to be tricky.
+ I'd still expect some info transfer along the lines of 'use options
a, b, c' to be passed to the frontend.

>=20
> So yes, I think it's definitely possible to have something generic where
> the backend could completely define a channel (even had some ideas) but
> I think the complexity it would bring is just not worth it
> (at least right now).=20

Agreed.

>=20
> However, another idea that started to grow (that maybe is not that bad)
> is that the IIO frontend would still define how many channels, the
> channel type, which channel is buffered, etc... but allowing the backends
> to extend a certain channel (the backend would be given the channel type
> and it could then decide if it can or cannot extend it). We should be
> careful with what we allow to extend though... For instance, in this case,
> allowing to extend extended_info is likely not that bad because it's
> a fairly self contained thing.

An example that might make sense is filtering. More than possible the
backend would do controllable digital filtering, or indeed the related
option of oversampling and averaging.

This is definitely plausible.  I'd not worry about limiting what the backend
can in theory modify that much, in practice I'd expect it to remain sane
and if it becomes a problem the front end can take a look at the result
and reject things it doesn't like.

>=20
> Another thing that we could consider is the info masks. Mentioning this
> because (it's not part of the RFC but it should be in the real series)
> the AXI_DAC also has CALIBSCALE and CALIBBIAS (I think) that can be
> applied to the buffered channel. But in here, it's not that much of code
> duplication to set a couple of bits in the mask and then we can just
> forward the read/write to the backend... Still, maybe worth considering it
> at least..

This feels like something not to do 'yet', but maybe in the future.
Have way for the two to negotiate ownership of an interface call (hopefully
only one handles it) and pass them on through.
>=20
> So, the above two paragraphs are kind of an intermediate approach which
> does not look that crazy (or complex to implement).
>=20
> Thoughts?
>=20
> [1]: https://lore.kernel.org/linux-iio/20230807112113.47157-1-paul@crapou=
illou.net/
>=20
> ---
> Nuno Sa (4):
>       iio: buffer: add function to set the buffer direction
>       iio: backend: add new backend ops
>       iio: dac: add support for the AD97339A RF DAC
>       iio: dac: adi-axi-dac: add support for AXI DAC IP core
>=20
> Paul Cercueil (4):
>       iio: buffer-dma: Rename iio_dma_buffer_data_available()
>       iio: buffer-dma: Enable buffer write support
>       iio: buffer-dmaengine: Support specifying buffer direction
>       iio: buffer-dmaengine: Enable write support
>=20
>  drivers/iio/buffer/industrialio-buffer-dma.c       | 100 +++-
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  28 +-
>  drivers/iio/dac/Kconfig                            |  37 ++
>  drivers/iio/dac/Makefile                           |   2 +
>  drivers/iio/dac/ad9739a.c                          | 503 +++++++++++++++=
+++++
>  drivers/iio/dac/adi-axi-dac.c                      | 510 +++++++++++++++=
++++++
>  drivers/iio/industrialio-backend.c                 |  65 +++
>  drivers/iio/industrialio-buffer.c                  |  12 +
>  include/linux/iio/backend.h                        |  53 ++-
>  include/linux/iio/buffer-dma.h                     |   4 +-
>  include/linux/iio/buffer-dmaengine.h               |   5 +-
>  include/linux/iio/buffer.h                         |   3 +
>  12 files changed, 1292 insertions(+), 30 deletions(-)
> ---
> base-commit: 7d50ed99f4d40b6fa672be971dda91a8cc8ebae4
> change-id: 20240216-iio-backend-axi-dds-1772fb20604f
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


