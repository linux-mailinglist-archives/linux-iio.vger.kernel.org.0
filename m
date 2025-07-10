Return-Path: <linux-iio+bounces-21504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C1BAFFBB2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9CB1895FBD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65428BA88;
	Thu, 10 Jul 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKcHiVjk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3B28B4FC;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134791; cv=none; b=c5kesM8V8FuDOJkrSYA+4eGic+yUR41+8cZslT94uIkb0RHK4oe3Of7ENKNAj6xJFeHUWgziNZItiFVIK2SQBBDEGPFe6QS39qg0+zHxbKz93WHXkuLaXXugUAahVIUpXY6FYI/u2sRITZ8KIcrNSzsOGtA3eXRYM6GD1J1TcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134791; c=relaxed/simple;
	bh=Qdz0Seg600/NfZ8qh0A2H91OLBFUzDUq9XUtOoB6PgA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBEYI+27ZL19wicZ8b8ys3u8aMLWxoOaihLFCigYgGLd970hDmxxDrHmVkdsQJ/8mn5jO+30obHnlojSxC4sIumro0YBZB546yqnFWd2DBrG3iB/SKUcBq+mxJCrAWWRIuGm4HEpqfDJdeaXzHWQClEMyc+FxRLq86ht6wBlbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKcHiVjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 932E7C4CEE3;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134790;
	bh=Qdz0Seg600/NfZ8qh0A2H91OLBFUzDUq9XUtOoB6PgA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VKcHiVjkvIkYF3H/YhQGCwJ0nLT0W/IxmGGTBvVM59eo8x0Qh3jA90NKNU6B4Btyo
	 q0ZA2Y/SnchkV+mpaAVXzDjRqM0qBdk+IkY6uDdcotRMr8nt/JIqyv1h3bSmkR0QbQ
	 PiymNnfc1FjBgHBzE/xpzDubb3B3a4MZ6aW2uvMJEmxIRB8sPYRsN1iXXCEJJmP+dy
	 ZDHneKD9BtM4wTRsFElDht1e+FewVNKxv03yygXPWRofuT+T6y7C1bVanzwYFH0xW7
	 VwpyOkqyLsEFgeuPp67AnHY0XXTv9wxp/llT0omYocxYeCoD8Ipv1WVRiQHg8VuEEF
	 hws+qRu0GA8qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F11C83F1A;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
From: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>
Subject: [PATCH v2 0/4] QRTR bus and Qualcomm Sensor Manager IIO drivers
Date: Thu, 10 Jul 2025 09:06:26 +0100
Message-Id: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJ0b2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MD3cLk/Fzd4tz0Il2LlCRLsxRjc4MkQwMloPqCotS0zAqwWdGxtbU
 AE1gPnVsAAAA=
X-Change-ID: 20250710-qcom-smgr-8db96d370b10
To: Manivannan Sadhasivam <mani@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752134788; l=7200;
 i=y.oudjana@protonmail.com; s=20250710; h=from:subject:message-id;
 bh=Qdz0Seg600/NfZ8qh0A2H91OLBFUzDUq9XUtOoB6PgA=;
 b=jYuw5kDhYNu17UC7FXwR+r3E3JhLoV9iC6fqTVG8lW74iwK/Y/6q6S8qTRpQ5pmbAc2xJ3aJB
 1Fl+JwaxKjIA82Fib1rsFeL6qicvL51pRyO8Yp1zacVTInp19GEu0HB
X-Developer-Key: i=y.oudjana@protonmail.com; a=ed25519;
 pk=kZKEHR1e5QKCbhElU9LF/T1SbfTr8xzy2cO8fN70QgY=
X-Endpoint-Received: by B4 Relay for y.oudjana@protonmail.com/20250710 with
 auth_id=455
X-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: y.oudjana@protonmail.com

Sensor Manager is a QMI service available on several Qualcomm SoCs which
exposes available sensors and allows for getting data from them. This
service is provided by either:

- SSC (Snapdragon Sensor Core): Also known as SLPI (Sensor Low Power
  Island). Has its own set of pins and peripherals to which sensors are
  connected. These peripherals are generally inaccessible from the AP,
  meaning sensors need to be operated exclusively through SSC. The only
  known SoCs in this category are MSM8996 and MSM8998 (and their
  derivatives).
- ADSP (Audio DSP): Shares pins and peripherals with the AP. At least on
  some devices, these pins could be configured as GPIOs which allows the AP
  to access sensors by bit-banging their interfaces. Some SoCs in this
  category are SDM630/660, MSM8953, MSM8974 and MSM8226.

Before Sensor Manager becomes accessible, another service known as Sensor
Registry needs to be provided by the AP. The remote processor that provides
Sensor Manager will then request data from it, and once that process is
done, will expose several services including Sensor Manager.

This series adds a kernel driver for the Sensor Manager service, exposing
sensors accessible through it as IIO devices. To facilitate probing of this
 driver, QRTR is turned into a bus, with services being exposed as devices.
Once the Sensor Manager service becomes available, the kernel attaches its
device to the driver added in this series. This allows for dynamic probing
of Sensor Manager without the need for static DT bindings, which would also
not be ideal because they would be describing software rather than
hardware. Sensor Manager is given as a working example of the QRTR bus.
Kernel drivers for other services may also be able to benefit from this
change.

As previously mentioned, a Sensor Registry server must run on the AP to
provide the remote processor (either SLPI or ADSP) with necessary data.
A userspace implementation of this server is made[1]. The server can be
supplied with the necessary data in the form of a plain-text configuration
file that can be pulled from the Android vendor partition (sample[2]), or
generated from a binary file that can be pulled from the persist partition.
A more recently developed kernel implementation of the Sensor Registry
server[3] can also be used. This last implementation only supports reading
data from the binary file pulled from persist. Sensor Registry remains out
of the scope of this patch series, as the Sensor Registry server and Sensor
Manager client (this series) are fully independent components.

Due to the total lack of documentation on Sensor Manager, this driver was
almost entirely the result of a process of capturing transactions between
SSC and the proprietary Android daemons with several methods and manually
decoding and interpreting them, sometimes by comparing with values acquired
from Android APIs. A blog post[4] describes part of this process more
detail. A little piece of downstream Android open-source code[5] was also
used as reference during later stages of development. All of this, as well
as a lack of time on my side for the last couple of years, meant that this
driver had to go through a slow and intermittent development process for
more than 3 years before reaching its current state.

Currently supported sensor types include accelerometers, gyroscopes,
magentometers, proximity and pressure sensors. Other types (namely
light and temperature sensors) are close to being implemented.

Some testing instructions may also be found here[6].

[1] https://gitlab.com/msm8996-mainline/sns-reg
[2] https://github.com/nian0114/android_vendor_xiaomi_scorpio/blob/mkn-mr1/proprietary/etc/sensors/sensor_def_qcomdev.conf
[3] https://github.com/sdm660-mainline/linux/pull/57
[4] https://emainline.gitlab.io/2022/04/08/Unlocking_SSC_P2.html
[5] https://android.googlesource.com/platform/system/chre/+/android-8.0.0_r2/platform/slpi
[6] https://gitlab.postmarketos.org/postmarketOS/pmaports/-/merge_requests/4118

Changes since v1:
- Split qdev renaming into separate patch
- Export new QRTR symbols with namespace
- Change struct initialization style
- Remove redundant NULL initialization of qdev->dev.driver
- Remove redundant devm_kfree
- Use variable in sizeof rather than type
- Change error return style in qcom_smd_qrtr_init
- Change order of operations in qcom_smd_qrtr_exit
- Use FIELD_PREP and GENMASK in QRTR_INSTANCE macro and add a CONST variant
- Remove per-sensor subdrivers and eliminate use of platform devices
- Put year range in copyright statements
- Use dev_err_probe for error messages in probe
- Remove unused include of linux/of.h
- Avoid casting away const in qcom_smgr_buffering_report_handler
- Use iio_push_to_buffers instead of iio_push_to_buffers_with_timestamp
- Preprocess proximity sensor data before pushing to buffer
- Add warning message for report with unknown ID received
- Change sentinel value style in array of struct initialization
- Refuse to set sampling frequency when buffer enabled
- Return -EINVAL inside default case in all applicable switch statements
- Move samp_freq_vals in qcom_smgr_iio_read_avail to priv and fix maximum
- Add devm_add_action_or_reset for releasing QMI handle and get rid of
  qcom_smgr_remove
- Add service versions and instance IDs found on some platforms to QRTR
  match table
- Fix null pointer dereference on registering unsupported sensor

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Yassine Oudjana (4):
      net: qrtr: smd: Rename qdev to qsdev
      net: qrtr: Turn QRTR into a bus
      net: qrtr: Define macro to convert QMI version and instance to QRTR instance
      iio: Add Qualcomm Sensor Manager driver

 MAINTAINERS                                     |  13 +
 drivers/iio/accel/qcom_smgr_accel.c             | 138 ++++
 drivers/iio/common/Kconfig                      |   1 +
 drivers/iio/common/Makefile                     |   1 +
 drivers/iio/common/qcom_smgr/Kconfig            |  16 +
 drivers/iio/common/qcom_smgr/Makefile           |   8 +
 drivers/iio/common/qcom_smgr/qcom_smgr.c        | 840 ++++++++++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/Makefile       |   3 +
 drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c | 713 ++++++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h | 161 +++++
 drivers/soc/qcom/qmi_interface.c                |   5 +-
 include/linux/iio/common/qcom_smgr.h            |  80 +++
 include/linux/mod_devicetable.h                 |   9 +
 include/linux/soc/qcom/qrtr.h                   |  46 ++
 net/qrtr/af_qrtr.c                              |  23 +-
 net/qrtr/qrtr.h                                 |   3 +
 net/qrtr/smd.c                                  | 252 ++++++-
 scripts/mod/devicetable-offsets.c               |   4 +
 scripts/mod/file2alias.c                        |  10 +
 19 files changed, 2302 insertions(+), 24 deletions(-)
---
base-commit: 835244aba90de290b4b0b1fa92b6734f3ee7b3d9
change-id: 20250710-qcom-smgr-8db96d370b10

Best regards,
-- 
Yassine Oudjana <y.oudjana@protonmail.com>



