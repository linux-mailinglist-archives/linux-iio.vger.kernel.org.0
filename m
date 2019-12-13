Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA611EB01
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfLMTKj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 14:10:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36909 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMTKj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 14:10:39 -0500
Received: by mail-oi1-f195.google.com with SMTP id x195so1675052oix.4;
        Fri, 13 Dec 2019 11:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqHrE4O7N3WyEVZBtjPW2RoMCJ5WebdfF8tzAO9VFB8=;
        b=WRbcQAWtC35i7HuDyaoJqOPkkRxEqfpqdELt5q9DDMgiHzR+w0BEjOihl5RXyW8H0o
         2pTkeVHUSgIaN2H+jsc2w/f+I735rwupoSHxIAnFWEVQjJ6/2f9a8rM2n9c3kRJHM0v6
         4pxq1DhrEe0GMyJhfEfn4i8RL7uhbb/1nx073QqIKwzhrAj5VNAIuEoDykZ/mTAXo2vp
         jrSlP5DZIplrjd5B2Gg5xizdbaxO2zZRCYhYiypML0V7Tg6gwMQQo8iugQjpRu37ZrNz
         Bd6pVX8Fb0KPFwkJfJEl1G2nARJAud9GN17M7w+RldO5IwfPT7GnJTJvcTVKw/iejk64
         0zHA==
X-Gm-Message-State: APjAAAWtk+HB9UbJIAhCeMPpBJYdJ6J1HTyV82wRkT/wsusuPysP8fSf
        SHFG65puYgGct12aOVHhzg==
X-Google-Smtp-Source: APXvYqxZJ6Djo9EHYC157I6r3XJQxg59UQRl0WouyQ2edATyQWi33Bg1WW4fHm5bv/3Ywm6ouP31Pw==
X-Received: by 2002:a54:4702:: with SMTP id k2mr6835867oik.168.1576264238139;
        Fri, 13 Dec 2019 11:10:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j130sm3596993oia.34.2019.12.13.11.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:10:37 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:10:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: iio: accel: add binding
 documentation for ADIS16240
Message-ID: <20191213191036.GA28558@bogus>
References: <20191207045339.9186-1-rodrigorsdc@gmail.com>
 <20191207045339.9186-2-rodrigorsdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207045339.9186-2-rodrigorsdc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Dec 2019 01:53:39 -0300, Rodrigo Carvalho wrote:
> This patch add device tree binding documentation for ADIS16240.
> 
> Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> ---
> V6:
>   - Update SPDX license identifier
> 
>  .../bindings/iio/accel/adi,adis16240.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
