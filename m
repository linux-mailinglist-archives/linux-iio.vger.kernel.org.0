Return-Path: <linux-iio+bounces-22286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A210B1A33B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A82188D64C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559D265CCD;
	Mon,  4 Aug 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXKVk23Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D731236A9F
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314172; cv=none; b=K1KdBqbRFlVNi7v/vT4dof4syuqaIxSWjJzpsqQ3Qk+zcdWGQkyB98RS4D2MpQYnXPshv5GvPLaht31f8sQfsT9TYU+q1+r4SgBmfW39+UHvSof9d0PDjYF0180L6NdjkhorspBZ40S+gEb4QX9Uyt2PaLB99BqrhN8MYxpvIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314172; c=relaxed/simple;
	bh=ukIS0+M172Pmh+zG371KRb7KKe2oZJfwjlz2rEfZI4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hcCnMhWNDiGSCij9gtd35BASA62thXCxEKKKtth/ar8yObWEq8SajCKCLUiplCa3dKhs0wFGS0PvXH3gTk+Pfman7rLW2hhN7S6byyRN1bbo0hmiVkZFmww9jTzuRZpHXbw8TROycUIVB/uc7xMi1b/zk95mJ1klEtctWatAcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXKVk23Y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754314171; x=1785850171;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ukIS0+M172Pmh+zG371KRb7KKe2oZJfwjlz2rEfZI4s=;
  b=aXKVk23YdmPSMIZYkTn+CYZh7o/qe0ebEfqcFbakMztGcolkmErR5yhD
   DK7VTXaGr/Nmofe3f7ZdGudh2WHISTmm/Yc1KX4BSMvxQT9TQN2KWJpIC
   GmJllhtEZedmxCER0V1feAPzSxDoCJUfNwq/t+Z8SvjRnLP5+Olu+CjA4
   oYIQHfIEHSqQPQnLwLMNVP6MThtWyzW777tTVaVH86kP2sN8ZIzGPpe34
   g9T+q4OeNdXclX55rSXN+zcivmqeIqwtRYK35QAfZ4cqCW9f2zA0z7l2M
   5pSpUOVRvTG6ti7VOEZ/QgMgfmMpbDgv3wmX5+yB7yPVFVox+qdOqs+lU
   w==;
X-CSE-ConnectionGUID: /tlsWkLsQ9WFLda628L8Rw==
X-CSE-MsgGUID: zGZ2uuHwTWO4cYL2whNhdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56446211"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56446211"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 06:29:14 -0700
X-CSE-ConnectionGUID: 9/HwLRgsT666CZAnXBDeKw==
X-CSE-MsgGUID: 1GUYYC0OROmyysNNRX5l1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163428398"
Received: from cmdeoliv-mobl4.amr.corp.intel.com ([10.125.110.47])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 06:29:12 -0700
Message-ID: <7ae1bb4d28e7958cdda7fb53807017034f67628a.camel@linux.intel.com>
Subject: Re: [PATCH 16/16] iio: light: Simple conversions to
 iio_push_to_buffers_with_ts()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Abhash Jha
 <abhashkumarjha123@gmail.com>, Astrid Rost <astrid.rost@axis.com>, 
 =?ISO-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>, Gwendal
 Grignou <gwendal@chromium.org>, Christian Eggers
 <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 04 Aug 2025 06:29:10 -0700
In-Reply-To: <20250802164436.515988-17-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
	 <20250802164436.515988-17-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-02 at 17:44 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This new function allows for runtime checks on the provided source
> buffer
> being of sufficient size to accommodate the enabled channel data
> layout and
> the naturally aligned s64 timestamp (which is non obvious and a
> frequent
> source of bugs in the past).
>=20
> This patch includes the remaining simple cases for light sensor
> drivers.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mudit Sharma <muditsharma.info@gmail.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/light/bh1745.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/light/hid-sensor-als.c | 5 +++--
> =C2=A0drivers/iio/light/ltr501.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/light/opt4060.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0drivers/iio/light/rohm-bu27034.c=C2=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/light/rpr0521.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 4 ++--
> =C2=A0drivers/iio/light/si1145.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 5 +++--
> =C2=A0drivers/iio/light/vcnl4000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
4 ++--
> =C2=A0drivers/iio/light/veml6030.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A09 files changed, 18 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> index 4e9bd8f831f7..74a7bf9d610d 100644
> --- a/drivers/iio/light/bh1745.c
> +++ b/drivers/iio/light/bh1745.c
> @@ -755,8 +755,8 @@ static irqreturn_t bh1745_trigger_handler(int
> interrupt, void *p)
> =C2=A0		scan.chans[j++] =3D value;
> =C2=A0	}
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> -					=C2=A0=C2=A0
> iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> =C2=A0
> =C2=A0err:
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/light/hid-sensor-als.c
> b/drivers/iio/light/hid-sensor-als.c
> index 830e5ae7f34a..384572844162 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -262,8 +262,9 @@ static int als_proc_event(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0		if (!als_state->timestamp)
> =C2=A0			als_state->timestamp =3D
> iio_get_time_ns(indio_dev);
> =C2=A0
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> &als_state->scan,
> -						=C2=A0=C2=A0 als_state-
> >timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev, &als_state-
> >scan,
> +					=C2=A0=C2=A0=C2=A0 sizeof(als_state->scan),
> +					=C2=A0=C2=A0=C2=A0 als_state->timestamp);
> =C2=A0		als_state->timestamp =3D 0;
> =C2=A0	}
> =C2=A0
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index debf57a52d1c..022e0693983b 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1315,8 +1315,8 @@ static irqreturn_t ltr501_trigger_handler(int
> irq, void *p)
> =C2=A0		scan.channels[j++] =3D psdata & LTR501_PS_DATA_MASK;
> =C2=A0	}
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> -					=C2=A0=C2=A0
> iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> =C2=A0
> =C2=A0done:
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/light/opt4060.c
> b/drivers/iio/light/opt4060.c
> index 566f1bb8fe2a..3c8d34b97dc8 100644
> --- a/drivers/iio/light/opt4060.c
> +++ b/drivers/iio/light/opt4060.c
> @@ -1104,7 +1104,7 @@ static irqreturn_t opt4060_trigger_handler(int
> irq, void *p)
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(idev, &raw, pf-
> >timestamp);
> +	iio_push_to_buffers_with_ts(idev, &raw, sizeof(raw), pf-
> >timestamp);
> =C2=A0err_read:
> =C2=A0	iio_trigger_notify_done(idev->trig);
> =C2=A0	return IRQ_HANDLED;
> diff --git a/drivers/iio/light/rohm-bu27034.c
> b/drivers/iio/light/rohm-bu27034.c
> index 7cec5e943373..28d111ac8c0a 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -1193,7 +1193,8 @@ static int bu27034_buffer_thread(void *arg)
> =C2=A0			 */
> =C2=A0			data->scan.mlux =3D (u32)mlux;
> =C2=A0		}
> -		iio_push_to_buffers_with_timestamp(idev, &data-
> >scan, tstamp);
> +		iio_push_to_buffers_with_ts(idev, &data->scan,
> +					=C2=A0=C2=A0=C2=A0 sizeof(data->scan),
> tstamp);
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> diff --git a/drivers/iio/light/rpr0521.c
> b/drivers/iio/light/rpr0521.c
> index c50183f07240..fbd116272921 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -457,8 +457,8 @@ static irqreturn_t
> rpr0521_trigger_consumer_handler(int irq, void *p)
> =C2=A0		data->scan.channels,
> =C2=A0		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int
> clear reg. */
> =C2=A0	if (!err)
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> -						=C2=A0=C2=A0 &data->scan, pf-
> >timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
> +					=C2=A0=C2=A0=C2=A0 sizeof(data->scan), pf-
> >timestamp);
> =C2=A0	else
> =C2=A0		dev_err(&data->client->dev,
> =C2=A0			"Trigger consumer can't read from
> sensor.\n");
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 4aa02afd853e..f8eb251eca8d 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -494,8 +494,9 @@ static irqreturn_t si1145_trigger_handler(int
> irq, void *private)
> =C2=A0			goto done;
> =C2=A0	}
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -		iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
> +				=C2=A0=C2=A0=C2=A0 sizeof(data->buffer),
> +				=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> =C2=A0
> =C2=A0done:
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/light/vcnl4000.c
> b/drivers/iio/light/vcnl4000.c
> index eccf690eae8c..cc81a30b7c70 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1698,8 +1698,8 @@ static irqreturn_t vcnl4010_trigger_handler(int
> irq, void *p)
> =C2=A0	if (!data_read)
> =C2=A0		goto end;
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> -					=C2=A0=C2=A0
> iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> =C2=A0
> =C2=A0end:
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/light/veml6030.c
> b/drivers/iio/light/veml6030.c
> index 0945f146bedb..6bcacae3863c 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -903,7 +903,7 @@ static irqreturn_t veml6030_trigger_handler(int
> irq, void *p)
> =C2=A0		scan.chans[i++] =3D reg;
> =C2=A0	}
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(iio, &scan, pf-
> >timestamp);
> +	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), pf-
> >timestamp);
> =C2=A0
> =C2=A0done:
> =C2=A0	iio_trigger_notify_done(iio->trig);


