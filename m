Return-Path: <linux-iio+bounces-18986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A84AA718F
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283D7460C6D
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9BA2528E4;
	Fri,  2 May 2025 12:19:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C71E489
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188358; cv=none; b=JhVReKPW4OS4vw/IfCfl48fhZY5AIiL6iI8sggJuabbGVT8rcoTOcksmzHbj93POuA93aTuSD7Ok+Mcna05//wyAA0WoG1xEkSxidlclfHO4ZB7UTHw7QBC7wfocgxfFPFM1dXhRNR+gbAWFi1OM3J3KK4YiM3WpbptPafyYst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188358; c=relaxed/simple;
	bh=Zlnyaz8lNOBFQy6yq2meiLZP2ObaBfMYfwoRUwPqvqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtcKnZbQMty/ltZj1tXYSWeK0/CQKtkjk9i16Hk4+9uCmop0Aj1c5UAB4+DVyhQ9kKZnn/hJ+Q3uDNOoiuMWmuJgB9MQ6DDO9EU9yozLMGcWN4V3yNnIWWeEhiGn2q+RP2wj7TVgDb+kwsX2hYCmzOSb6XiHD+OBX5cg1K6GLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uApMI-0000JB-5a; Fri, 02 May 2025 14:19:14 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uApMH-000kSJ-2f;
	Fri, 02 May 2025 14:19:13 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uApMH-00GXyt-2I;
	Fri, 02 May 2025 14:19:13 +0200
Date: Fri, 2 May 2025 14:19:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wbg@kernel.org" <wbg@kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Convert atomic_t -> atomic_long_t
Message-ID: <aBS4QRuKeZ1IpJvN@pengutronix.de>
References: <20250331152222.2263776-1-alexander.sverdlin@siemens.com>
 <91c00e75bc25267d57863494d638f0a43e499ac4.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91c00e75bc25267d57863494d638f0a43e499ac4.camel@siemens.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hi Alexander,

On Fri, May 02, 2025 at 09:24:18AM +0000, Sverdlin, Alexander wrote:
> Dear maintainers,
> 
> On Mon, 2025-03-31 at 17:22 +0200, A. Sverdlin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > 
> > Convert the internal counter type to atomic_long_t, which:
> > - doesn't change much for existing in-tree users as they are 32-bit anyway
> >   (stm32/i.MX6)
> > - doesn't introduce performace penalty on 32-bit platforms
> > - provides 64-bit resolution on 64-bit platforms with virtually no
> >   preformance penalty
> > 
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> I've noticed that the patch has been marked as "Changes Requested" in
> the patchwork, could it be a mistake? Because I never received any
> change request.

Sorry for delay
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

