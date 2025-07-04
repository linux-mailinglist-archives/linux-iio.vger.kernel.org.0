Return-Path: <linux-iio+bounces-21341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C806AF8DF1
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 11:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3B2765651
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E12F3C1B;
	Fri,  4 Jul 2025 09:03:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF582FA638;
	Fri,  4 Jul 2025 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619809; cv=none; b=sjFR/CzOp306LQznfW3DLivfogW5gZPyEmp8vn1FWusLFYQQgI2aTCxW1b3jnLl0tOlXraBPa/8U7dMMnx0GecwXOxfjnr1wWhIAKOIPKOxpmuvW8elCZrDg2jo5ya255IsD4+BljO6cpcB1Yjmpq0fYmxdzMO4iEDeSKwuhgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619809; c=relaxed/simple;
	bh=fSyPsCt8IzLyZq79hRzLIJk/sieMUnXURwoScy/WTtg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG6HocnjohOAIoHLHMwvrgP3eFju2mfprdijVjKWFSF/69LsWZf+jiYeN4BWbbn6UIy2nII/iw+sysEjmA8EeFZ9fAJKn45+VKJnMPDXtVPpS7V3KAe2y7yshXuwiEjyWr3kGhFdS6BB9mbxu1yvI4Zb8Amk5N1wuewJkslebOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYSMZ5x0mz67QRQ;
	Fri,  4 Jul 2025 17:02:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 948EF1402F1;
	Fri,  4 Jul 2025 17:03:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 11:03:22 +0200
Date: Fri, 4 Jul 2025 10:03:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 00/80] treewide: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250704100320.0000303b@huawei.com>
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri,  4 Jul 2025 10:52:25 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hello everyone,
> 
> Late last year I posted a set to switch to __pm_runtime_mark_last_busy()
> and gradually get rid of explicit pm_runtime_mark_last_busy() calls in
> drivers, embedding them in the appropriate pm_runtime_*autosuspend*()
> calls. The overall feedback I got at the time was that this is an
> unnecessary intermediate step, and removing the
> pm_runtime_mark_last_busy() calls can be done after adding them to the
> relevant Runtime PM autosuspend related functions. The latter part has
> been done and is present in Rafael's tree at the moment, also see
> <URL:https://lore.kernel.org/linux-pm/CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com/>:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> 		pm-runtime-6.17-rc1
> 
> So before merging these, please pull Rafael's tag. My thinking is indeed
> these would be best merged via the respective trees as there's some
> potential for conflicts (there are around 920 call sites modified here).
> 
> These patches are on next-20250701.

Hi Sakari,

Great change in general - however...

I'd much of preferred to see a per subsystem series for this rather than
all together.  That would have avoided the back reference to this cover letter
in each patch.  Also would have provided a subsystem specific cover letter
for people to reply with general comments and tags.

As you note there is no need for these all to land together and the
expectation is they will go through subsystem trees.

Grouping by 'type' of driver is a good step though, so thanks for doing that.

Ah well, I guess I'll cherry-pick the IIO ones from this series.

Jonathan

> 
> The changes in these have been generated using the following Coccinelle
> patch:
> 
> -----------8<-----------------------------
> @@
> expression E;
> identifier label, rval;
> @@
> - pm_runtime_mark_last_busy(E);
> ...
> (
>   label:
> |
> )
> ...
> (
>   pm_runtime_put_autosuspend(E);
> |
>   pm_runtime_put_sync_autosuspend(E);
> |
>   pm_runtime_autosuspend(E);
> |
>   pm_request_autosuspend(E);
> |
>   (void)pm_runtime_put_autosuspend(E);
> |
>   (void)pm_runtime_put_sync_autosuspend(E);
> |
>   (void)pm_runtime_autosuspend(E);
> |
>   (void)pm_request_autosuspend(E);
> |
>   return pm_runtime_put_autosuspend(E);
> |
>   return pm_runtime_put_sync_autosuspend(E);
> |
>   return pm_runtime_autosuspend(E);
> |
>   return pm_request_autosuspend(E);
> |
>   rval = pm_runtime_put_autosuspend(E);
> |
>   rval = pm_runtime_put_sync_autosuspend(E);
> |
>   rval = pm_runtime_autosuspend(E);
> |
>   rval = pm_request_autosuspend(E);
> )
> -----------8<-----------------------------
> 
> Sakari Ailus (80):
>   accel/ivpu: Remove redundant pm_runtime_mark_last_busy() calls
>   accel/amdxdna: Remove redundant pm_runtime_mark_last_busy() calls
>   Bluetooth: Remove redundant pm_runtime_mark_last_busy() calls
>   bus: sunxi-rsb: Remove redundant pm_runtime_mark_last_busy() calls
>   hwrng: Remove redundant pm_runtime_mark_last_busy() calls
>   clk: imx: Remove redundant pm_runtime_mark_last_busy() calls
>   clk: qcom: Remove redundant pm_runtime_mark_last_busy() calls
>   crypto: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: at_xdmac: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   dmaengine: pl330: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: qcom: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: ste_dma40: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   dmaengine: ti: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: zynqmp_dma: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   gpio: arizona: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/amd: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/nouveau: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/radeon: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/panfrost: Remove redundant pm_runtime_mark_last_busy() calls
>   drivers: drm: Remove redundant pm_runtime_mark_last_busy() calls
>   HSI: omap_ssi_port: Remove redundant pm_runtime_mark_last_busy() calls
>   stm class: Remove redundant pm_runtime_mark_last_busy() calls
>   i2c: Remove redundant pm_runtime_mark_last_busy() calls
>   i3c: master: svc: Remove redundant pm_runtime_mark_last_busy() calls
>   i3c: dw: Remove redundant pm_runtime_mark_last_busy() calls
>   HID: intel-thc-hid: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: accel: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: adc: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: common: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: dac: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: light: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: magnetometer: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: pressure: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: proximity: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls
>   Input: omap4-keypad: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   Input: cs40l50: Remove redundant pm_runtime_mark_last_busy() calls
>   media: Remove redundant pm_runtime_mark_last_busy() calls
>   mfd: Remove redundant pm_runtime_mark_last_busy() calls
>   mei: Remove redundant pm_runtime_mark_last_busy() calls
>   mmc: Remove redundant pm_runtime_mark_last_busy() calls
>   mtd: rawnand: gpmi: Remove redundant pm_runtime_mark_last_busy() calls
>   net: ethernet: Remove redundant pm_runtime_mark_last_busy() calls
>   net: ipa: Remove redundant pm_runtime_mark_last_busy() calls
>   net: wireless: Remove redundant pm_runtime_mark_last_busy() calls
>   net: wwan: Remove redundant pm_runtime_mark_last_busy() calls
>   nfc: trf7970a: Remove redundant pm_runtime_mark_last_busy() calls
>   PCI/portdrv: Remove redundant pm_runtime_mark_last_busy() calls
>   phy: motorola: phy-mapphone-mdm6600: Remove redundant
>     pm_runtime_mark_last_busy() calls
>   phy: ti: phy-twl4030-usb: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   power: supply: bq24190: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   power: supply: twl4030_charger: Remove redundant
>     pm_runtime_mark_last_busy() calls
>   pwm: img: Remove redundant pm_runtime_mark_last_busy() calls
>   regulator: stm32-vrefbuf: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   remoteproc: omap: Remove redundant pm_runtime_mark_last_busy() calls
>   slimbus: Remove redundant pm_runtime_mark_last_busy() calls
>   soundwire: Remove redundant pm_runtime_mark_last_busy() calls
>   spi: Remove redundant pm_runtime_mark_last_busy() calls
>   staging: greybus: Remove redundant pm_runtime_mark_last_busy() calls
>   greybus: Remove redundant pm_runtime_mark_last_busy() calls
>   media: rkvdec: Remove redundant pm_runtime_mark_last_busy() calls
>   thunderbolt: Remove redundant pm_runtime_mark_last_busy() calls
>   serial: Remove redundant pm_runtime_mark_last_busy() calls
>   usb: Remove redundant pm_runtime_mark_last_busy() calls
>   w1: omap-hdq: Remove redundant pm_runtime_mark_last_busy() calls
>   ALSA: hda: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: atmel: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: codecs: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: Intel: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: component: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: SOF: Remove redundant pm_runtime_mark_last_busy() calls
>   ALSA: intel_hdmi: Remove redundant pm_runtime_mark_last_busy() calls
>   soc: apple: mailbox: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   block: pm: Remove redundant pm_runtime_mark_last_busy() calls
>   Input: cyapa - Remove redundant pm_runtime_mark_last_busy() calls
>   mei: Remove redundant pm_runtime_mark_last_busy() calls
>   scsi: block: pm: Remove redundant pm_runtime_mark_last_busy() calls
> 
>  block/blk-pm.c                                |  1 -
>  drivers/accel/amdxdna/amdxdna_pci_drv.c       |  3 --
>  drivers/accel/ivpu/ivpu_job.c                 |  1 -
>  drivers/accel/ivpu/ivpu_pm.c                  |  2 --
>  drivers/bluetooth/btmtksdio.c                 |  1 -
>  drivers/bluetooth/hci_bcm.c                   |  3 --
>  drivers/bluetooth/hci_h5.c                    |  2 --
>  drivers/bluetooth/hci_intel.c                 |  3 --
>  drivers/bus/sunxi-rsb.c                       |  2 --
>  drivers/char/hw_random/atmel-rng.c            |  1 -
>  drivers/char/hw_random/cctrng.c               |  1 -
>  drivers/char/hw_random/mtk-rng.c              |  1 -
>  drivers/char/hw_random/npcm-rng.c             |  1 -
>  drivers/char/hw_random/omap3-rom-rng.c        |  1 -
>  drivers/char/hw_random/rockchip-rng.c         |  3 --
>  drivers/char/hw_random/stm32-rng.c            |  1 -
>  drivers/clk/imx/clk-imx8qxp-lpcg.c            |  1 -
>  drivers/clk/imx/clk-scu.c                     |  1 -
>  drivers/clk/qcom/lpassaudiocc-sc7280.c        |  2 --
>  drivers/clk/qcom/lpasscorecc-sc7180.c         |  2 --
>  drivers/crypto/ccree/cc_pm.c                  |  1 -
>  drivers/crypto/hisilicon/qm.c                 |  1 -
>  drivers/crypto/omap-aes-gcm.c                 |  1 -
>  drivers/crypto/omap-aes.c                     |  1 -
>  drivers/crypto/omap-des.c                     |  1 -
>  drivers/crypto/omap-sham.c                    |  1 -
>  drivers/crypto/stm32/stm32-cryp.c             |  1 -
>  drivers/crypto/stm32/stm32-hash.c             |  1 -
>  drivers/dma/at_xdmac.c                        | 11 ------
>  drivers/dma/pl330.c                           |  5 ---
>  drivers/dma/qcom/bam_dma.c                    |  5 ---
>  drivers/dma/qcom/hidma.c                      |  9 -----
>  drivers/dma/qcom/hidma_dbg.c                  |  1 -
>  drivers/dma/qcom/hidma_mgmt.c                 |  2 --
>  drivers/dma/ste_dma40.c                       |  8 -----
>  drivers/dma/ti/cppi41.c                       |  5 ---
>  drivers/dma/xilinx/zynqmp_dma.c               |  2 --
>  drivers/gpio/gpio-arizona.c                   |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  1 -
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  4 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 25 -------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  1 -
>  .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  1 -
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 -
>  .../drm/bridge/analogix/analogix_dp_core.c    |  2 --
>  drivers/gpu/drm/bridge/analogix/anx7625.c     |  2 --
>  drivers/gpu/drm/bridge/parade-ps8640.c        |  2 --
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  1 -
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  4 ---
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c      |  2 --
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c       |  2 --
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c       |  2 --
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c   |  1 -
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c    |  1 -
>  drivers/gpu/drm/i915/intel_runtime_pm.c       |  2 --
>  drivers/gpu/drm/imx/dcss/dcss-crtc.c          |  1 -
>  drivers/gpu/drm/lima/lima_sched.c             |  1 -
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       |  2 --
>  drivers/gpu/drm/nouveau/nouveau_connector.c   |  1 -
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c     |  1 -
>  drivers/gpu/drm/nouveau/nouveau_display.c     |  1 -
>  drivers/gpu/drm/nouveau/nouveau_drm.c         |  4 ---
>  drivers/gpu/drm/nouveau/nouveau_gem.c         |  3 --
>  drivers/gpu/drm/panel/panel-edp.c             |  3 --
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  |  2 --
>  drivers/gpu/drm/panel/panel-simple.c          |  2 --
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  2 --
>  drivers/gpu/drm/panthor/panthor_sched.c       |  2 --
>  drivers/gpu/drm/radeon/radeon_acpi.c          |  1 -
>  drivers/gpu/drm/radeon/radeon_connectors.c    |  5 ---
>  drivers/gpu/drm/radeon/radeon_display.c       |  2 --
>  drivers/gpu/drm/radeon/radeon_drv.c           |  2 --
>  drivers/gpu/drm/radeon/radeon_fbdev.c         |  2 --
>  drivers/gpu/drm/radeon/radeon_kms.c           |  4 ---
>  drivers/gpu/drm/tegra/submit.c                |  1 -
>  drivers/gpu/drm/tidss/tidss_drv.c             |  2 --
>  drivers/gpu/drm/vc4/vc4_v3d.c                 |  1 -
>  drivers/greybus/bundle.c                      |  1 -
>  drivers/greybus/interface.c                   |  1 -
>  .../intel-quicki2c/pci-quicki2c.c             |  2 --
>  .../intel-quicki2c/quicki2c-hid.c             |  1 -
>  .../intel-quickspi/pci-quickspi.c             |  2 --
>  .../intel-quickspi/quickspi-hid.c             |  1 -
>  drivers/hsi/controllers/omap_ssi_port.c       | 11 ------
>  drivers/hwtracing/stm/core.c                  |  3 --
>  drivers/i2c/busses/i2c-amd-mp2.h              |  1 -
>  drivers/i2c/busses/i2c-at91-core.c            |  1 -
>  drivers/i2c/busses/i2c-at91-master.c          |  1 -
>  drivers/i2c/busses/i2c-cadence.c              |  1 -
>  drivers/i2c/busses/i2c-davinci.c              |  2 --
>  drivers/i2c/busses/i2c-designware-master.c    |  1 -
>  drivers/i2c/busses/i2c-hix5hd2.c              |  1 -
>  drivers/i2c/busses/i2c-i801.c                 |  1 -
>  drivers/i2c/busses/i2c-img-scb.c              |  3 --
>  drivers/i2c/busses/i2c-imx-lpi2c.c            |  4 ---
>  drivers/i2c/busses/i2c-imx.c                  |  3 --
>  drivers/i2c/busses/i2c-mv64xxx.c              |  1 -
>  drivers/i2c/busses/i2c-nvidia-gpu.c           |  1 -
>  drivers/i2c/busses/i2c-omap.c                 |  3 --
>  drivers/i2c/busses/i2c-qcom-cci.c             |  2 --
>  drivers/i2c/busses/i2c-qcom-geni.c            |  1 -
>  drivers/i2c/busses/i2c-qup.c                  |  3 --
>  drivers/i2c/busses/i2c-riic.c                 |  2 --
>  drivers/i2c/busses/i2c-rzv2m.c                |  1 -
>  drivers/i2c/busses/i2c-sprd.c                 |  2 --
>  drivers/i2c/busses/i2c-stm32f7.c              |  5 ---
>  drivers/i2c/busses/i2c-xiic.c                 |  1 -
>  drivers/i3c/master/dw-i3c-master.c            |  8 -----
>  drivers/i3c/master/svc-i3c-master.c           |  8 -----
>  drivers/iio/accel/bmc150-accel-core.c         |  1 -
>  drivers/iio/accel/bmi088-accel-core.c         |  3 --
>  drivers/iio/accel/fxls8962af-core.c           |  1 -
>  drivers/iio/accel/kxcjk-1013.c                |  1 -
>  drivers/iio/accel/kxsd9.c                     |  3 --
>  drivers/iio/accel/mma8452.c                   |  1 -
>  drivers/iio/accel/mma9551_core.c              |  1 -
>  drivers/iio/accel/msa311.c                    |  6 ----
>  drivers/iio/adc/ab8500-gpadc.c                |  1 -
>  drivers/iio/adc/at91-sama5d2_adc.c            | 10 ------
>  drivers/iio/adc/imx8qxp-adc.c                 |  2 --
>  drivers/iio/adc/imx93_adc.c                   |  1 -
>  drivers/iio/adc/rcar-gyroadc.c                |  1 -
>  drivers/iio/adc/rzg2l_adc.c                   |  3 --
>  drivers/iio/adc/stm32-adc-core.c              |  1 -
>  drivers/iio/adc/stm32-adc.c                   |  7 ----
>  drivers/iio/adc/sun4i-gpadc-iio.c             |  2 --
>  drivers/iio/adc/ti-ads1015.c                  |  1 -
>  drivers/iio/adc/ti-ads1100.c                  |  1 -
>  drivers/iio/adc/ti-ads1119.c                  |  2 --
>  drivers/iio/chemical/atlas-sensor.c           |  2 --
>  drivers/iio/chemical/bme680_core.c            |  3 --
>  .../common/hid-sensors/hid-sensor-trigger.c   |  1 -
>  drivers/iio/dac/stm32-dac.c                   |  3 --
>  drivers/iio/gyro/bmg160_core.c                |  1 -
>  drivers/iio/gyro/fxas21002c_core.c            |  2 --
>  drivers/iio/gyro/mpu3050-core.c               |  3 --
>  drivers/iio/gyro/mpu3050-i2c.c                |  1 -
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  5 ---
>  .../imu/inv_icm42600/inv_icm42600_buffer.c    |  1 -
>  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  5 ---
>  .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  1 -
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  6 ----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  1 -
>  drivers/iio/imu/kmx61.c                       |  1 -
>  drivers/iio/light/apds9306.c                  |  2 --
>  drivers/iio/light/apds9960.c                  |  1 -
>  drivers/iio/light/bh1780.c                    |  1 -
>  drivers/iio/light/gp2ap002.c                  |  2 --
>  drivers/iio/light/isl29028.c                  |  1 -
>  drivers/iio/light/ltrf216a.c                  |  1 -
>  drivers/iio/light/pa12203001.c                |  1 -
>  drivers/iio/light/rpr0521.c                   |  1 -
>  drivers/iio/light/tsl2583.c                   |  1 -
>  drivers/iio/light/tsl2591.c                   |  2 --
>  drivers/iio/light/us5182d.c                   |  1 -
>  drivers/iio/light/vcnl4000.c                  |  1 -
>  drivers/iio/light/vcnl4035.c                  |  1 -
>  drivers/iio/magnetometer/ak8974.c             |  2 --
>  drivers/iio/magnetometer/ak8975.c             |  1 -
>  drivers/iio/magnetometer/als31300.c           |  2 --
>  drivers/iio/magnetometer/bmc150_magn.c        |  1 -
>  drivers/iio/magnetometer/tmag5273.c           |  2 --
>  drivers/iio/magnetometer/yamaha-yas530.c      |  2 --
>  drivers/iio/pressure/bmp280-core.c            |  5 ---
>  drivers/iio/pressure/icp10100.c               |  1 -
>  drivers/iio/pressure/mpl115.c                 |  2 --
>  drivers/iio/pressure/zpa2326.c                |  2 --
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  1 -
>  drivers/iio/proximity/srf04.c                 |  1 -
>  drivers/iio/temperature/mlx90614.c            |  1 -
>  drivers/iio/temperature/mlx90632.c            |  1 -
>  drivers/iio/temperature/mlx90635.c            |  1 -
>  drivers/input/keyboard/omap4-keypad.c         |  4 ---
>  drivers/input/misc/cs40l50-vibra.c            |  4 ---
>  drivers/input/mouse/cyapa.c                   |  3 --
>  drivers/input/mouse/cyapa_gen5.c              |  1 -
>  drivers/media/i2c/alvium-csi2.c               |  1 -
>  drivers/media/i2c/ccs/ccs-core.c              |  4 ---
>  drivers/media/i2c/dw9768.c                    |  1 -
>  drivers/media/i2c/gc0308.c                    |  3 --
>  drivers/media/i2c/gc2145.c                    |  3 --
>  drivers/media/i2c/imx219.c                    |  2 --
>  drivers/media/i2c/imx283.c                    |  3 --
>  drivers/media/i2c/imx290.c                    |  3 --
>  drivers/media/i2c/imx296.c                    |  1 -
>  drivers/media/i2c/imx415.c                    |  1 -
>  drivers/media/i2c/mt9m114.c                   |  6 ----
>  drivers/media/i2c/ov4689.c                    |  3 --
>  drivers/media/i2c/ov5640.c                    |  4 ---
>  drivers/media/i2c/ov5645.c                    |  3 --
>  drivers/media/i2c/ov64a40.c                   |  4 ---
>  drivers/media/i2c/ov8858.c                    |  2 --
>  drivers/media/i2c/st-mipid02.c                |  2 --
>  drivers/media/i2c/tc358746.c                  |  5 ---
>  drivers/media/i2c/thp7312.c                   |  4 ---
>  drivers/media/i2c/vd55g1.c                    |  4 ---
>  drivers/media/i2c/vd56g3.c                    |  4 ---
>  drivers/media/i2c/video-i2c.c                 |  4 ---
>  .../chips-media/wave5/wave5-vpu-dec.c         |  4 ---
>  .../chips-media/wave5/wave5-vpu-enc.c         |  5 ---
>  .../media/platform/nvidia/tegra-vde/h264.c    |  2 --
>  .../media/platform/qcom/iris/iris_hfi_queue.c |  1 -
>  .../platform/raspberrypi/pisp_be/pisp_be.c    |  2 --
>  .../media/platform/verisilicon/hantro_drv.c   |  1 -
>  drivers/media/rc/gpio-ir-recv.c               |  1 -
>  drivers/mfd/arizona-irq.c                     |  1 -
>  drivers/mfd/cs40l50-core.c                    |  1 -
>  drivers/mfd/cs42l43.c                         |  1 -
>  drivers/misc/mei/client.c                     |  9 -----
>  drivers/misc/mei/interrupt.c                  |  2 --
>  drivers/mmc/core/core.c                       |  1 -
>  drivers/mmc/host/atmel-mci.c                  |  2 --
>  drivers/mmc/host/mmci.c                       |  1 -
>  drivers/mmc/host/omap_hsmmc.c                 |  3 --
>  drivers/mmc/host/sdhci-esdhc-imx.c            |  1 -
>  drivers/mmc/host/sdhci-msm.c                  |  1 -
>  drivers/mmc/host/sdhci-omap.c                 |  2 --
>  drivers/mmc/host/sdhci-pxav3.c                |  2 --
>  drivers/mmc/host/sdhci-sprd.c                 |  1 -
>  drivers/mmc/host/sdhci_am654.c                |  1 -
>  drivers/mmc/host/tmio_mmc_core.c              |  1 -
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c    |  3 --
>  drivers/net/ethernet/cadence/macb_main.c      |  5 ---
>  drivers/net/ethernet/freescale/fec_main.c     |  8 -----
>  drivers/net/ethernet/renesas/ravb_main.c      |  4 ---
>  drivers/net/ethernet/ti/davinci_mdio.c        |  7 ----
>  drivers/net/ipa/ipa_interrupt.c               |  1 -
>  drivers/net/ipa/ipa_main.c                    |  1 -
>  drivers/net/ipa/ipa_modem.c                   |  4 ---
>  drivers/net/ipa/ipa_smp2p.c                   |  2 --
>  drivers/net/ipa/ipa_uc.c                      |  2 --
>  drivers/net/wireless/ath/wil6210/pm.c         |  1 -
>  drivers/net/wireless/ti/wl18xx/debugfs.c      |  3 --
>  drivers/net/wireless/ti/wlcore/cmd.c          |  1 -
>  drivers/net/wireless/ti/wlcore/debugfs.c      | 11 ------
>  drivers/net/wireless/ti/wlcore/main.c         | 36 -------------------
>  drivers/net/wireless/ti/wlcore/scan.c         |  1 -
>  drivers/net/wireless/ti/wlcore/sysfs.c        |  1 -
>  drivers/net/wireless/ti/wlcore/testmode.c     |  2 --
>  drivers/net/wireless/ti/wlcore/tx.c           |  1 -
>  drivers/net/wireless/ti/wlcore/vendor_cmd.c   |  3 --
>  drivers/net/wwan/qcom_bam_dmux.c              |  2 --
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.c        |  3 --
>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c    |  2 --
>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c    |  2 --
>  drivers/nfc/trf7970a.c                        |  1 -
>  drivers/pci/pcie/portdrv.c                    |  1 -
>  drivers/phy/motorola/phy-mapphone-mdm6600.c   |  2 --
>  drivers/phy/ti/phy-twl4030-usb.c              |  3 --
>  drivers/power/supply/bq24190_charger.c        | 14 --------
>  drivers/power/supply/twl4030_charger.c        |  1 -
>  drivers/pwm/pwm-img.c                         |  2 --
>  drivers/regulator/stm32-vrefbuf.c             |  6 ----
>  drivers/remoteproc/omap_remoteproc.c          |  3 --
>  drivers/scsi/scsi_pm.c                        |  1 -
>  drivers/slimbus/core.c                        |  1 -
>  drivers/slimbus/messaging.c                   |  2 --
>  drivers/slimbus/qcom-ctrl.c                   |  1 -
>  drivers/soc/apple/mailbox.c                   |  1 -
>  drivers/soundwire/bus.c                       |  1 -
>  drivers/soundwire/cadence_master.c            |  1 -
>  drivers/soundwire/qcom.c                      |  3 --
>  drivers/spi/atmel-quadspi.c                   |  5 ---
>  drivers/spi/spi-cadence-quadspi.c             |  2 --
>  drivers/spi/spi-cadence.c                     |  1 -
>  drivers/spi/spi-fsl-espi.c                    |  2 --
>  drivers/spi/spi-fsl-lpspi.c                   |  2 --
>  drivers/spi/spi-imx.c                         |  3 --
>  drivers/spi/spi-mtk-nor.c                     |  1 -
>  drivers/spi/spi-nxp-fspi.c                    |  1 -
>  drivers/spi/spi-omap2-mcspi.c                 |  3 --
>  drivers/spi/spi-rockchip-sfc.c                |  3 --
>  drivers/spi/spi-s3c64xx.c                     |  3 --
>  drivers/spi/spi-sprd.c                        |  1 -
>  drivers/spi/spi-stm32-ospi.c                  |  7 ----
>  drivers/spi/spi-stm32-qspi.c                  |  7 ----
>  drivers/spi/spi-stm32.c                       |  2 --
>  drivers/spi/spi-ti-qspi.c                     |  2 --
>  drivers/spi/spi-zynqmp-gqspi.c                |  1 -
>  drivers/spi/spi.c                             |  3 --
>  drivers/staging/greybus/gbphy.c               |  1 -
>  drivers/staging/greybus/gbphy.h               |  1 -
>  drivers/staging/media/rkvdec/rkvdec.c         |  1 -
>  drivers/thunderbolt/debugfs.c                 | 11 ------
>  drivers/thunderbolt/domain.c                  |  2 --
>  drivers/thunderbolt/icm.c                     |  7 ----
>  drivers/thunderbolt/retimer.c                 |  2 --
>  drivers/thunderbolt/switch.c                  |  4 ---
>  drivers/thunderbolt/tb.c                      |  9 -----
>  drivers/thunderbolt/usb4_port.c               |  2 --
>  drivers/tty/serial/8250/8250_omap.c           |  9 -----
>  drivers/tty/serial/8250/8250_port.c           |  2 --
>  drivers/tty/serial/fsl_lpuart.c               |  1 -
>  drivers/tty/serial/serial_core.c              |  1 -
>  drivers/tty/serial/uartlite.c                 |  2 --
>  drivers/tty/serial/xilinx_uartps.c            |  1 -
>  drivers/usb/cdns3/cdns3-gadget.c              |  1 -
>  drivers/usb/cdns3/cdnsp-gadget.c              |  1 -
>  drivers/usb/chipidea/core.c                   |  1 -
>  drivers/usb/chipidea/otg_fsm.c                |  1 -
>  drivers/usb/dwc3/core.c                       |  2 --
>  drivers/usb/dwc3/dwc3-am62.c                  |  1 -
>  drivers/usb/dwc3/dwc3-imx8mp.c                |  1 -
>  drivers/usb/dwc3/dwc3-pci.c                   |  1 -
>  drivers/usb/dwc3/dwc3-xilinx.c                |  1 -
>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.c   |  1 -
>  drivers/usb/host/xhci-mtk.c                   |  1 -
>  drivers/usb/host/xhci-tegra.c                 |  1 -
>  drivers/usb/misc/apple-mfi-fastcharge.c       |  1 -
>  drivers/usb/mtu3/mtu3_plat.c                  |  1 -
>  drivers/usb/musb/musb_core.c                  |  5 ---
>  drivers/usb/musb/musb_debugfs.c               |  5 ---
>  drivers/usb/musb/musb_dsps.c                  |  1 -
>  drivers/usb/musb/musb_gadget.c                |  4 ---
>  drivers/usb/musb/omap2430.c                   |  1 -
>  drivers/w1/masters/omap_hdq.c                 |  5 ---
>  sound/hda/hdac_device.c                       |  1 -
>  sound/pci/hda/cs35l41_hda.c                   |  4 ---
>  sound/pci/hda/cs35l56_hda.c                   |  1 -
>  sound/pci/hda/tas2781_hda_i2c.c               |  3 --
>  sound/pci/hda/tas2781_hda_spi.c               |  4 ---
>  sound/soc/atmel/mchp-spdifrx.c                |  6 ----
>  sound/soc/codecs/arizona-jack.c               |  2 --
>  sound/soc/codecs/cs35l41.c                    |  2 --
>  sound/soc/codecs/cs35l45.c                    |  1 -
>  sound/soc/codecs/cs35l56-sdw.c                |  1 -
>  sound/soc/codecs/cs35l56.c                    |  1 -
>  sound/soc/codecs/cs42l42.c                    |  1 -
>  sound/soc/codecs/cs42l43-jack.c               |  5 ---
>  sound/soc/codecs/cs42l43.c                    |  2 --
>  sound/soc/codecs/cs48l32.c                    |  1 -
>  sound/soc/codecs/hda.c                        |  3 --
>  sound/soc/codecs/max98363.c                   |  1 -
>  sound/soc/codecs/max98373-sdw.c               |  1 -
>  sound/soc/codecs/rt1017-sdca-sdw.c            |  1 -
>  sound/soc/codecs/rt1308-sdw.c                 |  1 -
>  sound/soc/codecs/rt1316-sdw.c                 |  1 -
>  sound/soc/codecs/rt1318-sdw.c                 |  1 -
>  sound/soc/codecs/rt1320-sdw.c                 |  1 -
>  sound/soc/codecs/rt5682-sdw.c                 |  1 -
>  sound/soc/codecs/rt700.c                      |  2 --
>  sound/soc/codecs/rt711-sdca.c                 |  2 --
>  sound/soc/codecs/rt711.c                      |  2 --
>  sound/soc/codecs/rt712-sdca-dmic.c            |  1 -
>  sound/soc/codecs/rt712-sdca.c                 |  2 --
>  sound/soc/codecs/rt715-sdca.c                 |  1 -
>  sound/soc/codecs/rt715.c                      |  1 -
>  sound/soc/codecs/rt721-sdca.c                 |  2 --
>  sound/soc/codecs/rt722-sdca.c                 |  2 --
>  sound/soc/codecs/rt9123.c                     |  3 --
>  sound/soc/codecs/tas2552.c                    |  1 -
>  sound/soc/codecs/wcd-mbhc-v2.c                |  2 --
>  sound/soc/codecs/wsa881x.c                    |  1 -
>  sound/soc/codecs/wsa883x.c                    |  1 -
>  sound/soc/codecs/wsa884x.c                    |  1 -
>  sound/soc/intel/atom/sst/sst_pvt.c            |  1 -
>  sound/soc/intel/avs/core.c                    |  1 -
>  sound/soc/intel/avs/debugfs.c                 |  2 --
>  sound/soc/intel/avs/ipc.c                     |  1 -
>  sound/soc/intel/avs/pcm.c                     |  1 -
>  sound/soc/intel/catpt/pcm.c                   |  6 ----
>  sound/soc/intel/catpt/sysfs.c                 |  1 -
>  sound/soc/soc-component.c                     |  1 -
>  sound/soc/sof/control.c                       |  1 -
>  sound/soc/sof/debug.c                         |  1 -
>  sound/soc/sof/ipc3-dtrace.c                   |  1 -
>  sound/soc/sof/ipc4-loader.c                   |  1 -
>  sound/soc/sof/pcm.c                           |  1 -
>  sound/soc/sof/sof-client-ipc-flood-test.c     |  1 -
>  .../soc/sof/sof-client-ipc-kernel-injector.c  |  1 -
>  sound/soc/sof/sof-client-ipc-msg-injector.c   |  1 -
>  sound/soc/sof/sof-client-probes.c             |  3 --
>  sound/x86/intel_hdmi_audio.c                  |  3 --
>  381 files changed, 923 deletions(-)
> 


