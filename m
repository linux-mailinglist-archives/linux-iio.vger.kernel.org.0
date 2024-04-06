Return-Path: <linux-iio+bounces-4125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC489AC08
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17957B21706
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7D2940F;
	Sat,  6 Apr 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf0W4VVi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B2107B3;
	Sat,  6 Apr 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421184; cv=none; b=HBsCE+/n5BDfYXIhzgGwBifuMs59Sa/pHuMLaTQ/Bs9DlRMhlmKbHzloCq8rSA9DBDG/tKvKemXYIjOFCde7pGRuA8/rj1K7AOhhCEvOLP3mKVFoCcgY53zmGkU5T454+E69ktH+PeKvnom25jPcZtob54JAD9w5I9rO8gAvNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421184; c=relaxed/simple;
	bh=eRI9GKR3nAtniVh0eAlHR1mBDEIsVwRx3T0+rfsCumE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7+HR6Opo15r/8JZY3U179pHTUEevP6M9BkMMHrlYLRRpCHBc3H3l2tDMWknTfUnPiYmQWdk5amrgjWk6rEuigNIsGy35XU65BtSQIu6EgSUk84DpqzHpGxYqXDtPrvQRUZUtzy4H5z1bKKIIZMLO7xM79wMnVTXHcQ4/AzTzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf0W4VVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF15BC433F1;
	Sat,  6 Apr 2024 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712421183;
	bh=eRI9GKR3nAtniVh0eAlHR1mBDEIsVwRx3T0+rfsCumE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rf0W4VViPmDSht+6vFuH/sbu7YIz+smsw1jTzg1UjIe+JfZxrC2UcSQlU8zp18m5f
	 nFl7GEaZCtk0iEhib0PviDSHuoZVA4vN6LsJhOBPMbMVdulO9Qex0pduA7RsRB+wS3
	 7cHdIodpaxUm7waqkqZulR07NehL98xrioxfnP26T2El4acwrRvcRzV89HSKRJ71Em
	 jyHAfdZLR6Z4rwYI1VLSAKr/bUlHgQUCip04ZOdGRvbKvcXu2BjIMzFQ8fi7tq+sUT
	 ubgy9BE31lXh9fBVke5S4ZxPopIfY8nXPSwJaq5LHa0ksZujAwGhgDmPyiFMhmzd56
	 YwQslshhC/0Ew==
Date: Sat, 6 Apr 2024 17:32:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 09/11] iio: backend: add new functionality
Message-ID: <20240406173248.2a574251@jic23-huawei>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-9-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	<20240405-iio-backend-axi-dac-v2-9-293bab7d5552@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 17:00:07 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> This adds the needed backend ops for supporting a backend inerfacing
> with an high speed dac. The new ops are:
> 
> * data_source_set();
> * set_sampling_freq();
> * extend_chan_spec();
> * ext_info_set();
> * ext_info_get().
> 
> Also to note the new helpers that are meant to be used by the backends
> when extending an IIO channel (adding extended info):
> 
> * iio_backend_ext_info_set();
> * iio_backend_ext_info_get().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Whilst the code for the backend retrieval callback is simple
I wonder if we are better off just not having it for now.

Keep the infrastructure that checks for the default approach not working
but don't actually provide the alternative until we need it.

Advantage is pretty minor though so maybe just keep it.
Unless others have strong opinions, up to you to decide whether to keep it.

One trivial thing noticed inline.

> ---
>  drivers/iio/industrialio-backend.c | 179 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  49 ++++++++++
>  2 files changed, 228 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 2fea2bbbe47f..ac554798897f 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -29,6 +29,7 @@
>   *
>   * Copyright (C) 2023-2024 Analog Devices Inc.
>   */
> +#include "asm-generic/errno-base.h"

You'll need a strong reason if you want to do that include rather than
a normal one like linux/errno.h

>  #define dev_fmt(fmt) "iio-backend: " fmt
>  
>  #include <linux/cleanup.h>
> @@ -43,10 +44,12 @@
>  #include <linux/types.h>
>  
>  #include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
>  

