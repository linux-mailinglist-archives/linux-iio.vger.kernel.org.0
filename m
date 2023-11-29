Return-Path: <linux-iio+bounces-494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA97FD9C4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C44B281FEC
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11E20308;
	Wed, 29 Nov 2023 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76EC130;
	Wed, 29 Nov 2023 06:40:46 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d7e6df999fso4108684a34.1;
        Wed, 29 Nov 2023 06:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268846; x=1701873646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO94KdlO8mVlN8Xbd3EfX+TnJ2prZZJzJhNbB54uzYo=;
        b=vhd5JaDkeSGTvczd6daURFTnzoq/h/iApM24CGkedhN4e0hlG6nSreGKhAwOiFMZgZ
         4tAiNrHa9ierrwCimtXPLVV6jzn908IODNEC90RMI1pksr4qm5n562/gkPpE2oW94tTP
         MMbEV1gYNQhvjg5tqNk0aEYZDsmmAag4DDNimXCXuQwZb2CdxLTyNscLKXdFOWiXi98T
         2Xz7oHd7SMQYkNKc4vnZHLSdTlq49pnOT7YeQrV5wDzEkTC5BEGiComHtvKBajCnVhIU
         XCdoZl9GUhaeZeQnMu/bYV0j4NHUBk582NAsyYxGFi6oMhcnhkJyBAHYC31oixZj30y3
         uOAw==
X-Gm-Message-State: AOJu0YxculQSGCvo/yCxWe/fGLlxKxR4ieInmGs4R3tLKnsaoR5KyHni
	+g8WClvOcBqRtdB4u5v+5g==
X-Google-Smtp-Source: AGHT+IGYvYldn7DE9VXqFB9FiYafhMdPpg0tpckV2bRzSGNRrXS4R7SnmD/3iH0hot54xLh8GfPUWA==
X-Received: by 2002:a9d:7359:0:b0:6b8:6f94:d3a2 with SMTP id l25-20020a9d7359000000b006b86f94d3a2mr19334114otk.25.1701268846012;
        Wed, 29 Nov 2023 06:40:46 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a3-20020a056830100300b006cdf9935af2sm1967422otp.53.2023.11.29.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:40:45 -0800 (PST)
Received: (nullmailer pid 2439634 invoked by uid 1000);
	Wed, 29 Nov 2023 14:40:44 -0000
Date: Wed, 29 Nov 2023 08:40:44 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel-mentees@lists.linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <20231129144044.GA2320975-robh@kernel.org>
References: <20231129070432.1437-1-petre.rodan@subdimension.ro>
 <adf1e932-a201-475e-a562-4e35954159ee@linaro.org>
 <ZWb59iEftxX6mQdJ@sunspire>
 <99e89fb4-e99e-4a0f-8058-0ef6f04d61d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e89fb4-e99e-4a0f-8058-0ef6f04d61d8@linaro.org>

On Wed, Nov 29, 2023 at 09:47:57AM +0100, Krzysztof Kozlowski wrote:
> On 29/11/2023 09:44, Petre Rodan wrote:
> > 
> > hi,
> > 
> > On Wed, Nov 29, 2023 at 09:04:17AM +0100, Krzysztof Kozlowski wrote:
> >> On 29/11/2023 08:04, Petre Rodan wrote:
> >>> Adds binding for digital Honeywell TruStability HSC and SSC series
> >>> pressure and temperature sensors.
> >>> Communication is one way. The sensor only requires 4 bytes worth of
> >>> clock pulses on both i2c and spi in order to push the data out.
> >>> The i2c address is hardcoded and depends on the part number.
> >>> There is no additional GPIO control.
> >>
> >> Your threading is broken (not existing) since v4, making it difficult to
> >> apply the patchset. Please fix it when sending v6.
> > 
> > I'm confused.
> > 
> > you mean the lack of 'In-Reply-To' and 'References' headers in the emails
> > `git send-email` is generating?
> > I've added them for v2, but was told that was a mistake [1]
> > 
> > [1] https://lore.kernel.org/lkml/20231125191915.7f1f2dc4@jic23-huawei/

The instructions there were don't thread v2 to v1. Here, we're talking 
about threading within this version.

> > 
> > I'm probably misunderstanding something.
> > also, I hope v5 is flawless enough.
> 
> No, v5 is still wrong. Patchset should be threaded. Open lore.kernel.org
> and look how patchsets are organized and how your patchset is done.
> 
> It is as simple as:
> git format-patch -v6 -2
> scripts/get_maintainers.pl
> git send-email v6*

By default, git does the right thing, but the '--thread' option could be 
changed in your config. Note both commands can do the threading. If you 
are mucking with 'In-Reply-To' then it is probably wrong.

Rob

