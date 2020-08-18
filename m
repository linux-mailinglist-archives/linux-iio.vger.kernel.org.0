Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69870247C2F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRCaF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:30:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42389 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRCaE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:30:04 -0400
Received: by mail-il1-f194.google.com with SMTP id t13so16288647ile.9;
        Mon, 17 Aug 2020 19:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UVY67KTqZ9SjF/GYd5bFVf9bIgkWM38BWYiRjAUFfgA=;
        b=iherJMOwg5SytqA5JdB26F8mk/jeWeAK8g/Syss3C9PWRHWI484220UnFuHpgbVi5e
         3SHung3B35HDiAWHvi/kWRiJUqEGSJVugVrrVfzNg6+BzQ+iSED9IlMivKcGjRtHYLCB
         e5k0gKQhlMZs0ZI47jm0h+1Roous8qAKk1dr4Z3buDezQRsBsnj0JK17cxqXu5LY1OFq
         S7CxjlWArcYuXFdM8F0muLNq/9U2qJK7zBmSR1IS3fOdWEVPjIMBuJIn3LuRd4ZpwJN2
         Ij/hGxkz5SbiCB/NWwMPAyxqEhgSpMep3cTgDZGNoRyW0T8lqJWP1O9vXPFQKJQkw4Mi
         sBVg==
X-Gm-Message-State: AOAM532Ke0kbT6Minu+gfzV/JlcsLLLG2vDWD7YvNU1+63ZuTBtF4Rkn
        RsOLHGClnmWdo61EiqV7tg==
X-Google-Smtp-Source: ABdhPJzvXB2vmrUM4FLeUPJ7w3fTwSEQWfD0wsGCp0EjrofWR6YmsYV/6ZyZDo4WuqJKeCMSL75Bzw==
X-Received: by 2002:a92:dc03:: with SMTP id t3mr3641473iln.59.1597717803572;
        Mon, 17 Aug 2020 19:30:03 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id u124sm10309155iod.20.2020.08.17.19.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:30:03 -0700 (PDT)
Received: (nullmailer pid 2171526 invoked by uid 1000);
        Tue, 18 Aug 2020 02:30:00 -0000
Date:   Mon, 17 Aug 2020 20:30:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?iso-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/13] dt-bindings: iio: adc: ti,adc084s021 yaml
 conversion
Message-ID: <20200818023000.GA2171469@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-8-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200809111753.156236-8-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:47 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple conversion.
> 
> Added the #io-channel-cells optional property to allow for consumer
> bindings if appropriate on a given board.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mårten Lindahl <martenli@axis.com>
> ---
>  .../bindings/iio/adc/ti,adc084s021.yaml       | 58 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc084s021.txt        | 19 ------
>  2 files changed, 58 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
