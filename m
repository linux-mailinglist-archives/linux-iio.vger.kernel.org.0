Return-Path: <linux-iio+bounces-18984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B17AA70DF
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D45C7AD5C5
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5F22AE7B;
	Fri,  2 May 2025 11:50:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9733D76
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186632; cv=none; b=ekTyLDuJ48jFrpFHiMHc9JS6WcajZ1WZysjIF5MARtOB0cHj5LIKQuHuN2xAlUmLER1ZQhyYS8XtH6J8m+RFU857GrFxaW0LvADAFVv8HUQmpV2GTyIPDeAoVQBLww737ksOouNkp88EQcSu2bO015T6Bs1myeusrzjU4HPumXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186632; c=relaxed/simple;
	bh=J777bZBvblRFhUvgPhbRSI/pUJMpvYDRiGGLvvskkvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paMWQ96hK1VBluR8SykgwUGnduvuoxn8+eH5nky3VOOrydLB7z08Wo8FKUWMyAUI/Q+BkpDedSWBjjoH7vAzZD52nGx32IF63B5yosXw4QtDPnpxrKI6G4jmcre5k5Z0mOUCi2gltFrvm7Hnr0XjOD30QqXF4/R72QkClYXrolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uAouP-0006x9-G7; Fri, 02 May 2025 13:50:25 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uAouP-000kA8-00;
	Fri, 02 May 2025 13:50:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uAouO-00GXaQ-2p;
	Fri, 02 May 2025 13:50:24 +0200
Date: Fri, 2 May 2025 13:50:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: William Breathitt Gray <wbg@kernel.org>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Message-ID: <aBSxgDuw42kPlweT@pengutronix.de>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
 <jir0aD7w3brmbPDdhC4xAhaEKCp-g08TBmtdn785u_Z5M77ZHMhsK7UoamaROSznl2WmcUmPSnocgVnCSYmUYg==@protonmail.internalid>
 <8394ef31a75fdf9122331ecb97dd6f986d5026f1.camel@siemens.com>
 <aBSv1pJ1mulT78gn@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBSv1pJ1mulT78gn@ishi>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Fri, May 02, 2025 at 08:43:18PM +0900, William Breathitt Gray wrote:
> On Fri, May 02, 2025 at 09:24:20AM +0000, Sverdlin, Alexander wrote:
> > Dear maintainers,
> > 
> > On Mon, 2025-03-31 at 18:36 +0200, A. Sverdlin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > >
> > > Enable/disable seems to be racy on SMP, consider the following scenario:
> > >
> > > CPU0					CPU1
> > >
> > > interrupt_cnt_enable_write(true)
> > > {
> > > 	if (priv->enabled == enable)
> > > 		return 0;
> > >
> > > 	if (enable) {
> > > 		priv->enabled = true;
> > > 					interrupt_cnt_enable_write(false)
> > > 					{
> > > 						if (priv->enabled == enable)
> > > 							return 0;
> > >
> > > 						if (enable) {
> > > 							priv->enabled = true;
> > > 							enable_irq(priv->irq);
> > > 						} else {
> > > 							disable_irq(priv->irq)
> > > 							priv->enabled = false;
> > > 						}
> > > 		enable_irq(priv->irq);
> > > 	} else {
> > > 		disable_irq(priv->irq);
> > > 		priv->enabled = false;
> > > 	}
> > >
> > > The above would result in priv->enabled == false, but IRQ left enabled.
> > > Protect both write (above race) and read (to propagate the value on SMP)
> > > callbacks with a mutex.
> > >
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > 
> > I've noticed that the patch has been marked as "Changes Requested" in
> > the patchwork, could it be a mistake? Because I never received any
> > change request.
> 
> Hi Alexander,
> 
> I can't comment on the patchwork status because I don't use that
> service, but I apologize nonetheless for the delay in responding to your
> patch submission. I'm hoping for an Ack from Oleksij, but this is a
> pretty straight-forward fix that I'll be happy to pick it up regardless.
> 
> Would you provide a Fixes line so the stable trees can pick this up for
> the necessary kernel versions?

Sorry for delay, you can add my
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

