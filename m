Return-Path: <linux-iio+bounces-11797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE999B9585
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB511C2200E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAE1B4F2D;
	Fri,  1 Nov 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1tpwuz/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25214884F;
	Fri,  1 Nov 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478947; cv=none; b=mR1bXfNIPeDiMirgBZ0ii6XLo+gruH1V6tZ6fCHMiko3iE1WpeE5FIjcbIO8Ewy04A/XnZ8X2QT/Op9/ra0LJ0W/hhJLt/p8vMnZYbggU65ZFbNjnmoU9KHAlVU6Vzk6U8P8kyKKY+axhuEa6+kwJZue8pYtUkKamT4LlrG+Ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478947; c=relaxed/simple;
	bh=VAe8JaPazApSPoTOUWuTu3lf+OPBhaGqX0zo7n9+08M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWL5jk0db7UymXwhDaZvx62ra8/NwbhVNmn7M/74Ksndfv44xQFvoLvEhR4TX2KWeaylIFDkoWvBOMp15eOlfP8EnFKp7SVPCm4bipO0gLFVrncw+scV5BqqKm6c0X//qMAgppnvLQz+hvdwSfPwRMgvxSbmef0EFQfWe9RGz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1tpwuz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5961FC4CECD;
	Fri,  1 Nov 2024 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730478946;
	bh=VAe8JaPazApSPoTOUWuTu3lf+OPBhaGqX0zo7n9+08M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1tpwuz/azyd+hEHYQjWyu3g6WzlxirePGr5tCzhPoWJyPcCzmsEvwV5GXsMRiwNa
	 vlsRjpdYWH3r9cTrFOMjThIeBCPTmSrYRXty9uluBDplvDMsRjzeVBufZIv23P8Py5
	 B7z70h1jPSyqTn6Og+yxxM/Tsp42XQ3+MjY/4Ls2AIA8SfGIUxy4UOBUr+IYDTPa5V
	 aVTDYB2GetSTplCXpGubAh0HZbMfrkG/YtEAt2E80CgPtLFf2CYFwUvcnRW7i/BlVU
	 9+Zvvh0KxeSd6F46d7hxskBtXy5cumZz/EbDo5FuUh1umx64DRth2XtYdUIki3KtSn
	 RvS3gzWoPPEgg==
Date: Fri, 1 Nov 2024 16:35:35 +0000
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
Subject: Re: [PATCH v2 10/15] iio: imu: bmi323: use bool for event state
Message-ID: <20241101163535.644a006f@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-10-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-10-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:05 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Since the write_event_config callback now uses a bool for the state
> parameter, update the signatures of the functions it calls accordingly.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied.
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 76a88e1ccc1d89988eb52d6b1be8da0f5005f0e6..161bb1d2e761688dd740635f8a2830e9562d1b59 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -467,7 +467,7 @@ static int bmi323_feature_engine_events(struct bmi323_data *data,
>  			    BMI323_FEAT_IO_STATUS_MSK);
>  }
>  
> -static int bmi323_step_wtrmrk_en(struct bmi323_data *data, int state)
> +static int bmi323_step_wtrmrk_en(struct bmi323_data *data, bool state)
>  {
>  	enum bmi323_irq_pin step_irq;
>  	int ret;
> @@ -484,7 +484,7 @@ static int bmi323_step_wtrmrk_en(struct bmi323_data *data, int state)
>  	ret = bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
>  				    BMI323_STEP_SC1_WTRMRK_MSK,
>  				    FIELD_PREP(BMI323_STEP_SC1_WTRMRK_MSK,
> -					       state ? 1 : 0));
> +					       state));
>  	if (ret)
>  		return ret;
>  
> @@ -506,7 +506,7 @@ static int bmi323_motion_config_reg(enum iio_event_direction dir)
>  }
>  
>  static int bmi323_motion_event_en(struct bmi323_data *data,
> -				  enum iio_event_direction dir, int state)
> +				  enum iio_event_direction dir, bool state)
>  {
>  	unsigned int state_value = state ? BMI323_FEAT_XYZ_MSK : 0;
>  	int config, ret, msk, raw, field_value;
> @@ -570,7 +570,7 @@ static int bmi323_motion_event_en(struct bmi323_data *data,
>  }
>  
>  static int bmi323_tap_event_en(struct bmi323_data *data,
> -			       enum iio_event_direction dir, int state)
> +			       enum iio_event_direction dir, bool state)
>  {
>  	enum bmi323_irq_pin tap_irq;
>  	int ret, tap_enabled;
> 


