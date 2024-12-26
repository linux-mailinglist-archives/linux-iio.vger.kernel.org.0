Return-Path: <linux-iio+bounces-13811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3309FCD4F
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 20:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566911883224
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 19:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191A146A60;
	Thu, 26 Dec 2024 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BibEkG56"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB62BCF5;
	Thu, 26 Dec 2024 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735240584; cv=none; b=LoZaRnD1EYpjrFdacnrLS9qt20KmMRJCKH17p8Tc+s9K6eBrxhT2aWQla2UKHWSt5h+Lzb07lMEB0BzAAOoDvhSYIttqGvv12ljHC6NwkLQBnoko4hw6q357CzwszSINkunHyqF5WUjcPGM9wTXmPhoCkgYJpTdWtZ5IoVLFa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735240584; c=relaxed/simple;
	bh=5BVHlUudbockLA7CxwiOT8r6o23IHJF6BXZFa0oOjrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9ca7J0LXP9MSapvku0B9Z4VHqtJ6FzRT/Vt88XAlKAppOVGTP5kiMgR1nCOc0h1Uvk0f1Z5x12PXVGEucR2dU11/dHSh5aNzqupRKLnLum9Q0Vp9YknJC4owQom9iFFfip/Uny9zUfiI90TJ+WOo6lgNxOmIMl5RKhvwijPX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BibEkG56; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b70e78351aso539722885a.0;
        Thu, 26 Dec 2024 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735240582; x=1735845382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEVgf5HifYcT/ChBJ9uoFGBYDRXyqfRjcCKmlYzW1+M=;
        b=BibEkG562pGfBwiTNA+wNJ6Z8V1Gk8fIUCdb+OhSgAAcpxuVmEBZ40HLI/Ybr2rWG5
         7j15aA0m60g5Hc82Uev0ssTOTMpN1T07QzAVkguCgwnXoaH4tSBbayyPnO9y12TpOt7z
         QNTek/y0WLnEXDpEF9syKOwr430Dbeb/MJ+EnXQMHH+QGgo1XO17iFZkoFEbdy9oFqYt
         qe1tfjzy/RaMrvCEbyz3TgQpenRYlKDjuC67zu7G5n7nOLzDLne+ftJj0YfHo6hh5wRR
         1GcH17uUO22QUq/1lg8iXBxaJQbbCnLUgFkM/grarMCtWqEdKE5lvgdEvZRTdxec8SHY
         a9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735240582; x=1735845382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEVgf5HifYcT/ChBJ9uoFGBYDRXyqfRjcCKmlYzW1+M=;
        b=MLE1BO6oILN3FJufovqmn/Gv+wi12oPX+QVTmfnPpy7+XJxEG4thoCxAxVgylO6/kr
         ySYCqYa2fIAU6lSU2CQwODmfxTdLAeCuG+NGvAW467z1GpRpZD2NtegWH2tDl4K56DGv
         0jSd9+e6tT0hXaiHCNNcKnfppF7gLknTbPUFFwW3HCwn0s6/FWxEnEBIt3xAq4AkED/p
         QO3hurfBkmiqQYuqzfnMm4NRV3nz/qymzlwTn3Yj9VPSD7ER5WK7BIvqKcB5ZY2c4V1I
         L+ZOFA5s0eeeLl32bghFyKoTJagzWKUJV5csz7z3j8RtxMoTycTamZZyt1e+ZJFKUKAP
         lDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe/Hi1fXsnfB86AT6aYFZLQnHDZyNN0VO5Bm/hnZvuY7klSAgsiFTfLxqcjYPExlp2+AN4bnijZ9VcBqMz@vger.kernel.org, AJvYcCWoke6vm30/r7/7r0F4dOcDqB09kJspl24cLz0PGynewCnPaq517t9UKTwuRhxdUgilPudJuMYEfouw@vger.kernel.org, AJvYcCXKfEA70VnozpkwDuKGPagMWH+mmjP73pmIdcun6ZZWSdaflnAYfqdNhtuwlrim7Vo6Rgs72kbH6+2o@vger.kernel.org
X-Gm-Message-State: AOJu0YwjWvN2Wmmfl2FFpqd35vok/DNlbytp+7xXYYGWkpUyvoX04hRn
	3NdvbHY/0ak3xDDrQVexPkalfX2yhcaA8vMejQPP7PLLNsW82Zhy
X-Gm-Gg: ASbGncvpw6n4CRKqWMQqiE91MYyisWCaCf763RA7UFLM5j0nf6xqFPCAxH40OHhRb4f
	8seca2w1118612WhopJHBGTjVPaSBXQVHAbhHzkesmljIBBLPy07Lud0ZdUqkBcTNf4HA1829M+
	DlqTPjb5zbwQj/HUvlxIl3mAtRhTNPItFZ8f51excWJgyiBiTYFFfM352Zz5b4Q6P0bWtCTDm2r
	0Fej/1s5DuIsIYD7ReGCmbSB1/w1s16RM4SUxET/FwJFz1xuA2zi3EBnM8=
X-Google-Smtp-Source: AGHT+IG5tEwT3ooSzvnacQ7YFkfrWEHKvnQ7iAlPjj8dW3zcND0/PvS+YhnOMizWfKJBrw5LGhNJmg==
X-Received: by 2002:a05:620a:1a22:b0:7b6:d5a6:18e8 with SMTP id af79cd13be357-7b9ba7fdeb9mr3559681685a.50.1735240582154;
        Thu, 26 Dec 2024 11:16:22 -0800 (PST)
Received: from VM-Arch ([2603:7000:d100:26f7:906d:da54:c718:2403])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478d9esm643203885a.77.2024.12.26.11.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 11:16:21 -0800 (PST)
Date: Thu, 26 Dec 2024 14:08:16 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jagathjog1996@gmail.com, trabarni@gmail.com, danila@jiaxyga.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: imu: bmi270: add boolean type
 for drive-open-drain
Message-ID: <otr4hmhbhll2lcx76ac4t4ixy4lcgph2wcmhlmqp4kdfdynfc6@codcwfij2cnm>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
 <20241219234745.58723-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219234745.58723-3-vassilisamir@gmail.com>

On Fri, Dec 20, 2024 at 12:47:44AM +0100, Vasileios Amoiridis wrote:
> Add missing type description "boolean" for the drive-open-drain property.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> index 7b0cde1c9b0a..860a6c1fea3c 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> @@ -41,6 +41,7 @@ properties:
>          - INT2
>  
>    drive-open-drain:
> +    type: boolean
>      description:
>        set if the specified interrupt pins should be configured as
>        open drain. If not set, defaults to push-pull.
> -- 
> 2.43.0
> 

Ignore previous tag I sent in.

Reviewed-by: Alex Lanzano <lanzano.alex@gmail.com>

