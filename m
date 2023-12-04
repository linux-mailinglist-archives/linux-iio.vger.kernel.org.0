Return-Path: <linux-iio+bounces-607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC2803B2C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ED71C20A82
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3F2E63B;
	Mon,  4 Dec 2023 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6STAcuB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014442557A
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11421C433C7;
	Mon,  4 Dec 2023 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701709859;
	bh=25cUyV1hdVjzZ9YVPCMY71+Hk0YOnKKkdrsQWbx/eLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6STAcuBd0CPQoGoZU1dWPrzDOlJRM62hyxq+WY64HsYmJRZu3GFwXrpDvgqqm/Uw
	 13e4+XidnNytlZg4ntib3cnaQGk9tYy8P7LHpYvMD/YQYJ/RIB3NSERcsjpt2cOvUt
	 M0Tz/MOrQnybPX7xT/fVgtbnkXadrlYxwEJyVuQ6yJ6rsQgEoTyMug1B39kyI7a2jn
	 OjBgj89jWHeZIQPK3TeVysnYsw/RfiFq0EiV5tFvcnhO/riwvG0YYt2IXDbwlt5hIU
	 2Fg8F7p46BQ3sr0OpkjbNKetDWPAIvamnRYMq5VIEH5E7xQbET7FsB6fNXNuqeP1l3
	 diq2/KffTBQfw==
Date: Mon, 4 Dec 2023 17:10:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] iio: light: pa1203001: Drop ACPI_PTR() protection.
Message-ID: <20231204171052.40def421@jic23-huawei>
In-Reply-To: <20231116192711.366441-1-jic23@kernel.org>
References: <20231116192711.366441-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 19:27:11 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The extra cost of always including the acpi_device_id table is trivial
> vs the complexity of adding guards or __maybe_unused markings so
> just stop using the ACPI_PTR() macro.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311160851.FDA4CDVE-lkp@intel.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Meh.  Guess not that exciting to review :)

Applied anyway, so hopefully I haven't shot myself in the foot.

Jonathan

> ---
>  drivers/iio/light/pa12203001.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index ed241598aefb..636432c45651 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -472,7 +472,7 @@ static struct i2c_driver pa12203001_driver = {
>  	.driver = {
>  		.name = PA12203001_DRIVER_NAME,
>  		.pm = &pa12203001_pm_ops,
> -		.acpi_match_table = ACPI_PTR(pa12203001_acpi_match),
> +		.acpi_match_table = pa12203001_acpi_match,
>  	},
>  	.probe = pa12203001_probe,
>  	.remove = pa12203001_remove,


