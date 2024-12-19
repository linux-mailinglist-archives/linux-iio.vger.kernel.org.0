Return-Path: <linux-iio+bounces-13670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A09F81B3
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E901893914
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3D1A2C06;
	Thu, 19 Dec 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQXB4oYv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEF19C56D;
	Thu, 19 Dec 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628740; cv=none; b=KLDgFAbb0iaCrYn8+VZhpf92yI5AsBhslJps9JrMhBHcNm8rYg7raz8iuLgn/sFnN/8ZzWVmHAYtPWbGxhIccHJpl3udkzBzcGBkOaSZU9+e5qtCKBTu+w8ocgVtPmfiwZgOAnCdw8FGs8ScSFPUJUnJeaRDUvDNitxBMkqrD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628740; c=relaxed/simple;
	bh=EpxJFfnZzgsAhKOsgbC5z2lZk3Ha4f5t6SsaVfVU32U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8EUyCTnL4a1mHaUXc8WqxZp8Tzg4P5Hdtr0Xt30mMhTTH+c67jhEAMDHiNa3Q3Alz5Jbqjar45eU2gsOXd0dQ4Clm/0ZOSU0dLW74qz5X/fY28IGoFQKVKeUbU+mTH8QEgjfAGMgfZKqyl9Xxabfr7vM3G9/F+J91OyGlnQlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQXB4oYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47D8C4CECE;
	Thu, 19 Dec 2024 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734628740;
	bh=EpxJFfnZzgsAhKOsgbC5z2lZk3Ha4f5t6SsaVfVU32U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oQXB4oYv71Jfp7rRRoiyTMvTi0GwPnxayz1S41xq76J0MYSX1fHCv+ccqksJt+CC3
	 ikAJpEQXTr8qjwGFuU66WMQZCnFwTtGt9HHVVVg16wCLy/i9nggun3NU317F8ekqzp
	 /haTQ/bwxiku3yk9Nd+gUlGnMBFgV8UwCNf7zlIBN72h2b2V2wm+7IkdJDCPhxoGq1
	 YwNE0TSXJMsFf+opMhXBEHEqOvmgsFKVCqeNoCJPNphiSMyPBoo3y9EjbX18F4KNHV
	 M6SarpKUWehSxObtgz5Amd/uMAifQIETkecxXnVqVc50qf/LmNStgPNO5p/OJzlfAq
	 3XnMzoyYIcjTQ==
Date: Thu, 19 Dec 2024 17:18:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shen Jianping
 <Jianping.Shen@de.bosch.com>, Alex Lanzano <lanzano.alex@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <robi_budai@yahoo.com>
Subject: Re: [PATCH v3 1/7] iio: imu: adis: Remove documented not used
 elements
Message-ID: <20241219171847.56cec7b9@jic23-huawei>
In-Reply-To: <20241216144818.25344-2-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
	<20241216144818.25344-2-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 16:48:07 +0200
Robert Budai <robert.budai@analog.com> wrote:

> This patch removes elements from adis.h that are documented
> but not used anymore.
> 
> Signed-off-by: Robert Budai <robert.budai@analog.com>
I already picked this one up.  Don't included in any future versions
as it will just confuse me :)

Thanks,

Jonathan
> ---
>  include/linux/iio/imu/adis.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index e6a75356567a..4bb98d9731de 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -99,7 +99,6 @@ struct adis_data {
>   * @spi: Reference to SPI device which owns this ADIS IIO device
>   * @trig: IIO trigger object data
>   * @data: ADIS chip variant specific data
> - * @burst: ADIS burst transfer information
>   * @burst_extra_len: Burst extra length. Should only be used by devices that can
>   *		     dynamically change their burst mode length.
>   * @state_lock: Lock used by the device to protect state


