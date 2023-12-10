Return-Path: <linux-iio+bounces-796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A61080BAB1
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D80280E24
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72086BE7E;
	Sun, 10 Dec 2023 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk7Bf/F0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B763A;
	Sun, 10 Dec 2023 12:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87151C433C8;
	Sun, 10 Dec 2023 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702211719;
	bh=wsAE6AWIA0igK94XxcyNxUQ4idq7YVmNjP8oXu4ldBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dk7Bf/F0FPjamUqsmdINGYv1jpTQMb3J84BGqP9GbFw8/GoIVbY2jmsZWUvrNekV+
	 my00CTlHyxvF/26Ddqti/ysomiYGNsvVxzC9Epi7ZKxnJyoBnY5h+eYX/n6dHtVxdJ
	 IiW9Ae8ZK3oCDZAGLOJ+SCkYoRmDyRi6BzdcIc+6PmwacoxL+0cjafOPmsY0Hkdoxh
	 Y7vuLshAV7WIPd8KFSt8AaWg+htknRFg2HLl7HFg0BtGvy0odnmj4MAvinvqvmUb7W
	 FBKHUq+wiY96wwD9Yg7KvahPlC6ECt85bU1Vflgw8eH65C4pPapIYsVtdwczKHpKEA
	 +rF0aX6NWxk5Q==
Date: Sun, 10 Dec 2023 12:35:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/13] iio: adc: ad7091r: Set device mode through
 chip_info callback
Message-ID: <20231210123511.63ddd8b2@jic23-huawei>
In-Reply-To: <84826948132ccd66b9a64617bc4eb2cbc9a3f90f.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
	<84826948132ccd66b9a64617bc4eb2cbc9a3f90f.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 15:41:03 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD7091R-5 devices have a few modes of operation (sample, command,
> autocycle) which are set by writing to configuration register fields.
> Follow up patches will add support for AD7091R-2/-4/-8 which don't have
> those operation modes nor the register fields for setting them.
> Make ad7091r_set_mode() a callback function of AD7091R chip_info struct
> so the base driver can appropriately handle each design without having
> to check which actual chip is connected.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Hi Marcelo,
> +
>  #define AD7091R_CHANNEL(idx, bits, ev, num_ev) {			\
>  	.type = IIO_VOLTAGE,						\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> @@ -52,6 +60,7 @@ struct ad7091r_chip_info {
>  	unsigned int num_channels;
>  	const struct iio_chan_spec *channels;
>  	unsigned int vref_mV;
> +	int (*ad7091r_set_mode)(struct ad7091r_state *st, enum ad7091r_mode mode);
Given it's embedded in a driver specific structure, I'm not seeing a clear
reason to prefix the callback with ad7091r.  set_mode is probably enough.
Same for the ones introduced in later patches.


