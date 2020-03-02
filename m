Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36D1759F4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Mar 2020 13:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgCBMEZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Mar 2020 07:04:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgCBMEZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Mar 2020 07:04:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id a132so879907wme.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2020 04:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LfwHBF+1G3/DK1Sa/fxKynvnskOyWmgOn43G66JuuXg=;
        b=fJsoGkY66Y+OGJcqLdZCFSg2SEwEJ5bMmGoYoNjlCGPFA1TJKDS5CosrXav6DjtawT
         YZQSyHU8kThF342vvA4c6n8b5oSXIfH5BzLS9T6rwV0s61QDV+vUYr/KozQ8ZKKLE8mQ
         /vR5oDePM6lxDYnfsQiZQg1fScIT0dKeLkw9rwSscm0W9j6mcX6jUvpdZ0zC9CXV+3v1
         hofXleOlfL3zDrk1tpmFkeRCXYaboRfbceNBVBugoL9w6hB/+mMHIf6UnburM8FBaOSg
         ei7g/pxeh3OkZPwnY2LoRgm/aqeqPouwI3tsmDyZZZ8xFRLAMMIAEVL5KzGuOXM6jXtP
         CR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LfwHBF+1G3/DK1Sa/fxKynvnskOyWmgOn43G66JuuXg=;
        b=ejNsiAx38I0p015EboL3bwJfs7ZhljRWphZEqNn9q8M0shoV/zQnrcfQjNvSmYah3m
         wpicn2qgVPKf3VlIOUAKcVjNK4wNaWbxpeQKc8fH3NB9qeFA35s6XaEwOeUqvudmLhmH
         gZemhmYvqkx7ffnaZanZqutZKkJ0hXnzyXdf+sIKDAnRcBnNynzBdLf3qnWDtLtxYGDP
         x46Dqh4G6jsegJ4d/jkP404zFpVtEqEIg2ULKJWTlM7ioWvC0HWIeigKKVUV1U9kPE1c
         VdX06d4hPGgN82kJZFl4x8DVEWwRhguwC1C9jho9o6oDYlVNzKZ0Xl+/E4+pAdczf9rh
         8qXw==
X-Gm-Message-State: APjAAAUzKakvxyJgonLTkRuAwSEPoWqF8XtVOHtV3Ux0sBHKV7dsOwer
        oolu4V640Wzq9Sf7LN6UXEfgMQ==
X-Google-Smtp-Source: APXvYqwY7JNdGcibXu8arbodj+Ox9DFMTorii9SxoGFb+i/waE0uuBxRdi/Lb0LYg2yCgoBDixUQvg==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr19983737wml.72.1583150663296;
        Mon, 02 Mar 2020 04:04:23 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id v8sm27192427wrw.2.2020.03.02.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:04:22 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:04:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200302120458.GY3494@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228034220.GA3510@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020, Jeff LaBundy wrote:

> Hi Lee,
> 
> On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> 
> [...]
> 
> > 
> > Well done Jeff.  Good job.
> > 
> > Applied, thanks.
> > 
> 
> Thank you for your kind words as well as your support in fleshing out this
> series.
> 
> Just to confirm, does your offer to take the remainder (once everything is
> approved) through immutable branches still stand?

Depends how quickly you can get the other drivers turned around.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
