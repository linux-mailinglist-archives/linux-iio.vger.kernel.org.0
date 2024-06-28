Return-Path: <linux-iio+bounces-6998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BBB91BBE2
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D931C21CF1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEEE154444;
	Fri, 28 Jun 2024 09:50:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B35153BD7
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568215; cv=none; b=RwYPv5nM1BtUPkpiECZntezPK39/pH6Bj9LU35F6EBskMWqRSo3+Dazef8nHWZkSEng2sWgcFY1TSKbWQfA3c/oyy9v/cwHjS6+Uf9BUVVI1wbz2Eewn5uHv8KrDnbac0rI5vCisxBssUystZvjlgQnz1Gh393zdfCaozm4OCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568215; c=relaxed/simple;
	bh=RFkwjKRBKpuLhTw8uyk2KWQoI5qOeVfZQixg0lBl9QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF5sxvkD5MOmX812gW7q6camAHV/7Wqyb+VVdck7mk0jm4jiJePdY5hf3Sh+irzIILgxFl03L4SDYxcLOpXrUgnz8zAAXqkcy+lQ7fIdETv+fOX3lsVGVsvwTAKIQ58vdzrvxlTy/MJa0RDeWMLPDk46f/4K9x4/eTcWkJdHR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sN8Eg-0004Ti-S6; Fri, 28 Jun 2024 11:49:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sN8Ec-005ZkR-IP; Fri, 28 Jun 2024 11:49:38 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sN8Ec-002Q5R-1U;
	Fri, 28 Jun 2024 11:49:38 +0200
Date: Fri, 28 Jun 2024 11:49:38 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Julien Stephan <jstephan@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/5] spi: add support for pre-cooking messages
Message-ID: <Zn6HMrYG2b7epUxT@pengutronix.de>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hi David,

On Mon, Feb 19, 2024 at 04:33:17PM -0600, David Lechner wrote:
> This is a follow-up to [1] where it was suggested to break down the
> proposed SPI offload support into smaller series.
> 
> This takes on the first suggested task of introducing an API to
> "pre-cook" SPI messages. This idea was first discussed extensively in
> 2013 [2][3] and revisited more briefly 2022 [4].
> 
> The goal here is to be able to improve performance (higher throughput,
> and reduced CPU usage) by allowing peripheral drivers that use the
> same struct spi_message repeatedly to "pre-cook" the message once to
> avoid repeating the same validation, and possibly other operations each
> time the message is sent.
> 
> This series includes __spi_validate() and the automatic splitting of
> xfers in the optimizations. Another frequently suggested optimization
> is doing DMA mapping only once. This is not included in this series, but
> can be added later (preferably by someone with a real use case for it).
> 
> To show how this all works and get some real-world measurements, this
> series includes the core changes, optimization of a SPI controller
> driver, and optimization of an ADC driver. This test case was only able
> to take advantage of the single validation optimization, since it didn't
> require splitting transfers. With these changes, CPU usage of the
> threaded interrupt handler, which calls spi_sync(), was reduced from
> 83% to 73% while at the same time the sample rate (frequency of SPI
> xfers) was increased from 20kHz to 25kHz.
> 
> [1]: https://lore.kernel.org/linux-spi/20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com/T/
> [2]: https://lore.kernel.org/linux-spi/E81F4810-48DD-41EE-B110-D0D848B8A510@martin.sperl.org/T/
> [3]: https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@martin.sperl.org/T/
> [4]: https://lore.kernel.org/linux-spi/20220525163946.48ea40c9@erd992/T/

I have a regression after this patch set. My system explodes with
following trace:
 Unable to handle kernel paging request at virtual address 0064f69bfd319200
 Mem abort info:                                  
   ESR = 0x0000000086000004
   EC = 0x21: IABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 [0064f69bfd319200] address between user and kernel address ranges
 Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
 Modules linked in: lan78xx etnaviv crct10dif_ce gpu_sched fsl_imx8_ddr_perf caam ina2xx ina3221 rtc_snvs error imx8mm_thermal imx_cpufreq_dt fuse
 CPU: 2 PID: 103 Comm: spi2 Tainted: G        W          6.8.0-rc3-00118-g82b98fb8cd33 #36
 Hardware name: Philips i.MX8MPlus Delta Evaluation Kit (DT)
 pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : 0x64f69bfd319200
 lr : spi_res_release+0x68/0xb8
 sp : ffff800083a6bcb0
 x29: ffff800083a6bcb0 x28: ffff800081906008 x27: ffff8000809feea8
 x26: 0000000000000001 x25: dead000000000122 x24: dead000000000100
 x23: ffff800083c7ba38 x22: ffff0000c3ca5000 x21: ffff800083c7b9e0
 x20: ffff800083c7ba40 x19: ffff800083c7bb48 x18: 0020000000000000
 x17: 0000000000901400 x16: 00000000b0891400 x15: 049d200e412d4100
 x14: 00000090fff6c1f4 x13: 000000280b412d41 x12: 000ed3ddde0a5202
 x11: 6e0194029343039e x10: 00000000000014c0 x9 : ffff8000809fd5dc
 x8 : ffff800081906008 x7 : ffff0000c3c9c41c x6 : ffff8000800f34b0
 x5 : 0000000000000000 x4 : ffff800083a6bab8 x3 : 8f64f69bfd319200
 x2 : ffff800083c7bb60 x1 : ffff800083c7b9e0 x0 : ffff0000c3ca5000
 Call trace:
  0x64f69bfd319200
  spi_async+0xac/0x110
9H0[]6 spi_mux_transfer_one_message+0xb8/0xf0
  __spi_pump_transfer_message+0x26c/0x650
  __spi_pump_messages+0xe0/0x228
  spi_pump_messages+0x20/0x38
  kthread_worker_fn+0xe0/0x2a8
  kthread+0x10c/0x120
  ret_from_fork+0x10/0x20
 Code: ???????? ???????? ???????? ???????? (????????) 
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x0,00000008,00020000,2100421b
 Memory Limit: none
 Rebooting in 10 seconds..

It seems to be spi_mux specific. We have seen similar trace on other system
with spi_mux.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

