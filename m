Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B192F6A91
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jan 2021 20:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbhANTJ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jan 2021 14:09:57 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:40833 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbhANTJ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jan 2021 14:09:56 -0500
Received: by mail-oi1-f170.google.com with SMTP id p5so7038630oif.7;
        Thu, 14 Jan 2021 11:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxtwvTqYUdmR3sbTL6//3235esukBSWsgqFWaR41Jcs=;
        b=FEe0RQp0sRVSFunciW1+Gtc8QCyxAv0w708RVp4xybAC/5aQR9s7p6Scxoww0fxDTf
         Axs8usIDcp2wQwcXDZNfVYTcQ/sLyYB6tkDO6D3YFNLbwPkuPW/GZwDhIEteCxQzdHPX
         FnsfQL/fhWJCKraXEfUuUuFMVO5e76Q8Kt8XPcj+ag+zQsF9A9rVLHcpJN/vx5mXOsk2
         Wtrq67MHH3cMKt08HK1esGWrf8vpHtAjmPYH4vCFUu6d9EgtlgorNEJTVm+nWkdwOYUO
         iAQd2D0i46IsLDmKchdHQx/vvI66BSpuwOAWP2e1MMNKxRPHMyoTk1A9Luptn22heYzt
         8X1A==
X-Gm-Message-State: AOAM530t6/HchhfL2wzst8E+KCIxwgVwluw+Cwfa04ntrSNxa7Nck6Kt
        1EbFP45ADXTI/Rnq1HDJdZtQR7Z8ug==
X-Google-Smtp-Source: ABdhPJyHVmyX4C/d8depnAY9WrS8L7yZZZzR3ueXI8w835CaM8xSneOVqT3Ay5xvDmXXhNPLOfunnA==
X-Received: by 2002:aca:3757:: with SMTP id e84mr3329812oia.5.1610651355767;
        Thu, 14 Jan 2021 11:09:15 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a52sm1255606otc.46.2021.01.14.11.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:09:14 -0800 (PST)
Received: (nullmailer pid 3389803 invoked by uid 1000);
        Thu, 14 Jan 2021 19:09:13 -0000
Date:   Thu, 14 Jan 2021 13:09:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 6/6] iio:pressure:ms5637: add ms5803 support
Message-ID: <20210114190913.GA3389746@robh.at.kernel.org>
References: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
 <20210109231148.1168104-7-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109231148.1168104-7-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Jan 2021 00:11:48 +0100, Alexandre Belloni wrote:
> The ms5803 is very similar to the ms5805 but has less resolution options
> and has the 128bit PROM layout.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  drivers/iio/pressure/ms5637.c                          | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
