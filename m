Return-Path: <linux-iio+bounces-3855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC23D890009
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C681F22612
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F08060C;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppoKZUel"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CC7EF06;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632151; cv=none; b=NFUUKOrVmTJKTry1GDe4yTJt/PhYVF/vC/0Bj/hsTabEGp9LGLgOFXG7XrdNzGJBw1kOXbOjGH/7TWgVd+XnIPV9xSTW+HcpI4QbnD2oNUCDvLJmv2nP0pefl+dk6HSqZsnN7vEtF1deXk1MQn34lJmCJpDZ1G23TLye3CQfHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632151; c=relaxed/simple;
	bh=hifp9EPxacqyqTKh/Swwog3FV5gr1fKecBoFzLekKao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pUb/ITqcwVSno/YMW4N1WHvVWuOKjvGNJYPQJs2NKwAGbK/KiSHr8NBBtRlYuut8344cbm/uHre09MItViwicCsrvKm053bUvNn8Z2dnKS02SaXgNiTKcWYm98pi3Q6EW81VxwBDTc/kzoLyicYfd4nLBfwbrP/tw3GmIEzIM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppoKZUel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11276C433C7;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=hifp9EPxacqyqTKh/Swwog3FV5gr1fKecBoFzLekKao=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ppoKZUelxc4IRboRBDLbAtohfxohapAfaPZb5f0fE8v1kntnYQtJFZA9GgVG47G4+
	 NvhPmu9n8OcZQMYFjogY/5EKApRsVQYdC/x5MqesUDo1pOBsa9qiDJqmH/NvSCGbsc
	 Eww85XnoJpLQwj+vRPAGwGQbsi1F/iXeJJvN30uP0I8HqNOipDC6FKWmrcdk3lQ8q1
	 RskEoJnZr/e3LgFXWXwv2nohEEN+5Cq4SMwujBAkdRJrJdUhJQliGXeYzP+U5oCjQO
	 zZGZaX9W0W1+yVpAvGrdNjzIZZpOWLYWcHnGkWxSEedPIliYyhFOHo+qbitOf3r6WV
	 t2OC1nyNatEig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA2ACD1283;
	Thu, 28 Mar 2024 13:22:30 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 00/10] iio: dac: support IIO backends on the output
 direction
Date: Thu, 28 Mar 2024 14:22:24 +0100
Message-Id: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABBvBWYC/x3MQQqAIBBA0avErBsws6yuEi0mnWoILBQiiO6et
 HyL/x9IHIUTDMUDkS9JcoSMqizAbRRWRvHZoJU2qtYtihw4k9s5eKRb0JND01uyylLjuw5yeUZ
 e5P6v4/S+H988O8llAAAA
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=3896;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=hifp9EPxacqyqTKh/Swwog3FV5gr1fKecBoFzLekKao=;
 b=VBDDUP2MQv6jYPWbKLTgFuaSqA+z4T22yY1UFxlgpZc1P6GWL05sA21/X83vBIHZuGpsMKqwQ
 YSZubgAWCcjDtYfKVY45vNdsUFBmSpYBvUBLVJSJZIrCZWbZ6v1MxNI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

This is the result of the brief discussion we had in the RFC [1].
Patches 2 to 5 from Paul's series to bring output buffer support to
DMA buffers [2].

Note that the original DMA patch 4 ("iio: buffer-dmaengine: Support
specifying buffer direction") also had changes for the axi-adc as it
used devm_iio_dmaengine_buffer_setup(). However, when that was converted
to the backend framework, we started to use iio_dmaengine_buffer_alloc()
and default is INPUT so no need for any change.

I did gave it a try on beginning to support extending IIO channels
(chan_spec) from backend's. For now, we just need to do it for the
extended info and honestly, IMHO, I don't think the result to be
horrible :). The only thing that I don't like much is the call to
iio_device_set_drvdata() in iio_backend_extend_chan_spec(). Long story
short, I know it's likely to break so maybe we should have a proper
solution right from the beginning. But see the comment I have in there.
I did thought in a solution that should work but you may have a better
idea.

Also note the main reason to come up with the iio_backend_ext_info_set()
and iio_backend_ext_info_get() helpers is not to allow starting having
these from backends. I was even thinking in just passing the callbacks
from the frontend to iio_backend_extend_chan_spec() but I kind of prefer
this way. We may still need at some point to allow frontends to have full
control and have their callbacks in the attributes. But for now, I'm not
even allowing for backends to append a channel ext_info so i would say to
worry about that when such a scenario pops up.

I would also prefer for  iio_backend_ext_info_set() and
iio_backend_ext_info_get() to be static but that would make the code more
complex than it needs to be (we would have to kmemdup() the backends
ext_info and assign the callbacks) so I went this way.

[1]: https://lore.kernel.org/linux-iio/20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com/
[2]: https://lore.kernel.org/linux-iio/20230807112113.47157-1-paul@crapouillou.net/

---
Nuno Sa (6):
      iio: buffer: add helper for setting direction
      dt-bindings: iio: dac: add bindings doc for AXI DAC driver
      dt-bindings: iio: dac: add bindings doc for AD9739A
      iio: backend: add new functionality
      iio: dac: add support for AXI DAC IP core
      iio: dac: support the ad9739a RF DAC

Paul Cercueil (4):
      iio: buffer-dma: Rename iio_dma_buffer_data_available()
      iio: buffer-dma: Enable buffer write support
      iio: buffer-dmaengine: Support specifying buffer direction
      iio: buffer-dmaengine: Enable write support

 Documentation/ABI/testing/sysfs-bus-iio-ad9739a    |  17 +
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |  88 +++
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  62 ++
 MAINTAINERS                                        |  17 +
 drivers/iio/buffer/industrialio-buffer-dma.c       | 100 +++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  28 +-
 drivers/iio/dac/Kconfig                            |  37 ++
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad9739a.c                          | 445 ++++++++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 644 +++++++++++++++++++++
 drivers/iio/industrialio-backend.c                 | 144 +++++
 drivers/iio/industrialio-buffer.c                  |   7 +
 include/linux/iio/backend.h                        |  49 ++
 include/linux/iio/buffer-dma.h                     |   4 +-
 include/linux/iio/buffer-dmaengine.h               |   6 +-
 include/linux/iio/buffer.h                         |   3 +
 16 files changed, 1624 insertions(+), 29 deletions(-)
---
base-commit: a276b4da56e988157a34b9fef9c46ebfd95f7f09
change-id: 20240326-iio-backend-axi-dac-497a707a5d88
--

Thanks!
- Nuno Sá



