Return-Path: <linux-iio+bounces-26906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 474C9CAB7EB
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97004301DB8B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D52D0618;
	Sun,  7 Dec 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQzF94fl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE116DC28;
	Sun,  7 Dec 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765126448; cv=none; b=PgZtvnSandPjZCn336cmLD1NR93V400mIQwYZ5lWEN5WqnCNRx0AzXiAg4SwI1l/56dokywsuL4tfK5B77EV7CmN9abGazsj3b7hN9iSElYBdBOCq8ADBhxMd8x5s6l+lPWpq3Bg6s31ZI+57hdFntMFFJYFOls7b5RW53mG5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765126448; c=relaxed/simple;
	bh=C5sZX87PayaYSX4KfMWn5QhVbDjq7mIXp6DtwTMeVlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqrEYM4Tzx07l2QFyKC9J7qhnvcZC1uP/s2Ekh/YP5YJd0QSPnBZLCPMH4rqzEQfkf64nkRf5QpDV5B0IYkFqOq0htkpnRS1koFiXI6KqKAuQ4A83q3sxHDJlQ3PAuIwFADD9hTpauunKn/aLGMPwFPMv/1hlnj9DpwvskWdQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQzF94fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A1EC4CEFB;
	Sun,  7 Dec 2025 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765126445;
	bh=C5sZX87PayaYSX4KfMWn5QhVbDjq7mIXp6DtwTMeVlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQzF94flU5YhTWDez2epfvKC5EqjVvI+7is443ff5YfWy2/yt9djUUsn6PgYcOvsC
	 HU8339fb5BHU7u9WDDaDROzxM+w5fu15J0e7xN1JamuDggwX4dcgDYB+ZoIl6FC+Q8
	 d25Ckwd9ov3r8z9+1/5IQLV+Qp7xRL3Kj/ZzCfo4kg+aDf5P2IOb7hNIaLzuHbenDj
	 QaSfBxpKKa7InHW3e5J/E2ngtAtQzGp8dBQNOQ4LGWDrlAuE2DdS74Gzdcyap4dits
	 yuKzlA32Zgps8id9w1zY7HZntERbC72KU1phfiTiXOE/J/xFT9dzKHCGJmsPv6gx1W
	 ZTBcBMWCwQAOQ==
Date: Sun, 7 Dec 2025 16:53:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
Subject: Re: [PATCH V8 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20251207165349.72f80659@jic23-huawei>
In-Reply-To: <20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
	<20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 19:10:35 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> By convention, we reserve the first channel of the first SDAM for all
> immediate reads and use the remaining channels across all SDAMs for
> ADC_TM monitoring functionality.
> 
> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> driver.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi Jishnu

Biggest thing I noticed on a fresh review is that you include
very few headers.  This only compiles (I think) because of lots
of deeply nested includes.  General principle in kernel code is
to follow IWYU approach with a few exceptions.  That makes code
much less prone to changes deep in the header hierarchy.

You can even use the tooling that exists for clang to give you suggestions
though search around for config files (I posted one a long time back)
that reduce the noise somewhat.

Jonathan


> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
> new file mode 100644
> index 000000000000..46bb09424f22
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
> + * of type ADC5 Gen3.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/regmap.h>
This seems like very light set of includes.
If nothing else should be seeing linux/types.h I think

In general try to follow include what you use principles (loosely as some
conventions exit for not including particular headers). 

Sorry I didn't notice this in earlier reviews!


> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..effd4bd49989
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c

> +/**
> + * struct adc5_chip - ADC private structure.
> + * @dev: SPMI ADC5 Gen3 device.
> + * @dev_data: Top-level ADC device data.
> + * @nchannels: number of ADC channels.
> + * @chan_props: array of ADC channel properties.
> + * @iio_chans: array of IIO channels specification.
> + * @complete: ADC result notification after interrupt is received.
> + * @lock: ADC lock for access to the peripheral, to prevent concurrent
> + * requests from multiple clients.
> + * @data: software configuration data.
> + * @n_tm_channels: number of ADC channels used for TM measurements.
> + * @tm_aux: pointer to auxiliary TM device.
> + */
> +struct adc5_chip {
> +	struct device *dev;
> +	struct adc5_device_data dev_data;
> +	unsigned int nchannels;
> +	struct adc5_channel_prop *chan_props;
> +	struct iio_chan_spec *iio_chans;
> +	struct completion complete;
> +	/*
> +	 * lock for access to the peripheral, to prevent concurrent requests
> +	 * from multiple clients.
> +	 */

Whilst checkpatch is dumb on this and complains if you don't have a comment
here feel free to drop it as the one in the kernel-doc is enough.

> +	struct mutex lock;
> +	const struct adc5_data *data;
> +	unsigned int n_tm_channels;
> +	struct auxiliary_device *tm_aux;
> +};


>

