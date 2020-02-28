Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E184C173616
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1LdT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 06:33:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33454 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgB1LdS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Feb 2020 06:33:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id c62so1446088edf.0;
        Fri, 28 Feb 2020 03:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nnPLD2kwXHtOQ0PS3CP4V1/yZI3WoezcfPgFUZcg6R4=;
        b=KF2kxJza+AkIGArL3ACdkNQp+bRjWFAIdwHP0aJK+NYDV18pW1OK6shGOegXiwYHTJ
         EVjFRFwJ9kI+UHcRBwrC16Jk4EnWw37n6/cuImqD6Ziq0TZz4sAFKH7TZEV817dSB9ci
         8EHDgW4iC2b6zuatm3/H7da+1alQ+qjjisS1IqLamBUx+hMM7DVe+e2jvdhnhnEd10Ii
         HHDyf+4aLN4ONeMHrxWRSmX1A/veLEt5K9zrJ3tWEcZCCdjXT0/0nvTyE8VnmH2A5TLC
         nH5fgqZoFOq+UJMF1E0FEnzMqH5QCW/8Eu/Y3b+7SgzNQdUZhhd+4Tuhd5OwfNFJz62i
         4efw==
X-Gm-Message-State: APjAAAWLSwNCvt7TnkohkgtyQhV7EZjufiFzW3hTXO2ANJzUM8G9+spu
        M/aVlRulgFpwfSZxrYWcneg=
X-Google-Smtp-Source: APXvYqzx46SGHanL4lMm5q8SuA/FB6FbkYrdqwJkUQducRP6B+eYR5HKx0olozo5cmyHe8LviKHDjg==
X-Received: by 2002:a17:906:ccc2:: with SMTP id ot2mr3674182ejb.194.1582889597424;
        Fri, 28 Feb 2020 03:33:17 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id x13sm353864ejs.27.2020.02.28.03.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:33:16 -0800 (PST)
Date:   Fri, 28 Feb 2020 12:33:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: exynos: Silence warning about regulators
 during deferred probe
Message-ID: <20200228113314.GE9458@pi3>
References: <CGME20200228092134eucas1p226ebb0e76f2a6c82b62489ae3a0379bd@eucas1p2.samsung.com>
 <20200228092121.15918-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228092121.15918-1-m.szyprowski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 28, 2020 at 10:21:21AM +0100, Marek Szyprowski wrote:
> Don't confuse user with meaningless warning about the failure in getting
> regulators in case of deferred probe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

