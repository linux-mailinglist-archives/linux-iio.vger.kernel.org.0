Return-Path: <linux-iio+bounces-17673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230ACA7CE55
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C6A16B1C6
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EBF218EB4;
	Sun,  6 Apr 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qrKSPqdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52E1AC892;
	Sun,  6 Apr 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743948480; cv=none; b=MZIX1LmEXufUPw8okJ5TiYSbIXAIKjM4sdLTryzVAqVz1nNY6XlIwu4XAPNUK/em4vAgxDqR0DuiXNZTNHckvakjhQH29dhc41aUlVh8q8/wzSoVRuq0cndg8Ov4jITwYEp3H18VRTFsmHuTRxaWoZTPHJu3Ve2H1QwFx8Lwz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743948480; c=relaxed/simple;
	bh=Z53CsyLkLOlcVX0c5lfTQyLWkaBtTAkW9dGk+/vUJhE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fSFlk7Xye3stbmf+on7vbM9dGKTV0ii7FN2bBDz0TLtOIDpBQxUKgZaT9GYRkARg1w8zbsihp8af4cRxJnxCJc5Dz2QJqBzajQWQUuxNOUp8BTFwt8LKKOlXomyFlBwe5j3OmyuwzqVIPhXBVCe3YcHI9PXVaGE11Zpyg2gfeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qrKSPqdK; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743948460; x=1744207660;
	bh=Mj7B7z/hH6xtB7WLjolnDj4nK6PGPH60R2poCPHq4nU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=qrKSPqdKxQY538trIc6s/Ep9wAomkhZr/eXYz4kduC2s6K6SWvuHTyMdgJPysbl8Q
	 nPVlcjKngLCXeFIOM1/YDz52zPm9Zvz1o6xojtyGOKs4w9Zys88BUap2lRB8V4Vl2Y
	 7RBvu+8/9kz1TYXcf5JZwqqBs+L3Ca+7MKKI90Xr+wZHX+iU0Yi7g6n6HKV6gTNU5P
	 ZLyEpielmh3KimoVmvYj49GRtxpYhsbNwFDHnR1aLc8O5CyhmtDIdPo4VcX1xQeZb6
	 XrmZhROSiWuRJ+krWCgjuMQjVhk2S0B/ocFBPQSQ55pFPmi2LrbJ2T2/82LMjMrpIk
	 0ekHchRFTS49w==
Date: Sun, 06 Apr 2025 14:07:31 +0000
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
	<barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 0/3] QRTR bus and Qualcomm Sensor Manager IIO drivers
Message-ID: <20250406140706.812425-1-y.oudjana@protonmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 44e8b11f854e8cb929496223c17c7bee0ab18209
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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

This series adds kernel drivers for the Sensor Manager service, exposing
sensors accessible through it as IIO devices. To facilitate probing of the
Sensor Manager core driver, QRTR is turned into a bus, with services being
exposed as devices. Once the Sensor Manager service becomes available, the
kernel attaches its device to the driver added in this series. This allows
for dynamic probing of Sensor Manager without the need for static DT
bindings, which would also not be ideal because they would be describing
software rather than hardware. Sensor Manager is given as a working example
of the QRTR bus. Kernel drivers for other services may also be able
to benefit from this change.

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
[2] https://github.com/nian0114/android_vendor_xiaomi_scorpio/blob/mkn-mr1/=
proprietary/etc/sensors/sensor_def_qcomdev.conf
[3] https://github.com/sdm660-mainline/linux/pull/57
[4] https://emainline.gitlab.io/2022/04/08/Unlocking_SSC_P2.html
[5] https://android.googlesource.com/platform/system/chre/+/android-8.0.0_r=
2/platform/slpi
[6] https://gitlab.postmarketos.org/postmarketOS/pmaports/-/merge_requests/=
4118

Yassine Oudjana (3):
  net: qrtr: Turn QRTR into a bus
  net: qrtr: Define macro to convert QMI version and instance to QRTR
    instance
  iio: Add Qualcomm Sensor Manager drivers

 MAINTAINERS                                 |  18 +
 drivers/iio/accel/Kconfig                   |  10 +
 drivers/iio/accel/Makefile                  |   2 +
 drivers/iio/accel/qcom_smgr_accel.c         | 138 ++++
 drivers/iio/common/Kconfig                  |   1 +
 drivers/iio/common/Makefile                 |   1 +
 drivers/iio/common/qcom_smgr/Kconfig        |  16 +
 drivers/iio/common/qcom_smgr/Makefile       |   8 +
 drivers/iio/common/qcom_smgr/qcom_smgr.c    | 589 ++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/Makefile   |   3 +
 drivers/iio/common/qcom_smgr/qmi/sns_smgr.c | 711 ++++++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/sns_smgr.h | 163 +++++
 drivers/iio/gyro/Kconfig                    |  10 +
 drivers/iio/gyro/Makefile                   |   2 +
 drivers/iio/gyro/qcom_smgr_gyro.c           | 138 ++++
 drivers/iio/magnetometer/Kconfig            |   9 +
 drivers/iio/magnetometer/Makefile           |   2 +
 drivers/iio/magnetometer/qcom_smgr_mag.c    | 138 ++++
 drivers/iio/pressure/Kconfig                |  10 +
 drivers/iio/pressure/Makefile               |   1 +
 drivers/iio/pressure/qcom_smgr_pressure.c   | 106 +++
 drivers/iio/proximity/Kconfig               |  10 +
 drivers/iio/proximity/Makefile              |   1 +
 drivers/iio/proximity/qcom_smgr_prox.c      | 106 +++
 drivers/soc/qcom/qmi_interface.c            |   5 +-
 include/linux/iio/common/qcom_smgr.h        |  64 ++
 include/linux/mod_devicetable.h             |   9 +
 include/linux/soc/qcom/qrtr.h               |  36 +
 net/qrtr/af_qrtr.c                          |  23 +-
 net/qrtr/qrtr.h                             |   3 +
 net/qrtr/smd.c                              | 250 ++++++-
 scripts/mod/devicetable-offsets.c           |   4 +
 scripts/mod/file2alias.c                    |  10 +
 33 files changed, 2573 insertions(+), 24 deletions(-)
 create mode 100644 drivers/iio/accel/qcom_smgr_accel.c
 create mode 100644 drivers/iio/common/qcom_smgr/Kconfig
 create mode 100644 drivers/iio/common/qcom_smgr/Makefile
 create mode 100644 drivers/iio/common/qcom_smgr/qcom_smgr.c
 create mode 100644 drivers/iio/common/qcom_smgr/qmi/Makefile
 create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.c
 create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
 create mode 100644 drivers/iio/gyro/qcom_smgr_gyro.c
 create mode 100644 drivers/iio/magnetometer/qcom_smgr_mag.c
 create mode 100644 drivers/iio/pressure/qcom_smgr_pressure.c
 create mode 100644 drivers/iio/proximity/qcom_smgr_prox.c
 create mode 100644 include/linux/iio/common/qcom_smgr.h
 create mode 100644 include/linux/soc/qcom/qrtr.h

--=20
2.49.0



