Return-Path: <linux-iio+bounces-15712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E3A387C4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F143B4736
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A6224AF6;
	Mon, 17 Feb 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CS2NhaK9"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89B148FE6
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806724; cv=none; b=FdWWKjJkROfn2DmyDByNm5F1e6oi9nANyZrWJEZr4U9ihYqcRiLfUfZjeu5ynunqTG0/viXrEaXF53p18cX+SSnKGu/6i6wW2AuLrBsNCY9bCsekyiGKU6LCmosG+7mnB7A9xvNdgIJb8k0PaL9/VSlpaIMv1yyuOkRBqeXDJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806724; c=relaxed/simple;
	bh=KDjyitVzif5BhWidRs5kEg+NZ8d5pYM3cDN1FH+M2bY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nl7b0OXo+sZ2fe0IcPHDuifTNrKZCvCQ4d/PxqdXQZXKInNjIdNB5tiHuulI5uibM2BSPbHfqnuV18Uu+N7DPk0+tIMo9DO5KszheEeQKVwgpDbOVAQfWr9vZd+tXusTmal+ikMaC2Uc5+wloJuXYraiKX2pBC0QIAxotwWz4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CS2NhaK9; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07CC5441B2;
	Mon, 17 Feb 2025 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739806719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDjyitVzif5BhWidRs5kEg+NZ8d5pYM3cDN1FH+M2bY=;
	b=CS2NhaK9Mz/NMAgRJQJDtCy7RDgaNqj7Y0JNUkkHM3EYQsaql5BWxp9+QIicB5emOL7kkE
	ye39yKgyEzpCV2Xv1HPGZrVWup2OvJJN5jQ/Ij8pEEOcN4V2MaBwVK3eR9Z4EZqqEKreSI
	E2tDMy1TxKzmRr25wtxFvJqPAU9xyK7v+YIaUZr19jFDgoDbybm7B1zXU2VpZpRWu+zeEM
	eMzwQurDBdrKe/EyfAfvPP64rC2VEBUh6HezMDBreFcaIwLiEsY9bDdmlBiR2Ill7bOsqL
	PWXKbSrvapuc45T5fcDYrfEEUyMgNADwWkR7bCPWdH3T34PMspdG9U7fCZnqXw==
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
Subject: Re: [PATCH 23/29] iio: adc: max1027: Move claim of direct mode up
 one level and use guard()
In-Reply-To: <20250217141630.897334-24-jic23@kernel.org> (Jonathan Cameron's
	message of "Mon, 17 Feb 2025 14:16:23 +0000")
References: <20250217141630.897334-1-jic23@kernel.org>
	<20250217141630.897334-24-jic23@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 17 Feb 2025 16:38:37 +0100
Message-ID: <87seoctwci.fsf@bootlin.com>
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

Hello Jonathan,

On 17/02/2025 at 14:16:23 GMT, Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Move iio_device_claim_direct_mode() into the read_raw() callback
> and use guard() to release a mutex. This enables simpler error
> handling via direct returns.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

