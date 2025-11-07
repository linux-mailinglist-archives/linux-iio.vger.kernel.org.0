Return-Path: <linux-iio+bounces-26002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B49C3E224
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 02:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBAC84E48CA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667D2EE608;
	Fri,  7 Nov 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfjFUcUX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE12E5405
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479157; cv=none; b=XiC7BnIjJkf2ON+g006DkhmDMT9jasQ+75UpWb5+shG1XqtoMSBpWGn2Vsf7J15zE3Nl0g2cOLfmzmKl2O7U2WH1ry1hbYItN5SvwFfHYKt41qyRSbfJ4nGFhs89+dO4SuKtF5AxP0KrAZIu7CkWuy2Xui+qhzYq+emz3YSnw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479157; c=relaxed/simple;
	bh=/Rc1S3UgMB9WnXm0w2Pdmn1pVdbwQaIgK4COQB6l498=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUyby3Y3rSYZCwssCctFNRav6y/b/rT4U4NXS9qwebiO1Va6Aqlyxv7jKfkw6FV9ydnnbh7SwCYaFt/u+tmvdVqctXhaHiH21yI6IvQD2UEt9IfUvI99eqPRX0pshWik6IE2+mAJy9/E4X/Y6lSQpfskIYHdOOLR+GocwUXCNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfjFUcUX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2956d816c10so2686965ad.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 17:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479156; x=1763083956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4bXmwmarcggMBeI4uAlHgK7+FsvVPN4ytmfUmRpIcI=;
        b=GfjFUcUXJd2gWMs90LeppObIEwcdOlGjp7EWLi4Oi4QpoM54blbQPs+Pn96ItAcawi
         Pv4PzO4iDMzP8ncFDqPewP0VxgM1cCs5/ZCpCvEmEDw0gPLZU6bsgiqxO/DvSIjC1G5z
         4HPW0BSRAAWAbmrf6MjR0q8rpNjwDwDe5184Ng/wB8LhT+foN9dOkmtUq8NXegTPd1Ih
         iru9b+9optPDlgu1z0AEjjzlSIHm6cF6alzfpfxXH8wj7+sZfVAIxDljW/9ITdvVg+ZL
         ClulIE8Q8G0VUgi5tPL0BjNYkcTs6RC00YkKI/C6tVdACOvOw3a7LiCc0pHUlfUmsSI/
         +3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479156; x=1763083956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4bXmwmarcggMBeI4uAlHgK7+FsvVPN4ytmfUmRpIcI=;
        b=wUPZn+rC6D8r98UrW1ImCBvnhtfOPWASD1oq8sUmiCaXc4BjW561zVOq7srqIpb5ra
         lUoFfO8GfxpzQzaaxWNlOzF7VEqEvZ53lygJ/viTw2Yar4YGLSsBrJ3TAvAGvZOBMPg0
         nnft4G/+fWP9UsZs9A+dgn7ofVpeE4zLpvWCusg3g4Qz7xhLCJ7MxxKU4aecvGrNguDe
         i3PsfsgrzI5xknH8BmoA008b37fqBVODmeVt/C2pqpKHDmGDV0S6p5gutVRzA2whhfxX
         CE9jJHoVx/0PO166sn6DCxvsb60o1T/MLOYLsSNSLeSZImaq9fT4A23bS8prpGcLcD2Y
         vQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWJO+dkdHNs/awyFbpQijRgGsaMVLsMF9ql+0R8H4+w3mzRZK0Go4FaarBNfv+U1Sxp2b5KRR1VOp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/WhYF8MzeQcYXN5UUhb/4RIFRO+UPUHhSuBmIx7b59YCXgv3
	L3LeudHcKsYVzzgY0exCAvqVjNMVE0RuU0FhI6Pb4Peut6ZpALmdLERr
X-Gm-Gg: ASbGncsHokmoRlRawI6FG2I8ceLE0WB1imCUUNXfMOzVvvXUZncmruyzG3hSug3lXoi
	GcTdKi738oH7a6hY0M6xWrjQtjoTWJlTNv7+7h7BtRppyXmQlIaxj4hG33jSweB3VphmgRDrHdS
	OTWMcfrn3JO2f6uUbYa2yPrgLIz7H1Mieq2Ta8k5q7pSsMz6JbymvQXFZhUaCt1sVEOl3Czfflz
	yBXaL/ft99S+F2myKFlS/yOkDUwkNrtxDqYINPUlmoJpiV38MCNAOCj2FEpwRskRvWHRb5OYJQn
	WCpt2qLhoDIocIpaAvOzrB0JyDx8xvxzjbrcOqc4Ub4XIJKoAH4JCKd6WsOK9WIl27DiSNBOsfG
	zZowJIg0qHEiRLIQN4Pnv9ILGOHMDJ7TKUKEKC5LY0PAixYlfWICrt8gZFaQCNqwG9/rNlo+Nph
	Xo1xyjH4q9O3tjCj5URt7A
X-Google-Smtp-Source: AGHT+IEuOb6MZ6uwRqxv2u8kDKX7WSQVhjNXmCgCvwECDb39/Us2vO+phB5ffphUcz+ot/sBsdLRfg==
X-Received: by 2002:a17:903:f8c:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-297c03ad419mr21806625ad.14.1762479155584;
        Thu, 06 Nov 2025 17:32:35 -0800 (PST)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29651ca4257sm41496575ad.95.2025.11.06.17.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:32:34 -0800 (PST)
Date: Thu, 6 Nov 2025 22:33:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve
 pressure data
Message-ID: <aQ1MfTu24hhk-dKP@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105095615.4310-2-apokusinski01@gmail.com>

On 11/05, Antoni Pokusinski wrote:
> The pressure measurement result is arranged as 20-bit unsigned value
> residing in three 8-bit registers. Hence, it can be retrieved using
> get_unaligned_be24 and by applying 4-bit shift.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
...
>  
> -		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> +		*val = get_unaligned_be24(tmp) >> 4;
hmm, now the number of bits shifted is dissociated from the channel characteristics.
We can do
		*val = get_unaligned_be24(tmp) >> (24 - chan->scan_type.realbits);
or maybe
		*val = get_unaligned_be24(tmp) >> (sizeof(tmp) - chan->scan_type.realbits);
but it starts becoming too long IMO. Even longer if `tmp` gets a more meaningful
name. Ah well, any of the three forms should work the same at the end of day so
no strong opinion.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

>  		return IIO_VAL_INT;
>  	}
>  	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
> -- 
> 2.25.1
> 

