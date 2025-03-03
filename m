Return-Path: <linux-iio+bounces-16297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D840DA4C56E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 16:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAF1618D8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAF2139AF;
	Mon,  3 Mar 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="cFgkZnKI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E948723F36F;
	Mon,  3 Mar 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016515; cv=none; b=cSEdH2r3gRAs/28kfsRdVGEKF2qQTZL2hmYitwVTANKPAQrJCMoAxzRZj2w1Jw1S7XVMafj3FZgEWDwVnsZ3qoRNiH2mBjgfrDFQOce0pkVb4EhuLUZkVQ0R5+1jl8LAIMz+hcGMGGrF9BrSiO3z3PRsuNlKt/86iCh8Z7Y9/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016515; c=relaxed/simple;
	bh=m25FjPrgYwk7MjQZxfJGTGjcn2SPVYgupnmoKPBo3ug=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=LgRkwj4zJS9V28slU9SGVzkirA/QBJBKNIEg+BsHhXcAWdw1K/QIjTBMz71ApSyh3JpeV0bPAWmH9WQwJwz7tR2PJeNDD6r/Bmzla9b1k78WPtm5UxCeseQQAk71027j6CeHUIk1QS/z8iw0Flhhu2AW2Dwk7suz0ZSPGw9uAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=cFgkZnKI; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=C/mjUrCDUh8TvGQ0TNP99UWlQJSkPZIBxxqCtz4GkI0=; b=cFgkZnKIv0/ZHT36d/Zwl7IRW1
	fW9cvHeQLM8AeK7zGY/zPOWZy9w7wMXgJkCSy5z05SlMk8da27MCzCKt29/I0lhlBw2CscACezTh4
	2mG4q/f/ES1WSSFlTCdeu0TFqSsnFwe8mN+Gu37FBSbil4W7sh78YpEv424PPHAysC1w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56514 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tp7EM-0000V2-1t; Mon, 03 Mar 2025 09:57:18 -0500
Date: Mon, 3 Mar 2025 09:57:17 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, Matteo
 Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Message-Id: <20250303095717.56ef5ac016b99911fc34e198@hugovil.com>
In-Reply-To: <7c79ce3a-0dc4-4aa4-941a-e05be9a34fb8@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
	<20dd0e4ea72fe39b90b611f9c08dbd4bc1d5217f.1740421248.git.mazziesaccount@gmail.com>
	<f0d0f114-3953-46b5-b9f6-9b35537e6f8e@baylibre.com>
	<d391b012-0a8e-40ca-af56-ca73b3fd853b@gmail.com>
	<20250302032713.1c834448@jic23-huawei>
	<7c79ce3a-0dc4-4aa4-941a-e05be9a34fb8@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.6 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v4 07/10] iio: adc: ti-ads7924: Respect device tree
 config
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Sun, 2 Mar 2025 15:10:12 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 02/03/2025 05:27, Jonathan Cameron wrote:
> > On Wed, 26 Feb 2025 08:39:11 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > 
> >> On 26/02/2025 02:09, David Lechner wrote:
> >>> On 2/24/25 12:34 PM, Matti Vaittinen wrote:
> >>>> The ti-ads7924 driver ignores the device-tree ADC channel specification
> >>>> and always exposes all 4 channels to users whether they are present in
> >>>> the device-tree or not. Additionally, the "reg" values in the channel
> >>>> nodes are ignored, although an error is printed if they are out of range.
> >>>>
> >>>> Register only the channels described in the device-tree, and use the reg
> >>>> property as a channel ID.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>>
> >>>> ---
> >>>> Revision history:
> >>>> v3 => v4:
> >>>>    - Adapt to 'drop diff-channel support' changes to ADC-helpers
> >>>>    - select ADC helpers in the Kconfig
> >>>> v2 => v3: New patch
> >>>>
> >>>> Please note that this is potentially breaking existing users if they
> >>>> have wrong values in the device-tree. I believe the device-tree should
> >>>> ideally be respected, and if it says device X has only one channel, then
> >>>> we should believe it and not register 4. Well, we don't live in the
> >>>> ideal world, so even though I believe this is TheRightThingToDo - it may
> >>>> cause havoc because correct device-tree has not been required from the
> >>>> day 1. So, please review and test and apply at your own risk :)
> >>>
> >>> The DT bindings on this one are a little weird. Usually, if we don't
> >>> use any extra properties from adc.yaml, we leave out the channels. In
> >>> this case it does seem kind of like the original intention was to work
> >>> like you are suggesting, but hard to say since the driver wasn't actually
> >>> implemented that way. I would be more inclined to actually not make the
> >>> breaking change here and instead relax the bindings to make channel nodes
> >>> optional and just have the driver ignore the channel nodes by dropping
> >>> the ads7924_get_channels_config() function completely. This would make
> >>> the driver simpler instead of more complex like this patch does.
> >>
> >> I have no strong opinion on this. I see this driver says 'Supported' in
> >> MAINTAINERS. Maybe Hugo is able to provide some insight?
> >>
> > This seems to be ABI breakage.  Never something we can take if there is
> > a significant chance of anyone noticing.  Here it looks like risk
> > is too high.
> 
> Ok. I'll just drop this patch then. Thanks David & Jonathan :)

Hi Matti,
I haven't really been able to follow all discussions, but as an
historic note I developped this driver for a prototype that never
materialized. So any changes would not have an impact, as far as I am
concerned.

Hugo.

