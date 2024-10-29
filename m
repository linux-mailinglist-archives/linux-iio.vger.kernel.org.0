Return-Path: <linux-iio+bounces-11542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4609B432C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0950DB21EF7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46D20264A;
	Tue, 29 Oct 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzwHFkFy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531A78C6D;
	Tue, 29 Oct 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187213; cv=none; b=urpvzZ5XEYxfQnwElRLywik6x/pluny5tuZ6vfNsMG81LJU+CWWGxWt/8W3V+PGJNQwjOHN/DdnHNLYrVFCZlvEXzR7En9SL3HXw///sJ9HfA5QBJb/E9AF+9jZNvJIQJwd24s6mi4QFJfWpct3ratYowEoYyskuaXIaHsWv7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187213; c=relaxed/simple;
	bh=t1U+Flur8ky8mDQZz6HKT7GtRSKzTi9DwVdFhIiIMMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7emZsV5HZiGNB8eTiRX8yvhY6BiAVkW56a9MOS2Q7P3XbOqKAjZ3od3Cp4MEi82jKljqw1+SzraAQeuDGt8T8vDL0mDhWcs9DtSuW3Gruzr7EuskbvRBR2gDErJvk9uRbohwsSRTOn1d8Wsvy8/RPHtVDEbBQCpy9g3k11ciyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzwHFkFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0990CC4CECD;
	Tue, 29 Oct 2024 07:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730187212;
	bh=t1U+Flur8ky8mDQZz6HKT7GtRSKzTi9DwVdFhIiIMMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzwHFkFyicNZQKGQWTFuyrJN09Cnjg0AkBhRj+i1ZoS1FfvyW+WTUqYJ0ofj2fVso
	 FcpB+WGqEKMpHu2Ph/Xqi3+fBsTyv6vUjZOOO+ImHdTtMr7RwOiQXHf0p9JzpO3WZP
	 97lWtrMc8xZqpPbGujfJkQpFkKc+3pJm0EZnU+iB5ZB5ms7fQIREWEuCEN9K8CSg1f
	 xnAwLnwtkHD+FmQEXFF34ZkGDA9UpbOPC7uUyf4aTgizCu6DN+tgkmD3pHhy5z0CTj
	 WRUS3WGr8iXcatgHdBDYd/EUdlqz+Aj8ffVAfzfGy8ZEcE6lwlcx+1DfqBWlZs1EZD
	 /xD+4/4sVs6Vw==
Date: Tue, 29 Oct 2024 08:33:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: veml6075: document
 rset-ohms
Message-ID: <kguuixqw73fjzfdnmwapfm4tpq25c33mmdkifbx4h6taoqmzx4@yp3soq2n5d3n>
References: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
 <20241028-veml6070-integration-time-v3-1-dd7ace62f480@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028-veml6070-integration-time-v3-1-dd7ace62f480@gmail.com>

On Mon, Oct 28, 2024 at 06:14:01PM +0100, Javier Carrasco wrote:
> The veml6070 provides a configurable integration time by means of an
> external resistor (Rset in the datasheet) with values between 75 and
> 1200 kohms.
> 
> Document rset-ohms to select the integration time.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,veml6075.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> index 96c1317541fa..5381a90f7f7e 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> @@ -22,6 +22,13 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  rset-ohms:

I missed last time this, sorry:
This looks specific to this device, so missing vendor prefix. Otherwise
you should use an existing property or make it a generic, IIO property
in common schema.

Best regards,
Krzysztof


