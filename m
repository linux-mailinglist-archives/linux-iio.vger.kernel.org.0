Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE53EBDB2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhHMU5x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 16:57:53 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36765 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHMU5x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 16:57:53 -0400
Received: by mail-oi1-f169.google.com with SMTP id bd1so10311082oib.3;
        Fri, 13 Aug 2021 13:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRw29i8rZgtAQOOWjfxSeVfjrlJMzPgX8t5bNl0FQc4=;
        b=hRoXSmfsfdK7xpXZnyMusn4ZiJvrro3kFsRvOPY4m0iq78T2Ofh+nnKs6N9suMWXpM
         tbjE2DaRJMDvsoPrGTfR+0J8xFb15G09YV5h6p/MqN3XMNqW/qBQQZuL+lBoyefpy4dM
         exNe/+Tqlft9445h9Otylem95TtB/ViDQlzz4d6eOGMa8Na6Tqgum05o9TE5BlIyhuGF
         yhZUOEAx2rPR5SE+bHKjSQyuqKJp4Q7MPGVlTYNKUDb4w1rPAl8DtCO/kf+WzknTo2cK
         jchHEA4xv6v97XBSqrKbxePJluHB27NF+PUlHF/HaoqrM50qHYYoRe2LvHp6Zt8C2bQU
         0Yag==
X-Gm-Message-State: AOAM5301GLHMAV0XzycyNBAmHTHw0bL0MwIH5yiWj10FLFDTkk9pli7F
        S6CHbcmVOOxYCkTmoaCEGQ==
X-Google-Smtp-Source: ABdhPJy9HKW8pPlI9RBDXhXYvubQZueRg9WbqHK62nLq1LNsL5G+0pIOcso3FFcfwkxt3itU8Ljf5w==
X-Received: by 2002:aca:1911:: with SMTP id l17mr3728709oii.160.1628888245552;
        Fri, 13 Aug 2021 13:57:25 -0700 (PDT)
Received: from robh.at.kernel.org (2603-8080-2a06-ed00-a2a6-2d62-395f-9378.res6.spectrum.com. [2603:8080:2a06:ed00:a2a6:2d62:395f:9378])
        by smtp.gmail.com with ESMTPSA id w35sm525504ott.80.2021.08.13.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:57:25 -0700 (PDT)
Received: (nullmailer pid 4019742 invoked by uid 1000);
        Fri, 13 Aug 2021 20:57:23 -0000
Date:   Fri, 13 Aug 2021 15:57:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     linux-iio@vger.kernel.org, Dragos.Bogdan@analog.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Darius.Berghe@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: potentiometer: Add AD5110 in
 trivial-devices
Message-ID: <YRbcswAZuiLCFVz+@robh.at.kernel.org>
References: <20210809075745.160042-1-dmugil2000@gmail.com>
 <20210809075745.160042-2-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809075745.160042-2-dmugil2000@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 09 Aug 2021 13:27:19 +0530, Mugilraj Dhavachelvan wrote:
> Add AD5110, a Nonvolatile Digital Potentiometer into
> trivial-devices.yaml.
> 
> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
