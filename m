Return-Path: <linux-iio+bounces-1594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77682B8FA
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 02:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7471B1C24109
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7265A4C;
	Fri, 12 Jan 2024 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLDZHvua"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59083EA6;
	Fri, 12 Jan 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28bc870c540so4917983a91.2;
        Thu, 11 Jan 2024 17:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705021785; x=1705626585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbnbqtGC+LwPJy3OhQOf+bnBND4N5hTC5bevzjMn7M8=;
        b=XLDZHvuan0wj0aefv/Nu4b7EeMXsO8zkVPi3ojeyYdN7G58eLqWLwDcFkUTpbrzDvh
         bYymo1qtH8mSIgcTegStPU7axNAlA11zzBxqVDKf6VP6Pi8NZimsf2NF7pjDSo6iNqs/
         fzQfdfBbZqxFFBlIKtPqFi5P4cAx93rc5FQcaZ4BcbU70Gw1skV9rAPpDKhxDFgXy81F
         rFUioAJ5VT8s/WAsfiwdNxdKarlSps975yXTZeDwCPVptNRgJbtD1K+GiK/PrnRUx3KU
         7puBmVAfKFMFJCdWXYCv9PhjLuqTiHOB03JjCYd0JNmg7h4aSUMkOkv6uLQbcWEvLKC5
         fnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705021785; x=1705626585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbnbqtGC+LwPJy3OhQOf+bnBND4N5hTC5bevzjMn7M8=;
        b=ckFitgq1G6vGbLREa8X0p2TeC8jg6zcuRZ416eoQy+dU1F/ICPQu04JIFIvRpGOqns
         jdnqfp+Eh7o4iKANTZwq6gzl/FopfRQ6B2fJjOftug37AjVW8zJhe5eW/j22NC6cxxwn
         vnujVZWav+7K8IZQzrfVKS3mqoDtGn4L1AXBBFuEsE0R+ZPOw/EYlfyuSYUpHYiCllh3
         iw0jonv16JmQRzENoKVFyKuHOB97i4ODKQhiK3exStk/qXBfWq9wC9MwLnUhaldG97M9
         Ir+4yRS2XvJikIOqLtGnVFEBnMLoHLhX3M96FspbTyVBRkXeRMgqNbYs/a7wk09ROP+4
         PlsQ==
X-Gm-Message-State: AOJu0YytG/ZYRgalWIMl/2WT2GeHGrzgzzJ89rmIpk9pL3QfaTLXYU4E
	sCc8plMXNYt1zKRF2LtmT7I=
X-Google-Smtp-Source: AGHT+IHWgleMhDkfikwrRIqFaW2HT2Q8E4dtrtFV9uwKWr3KD82C/4m0Ekkxr8BwjDCcw/HnqU0S1Q==
X-Received: by 2002:a17:90a:c004:b0:28d:a54b:6951 with SMTP id p4-20020a17090ac00400b0028da54b6951mr680831pjt.16.1705021784655;
        Thu, 11 Jan 2024 17:09:44 -0800 (PST)
Received: from localhost ([2804:30c:924:6f00:42e7:f3b7:14b8:1cbe])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090aec8e00b0028e0a0445e8sm84189pjy.17.2024.01.11.17.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 17:09:43 -0800 (PST)
Date: Thu, 11 Jan 2024 22:09:43 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: correct file entry for AD7091R
Message-ID: <ZaCRV6Qw1KlIFt3I@debian-BULLSEYE-live-builder-AMD64>
References: <CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com>

On 01/06, Amit Dhingra wrote:
> File entry has driver/iio/adc two times. Fix the file entry
> 
> Found by ./scripts/get_maintainer.pl --self-test=patterns
> 

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
> ---
[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35147477e8e4..ff61be50e82e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1128,7 +1128,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
> -F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
> +F:	drivers/iio/adc/ad7091r*
> 
Oops, must have accidentaly bumped the paste key at some point.

Thanks,
Marcelo

