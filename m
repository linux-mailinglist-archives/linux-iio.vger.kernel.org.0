Return-Path: <linux-iio+bounces-17385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2EA75C27
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 22:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BD3168770
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7E70820;
	Sun, 30 Mar 2025 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAstD51j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D12AE8E;
	Sun, 30 Mar 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743365884; cv=none; b=nb8oxkNzNbdgjGSG4dRNo4rtd6CksdtTlawdutllk7FV0sh+Rozipdnjb7tnCG7c4wjKIDekriZVWcWw4yP9nZLbOFqhLiGAp8ZOFL2zTeElPhc+QsvJ1pcgrAQZ1CZM2ACi0ICgDRVFm2dj4jDYyQt2SyiyDPYtfm40qeLhh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743365884; c=relaxed/simple;
	bh=i/zZuquizU3rNnjsaeo6z64PLYbXEl+OVKP9uiO7kOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw9GLiid4UP9ciu7/snS2gljGqRN5ywgDZnfuqGrmIPb226GnX+ycl5tTGjLnm+0GVSZFp3Rwct0UbMqfUKPxTldbXwUJxo9uFJpAe/mLYIAAS9ZB00CqDA87d6WMnLjMcok3iGhkY4PQeHhSWAeCy5uDMDdyn6zkKjsTyIJ5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAstD51j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so70755275ad.0;
        Sun, 30 Mar 2025 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743365882; x=1743970682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5coYYRPMmYyk90hyfQos6Hfk3JtJvsesMjWEHhnPPg=;
        b=ZAstD51jAMgdtjHUjKHWIFNE3TvCRhxeTwfkGLGMRWcjgVqIIQ+wnPT/F+lZKYRmX1
         PRLI1iiHmrs5g3AAo9ztulw8kPdn2DmiNR9FfLE/VrmbVwhrjCYlJi4lbER2oaFbHmeP
         LpyUlhqegAE4Ku8cbk/vNm4yOVrJovetdnZTJFYaFYEbmRNF1XwfdumcNm9RhnMvMn+x
         MXyJxsHA6UPJqv37g5DF+U7vVGVX/r5bSl99KPeqnRwPBl1ixYhq4r13FNBsxGbtlXP8
         EEpnvAiOweFRLF8ztwLaAwVxHbBzvsSi5Xj2Hyfzz5nNNpvQUoSYZhBgzTS5jl/ZDn8N
         YxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743365882; x=1743970682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5coYYRPMmYyk90hyfQos6Hfk3JtJvsesMjWEHhnPPg=;
        b=j2df6jkqZohoZxWx/RW5MUjN81XMuzNqCVXeAUmZjU3nJUoxfWaPMFpWcIH+AIiDa1
         NXcUHzY9vxKgV3c5UMyHmsUJJwnrF7vwODy9Deoq6zEcs7KEZQKbdpIqFWkKcGa9fwmV
         B8vynotON6f2cRupHirabVdiCU5Q3cSIxeg8gZvC5v5uN1IPf+wMzyVjbCqKh9fzZOlY
         1awwNmD2HiAfZtU6I4kX43hIBskhjUxiezntIf7nWaT9fU8Hr+sZXOz6gqzseeOrBbdc
         hYFWVWlm5TTU80nTk+tSR/uOiylw9ujqa7Eup/AXz6+NrEi4d/BfmeEO8fpAGBEPo6RZ
         z72A==
X-Forwarded-Encrypted: i=1; AJvYcCUM+EyU+IPCxsouef8DPlVcv6zngh7RjrMRWRfRReYTFXKUitctPnBace6N6MtprjF4zsVzBzMO22AV@vger.kernel.org, AJvYcCUrcZil60q6ylltCv8MdzmfU8gyOBWCLUTMFQSCA3CexTTL/diUrCuk0CnSzl3JDG8iLdXLpoi5vaqf7sICoHdwacM=@vger.kernel.org, AJvYcCUt1yYC2VVWylN4GAtPuAngViSyFRDFJCJopCSJGkzI9pXRTQoMVUevNTu6uRNI5KgaB9aS3H6RtzZ1FGuW@vger.kernel.org, AJvYcCW4ctXMlWPCM6I88hQkuQDP/CALpsHvfGT3cKVoGepW/HdG6D+VkFKbTJjBzVAL3VSN2c6TvnfM3tId@vger.kernel.org, AJvYcCXNxP+pmwcHvM2v06wcpJEmnMeIRu4LkvF9lfP/bNEXlf+mqxYlx2qZ8Ud10qTfVFa229Xikd+SPK2SXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJ4GDoHyIulx2iOIeiWg0NvVsPShqVw2qGtFzq88rprzFyJQk
	JXgYs6XqEStHvRtrV/TmdwFOMsGxPLzijQKq10Ddb7CvjcoOfpQtjoZc59Su8pk=
X-Gm-Gg: ASbGncv7o7uObYjHycYvn93NMqQjMegv71THfKGFvfB6w7Qa1R3WSCGTCmlemu3tf8Q
	v8YpgPPX2I075G3hvI1c4Z2w45URJKAwCdw2RMHAawuLldVHYLay5u/+DhEmhJrj4LEiB54caTU
	DH/HVj6B+VqWVmQ2MGBYXZITPQSJMdiEzR95CR81LhDwwTIShOmG12PhE+vqmNvDaZVEv0Gma7L
	8nJea7LdUAjCQFuGd6YxnoT7EQOsdkImSGKOHLM79kkJqm68cFdehzOxlwrgtLxUhiAAii75h8D
	yG+Ea0KaYn53XyhaXP5jK9xri/ZktsEdCTuRxjVxUEdKBlsXxR3vdg==
X-Google-Smtp-Source: AGHT+IGdRb8RSEY/uMCLsBXs2PCUKzrfAlPuylZyCRqePE4ThlWVOzd97jd96fvdyjccpN5hsZkrrA==
X-Received: by 2002:a17:902:f644:b0:224:1af1:87f4 with SMTP id d9443c01a7336-2292f974b63mr133802185ad.22.1743365882249;
        Sun, 30 Mar 2025 13:18:02 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e1139fasm9042555a91.25.2025.03.30.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 13:18:01 -0700 (PDT)
Date: Sun, 30 Mar 2025 17:19:02 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v10 3/8] iio: adc: add helpers for parsing ADC nodes
Message-ID: <Z-mnNtYLkwsTYjMh@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
 <f1d8b3e15237947738912c0d297b3e1e21d8b03e.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d8b3e15237947738912c0d297b3e1e21d8b03e.1742560649.git.mazziesaccount@gmail.com>

Hi Matti,

The new helpers for ADC drivers look good to me.
I am now very late to complain about anything but am leaving some minor comments
below that can be completely ignored.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Thanks,
Marcelo

On 03/24, Matti Vaittinen wrote:
> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.
Not sure it's preferred to have ADC channels always declared in dt. That
question was somewhat also raised during ADC doc review [1]. In short, ADC
channel may and may not be declared under ADC dt node. ADC bindings often don't
enforce channels to be declared. On IIO side of things, many ADC drivers just
populate channels even if they are not declared in dt.
The ADCs you are supporting in the other patches of this series seem to require 
dt declared channels though.

[1]: https://lore.kernel.org/linux-iio/20250118155153.2574dbe5@jic23-huawei/

Would something like

A common way of marking pins that can be used as ADC inputs is to add
corresponding channel@N nodes in the device tree as described in the ADC
binding yaml.

be a good rephrasing of the above paragraph?

> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
...
> +static inline int iio_adc_device_num_channels(struct device *dev)
> +{
> +	return device_get_named_child_node_count(dev, "channel");
> +}
I wonder if this function name can eventually become misleading.

In Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml we have
temperature sensor with channel nodes named after external hardware connected to
the sensor, leading to channels having different node names. Can anything like
that ever be accepted for ADC bindings?

