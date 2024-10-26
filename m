Return-Path: <linux-iio+bounces-11341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625009B185E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81E2B22EDB
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FA17C7C6;
	Sat, 26 Oct 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZsRTfaQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9231D362B;
	Sat, 26 Oct 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947606; cv=none; b=IhsWBlQGRpG288IMIyma9avIipaK4GfutEOYY2j8lvNBkwOiuGyJLQO3wNUsb/U049yqr0MVQrgHgxcZFLbUXRPcGN7RAg15tnzDFGey60iGfD5F0LWpFXPa2c3AXn1oYE1JxiExPZH8VrqZlxqFPDQRsQUAL74aJBpGVzwwILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947606; c=relaxed/simple;
	bh=AKe3BO5YIIiqIgoXshZ0dnLuyG4anBM5h4hKomPr3ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM5pSi/xl1kX0leSRjA/vE70uZoVrOor+zT72BhvChpgpjLUb9qZhY6WF0kkdVjn6+mBUhsC/1M590S2R/korvq6bCblch5/6BDbzNgDAOWl3Gz1qd8lpAKWzTTOKsE/o8xS1ILrrdiw1+EVJQLjdvafW5IdDnXw+tyf+LH3cVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZsRTfaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEF5C4CEC6;
	Sat, 26 Oct 2024 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729947606;
	bh=AKe3BO5YIIiqIgoXshZ0dnLuyG4anBM5h4hKomPr3ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZsRTfaQy0QEOptCpJbvD7bNT06ZGWWc5yS/hsKJU16O1pY51oRrg0HW8Hi5uam6W
	 +xuC4+VZpCu5px7ZfavBBuAwldCR61BHzgEs/lNJs2nAHdjESQxoIkoxYkYI80W5aj
	 FM89u0FY0f9duLGBe+5z2ajHcRifZm5WaRvi31EfvPMQq/aWCTyUroeu51IB/y49/r
	 BjlgYiT4QQPVns5WGal3vv1pd34lXQwkq8QHvwq8W96i6vxqx+dfgh/MDRX8l/3ipc
	 eWIHiMiu8zaOKf+h65OlT1qZV7AqLl0hIr9CoqZsMakQ4Qk8c01/Jkg7IP+b9ghVkz
	 Sv3qwmcfq5vWg==
Date: Sat, 26 Oct 2024 13:59:08 +0100
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
Subject: Re: [PATCH 7/7] iio: fix write_event_config signature
Message-ID: <20241026135908.092c2736@jic23-huawei>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-7-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
	<20241024-iio-fix-write-event-config-signature-v1-7-7d29e5a31b00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 11:11:29 +0200
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

It's a nice cleanup, but the challenge of this sort of change is the odd ways
various drivers use what you are changing.

So ever single case needs close inspection.  I took a fairly broad look at it and there
is at least one case that I think is broken by the change :(
+ a bunch of others where the result needs tidying up to not end up confusing.


Jonathan

> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 9f6f0a45efce7981736c3a8f005f4fef83f05cfd..5d2bda1a6a783c3f5bf6dfa6830bc80cc7055e01 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -1386,7 +1386,7 @@ static int adxl380_write_event_config(struct iio_dev *indio_dev,
>  				      const struct iio_chan_spec *chan,
>  				      enum iio_event_type type,
>  				      enum iio_event_direction dir,
> -				      int state)
> +				      bool state)
>  {
>  	struct adxl380_state *st = iio_priv(indio_dev);
>  	enum adxl380_axis axis;




> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index fa1799b0b0dff35ccd811c4abee3883249c184da..0656e35a1c4e5c1268a4bbf7011fd9282053dbbf 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -225,7 +225,7 @@ static int mma9551_write_event_config(struct iio_dev *indio_dev,
>  				      const struct iio_chan_spec *chan,
>  				      enum iio_event_type type,
>  				      enum iio_event_direction dir,
> -				      int state)
> +				      bool state)
>  {
>  	struct mma9551_data *data = iio_priv(indio_dev);
>  	int ret;

Good to push down into functions called.

> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 87c54e41f6ccd2f9311653b757b2d794df1dd5d4..36cbfcbba04d6920ba68bebd70d21bc3898a044d 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1253,7 +1253,7 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
>  				      const struct iio_chan_spec *chan,
>  				      enum iio_event_type type,
>  				      enum iio_event_direction dir,
> -				      int state)
> +				      bool state)
>  {
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret;
Good to push down the state into the functions called.

> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 1e6c083ea5c1bbddb878f08cd4f4be725c0e319f..76a88e1ccc1d89988eb52d6b1be8da0f5005f0e6 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -785,7 +785,7 @@ static const struct attribute_group bmi323_event_attribute_group = {
>  static int bmi323_write_event_config(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     enum iio_event_type type,
> -				     enum iio_event_direction dir, int state)
> +				     enum iio_event_direction dir, bool state)
>  {
>  	struct bmi323_data *data = iio_priv(indio_dev);
>  
Mix of types used to store state. Would be good to chase the boolean though. But no
need to do that for this series.



> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index fb4c6c39ff2e157593f02513cc8e01cd7eea9bdf..caefa15e559b8808051ff1c7f82c3f36c947933c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1959,7 +1959,7 @@ static int
>  st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>  			      const struct iio_chan_spec *chan,
>  			      enum iio_event_type type,
> -			      enum iio_event_direction dir, int state)
> +			      enum iio_event_direction dir, bool state)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
state is stored in a mix of bool and int in this driver. Might be a nice to cleanup
thing but not strictly part of what you are doing here.

> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 2e0170be077aef9aa194fab51afbb33aec02e513..a36cdad113f774ef8733eb1aaef0f87d5d2532f1 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -502,7 +502,8 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
>  static int adux1020_write_event_config(struct iio_dev *indio_dev,
>  				       const struct iio_chan_spec *chan,
>  				       enum iio_event_type type,
> -				       enum iio_event_direction dir, int state)
> +				       enum iio_event_direction dir,
> +				       bool state)

This one is a bug, because state is used as an intermediate for other stuff.
Bad code, but needs fixing before you can do this.

>  {
>  	struct adux1020_data *data = iio_priv(indio_dev);
>  	int ret, mask;
> diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
> index 11f2ab4ca261813aff04b8c25d4595a531fb43cb..95861b2a5b2d94011d894959289c5c4f06cc1efe 100644
> --- a/drivers/iio/light/apds9300.c
> +++ b/drivers/iio/light/apds9300.c
> @@ -321,7 +321,7 @@ static int apds9300_read_interrupt_config(struct iio_dev *indio_dev,
>  
>  static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
>  		const struct iio_chan_spec *chan, enum iio_event_type type,
> -		enum iio_event_direction dir, int state)
> +		enum iio_event_direction dir, bool state)
>  {
>  	struct apds9300_data *data = iio_priv(indio_dev);
>  	int ret;
Tidying up the interrupt state to all be tracked with a bool in here would make this better, but
not strictly related to what you have here.

> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 079e02be1005210ddd30b384ffa1ff7feeb098d7..8adc74040db2bddf93fbb773e3519abcc726b9a6 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -1071,7 +1071,7 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
>  				       const struct iio_chan_spec *chan,
>  				       enum iio_event_type type,
>  				       enum iio_event_direction dir,
> -				       int state)
> +				       bool state)
>  {
>  	struct apds9306_data *data = iio_priv(indio_dev);
>  	struct apds9306_regfields *rf = &data->rf;
This has a rather silly regmap_field_write() related if statement you could clean up but
that's an optional extra.

> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 3a56eaae5a68f2891d061871c7013f0b5447bb47..a7f0cc99f236685900f89fbc48de3be0e9a40704 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -757,7 +757,7 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
>  				       const struct iio_chan_spec *chan,
>  				       enum iio_event_type type,
>  				       enum iio_event_direction dir,
> -				       int state)
> +				       bool state)
>  {
>  	struct apds9960_data *data = iio_priv(indio_dev);
>  	int ret;
Should change type of pxs_int etc to bool.



> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index ff6b5d8b582b33eba60b769dff529caa00fb7244..b67c811cdf54af8de3dec3e1713a41312fb238d4 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -553,7 +553,7 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
>  				const struct iio_chan_spec *chan,
>  				enum iio_event_type type,
>  				enum iio_event_direction dir,
> -				int state)
> +				bool state)
>  {
>  	struct ltr390_data *data = iio_priv(indio_dev);
>  	int ret;

See review of patch 2.



> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index cab468a82b616a23394977da1d8822d29d8941d3..13086048ee5ffae77c26db8cbd3cb7002e1a72e2 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1081,7 +1081,7 @@ static int tsl2772_write_interrupt_config(struct iio_dev *indio_dev,
>  					  const struct iio_chan_spec *chan,
>  					  enum iio_event_type type,
>  					  enum iio_event_direction dir,
> -					  int val)
> +					  bool val)
>  {
>  	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  

val ? true : false
in here should go.

> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index d8fb34060d3db88a3ba5ecdc209b14be8e42e8b9..8c2f1cf062033dd8580f8f75649543289fbf9fb7 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -874,7 +874,7 @@ static int hx9023s_write_event_config(struct iio_dev *indio_dev,
>  				      const struct iio_chan_spec *chan,
>  				      enum iio_event_type type,
>  				      enum iio_event_direction dir,
> -				      int state)
> +				      bool state)
>  {
>  	struct hx9023s_data *data = iio_priv(indio_dev);
Has a !!state that should go. 
>  
> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> index 6e96b764fed8b577d71c3146210679b0b61d4c38..eded45a778737a699f8b69ad86a9909594e04b32 100644
> --- a/drivers/iio/proximity/irsd200.c
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -648,7 +648,8 @@ static int irsd200_read_event_config(struct iio_dev *indio_dev,

This has a !!state that should go.

>  static int irsd200_write_event_config(struct iio_dev *indio_dev,
>  				      const struct iio_chan_spec *chan,
>  				      enum iio_event_type type,
> -				      enum iio_event_direction dir, int state)
> +				      enum iio_event_direction dir,
> +				      bool state)
>  {
>  	struct irsd200_data *data = iio_priv(indio_dev);
>  	unsigned int tmp;
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 3f4eace05cfc6a4679fe82854dc059aa4a710d6d..e7da02c59b753158c30c7473bdeea8886a2977a3 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -540,7 +540,7 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     enum iio_event_type type,
>  				     enum iio_event_direction dir,
> -				     int state)
> +				     bool state)
>  {
This one treats state as an integer.  We should change that before applying this patch.

>  	struct sx9500_data *data = iio_priv(indio_dev);
>  	int ret;

