Return-Path: <linux-iio+bounces-4763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948958BA022
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD5B23E4D
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C0173332;
	Thu,  2 May 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGSNnOIF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E821171E71
	for <linux-iio@vger.kernel.org>; Thu,  2 May 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673714; cv=none; b=pl9+aearfWUxJz5KCJOE3YGqhrmEDt52J6WTaKCsHxKz0vngsJHJNmdaGI53mtRH5WnlT1ccWRF8GlWry8GM4ngzI4t5Pn6rHhfersGFuoYRTm85BrOTpq9lAfN3FJhyhH667Npm/n2/7mdQqon5OJ3n5DhK7MVwdBoDHFsm56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673714; c=relaxed/simple;
	bh=covbC+0qj9BjYv0FcB/FNTAhWyr4gTjR+6v7SsnVT+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuLQrdwu8GuShsPLcLGApO8dkskTkp6BJf9Z+tSBx3h8gySekbCij2RRGKUVXoFRw/WTUYCt5+DEuHsY4jUMuNqbksrvhuzuaqw3C0gX6p61sUFNyejPChD3fPa0hGKDMPqcZ+J2EE3s/ogZOtMoMuI63O9lYN3X9dIQePOAntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGSNnOIF; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa3f0fcd46so4944096eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 02 May 2024 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714673712; x=1715278512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApPC9pEmbzXhXjVlcwn1JoO9KQlj+D53VnVrqQphLHw=;
        b=DGSNnOIF8P1LAACvgx/wO4df8e0pzpoq6KgeLVg+corWyC+fI0TZi2gu0b+ZKFn+cp
         jFI3vIUPZoklgZ7qgOpQuOTPwsZ9jO+c0JV1E4joQEiHjVKugAH/LFUcVd54ZQH0yH3a
         vYhkrT9i/GyL2ECD9kXKB1EOol7BruVjNVRcEEBWAvC+t7xNyD8AhDRdiQcscQS4pHi8
         Xq8pQPhi0xeESH1fY8o9KSqEaFkllWENWYnRv2CcpZ+rptf+P/kiwE6h3o/Pssne3z3f
         sViuOBS6bbgq+yNRP7cGfZLEO+7f3hLEvsyhH3VsOfOcYFfqWDZ2FtdolIJcBOR84N61
         k10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673712; x=1715278512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApPC9pEmbzXhXjVlcwn1JoO9KQlj+D53VnVrqQphLHw=;
        b=g07JV3qElf8vOpSScgLCKFUwWHdOoFXAVc/gposVCKkh0bFavqSNdk3T/PwF47dAyq
         ATELIYx9OBMhbyxIqAiqRk9y9bX5jIVHmc+pKbKcVn6C+W0Kiq4LxICJAvjbpJdtpoeg
         ej9g3a9ZEcMJwR0nXtBLIZpBUS5nA7J8s5BfZ8RVj9Fr+djJzrQqnDLcuzfcvGzb0tsK
         g1rRoepZFeFbc2PLHMcRMKORdRt15qMmYI2AN8bXVpSD8XSG7Fwx7G6eHkIXDFptc7TN
         5+hlDqfuAVa+helDrb5j14uKp7rN2Ow1RidQZiRtOO+xrQCDbEc5HXzahrGu2hDns9X9
         L2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVpS4DuJy8yX6GpZJotQKW566TkLgDyCAHAuvSLPq2sfIQkXAATXfVOUveUxXqHL03HlN6gbr0Kbd8rWk99BsBv8yewSFMqv/wS
X-Gm-Message-State: AOJu0YzgnzQXXeZSqOK1v96biJWbfg4og12j8njIMoU7yap7hHI+afuJ
	dwAFMhD0DqJSNhOKtzmNgxOVC/7uESKTv/C2+QD+jp+TFgjfEy2C
X-Google-Smtp-Source: AGHT+IG7zijaOPcdUTY+Ob7vHlBliJg2iVJ9Q/g8+7TpCJBpNJE83M6KUYmQhDCq/b7/lNYFTq6FKQ==
X-Received: by 2002:a4a:d888:0:b0:5ac:bdbf:8a31 with SMTP id b8-20020a4ad888000000b005acbdbf8a31mr548195oov.8.1714673712071;
        Thu, 02 May 2024 11:15:12 -0700 (PDT)
Received: from adam-asahi.team.saronic.dev ([136.41.97.255])
        by smtp.gmail.com with ESMTPSA id gr5-20020a0568204cc500b005a4bb400a0fsm277895oob.4.2024.05.02.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 11:15:11 -0700 (PDT)
Date: Thu, 2 May 2024 13:15:10 -0500
From: Adam Rizkalla <ajarizzo@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: ang.iglesiasg@gmail.com, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org
Subject: Re: Replying to: [PATCH] iio pressure: bmp280: Fix BMP580
 temperature reading
Message-ID: <ZjPYLtGAFtI5iN8E@adam-asahi.team.saronic.dev>
References: <043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com>
 <20240502171616.154085-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502171616.154085-1-vassilisamir@gmail.com>

On Thu, May 02, 2024 at 07:16:16PM +0200, Vasileios Amoiridis wrote:
> Hi Angel!
> 
> Indeed the datasheet says that the pressure is a signed value. But this comes
> in contrast with 2 things:
> 
> 1) The BMP58x sensor does not have a compensation function so the value from the
> sensor is a pressure value just in different unit from the one reported by IIO.
> And the sensor is able to report in between 30-125kPa according to the
> datasheet which are both positive values so it makes more sense to be an
> unsigned value.
> 
> 2) According to the BMP5 sensor API [1] provided by Bosch, the pressure is
> declared as an unsigned value.
> 
> So, what should we trust?
> 
> [1]: https://github.com/boschsensortec/BMP5_SensorAPI/blob/master/bmp5_defs.h#L895

The pressure sensor reading cannot be negative, as the pressure range of the sensor
is 300 - 1250 hPa,so this change does not need to be applied for bmp580_read_press().
Also, the overflow issue does not happen with the pressure reading since the value
read back from the device is scaled up only by 2^6 for pressure vs 2^16 for temperature,
so multiplying by 1000 even for the maximum value would still fit in a 32-bit signed
integer. Temperature ranges above ~32.767C, however, will overflow a 32-bit signed
integer when multiplied by 2^16 * 1000 which is why this change is necessary only for
temperature readings.

Hope this helps clarify.

Best,
Adam

