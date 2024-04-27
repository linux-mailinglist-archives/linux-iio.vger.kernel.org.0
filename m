Return-Path: <linux-iio+bounces-4559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1818B45C8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 13:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07409B21696
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5B487BF;
	Sat, 27 Apr 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz1mZy60"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B263482E1
	for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216445; cv=none; b=cnYBYK0TB0o9IwGQNaiT+xKcQalLLOKDHoMzuV7Rd5ZnRjSIZ7PGOgQEpUdtPNrJNAVlqcxd/3R8e6MRItT/GTF/XdqwTSQuBQpkgYZ3wbS59hMmqS0OxrdfGpKOivb1DFh9TkMlVq+w+hfA930FlHKRkba+gcDSjhIjXpBycTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216445; c=relaxed/simple;
	bh=dc8H1AsIBx7qbJTfi5bbCIyCCWi65tVvF79n3vOJ1hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKdkAGuC5ndSW/7j/o3WCZxz9T7Y1kWLHCme535b9rO18SbDyXGRmZ1iRx0ymBvTfozSPNQWuAtwr7UAkqPa/SUieUo89L1WeNfaHSAFprRMVi5hJzx9cOs1TSI5orKdlLStF7tH2JhLIUhT93b+XRpuC4XUMRIWCjB2wV6T/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz1mZy60; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2223626a12.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714216442; x=1714821242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFwFEMLz9Y4SvJ0kCtjaCb4pbyDl5bvWmn72Z2y7QrE=;
        b=jz1mZy60+iHhM6yzRoEaz5YJ2wiPwUv3uCBhyDprTukIiNgYSGFM4+puLd4odvsEvP
         0QH6ro8wOq7NiTHbHIpkqlyiAB8YUdOJJkJHrKx3wdqG45saXwHfw7aKRSesr1mxnPBc
         jVlcsLHzsXq+z8u7jCwKDcgzALIK/JvtSJIPzsKOri/xbeN1Tjbe8R6xISlLoylC3NjF
         w3Aeiitc19oYBH7TC4ftfrvUsZN0A8tqNJYqrJ2G/FwZ57ycotvZzNGpZl1cfxb7JBYT
         5vmfTa9fN/KwMNA0nI1/I8kZ/OAQFV7lwvlkTGjfTwg103fL/kRJAwfQUsUjwQRJAFev
         w1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714216442; x=1714821242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFwFEMLz9Y4SvJ0kCtjaCb4pbyDl5bvWmn72Z2y7QrE=;
        b=Z7LD3QFGBTLqLMPs0udyAiVf41viFNWeWdOhiBtZmZC/nQ+ih0X4+YMU8gbQacB1AW
         lYfhNI6ercJF6V4EKsGIjqGmbs62AnRMNsfgnU6FB/b0AlO2ToNVKx8FqqGXbYKEcdpa
         rPn3BON9IDUfLksaOn2U82L6rd12tFQxG2iLCPFVGlTK7zbhC2GwryMYVbFukWWOhFBb
         4yMoQG86G91Od1Z66xfg6v8ni4iOY5zUAoQsb/aw1W8wJsyP88CNgq5uh8mZnb88X68n
         hxUFx9XzcmGHJGyDGet0ctV/Q/Z+W8chCdQJb9kfJUqO5h9I6o8RfpPFLxMt+GB7ip0H
         Dafg==
X-Forwarded-Encrypted: i=1; AJvYcCUNQIK5eiQNdyx3KK6LUhoJfDQgVzo/9zu6NkjUuA4l1RmeOE815fQlqZfzYwUHQ0mQ7ppRZwuurEKgSzD6uxwAeG029g4CAHJL
X-Gm-Message-State: AOJu0Yy70Hu61WqnKTsJVGUBGcuLU5qp0PMgkRcLKzfCVy7lExUEUKbr
	Qz+AHYQu+Wf0BMfkomNpeH3hhJLf2lUoopyRleEfP+pDbG+W/vgr
X-Google-Smtp-Source: AGHT+IE0bpdKG8KyTkkLHAhN1f/mRMkqMTs2yVL9QWrt31MJnmeMpgZDtGOSRfHEDKOEzw5qMRg3Qg==
X-Received: by 2002:a17:902:f80c:b0:1e6:ac1:9437 with SMTP id ix12-20020a170902f80c00b001e60ac19437mr4550041plb.67.1714216442393;
        Sat, 27 Apr 2024 04:14:02 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903028300b001eb15178370sm2482318plr.130.2024.04.27.04.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:14:01 -0700 (PDT)
Date: Sat, 27 Apr 2024 08:14:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Lincoln Yuji <lincolnyuji@usp.br>
Cc: jic23@kernel.org, Lincoln Yuji <lincolnyuji@hotmail.com>,
	Luiza Soezima <lbrsoezima@usp.br>,
	Sabrina Araujo <sabrinaaraujo@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: use
 device_for_each_child_node_scoped()
Message-ID: <ZizeKo_E7Z5DOR9C@debian-BULLSEYE-live-builder-AMD64>
References: <20240426131953.14933-1-lincolnyuji@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426131953.14933-1-lincolnyuji@usp.br>

Hi Lincoln, Sabrina, Luiza,

The patch looks good, though the message should be wrapped to 75 columns
and the "From:" tag was not needed and caused an email mismatch.

With those adjustments made,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Regards,
Marcelo

On 04/26, Lincoln Yuji wrote:
> From: Lincoln Yuji <lincolnyuji@hotmail.com>
> 
> This loop definition removes the need for manual releasing of the fwnode_handle
> in early exit paths (here an error path) allow simplification of the code
> and reducing the chance of future modifications not releasing
> fwnode_handle correctly.
> 
> Co-developed-by: Luiza Soezima <lbrsoezima@usp.br>
> Signed-off-by: Luiza Soezima <lbrsoezima@usp.br>
> Co-developed-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> Signed-off-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> Signed-off-by: Lincoln Yuji <lincolnyuji@usp.br>
> ---
>  drivers/iio/adc/ti-ads1015.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 6ae967e4d..d3363d02f 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  	struct device *dev = &client->dev;
> -	struct fwnode_handle *node;
>  	int i = -1;
>  
> -	device_for_each_child_node(dev, node) {
> +	device_for_each_child_node_scoped(dev, node) {
>  		u32 pval;
>  		unsigned int channel;
>  		unsigned int pga = ADS1015_DEFAULT_PGA;
> @@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  			pga = pval;
>  			if (pga > 5) {
>  				dev_err(dev, "invalid gain on %pfw\n", node);
> -				fwnode_handle_put(node);
>  				return -EINVAL;
>  			}
>  		}
> @@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  			data_rate = pval;
>  			if (data_rate > 7) {
>  				dev_err(dev, "invalid data_rate on %pfw\n", node);
> -				fwnode_handle_put(node);
>  				return -EINVAL;
>  			}
>  		}
> -- 
> 2.34.1
> 
> 

