Return-Path: <linux-iio+bounces-923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D040A8132BC
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 15:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70683B21513
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C059E31;
	Thu, 14 Dec 2023 14:16:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A534C9C;
	Thu, 14 Dec 2023 06:16:02 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so991096b6e.2;
        Thu, 14 Dec 2023 06:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563362; x=1703168162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMTq5pMAaDOJYQEmGWHKZ8Rcvl+M1avRt4eHZ4R2vog=;
        b=LQVBX+IUq4qsycadv4NHM2QvFsjms4/ymgV71sfW8FC1p3QquVbS32oI5MsNiT3+3+
         FMPzwMaDptsB6A8gQXUGdStql+GM1z4v8RoUpov/XJLq2N3OR6mWSm4iVc6DiAzRhcgj
         0bip0VzWudwbGOUsrTuf2vYvaALG2lPRhW5jnbtb4/Y/xg2P9G1vzs0eJoNRRYbWZTZs
         cbiW9eBPkuA5Umf1S+IxNLkGqGpK+ik6nb+acoeJ/8v98oEAGrsEi6lyi2IdExP+rFOZ
         yYX+Rp5prN4E/HeTCmZeBQj732lNjFahyqtVRYchHBgIjbidt1OhznlqHC5eDFaoFU0s
         w5Ag==
X-Gm-Message-State: AOJu0Yzkk81G5n+9R/uR1Lf98xJ2I/j09YQybK9lWGAi4yHNSYgh2D/q
	NdHCKJybVvo62cxxn8QC6w==
X-Google-Smtp-Source: AGHT+IFCKUZM61QqCWtOMvFPejA9INlIXYajdO7i5gIK1gxqeJCH0JI3HLFUbTt/gG1nITmzT25dGw==
X-Received: by 2002:a05:6808:2201:b0:3b8:63aa:826f with SMTP id bd1-20020a056808220100b003b863aa826fmr14850983oib.25.1702563361881;
        Thu, 14 Dec 2023 06:16:01 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bq1-20020a05680823c100b003a7a34a4ed8sm3362994oib.33.2023.12.14.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:16:01 -0800 (PST)
Received: (nullmailer pid 233694 invoked by uid 1000);
	Thu, 14 Dec 2023 14:16:00 -0000
Date: Thu, 14 Dec 2023 08:16:00 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
Message-ID: <20231214141600.GA224419-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>

On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote:
> v1:
>  https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
> 
> v2:
>  https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e1@analog.com
> 
> Changes in v3:
> - Patch 1:
>  * Use proposed generic schema [1]. Also make it a required property;
>  * Improved the commit message.
> - Patch 2:
>  * Improved commit message.
> - Patch 4:
>  * Namespace all IIO DMAENGINE buffer exports;
>  * Removed unrelated new line removal change.
> - Patch 5:
>  * Namespace all IIO backend exports.
> - Patch 6:
>  * Set backend.h in alphabetical order;
>  * Import IIO backend namespace.
> - Patch 7:
>  * Don't depend on OF in kbuild anymore;
>  * Import IIO backend namespace.
> 
> For the bindings patches, I tried not to enter into much details about
> the IIO framework as I think specifics of the implementation don't care
> from the bindings perspective. Hopefully the commit messages are good
> enough.
> 
> I'm also aware that patch 1 is not backward compatible but we are
> anyways doing it on the driver side (and on the driver the property is
> indeed required). Anyways, just let me know if making the property
> required is not acceptable (I'm fairly confident no one was using the
> upstream version of the driver and so validating devicetrees for it). 
> 
> Keeping the block diagram in v3's cover so we don't have to follow links
> to check the one of the typicals setups. 
> 
>                                            -------------------------------------------------------
>  ------------------                        | -----------         ------------      -------  FPGA |
>  |     ADC        |------------------------| | AXI ADC |---------| DMA CORE |------| RAM |       |
>  | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|          |------|     |       |
>  |                |------------------------| -----------         ------------      -------       |
>  ------------------                        -------------------------------------------------------

Why doesn't axi-adc just have an io-channels property to adc? It's the 
opposite direction for the link, but it seems more logical to me that 
axi-adc depends on adc rather than the other way around.

And if there's another consumer in the chain, then a node could 
certainly be both an io-channels consumer and producer.

The architecture of the drivers seems odd to me. It looks similar to 
making a phy driver handle all the state and protocol with the host 
controller being a backend.

Rob

