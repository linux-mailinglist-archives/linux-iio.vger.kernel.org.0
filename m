Return-Path: <linux-iio+bounces-16351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACF1A4E19A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E90B17FB01
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0723B27702C;
	Tue,  4 Mar 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqXkAB6s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181625F995;
	Tue,  4 Mar 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099171; cv=none; b=eM6viki32ZtMyaR4Dik2iM4LSZQE2i4j4u9y+PG8vkWkM5YpSvK9Tz3fkQrnqUJcMVeSgoCA3AnOeNdboCZsL2St3FfZVnethClhHnDn5XHLm8QEu3ZlxditqnFTRGDNnrggNM0X1WPpSX9f7Yd6DrjvQwcxBK6QeC9WG5MbKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099171; c=relaxed/simple;
	bh=jnOdfuXRrGxj9sTQZc1Iuu4zBup/Ee2nCQGAIKhACUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/aJL2zn/4O6eYTXOBILJ/zulHoJ+80YgbVsInxEcYkmeKMG4i1CLN9awfsI+nHhJizwNOqFbfZQjbmmv8HEyf3jB8XzQicWRO87xItMgOGf3XED0bU5YQE3LZDEwYajr90BixAqw+42UI9iUIGr6NDaEkauLGXv76oDuVuTA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqXkAB6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA02CC4CEE5;
	Tue,  4 Mar 2025 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099171;
	bh=jnOdfuXRrGxj9sTQZc1Iuu4zBup/Ee2nCQGAIKhACUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqXkAB6sEb4EV+vf4Er52IUXMbw615GLEf3AhgXy4lBggSUFamqIOcZnmJJ2eWPzG
	 lYyM22liWT1LV3qGgW3TnxLH2RBsibw1iUultdO5SbJmWDZ5v7TJn+15Qcrfjt28jc
	 DVBz0AZI+w5iFYvY/32Um53KqrDqVOjBI9MZ/rVwcwvQQYu88343PgIvx+RVOcs3Ma
	 3Uy6m2CIapeOGJg9NvHIzGqmqH8L1NCkobz6xjD/utBzhk2m++sl81tJAfh5cVIPFo
	 8KvGdDzXCZdW9k0ngoul3cvwqkLCFQAP1ClO5Vf1MXEhGSRFc889PUrEA5img4ESbm
	 +nQ95ATNH6OCw==
Date: Tue, 4 Mar 2025 14:39:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 21cnbao@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: accel: add binding documentation
 for ADIS16203
Message-ID: <20250304143918.733d6cca@jic23-huawei>
In-Reply-To: <20250303235930.68731-1-danascape@gmail.com>
References: <20250303235930.68731-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 05:29:30 +0530
Saalim Quadri <danascape@gmail.com> wrote:

> This patch add device tree binding documentation for ADIS16203.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
> Changes:
> V1 - V2: change compatible property from enum to const
> 
>  .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> new file mode 100644
> index 000000000000..64370f13e1dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer
> +
> +maintainers:
> +  - Barry Song <21cnbao@gmail.com>
I think you'll be dropping this patch anyway, but just a quick not that
it isn't good to volunteer people.  Barry hasn't worked on these
devices for quite a long time now so seems unlikely he agreed to this.

Jonathan

