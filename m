Return-Path: <linux-iio+bounces-27178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A67CCC49F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAAA930F9C29
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF62DC77E;
	Thu, 18 Dec 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So+nO32x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C07262A
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067941; cv=none; b=WhyqjzKioOdDpfxty30ffTBs9iZmNkujKGgCuXHy8MOWlaRTKLHvSmhIGx4m5O5SWRKsgTqh8M0rC8MwOIijLDDkd49pk8MJ3fnNxktq6A3I/fUstRZ5hQE0+W+6+sYQYdzpvVrzoZe6/3XWqOYBWeJNbd6OMDERWWEX1IkFvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067941; c=relaxed/simple;
	bh=hOaZpIPU4+XxMnfRP6ushVxknuqbVC0AAepOfbfQUiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKC6qAeIl2G0ixoCzyXNtZ2TXqfslkpPrCwVbnboJxZzrm8UxVJHGgdbcauvsq6wE9T5okezQ2uJARTVtGQA8r46vm0FwfCs+GpGYNU1RhZVmg1zHfeROSvOpf4h+SEUOn3tf9XtO3ZzWJURsOgbJziZMCkqXTTJVUneuJuOQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So+nO32x; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0b4320665so9896125ad.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766067940; x=1766672740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJFttwe3pIjHyPLfagVpv1sywC4wqqLbZAgcahrnMHc=;
        b=So+nO32xT4tnOZW+DhJ95UaDrJDvmLf7dbh5S3mnp3SYeZT1r/x4d2ntaIJ+KwJqKf
         l9HoC28X+qyCBc/6cvo/mm30li0oIeYnRZK2t3W5Wezb07wWa/qMOTXugeJTe/NHeGDI
         YsncTvo7dYZsxDqovs39hx4U4CuZQEATqaHcnC0tK1Xy1LNo7eELdmlIr+rAwblE1lmb
         EhDWwevS1JZu/W7vVLAJoEvpfUhSgITOgmzGsmv9pvv0k3MXr+ChKmBrJBphiuLv97GR
         m1gy+s2QI1Rt2UCo0r9HsRcRKYGfdURtON/7C5Rtf2vzx6jEv9teQ8lIaLVqPjhsgWPz
         CCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766067940; x=1766672740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJFttwe3pIjHyPLfagVpv1sywC4wqqLbZAgcahrnMHc=;
        b=I/XT22BzgAaNdGvJNnzWGyPzkDZmQlh0dzKOQp/4KErGrqonSKUiDerqKbs+3vauW3
         H5+9RCXjZ79AzyVrLZ2uuv3/kxDKsadXc50AY7413lji/TceXw21T5wlXycJ0PUZmeAb
         /RbytCxKM5BBS26+W3mnRFha4t0zkR41JlBndxMi06kfrTsjlMf7329YMVv796yI4HgE
         Y7C8Q5ZHMwSJb683ScsndfaEklryixdYQwDoE7SsfapCPdFayuu+YVvQEvxBz9Tc7Zxn
         iHOIqWff7HQh0TBLTApMawFlwHS1bV43wZY7kzr7X8JQBAdZN+i7vach3xVbLPTIJAW7
         KYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpaWlYwdy3gpIjRn6cddu9sME+t23V5N5TRuMZrbT6LaWMwp6L2nsqQzZvq93Z6xQq11E6jMftT8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16yrG5/+UxZ0/qOKrNQTXJ59uZ/x9XbxpbmEQ5JhpsycmwH+6
	bpgGFAdaFnHwjJaMD3jKN+5+/cY8ilzW6G32S6cFN5XzunruL9gU4uox
X-Gm-Gg: AY/fxX4vn7ME/VfwVEU8zoeXmpMqInG5DorKgp+cU0PrjB9RCTdw4fxDajDy0sIFeU2
	6ZEUo3cvV2idawUr764AJVXPY6tKzndUkrHnBgmZKrEe/DKp/kCKsX1JmfxVkKhviKYhl30rUsT
	OgCK+3BCLQTumRqB5MiKJndapwXFNoLatkW1K5+VPZVUiuQGkjDel+cevxcERy0dc2HhdD4DbHl
	ui2RNkKlbfUn5IihFqOBmtTqmQInZ8Fo4asKh/36MA9Rwi9a2uaU+EqiV1WiHvPlplig/qdg58X
	n1p+MzhbMxDclaytQk14gjlh3NkjjBPbIOG1A6/A8zGuzlrbIvMVsAzRLCJxI9DLy6BTKyJSEGa
	UEfubuEJVZx93NSJ4uHLpDc5BbomFLhdlAmmtYroMJifFCQ2h12qz8GFvAHqlip4FB9HWlBQyOh
	OAUie9cxPMfXulkjiR/ig=
X-Google-Smtp-Source: AGHT+IGYRdEpECBqHBJfR3wJ5y9jJlkdT8kWACpnNRTlu0V4vK6d7wJxahfmcG1QE+eapNwLI97szw==
X-Received: by 2002:a05:7022:f904:b0:119:e56c:18a6 with SMTP id a92af1059eb24-11f34bc65bcmr13003744c88.14.1766067939535;
        Thu, 18 Dec 2025 06:25:39 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061f5412esm8783938c88.6.2025.12.18.06.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:25:37 -0800 (PST)
Date: Thu, 18 Dec 2025 11:27:18 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/5] staging: iio: ad9832: clean up whitespace
Message-ID: <aUQPRsCbB-eXHSIx@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
 <20251215190806.11003-2-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215190806.11003-2-tomasborquez13@gmail.com>

Hi Tomas,

LGTM.
One minor suggestion.

On 12/15, Tomas Borquez wrote:
> Remove unnecessary blank lines between comment sections to improve
> readability.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index e2ad3e5a7a..00813dab7c 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -26,7 +26,6 @@
>  #include "dds.h"
>  
>  /* Registers */
> -
>  #define AD9832_FREQ0LL		0x0
>  #define AD9832_FREQ0HL		0x1
>  #define AD9832_FREQ0LM		0x2
> @@ -50,7 +49,6 @@
>  #define AD9832_OUTPUT_EN	0x13

There is a blank line between AD9832_PHASE3H and AD9832_PHASE_SYM that could
also be removed, IMO.
 #define AD9832_PHASE3L		0xE
 #define AD9832_PHASE3H		0xF
-
 #define AD9832_PHASE_SYM	0x10
 #define AD9832_FREQ_SYM		0x11

>  
>  /* Command Control Bits */
> -
>  #define AD9832_CMD_PHA8BITSW	0x1

