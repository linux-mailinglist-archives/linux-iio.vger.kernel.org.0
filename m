Return-Path: <linux-iio+bounces-16874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B946A63187
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5AF189587A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1C7205ABE;
	Sat, 15 Mar 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snXASOq1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AE1FECAD;
	Sat, 15 Mar 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063309; cv=none; b=LY7WwhbgVQtHx4DvtiOkOzSjkVwFEuOqxNRl9jtsQJJAKTdFmzDn5jOJnz6kNGiSTR4Cp8s6ZWRQwvV0wbqO2CoW/+ZN+t09pf2j+3wO+tsEuwgm6ZCjSpoqzA7cmHiz4AiTt9+I7kVVr+Bw5uX0ovhdh58RsZxk4yNVyy9ZpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063309; c=relaxed/simple;
	bh=sMKrjH62WoD/khslIsrraD1DRdosmW6hiDuN4h1CExc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUf8smIi0xU5ENXm8xVRmddyY6gIYsa9PbLPlX1M8A7bHJes2t3xDmfIYxS+AEqXc5D7THT6PwkeeENeNXjvRnncYrIYwCSFxp81NYhN5C0tiAHTh2jxzj4wg3as4SMXd3Er4xqv54ZpUN216UrzMM6NXnBgZjAAWudhuiNrisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snXASOq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9C5C4CEE5;
	Sat, 15 Mar 2025 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063309;
	bh=sMKrjH62WoD/khslIsrraD1DRdosmW6hiDuN4h1CExc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=snXASOq1cllJq1YTzDr4qDVX4xo/lxUHFZy5n9suL0QxsZkZAUZM1i5zZk7uoKn7T
	 eignihiclaj4hs8EJ/v/qppGcHX1leERoUdOm5BnAe9COVUk4TU1nIOxfVikm3jJXU
	 cI3Z65HXbPpPiiO0hOr6iK+tqdnelXHSD+UtsANAzhNECjS0JeNnMsw01WeDCX6G88
	 swbZ/gbJerFL1k7OXCVQT4mB/8nD5xZ+19cgx4+r2Ml+M8WU5KmcOB49pBvjQheG5s
	 vB9stQQLN3SggAUGmT3zLZ+Gu5LpJpFodH/523FaWEeSGqSa3yDhi4aOGRr5Eiv6As
	 DDxjAIvVTxcbw==
Date: Sat, 15 Mar 2025 18:28:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>, Thomas
 Bonnefille <thomas.bonnefille@bootlin.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Nuno Sa <nuno.sa@analog.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, Claudiu
 Manoil <claudiu.manoil@nxp.com>, devicetree@vger.kernel.org, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-iio@vger.kernel.org, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Eric Dumazet <edumazet@google.com>, Conor
 Dooley <conor+dt@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Paul Elder <paul.elder@ideasonboard.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Matteo Martelli
 <matteomartelli3@gmail.com>, Guillaume Stols <gstols@baylibre.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, David Lechner <dlechner@baylibre.com>, Chen-Yu
 Tsai <wens@csie.org>, Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v6 00/10] Support ROHM BD79124 ADC
Message-ID: <20250315182806.653bd71c@jic23-huawei>
In-Reply-To: <e685d31c-8cdc-4732-b3a8-8e70a6f82578@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
	<20250310202738.13301548@jic23-huawei>
	<e685d31c-8cdc-4732-b3a8-8e70a6f82578@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 07:49:35 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/03/2025 22:27, Jonathan Cameron wrote:
> > On Mon, 10 Mar 2025 14:53:50 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Support ROHM BD79124 ADC.
> >>
> >> This series adds also couple of IIO ADC helper functions for parsing the
> >> channel information from the device tree. There are also new helpers
> >> included for iterating and counting firmware child nodes with a specific
> >> name.
> >>
> >> Series does also convert couple of drivers to use these helpers. The
> >> rzg2l_adc and the sun20i-gpadc are converted to use the new ADC helper.
> >>
> >> The gianfar driver under net and the thp7312 under media/i2c are added as
> >> first users of the newly added "named child node" -helpers.
> >>
> >> There has been some discussion about how useful these ADC helpers are,
> >> and whether they should support also differential and single ended channel
> >> configurations. This version does not include support for those - with the
> >> benefit of reduced complexity and easier to use API.
> >>
> >> NOTE: Patches 4,5,9 and 10 are untested as I lack of relevant HW.
> >> They have been compile tested only.  
> > This probably wants an update.  Also, 00/10? There are only 8 that I can see.  
> 
> That's odd.
> There should be 10 in total. And the 4, 5, 9 and 10 was updated.
> 
> 9/10:
> https://lore.kernel.org/all/1c4b9b4ceb1995bce76a0ddef0e04ad0d1d81190.1741610847.git.mazziesaccount@gmail.com/
> 
> 10/10:
> https://lore.kernel.org/all/ab79cf4415d21ff2854fee4f4189fac555c30b7a.1741610847.git.mazziesaccount@gmail.com/
> 
> Perhaps it's because of the "net-next" in subject?
> 
Nope. My filters broke the series up into different directories.

Thanks,

Jonathan

> Yours,
> 	-- Matti


