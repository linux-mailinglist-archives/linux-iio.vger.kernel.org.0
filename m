Return-Path: <linux-iio+bounces-8590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2E95689E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 12:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414D42825C3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5DD161900;
	Mon, 19 Aug 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqpARSQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B541607AB
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063705; cv=none; b=Q1K7+aviHS13dCGN33lxXRA0jB4UivQqED0FjRmTFoyDsN9KkvWAVdlnrGNxR7YuIPeeuqoJ2aKLPxTDTzwwBVr8MfOFlLHAuAmB7bIZqdHxuugEDP2bxUK+FYHpVtENgAiv06AbTfLLHHo+Q5+w4KsQop9WXl0/MJrBZFKl/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063705; c=relaxed/simple;
	bh=C8cmAZ6DtMCK8UKjeMB4ciqE3g/tYE4h+B83nEaCixY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCppg9N2IOO0E+hGr2nVFxuUyh3fiWddprstesmPNshwajLYjJPy3sCH8bY20pGpMcq8gknVrpIc0XtSs1YEins4k8VsuJl96iQ9vvwwPyJ4KwyMlk80OjYzAwWrvAUyyt0P2HtezT4dXstAQdvof56FaHI2DOgOpVWzXw7VXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tqpARSQh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-704466b19c4so2408970a34.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724063702; x=1724668502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0G/FT2pek0BJGYjowpKrU8vTGOyidDEZSmaRCBfETA=;
        b=tqpARSQh4FlORB4lf/levNhSIyjSdKqGJPSrsRVGhSE0jmGR6Y2WZQCjbp2pOfGr7p
         EefKpIloCC9E8YHFOQsqFWNjPwRDff1v5BzlLNPmYfC1/DdE1hwMd3xZEtcd1+yuVexl
         jIvf7Iug6J5FyIfGo9DG8wATqjZj7HW6xb80gEWuPgcxsa1EKa2rvGWuKbH13MD+PzXa
         EL4lP/K6AAuScAlDTmkrBK1Ezk9+G2DDM6ZLfT7nwgWQ21SZ2yegkbICTguG1mLxJyzV
         94wZ3uFadY8NRdkYqOvWyMw31/yNwNgGEkzUSmUjyPF9Tx3W3m6GS3RBYwfBb6ZnuDes
         uJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063702; x=1724668502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0G/FT2pek0BJGYjowpKrU8vTGOyidDEZSmaRCBfETA=;
        b=HYWpIIzrUxbcAOzRmozoOGwGnMCv9EFzHaROiMIuPq9NLZo+MTDtAOTUyRS/68tXng
         tLMTtPQ+5l6ccyrhhFY2pcw2P7mBmjTzbcmJsn9dQaD2rhCSgpxnFYH5xKE5TDdOlNHh
         zJLvUuPTRI9aR59bcBOXfLdVMgPMKV8/eLkLgwvg/83DlAx1dY5+WWVTlE8SQmVgE9sW
         RbHZkvIvXlsumKhtymqH+Cgnoylqy3n4+vqwzyGqVOd37NzsF46B/pkuAHqYAvKIJePb
         +siknm4Ia5gxKdiC8s6ETbG2mpMOCZc1iBhS9eLvsaDw50ytOvsRrFdBeF3t49kOnGTJ
         TcTw==
X-Forwarded-Encrypted: i=1; AJvYcCXykObs7mEORDBvsM4mddZWc5zrhK8g2AL28FIzSHKiO5g0HSIYvPHgXppeOA0RIsdJUvP/jnDBtssmRhfcfzkcJ6F0xNNvFd5n
X-Gm-Message-State: AOJu0Yyc+svYQ8k+j4xAyehsl8Aykx0NuOw+VE6vmwTKKx7jdokLR7yv
	+a6wURPKf5KxU/t6M6jT0D+/do/kIt9mo5roStCFORoYoOh9sjr8K/nzPF4bH8ueuDD/H0pGcpe
	d0R375S5RV2ISkPH+7MT9HKfTbgZEkYM4zstYhg==
X-Google-Smtp-Source: AGHT+IGvfBJcsaH/i9fkAq46MlKF83AnLmTz2dPtPSQk73u0lGeY9eW9+SpkGNyUeKF1EmhsEC3NDjgKQWw+rxKqR7M=
X-Received: by 2002:a05:6870:3320:b0:260:fbc0:96ec with SMTP id
 586e51a60fabf-2701c55a28bmr12549846fac.38.1724063702596; Mon, 19 Aug 2024
 03:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com> <20240808-device_child_node_access-v2-1-fc757cc76650@gmail.com>
In-Reply-To: <20240808-device_child_node_access-v2-1-fc757cc76650@gmail.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Mon, 19 Aug 2024 11:34:51 +0100
Message-ID: <CAJ9a7VgtK1AtjhM+i41nyDnza27gigg2JioC2xBmWkPeLBS0zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] coresight: cti: use device_* to iterate over
 device child nodes
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
	Michal Simek <michal.simek@amd.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 16:12, Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Drop the manual access to the fwnode of the device to iterate over its
> child nodes. `device_for_each_child_node` macro provides direct access
> to the child nodes, and given that they are only required within the
> loop, the scoped variant of the macro can be used.
>
> Use the `device_for_each_child_node_scoped` macro to iterate over the
> direct child nodes of the device.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-platform.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index ccef04f27f12..d0ae10bf6128 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -416,20 +416,16 @@ static int cti_plat_create_impdef_connections(struct device *dev,
>                                               struct cti_drvdata *drvdata)
>  {
>         int rc = 0;
> -       struct fwnode_handle *fwnode = dev_fwnode(dev);
> -       struct fwnode_handle *child = NULL;
>
> -       if (IS_ERR_OR_NULL(fwnode))
> +       if (IS_ERR_OR_NULL(dev_fwnode(dev)))
>                 return -EINVAL;
>
> -       fwnode_for_each_child_node(fwnode, child) {
> +       device_for_each_child_node_scoped(dev, child) {
>                 if (cti_plat_node_name_eq(child, CTI_DT_CONNS))
> -                       rc = cti_plat_create_connection(dev, drvdata,
> -                                                       child);
> +                       rc = cti_plat_create_connection(dev, drvdata, child);
>                 if (rc != 0)
>                         break;
>         }
> -       fwnode_handle_put(child);
>
>         return rc;
>  }
>
> --
> 2.43.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

