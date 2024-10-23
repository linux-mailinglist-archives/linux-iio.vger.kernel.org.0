Return-Path: <linux-iio+bounces-10985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8939D9ACA62
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C397CB22F2A
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5D1AC43A;
	Wed, 23 Oct 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="WchVl0Gs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D401AD9EE
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687499; cv=none; b=k5pCkHOnjP4Ak4zDnEAEDOXQuEVNSuiWVoBYlby1Ro61SyMYB5IVsc7T3C1te2tPKm2ivV6csQPgeCXuV05wNu4rvrRmMAzTBfdcJjnLHg1CDcMVWa2dRAdN/0Kt8Pv/Rau5hnEESeGKlZiZUdOPEUViIFoZG2VfLY8CoE8Q7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687499; c=relaxed/simple;
	bh=HHP1eM93bGJI8vjvVV38PAk6nYXoY0kZEk6tG6K5d+g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuOxlh/AQvDD+G+IZ9lSSbrVAved74qdRaZNPqqyWT1gTYQTHE/bjKWA6j+pPp71rLpxK13dOAH1YG3H9iM3ZXPakkRGHc7YslLnKla/c6qxs+l6AJf9m/gGdTXtTZ1CLjXvReUZGDjWumGaDzkWL3luJvp4/yvy7SxeUK3VwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=WchVl0Gs; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1829B120004;
	Wed, 23 Oct 2024 15:44:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1829B120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729687484;
	bh=D2j+rLGEzf0baT2XE6sZfyGRhKr8KtNK+Zn6A3QbhX0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=WchVl0GsYIAxrzD7rdYHpQbfeUaXi3wZlGd2ZqM1CwjduqVDI87/AtHGKaMGxDJsB
	 9reTSX4lNzWM0o+CBS09cYpPOIKI9fVbWHCLB9Y6HVSTQI2Yh0htV2k1UtIS7yJcWT
	 ozQ3kN3eDUDj4bbOqHSsLpMBu5zIQbQvxZVvowOsqhmUhAOP71oguXTFYViOpHbn9r
	 ZqgQmRze4UTjafgYiJV39owNtIA4zd6Ae3dosa3PieFjDZkmnlaYQRcLWBkEnjKGlf
	 LLzZ+ipjvnOyXdr+cHla7dGFea0iAg5qMYcKua3gBBFJUtTZislgVwtubrdqVVEkT8
	 +OHZ+DM8bMHVw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 23 Oct 2024 15:44:43 +0300 (MSK)
Date: Wed, 23 Oct 2024 15:44:43 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: accel: replace s64 __aligned(8) with aligned_s64
Message-ID: <20241023124406.v6idzofluwghalqc@CAB-WSD-L081021>
References: <20241020180720.496327-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241020180720.496327-1-jic23@kernel.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188654 [Oct 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/23 09:40:00 #26790600
X-KSMG-AntiVirus-Status: Clean, skipped

On Sun, Oct 20, 2024 at 07:07:20PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> e4ca0e59c394 ("types: Complement the aligned types with signed 64-bit one")
> introduced aligned_s64. Use it for all IIO accelerometer drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

> 
> ---
> 
> I debated whether to split this up by driver by the time we've done all IIO
> drivers that will be a very large number of trivial patches.
> 
> The changes are minor enough that they shouldn't present much of a
> backporting challenge if needed for future fixes etc.
> 
> I'm find splitting them up if people prefer.
> Next on my list is to look at adding runtime checks that the buffers
> containing these timestamps are big enough but I want this out of the
> way first.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/accel/bma180.c          | 3 ++-
>  drivers/iio/accel/bma220_spi.c      | 1 +
>  drivers/iio/accel/bma400_core.c     | 2 +-
>  drivers/iio/accel/bmc150-accel.h    | 3 ++-
>  drivers/iio/accel/fxls8962af-core.c | 3 ++-
>  drivers/iio/accel/kionix-kx022a.c   | 3 ++-
>  drivers/iio/accel/kxcjk-1013.c      | 3 ++-
>  drivers/iio/accel/kxsd9.c           | 3 ++-
>  drivers/iio/accel/mma7455_core.c    | 3 ++-
>  drivers/iio/accel/mma8452.c         | 3 ++-
>  drivers/iio/accel/msa311.c          | 3 ++-
>  drivers/iio/accel/mxc4005.c         | 3 ++-
>  drivers/iio/accel/stk8312.c         | 3 ++-
>  drivers/iio/accel/stk8ba50.c        | 3 ++-
>  14 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 1fe20eb78a0b..41a517e1630f 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -21,6 +21,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/types.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> @@ -144,7 +145,7 @@ struct bma180_data {
>  	/* Ensure timestamp is naturally aligned */
>  	struct {
>  		s16 chan[4];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  };
>  
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index d33218e40c79..2d27a592a61e 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/types.h>
>  #include <linux/spi/spi.h>
>  
>  #include <linux/iio/buffer.h>
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index d96840d135c6..eb32c963dfc8 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -115,7 +115,7 @@ struct bma400_data {
>  	struct {
>  		__le16 buff[3];
>  		u8 temperature;
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} buffer __aligned(IIO_DMA_MINALIGN);
>  	__le16 status;
>  	__be16 duration;
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index 7775c5edaeef..7a7baf52e595 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -6,6 +6,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/types.h>
>  #include <linux/workqueue.h>
>  
>  struct regmap;
> @@ -69,7 +70,7 @@ struct bmc150_accel_data {
>  	 */
>  	struct {
>  		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} scan;
>  	u8 bw_bits;
>  	u32 slope_dur;
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 37f33c29fb4b..ab427f3461db 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -22,6 +22,7 @@
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> @@ -163,7 +164,7 @@ struct fxls8962af_data {
>  	const struct fxls8962af_chip_info *chip_info;
>  	struct {
>  		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} scan;
>  	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
>  	struct iio_mount_matrix orientation;
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 53d59a04ae15..32387819995d 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -16,6 +16,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/string_choices.h>
> +#include <linux/types.h>
>  #include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
> @@ -292,7 +293,7 @@ struct kx022a_data {
>  	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
>  	struct {
>  		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} scan;
>  };
>  
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index b76df8816323..bbf65fc97b08 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -11,6 +11,7 @@
>  #include <linux/bitops.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/types.h>
>  #include <linux/acpi.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> @@ -250,7 +251,7 @@ struct kxcjk1013_data {
>  	/* Ensure timestamp naturally aligned */
>  	struct {
>  		s16 chans[AXIS_MAX];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  	u8 odr_bits;
>  	u8 range;
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 70dfd6e354db..6d2b0a22e550 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sysfs.h>
>  #include <linux/slab.h>
> +#include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/bitops.h>
> @@ -215,7 +216,7 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
>  	 */
>  	struct {
>  		__be16 chan[4];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} hw_values;
>  	int ret;
>  
> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
> index a34195b3215d..50f7ac1845c6 100644
> --- a/drivers/iio/accel/mma7455_core.c
> +++ b/drivers/iio/accel/mma7455_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>
>  
>  #include "mma7455.h"
>  
> @@ -58,7 +59,7 @@ struct mma7455_data {
>  	 */
>  	struct {
>  		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} scan;
>  };
>  
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 62e6369e2269..de4525b30edc 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -32,6 +32,7 @@
>  #include <linux/delay.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/types.h>
>  
>  #define MMA8452_STATUS				0x00
>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> @@ -115,7 +116,7 @@ struct mma8452_data {
>  	/* Ensure correct alignment of time stamp when present */
>  	struct {
>  		__be16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} buffer;
>  };
>  
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index 57025354c7cd..e7fb860f3233 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -34,6 +34,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/string_choices.h>
> +#include <linux/types.h>
>  #include <linux/units.h>
>  
>  #include <linux/iio/buffer.h>
> @@ -893,7 +894,7 @@ static irqreturn_t msa311_buffer_thread(int irq, void *p)
>  	__le16 axis;
>  	struct {
>  		__le16 channels[MSA311_SI_Z + 1];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} buf;
>  
>  	memset(&buf, 0, sizeof(buf));
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index fc54a2a4693c..cb5c4e354fc0 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -11,6 +11,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/buffer.h>
> @@ -69,7 +70,7 @@ struct mxc4005_data {
>  	/* Ensure timestamp is naturally aligned */
>  	struct {
>  		__be16 chans[3];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  	bool trigger_enabled;
>  	unsigned int control;
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index abead190254b..471c154c3631 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/types.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -105,7 +106,7 @@ struct stk8312_data {
>  	/* Ensure timestamp is naturally aligned */
>  	struct {
>  		s8 chans[3];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  };
>  
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index a32a77324e92..cab592a68622 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/types.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -94,7 +95,7 @@ struct stk8ba50_data {
>  	/* Ensure timestamp is naturally aligned */
>  	struct {
>  		s16 chans[3];
> -		s64 timetamp __aligned(8);
> +		aligned_s64 timetamp;
>  	} scan;
>  };
>  
> -- 
> 2.46.2
> 
> 

-- 
Thank you,
Dmitry

