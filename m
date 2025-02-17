Return-Path: <linux-iio+bounces-15713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699CA387EA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 16:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B393B76DC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78E224B08;
	Mon, 17 Feb 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mC/kSrLC"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19069225761
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806849; cv=none; b=gOa1o9Nsox9BMT/EpMMFWIaLVFJAmnyKAOctQdniYYZlJ19rySiGn/HTpkdLVjEO0+8yyQC1QBl53KYLls+CBq2DL2lNcw7UJslWR3uuV4SmDKz0x1NTYgvlPFnzxyg4mjMw+uq10OmPloievW0KYnrY+gpXHQB4JKaXLzVdcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806849; c=relaxed/simple;
	bh=4T4LpcA8MiMgoC/Y7W+5QNmxY93xutz5VPsGYLNcSMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oY346nK6L3eRgTyjXsxaH9VSEv+mxagBfOFWyhlQG1IMKcON/D/y0YdGFxJIfquxw6EgrEeJQuG8sdl6+YZXcZ98W+bjh5Mp/wmDOjq+SwnjS0lmnIfHBhOoNUA2Hy0RD6gBTxiMvYpL3zuVeMvOWrVexEVAkRXurV0NLaxHtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mC/kSrLC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C21ED4440F;
	Mon, 17 Feb 2025 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739806845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4T4LpcA8MiMgoC/Y7W+5QNmxY93xutz5VPsGYLNcSMc=;
	b=mC/kSrLCi3QwHlaiAP0kxW0kCX2q21WPyOuPC551k2D3oceOkiSA1++z/6zWjrUoIBR2g6
	kQHm1YuHssQBT6wVfEWig/tHuAKfl/31LM73sWT3IAXGF0y7ur0u+rbxUhDmhA49tchTQw
	TXIP6QhKYS8d3PKYbg4HWtzGqmIXUQci7tHb6ZyIYzlSMPzVd4o0nsQXTdqsqb6PpBsnnw
	OJFFOTqLzIiVUfl4yGRBB3kcS0ZztV1ZX7G2/PCsskJPNfvgmSEL0A1ipTVtgqsucUg5mM
	X8XACOh0+S+NGEicuzZTLjozMFtghLvWtrJww5E5hDJXH0l3MksIwElojwzrfw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,  David Lechner <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>,  Olivier Moysan
 <olivier.moysan@foss.st.com>,
  Mike Looijmans <mike.looijmans@topic.nl>,  Phil Reid
 <preid@electromag.com.au>,  Marek Vasut <marek.vasut+renesas@gmail.com>,
  Claudiu Beznea <claudiu.beznea@tuxon.dev>,  Uwe =?utf-8?Q?Kleine-K=C3=B6?=
 =?utf-8?Q?nig?=
 <u.kleine-koenig@baylibre.com>,  Alisa-Dariana Roman
 <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,  Frank Li
 <Frank.Li@nxp.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 24/29] iio: adc: max1027: Switch to sparse friendly
 iio_device_claim/release_direct()
In-Reply-To: <20250217141630.897334-25-jic23@kernel.org> (Jonathan Cameron's
	message of "Mon, 17 Feb 2025 14:16:24 +0000")
References: <20250217141630.897334-1-jic23@kernel.org>
	<20250217141630.897334-25-jic23@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 17 Feb 2025 16:40:43 +0100
Message-ID: <87h64stw90.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepnhhonhgrmhgvrdhnuhhnohesghhmrghilhdrtghomhdprhgtphhtthhopeholhhivhhivghrrdhmohihshgrnhesfhhoshhsrdhsthdrtghomhdpr
 hgtphhtthhopehmihhkvgdrlhhoohhijhhmrghnshesthhophhitgdrnhhlpdhrtghpthhtohepphhrvghiugesvghlvggtthhrohhmrghgrdgtohhmrdgruhdprhgtphhtthhopehmrghrvghkrdhvrghsuhhtodhrvghnvghsrghssehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Jonathan,

On 17/02/2025 at 14:16:24 GMT, Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.

Ok, I didn't know.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

