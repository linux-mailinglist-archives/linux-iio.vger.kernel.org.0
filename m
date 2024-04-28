Return-Path: <linux-iio+bounces-4609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3948B4DC5
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 22:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C0FB20E13
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4B745F0;
	Sun, 28 Apr 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dafmSjMQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C521DFC7
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714335910; cv=none; b=pPw1FUWBrb0sSOQF9YTSWH9tKvjh9+06afeW2deWIJAl0M+Z3y2d8xIf1k+/1hQpi4F1+60cyukKAvq360puh5XCT73JTiUOAkEM9nczBke1FntLz/TdCi6ZJLdSA17ka4iKBjRjqRmvWPAAVJeIBXYzAlLtAvWTZCui1rPWsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714335910; c=relaxed/simple;
	bh=yn0rMumD9n7/8Ruz9ja3FaSnlWN7W/l+1Pp0AusQFho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+eNDijxZ1AvVhOWuHK2xfcUSvC06HZunIGl5XtdbOinUStIQ7H+6cXJLUnKjappMdDExfjkFFcRb6csVf/H3F+WeVhKZjzPj9Aogb29NwqAPOKVTmI940sqYIOwLQem6E/j3a5EMXcDtXA59+926LZ18nEiEH24fPzXzUl5rKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dafmSjMQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed627829e6so4698258b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714335908; x=1714940708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7wnHcjqC4ianr4ImbCf0xx9Vru0olSwYD1Tz+MZokc=;
        b=dafmSjMQgV6GKStAnFCWrbtYFj/Qn4QngqotIFn3XPftvLHyKUrG/uAvWjqfe39EPU
         XsQCu/uj5h6CwMEQnBUkAkkUQ+VN8I4E0oRdOpJ/jUImkkFpSAucV+owtasHcgA75WXR
         P7wSUkfvE+b4kS/j/UQ66hDB/kJ+JhpFMui9EhliJv0NyxoMovwY07fjLNY37wAPz9+u
         ehpQUK+8xMpbViIHQCB9lsZOxzdgeU+lm1qWzOyjizch7acJSlNf6pXOXroFRYZcDLMs
         Ul+i97fGlp+VSq8vux9aeyhuBdz1gbZDaCCK7ze2DvIyIcpRoqcKH//86aD/W7AgdRCW
         l2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714335908; x=1714940708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7wnHcjqC4ianr4ImbCf0xx9Vru0olSwYD1Tz+MZokc=;
        b=ZYHIv01L9nzzNjeUL5XG6R7lxwz8fS/NrTtEuTX6LRL4N0OYIWimvdBMpRnks2WxqJ
         Khsaoqf8IgdFxwugkErvSSO6cI0FTduv4k/n+8ffnoGGdfWp+mxwvBpmUjGRFzCzZan5
         Tt7TaqhnggqFxdj3Uk5/9EmsjLUzV+2ywQE+fcK7TAIlLXSJ1huQUbnN3q6ES7JRGpRA
         WKMd/+2gtUl+0sKe0BT3/XMyisYDQxmcP6ccncBOIWPuVFYZYsVAfbY9GaDQQcYuermC
         sd5q5kMAt7t9zxtKUF63EctnZBB4h1WVmh0lIrhKhGVpsOmgzRp/UfPx4maeIn6r1a/o
         yfXA==
X-Gm-Message-State: AOJu0YwygcnwDCz7Gf0lsNdSONVmzcVKe9XV5FQW82bDsObD+DZ5HAhO
	hWzjdzlpVtS9pT3Z78XpR6+WEhGcz6zzfxdeU5RuVQWEQFYPntCFxeXojv5m
X-Google-Smtp-Source: AGHT+IGyVy2MGns74cTOGS//YncTbKyhI0de83Pde1l+AWYkHvEnzA3hLYoPUFXo1cuo1UGc8B+KlA==
X-Received: by 2002:a05:6a00:1906:b0:6ea:e2d8:468 with SMTP id y6-20020a056a00190600b006eae2d80468mr11750947pfi.26.1714335908026;
        Sun, 28 Apr 2024 13:25:08 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006f3ec69bc09sm2891924pfb.75.2024.04.28.13.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 13:25:07 -0700 (PDT)
Date: Sun, 28 Apr 2024 17:25:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 1/2] iio: adc: mcp3564: Use
 device_for_each_child_node_scoped()
Message-ID: <Zi6w1V9mBWZAMv-t@debian-BULLSEYE-live-builder-AMD64>
References: <20240428174020.1832825-1-jic23@kernel.org>
 <20240428174020.1832825-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428174020.1832825-2-jic23@kernel.org>

Hi Jonathan,

This also looks good to me.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 04/28, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
> 
> Cc: Marius Cristea <marius.cristea@microchip.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/mcp3564.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index 311b613b6057..e2ae13f1e842 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -998,7 +998,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
>  	struct mcp3564_state *adc = iio_priv(indio_dev);
>  	struct device *dev = &adc->spi->dev;
>  	struct iio_chan_spec *channels;
> -	struct fwnode_handle *child;
>  	struct iio_chan_spec chanspec = mcp3564_channel_template;
>  	struct iio_chan_spec temp_chanspec = mcp3564_temp_channel_template;
>  	struct iio_chan_spec burnout_chanspec = mcp3564_burnout_channel_template;
> @@ -1025,7 +1024,7 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
>  	if (!channels)
>  		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
>  
> -	device_for_each_child_node(dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
>  		node_name = fwnode_get_name(child);
>  
>  		if (fwnode_property_present(child, "diff-channels")) {
> @@ -1033,26 +1032,25 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
>  							     "diff-channels",
>  							     inputs,
>  							     ARRAY_SIZE(inputs));
> +			if (ret)
> +				return ret;
> +
>  			chanspec.differential = 1;
>  		} else {
>  			ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
> +			if (ret)
> +				return ret;
>  
>  			chanspec.differential = 0;
>  			inputs[1] = MCP3564_AGND;
>  		}
> -		if (ret) {
> -			fwnode_handle_put(child);
> -			return ret;
> -		}
>  
>  		if (inputs[0] > MCP3564_INTERNAL_VCM ||
> -		    inputs[1] > MCP3564_INTERNAL_VCM) {
> -			fwnode_handle_put(child);
> +		    inputs[1] > MCP3564_INTERNAL_VCM)
>  			return dev_err_probe(&indio_dev->dev, -EINVAL,
>  					     "Channel index > %d, for %s\n",
>  					     MCP3564_INTERNAL_VCM + 1,
>  					     node_name);
> -		}
>  
>  		chanspec.address = (inputs[0] << 4) | inputs[1];
>  		chanspec.channel = inputs[0];
> -- 
> 2.44.0
> 
> 

