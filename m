Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF2C921D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfJBTOU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 15:14:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34414 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfJBTOT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 15:14:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so173527qta.1;
        Wed, 02 Oct 2019 12:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2Iujt6utKy1YqvDaOzRyEiWOuWyqkgmuunfJJxqP/c=;
        b=m8mtQ7y+aax+Zi0svuJCQIT4+uageKkQJYo+sq1d2gCSdoW7vFdGK9tL4G4izH86+R
         0cRBrVtXayxjoF7aUQ5JwIz+FiWdpjFAsz+sAoEpz01eshyEhQEPMICgfqs2a0yrSUB9
         0T0D60etPEhhfT9cvzMyWOXvea/exSi8UPVP/PuN1hYjcDqAnPwkSMAJn242RHATgybq
         JsH9AMrjqzAaiJ3JbOy1nea8q03wAnSKB0YDzJRelBisE9fFs4H5MHECLF0dtRtuTg3U
         xsMFD33KCTSmlMQj8LMjXjAimUF4U446HTXy2oPjBHgG6FdAM/YpxyHl+FKJtxjE+ZgH
         3tzg==
X-Gm-Message-State: APjAAAX94aSbuBPP1DwJaJ6MG0KW1ik7/c+G5UdPRy3/egECj6Aps80A
        Ev5z3Nt5lY8QmupTT0gtBw==
X-Google-Smtp-Source: APXvYqwOOLw4bdAhjl5pUY68J9aiYtVdCYsO3X6ldrlqK7OrIiOxvVYWH+3db17LNEYZc8c7JK3lfw==
X-Received: by 2002:a0c:a8c5:: with SMTP id h5mr4714962qvc.180.1570043657731;
        Wed, 02 Oct 2019 12:14:17 -0700 (PDT)
Received: from localhost ([132.205.229.212])
        by smtp.gmail.com with ESMTPSA id c14sm83853qta.80.2019.10.02.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:14:17 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:14:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad7192: Fix Regulator Properties
Message-ID: <20191002191416.GA17605@bogus>
References: <20191002144542.114722-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002144542.114722-1-mripard@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Oct 2019 16:45:41 +0200, Maxime Ripard wrote:
> The AD7192 binding describes two regulator properties, avdd-supply and
> dvdd-supply, but describes it as a constant string that must be avdd and
> dvdd. This is wrong since a *-supply property is actually a phandle, and
> results in warnings when the example is validated (or any device tree using
> that device, for that matter).
> 
> Let's remove that requirement.
> 
> Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 

Applied, thanks.

Rob
