Return-Path: <linux-iio+bounces-22953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04391B2B169
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 21:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134253AFB9C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD816263F36;
	Mon, 18 Aug 2025 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV7m6Icp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E853451B0;
	Mon, 18 Aug 2025 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544386; cv=none; b=tCWr07WLMgjMeu2BkyBwkQDs56knoYYHlcSPfF0OqZ8bGWC2lkP+Czgo46Zl0fkueveJp5YmI31NRCxSVQn70wU6IEN9HtXHFa3PmQNNKGaABn8RB1sZIyN7fZ9fVnoALMZLpeJr/EqQdLTdoL+L7vYTkQStHpU7/m+fjpjW5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544386; c=relaxed/simple;
	bh=0gxTbG8IDFeahIwRXLJ5Ki2M1jR8ORnhUe5Uokg/sgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1BkvGinp/MhI4HFnCeGDgKyHR93aKdgyZYnrnEKaupyd0N1GEibwuVOhFe9ukvtOTtxMWo0mayc/90fQB/bXBU2AJYo9+UDFQgK4Lm7UCzhI/0/KO1Xuzqg3zXxQvgpRfuZLVjwESBNqXrlffWxp1W99V0o5T69Pgvj+T++CNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV7m6Icp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1915CC4CEEB;
	Mon, 18 Aug 2025 19:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755544386;
	bh=0gxTbG8IDFeahIwRXLJ5Ki2M1jR8ORnhUe5Uokg/sgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iV7m6Icp2O22MoxrsVPFFFQ4+ETwUbRxC1Puf/06Oh1yAY3Ns0j0qg1uZmcqdoLDT
	 YBXBwzb5FKGulte3+5se6gMfnvn2aUAvXGDkSP4p7isobwlW7hhT4Am3H3JcwfD8Xv
	 BBFVY8n/LbVNgk4FhY5nwFoDKi6jYiZ6Kz0Dx3rVMnIxHzZANgwt5ako5aUD/gPaJF
	 nCtvW/5vQEbTN5I/3UmazUUj61awRYPolpYz23iygOAYm0SVQutrpP5p5UuWYc6Xdg
	 3F8KXcH5vDJN6+enwOj4gQH7tSVphtpT3nq3jvWdY1jUU+xX5sx5KQbDqYdoAoBq0q
	 RMnoawDhkvYVg==
Date: Mon, 18 Aug 2025 20:12:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v2 0/4] Support ROHM BD7910[0,1,2,3]
Message-ID: <20250818201256.7be1092c@jic23-huawei>
In-Reply-To: <8127b81f-d2a1-4dfc-b8c6-45615ba9e431@baylibre.com>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
	<20250818191932.42c22df3@jic23-huawei>
	<8127b81f-d2a1-4dfc-b8c6-45615ba9e431@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 13:46:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/18/25 1:19 PM, Jonathan Cameron wrote:
> > On Mon, 18 Aug 2025 11:11:56 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Add support for ROHM BD7910[0,1,2,3] ADCs.
> >>
> >> The ROHM BD79100, BD79101, BD79102 and BD79103 are ADCs derived from the
> >> BD79104. According to the data-sheets, the BD79103 is compatible with the
> >> BD79104. Rest of the ICs have different number of analog input channels.
> >>
> >> This series adds support for these ICs using the ti-adc128s052.c.
> >>
> >> NOTE: There has been work on couple of other patch series [1][2] touching
> >> this same driver. I haven't considered those changes because, AFAICS,
> >> there has been no new revisions of these series since mid June.
> >>
> >> [1]: https://lore.kernel.org/all/20250614091504.575685-1-sbellary@baylibre.com/
> >> [2]: https://lore.kernel.org/all/20250625170218.545654-2-l.rubusch@gmail.com/  
> > 
> > Pretty simple replies to the changes requested in v1 reviews and nice and clean
> > so I'll gamble (a tiny bit) that everyone is happy with this and at least
> > queue it up for build testing.
> >   
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Thanks. Added to the 3 you hadn't tagged already.

