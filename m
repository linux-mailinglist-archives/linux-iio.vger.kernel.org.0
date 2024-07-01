Return-Path: <linux-iio+bounces-7091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7ED91D85E
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 08:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F61C21C9A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E26EB4A;
	Mon,  1 Jul 2024 06:56:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E835EE8D
	for <linux-iio@vger.kernel.org>; Mon,  1 Jul 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816988; cv=none; b=ABqXieXFmcX81pLdTYxAb2lYQHgQh5Fagd+o3mbnKs4WQMNnUXLAdJ4Phk5M2mP6K+I8zgX+ctypYZplScn3iohAVT/FBuWCbHAle9utvpyF1/kDNhZninU52kPJ52+v0ARKssNogZI08+UW8Srspj4jiPnRM1Jsxyphr8f8e0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816988; c=relaxed/simple;
	bh=HOIaIlSj7r2hqWcDrBSX8JQqRZf1t595YMIepq2kMyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfQkSXNQVSX6m1A5+bwGu8G8d4yCvZA/NaNO3l2lKaQ76JE/gHS0n8QUT+HeSt0dXiIzGAjrjPyBF1gS635qHMbkWLuKSr4mej6f9WSxSmyJwoqTRSYCv0Y2WalB4MeACfNtqGeL/z/ReqfTtucn1CZfsV9Qblgjn3dvNN8dDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sOAx0-0003Yo-FR; Mon, 01 Jul 2024 08:55:46 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sOAww-006JJB-6n; Mon, 01 Jul 2024 08:55:42 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sOAww-008Jk4-0K;
	Mon, 01 Jul 2024 08:55:42 +0200
Date: Mon, 1 Jul 2024 08:55:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Mark Brown <broonie@kernel.org>,
	Martin Sperl <kernel@martin.sperl.org>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel@pengutronix.de, T.Scherer@eckelmann.de
Subject: Re: [PATCH v2 0/5] spi: add support for pre-cooking messages
Message-ID: <ZoJS7hAdf36ezyUn@pengutronix.de>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
 <Zn6HMrYG2b7epUxT@pengutronix.de>
 <20240628-awesome-discerning-bear-1621f9-mkl@pengutronix.de>
 <9e6b5cff-8692-484e-9e1c-b89a1f49d6c7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e6b5cff-8692-484e-9e1c-b89a1f49d6c7@baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Fri, Jun 28, 2024 at 10:27:28AM -0500, David Lechner wrote:
> On 6/28/24 5:16 AM, Marc Kleine-Budde wrote:
> > On 28.06.2024 11:49:38, Oleksij Rempel wrote:
> >> It seems to be spi_mux specific. We have seen similar trace on other system
> >> with spi_mux.
> > 
> > Here is the other backtrace from another imx8mp system with a completely
> > different workload. Both have in common that they use a spi_mux on the
> > spi-imx driver.
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000dd0
> > Mem abort info:
> >   ESR = 0x0000000096000004
> >   EC = 0x25: DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> >   FSC = 0x04: level 0 translation fault
> > Data abort info:
> >   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> >   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046760000
> > [0000000000000dd0] pgd=0000000000000000, p4d=0000000000000000
> > Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > Modules linked in: can_raw can ti_ads7950 industrialio_triggered_buffer kfifo_buf spi_mux fsl_imx8_ddr_perf at24 flexcan caam can_dev error rtc_snvs imx8mm_thermal spi_imx capture_events_irq cfg80211 iio_trig_hrtimer industrialio_sw_trigger ind>
> > CPU: 3 PID: 177 Comm: spi5 Not tainted 6.9.0 #1
> > Hardware name: xxxxxxxxxxxxxxxx (xxxxxxxxx) (DT)
> > pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : spi_res_release+0x24/0xb8
> > lr : spi_async+0xac/0x118
> > sp : ffff8000823fbcc0
> > x29: ffff8000823fbcc0 x28: 0000000000000000 x27: 0000000000000000
> > x26: ffff8000807bef88 x25: ffff80008115c008 x24: 0000000000000000
> > x23: ffff8000826c3938 x22: 0000000000000000 x21: ffff0000076a9800
> > x20: 0000000000000000 x19: 0000000000000dc8 x18: 0000000000000000
> > x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff88c0e760
> > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > x11: ffff8000815a1f98 x10: ffff8000823fbb40 x9 : ffff8000807b8420
> > x8 : ffff800081508000 x7 : 0000000000000004 x6 : 0000000003ce4c66
> > x5 : 0000000001000000 x4 : 0000000000000000 x3 : 0000000001000000
> > x2 : 0000000000000000 x1 : ffff8000826c38e0 x0 : ffff0000076a9800
> > Call trace:
> >  spi_res_release+0x24/0xb8
> >  spi_async+0xac/0x118
> >  spi_mux_transfer_one_message+0xb8/0xf0 [spi_mux]
> >  __spi_pump_transfer_message+0x260/0x5d8
> >  __spi_pump_messages+0xdc/0x320
> >  spi_pump_messages+0x20/0x38
> >  kthread_worker_fn+0xdc/0x220
> >  kthread+0x118/0x128
> >  ret_from_fork+0x10/0x20
> > Code: a90153f3 a90363f7 91016037 f9403033 (f9400674) 
> > ---[ end trace 0000000000000000 ]---
> > 
> > regards,
> > Marc
> > 
> 
> 
> Hi Oleksij and Marc,
> 
> I'm supposed to be on vacation so I didn't look into this deeply yet
> but I can see what is happening here.
> 
> spi_mux_transfer_one_message() is calling spi_async() which is calling
> __spi_optimize_message() on an already optimized message.
> 
> Then it also calls __spi_unoptimize_message() which tries to release
> resources. But this fails because the spi-mux driver has swapped
> out the pointer to the device in the SPI message. This causes the
> wrong ctlr to be passed to spi_res_release(), causing the crash.
> 
> I don't know if a proper fix could be quite so simple, but here is
> something you could try (untested):

This issue is still reproducible with following trace:
[   19.566433] Call trace:
[   19.568882]  spi_async+0x90/0x118
[   19.572204]  spi_mux_transfer_one_message+0xd4/0x110
[   19.577175]  __spi_pump_transfer_message+0x2bc/0x6e8
[   19.582149]  __spi_pump_messages+0xe0/0x228
[   19.586339]  spi_pump_messages+0x20/0x38
[   19.590271]  kthread_worker_fn+0xe0/0x2e8
[   19.594286]  kthread+0x10c/0x120
[   19.597518]  ret_from_fork+0x10/0x20

addr2line for spi_async+0x90/0x118 -> drivers/spi/spi.c:2136
  2132 static void __spi_unoptimize_message(struct spi_message *msg)         
  2133 {                                                                     
  2134         struct spi_controller *ctlr = msg->spi->controller;
  2135
  2136         if (ctlr->unoptimize_message)
  2137                ctlr->unoptimize_message(msg);
  2138
  2139         spi_res_release(ctlr, msg);                                   
  2140
  2141         msg->optimized = false;
  2142         msg->opt_state = NULL;
  2143 }

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

