Return-Path: <linux-iio+bounces-13323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A39ECCB3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0654188A2CF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D282210D3;
	Wed, 11 Dec 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2EAp0vPV"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DD290F;
	Wed, 11 Dec 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922151; cv=none; b=c9b+IDzyoFR9RgUmMgtLfZJ77UNg5PsG8a5D9nZiicr87xT9VrMaqL4sv0zUbXvDkhhipWeH95rN8RyuR1lCujsEm8LTH4q9tqv0J1WdeMrbsjAwiiJlPPjzJW2lQ3NFy3otofdG8GyVPrToY0o2yvKMuImXuNaswlYejMRqRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922151; c=relaxed/simple;
	bh=LZMfTgHqkdTa/EfeMHpOmW3wdjO6Gh1IDsbKq6GgHQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZjiB6sQYKXI8ofQ3eagIpDC77XooqBqA9sn3rqVGxlF6X1WccvLYscwktNAzXXpuSiZ8l69is/twXqlIHnpFwAEbtWwvgwkq+suC61PK22eQ4sC4xt4bIWpzrcbpMut5q7lsl45psbvvNm96wXFy0elzOKGv/uq7sdXakkchqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2EAp0vPV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jkmc+0iMxSsuraunK1hN8Fbs31rpvecJZuCVn+Hdq70=; b=2EAp0vPV9U9VTzLQIBFoBNm3wm
	wZi0Eggw03q+26nYB020dRYGjGIj1liBjiypzd55QnC7v5a+CyphFgnHfLRnru551jrqhGFMkFQg/
	ZCbtrjpajxf9gFv40AJhXC+S2kNyDU39e8ckE3DgCmhpmY621QxHg3oC6P4H94nCJAPpb6PmHvQrd
	0pA7NsaCoQ9cQ9XZxUtCsbT3RPORl4vo29LOiCS/o0MG9oNROg4xuR95xELFIO1x3vUv5eMGSStmf
	nqmoN/uFxYXq36yG90YlKaLE8mkKbJaqjed7tWq9hjJCwu4r8gxYiWe9z+dK+LSrleaxEX0oBd0HG
	xMlS/E2w==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tLMLd-0003DO-Li; Wed, 11 Dec 2024 14:01:49 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Lee Jones <lee@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
 dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale platform-data on
 remove
Date: Wed, 11 Dec 2024 14:01:48 +0100
Message-ID: <3196449.TQGk6oTFT5@diego>
In-Reply-To: <n914pn7o-pr9n-5ss0-p744-73402nnn843p@xreary.bet>
References:
 <20241107114712.538976-1-heiko@sntech.de> <20241211120844.GD7139@google.com>
 <n914pn7o-pr9n-5ss0-p744-73402nnn843p@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 11. Dezember 2024, 13:24:42 CET schrieb Jiri Kosina:
> On Wed, 11 Dec 2024, Lee Jones wrote:
> 
> > > > > This change was more or less a surprise find, because I wanted to make
> > > > > the platform_data pointer in the mfd_cell struct const and this the hid
> > > > > sensor hub stood out as doing something strange ;-) .
> > > > > 
> > > > > So patch 2 of this series actually depends on this change to not cause
> > > > > build errors.
> > > > 
> > > > Ah, right.
> > > > 
> > > > > But seeing that we're after -rc6 alredy, I would assume the brunt of the 
> > > > > mcu series might need to wait after 6.13-rc1 anyway - but I guess that 
> > > > > depends on how Lee sees things ;-) .
> > > > 
> > > > OK, I am keeping my hands off it for the time being.
> > > 
> > > I can take it now with an Ack.
> > 
> > Looking to apply this set now.
> > 
> > Ack please.
> 
> I'd preferer if Srinivas could ack this as the more specific maintainer. 
> Srinivas, please? 

The patch already includes the
   Ack from Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
from a previous version, so I guess it should be ok already?




