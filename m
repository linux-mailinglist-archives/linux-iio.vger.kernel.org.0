Return-Path: <linux-iio+bounces-13765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDE9FB4D2
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 20:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377DD165C2B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C786A1C5F04;
	Mon, 23 Dec 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgAlmGOq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0318A921;
	Mon, 23 Dec 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983694; cv=none; b=F5Rj84r0fFcKdUeUuFJiohVe1acgJ0DcN57el3WYsoHlyDSQiSMU4bPGBNvWljlIi+4yKyIU/iZVL7KNmV/feyCZc539elkV2GJQMJWycaK/1Xqs3oz9YHyflrd2T9wPX5H+N5WduNqWNuY2h4sZFCOTHjWnko5/0zjffsZSYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983694; c=relaxed/simple;
	bh=1VD2EVmlIlsR0rtO4sh+F5RUXtekuQSnjvGo4zPhoyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkmmBtli68cwW4nVZX4ouRLNLp7OYfbtiVsejUHlBTmtnheTudl26uhbhO4ewFN80Na+ydhaKtK5u5bmrza0JKa98Z7SrNpPUapGCKm0BeSkmgo1A7t9JqEmFN10qKSmcz/NzLC70K2moP9y8DkLYvQt7lktmYWNcYBs1PcgTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgAlmGOq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4678664e22fso39287531cf.2;
        Mon, 23 Dec 2024 11:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734983692; x=1735588492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCYHOdpxlngzw9mxp4CN6soXHAy3g4DMK4GbjfV46I0=;
        b=RgAlmGOqQDq7Qtsesem8ux4Qup8/wl2YPcgqTgkMJMjS8OOqtf8ZWAlc0Id0FyN8iD
         osdt1fyQa4Ihve7EbFn4PXBPawifEWqEq9YzgAzWQxEAwKZjGf3pOQQu4b3hdkLpVeE8
         gzmENGciUud2PeJq6VANWknW+CP4L+RsLuOXoyckwFJpC7ceMu2sxdiWvqLhETzmFY+L
         eUqhc4vBrq+jglgcNFmabjtkgTSzD/MX6+XwZvM6tQ8JFaTmNfM6tQWZIaEp3356IEBv
         4pM2ZNCJT1v6UWvj/hXbOLGXwxW0VTNjrhym/4inK3HYjo++FAUWrejP4OHUgBn6mw82
         1URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734983692; x=1735588492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCYHOdpxlngzw9mxp4CN6soXHAy3g4DMK4GbjfV46I0=;
        b=wLkrN5xZWkZiJJjDCpoRiac0ZFY38A7EUmL+7zywvz48TejDcFxmOZIkj+KHwzqUh4
         fuV/U0UxMFnMbSpmaT9pyOES1PlqjLs9bDrVlsqAvjnSIxhKKTB/r7HbN6TDkpMuvEJD
         Uzv4XlemJqzvI/jlz1QSUkV9HAw5BhoOYK9ZarQcIK5Rz6nYS/ptu1tQQQYoX3X8kV80
         hHM3w5dXxcGT8GYoXVYwbJOhpbIXWcwG6MiEjcdXou6xSZWiQKEtvvZsjhsLXEwgmj00
         aI32SFk7/WMpyvPirFTi7wxQrA7TUwl3TG6JKPPrlp1SLAvd4gz7toFEu+XhNZP9/76z
         GJqw==
X-Forwarded-Encrypted: i=1; AJvYcCUINKeECruNNWwlxZEDgaOianG3yi2WUCs5a/5EShAglcfJqzaVfhR0wOdSLArawk/F4lHXyos/Yp8P@vger.kernel.org, AJvYcCWNCdRdyjxPMtZ5f1pbsd2Gn7NF2y6L5727aOAbG+jBi/NCZyYhMoTOfICUaakzXYvfLFsUMuOb4XY1zh4T@vger.kernel.org, AJvYcCX8n8mbBGqXFzOzCcmZoSEMA20D5yNRP5ATDJhd1c5XAftGCxlZcwPPOzVihZsQPLIxMbd36Q287mI4@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjIU3YscDlaIrCfpPNYmc3JKkXRKAjcGNv6G9bCxqHELD79zO
	1z4yJMDAFkqHTY3blwkNRDj/9xVEQdFiHyTI7nWnxZk8h3tV7OyR
X-Gm-Gg: ASbGncvtI6e0rtRyHvFNoJqCbVTB2qmTUFkcLWwtjGzSr0iQ8t921ypow3vhX9SHUqz
	L5ovSy5a1kOS+QmQRigK9+Fg8TVc0atl6od+qMlxpiLU/o+sseNmBt72YZkRGj9UTuUT3fIQc02
	YleOwA+0uO1NmJ6PK63oRSvcgkyg0ssYaGOX8M+B8bHzT8easGqGqgbmRbpc5z/jpFWBaARhMwE
	nxIEGtaj4cfkBteHQAGZsfa4OWePkRkRWT0LU8gJSnskr1ZaVc9lx/97Q==
X-Google-Smtp-Source: AGHT+IG4MNY1QQyKOzMsb54VgP1U4hyPjs7QpeTc+3qPpe4RCySf1QJcK81jon+MynXP+4NYu0aFyQ==
X-Received: by 2002:ac8:584e:0:b0:467:4fc5:9d72 with SMTP id d75a77b69052e-46a4a976e18mr228443071cf.36.1734983691988;
        Mon, 23 Dec 2024 11:54:51 -0800 (PST)
Received: from VM-Arch ([2600:1001:b151:a20a:c825:7073:d6bf:fa14])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e688cd3sm46567501cf.36.2024.12.23.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 11:54:51 -0800 (PST)
Date: Mon, 23 Dec 2024 14:50:53 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jagathjog1996@gmail.com, trabarni@gmail.com, danila@jiaxyga.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: imu: bmi270: add boolean type
 for drive-open-drain
Message-ID: <uqn4jpowzqhchthn3i2fpg7j52c7y67gawg5ausrt5j3cemq52@c3l54jktq2wv>
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

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>

