Return-Path: <linux-iio+bounces-11798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 754A19B9590
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC0B211C7
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D21A2562;
	Fri,  1 Nov 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l14K5SRt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9E450E2;
	Fri,  1 Nov 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479023; cv=none; b=FEmUuAnIWW1ys6HgkY4f8YCjjexOXZ8ywgbdybWk5dz1B8B9zqpkkfD+Tsah2mKulfYxLKlD9HjLPBeQyhyrnKBQp1Lw2bTKdFA76m4/outtckmqgDM9mfYSDqRgg1dSLMqURXbeFOBmn33MPEqH8CmXZ82YDJY1wGhs1RG3boY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479023; c=relaxed/simple;
	bh=QET17fHgUqNbmUw/e9EdVPDP2UwGuQA8tvgZ5/yNPgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hELM1OUBxEvOoV/1VgCPP4Ic+Go7+3UXySi4eqBzhsA1igsjrvNpx4b5fh311OUTX11OybQXCczi2SOXvSqmlUtFvoqfd3E+zrm7Avf894eFv5MOHOtcqPBskepW4/lzuH876bx8/z3hr+zGl4LfKssBERwOi/F0Vvhxf3FM1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l14K5SRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1342DC4CECD;
	Fri,  1 Nov 2024 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730479023;
	bh=QET17fHgUqNbmUw/e9EdVPDP2UwGuQA8tvgZ5/yNPgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l14K5SRt1vC7zG+/VORahqbr+H6ulbVRDGBFQqXQrlK65o/ub6oYejiOTlB3PTP+t
	 ojIvFQAiM6eCZyGzENOs0yMHTr2uO8dWnwfinokslRJsBu9P37TMZnux02xYOlCtzM
	 EK6rS/bitNuCRQeM04K0w8i1fLTqvY1KCpyTTO2NKLQRnQndxkAEUdekfUn/utuDTd
	 oOCDKuIEdj4R85KlKTGWq2I0JD6y348/hop0m/AUa2FbOMlj77L8f6dHmIh6//o3Mn
	 MuOX0BLZg2wZpUTzzIeaMq8bP81cyI1nIOFo50d6vJ288U5hiHbTmy88m3C7SKeuRO
	 wPHYT0ZSpEvKA==
Date: Fri, 1 Nov 2024 16:36:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit
 Ghosh <subhajit.ghosh@tweaklogic.com>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 11/15] iio: imu: st_lsm6dsx: use bool for event state
Message-ID: <20241101163651.09ca52d4@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-11-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-11-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:06 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Since the write_event_config callback now uses a bool for the state
> parameter, update the signature of the function it calls accordingly.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index caefa15e559b8808051ff1c7f82c3f36c947933c..509e0169dcd54e773540c4e3f1b56e5b737f80c3 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1865,7 +1865,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>  	return err;
>  }
>  
> -static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
> +static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
>  {
>  	const struct st_lsm6dsx_reg *reg;
>  	unsigned int data;
> 


