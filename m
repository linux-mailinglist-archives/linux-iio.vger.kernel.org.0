Return-Path: <linux-iio+bounces-13457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6751D9F1F19
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 14:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691A316743E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D34D192D75;
	Sat, 14 Dec 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDwQsEIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4037191F60;
	Sat, 14 Dec 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183916; cv=none; b=RaDCG5yiJuA+qyOVPMk2CFz8H4ObL97Z5KWEW1V+2IuntI/KxnoLLr9VqdHwGv9xkfIJ4gH9yXmzDi3k/6dGvTxlKyuZcMX4sHjlz0C4lrj58t6TnBT9EixyB6H4SuRR2OV03kjvLZqdlP1nB09hYZUkCidwrMjiuaMZLYA+SWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183916; c=relaxed/simple;
	bh=ZZBbjto7mRCBvgFnDMB6MlCtSuo0xfsRbwidqoAFM8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjdZ0vEP/747x1SVtMtc+kDMwhn5XPmMTJWDdHu9g1cWaJv/MhCtaXPvWAkuj2C/4GSM3J4DWll2LrLRlyL4+j9ffyyz9F0l25wCC4u3ye47NgNoQi7DK/T7SDWUj+6gWUi1hnYFhEFk/L+gOMrOHxRsZb03oXCQS/IH7z8zt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDwQsEIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903D9C4CED1;
	Sat, 14 Dec 2024 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734183915;
	bh=ZZBbjto7mRCBvgFnDMB6MlCtSuo0xfsRbwidqoAFM8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EDwQsEIZEgJOBZZYtrEp4NsQT4XiffATR80E1yquZ4eu5qcSd4ONAOmylydGW7xyn
	 Br8TROI9Ohk09POTQwQPbut3vp7tDuHeA24tKVODcWQGO0WzJGfJRoulHGAwL7I6ph
	 KYI9lWUmaLgNrmM9IaWSm7tewpPJS6kJoxTWEvE948VsiorV+ZKHU73+M3AzV628Ed
	 ywImbZ0sJ7Wo8hSTZp78T+JGv4ILPVFzPj0IpC0eka3x/4nUVob9CPKqHvPOEke3Jo
	 RR1qJV+s5nFAgEyDzYvg/yGgMTqdiw6pFxjO2oDpIx5BMegoEEaIs8wUIQ0RL55duy
	 oz/Zy6Rm3Z0YQ==
Date: Sat, 14 Dec 2024 13:45:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Darius Berghe <darius.berghe@analog.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] dt-bindings: iio: adxl367: add support for
 adxl366
Message-ID: <20241214134506.3c09d9a2@jic23-huawei>
In-Reply-To: <20241213095201.1218145-3-darius.berghe@analog.com>
References: <20241213095201.1218145-1-darius.berghe@analog.com>
	<20241213095201.1218145-3-darius.berghe@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 11:52:01 +0200
Darius Berghe <darius.berghe@analog.com> wrote:

> Add support for adxl366 Micropower, 3-Axis, +-/2g, +/-4g, +/-8g
> Digital Output MEMS Accelerometer into the existing adxl367 iio
> subsystem driver.
> 
> adxl366 supports all the features of adxl367 but has a few
> additional features for which support is added in this patch:
>  - built-in step counting (pedometer)
>  - non-linearity compensation for Z axis

That description makes it sound like you could use a fallback
compatible.  Would it 'work' with those features missing using
the adxl367 compatible?

> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> index f10d98d34cb8..272be616e979 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> @@ -27,6 +27,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,adxl366
>        - adi,adxl367
>  
>    reg:


