Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2178443408F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 23:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJSV2G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 17:28:06 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:38477 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJSV2G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 17:28:06 -0400
Received: by mail-oo1-f44.google.com with SMTP id i1-20020a4ab241000000b002b7069d0e88so1305392ooo.5;
        Tue, 19 Oct 2021 14:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4QGCRdX9SjNn6umibiI17S3YVWzeQe66bcgeT/MBg0=;
        b=3+ui9SVLL0Ngq/4a0TUvM0ltdmnWX7gXyZgFJZGs67T6CnLyd6BMGN3zPSPuDKEWye
         5ddX9iSnxEvoYcT/uJDL8MvqntJI3pRCjj1HWfdf6orKzfdJiEq2tcEfwKUdBDBoyn5S
         e+nq6npW4ceQ6yaS0jWj3AmvIoU1pPH1mrcLKc6x/L1u1ITnXMt+wxrpKBdYYlv9/pWh
         yhNw0Aze9pp4fIxJmncHV0LFJ0e3iLEEmH72CL6E4+Kl6qQwx9uVyGp6ykQKS3YP6b+m
         VYtD9/TgFDBspXALpx18ekLUntOJ7X7ijhgxpMkdG0Paep8I2k74TP+Q1SDuyouDlQ5B
         /2PQ==
X-Gm-Message-State: AOAM532ZnXrX9kw9Yt1U1AdZNLzwRhOFmPCD3pUZ9mlJg63SHzp+4hwx
        NB5vmrlZO6f6Q3bUb3CuRg==
X-Google-Smtp-Source: ABdhPJzKXvMMBePx1sIR5a+7CW+7veQ9w3ZHWmbKY+HLIJm7xztuG/bxio/ljKQqy0lJyl4GpQUpvw==
X-Received: by 2002:a4a:6852:: with SMTP id a18mr6598176oof.92.1634678752909;
        Tue, 19 Oct 2021 14:25:52 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-67-78-118-34.sw.biz.rr.com. [67.78.118.34])
        by smtp.gmail.com with ESMTPSA id t5sm53631oic.4.2021.10.19.14.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:25:52 -0700 (PDT)
Received: (nullmailer pid 867885 invoked by uid 1000);
        Tue, 19 Oct 2021 21:25:49 -0000
Date:   Tue, 19 Oct 2021 16:25:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, kernel@axis.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/3] dt-bindings: iio: io-channel-mux: allow duplicate
 channel, labels
Message-ID: <YW833Ty3IwyBrKD3@robh.at.kernel.org>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com>
 <815d858d-3c67-c184-2413-9d6b487a853e@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815d858d-3c67-c184-2413-9d6b487a853e@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 09 Oct 2021 00:11:30 +0200, Peter Rosin wrote:
> This is needed since an empty channel label is used to indicate an
> unused channel, and there can be more that one of those.
> 
> Fixes the following problem reported by dtbs_check:
> envelope-detector-mux: channels: ['', '', 'sync-1', 'in', 'out', 'sync-2', 'sys-reg', 'ana-reg'] has non-unique elements
> 	arch/arm/boot/dts/at91-tse850-3.dt.yaml
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
