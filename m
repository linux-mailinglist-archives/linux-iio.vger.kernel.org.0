Return-Path: <linux-iio+bounces-11794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA49B9578
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B75AB2150E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21614884F;
	Fri,  1 Nov 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBtLqn68"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C772AE74;
	Fri,  1 Nov 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478787; cv=none; b=ovhCXcUnbwpjYLwnHRI/2RWk3qmKDHN/Va5HNts0CSzjGmddphZHWcTMVMEs2hOLcW2SwtXj2JfJRFKeIaMvRSv4zkmF9tFR3qRRGKh7fscDymA30tqaDRBwQ8UL1BsgWCUGHobcE/jum7WUK4H9ATW25sJnLdKSEAaZYPiMZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478787; c=relaxed/simple;
	bh=+/EHCXpDx5L4TC1H3xO4NniCxN6vsO+DisWCZAUvFfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f151/fZ3zU35dVj3JwL+MCu1nCO51UyAFm83K72pngRuUfkB3hHJ9O+kIkxjtYfq9mlg/8vTTXseEQLMb2KqNGdTfr7uTrNSTtaitI0PclsTt3l4PCttcTJ3NFEZNCAzz/EcwGdDpXV/iSqNuWPmH8AcrALQdDsS/G8RlT46zCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBtLqn68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B808C4CED1;
	Fri,  1 Nov 2024 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730478787;
	bh=+/EHCXpDx5L4TC1H3xO4NniCxN6vsO+DisWCZAUvFfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBtLqn68LZmCHrH+m2q+Ee/PWSyb1Rvg+5Fv/hPKvpVh3jY05/3tva+cCIdP41T1Z
	 7YcitCuFcBXL8gnUakCUv5+/pIhEiE/zRETRnzd1+eu4jiNSJ81ciVE69aYgaZQWn6
	 hWh/E97wU+AuCtetOZZ/13vi4oqK7IFjaX97YHy2Ah5S3yYTdd6tW8DA7/wBi+//FR
	 VWpaxupDfjRBdmCCfri9Gp4P+FrUJO+40jZS5FAYXVXC811dO7vCeGruTpavORgqOL
	 /Oja0SOgIzdZxPMV2gr0UicMD0nAqtoV94WLXlRmr0r6oJTLe262XwITFd1uRLtFsL
	 Iax0cC2YMmLKA==
Date: Fri, 1 Nov 2024 16:32:55 +0000
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
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev,
 Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2 07/15] iio: fix write_event_config signature
Message-ID: <20241101163255.5f4d9d70@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-7-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-7-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:02 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> write_event_config callback use an int for state, but it is actually a
> boolean. iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to write_event_config.
> 
> Fix signature and update all iio drivers to use the new signature.
> 
> This patch has been partially written using coccinelle with the
> following script:
> 
> $ cat iio-bool.cocci
> // Options: --all-includes
> 
> virtual patch
> 
> @c1@
> identifier iioinfo;
> identifier wecfunc;
> @@
>  static const struct iio_info iioinfo = {
>         ...,
>         .write_event_config =
> (
>  wecfunc
> |
>  &wecfunc
> ),
>         ...,
>  };
> 
> @@
> identifier c1.wecfunc;
> identifier indio_dev, chan, type, dir, state;
> @@
>  int wecfunc(struct iio_dev *indio_dev, const struct iio_chan_spec *chan, enum iio_event_type type, enum iio_event_direction dir,
> -int
> +bool
>  state) {
>   ...
>  }
> 
> make coccicheck MODE=patch COCCI=iio-bool.cocci M=drivers/iio
> 
> Unfortunately, this script didn't match all files:
> * all write_event_config callbacks using iio_device_claim_direct_scoped
>   were not detected and not patched.
> * all files that do not assign and declare the write_event_config
>   callback in the same file.
> 
> iio.h was also manually updated.
> 
> The patch was build tested using allmodconfig config.
> 
> cc: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Hi Julien,

I went through these by hand.  There are somewhere maybe it is worth
passing booleans down into leaf functions and only convert to int
right at the end (for a field write) but I don't think we care.
The cases here are more of the variety of converting a bool to an int
to use it as a bool (like the ones you clear up later in this series).

Neither is wrong, just inefficient, so applied and pushed out as testing
for 0-day to take a look.
Fingers crossed nothing got missed!

Jonathan

> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index ab427f3461dbbef535c2ec2cf2982202ca97bb82..f07fba17048e7b5c1958807b14d4bcb3ff87e26d 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -617,7 +617,7 @@ static int
>  fxls8962af_write_event_config(struct iio_dev *indio_dev,
>  			      const struct iio_chan_spec *chan,
>  			      enum iio_event_type type,
> -			      enum iio_event_direction dir, int state)
> +			      enum iio_event_direction dir, bool state)
>  {
>  	struct fxls8962af_data *data = iio_priv(indio_dev);
>  	u8 enable_event, enable_bits;
This passes the state variable into fxls8962af_event_setup() as an integer
and uses it as a boolean.  Might as well be bool all the way.


> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 81e718cdeae32d60581cb490148f4f1c0bd695c7..1a352c88598e5d701256aa8659a7f9683bce56f9 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1159,7 +1159,7 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
>  					   const struct iio_chan_spec *chan,
>  					   enum iio_event_type type,
>  					   enum iio_event_direction dir,
> -					   int state)
> +					   bool state)
This one could do with a follow up as the state variable is passed as an integer
to another function that then uses it as a bool.

>  {
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	enum gp2ap020a00f_cmd cmd;

