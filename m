Return-Path: <linux-iio+bounces-2627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D6857EEE
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C911B27A23
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF9112E1FC;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/mwi/jW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC012E1DE
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092689; cv=none; b=hf1SJyz+fof9bIYqpC5HEiXv3G3LY1QaJykHJtCaa+1TMSTx2e8OkBPGN4Z18/vjo2GhylbEuwpwiQO9UL99/+AO5WpvH3krFWg8msGnlUUng/VBGuRScXjJy8xQrVfrPEuwk7XIvKUxHty6gXkcrd7ibFOnBQVeQSRfmID0OrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092689; c=relaxed/simple;
	bh=JkdEGtgxgNJFqntuuSvbTXVlI576d1yAn17D5A/OWj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=auuh2qyDBHWX/x67ZjJ/xPyU0ez260mRodu03RCUI8/7MAY5GJbnQNtJly0Vcqy9wmloJvCwop/0W6jlJd7dyb3c2vZTW9Tcd18B4p0ndNID23E+4teP+M68LSulMH5KJIk+bV6UEDbsBYxtpEvK4h81BetJRGTNtBALeLAeTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/mwi/jW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36B98C433F1;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092689;
	bh=JkdEGtgxgNJFqntuuSvbTXVlI576d1yAn17D5A/OWj8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=q/mwi/jWsqI1fiOHbjUyznOtIo3O6GjJpce6Of2XrXQCBLnMqe9vFYmhNqG7z3BE1
	 uFx22O23LzYwBBjIjR0AZWWa9u8Qji7EdMrKwLdm+FLbQ4cDFjpq6xo2BPWnG8hpEn
	 AIURdFlT8GWHCo1OuX0rqpqSE2iNOHJcyoZ9Jh/W01ADZjlZLiA/MalVrWmczlfos8
	 WUbvjaHCQdxa4A6H3Uso8R6+i55zyD7eYr92ZxDhH8vUVNZiK605KUe/AqTrZUTNA3
	 kkk8Fkcw0hipRGBPzzD+XTrDH74MIm1hW+B4o32f9IcELZ05AYUHW6ZmmDHDE/HKvt
	 R1z0ID3b7KO4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191ADC48260;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RFC 0/8] iio: dac: support IIO backends on the output
 direction
Date: Fri, 16 Feb 2024 15:10:49 +0100
Message-Id: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOlsz2UC/x3MMQqAMAxA0atIZgNtEAuuggdwFYdqUw1ClRZEK
 N7d4viG/zMkjsIJuipD5FuSnKFA1xWsuw0bo7hiIEWNIt2iyImLXQ8ODu0j6FxCbQz5hVSrGg+
 lvCJ7ef7rBOPQw/y+H4NjaU5qAAAA
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708092664; l=4794;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JkdEGtgxgNJFqntuuSvbTXVlI576d1yAn17D5A/OWj8=;
 b=FKnfYoC42zMUdsaG9ZUVRLmLu5R/TvJVlueufdEAxdixb1r9B3T3IX2v+EWrtiMOcxp/g/9oJ
 KQC9ps36M4OCPc0uY/ais285EDoE0WPuBW6/fUwUPA5GHd/v2LmANeJ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

Hi all,

This RFC is mainly because I'm not getting extremely happy with the
direction of the API in the series. So I think it's better to have the
discussion now so the actual series will look better. Also note that patch
2 to 5 are brought from Paul's series to bring output buffer support to
DMA buffers [1].

So, the main API I'm speaking about is:
 - iio_backend_read_phase()
 - iio_backend_write_phase()
 - iio_backend_read_scale()
 - iio_backend_write_scale()
 - iio_backend_read_frequency()
 - iio_backend_write_frequency()

All the above is basically ABI/attributes that belong and are supported
by the AXI_DAC IP core. The main things I dislike are:
 * The sample_freq and tone_id in iio_backend_read|write_frequency().
   The API (like the others) should resemble the IIO read|write_raw()
   API and even though multiple tone waves is not something unusual, it
   would be better to keep it local to the core. The sample_freq is not
   that bad as we can eliminate it by having a new op for setting the
   sample_frquency.
 * Code duplication. Any DAC using the AXI_DAC  backend will have to define
   that extended_info.

One idea that I had was to allow to get IIO channels from the backend
but I then quickly started to dislike it because it would open a lot of
complexity. I mean, if we allow backends to define whatever they
want, that might quickly get nasty.

I guess the above comes from (maybe naive) this idea that we should be
capable to replace a backend and the IIO frontend should still work
without any change to the code. But given how the backends are tightly
coupled to the frontend (at least on ADI usecases) I think that
changing the backend is a very unlikely usecase. And if it happens it
definitely means different HW and userspace ABI so devicetree might make
sense (maybe even a new compatible).

So yes, I think it's definitely possible to have something generic where
the backend could completely define a channel (even had some ideas) but
I think the complexity it would bring is just not worth it
(at least right now). 

However, another idea that started to grow (that maybe is not that bad)
is that the IIO frontend would still define how many channels, the
channel type, which channel is buffered, etc... but allowing the backends
to extend a certain channel (the backend would be given the channel type
and it could then decide if it can or cannot extend it). We should be
careful with what we allow to extend though... For instance, in this case,
allowing to extend extended_info is likely not that bad because it's
a fairly self contained thing.

Another thing that we could consider is the info masks. Mentioning this
because (it's not part of the RFC but it should be in the real series)
the AXI_DAC also has CALIBSCALE and CALIBBIAS (I think) that can be
applied to the buffered channel. But in here, it's not that much of code
duplication to set a couple of bits in the mask and then we can just
forward the read/write to the backend... Still, maybe worth considering it
at least..

So, the above two paragraphs are kind of an intermediate approach which
does not look that crazy (or complex to implement).

Thoughts?

[1]: https://lore.kernel.org/linux-iio/20230807112113.47157-1-paul@crapouillou.net/

---
Nuno Sa (4):
      iio: buffer: add function to set the buffer direction
      iio: backend: add new backend ops
      iio: dac: add support for the AD97339A RF DAC
      iio: dac: adi-axi-dac: add support for AXI DAC IP core

Paul Cercueil (4):
      iio: buffer-dma: Rename iio_dma_buffer_data_available()
      iio: buffer-dma: Enable buffer write support
      iio: buffer-dmaengine: Support specifying buffer direction
      iio: buffer-dmaengine: Enable write support

 drivers/iio/buffer/industrialio-buffer-dma.c       | 100 +++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  28 +-
 drivers/iio/dac/Kconfig                            |  37 ++
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad9739a.c                          | 503 ++++++++++++++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 510 +++++++++++++++++++++
 drivers/iio/industrialio-backend.c                 |  65 +++
 drivers/iio/industrialio-buffer.c                  |  12 +
 include/linux/iio/backend.h                        |  53 ++-
 include/linux/iio/buffer-dma.h                     |   4 +-
 include/linux/iio/buffer-dmaengine.h               |   5 +-
 include/linux/iio/buffer.h                         |   3 +
 12 files changed, 1292 insertions(+), 30 deletions(-)
---
base-commit: 7d50ed99f4d40b6fa672be971dda91a8cc8ebae4
change-id: 20240216-iio-backend-axi-dds-1772fb20604f
--

Thanks!
- Nuno Sá


