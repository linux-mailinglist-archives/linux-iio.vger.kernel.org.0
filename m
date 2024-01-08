Return-Path: <linux-iio+bounces-1476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 222508268FC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 08:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74C51F212F3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B98C18;
	Mon,  8 Jan 2024 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1UDgTSn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D758F47
	for <linux-iio@vger.kernel.org>; Mon,  8 Jan 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33678156e27so1569721f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jan 2024 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704700566; x=1705305366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJNILWAfFW1RwsyUiMbUTUb3w1uu4P5ooAtXH7+Yq+Q=;
        b=i1UDgTSn0yq0DMf1XaGSbrrlV3k/m1a7sBNMM5EJdFdFEi2ZCRaHKUrx1BtBlGrxki
         QboTEJBszj8RN5R5fbfjQWGxnbBiKQkcTNPIHqBW3nefGsSIaFLRZCO9Kpp5VRhVl2nd
         WDFruFoM2AwygdvCQbBQatZT2ZC+L4xX12v0n2nZcUmJVFpgLkd/aDV1gszEFpQAWuyR
         ueRn5Pywd/ojtlcT3UzkpksXyKa9VHSkiLY6UO+dXmVWoB74ukUJWUr7SAqIly5pNl9r
         ZQPMEpvnZqleosiPuV6B7ib/cSs6DHJcvo+kahkPME6ebQ6XuJkexMQ2V4Q597/HPZQD
         6CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704700566; x=1705305366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJNILWAfFW1RwsyUiMbUTUb3w1uu4P5ooAtXH7+Yq+Q=;
        b=J3g4MAeGOwLu0OKhxY8idY6/MvQzizZf0CdvMna4H+IFG0zLPaLkZuvDeBZvrx2ZiL
         lrBX9HXpaVdtUXJ2MNnzqDooyvl7IGkm63YZH7Oa26/44LzLjmKQv5fUfmZYSO9xzNye
         TlFT+zWiyLGUQH1CGl63FUjbvh8ADR3je+qo8VWCMKgjQjla6AsJZO2YKOOp0KL1JccT
         fRGGd8q4jMC6C+3PjhIJGXb7rR+Of0BwtRU9rbzdziQUR3KsV4xR/Q7IsAss/xV8I+Q1
         eRrVjsFj5D3ysJoDkSb5bMgATdRfdnynJ0gE3jTcgl9w2NsYfC8nUJrgg4giIcrQg27J
         4GcA==
X-Gm-Message-State: AOJu0Ywbl2Yi/4Gw0XKKrrza20S1BD+9OubH+vBlq3418kVQ3Mopp4Ga
	3r1oHYn7mN6/crfszty4WXEIogQoFBugK1UKvMHE5O25FRw=
X-Google-Smtp-Source: AGHT+IFVZq+5aEwpT+kqCH37EVM0iXm3wHL9fyHq4kAbvJk7Xn3+K76StTQwO+n8lbmc0Ib8MlmElg==
X-Received: by 2002:a05:6000:144d:b0:337:69e9:4554 with SMTP id v13-20020a056000144d00b0033769e94554mr536596wrx.137.1704700565838;
        Sun, 07 Jan 2024 23:56:05 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b00336898daceasm7067471wri.96.2024.01.07.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:56:05 -0800 (PST)
Date: Mon, 8 Jan 2024 10:56:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: correct file entry for AD7091R
Message-ID: <d537ca6c-180c-4f35-8441-adea03095689@moroto.mountain>
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

On Sat, Jan 06, 2024 at 12:08:35PM -0800, Amit Dhingra wrote:
> File entry has driver/iio/adc two times. Fix the file entry
> 
> Found by ./scripts/get_maintainer.pl --self-test=patterns
> 
> Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
> ---
> Patch based on jic23/iio.git:togreg branch
> 
> I don't think fixes applies here since its not in the mainline yet.
> 

Generally, patches to MAINTAINERS don't need Fixes tags.

It doesn't matter if the patch is in mainline or not.  If it's in a tree
which is rebased then maintainers will fold the fix into the original
commit and the Fixes tag will be lost.  But that's fine.

Also when you're using a Fixes tag, it should all go one one line.
Don't line wrap it at 75 characters.  Just go over the limit.  That's
the normal/correct way.

regards,
dan carpenter


