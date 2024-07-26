Return-Path: <linux-iio+bounces-7909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C67E93CF7E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFAD1C21E37
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85CC176FA3;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbrPPbTa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB155898;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982180; cv=none; b=qx+bgQO46rnkefke4ltWp14ZRfgNu5qz7k83BW81r+NcfuaxuX0STOLroRlZlylMKrRCjLIWHd+LLFClWpxsFUCk/5D1wKh+u7Gi9l6bV70Z6uwKz4iHuRViHCCgOosdXIf71DVT/Fx9Mzd0Flh6wDc5Iz97zi3aTDWxWkMIPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982180; c=relaxed/simple;
	bh=WyJI+2lqRWn23JQimnxJt9rUlG59V5Wo8/tdFWvIKuM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fVZ6buV/9M0XXhMffmbGhQqy3XptItijU3SU8JCvldhQcS32f3Zfokxf6Wl3KIHu/Kl1/nyTAG/xp2Nr+7ghmxu+oftWfm5qUQ39biFkylFHjE811rj1pDy2RUmIhKN8fer/8ktijOX7zPx1HebV5QJgepn7XcQ5lwbH/Gf06Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbrPPbTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CBFAC32782;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=WyJI+2lqRWn23JQimnxJt9rUlG59V5Wo8/tdFWvIKuM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PbrPPbTakoujIXnMRBrDh8TbZ3B+XaxRHuOIVuFG4fQ3QmjOID8M1NDWdsX5RoOin
	 dGTQ03yMspH80OMMpaLj4xyr/P5y+N8NYSJPrW5UPjh3BWvmh9gdXriOe9Vmx4OofG
	 XwkikxWrV2orbtXmufRRb6sv4/DjXNfPsHnX/OVd4SGNlyhAxn/nH5Boz/zaZAeP9z
	 hrt9IxzwCne3dIteuwpn989eEta7KBlA7Ouz73n4N4ULI75PT/a+T34jeCvO/l9l7R
	 ej0SKWfvIoZFuhhT0lyYWtF0NmjnZ4gnQfMyR+T6OUaXSh3szETlb5JTynP6F0D92I
	 Ljlqzd1swfcDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B00C3DA49;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 00/23] iio: make masklength __private (final round)
Date: Fri, 26 Jul 2024 10:22:52 +0200
Message-Id: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANxco2YC/x3MQQqAIBAAwK/EnlsoC6y+Eh0W3WqpLFQkiP6ed
 JzLPBDYCwcYigc8Jwlyuoy6LMCs5BZGsdmgKtVWWrVoOaHIiQeFbWe3xBUvL4kiN6hJ2a7uyRh
 tIQ+X51nufx+n9/0AyfqI/20AAAA=
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=5077;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WyJI+2lqRWn23JQimnxJt9rUlG59V5Wo8/tdFWvIKuM=;
 b=7dO/QcsN3vOJ1/SAxpLpEUUZ6emm5sf6znQMt4MjPY491Ya7+QQCYQyS2Trge9M/pmTFfHFvQ
 wMwUCwQTGOADl6sX+5VHG8yr8TfJMKhSHGZyMYxeSbSkPLz+lSqrjIJ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes the final conversion round.  On the testing branch a git
grep:

git grep "\->masklength"

Gives no more users so hopefully I did it right :).

Not entirely related with this but I'll mention it anyways :). Looking
at the other [INTERN] fields, I see:

* active_scan_mask: which seems to be pretty similar to masklength;
* scan_timestamp: Has some apparently valid  users;
* scan_bytes: Also has a few users;
* trig: may need a bit more inspection.

The first 3 look like valid RO fields that drivers are allowed to
access. I mean, for scan_bytes I guess drivers could calculate that
based on the active_scan_mask but I think that's just not worth it given
the core already did it for us.
 
So I wonder if a similar work would be valuable? scan_timestamp and
scan_bytes would be pretty trivial but for active_scan_mask we do have
lots of users (but also trivial I think).

For Trig, most of the writes are drivers doing

indio_dev->trig = iio_trigger_get(data->trig);

So we either assume it's public or remove that line from drivers. Though
that could break userland apps relying on some trigger to be
automatically set after device probe. We can anyways have another helper
to do that for drivers (not sure this field is accessed in some
fastpath).

Also need to better check if there are any readers for it.

Anyways, it would be nice to get your inputs on the last [INTERNAL] fields
in struct iio_dev

Also want to mention that I deliberately removed some mailing lists
given by get_maintainers as this is fairly simple and so I don't think
the "spam" is worth it :). 

---
Nuno Sa (23):
      iio: accel: adxl380: make use of iio_get_masklength()
      iio: adc: max1118: make use of iio_for_each_active_channel()
      iio: adc: max1118: make use of iio_for_each_active_channel()
      iio: adc: mcp3911: make use of iio_for_each_active_channel()
      iio: adc: mt6360-adc: make use of iio_for_each_active_channel()
      iio: adc: rockchip_saradc: make use of iio_for_each_active_channel()
      iio: adc: rtq6056: make use of iio_for_each_active_channel()
      iio: adc: stm32-adc: make use of iio_get_masklength()
      iio: adc: stm32-dfsdm-adc: make use of iio_get_masklength()
      iio: adc: ti-adc0832: make use of iio_for_each_active_channel()
      iio: adc: ti-adc084s021: make use of iio_for_each_active_channel()
      iio: adc: ti-ads1015: make use of iio_get_masklength()
      iio: adc: ti-ads1119: make use of iio_get_masklength()
      iio: adc: ti-ads1298: make use of iio_for_each_active_channel()
      iio: adc: ti-adc12138: make use of iio_for_each_active_channel()
      iio: adc: ti-ads124s08: make use of iio_for_each_active_channel()
      iio: adc: ti-ads131e08: make use of iio_for_each_active_channel()
      iio: adc: ti-ads8688: make use of iio_for_each_active_channel()
      iio: adc: vf610_adc: make use of iio_get_masklength()
      iio: adc: xilinx-xadc-core: use new '.masklength' accessors
      iio: common: cros_ec_sensors_core: use new '.masklength' accessors
      staging: iio: impedance-analyzer: ad5933: make use of iio_get_masklength()
      iio: core: annotate masklength as __private

 drivers/iio/accel/adxl380.c                               | 2 +-
 drivers/iio/adc/ina2xx-adc.c                              | 3 +--
 drivers/iio/adc/max1118.c                                 | 3 +--
 drivers/iio/adc/mcp3911.c                                 | 2 +-
 drivers/iio/adc/mt6360-adc.c                              | 2 +-
 drivers/iio/adc/rockchip_saradc.c                         | 2 +-
 drivers/iio/adc/rtq6056.c                                 | 2 +-
 drivers/iio/adc/stm32-adc.c                               | 4 ++--
 drivers/iio/adc/stm32-dfsdm-adc.c                         | 2 +-
 drivers/iio/adc/ti-adc0832.c                              | 3 +--
 drivers/iio/adc/ti-adc084s021.c                           | 3 +--
 drivers/iio/adc/ti-adc12138.c                             | 3 +--
 drivers/iio/adc/ti-ads1015.c                              | 2 +-
 drivers/iio/adc/ti-ads1119.c                              | 4 ++--
 drivers/iio/adc/ti-ads124s08.c                            | 3 +--
 drivers/iio/adc/ti-ads1298.c                              | 3 +--
 drivers/iio/adc/ti-ads131e08.c                            | 2 +-
 drivers/iio/adc/ti-ads8688.c                              | 4 +---
 drivers/iio/adc/vf610_adc.c                               | 2 +-
 drivers/iio/adc/xilinx-xadc-core.c                        | 5 ++---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 8 +++-----
 drivers/iio/industrialio-buffer.c                         | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c           | 5 +++--
 include/linux/iio/iio.h                                   | 4 ++--
 24 files changed, 32 insertions(+), 43 deletions(-)
---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240724-dev-iio-masklength-private3-7a2d819acc7d
--

Thanks!
- Nuno Sá



