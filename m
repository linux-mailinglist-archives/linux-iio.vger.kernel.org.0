Return-Path: <linux-iio+bounces-16885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F930A634CF
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 10:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA6C16CC95
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5558219DF75;
	Sun, 16 Mar 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbEwkAIE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9652133987;
	Sun, 16 Mar 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742117908; cv=none; b=n89zCYnHF77w9/XgOdZN1S5/2UoCT2ZNaMlc0f1aI4LEXfBYgWF7kEWVzCjXliIFCikHOg1/01Ro5UbU5Zz4jMjqv+N3VS4rqQvCrIwKYTyJbA8EGXc+YXKwncjm2Ld1rP8JNWlpSmgirDMo5WWmwRL7UBA25TukVmCd7MQZMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742117908; c=relaxed/simple;
	bh=IfQEydlLkB/SwiGc+oQAak2koasoTaF6BMIlt7gzGgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7KJ63o3UApjPTPnrBRSzyhTPEEV0vZ3F8L8svxtvPI2K2q6UXh0CVlDVqrEksUwb4PiUJ1fSwfHA7YKTPOm2xLvcrLAffqZtK/YPPFPnVkFVy7iaXl16oRztKOhB/99QrKJ9DDMioUHdGfIPR/2ARHy26FXoe4NMJmWwb9HRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbEwkAIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F122C4CEDD;
	Sun, 16 Mar 2025 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742117907;
	bh=IfQEydlLkB/SwiGc+oQAak2koasoTaF6BMIlt7gzGgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbEwkAIESdXZMWtrTIoTAH6bpMFDi0sreEWPRFDN//Vt4pQTw7EVzyyTmktQmC7fz
	 VHJNELiNsPGlujkXGKfiZfOojPiNz6Clu+Fih36MVubORIJP9FPGhC2VzgGxkeDrF3
	 +h8dxf0jDeLK9mFWI51D5w8ssRihSjiUmsdPCcKO82u3g9Hadp/O4h2b+fdL4Sz1JP
	 8ZQtR/aiD9EkxwoH4AgZGiCzIENJdvPzP5BJjqY/UeFbw1r0GFlY3BZC9QVU6NsYT3
	 7WSNY3ELng4JXyZzlfmKK5mXwhgkW5PkVQJv+pyMCdz9d+vo2ODEFIx41lkkSotpjb
	 iFjkj6I3SB/XA==
Date: Sun, 16 Mar 2025 09:38:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250316093752.0eacaa16@jic23-huawei>
In-Reply-To: <c8899e8c535a1d93cd7588b7c160eb0fae5d26d2.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
	<c8899e8c535a1d93cd7588b7c160eb0fae5d26d2.1741849323.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 09:18:18 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.
> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.
I suspect we'll need the addition of an optional trailing timestamp
channel at somepoint. But we can add that when we need it as only
matters for drivers doing iio_push_to_buffers_with_timestamp()

Otherwise no additional comments from me.

