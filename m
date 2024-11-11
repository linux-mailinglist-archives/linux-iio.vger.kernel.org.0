Return-Path: <linux-iio+bounces-12156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9429C45BF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626AC1F22ADD
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF11AA790;
	Mon, 11 Nov 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWBp5pjE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964491A9B3E;
	Mon, 11 Nov 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352975; cv=none; b=CP2suC2ssT2MEAJdc4H8glsScWCGeyHi9AiPrBN8+Hy/KgCHZllim6fYYwMrbSQPgn2iLMGSXvZNL69oB/2wo6j73ozJ6prqCRlnQ7YhhjbSy1hOc2I21Sw0pcAo7f1hGysmpBx+UBX3Lnku2fpD0pyWcnTHeM13TT3wC7cdx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352975; c=relaxed/simple;
	bh=/nmLjHtfpdNdhGIZlqXYWtJccSFVnju/0KheTIMKdy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9rg4N4v4jedMIeuFm0q3JsI7Y3cqQk2tvahsgyMog7NBAgdjw0HeQsO6LZpxPBycbquRmKX0niGrvCv1+a657JWXa1maP6r7bWOkIlfDfaR4eQcevEkJYBmsDjc/HLXKZ8Pq9OeQHqR+Yr+OroNJVE0mKSSzdYWl66qBE8cpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWBp5pjE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2689e7a941fso2859353fac.3;
        Mon, 11 Nov 2024 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731352972; x=1731957772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+f3u/Hy7ggU6TYper9ScR7UkjM6HPFZfTcg01Knz8Q=;
        b=MWBp5pjEDX0z6R6gKrSx+n+WJysNzvZdSD5jomu9QC/nrLgNc6Yn40goGUJOHH6gxI
         SoVF1xkVpKH6Ab0Wbf5YQ+Pz7HyskLfWc6x/aqD7BrO0E1+KQ9xLwbIXnhHSF7JlShcO
         ppgv4ugUxQvVCVvp+z4HI0bdllTgHJTfXQEZAPN5faPO4hG2eaas1Q3Z8intcvS4+Kqd
         whJeJmRpKAnaHs7iEpyrlJbDXRpWLkjdmWYtyBQqSnXBOiwSKdYxTmu9uszzDN3OOlZ1
         4lB3vYODd5CY5GHCPZC72r1iMzbc9sR5sNfQTW/iCtgrQ8fDjx/3r7GzylUpDwvDBhVF
         0WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352972; x=1731957772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+f3u/Hy7ggU6TYper9ScR7UkjM6HPFZfTcg01Knz8Q=;
        b=LaatmhJjb0f6fyBKmCZ8qw5tv8SzjAmcHkPK5w123MM9ldekVI85KuwBIJPxkLE2zl
         kpj0b8Z6GvsD9VC9vSq1SzscihQl2lR0hPo5aPAkgr+S5ALkthuXw/81bSF7EAWtuE+O
         dGZg3Qo1XGkPVMZuYCdSJRF5BIqv6vk4TIuAycCODfoKAl/kre9sBtlSY7Q8wTyFiMqw
         9zR3MFeGNATXYtYQAwZLC1kzh7Cx7GdcxfpOirL2Tmg1CyFXLmoQ9/e+85fcLkFtjNtp
         egII6OeD5jTHvf4rdyANLSKFhMJWg9+GC/lO76MVZgQv9qUn5TecIlyq88BJTXwyZa9h
         Nmmw==
X-Forwarded-Encrypted: i=1; AJvYcCV0lMg4TlB7mSAADCuZMzhUKpOVRmLLwCgcg89BhzX/nKXSxLpL0f6DlE3LwlwQLemVTZB+9t4s7KNp8OLv@vger.kernel.org, AJvYcCWevtMLEyh4c89PitllXUiVcqxioGCic1Ns/6XO6hfT31hXJbs6CxAzcn5NEzD8rFDPALtfkOOtnB0x@vger.kernel.org, AJvYcCXC35N4yFQmer8annKcq/R2fwiycacrS/21RPjecC5bpmH79nYbkIqE6xvEiCH43wrl2nZ/Uvh8r0bw@vger.kernel.org, AJvYcCXS3Yh3o5VZq7+rfPV2mStbT0cXiN+CY3p879M8ldaduvdWB7wyTGUyse/BjraITvuCVIOJn3KJoybbngY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3C+rn1k91dwJ4X/O81Y6KvzmxoHq4NxO1C0/MuGl2uhHUt73O
	9w68IraLTMIN9+Uqx2oRiaNn7CAPtwvQS4Ax6D5HKBeM3p30ic25
X-Google-Smtp-Source: AGHT+IG2nHO+Bg1rkJrf7qfukU+vp9KRWNaZefDaFklMRxL7gpN5i3aVFdozoWQvKm9ndIshve7DYA==
X-Received: by 2002:a05:6870:d110:b0:287:3cf8:4abe with SMTP id 586e51a60fabf-29560099278mr11079889fac.18.1731352972553;
        Mon, 11 Nov 2024 11:22:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644036sm8879120a12.66.2024.11.11.11.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 11:22:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Nov 2024 11:22:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085
 compatible string
Message-ID: <afbd8490-f5bb-4ca3-8da0-aa1f01de5efa@roeck-us.net>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
 <20241111-p3t1085-v3-1-bff511550aad@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-p3t1085-v3-1-bff511550aad@nxp.com>

On Mon, Nov 11, 2024 at 12:31:58PM -0500, Frank Li wrote:
> The register layout of P3T1085 is the same as ti,tmp108. Add compatible
> string nxp,p3t1085 for it. The difference of P3T1085 is support I3C.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied.

Thanks,
Guenter

