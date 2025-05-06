Return-Path: <linux-iio+bounces-19180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AF8AABA64
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 09:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CB21C0805D
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EF219A7A;
	Tue,  6 May 2025 04:48:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883C157E99
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506931; cv=none; b=PFxgSPTlcWA1Cq7GBA69PwsQ3BlbKFCJM0VC7MAdgrfynuDnIV7uHvrGDyhMXdEm0Uem5+PPTjOUXUp7d8eIE1CjJW/msZW7IGrourFtWmuNXcgEfO+BbI7CXuLxQRdZPGs0xHaZsbrQQrxUYRDdeICBHB/+dS66h2hmkU9/3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506931; c=relaxed/simple;
	bh=M7tSa7MbJaWs0RYS66QZrD+Gc1VodiI1dQFPflJRvnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUHEXaqrJNGReZR9BlXJlbxafjfukh7NhS5FiRbzfDIv69Ax12MnMEDMPdYuexJ9Y1JQQHiSOU+vU6GyikJAq8MYsdYP/+PZGhJ26m9opp/6CXX+7XbL7CtOYdh7nT1Mutz50GkBuOwog9foPUMsNfPwD6eTMSND4RgkykjV8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uCAEO-0004mV-8Y; Tue, 06 May 2025 06:48:36 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCAEN-001L19-00;
	Tue, 06 May 2025 06:48:35 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCAEM-006Qfn-2i;
	Tue, 06 May 2025 06:48:34 +0200
Date: Tue, 6 May 2025 06:48:34 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, kernel@pengutronix.de,
	Song Qiang <songqiang1304521@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] iio: adc: ti-tsc2046: remove bits_per_word = 8
Message-ID: <aBmUou6kEL32Nzp-@pengutronix.de>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
 <20250505-iio-remove-bits_per_word-8-v1-2-341f85fcfe11@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-2-341f85fcfe11@baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Mon, May 05, 2025 at 02:20:29PM -0500, David Lechner wrote:
> Remove setting bits_per_word = 8 from the ti-tsc2046 driver. This is the
> default value for SPI transfers, so it is not necessary to explicitly
> set it.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

