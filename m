Return-Path: <linux-iio+bounces-11783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7DD9B9412
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D49A2825CF
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7411AC8A2;
	Fri,  1 Nov 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctFgbyOD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF219F43B;
	Fri,  1 Nov 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473969; cv=none; b=P3YFFfjJhAujK71gi/hVFN4WbB1tefFK3/beeFsJd+n6mdc4HowHMSVFxVa0FboXlFmDkRz4h83prVRYwHYpBK0GL+Ap4Oe3ohSMEZd4gO/ds19dlJ9nBn7WP/GIeE8F1AiUMQjOfJ3j/FPaNkwtfk+qI06qdM4QgrmiWDZwwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473969; c=relaxed/simple;
	bh=H2ADy5sNeqxI+b63MV/vhg47XWPphNDQc6A9R+JB6mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8LgpFubeLq8S/ilnKd7/Gf9AkBDTKtgod5jX/w8c92bXAayRRhFJGrT8VpxtB+FZ4TaqhsUIgb2ut4YH1pwzcgSZKAcRjaYsRZNyYxVZUrvm0s8IgpdWHsqyOxdgqIIlyZhZm1QniUsC8dJPdcdMNM5So1B0gQo9ZvUVy4wMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctFgbyOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FF7C4CECD;
	Fri,  1 Nov 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730473969;
	bh=H2ADy5sNeqxI+b63MV/vhg47XWPphNDQc6A9R+JB6mQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ctFgbyODFZoFOSgFgkajyO88B29tEdtiSy+qyIETb7qdI7iIUK4yn2it7yX5zkY8Q
	 gXRHv4729KWHPSHWGVLCKNQU4LK9gcq9fVjPPCE8bjSKraMnF3Bz8PM6rEbzLPAloe
	 hTOxqCjEYgT6baK+00GsuuryxFUC2dEG44qcW4ih4Le219SSpuj1SjV9pLSiQMzArX
	 UxRQ0Iq0JDiRY6PZenRTcL8VJ1smvkyQgHSQzN0CHSyeaks16lXYLiyv3CM6wuTt3J
	 ph2hDFwkQxXUc7OQeR1qGOu0SWhOUQ5C1nIwspX5zen+/yzeJH5IcRwkro+ui2s28n
	 DLfb0AdFFzOEQ==
Date: Fri, 1 Nov 2024 15:12:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Darius Berghe <darius.berghe@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: iio: adis16480: add devices to
 adis16480
Message-ID: <20241101151243.558a8577@jic23-huawei>
In-Reply-To: <20241101130742.3479110-3-darius.berghe@analog.com>
References: <20241101130742.3479110-1-darius.berghe@analog.com>
	<20241101130742.3479110-3-darius.berghe@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 15:07:42 +0200
Darius Berghe <darius.berghe@analog.com> wrote:

> Add the adis16486, adis16487 and adis16489 Six Degrees
> of Freedom Inertial Sensors to the list of compatible devices
> of the adis16480 iio subsystem driver.
Hi Darius

Please give a brief statement of what differs between these and the
many other compatibles in this binding (beyond the ID register)?

(usually scales, features etc)

In particularly you state in the docs patch that one of them
is functionally equivalent to an existing part so there a fallback
compatible is appropriate.

See how the st,lsm6dsx does it.  The reason to do this it allows
the potential for an old kernel driver to work fine with a newer
device tree.

Other than that the series looks good to me.

Given we have a case where data could be shared, longer term
breaking up the chip_info array into individual structures would
allow sharing of the data.

The name handling in here isn't ideal as it relies on matching
in the spi_device_id table which is fragile.  Doing that more
cleanly might break the sharing of structures.  Oh well, not
relevant for this set anyway.

Jonathan




> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> index e3eec38897bf..5bef2878a0df 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> @@ -15,7 +15,10 @@ properties:
>        - adi,adis16375
>        - adi,adis16480
>        - adi,adis16485
> +      - adi,adis16486
> +      - adi,adis16487
>        - adi,adis16488
> +      - adi,adis16489
>        - adi,adis16490
>        - adi,adis16495-1
>        - adi,adis16495-2


