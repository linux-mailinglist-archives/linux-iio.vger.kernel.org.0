Return-Path: <linux-iio+bounces-495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A77FDAC9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 16:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE83B2126F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685E37177;
	Wed, 29 Nov 2023 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D0A3;
	Wed, 29 Nov 2023 07:08:07 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-589d4033e84so3576825eaf.1;
        Wed, 29 Nov 2023 07:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270486; x=1701875286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI1/wzdwffaI3kyqusnZSh3mTwevHG0W8aO7PvXkZxM=;
        b=xQa+/NFfQF9/b7VBMZ2Ag27uHaBwS7l8dc6KpPd6vjpWV9foVMBW6KCS2k4QQD5jzV
         ZthedzWcDZbssGqcb5fpMr8+xpkH6Mr25coPoV7Bz6Z75U348nrE+EtHAk+Jt/izKijm
         wuQOQ9pMkxFxoY62g3W5L4n5sFdqXUd/A16JVjpND3i1DSpRYtcd9pQtCHWKaw9MmL1r
         XFqdKT6zpcrW+Vl6Ti+oZbjtRx1fJTe2+BKg5XjxBVdfmNP+rEndsnktmR1vjad2o9At
         GXKuSz03VL5gMkQsmgHV60dHuPBUHH5DsChmd2nRmXaXiMZ3IlZmZw/UDuEk86sdms45
         NfIQ==
X-Gm-Message-State: AOJu0YyVvpmEcZ3EKhhLbfqH5tS5Ptu1+9RqMTDQcn7C0tZSJ/Eebn2o
	5Z1QVeHfDLZn1QINj2BkDw==
X-Google-Smtp-Source: AGHT+IG220tKRuDUsK0m/+CIFeuym99iFmyRgi/BSxQOPcoOe72EJJ+O6aqEfhadSUOFUdB/YiUxEA==
X-Received: by 2002:a05:6820:613:b0:58d:ac91:1dd0 with SMTP id e19-20020a056820061300b0058dac911dd0mr7460361oow.9.1701270486408;
        Wed, 29 Nov 2023 07:08:06 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v5-20020a4a2445000000b0058d4805748fsm1883979oov.44.2023.11.29.07.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:08:05 -0800 (PST)
Received: (nullmailer pid 2490376 invoked by uid 1000);
	Wed, 29 Nov 2023 15:08:04 -0000
Date: Wed, 29 Nov 2023 09:08:04 -0600
From: Rob Herring <robh@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: temperature: add MLX90635 device
Message-ID: <170127048238.2490279.8887087379868217714.robh@kernel.org>
References: <cover.1701168726.git.cmo@melexis.com>
 <f8cb0afb2966540dd266da09e832eab22604347b.1701168726.git.cmo@melexis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8cb0afb2966540dd266da09e832eab22604347b.1701168726.git.cmo@melexis.com>


On Tue, 28 Nov 2023 12:02:52 +0100, Crt Mori wrote:
> Add device tree bindings for MLX90635 Infra Red contactless temperature
> sensor.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  .../iio/temperature/melexis,mlx90632.yaml     | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


