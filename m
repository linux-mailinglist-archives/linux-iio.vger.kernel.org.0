Return-Path: <linux-iio+bounces-10209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B14991932
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53D0282EE5
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4655E158208;
	Sat,  5 Oct 2024 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpC/wNG2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C7A31;
	Sat,  5 Oct 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151598; cv=none; b=PvHrmHGZmp6wuno6qSXr06I/Yg6EUOYgDmvJPgeS53Qg9p3H6MXIYlwPB4yw688/5+cDxMkxXH+tqf8Fha4+NVtfZaqiTXviCvIzHfMnwi9sjvTL7IhtHg4M+6HcdYEupsW0K5Z7jPdEamgmWzK2Wse3VlpOwhPKlNvjLcdHWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151598; c=relaxed/simple;
	bh=6x6Pwu8q6e4S/hIMCuynP0QiDuN8x+ThpPL/EAlwWwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0f1h1BSg8WV0ICEmWvIz3FDLJtaRo3Gl48VofpCB888dYpxItTDnHzlUVy6rcVfhS391e4h/mvcLPAh36VAWgQOn22F9NZe/pYMQgEVQywFZ5h8Y9tWMXKEyfaaRqkkZzggjBftc8LjiTNnG5hWDJdjK2AwUp9txXuMflZG4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpC/wNG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB8CC4CED2;
	Sat,  5 Oct 2024 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151597;
	bh=6x6Pwu8q6e4S/hIMCuynP0QiDuN8x+ThpPL/EAlwWwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpC/wNG2RNc/Q0hzdDWTdKYQfCvy+0amdeNOMdK1dezAZ35cKMBmetj2SBMSlu7tT
	 aUmsFm1zhSJdZ9MuSFxFNe8QEraXQfGNnQLdFrrtXxEOGBZ1cM5VV/FLJZmuyhvw5s
	 RhvepMeTok80KRXKuNcb2BoTguCIoiGLYVRYJQmnfkYnUBIzHLIb4piQ/wXDnxkMOH
	 nbi4g7vmW2hkBn//8Mqb5H+BUq2cH+XFgDlmqczayNmPKbg3OGWi22UaQcB4pw1sLx
	 lJ+HwL4pLY/CIv5YKJHISlQivAGqqDTrXB2yTGb1bYI+UDugb9BEV5oisPG9iAHsZf
	 ++3iSJoa2NEWQ==
Date: Sat, 5 Oct 2024 19:06:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: Fix an error handling path in
 _hid_sensor_set_report_latency()
Message-ID: <20241005190620.5f8633a9@jic23-huawei>
In-Reply-To: <c50640665f091a04086e5092cf50f73f2055107a.1727980825.git.christophe.jaillet@wanadoo.fr>
References: <c50640665f091a04086e5092cf50f73f2055107a.1727980825.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 20:41:12 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If hid_sensor_set_report_latency() fails, the error code should be returned
> instead of a value likely to be interpreted as 'success'.
> 
> Fixes: 138bc7969c24 ("iio: hid-sensor-hub: Implement batch mode")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative.
> 
> The code just *looks* wrong to me. No strong opinion, if it is done on
> purpose or not.
Agreed it smells :)  But I'd like more eyes on this before I take the fix
as maybe there is something subtle going on.

J
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index ad8910e6ad59..abb09fefc792 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -32,7 +32,7 @@ static ssize_t _hid_sensor_set_report_latency(struct device *dev,
>  	latency = integer * 1000 + fract / 1000;
>  	ret = hid_sensor_set_report_latency(attrb, latency);
>  	if (ret < 0)
> -		return len;
> +		return ret;
>  
>  	attrb->latency_ms = hid_sensor_get_report_latency(attrb);
>  


