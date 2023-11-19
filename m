Return-Path: <linux-iio+bounces-164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5BA7F0692
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C55D1F22058
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79211C94;
	Sun, 19 Nov 2023 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E0C4;
	Sun, 19 Nov 2023 05:49:43 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b6ce6fac81so2331799b6e.1;
        Sun, 19 Nov 2023 05:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700401782; x=1701006582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea1nL2nPexAtRKPgqXuGpzPO5QHlIHi+M6o+KnmRKRU=;
        b=tcALYVDifEX4gTM1hXLEcOsvOdsaPOvwuJXAPbZCoAQ5ies15q+gdll/NWCcMAsT7o
         wRoYj9QtULjBN0myplDayp6m5XkoltMxj1aZhbB9acCE8STlL/YFWaB8NTZtl6nXnhqp
         SiSgA9Gr8fPVpqSyHI03wE2TrLJuBNTd5JldvFEkGC8MtbcbzKjCsxrHc3BC6kczq2hQ
         HRlDaZELzJ2+KHyfjc5KBTFSPmmYg7mPiG6ExZeD86vXj8DvDrSWyEpV7scOql03DEEa
         50ZrbT9tg0Hfy5kr0XbiBsZ8z4DtvM+2g/23kyfxMqZVCF53UZStfbSIvnYAbvpNNeGf
         RFyQ==
X-Gm-Message-State: AOJu0YxlDFr1+Vypvi61sSy1++D3UUX9C3WwKtMIP0qdZkzj8KtuxO62
	/TzUAMT1t8NvZTGdk1YJeA==
X-Google-Smtp-Source: AGHT+IGxVkAxDv26Ud8aWhrf5vJNXccASuADchAxq+oMG+km9HHX6JHB8u48ZRVIHJQaYC1FS1BOuw==
X-Received: by 2002:aca:1005:0:b0:3b3:e64e:e0a4 with SMTP id 5-20020aca1005000000b003b3e64ee0a4mr6236212oiq.54.1700401782352;
        Sun, 19 Nov 2023 05:49:42 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id z21-20020a544595000000b003a9ba396d62sm968588oib.36.2023.11.19.05.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:49:41 -0800 (PST)
Received: (nullmailer pid 9867 invoked by uid 1000);
	Sun, 19 Nov 2023 13:49:39 -0000
Date: Sun, 19 Nov 2023 07:49:39 -0600
From: Rob Herring <robh@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel-mentees@lists.linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <20231119134939.GA8784-robh@kernel.org>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117192305.17612-1-petre.rodan@subdimension.ro>

On Fri, Nov 17, 2023 at 09:22:57PM +0200, Petre Rodan wrote:
> Adds binding for digital Honeywell TruStability HSC and SSC series pressure 
> and temperature sensors.
> 
> Datasheet:
>  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
>  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> 
> Changes for v2:
> - Removed redundant quotations reported by robh's bot
> - Fixed yamllint warnings
> 
> I'm failing to run 'make DT_CHECKER_FLAGS=-m dt_binding_check' due to
> python errors and exceptions

What exceptions?


