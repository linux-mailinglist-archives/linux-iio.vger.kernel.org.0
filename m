Return-Path: <linux-iio+bounces-4557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646538B4547
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 11:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFB4282D50
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607EF4503B;
	Sat, 27 Apr 2024 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ZwYkqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D2653
	for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209135; cv=none; b=D911HtSIFupPXn2uVXQVhvWe/KK3MBBUq8gOpDqz84z6GJHbZE6nN4d6ZHVd2V8t5Lr3Fyz0nVxtceQQvT763auX7QHgtRLgAos9z3aZlvRtF5ZQi1pmlJgygpqUbr64OY50Tsxxeyq6wOT2bhrC1CtJmrxbEhTSjjpJwQidb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209135; c=relaxed/simple;
	bh=297dbZ56nifTh1rDORGDbHHEw/H+/nzws02WbXPW78g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c17XqgOGM5I4kg3krrwO0+dTE5FH3yNsl8CSO3y8k9CA2RqFl53JQ7uD2hm2Qr4EGfJgJ+qUoWPk9EJJUksQjaqZ3q7D8zA6Mn4iFFRvwOoIIqJI5blYyXhMjdWQCYhs5fsJ3tldozAtgrjnUxlXpXiw1N+6WalE7bFKQXOkSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8ZwYkqF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso2116358b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714209133; x=1714813933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHS+Lovr4/3nadLiBBf/GgWskCGuGQuMZF4WqhjJZ8k=;
        b=V8ZwYkqFExFw2S/Q7S1n5ymWZqt3rXZeSB6qlsGnvV4hmyWAOb7Xk2Oh6bh6MW4XyZ
         Fv6cZf5LQdm8CHhNDRMUKWPpokkbTxkkQNUgIpaWHYSgq8NInnD725EtLrm32fZn3VK4
         dzI8kQtoJTLP0eWPvhDeM3+imGqi1Lw9s4QeRHElSYStHWK/6v4XyHMTJ1/oysVHIo+N
         wBMqn8W1aQqlfpdVX21cfDaudM6GqYujrh2njqyWNDPwG67BreeLbsY0velkE9C9YvNp
         Ga0020vFguJI+7cufo9KW1EqsfKnTtwXw/Q6wRaNkj+Ce7uX73t5BnkfSdWxVzwn3WIC
         MbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714209133; x=1714813933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHS+Lovr4/3nadLiBBf/GgWskCGuGQuMZF4WqhjJZ8k=;
        b=bxA4C5OBfBIvoMflLq0TREP0kUG7IMf67f1xqQw/zPsJPZLO2yy4oCI4JeX84N2fZn
         LQXKHIgbjU8+4jOGmI6BgFHMVi8bdlQjXLwb4ZhLpDGHSKppFRK7Qp+HXlVL0FSexWKo
         39mX08QMrrINdfgjr/u3Q2shqutBMJz6i6UfTaNsUe4JXt8xErnPU8RRHKYHeijJ0mz/
         /PLDAnwQF4sXnuY2Gh8BSijN+uROojnxpnba94UpyH+0IbMZHrS/WnySlfamuljJcV/e
         6eZfhwtypIkjYiGZ58OR00jQxRmwMFyH5Z9Ap8LecBgnKJDzDqcNIZwzCvIlFeTUyV1X
         PTBg==
X-Forwarded-Encrypted: i=1; AJvYcCXck7ClztwvGjCqlGkfC/+NVRmPfjQlyHDivS0/vBJvZNFbNLA+2fqzvImVDWlxNqTmKmjIpWyuSt0+Su4zic/Mf/vAEGHIZs9c
X-Gm-Message-State: AOJu0YySg7RONE1rK4uINk6crXUfM5mTEgOYKRrhfBqAy6ZJwUYsp3nf
	JgbD56PDy4P1qkKHX2UffksoObIotWCTC1mlgkx6g5XONixrvPcm
X-Google-Smtp-Source: AGHT+IEI9/aIXBCRUtuzxt2AHmw++6CufuCTg0btcR2HkIbswT4vdDhvc3Ow6Jz88Ujt+G1dP+0wCg==
X-Received: by 2002:a05:6a00:39a1:b0:6ea:c767:4699 with SMTP id fi33-20020a056a0039a100b006eac7674699mr2751887pfb.13.1714209132845;
        Sat, 27 Apr 2024 02:12:12 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00170600b006e6b180d87asm16027125pfc.35.2024.04.27.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:12:12 -0700 (PDT)
Date: Sat, 27 Apr 2024 06:13:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Pedro Mariano <pedro.mariano@usp.br>
Cc: anand.ashok.dumbre@xilinx.com, jic23@kernel.org, michal.simek@amd.com,
	Roberto Bolgheroni <robertobolgheroni@usp.br>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: Use
 device_for_each_child_node_scoped()
Message-ID: <ZizBndYiU5GVUtmQ@debian-BULLSEYE-live-builder-AMD64>
References: <20240424225302.47004-1-pedro.mariano@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424225302.47004-1-pedro.mariano@usp.br>

Hi Pedro, Roberto,

Patch looks overall good except for the _scoped() function name and arguments,
must have been miss-typed or miss-copied somehow.
Comment inline.

Regards,
Marcelo

On 04/24, Pedro Mariano wrote:
> Using device_for_each_child_node_scoped instead of
> device_for_each_child_node automatically releases the handle on early exit
> which reduces the chance of bugs that cause resource leaks.
> 
> Co-developed-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
> Signed-off-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
> Signed-off-by: Pedro Mariano <pedro.mariano@usp.br>
> ---
>  drivers/iio/adc/xilinx-ams.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index f0b71a122..7f5571d9d 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1261,7 +1261,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>  	struct ams *ams = iio_priv(indio_dev);
>  	struct iio_chan_spec *ams_channels, *dev_channels;
>  	struct device *dev = indio_dev->dev.parent;
> -	struct fwnode_handle *child = NULL;
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	size_t ams_size;
>  	int ret, ch_cnt = 0, i, rising_off, falling_off;
> @@ -1283,13 +1282,11 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>  		num_channels += ret;
>  	}
>  
> -	fwnode_for_each_child_node(fwnode, child) {
> +	fwnode_for_each_child_node_scoped(fwnode, child) {
should be
	device_for_each_child_node_scoped(dev, child) {

>  		if (fwnode_device_is_available(child)) {
>  			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> -			if (ret < 0) {
> -				fwnode_handle_put(child);
> +			if (ret < 0)
>  				return ret;
> -			}
>  
>  			num_channels += ret;
>  		}
> -- 
> 2.44.0
> 
> 

