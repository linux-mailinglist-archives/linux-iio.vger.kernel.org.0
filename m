Return-Path: <linux-iio+bounces-11335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D89B17FA
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493F7B20E7F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334231D5175;
	Sat, 26 Oct 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEOeoPES"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C31CEABB;
	Sat, 26 Oct 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945351; cv=none; b=k462nABPd3Rb6EHivEq0EIgPoMf50QfKxV/Joz9CcYEW7S34Ory6qFUfJKaYOfijF7ekd13LqAOt7ptY0HyrzliKg4QC+IO7ZPnOli8FMYd7LFt99flLzcpmE+8cdBMKMXt40lpg487A8T0fx1uyWGchXowFF3UG2m0pNt5J0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945351; c=relaxed/simple;
	bh=nN9ySBQFhI6eChKsKY01UO/86r/vMQHDkXXeMgpaQuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2mtuHZ0/hdmOLIJn8eJF8V8jbq4OVYb8Hjzv/nDnRsPJdpCnmo9dB4NB2ZMW8WWSTk4Kz7yC91IuDcPYf4CsRDETZuKS1+POdCa4HOARx/D70BTYHLTc3hGg+FbEEMO9/9frqdjRS9MgmSCKJzomQROb0kH7AaBcg5o5vpuP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEOeoPES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873FAC4CEC6;
	Sat, 26 Oct 2024 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945350;
	bh=nN9ySBQFhI6eChKsKY01UO/86r/vMQHDkXXeMgpaQuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hEOeoPESHoSNQTqbqubJnp5p1c4P0R4aVFF9XaRXSalTHz/vjsXFMwWmCjCkMIVqK
	 DrptHqyoqXrMwF5gMZibAYCrs3Laqsh2YAlynRDlADU/NFYpHWb6uJfUHhiu4SZreu
	 5E7yKePUlRwgCfK7Xbi6T0tu5VqnlHze9AK5fVNlSpbUQIVDbHT+DkU8ejkNSpwEjV
	 IB1T0YGgx8ZZlR8ymYbJ6U8+xDDEpz/+5qlmHsWXVh/akxFMmkialIOfzHWSo5Og52
	 Iy8apVUzzUfCPnU1CsVyViSRphyyd9kNho4hWA003vwp7TTzgBMGxfkqtOrLI0ZirY
	 cc9/Z6q4wXjnA==
Date: Sat, 26 Oct 2024 13:22:04 +0100
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
Subject: Re: [PATCH 2/7] iio: light: ltr390: simplify code in
 write_event_config callback
Message-ID: <20241026132204.4466fb54@jic23-huawei>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-2-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
	<20241024-iio-fix-write-event-config-signature-v1-2-7d29e5a31b00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 11:11:24 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/light/ltr390.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 8e0a3fc3d923a6f65d2a629c87e7bfd35d82a507..ff6b5d8b582b33eba60b769dff529caa00fb7244 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -558,9 +558,6 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
>  	struct ltr390_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	if (state != 1  && state != 0)
> -		return -EINVAL;
> -
>  	if (state == 0)

Once you apply the final patch, the == 0 here will make less sense.
Can tidy that up here or in that final patch by just making this
if (!state) etc

>  		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
>  
> 


