Return-Path: <linux-iio+bounces-4126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6164389AC14
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 18:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97B7B217AD
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CF3EA86;
	Sat,  6 Apr 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLWa8vAP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0F1A716;
	Sat,  6 Apr 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421693; cv=none; b=ikDTmISuJdv+hLwjyBycA3jTQV/siiJUiWv5IbXcmT7eDxe3jW1sSaz1++Zpp2urQ2hzRUmFt8e48Ms5chZNUku7FIsfmDntg26C5WWK8EFJszeubvQ7tU9BXzYQpazExlB/kF3fe9N8yP6WAJ+SXqFi3QQWiSBXZzK735uB65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421693; c=relaxed/simple;
	bh=LKhD7FPeYzKmTi+QHKkEtY3ZKATs5j1nWOxqiydw9fE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBQZa94RbRDYN7HEl93wXKtbtEJAV2Hn7/qJ8WUYOivG1rAp67V9giJ02wgVsy1G4fO0Q1p4OFoft77EsuHpCJlIKzyBI6zvqyN4HbfzpXfMaUJGpiJnPUWYvF5ABcjNe9Ji8W+PfSaxY6QvSEICanDqYj388A3MbgIGgqUzsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLWa8vAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF43C433F1;
	Sat,  6 Apr 2024 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712421693;
	bh=LKhD7FPeYzKmTi+QHKkEtY3ZKATs5j1nWOxqiydw9fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLWa8vAPeJnQwNIRSEX1vZttGZir7N0D/f/42/aDkpKda6VY1rtpyKShNMI/5LTDS
	 wBqH9CANEzME216TjbHAyJxJfvX214pid4xUrss0J+k/avhQ1WtUfrq+bbjv359UlQ
	 lNQX4oTo/7H+gLs0aEq947limrTh0p4fGT4aKz1X1ZfTg48tJBRKWXtfKQMHUcuZbn
	 h0ViigCrKrln5oUGRA/ngc1gCKPH4dH7huzHKaFsXGp6W7cDk9Y0XLLk1m22VQ8NMV
	 m8QxRBoeopVQIpcB4NCHWSW2Avai/YR+OpN0mhNdu4jErV86axBgUk3yPza3JmHBio
	 l4Nsimyg0FbNQ==
Date: Sat, 6 Apr 2024 17:41:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 11/11] iio: dac: support the ad9739a RF DAC
Message-ID: <20240406174119.38b821ff@jic23-huawei>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-11-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	<20240405-iio-backend-axi-dac-v2-11-293bab7d5552@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 17:00:09 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are capable
> of synthesizing wideband signals from DC up to 3 GHz.
> 
> A dual-port, source synchronous, LVDS interface simplifies the digital
> interface with existing FGPA/ASIC technology. On-chip controllers are used
> to manage external and internal clock domain variations over temperature to
> ensure reliable data transfer from the host to the DAC core.
> 
> Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

The only thing I really have remaining questions on is the choice
of chan_spec with altvoltage and voltage channels.  Why does that
split make sense?  It's odd enough that some comments in the code would
be a good thing to add.

Jonathan

> new file mode 100644
> index 000000000000..9b91d66f826c
> --- /dev/null
> +++ b/drivers/iio/dac/ad9739a.c
> @@ -0,0 +1,454 @@

> +
> +static struct iio_chan_spec ad9739a_channels[] = {
> +	{
> +		.type = IIO_ALTVOLTAGE,

So this looks a little unusual. Perhaps some comments on why it
is appropriate to have this channel.

In reality there is only one channel I think?

> +		.indexed = 1,
> +		.output = 1,
> +		.scan_index = -1,
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.output = 1,
> +		.ext_info = ad9739a_ext_info,
> +		.scan_type = {
> +			.sign = 's',
> +			.storagebits = 16,
> +			.realbits = 16,
> +		},
> +	}
> +};


