Return-Path: <linux-iio+bounces-24586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63847BADE94
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244A33B8EC1
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550BFBF6;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eza55UVv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337783081A5
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=Jq8tgqxJOO1d6l5QiSwWXcOPvCVIyh/erdYFhuCRMx4n3LIr7XURoCu5GJKfvDk1m8lFsIgGtsFmK53QbWS1Nrqn7Hpmw/Q53bFhrHsDU7rVktJ+7cI2D/IqQERuI8W0jYmE8zC1y+J20663UuacB6YSOh5DfVZ8g/HkbI32auU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=Ujr3vQFuXMf6tuVm3oUvumgJUXtr5UkQ7zY3FbabcwE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a+PHdberpwrBvK5hPZhKTQFoUYuM8yIk4lE2FvkkFUKm0XgQGpxGKzoXWg2C2iKF6nGn0P0Qo+/WaBUHKBP6vYONFI0aHjFXA+BVy0fG1gdRjN/lMwNTATxTtpSTBFHt+phgePlbgAPkPhtsSSbQyumzi3cenq8OjWmk9aZ8rJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eza55UVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3E6BC4CEF0;
	Tue, 30 Sep 2025 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=Ujr3vQFuXMf6tuVm3oUvumgJUXtr5UkQ7zY3FbabcwE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Eza55UVvDUj7YW+dNgKYtQcGRei4XushrLJ6rf4DQ5EMi3ZC1P1Qa3/cfvOMtefya
	 hwerQAJ8m+aZb0UJ9Tn36qQRemb6jhlUHkoPE7epvSHxBSjDFSfwlKyxji03YFO7fU
	 5tmTX/HWZKtQPUfsQPbhaVQ/9vUuF4Cb+U0biRxevlpO3Lbv6WvmKQrtBYoP1U7e55
	 vxIlD6Cn72xMTumNoaEdUbA1meNpjVuOtmwHNr7wK53enEri5a7sH3WdJtvT1f6tXy
	 iAcK8NKidwc+w9ObJS6y7ra5Ar7WXFbAOPRgqf7G7SyGOVzs7blF/G0fwHMFkX7BXN
	 aLYzn100OVGNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB283CAC5B8;
	Tue, 30 Sep 2025 15:32:42 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/9] iio: replace sprintf() with sysfs_emit() in
 .read_label() op
Date: Tue, 30 Sep 2025 16:33:09 +0100
Message-Id: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADX422gC/x3MTQqAIBBA4avIrBsw+yG7SrQwG2sgTLQiiO6et
 PwW7z2QKDIl6MUDkS5OvPuMshBgV+MXQp6zQUnVSF1JnOnCFCL7w6HdyPgz4GScsp2eqrqVkMs
 QyfH9X4fxfT8l4ggaZQAAAA==
X-Change-ID: 20250930-dev-sprintf-cleanup-baf2c89b3460
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sal@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=1637;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Ujr3vQFuXMf6tuVm3oUvumgJUXtr5UkQ7zY3FbabcwE=;
 b=8di7Bmh4STjVso35xo+9KoFdUYG/3kFvDlxCfrbNPZczY3HcMa1qMINHkm+pDpUfvfts8bioc
 0vUbXM82UdlCHOphjbqnfS1Pl5XtiZPD7W+NHWks0UvNAHjLFN35Mu9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

When looking at some drivers implementing the .read_label() callback it
came to my attention that there were some outliers using sprintf() (or
even snprintf() with PAGE_SIZE) instead of sysfs_emit(). This series
cleans that up. 

---
Nuno Sá (9):
      iio: adc: ad4030: replace sprintf() with sysfs_emit()
      iio: adc: ad7768-1: replace sprintf() with sysfs_emit()
      iio: adc: mcp3564: replace sprintf() with sysfs_emit()
      iio: adc: meson_saradc: replace sprintf() with sysfs_emit()
      iio: adc: mt6360-adc: replace snprintf() with sysfs_emit()
      iio: adc: pac1921: replace sprintf() with sysfs_emit()
      iio: adc: qcom-spmi-rradc: replace snprintf() with sysfs_emit()
      iio: position: hid-sensor-custom-intel-hinge: replace sprintf() with sysfs_emit()
      iio: resolver: ad2s1210: replace sprintf() with sysfs_emit()

 drivers/iio/adc/ad4030.c                           |  4 +--
 drivers/iio/adc/ad7768-1.c                         |  2 +-
 drivers/iio/adc/mcp3564.c                          |  2 +-
 drivers/iio/adc/meson_saradc.c                     |  6 ++---
 drivers/iio/adc/mt6360-adc.c                       |  2 +-
 drivers/iio/adc/pac1921.c                          |  8 +++---
 drivers/iio/adc/qcom-spmi-rradc.c                  |  2 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |  2 +-
 drivers/iio/resolver/ad2s1210.c                    | 30 +++++++++++-----------
 9 files changed, 29 insertions(+), 29 deletions(-)
---
base-commit: b9700f87939f0f477e5c00db817f54ab8a97702b
change-id: 20250930-dev-sprintf-cleanup-baf2c89b3460
--

Thanks!
- Nuno Sá



