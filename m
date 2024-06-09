Return-Path: <linux-iio+bounces-6089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F47901538
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78211F2249C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1A1A29A;
	Sun,  9 Jun 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEmO9/bb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF551864C;
	Sun,  9 Jun 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717923893; cv=none; b=Wh8odlPoulIUCXkZYpLLuP9h7NhJmrJX33YRqb827/2/cKGfbBZOkAXrTtNqcjEORPORfcELx29tlsBKDG1Md2wgsrrxiCNNJGeOFr6lEze8ahxdkFpQUCq1pbYXJwEto5cSJAo0XFdJ8Vx00l23ZjXB7OXntCyWuhqln1VsHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717923893; c=relaxed/simple;
	bh=z8UDplykmGnLjGkVRX9TLDaOKMipuAvhGaovA/mVoAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHZP6GXmhi9Sp6McTK0Ek5mxqGXv1K6XKnyDTVZLgStzYf5QZ058yswiKIlYMQSCod4+wCVaGUID/0T+4AXIkS8rxDyBZJTYsW1jp1UeIHna1spnc5O1ENpL06lUbANGpWTP6wS0vKBaSJDEPy6nOgm8Z0TIrhdjw+9tWCa/iRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEmO9/bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37940C2BD10;
	Sun,  9 Jun 2024 09:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717923893;
	bh=z8UDplykmGnLjGkVRX9TLDaOKMipuAvhGaovA/mVoAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gEmO9/bb9f5HDkR+z/DyDR8pGOXHx4+UnoERXwfM9C4APJuknYhurJIq4+ktXaUzo
	 iEzX6uECQRifp1ywmqdmryBJD4MmEJ/UBbrHOA5puDw0cgvahd6oz0u+mdP5lD1FLu
	 9+Lc1g1PBl+T6ZAlcBRZKgESNylxKyQKCjn0oJKLLNbMgVNGBaQFYasZ2MV1kSHzmx
	 TTW5EA/XCnLphSR+NMnZ834MZHbDBlYF75MhUnMlgTt6VGPwejNUwRLSKAMHQRtYJa
	 fjLfDDz5OxgTSTK8lIBAW/o39d6izImZNtTZNQf3KEXNAwJ7ZACdx8/FDUSDrgWrzY
	 VsribZddW/F0Q==
Date: Sun, 9 Jun 2024 10:04:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240609100418.7018090c@jic23-huawei>
In-Reply-To: <20240604133639.959682-1-dima.fedrau@gmail.com>
References: <20240604133639.959682-1-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 15:36:39 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> The device has four programmable temperature alert outputs which can be
> used to monitor hot or cold-junction temperatures and detect falling and
> rising temperatures. It supports up to 255 degree celsius programmable
> hysteresis. Each alert can be individually configured by setting following
> options in the associated alert configuration register:
> - monitor hot or cold junction temperature
> - monitor rising or falling temperature
> - set comparator or interrupt mode
> - set output polarity
> - enable alert
> 
> This patch binds alert outputs to iio events:
> - alert1: hot junction, rising temperature
> - alert2: hot junction, falling temperature
> - alert3: cold junction, rising temperature
> - alert4: cold junction, falling temperature
> 
> All outputs are set in comparator mode and polarity depends on interrupt
> configuration.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

I think I'd have done this by taking a copy of the channels array and
putting just replacing the .event_spec and .num_event_specs fields
but what you have here works so fair enough.  It's always a fine
balance between when it makes sense to make everything data that you
pick from and when you use code to tweak that data a little.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take a look.

Thanks,

Jonathan

> ---
> 
> Changes in V2:
>   - Remove pretty printing patches from series
>   - Add patch for providing index for both channels(ABI change)!
>     Suggested by Jonathan, hope this okay.
>   - Remove formatting in a precursor patch
>   - Add lock documentation
>   - Add define MCP9600_TEMP_SCALE_NUM and use it instead of MICRO. MICRO is
>     type unsigned long which we have to cast to int when using
>     multiplication or division, because we are handling negative values.
>   - Use switch statement in mcp9600_write_thresh
>   - Replaced generic interrupt handler with four separate interrupt handler
>   - Use one lock instead of four
>   - Added error check for mcp9600_probe_alerts
> 
> Changes in V3:
>   - Remove patch for providing index for both channels(ABI change)!
>   - Treat hysteresis as offset and remove the lock, since dependency
>     between hysteresis and threshold doesn't exist anymore.
>   - Use helper function for handling alerts to avoid code duplication
>   - Scale max,min defines for hot and cold junction temperature to micro
> 
> Changes in V4:
>   - Added version number of patch
> 
> Changes in V5:
>   - move "struct iio_dev *indio_dev = private;" to mcp9600_alert_handler
>     instead of setting it in each alert handler to avoid code duplication
>   - Only create sysfs interfaces for events which are present.
> 
> ---
>  drivers/iio/temperature/mcp9600.c | 363 ++++++++++++++++++++++++++++--
>  1 file changed, 349 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 46845804292b..bfa873731d61 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -6,39 +6,123 @@
>   * Author: <andrew.hepp@ahepp.dev>
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  
>  /* MCP9600 registers */
>  #define MCP9600_HOT_JUNCTION 0x0
>  #define MCP9600_COLD_JUNCTION 0x2
> +#define MCP9600_STATUS			0x4
> +#define MCP9600_STATUS_ALERT(x)		BIT(x)
> +#define MCP9600_ALERT_CFG1		0x8
> +#define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
> +#define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> +#define MCP9600_ALERT_CFG_ACTIVE_HIGH	BIT(2)
> +#define MCP9600_ALERT_CFG_FALLING	BIT(3)
> +#define MCP9600_ALERT_CFG_COLD_JUNCTION	BIT(4)
> +#define MCP9600_ALERT_HYSTERESIS1	0xc
> +#define MCP9600_ALERT_HYSTERESIS(x)	(MCP9600_ALERT_HYSTERESIS1 + (x - 1))
> +#define MCP9600_ALERT_LIMIT1		0x10
> +#define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
> +#define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
>  #define MCP9600_DEVICE_ID 0x20
>  
>  /* MCP9600 device id value */
>  #define MCP9600_DEVICE_ID_MCP9600 0x40
>  
> -static const struct iio_chan_spec mcp9600_channels[] = {
> +#define MCP9600_ALERT_COUNT		4
> +
> +#define MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO	-200000000
> +#define MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO	1800000000
> +
> +#define MCP9600_MIN_TEMP_COLD_JUNCTION_MICRO	-40000000
> +#define MCP9600_MAX_TEMP_COLD_JUNCTION_MICRO	125000000
> +
> +enum mcp9600_alert {
> +	MCP9600_ALERT1,
> +	MCP9600_ALERT2,
> +	MCP9600_ALERT3,
> +	MCP9600_ALERT4
> +};
> +
> +static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
> +	[MCP9600_ALERT1] = "alert1",
> +	[MCP9600_ALERT2] = "alert2",
> +	[MCP9600_ALERT3] = "alert3",
> +	[MCP9600_ALERT4] = "alert4",
> +};
> +
> +static const struct iio_event_spec mcp9600_events[] = {
>  	{
> -		.type = IIO_TEMP,
> -		.address = MCP9600_HOT_JUNCTION,
> -		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_HYSTERESIS),
>  	},
>  	{
> -		.type = IIO_TEMP,
> -		.address = MCP9600_COLD_JUNCTION,
> -		.channel2 = IIO_MOD_TEMP_AMBIENT,
> -		.modified = 1,
> -		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_HYSTERESIS),
>  	},
>  };
>  
> +#define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, cj_ev_spec_off) \
> +	{								       \
> +		{							       \
> +			.type = IIO_TEMP,				       \
> +			.address = MCP9600_HOT_JUNCTION,		       \
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
> +					      BIT(IIO_CHAN_INFO_SCALE),	       \
> +			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
> +			.num_event_specs = hj_num_ev,			       \
> +		},							       \
> +		{							       \
> +			.type = IIO_TEMP,				       \
> +			.address = MCP9600_COLD_JUNCTION,		       \
> +			.channel2 = IIO_MOD_TEMP_AMBIENT,		       \
> +			.modified = 1,					       \
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
> +					      BIT(IIO_CHAN_INFO_SCALE),	       \
> +			.event_spec = &mcp9600_events[cj_ev_spec_off],	       \
> +			.num_event_specs = cj_num_ev,			       \
> +		},							       \
> +	}
> +
> +static const struct iio_chan_spec mcp9600_channels[][2] = {
> +	MCP9600_CHANNELS(0, 0, 0, 0), /* Alerts: - - - - */
> +	MCP9600_CHANNELS(1, 0, 0, 0), /* Alerts: 1 - - - */
> +	MCP9600_CHANNELS(1, 1, 0, 0), /* Alerts: - 2 - - */
> +	MCP9600_CHANNELS(2, 0, 0, 0), /* Alerts: 1 2 - - */
> +	MCP9600_CHANNELS(0, 0, 1, 0), /* Alerts: - - 3 - */
> +	MCP9600_CHANNELS(1, 0, 1, 0), /* Alerts: 1 - 3 - */
> +	MCP9600_CHANNELS(1, 1, 1, 0), /* Alerts: - 2 3 - */
> +	MCP9600_CHANNELS(2, 0, 1, 0), /* Alerts: 1 2 3 - */
> +	MCP9600_CHANNELS(0, 0, 1, 1), /* Alerts: - - - 4 */
> +	MCP9600_CHANNELS(1, 0, 1, 1), /* Alerts: 1 - - 4 */
> +	MCP9600_CHANNELS(1, 1, 1, 1), /* Alerts: - 2 - 4 */
> +	MCP9600_CHANNELS(2, 0, 1, 1), /* Alerts: 1 2 - 4 */
> +	MCP9600_CHANNELS(0, 0, 2, 0), /* Alerts: - - 3 4 */
> +	MCP9600_CHANNELS(1, 0, 2, 0), /* Alerts: 1 - 3 4 */
> +	MCP9600_CHANNELS(1, 1, 2, 0), /* Alerts: - 2 3 4 */
> +	MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
> +};





