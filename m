Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F36139DE7
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 01:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgANAQx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 19:16:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45547 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgANAQx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 19:16:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so10823297otp.12
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 16:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnCP/oi7Z0mxzEO5kxr1fVYeBOYXbt9IQu/uVhgHHc8=;
        b=lxci7UkQh5fnS81ZdJmF4YXt/7yqINB5wrDhwfEV2c0xukbUyerf6vWTKj8x1Rb0Gz
         sQah4DV0B+GnIYXhVxabIpmrxR8pSceEu3BtZQ1KypDczw/7taFvh17SDiW73UTdEDen
         Q1XkRnuvKBxBw/ZNA5cMTeZmMDR3PYh8sHtrTrbICwHxpq6y1jSqRYFhe8srAkL7Wubi
         MajEvzE/dBJTUSjzZU32vluVy6EYzSAbBLnokVqFORXhKnm/HCVuV/MHxdQgDxcgaz/7
         rnw3L2FJGUn0MJ8LxyfNir7umPjtoz9SZkr+SVU+5qfZ6X4vpzxCA+DJxeIfEqF/jkXF
         dIrQ==
X-Gm-Message-State: APjAAAW49AkeNKwlfNa126iJauH8TopgYiY9fvprHD2ay/BOOtoojFIz
        Hly0dWImFjfuxVb6zsLjlIxn8DP8/A==
X-Google-Smtp-Source: APXvYqwh0qXSv6nMMPPXlw9rrkCUloW3EasK546zJE6PvBf474xBIwTS3NdlysKdKbWa1JrttF2gHQ==
X-Received: by 2002:a9d:6849:: with SMTP id c9mr15693293oto.206.1578961011902;
        Mon, 13 Jan 2020 16:16:51 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm4793118otm.63.2020.01.13.16.16.50
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:16:51 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219cf
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:49 -0600
Date:   Mon, 13 Jan 2020 18:16:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 07/17] dt-bindings: atmel-matrix: add
 microchip,sam9x60-matrix
Message-ID: <20200114001649.GA11024@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-8-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-8-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:17:59 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-matrix to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-matrix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
