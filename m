Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4101B3C601D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhGLQLK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 12:11:10 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:44709 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLQLK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 12:11:10 -0400
Received: by mail-il1-f173.google.com with SMTP id r16so13099145ilt.11;
        Mon, 12 Jul 2021 09:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbdMM5+I2wOnFMw1MRsQ7vzmJ17lkNCF/VeMonLyj18=;
        b=KVp8D17ZYClTZxeh51yXNu5Qp8sqsP5FEWcLvIIZEQw5Q0v1oM/g9Skv/tBn/AD+L2
         6s9ZpAZMw/f4YZ6LM3Mh/nK/JePqEVA7VJ56raUFIWIy68gpqusYJtg8xJdGdpMLYPdg
         0SR2n8NP7L6usFMAOoTUaddc6ZJC1gNaLy1ciz6ozJ6WzlSR74Y5cL51QALro2TeIo6s
         B15MEENqwsQ7Beq4UhVp2otgU06NW8NYf+uvzo91h/rjIY5UYiLoFQHutBHUzwYjbmWp
         Rs2Ylk2OV2N5qj/tOq8dJYGx1/iCmZPUs8PDN33rF2zl+0G5tD1w858U6CGgpjLT9GZB
         uUSw==
X-Gm-Message-State: AOAM5322GuF4bSkbkdrLhdUXmLtnMYzX6hEz/ejjyELj6dks+beB50Gl
        wpckKpm0mvZBA3+W7PGFdA==
X-Google-Smtp-Source: ABdhPJxRdZFhiaI20xiwp7QOOz9frS5ULoO+kDZjX27zvwfK/QuC7iimru0yIM21BzIFtY2X7miKJQ==
X-Received: by 2002:a05:6e02:12a8:: with SMTP id f8mr14436073ilr.82.1626106100785;
        Mon, 12 Jul 2021 09:08:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h11sm8400421ilc.1.2021.07.12.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:08:20 -0700 (PDT)
Received: (nullmailer pid 2028844 invoked by uid 1000);
        Mon, 12 Jul 2021 16:08:18 -0000
Date:   Mon, 12 Jul 2021 10:08:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, robh+dt@kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH v4 09/10] dt-bindings: iio: afe: add bindings for
 temperature-sense-rtd
Message-ID: <20210712160818.GA2028808@robh.at.kernel.org>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-10-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706160942.3181474-10-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 06 Jul 2021 12:09:41 -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one case, the measurement of a temperature through the
> voltage across an RTD resistor such as a PT1000.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
